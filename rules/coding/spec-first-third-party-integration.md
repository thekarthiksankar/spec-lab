# Rule: Spec first principle for Third-Party API / SDK Integration 

Never trust training memory for any kind of interaction point with third-party SDK and API integration. Never proceed further unless you have the specification in hand — either provided by the user or found yourself.

Before writing any code that interacts with an external API or an SDK:

1. **Fetch the official API reference** for the specific endpoint or SDK method being implemented. Do not proceed without it — either the user provides it or you find it yourself.

2. **Never trust training memory for any interaction points with third-party API or SDK:**
   - Header names (e.g. `X-Api-Key` vs `x-api-key`)
   - Query / body parameter names
   - Endpoint URLs and paths
   - Response field names and shapes
   - Authentication schemes and token formats
   - Version strings (API version headers, SDK versions)
   - Deprecation status of any field or endpoint

3. **Review API boundary code against open docs** — not just by reading the generated code, but by comparing each detail line-by-line to the reference.
`