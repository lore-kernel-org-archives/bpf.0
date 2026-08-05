Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341813F88B9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969549; cv=none; b=XBSe50mm/WDoX0+8dezcKWh54p4wd9lpX2/eRT3lOHQd2DAwEJMPKCdc/k9PRXfqYSdIZp0W/7t3gF4TnTj9m/cRfZ82nep7y9NPqF0eZ8egnHXHAbAkf86FhpNh1ty8zHM7+bQM5juoX0xOkHlBwfn02IRL+cd7K5hQwTUNECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969549; c=relaxed/simple;
	bh=60DGgzjTHUSALfGhv2wLmMOZGRUaiDJYlKWplOTrJZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZOhZBOXIP1THTeZOIHImFEkVXjw4BFrSLug2VGhwcKhQEd0H3jPFMj4ffU66weutbNvfzL5Etv3l6X6J28gs+Z1Yf6i17guEQGjRoiqi1rm58TS6msSGHkRf0rmLa4Av4keRH8WM4LuoMgxoW6s09H6BJI0/0UUDAUWxOcGtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GszigWlw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GszigWlw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so982343a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785969547; x=1786574347; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=60DGgzjTHUSALfGhv2wLmMOZGRUaiDJYlKWplOTrJZc=;
        b=GszigWlwDJrffYYRGXeBmB8VPDfiwaoU952oWysi2ImNnFsZqqAWE/H+wOdy+8LJRb
         s11pOeyym2TR+HvY+7bDhNv69nZGj1cT2GE6upGXoxzsYCxrOqORDqXn10y1jwuxBCfK
         kj81Kje8MsNbh/LLWStOzlCkiy5bzO/LEu6mfgICTP9PibVsRCqeUmhmcAZJV7ZLBscc
         SKNXPP7rrw4ZMci3Fervbyib4ySQrMkA/NkGsPvA9tkOFFQTk3Tmhu6k9Bej1/yZ3Jer
         xpDINqzGz+7HoOCi7BDrM5LXDH5AsmuIuU9HpcjZpxhcAqepjNII7fmeURQ44Dt1MIQf
         lmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969547; x=1786574347;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60DGgzjTHUSALfGhv2wLmMOZGRUaiDJYlKWplOTrJZc=;
        b=WkGhchAstR31150qf8XIJLAl2hYSHpUQ8xgWotBdbs++QHmaJypRhxEr73xWX9khMc
         MkDcMNGQej3jWJRpOlhkgbz2OJHScg7R/CSZCL6dUcXsSjwh7IWS8Xhd+decRIuNB5G/
         5OzS5EfeL3f7Da+3C5t4pt0OV6fDH20tojHZEN+7LTSlyq8j7m17G3nv7hLTuxqlFS+h
         GS9Fym08VSB96cClE+LYse21tiE/SZWytuW9LMZ5B+HYbUnXPR7OUGeFYBLcQgJP9/bN
         XlujEQZ9PQ0gZN6KlSMxwngYkdt/xoHrHFMoYVeBceozE4QsOToFqXj+lwscgWBXo/MI
         Mu1w==
X-Forwarded-Encrypted: i=1; AHgh+RqxUoCw/DfmK37vVu2zY1mIZphDvalR+LEuj4rr3rN0m1p/PGFORJSqPU0SM2uvnbx8SyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2O0+7KUMqqJDKoylmfxllaX7lGiX3+6T74umFNky28yG+h1tH
	mgiGPdZmlQMAFW3lIAOLW4Bf1myOkFB6Fc6NQ26UQVDGihu8QiNBoFLX
X-Gm-Gg: AR+sD134TfEyNe6Yo6Zn1IcJ1LqxlbMmSvEEhtc96r58yx8yBZUlMQhZlYaihUnJeMq
	pfZD0DlLSmx8r+jHnfZaOR1o9Jv2rVp6InUS4JsVRtEEydL3+3PstQGEd0sgFw/yXTeo3KkGxxH
	ifgGb7JzIczc5vFKshbgH9M0OrBLSNEzzbwuunXsTtp0NQOylXEqNbKxYIogqeKzQO8UollW8Td
	s0IBBcH0OjoSJiHCtxYFwdAxNgd1I4+Mons88OEf1NcPXtDSipaLKcdhG4oq7MRDpzwwdFTJeeH
	7b0ihVfal+Q0TwJ8r4C5vHPOo2QJvnqcsuXAFPazjaGYqpn9Ws+pqS0DUSWIxZqLZZe3O3gGtfP
	5kYbSxFtVHmB7XuHGX60z2xNqjABGJW4TsTiyxBTEwOe1zIuoxLByrRm6OaI803NmGonEprAXYj
	Yv2H2Gg00hkE0g8qngo4aJjBOxS69gnC4EhIiYRUHGLw7P8wrSpOvL7C74tqrlrwbVl5jIHrP+j
	JZbJMTDBdnpbdU770tEE3cZdJWScAzEEudKFOiXEK8EoCRTmq24Gok=
X-Received: by 2002:a05:6a21:1f89:b0:3cb:8280:71f8 with SMTP id adf61e73a8af0-3cb85e6afffmr12470295637.18.1785969547426;
        Wed, 05 Aug 2026 15:39:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:969b:c0a:ff6f:454e? ([2620:10d:c090:500::5:b61b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc341sm31697881eec.27.2026.08.05.15.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:39:07 -0700 (PDT)
Message-ID: <25cea44482f4e8ca1d59116dff5b2b9b5948271c.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 6/8] selftests/bpf: extract BPF skeleton
 generation into a helper script
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 05 Aug 2026 15:39:04 -0700
In-Reply-To: <20260804170156.1709916-7-nickolay.lysenko@gmail.com>
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
	 <20260804170156.1709916-7-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVHVlLCAyMDI2LTA4LTA0IGF0IDEwOjAxIC0wNzAwLCBNeWtvbGEgTHlzZW5rbyB3cm90ZToK
PiBUaGUgZm91ciBza2VsZXRvbiBnZW5lcmF0aW9uIHJlY2lwZXMgKHJlZ3VsYXIsIGxpZ2h0LCBz
aWduZWQgbGlnaHQgYW5kCj4gbGlua2VkKSBhcmUgbmVhci1pZGVudGljYWwgZml2ZS1zdGVwIHBp
cGVsaW5lcyAtIGxpbmsgdmlhICJicGZ0b29sIGdlbgo+IG9iamVjdCIgdGhyZWUgdGltZXMsIGNv
bXBhcmUgdGhlIHNlY29uZCBhbmQgdGhpcmQgcmVzdWx0cyBhcyBhCj4gcmVncmVzc2lvbiB0ZXN0
IGZvciBicGZ0b29sJ3MgZGV0ZXJtaW5pc20sIGdlbmVyYXRlIHRoZSBza2VsZXRvbiAoYW5kCj4g
cG9zc2libHkgc3Vic2tlbGV0b24pLCByZW1vdmUgaW50ZXJtZWRpYXRlcyAtIGR1cGxpY2F0ZWQg
d2l0aCBzbWFsbAo+IHZhcmlhdGlvbnMgaW5zaWRlIERFRklORV9URVNUX1JVTk5FUl9SVUxFUywg
d2hlcmUgZXZlcnkgbGluZSBwYXlzIHRoZQo+IGRvdWJsZS1leHBhbnNpb24gZXNjYXBpbmcgdGF4
Lgo+IAo+IE1vdmUgdGhlIHBpcGVsaW5lIGludG8gZ2VuX2JwZl9za2VsLnNoOyB0aGUgZGlmZmVy
ZW5jZXMgYmV0d2VlbiB0aGUKPiBmb3VyIHZhcmlhbnRzIGJlY29tZSB0aGUgLS1sc2tlbCwgLS1z
aWduIGFuZCAtLXN1YnNrZWwgZmxhZ3MuIFNpZ25pbmcKPiB0YWtlcyB0aGUga2V5IGFuZCBjZXJ0
aWZpY2F0ZSBmcm9tICRQUklWQVRFX0tFWSBhbmQgJFZFUklGSUNBVElPTl9DRVJUCj4gaW4gdGhl
IGVudmlyb25tZW50LCBsaWtlIHRoZSBicGZ0b29sIGJpbmFyeSBjb21lcyBmcm9tICRCUEZUT09M
LiBUaGUKPiBkaXN0aW5jdCBsaW5rZWQvbGxpbmtlZCBpbnRlcm1lZGlhdGUgaW5maXhlcyBhcmUg
a2VwdCBidXQgZGVyaXZlZAo+IGluc2lkZSB0aGUgc2NyaXB0OiB0ZXN0cyBsaXN0ZWQgaW4gTFNL
RUxTX0VYVFJBIGdlbmVyYXRlIGJvdGggYQo+IC5za2VsLmggYW5kIGEgLmxza2VsLmggZnJvbSB0
aGUgc2FtZSAuYnBmLm8sIGFuZCBkaXN0aW5jdCBpbnRlcm1lZGlhdGUKPiBuYW1lcyBhcmUgd2hh
dCBrZWVwcyBwYXJhbGxlbCBidWlsZHMgZnJvbSByYWNpbmcuIEJ1aWxkLWxvZyBtZXNzYWdlcwo+
IHN0YXkgaW4gdGhlIHJlY2lwZXMgd2l0aCB0aGUgdXN1YWwgJChjYWxsIG1zZywuLi4pIGhlbHBl
cnM7IGJlaGF2aW9yCj4gaXMgdW5jaGFuZ2VkLgo+IAo+IFN1Z2dlc3RlZC1ieTogRWR1YXJkIFpp
bmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+Cj4gQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUt
ZmFibGUtNSBzaGVsbGNoZWNrCj4gU2lnbmVkLW9mZi1ieTogTXlrb2xhIEx5c2Vua28gPG5pY2tv
bGF5Lmx5c2Vua29AZ21haWwuY29tPgo+IC0tLQoKQWNrZWQtYnk6IEVkdWFyZCBaaW5nZXJtYW4g
PGVkZHl6ODdAZ21haWwuY29tPgoKSSBuZWVkIHRvIHByaW50IHRoaXMgb3V0IGFuZCBoYW5nIGl0
IGF0IG15IGRlc2suCgogIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
rOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKUgOKUgOKUgOKUkAogIOKUgiBleHByZXNz
aW9uIOKUgiAgICAgeCB1bnNldCAgICAg4pSCICAgICAgICAgICB4PSIiICAgICAgICAgICAg4pSC
IHg9diDilIIKICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilKQKICDilIIgJHt4LUR9ICAgICDi
lIIgRCAgICAgICAgICAgICAgIOKUgiBgYCAoZW1wdHkpICAgICAgICAgICAgICAgIOKUgiB2ICAg
4pSCCiAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSkCiAg4pSCICR7eDotRH0gICAg4pSCIEQg
ICAgICAgICAgICAgICDilIIgRCAgICAgICAgICAgICAgICAgICAgICAgICDilIIgdiAgIOKUggog
IOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUpAogIOKUgiAke3grQX0gICAgIOKUgiBgYCAgICAg
ICAgICAgICAg4pSCIEEgICAgICAgICAgICAgICAgICAgICAgICAg4pSCIEEgICDilIIKICDilJzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilLzilIDilIDilIDilIDilIDilKQKICDilIIgJHt4OitBfSAgICDilIIgYGAgICAgICAgICAg
ICAgIOKUgiBgYCAgICAgICAgICAgICAgICAgICAgICAgIOKUgiBBICAg4pSCCiAg4pSc4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS8
4pSA4pSA4pSA4pSA4pSA4pSkCiAg4pSCICR7eD1EfSAgICAg4pSCIEQgKGFuZCBhc3NpZ25zKSDi
lIIgYGAgKG5vIGFzc2lnbiDigJQgeCBpcyBzZXQpIOKUgiB2ICAg4pSCCiAg4pSc4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA
4pSA4pSA4pSA4pSA4pSkCiAg4pSCICR7eDo9RH0gICAg4pSCIEQgKGFuZCBhc3NpZ25zKSDilIIg
RCAoYW5kIGFzc2lnbnMpICAgICAgICAgICDilIIgdiAgIOKUggogIOKUnOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKU
gOKUgOKUgOKUpAogIOKUgiAke3g/bXNnfSAgIOKUgiBhYm9ydCAgICAgICAgICAg4pSCIGBgICAg
ICAgICAgICAgICAgICAgICAgICAg4pSCIHYgICDilIIKICDilJzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDi
lIDilKQKICDilIIgJHt4Oj9tc2d9ICDilIIgYWJvcnQgICAgICAgICAgIOKUgiBhYm9ydCAgICAg
ICAgICAgICAgICAgICAgIOKUgiB2ICAg4pSCCiAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSY
CgouLi4K

