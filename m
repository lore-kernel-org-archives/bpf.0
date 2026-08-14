Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F1472F66;
	Fri, 14 Aug 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714262; cv=none; b=QJDv7oHx2TSJ1m8hNUwigB7VY59wgYPeVn5qrcYxrysb1j77jHd8ehlCMwfg10qle/LQMo6gu/sCssnfmKKPSHAox7YVDAQ6eHbomRf8NqW/IH9++bXTrWWdy9SeOahNNyC11UfS9zCk/l8mZtcdHl5XjENPxrq4NK47zc3UhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714262; c=relaxed/simple;
	bh=pTgrWN2xLQMzK0REtG43WGoqhVN4y0jDl9hgnX8r8JM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QXRMxj1AF+5GGDBh1gCIQrGvtnseUexIUb8W+6K9GotTNwfdkoA74QfxOjmoML7G5Qs7llrHFmH6KT6kCtBT6Pz7YJMtrrj/21Fj+Qvs/cFo8GDQ3CPTbR2mZcPOA5RaFszSyrxyASCRQZhXAp1jnhbYm45Be2mDfv4VNDVD1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXZ62tkt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXZ62tkt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36F1F00A3A;
	Fri, 14 Aug 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786714261;
	bh=pTgrWN2xLQMzK0REtG43WGoqhVN4y0jDl9hgnX8r8JM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CXZ62tktXYcE831gfqBLIKV5huLJg+L7vKZ4nW6JL/ALbU3jSafJ1WK6ISNFeRbYw
	 KFlMhxEBXEwExPscyH8ATJ5jTkaOrJLOVQjpqH/iBaL7WoKuGsU7MCHsXsD1dYIjcw
	 Aub1tl3vZFZ+U7BzJX854V31Ubqd/xkeUdhbFaCc1HnPOc7geEZ9N7A4xZExtuvVxF
	 CDAO/7yis+bzaU4Gmz/kq0Qv6T2yKQwDuN6MEOFMg874Mh0qMuePaxUjfrbTgzZdD/
	 HMGEu0NjBDNP9JlfAyTiRNn56ogafjxti/kKrbINLWb1rv8H9BBpILvw2KjuNZmgXm
	 XVhOBRzV1/pkw==
Content-Type: multipart/mixed; boundary="===============5269789998203847462=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <89865ae4cc40dfaf576205ec16e2172b7680412259089d9ef19c3f838fd27b4f@mail.kernel.org>
In-Reply-To: <20260814124843.22041-5-i.tellez@btesa.com>
References: <20260814124843.22041-5-i.tellez@btesa.com>
Subject: Re: [PATCH v2 bpf 4/4] libbpf: Fix ring buffer consumer loop on 32-bit position wrap
From: bot+bpf-ci@kernel.org
To: i.tellez@btesa.com,andrii.nakryiko@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,billy@starlabs.sg,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,i.tellez@btesa.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 13:31:00 +0000 (UTC)

--===============5269789998203847462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBsaWJicGY6IEZpeCByaW5nIGJ1ZmZlciBjb25zdW1lciBsb29wIG9uIDMyLWJpdCBwb3NpdGlv
biB3cmFwCj4KPiByaW5nYnVmX3Byb2Nlc3NfcmluZygpIHdhbGtzIHRoZSByZWNvcmRzIGJldHdl
ZW4gdGhlIGNvbnN1bWVyIGFuZCB0aGUKPiBwcm9kdWNlciB3aXRoIGFuIG9yZGVyaW5nIGNvbXBh
cmlzb246Cj4KPiAJd2hpbGUgKGNvbnNfcG9zIDwgcHJvZF9wb3MpIHsKPgo+IGNvbnNfcG9zIGFu
ZCBwcm9kX3BvcyBtaXJyb3IgdGhlIGtlcm5lbCdzIHJpbmcgcG9zaXRpb25zIGFuZCBhcmUKPiB1
bnNpZ25lZCBsb25nIGhlcmUgdG9vLCBzbyBvbiAzMi1iaXQgdGhleSB3cmFwIGF0IDJeMzIgYnl0
ZXMgb2YgdHJhZmZpYy4KPiBXaGVuIHByb2R1Y2VyX3BvcyBoYXMgd3JhcHBlZCBhbmQgY29uc3Vt
ZXJfcG9zIGhhcyBub3QsIHByb2RfcG9zIGlzIHRoZQo+IHNtYWxsZXIgb2YgdGhlIHR3bywgdGhl
IGxvb3AgYm9keSBuZXZlciBydW5zIGFuZCBubyByZWNvcmQgaXMgY29uc3VtZWQuCj4gU2luY2Ug
Y29uc3VtZXJfcG9zIG9ubHkgYWR2YW5jZXMgaW5zaWRlIHRoYXQgbG9vcCwgaXQgbmV2ZXIgd3Jh
cHMgZWl0aGVyCj4gYW5kIHRoZSBjb25zdW1lciBzdG9wcyBkZWxpdmVyaW5nIHNhbXBsZXMgZm9y
IGdvb2QsIHdpdGggbm8gZXJyb3IKPiByZXR1cm5lZCB0byB0aGUgY2FsbGVyOiByaW5nX2J1ZmZl
cl9fcG9sbCgpIGtlZXBzIHJlcG9ydGluZyB6ZXJvCj4gcmVjb3JkcyB3aGlsZSB0aGUga2VybmVs
IHNpZGUgZmlsbHMgdXAgYW5kIHN0YXJ0cyBkcm9wcGluZy4KPgo+IENvbXBhcmUgdGhlIGRpc3Rh
bmNlIGluc3RlYWQuIFRoZSBjb25zdW1lciBuZXZlciBydW5zIGFoZWFkIG9mIHRoZQo+IHByb2R1
Y2VyLCBzbyBwcm9kX3BvcyAtIGNvbnNfcG9zIGlzIHRoZSBhbW91bnQgb2YgdW5jb25zdW1lZCBk
YXRhIGFuZAo+IHN0YXlzIGNvcnJlY3QgYWNyb3NzIHRoZSB3cmFwLgo+Cj4gNjQtYml0IGhvc3Rz
IGFyZSB1bmFmZmVjdGVkIGluIHByYWN0aWNlOiB0aGUgY291bnRlcnMgd291bGQgbmVlZCAxNiBF
aUIKPiB0byB3cmFwLiBUaGlzIGlzIHRoZSB1c2Vyc3BhY2UgY291bnRlcnBhcnQgb2YgdGhlIGtl
cm5lbC1zaWRlIHdhbGsgZml4ZWQKPiBpbiAiYnBmOiBGaXggcGVuZGluZ19wb3Mgd2FsayBvbiAz
Mi1iaXQgcmluZyBwb3NpdGlvbiB3cmFwIjsgYSAzMi1iaXQKPiBjb25zdW1lciBoaXRzIHdoaWNo
ZXZlciBvZiB0aGUgdHdvIGNvbWVzIGZpcnN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSXNyYWVsIFTD
qWxsZXogR2FyY8OtYSA8aS50ZWxsZXpAYnRlc2EuY29tPgoKVGhpcyBsb29rcyBsaWtlIGEgYnVn
IGZpeCBmb3IgcmluZyBidWZmZXIgc3VwcG9ydC4gU2hvdWxkIHRoaXMgaW5jbHVkZToKCiAgRml4
ZXM6IGJmOTljOTM2Zjk0NyAoImxpYmJwZjogQWRkIEJQRiByaW5nIGJ1ZmZlciBzdXBwb3J0IikK
ClRoZSBidWdneSBjb21wYXJpc29uICd3aGlsZSAoY29uc19wb3MgPCBwcm9kX3BvcyknIHdhcyBp
bnRyb2R1Y2VkIHdoZW4KcmluZyBidWZmZXIgc3VwcG9ydCB3YXMgZmlyc3QgYWRkZWQgdG8gbGli
YnBmLiBPbiAzMi1iaXQgc3lzdGVtcywgdGhpcwpjb21wYXJpc29uIGZhaWxzIHdoZW4gcHJvZHVj
ZXJfcG9zIHdyYXBzLCBjYXVzaW5nIHRoZSBjb25zdW1lciB0byBzdG9wCmRlbGl2ZXJpbmcgc2Ft
cGxlcyBwZXJtYW5lbnRseS4KCgotLS0KQUkgcmV2aWV3ZWQgeW91ciBwYXRjaC4gUGxlYXNlIGZp
eCB0aGUgYnVnIG9yIGVtYWlsIHJlcGx5IHdoeSBpdCdzIG5vdCBhIGJ1Zy4KU2VlOiBodHRwczov
L2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvdm10ZXN0L2Jsb2IvbWFzdGVyL2NpL2NsYXVkZS9S
RUFETUUubWQKCkNJIHJ1biBzdW1tYXJ5OiBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNo
ZXMvYnBmL2FjdGlvbnMvcnVucy8zMTgwMjgzNjk2NA==

--===============5269789998203847462==--
