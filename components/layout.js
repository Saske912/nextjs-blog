import Header from "./header";

const name = 'Pfile';
export const siteTitle = 'Next.js Sample Website';

export default function Layout({ children }) {
    return (
        <div className={"bg-gray-500"}>
            <Header></Header>
            <main>{children}</main>
            <footer className={"font-sans text-amber-200"}>by pfile</footer>
        </div>
    )
}