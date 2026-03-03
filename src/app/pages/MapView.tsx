import { useEffect, useRef, useState } from 'react';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
import { Card } from '../components/Card';
import { Input } from '../components/Input';
import { Button } from '../components/Button';
import { Navigation, Search, MapPin } from 'lucide-react';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

// Fix for default marker icon
delete (L.Icon.Default.prototype as any)._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-icon-2x.png',
  iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-icon.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
});

const locations = [
  { id: 1, name: 'Store Location 1', position: [37.7749, -122.4194] as [number, number], address: '123 Market St, San Francisco' },
  { id: 2, name: 'Store Location 2', position: [37.7849, -122.4094] as [number, number], address: '456 Mission St, San Francisco' },
  { id: 3, name: 'Store Location 3', position: [37.7649, -122.4294] as [number, number], address: '789 Howard St, San Francisco' },
];

function MapController({ center }: { center: [number, number] }) {
  const map = useMap();
  useEffect(() => {
    map.setView(center, 13);
  }, [center, map]);
  return null;
}

export const MapView = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedLocation, setSelectedLocation] = useState(locations[0]);
  const [userLocation, setUserLocation] = useState<[number, number] | null>(null);

  const getUserLocation = () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const coords: [number, number] = [position.coords.latitude, position.coords.longitude];
          setUserLocation(coords);
          setSelectedLocation({
            id: 0,
            name: 'Your Location',
            position: coords,
            address: 'Current Location',
          });
        },
        (error) => {
          console.error('Error getting location:', error);
        }
      );
    }
  };

  const filteredLocations = searchQuery
    ? locations.filter(loc =>
        loc.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        loc.address.toLowerCase().includes(searchQuery.toLowerCase())
      )
    : locations;

  return (
    <div className="flex flex-col h-screen">
      {/* Search Bar */}
      <div className="p-4 bg-card border-b border-border">
        <div className="max-w-md mx-auto space-y-3">
          <div className="relative">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
            <Input
              type="text"
              placeholder="Search locations..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-12"
            />
          </div>
          <Button
            variant="outline"
            className="w-full flex items-center justify-center gap-2"
            onClick={getUserLocation}
          >
            <Navigation className="w-4 h-4" />
            Use My Location
          </Button>
        </div>
      </div>

      {/* Map */}
      <div className="flex-1 relative">
        <MapContainer
          center={selectedLocation.position}
          zoom={13}
          style={{ height: '100%', width: '100%' }}
          zoomControl={false}
        >
          <TileLayer
            attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          />
          <MapController center={selectedLocation.position} />
          
          {filteredLocations.map((location) => (
            <Marker
              key={location.id}
              position={location.position}
              eventHandlers={{
                click: () => setSelectedLocation(location),
              }}
            >
              <Popup>
                <div className="p-2">
                  <h3 className="font-medium mb-1">{location.name}</h3>
                  <p className="text-sm text-muted-foreground">{location.address}</p>
                </div>
              </Popup>
            </Marker>
          ))}
          
          {userLocation && (
            <Marker position={userLocation}>
              <Popup>
                <div className="p-2">
                  <h3 className="font-medium">Your Location</h3>
                </div>
              </Popup>
            </Marker>
          )}
        </MapContainer>
      </div>

      {/* Location Details */}
      <div className="p-4 bg-card border-t border-border">
        <div className="max-w-md mx-auto">
          <Card>
            <div className="flex items-start gap-3">
              <div className="w-10 h-10 bg-primary/10 rounded-full flex items-center justify-center flex-shrink-0">
                <MapPin className="w-5 h-5 text-primary" />
              </div>
              <div className="flex-1">
                <h3 className="mb-1">{selectedLocation.name}</h3>
                <p className="text-sm text-muted-foreground mb-3">
                  {selectedLocation.address}
                </p>
                <div className="flex gap-2">
                  <Button variant="primary" size="sm" className="flex-1">
                    Get Directions
                  </Button>
                  <Button variant="outline" size="sm" className="flex-1">
                    Call
                  </Button>
                </div>
              </div>
            </div>
          </Card>
        </div>
      </div>
    </div>
  );
};
