Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4D1FC8
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780114379; cv=none; b=QDyRHkD3l2LO054Utsq2q/zDO7I4HOQbiSaqw3zPcZEZKyTD/QDeLuQOS9pjkt5PKFdV7ZfxE/Yck7+Ui4HgrRlQu/c1bxTU1hLlifYNi3FLf+Ysw7yE1FZhUSF1MFxOBZ7VDTOXrIb0ruObJVnmQs9Khw9maKzOWPGdlgjzJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780114379; c=relaxed/simple;
	bh=gJ2+EZAPI0Sx6PGLVWMK7o62qC1Hy8xswXPruahtFwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbiDw92iND+E4O999JPECEq2hGmDwaLisSEkcA8KuZlN9xpcYaaDjG1soYGxUJ68eVKS5Bn2DfSNXBEQoctfq8YFj2Xwr3V3o0tU0oXA+KJns8L+ou2NRSa2mSReKB0masPOr9h6mhu9CRlvQD3IKRBAGJhffxf9ZDZB99qhkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltX7AQMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltX7AQMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421751F00893;
	Sat, 30 May 2026 04:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780114377;
	bh=gJ2+EZAPI0Sx6PGLVWMK7o62qC1Hy8xswXPruahtFwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ltX7AQMZ8B8K2m+aqlHoQhv95lTG3YT2ZkMsIM3T+2lSLyBv3K3m9igwr03zn+kg2
	 3pfFk+NovLHqf9skB3ibjGAPPUKdiIzqJiGMeFinBTpGqsqeGdvZVr2WuGWleWOfdK
	 ApL2ACsaB2jWONxG3yu0jz1pnpp8/TiQ+JN9hdXDIX/weq8uBDP1B6aRUDu0p6LB6M
	 lM1HIQD7PugB5fzpiKQMNedvH0oYvJPVN//3KydsV9w4KT2/1U9aTZfyTR1rE6ag5r
	 oLNghM8FQ/80kRsH070bEGXevLVLSAyAu0ds9HUb9a0/dfl7t48QLBN/JtA3qyFQfW
	 YkFWCvbV3OiYg==
Message-ID: <7f62762d-fd91-4c07-9917-7d977441e17e@kernel.org>
Date: Sat, 30 May 2026 13:12:40 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 0/4] bpf,slab: Introduce bpf_arena_alloc()
 kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, david@kernel.org, tj@kernel.org,
 roman.gushchin@linux.dev, peterz@infradead.org, linux-mm@kvack.org,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YOgatyp4BDKWzraBvFYgBCBj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YOgatyp4BDKWzraBvFYgBCBj
Content-Type: multipart/mixed; boundary="------------AQ60e9pqNWOGDjhFSvs08E9C";
 protected-headers="v1"; hp="clear"
Message-ID: <7f62762d-fd91-4c07-9917-7d977441e17e@kernel.org>
Date: Sat, 30 May 2026 13:12:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 0/4] bpf,slab: Introduce bpf_arena_alloc()
 kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, david@kernel.org, tj@kernel.org,
 roman.gushchin@linux.dev, peterz@infradead.org, linux-mm@kvack.org,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260530011345.99342-1-alexei.starovoitov@gmail.com>

--------------AQ60e9pqNWOGDjhFSvs08E9C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

W1JlcGxhY2luZyBWbGFzdGltaWwncyBhbmQgbXkgb2xkIGVtYWlscyB3aXRoIG5ldyBvbmVz
LCBhbmQgQ2MnaW5nDQogICBIYW8gTGksIHdobydzIGEgbmV3IHJldmlld2VyIGluIHRoZSBz
bGFiIHN1YnN5c3RlbV0NCg0KQSBiaXQgb2YgYmFja2dyb3VuZCBmb3IgTU0gZm9sa3Mgd2hv
IG1heSBub3QgYmUgZmFtaWxpYXIgd2l0aCBCUEYgc3R1ZmYgDQooaW5jbHVkaW5nIG15c2Vs
ZiEpLiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJJ20gbWlzdW5kZXJzdGFuZGluZy4NCg0KQlBG
IGFyZW5hIFsxXSBpcyBhIDRHaUIgYXJlYSBzaGFyZWQgYmV0d2VlbiB1c2Vyc3BhY2UgYW5k
IEJQRiBwcm9ncmFtcy4gDQpUaGUgQlBGIGFyZW5hIGNhbiBiZSBzcGFyc2VseSBwb3B1bGF0
ZWQsIGFuZCB0aGVyZWZvcmUgdGhlIGtlcm5lbCBjYW5ub3QgDQphc3N1bWUgaXQgY2FuIHJl
bGlhYmx5IGFjY2VzcyBpdC4gKFRoZXJlIGlzIGEgcGF0Y2hzZXQgZnJvbSBUZWp1biB0aGF0
IA0KYWRkcmVzc2VzIHRoaXMgWzNdKS4NCg0KU2luY2UgQlBGIHByb2dyYW1zIGludGVyYWN0
IHdpdGggdGhlIGtlcm5lbCB0aHJvdWdoIGtmdW5jcyBhbmQgDQpzdHJ1Y3Rfb3BzIGNhbGxi
YWNrcywgaWRlYWxseSB0aGUga2VybmVsIHdhbnRzIHRvIHNoYXJlIGtlcm5lbCBvYmplY3Rz
IA0Kd2l0aCBCUEYgcHJvZ3JhbXM7IGhvd2V2ZXIsIHlvdSBjYW4ndCBwdXQga2VybmVsIHBv
aW50ZXJzIGRpcmVjdGx5IGluIA0KdGhlIGFyZW5hLCBhcyB0aGUgdmVyaWZpZXIgd29uJ3Qg
YWxsb3cgZGlyZWN0bHkgYWNjZXNzaW5nIHRoZW0gWzJdLiBTbyANCnRoZSBrZXJuZWwgaW5z
dGVhZCB3YW50cyB0byBhbGxvY2F0ZSBvYmplY3RzIGZyb20gdGhlIEJQRiBhcmVuYSBhbmQg
bGV0cyANCkJQRiBwcm9ncmFtcyBhY2Nlc3MgdGhlbSBkaXJlY3RseSBpbnN0ZWFkIG9mIGN1
cnJlbnQgd29ya2Fyb3VuZHMgDQptZW50aW9uZWQgaW4gWzJdIGFuZCBbM10uDQoNCnNjaGVk
LWV4dCBpcyBnb2luZyB0byB1c2UgYSBnZW5fcG9vbCBiYXNlZCBhbGxvY2F0b3IgWzNdIHRv
IGFjaGlldmUgDQp0aGF0LiBJdCB3b3JrcywgYnV0IHdlIG5lZWQgYSBtb3JlIGVmZmljaWVu
dCBhbGxvY2F0b3IgZm9yIEJQRiBhcmVuYXMgDQp3aXRob3V0IHJlLXdyaXRpbmcgdGhlIHNs
YWIgYWxsb2NhdG9yIGZyb20gc2NyYXRjaC4NCg0KVGhpcyBwYXRjaHNldCBhY2hpZXZlcyB0
aGF0IGJ5IGVuYWJsaW5nIFNMVUIgdG8gYWxsb2NhdGUgb2JqZWN0cyBmcm9tIA0KcGFnZXMg
dGhhdCBhcmUgbWFwcGVkIHRvIHRoZSBCUEYgYXJlbmEuIFNpbmNlIHRoZSBrZXJuZWwgY2Fu
bm90IGFjY2VzcyANCnRoZSBCUEYgYXJlbmEgZGlyZWN0bHkgKGF0IGxlYXN0IGZvciBub3cp
LCBTTFVCIGFsd2F5cyBhY2Nlc3NlcyBvYmplY3RzIA0KdmlhIHRoZSBkaXJlY3QgbWFwIHdo
aWxlIEJQRiBwcm9ncmFtcyBhY2Nlc3MgdGhlbSB2aWEgdGhlIHZtYWxsb2MgDQphZGRyZXNz
IHNwYWNlIChrZXJuX3ZtX3N0YXJ0KS4NCg0KR2l2ZW4gdGhhdCBCUEYgcHJvZ3JhbXMgY2Fu
IGFjY2VzcyBzbGFiIHBhZ2VzIGluIHRoZSBCUEYgYXJlbmEgDQoodXNlcnNwYWNlIHByb2dy
YW1zIGNhbid0LCBzZWUgYXJlbmFfdm1fZmF1bHQoKSksIG9uZSBpbnRlcmVzdGluZyBhc3Bl
Y3QgDQp3b3VsZCBiZSB0byBtYWtlIHN1cmUgdGhlIGtlcm5lbCBhdm9pZHMgcGFuaWNraW5n
IGFuZCBmYWxscyBiYWNrIA0KZ3JhY2VmdWxseSBpbiBjYXNlIG9mIGVycm9ycyBpbiB0aGUg
c2xhYiBwYWdlICh3aGlsZSBtYWludGFpbmluZyANCnJlYXNvbmFibGUgcGVyZm9ybWFuY2Us
IG9mIGNvdXJzZSkuDQoNClsxXSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTYxOTQxDQpb
Ml0gaHR0cHM6Ly9sd24ubmV0L0FydGljbGVzLzEwMTk4ODUNClszXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1tbS8yMDI2MDUyMDIzNTA1Mi40MTgwMzE2LTEtdGpAa2VybmVs
Lm9yZw0KDQpJJ2xsIGdldCB0byBpdCBhbmQgcmV2aWV3IHNvb24uDQoNClRoYW5rcy4NCg0K
LS0gDQpDaGVlcnMsDQpIYXJyeSAvIEh5ZW9uZ2dvbg0KDQpPbiA1LzMwLzI2IDEwOjEzIEFN
LCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+IEZyb206IEFsZXhlaSBTdGFyb3ZvaXRv
diA8YXN0QGtlcm5lbC5vcmc+DQo+IA0KPiB2MS0+djI6DQo+IC0gZGlzYWJsZSBrYXNhbiBm
b3Igc2xhYi1hcmVuYQ0KPiAgICBOb3RlLCBwYXRjaCAxIHJlbGllcyBvbiBwYXRjaCAzIGZv
ciBjb3JyZWN0bmVzcy4NCj4gICAgSSBkaWRuJ3Qgc3F1YXNoIHRoZW0sIHNpbmNlIGl0J3Mg
ZWFzaWVyIHRvIHJldmlldyB0aGlzIHdheS4NCj4gLSBmaXggaXNzdWVzIGZvdW5kIGJ5IHNh
c2hpa28NCj4gdjE6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDI2MDUyOTIw
MjQzOC4xNjQwOC0xLWFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20vDQo+IA0KPiBMZXQg
QlBGIHByb2dyYW1zIGFuZCBrZXJuZWwgYWxsb2NhdGUgb2JqZWN0cyBpbiBicGYgYXJlbmEg
dmlhDQo+IGt2bWFsbG9jLXN0eWxlIEFQSTogYnBmX2FyZW5hX2FsbG9jKCkga2Z1bmMuDQo+
IA0KPiBDdXJyZW50bHkgc2NoZWQtZXh0IEJQRiBwcm9ncmFtcyBpbXBsZW1lbnQgdmFyaW91
cyBhbGxvY2F0b3JzDQo+IGFzIEJQRiBwcm9ncmFtcyBvbiB0b3Agb2YgYnBmX2FyZW5hX2Fs
bG9jX3BhZ2VzKCkga2Z1bmMuDQo+IFRoaXMgaXMgaW5lZmZpY2llbnQuDQo+IA0KPiBSZWNl
bnRseSBzY2hlZC1leHQga2VybmVsIGNvcmUgaW50cm9kdWNlZCBzY3hfYXJlbmFfYWxsb2Mo
KSBiYWNrZWQNCj4gYnkgZ2VuX3Bvb2xfYWxsb2MoKSB0byBhbGxvY2F0ZSBhcmVuYSBtZW1v
cnkgdG9vLg0KPiBUaGlzIGlzIGFsc28gaW5lZmZpY2llbnQgYW5kIGdlbl9wb29sX2FsbG9j
KCkgaXMgbm90IGZhc3QgZW5vdWdoLg0KPiANCj4gSGVuY2UgYWRvcHQgc2hlYXZlcyBhbmQg
c2x1YiBhcyBhbGxvY2F0b3IuDQo+IFNlZSBwYXRjaCAzIGZvciBhbGdvcml0aG0gZGV0YWls
cy4NCj4gDQo+IEFsZXhlaSBTdGFyb3ZvaXRvdiAoNCk6DQo+ICAgIHNsYWI6IEludHJvZHVj
ZSBrbWVtX2NhY2hlX2FsbG9jX2FyZW5hX25vbG9jayBhbmQga2ZyZWVfYXJlbmFfbm9sb2Nr
DQo+ICAgIHNsdWI6IFBhc3Mga21lbV9jYWNoZSB0byBhbGxvY19zbGFiX3BhZ2UoKQ0KPiAg
ICBicGYsc2xhYjogQWRkIHNsdWItYmFja2VkIGFsbG9jYXRvciBmb3IgYnBmX2FyZW5hDQo+
ICAgIHNlbGZ0ZXN0cy9icGY6IEFkZCB0ZXN0cyBmb3IgYXJlbmEgc2x1Yi1iYWNrZWQgYWxs
b2NhdG9yDQo+IA0KPiAgIGluY2x1ZGUvbGludXgvYnBmX2RlZnMuaCAgICAgICAgICAgICAg
ICAgICAgICB8ICAxMyArDQo+ICAgaW5jbHVkZS9saW51eC9zbGFiLmggICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDI1ICsrDQo+ICAga2VybmVsL2JwZi9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4gICBrZXJuZWwvYnBmL2FyZW5hLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCA0MjUgKysrKysrKysrKysrKysrKystDQo+ICAg
bW0vc2xhYi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICst
DQo+ICAgbW0vc2xhYl9jb21tb24uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAyICstDQo+ICAgbW0vc2x1Yi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgMjY2ICsrKysrKysrKystDQo+ICAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0
cy9hcmVuYV9zbGFiLmMgICAgIHwgIDU5ICsrKw0KPiAgIC4uLi9wcm9nX3Rlc3RzL2FyZW5h
X3NsYWJfZnJlZXB0cl9zdGFsZV9wY3MuYyB8ICAyOCArKw0KPiAgIC4uLi90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvcHJvZ3MvYXJlbmFfc2xhYi5jICB8IDE3OSArKysrKysrKw0KPiAgIC4u
Li9icGYvcHJvZ3MvYXJlbmFfc2xhYl9mcmVlcHRyX3N0YWxlX3Bjcy5jICB8IDEyMCArKysr
Kw0KPiAgIDExIGZpbGVzIGNoYW5nZWQsIDEwODggaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRp
b25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL2FyZW5hX3NsYWIuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9hcmVuYV9zbGFiX2ZyZWVw
dHJfc3RhbGVfcGNzLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dzL2FyZW5hX3NsYWIuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvYXJlbmFfc2xhYl9mcmVlcHRy
X3N0YWxlX3Bjcy5jDQo+IA0KDQo=

--------------AQ60e9pqNWOGDjhFSvs08E9C--

--------------YOgatyp4BDKWzraBvFYgBCBj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEARYKADkWIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCahpjuBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwwLDMACgkQhlwTeq3OUtbHqAEAr+J/oR6rZ39dfikTiEo1
ucg13hc44kaKPwJW55DbiE8BALL0Z+VBQjT3buxlL9CZJShwvMEIN01zUj7ga1NT
fmgO
=H9v7
-----END PGP SIGNATURE-----

--------------YOgatyp4BDKWzraBvFYgBCBj--
