import Profile from '../components/profile'
import Spacer from  '../components/spacer'
import PersonalInfo from  '../components/personal-info'
import Notifications from '../components/notifications'
import StaticLayouts from '../components/stacked-layouts'

export default function profile() {
    return (
        <StaticLayouts>
            <Profile></Profile>
            <Spacer></Spacer>
            <PersonalInfo></PersonalInfo>
            <Spacer></Spacer>
            <Notifications></Notifications>
        </StaticLayouts>
    )
}