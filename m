Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8472877F6
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573778; cv=none; b=I4woKd2EKLwRl3Qio4H2iNY+QCVdlsiujOr7IUzEfFrk/TFlYNzVu6cqGgAm959NsT0Y9dqyFsAkdjHjkc8MPIi0IwAgv9hBDYlTkHM+dTBA6Vj6k80ySiKWBLHeaN2EuW9JIyVXent1KANewGfgN9Tm9YFEjrHeGKmVOq2GSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573778; c=relaxed/simple;
	bh=2N6C3ol2NdR6tSVyv7hdO+Z6Cgq6aGLskzxVJN43nQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRwPg+L1MHuZsZCBSLb+yyVvmwcrAySPm4ZA/a1mWhk3wZAQ+V1RYbzxgnqmSRApdathVgDC20v56RVvzoqxZEYuWBf5o/nkJy9V+/xh+ZKoWDPTo4KiLfZe9IYV08nBE3ZYJZc1Wnh+fOY0Nd85HlQnrmJYGk/vomPnRGxSgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWpOnbVm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWpOnbVm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso128609815ad.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573776; x=1785178576; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2N6C3ol2NdR6tSVyv7hdO+Z6Cgq6aGLskzxVJN43nQI=;
        b=PWpOnbVmw3HWtIPZaqgfUY8Mt2YtTCU46YP36qBvmGoB7NR4pYiE/OHwGqmuoiOPqB
         NuGgXzztSIreCAN8CtSRd25CFcuUema4DebrIV+IWH6/sUmYCxMXrqMwdmKVWcRYZxCh
         8p6udk3TumdV/WzxdhYRR2ANkxuqAgSyUbMFZnEDjiKbL0aBKPyhGmCpMD3n8PVdzhk2
         8uRLutAxd7GjSGn4OoqGYbPmULDw92GX/IHAXi3o970qnVWyX+MVvC9Nx54c4opacIKz
         yt/1S7Egb1UZ1NDeyPkr9bIHryMVRzipgI/A0iV8mHIjAPzlg30jLw24RUcWxiolz17T
         dgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573776; x=1785178576;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2N6C3ol2NdR6tSVyv7hdO+Z6Cgq6aGLskzxVJN43nQI=;
        b=hGPnoZmzXeeHXCJvaDvw0PNjsPWJOTvK+rJUYJUUZp5iCPXzYVeQtYIRMqqoflG2uM
         hk2QXeXw6yGsIk45L+pwmznXNbg73IiQfg42s/27vR9mO/yd03OzqnDHb8GxXmh5UeME
         pcdjGHd2rc2vGPjMehy2oz06c2iMMIcc9yz6hZWNkqgz5yUjgdt9TwMQ802tfBMcf6SF
         gHPU0KAd20ystvpveq8yH/+tjXCU5wyNpfccKzAuuO9SJjxap8yC2bD4aDdXq/5CCv07
         kHLy1XAkHQNLxq095WXGThhU2cN0pRVBDPkgQzBdYML05tyKpxiXXvAOmPkqrxwdv8Kb
         PREg==
X-Gm-Message-State: AOJu0YyDxo4RPi9cJ/+mBPR5GfRArvWw+mJNBkDyWqUwyO1QHccGjJa0
	AU7wjj2LNGaWMYVMkYavMcLdWNWp9MvcuvxKhGc8o0rPvwNOKcBH12RG2U38+Q==
X-Gm-Gg: AR+sD12sIlTou2KwNtWnsLvFPcj8A3Bvr+CG5Tv9JC0K5QEGQ2ZoyREffg9EQguPBdl
	Cj9YirNVrvcUXGarRPGl13hDYDS1fKODfd92Nv0zUTls5/Gs4M6eAXxX4rfwWtNmsfZiv9KbScJ
	Ehe8KCKBBQEfC1KZLBmagsn4uoJHTT53eNqlP6tiO3mO5sDV7SZjN4lTBB7WxEWht54RFW9yrId
	Ir2mQbPpGz60uXdmL0tjobmrHE4SwgCBTAbrIiZjxhQdh/b6dFCELR5z7ByQlEs7hexMzBmI/jL
	gCLzd0H392Rrl/hkT09qX9NLeUvSAOBcCipLFQIVu86a9uPzwoXgOIg1Nyp2FvSVDN5fZ39RjVI
	N5FN6wDc884XJdkysdEcBOJeW9IjWfP/HEuywb5vx+6KTE4MQZptlaO9NALSbasxr3Cw+Lbcpa/
	g1gtdwpAfkIiD3kJv9MrEhHYLXhyJzX5eyoub2jOQe
X-Received: by 2002:a17:903:3510:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2cf349ea184mr167457145ad.38.1784573776144;
        Mon, 20 Jul 2026 11:56:16 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm61231115ad.64.2026.07.20.11.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:56:15 -0700 (PDT)
Message-ID: <62e8903180a5caeafbd09cd8d2375bd06a755c54.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix compilation with
 RELEASE=1
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Viktor Malik
 <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis	 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Eric Biggers	 <ebiggers@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Date: Mon, 20 Jul 2026 11:56:13 -0700
In-Reply-To: <DK3JBMNLNYLD.2YDG311I01VWT@gmail.com>
References: <cover.1784112948.git.vmalik@redhat.com>
	 <CAP01T74To6X_XPeM5L9wN52QuL8oSuoDA3jk3jhR_Y1bLXH2Lw@mail.gmail.com>
	 <c49fbf3d-c1de-4eb3-a6b4-22c7bc84d655@redhat.com>
	 <DK3JBMNLNYLD.2YDG311I01VWT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI2LTA3LTIwIGF0IDE4OjIxICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVk
aSB3cm90ZToKPiBPbiBXZWQgSnVsIDE1LCAyMDI2IGF0IDM6MzAgUE0gQ0VTVCwgVmlrdG9yIE1h
bGlrIHdyb3RlOgo+ID4gT24gNy8xNS8yNiAxNDoxMCwgS3VtYXIgS2FydGlrZXlhIER3aXZlZGkg
d3JvdGU6Cj4gPiA+IE9uIFdlZCwgMTUgSnVsIDIwMjYgYXQgMTM6MjIsIFZpa3RvciBNYWxpayA8
dm1hbGlrQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IAo+ID4gPiA+IFdoZW4gY29tcGlsaW5n
IEJQRiBzZWxmdGVzdHMgd2l0aCBSRUxFQVNFPTEgKHdoaWNoIG1vc3Qgbm90YWJseSBhZGRzCj4g
PiA+ID4gLU8yKSwgR0NDIHJlcG9ydHMgc2V2ZXJhbCB3YXJuaW5ncy4gVGhlc2UgYXJlIGJ5IGRl
ZmF1bHQgdHJlYXRlZCBhcwo+ID4gPiA+IGVycm9ycyBhbmQgYWJvcnQgdGhlIGNvbXBpbGF0aW9u
Lgo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgc2VyaWVzIGZpeGVzIGFsbCBvZiB0aGUgaXNzdWVzIHN1
Y2ggdGhhdCBzZWxmdGVzdHMgY2FuIGJlIGNvbXBpbGVkCj4gPiA+ID4gd2l0aCBSRUxFQVNFPTEu
Cj4gPiA+ID4gCj4gPiA+IAo+ID4gPiBBcmUgdGhlc2UgY2hhbmdlcyBzdWZmaWNpZW50IHRvIGZp
eCBhbGwgaXNzdWVzPyBJIHNlZSBtb3JlIHdoZW4gSQo+ID4gPiBjb21waWxlIHdpdGggR0NDIDE1
IGFuZCBSRUxFQVNFPTEuCj4gPiAKPiA+IFN0cmFuZ2UsIEkgdHJpZWQgY29tcGlsaW5nIHdpdGgg
Ym90aCBHQ0MgMTUgYW5kIDE2IGFuZCB0aGVzZSBmb3VyCj4gPiBwYXRjaGVzIGdvdCByaWQgb2Yg
YWxsIHRoZSBpc3N1ZXMuIENhbiB5b3Ugc2VuZCB0aGUgc3BlY2lmaWMgaXNzdWVzIHRoYXQKPiA+
IHlvdSBzZWU/Cj4gPiAKPiAKPiDCoCBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRl
L2ZlYXR1cmVzLmg6NTM5LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
cm9tIC91c3IvaW5jbHVkZS9hcnBhL2luZXQuaDoyMSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZnJvbSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvbWFwX3Rlc3Rz
L2xwbV90cmllX21hcF9iYXRjaF9vcHMuYzozOgo+IMKgIEluIGZ1bmN0aW9uIOKAmGluZXRfbnRv
cOKAmSwKPiDCoMKgwqDCoMKgIGlubGluZWQgZnJvbSDigJhtYXBfYmF0Y2hfdmVyaWZ5LmNvbnN0
cHJvcOKAmSBhdCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvbWFwX3Rlc3RzL2xwbV90cmll
X21hcF9iYXRjaF9vcHMuYzo1MzozOgo+IMKgIC91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251
L2JpdHMvaW5ldC1mb3J0aWZpZWQuaDozNjoxMDogZXJyb3I6IGNhbGwgdG8g4oCYX19pbmV0X250
b3BfY2hrX3dhcm7igJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgd2FybmluZzogaW5ldF9udG9w
IGNhbGxlZCB3aXRoCj4gwqAgYmlnZ2VyIGxlbmd0aCB0aGFuIHNpemUgb2YgZGVzdGluYXRpb24g
YnVmZmVyIFstV2Vycm9yPWF0dHJpYnV0ZS13YXJuaW5nXQo+IMKgwqDCoMKgIDM2IHzCoMKgIHJl
dHVybiBfX2dsaWJjX2ZvcnRpZnkgKGluZXRfbnRvcCwgX19kc3Rfc2l6ZSwgc2l6ZW9mIChjaGFy
KSwKPiDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgIF5+fn5+fn5+fn5+fn5+fgo+
IAo+IMKgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvZmNudGwuaDozNDIsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvY2dyb3VwX3hhdHRyLmM6NToKPiDCoCBJbiBmdW5jdGlv
biDigJhvcGVu4oCZLAo+IMKgwqDCoMKgwqAgaW5saW5lZCBmcm9tIOKAmHRlc3RfcmVhZF9jZ3Jv
dXBfeGF0dHLigJkgYXQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvY2dy
b3VwX3hhdHRyLmM6NTI6MTEsCj4gwqDCoMKgwqDCoCBpbmxpbmVkIGZyb20g4oCYdGVzdF9jZ3Jv
dXBfeGF0dHLigJkgYXQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvY2dy
b3VwX3hhdHRyLmM6NzE6MzoKPiDCoCAvdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9iaXRz
L2ZjbnRsMi5oOjUyOjExOiBlcnJvcjogY2FsbCB0byDigJhfX29wZW5fbWlzc2luZ19tb2Rl4oCZ
IGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBvcGVuIHdpdGggT19DUkVBVCBvciBPX1RN
UEZJTEUgaW4KPiDCoCBzZWNvbmQgYXJndW1lbnQgbmVlZHMgMyBhcmd1bWVudHMKPiDCoMKgwqDC
oCA1MiB8wqDCoMKgwqDCoMKgwqDCoMKgwqAgX19vcGVuX21pc3NpbmdfbW9kZSAoKTsKPiDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+
IAo+IFRoYXQgc2FpZCwgaXQgYWxzbyBmaXhlcyB0aGUgb25lcyB5b3UgcG9pbnRlZCBvdXQsIHNv
IHdlIGNhbiBwcm9iYWJseSBsYW5kIHRoaXMuCj4gCj4gPiA+IEFsc28sIGlzIHRoZXJlIG5vIHdh
eSB0byBtYWtlIEFTU0VSVF9PS19QVFIgd29yayB3aGVuIHdlJ3JlIHRlc3RpbmcKPiA+ID4gZm9y
IG5vbi1OVUxMLW5lc3M/IEhhdmluZyB0byBjaGFuZ2UgaXQgdG8gZXhwbGljaXQgIT0gTlVMTCBp
cyBraW5kYQo+ID4gPiBzYWQuCj4gPiAKPiA+IEFTU0VSVF9PS19QVFIgdXNlcyBsaWJicGZfZ2V0
X2Vycm9yKCksIHdoaWNoIHJldHVybnMgLWVycm5vIHdoZW4gdGhlCj4gPiBwYXNzZWQgcG9pbnRl
ciBpcyBOVUxMLiBUaGlzIGlzIGNvcnJlY3QgZm9yIGNoZWNraW5nIHBvaW50ZXJzIHJldHVybmVk
Cj4gPiBmcm9tIGxpYmJwZiBiZWNhdXNlIGxpYmJwZiBhbHdheXMgc2V0cyBlcnJubyB3aGVuIGl0
IHJldHVybnMgTlVMTCBhcyBhbgo+ID4gZXJyb25lb3VzIHZhbHVlIG9mIGEgcG9pbnRlci4gSG93
ZXZlciwgdGhhdCBpcyBub3QgdGhlIGNhc2UgZm9yIG90aGVyCj4gPiBsaWJyYXJ5IGZ1bmN0aW9u
cywgc3VjaCBhcyBtYWxsb2MoKSwgc28gY2FsbGluZyBsaWJicGZfZ2V0X2Vycm9yKCkgb24KPiA+
IHRoZWlyIHJlc3VsdCBtYXkgYWN0dWFsbHkgcmV0dXJuIDAsIGlmIHRoZSBmdW5jdGlvbiByZXR1
cm5lZCBOVUxMIGFuZAo+ID4gbmV2ZXIgc2V0IGVycm5vLgo+ID4gCj4gPiBTbywgSSdkIHNheSB0
aGF0IGluIHRoZSBjdXJyZW50IHN0YXRlLCByZXN1bHRzIG9mIG5vbi1saWJicGYKPiA+IHB0ci1y
ZXR1cm5pbmcgZnVuY3Rpb25zIHNob3VsZCBiZSBjaGVja2VkIHdpdGggQVNTRVJUX05FUS4KPiA+
IEFsdGVybmF0aXZlbHksIHdlIGNhbiB1cGRhdGUgQVNTRVJUX09LX1BUUiB0byBleHBsaWNpdGx5
IGZhaWwgd2l0aCBhCj4gPiBkZWZhdWx0IGVycm9yIGNvZGUgd2hlbiBOVUxMIGlzIHBhc3NlZCwg
Zm9yIGV4YW1wbGU6Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvdGVzdF9wcm9ncy5oIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Rlc3RfcHJv
Z3MuaAo+ID4gaW5kZXggMmNmOTUwYWZjZDg1Li5iZjk0YjA5NDc3OTAgMTAwNjQ0Cj4gPiAtLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9wcm9ncy5oCj4gPiArKysgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9wcm9ncy5oCj4gPiBAQCAtMzkwLDcgKzM5MCw3
IEBAIHZvaWQgaGV4ZHVtcChjb25zdCBjaGFyICpwcmVmaXgsIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6
ZV90IGxlbik7Cj4gPiDCoCNkZWZpbmUgQVNTRVJUX09LX1BUUihwdHIsIG5hbWUpICh7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBcCj4gPiDCoMKgwqDCoMKgwqDCoCBzdGF0aWMgaW50IGR1cmF0aW9uID0gMDvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqX19fcmVz
ID0gKHB0cik7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IC3CoMKgwqDCoMKgwqAgaW50IF9fX2VyciA9
IGxpYmJwZl9nZXRfZXJyb3IoX19fcmVzKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgIGludCBfX19lcnIgPSBfX19y
ZXMgPyBsaWJicGZfZ2V0X2Vycm9yKF9fX3JlcykgOiAtRUlOVkFMO8KgwqDCoMKgwqDCoCBcCj4g
PiDCoMKgwqDCoMKgwqDCoCBib29sIF9fX29rID0gX19fZXJyID09IDA7wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcCj4gPiDCoMKgwqDCoMKgwqDCoCBDSEVDSyghX19fb2ssIChuYW1lKSwgInVuZXhwZWN0
ZWQgZXJyb3I6ICVkXG4iLCBfX19lcnIpO8KgwqDCoMKgwqDCoMKgIFwKPiA+IMKgwqDCoMKgwqDC
oMKgIF9fX29rO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBcCj4gPiAKPiA+IEhvd2V2ZXIsIHRoYXQgd291bGQgbWFrZSB1cyBsb3NlIHRo
ZSBlcnJvciBjb2RlcyBwYXNzZWQgdmlhIGVycm5vIGZyb20KPiA+IGxpYmJwZi4KPiAKPiBIbW0s
IEkgc2VlLiBJIGd1ZXNzIHdlIGNhbiBsZXQgaXQgYmUgdGhlbi4gRWR1YXJkLCBhbnkgc3VnZ2Vz
dGlvbnMgb3IKPiBwcmVmZXJlbmNlcyBoZXJlPwoKVGhlIGNoYW5nZSB0byBBU1NFUlRfT0tfUFRS
IGxvZ2ljIHNlZW0gcmVhc29uYWJsZSwgYSBzaW5nbGUgdGVzdCBydW4Kc2hvdWxkIHNob3cgd2hl
dGhlciB0aGVyZSBhcmUgcGxhY2VzIHRoYXQgbGVnaXRpbWF0ZWx5IGV4cGVjdCBOVUxMIHRvCnBh
c3MgdGhlIGNoZWNrLCBzdWNoIHBsYWNlcyBjYW4gYmUgdXBkYXRlZC4KCj4gT3RoZXJ3aXNlIEkg
YW0gaW5jbGluZWQgdG8gYXBwbHkgdGhpcyBmb3Igbm93LgoKSSB0aGluayBpdCdzIGZpbmUgdG8g
YXBwbHkgdGhpcyBwYXRjaCBhcy1pcy4K

