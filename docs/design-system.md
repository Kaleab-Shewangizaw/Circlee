# Circlee Design System

## Brand Feel

Circlee should feel like a place that is already alive when the user arrives. The interface needs emotional warmth without visual clutter.

## Design Tokens

### Color

```text
bg.base        #08111B
bg.elevated    #0D1826
surface.card   #122033
surface.glass  rgba(18, 32, 51, 0.72)
stroke.soft    rgba(255, 255, 255, 0.08)
text.primary   #F4F7FB
text.secondary #A6B2C5
text.tertiary  #74839B
accent.cyan    #68E1FD
accent.mint    #32D0A8
accent.coral   #FF8B66
accent.gold    #F4C56A
status.success #49D17D
status.warn    #FFB457
status.error   #FF6D7A
```

### Gradient System

- hero gradient: `#0B1524 -> #103148 -> #15596D`
- live gradient: `#18324A -> #175969 -> #32D0A8`
- event gradient: `#2D2338 -> #573A44 -> #FF8B66`

### Typography

- display: `Sora`
- body: `Manrope`
- monospace/meta: `IBM Plex Mono`

### Sizing

```text
space: 4, 8, 12, 16, 20, 24, 32, 40
radius: 12, 18, 24, 32
icon: 16, 20, 24, 28
touch: 44 minimum
```

## Motion System

### Durations

- micro: 120ms
- standard: 220ms
- scene: 360ms

### Curves

- spring enter: medium bouncy, low overshoot
- emphasis: quick ease-out for tap responses
- shared element: preserve visual continuity on circle/event transitions

### Motion Rules

- use staggered entry for discovery cards and onboarding choices
- use live pulse only on meaningful active states
- avoid continuous background motion except on live or voice surfaces

## Navigation

### Primary Shell

- `Home`
- `Discover`
- `Inbox`
- `You`

### Home Composition

- hero strip: live now, people online, today's plans
- your circles carousel
- recommended circles
- upcoming events
- community memories

### Discover Composition

- segmented control: `People`, `Circles`, `Events`, `Campus`
- animated query bar
- filter chips for vibe, distance, intent, schedule

## Key Screen Blueprints

### Onboarding

1. emotional intro with "Find your people"
2. choose goals and interests
3. choose social energy and preferred interaction styles
4. campus/city + availability windows
5. seed recommended circles and first event ideas

### Circle Page

- circle hero with presence rings and next event
- segmented content: `Feed`, `Chat`, `Plans`, `People`
- pinned highlights and streak card
- quick action rail for invite, voice room, create event

### Event Page

- immersive cover media
- who is going row
- agenda, chat, and planning checklist
- sticky RSVP and share CTA

### Chat

- dense, high-speed message list
- soft contrast bubbles
- inline replies, reactions, read tails
- composer with quick media, voice note, and event attach actions

### Live Room

- stage block with speakers
- audience grid with activity glow
- reaction lane
- moderator action sheet

## Component Library

- `CPrimaryButton`
- `CGlassCard`
- `CLivePill`
- `CSectionHeader`
- `CAvatarStack`
- `CInterestChip`
- `CCircleCard`
- `CEventCard`
- `CMessageBubble`
- `CPresenceRing`
- `CBottomActionSheet`

## UX Principles

- every major screen should show who is active now
- discovery should feel guided, not infinite
- creation flows should be short and reversible
- every social action should reduce ambiguity about what happens next
