Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45B27380A
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770872803; cv=none; b=hU3iUMy0VZU3XdYakOcZcHukLXp8Ew/ONGXT+WNLJaMvZZ+0UtqtW1BJU6Bl3lF446DwHayNXOVFxfG6yTaSNklqvebvxz1aV1CbdcdVTatiNvaVWNk65h0JAchsvb0Qo56X9iMc0tphNgEj3LNyJ+dBoARExeFwmK7UePgq6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770872803; c=relaxed/simple;
	bh=hUf+eh5aMZWHsXluUZwgnTBPuhRUlWwzE4sALaR7AyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRhEo3YYTZs1a9PmjpXgb1K0b1U8V/S9rSz1md8UwhoCXkIFXIIFRPwLq/4w2NOvmsmeA2I5LFSwvKRiPj2vWQFFEkZuVk/j3kjq0iyajGgyfWD1bKkEWevBpe+Oyt0L0WN8I/8Whu9mzo1KWjqB1QZECYQ7uM93i+6rgAeH218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpMFu5Kr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpMFu5Kr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so3009705a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770872802; x=1771477602; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hUf+eh5aMZWHsXluUZwgnTBPuhRUlWwzE4sALaR7AyE=;
        b=lpMFu5Krs8pafNgPrVnG/7A+D9MH+Y+Q5uFZo1/8m/3BS3Y0poY3QePRX1+PNkYYZF
         N+ocTgMOcpKgoXl6onjXI8dEJgfqRD1f8McR4TXBb6RYDSY92tqBpX3mX5RucRg2n8ok
         zKZRQnnWQpkQaL2mWIOKrsOxpIdaPylYWqDEN2zwOGUizJfDa7jkbM263rt2MwrJN6cU
         UDILOiXnjFtxYUYKIgry2CsgUEx6IpLN+0ZX9v7YGtw27N75uBsZLAEkuQRcBAOPm0P2
         snLjB5iurqXx8RRfFhjPhbZASpWZknsawJzpEzb2v6iTcDpZZZd1FNStPxVn3zE5Pa28
         DW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770872802; x=1771477602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUf+eh5aMZWHsXluUZwgnTBPuhRUlWwzE4sALaR7AyE=;
        b=FvFWYBSfGxuA+y3QjRb0eExu5DrST7T2cNj7NvhENQB9wwzsTvMwmWaBR7yBbJK6en
         1X/NbcBXjdAJ9uA0kKqDJkRsKBH2GY9Gso+ecydaSPbJ8MltG5xidjThHCCgZhTShjfu
         aFwurk7NgJ/55XB+uGRci8Zb+GjJXpi2UO+V5ubHznQ8EafqYbW677gYu/fDIT8bcjcD
         VoaN974I7WaIk9MeojUUx/hZNun/k+hzruvvdddmTed5+J7gF3oFVZ+Zu1ZbtobeqYJy
         1ADKOttAqTF2J1txOlxZzjh7aYm1I9ovkYtTCpfsfloDoUOCNN/jjWT+CtncelcGzghH
         RfrA==
X-Gm-Message-State: AOJu0Yy+uHFx+3q41uyB9MgqUBy6EgcxwV5eZcd1suhdaQ5dHDzVdYUU
	MKqMFHv4S/mAjtawMp7Utgz9u1XsN3NJmTbeuLFfSindwgv2t5Mc/Z8hSIRuS4Ve
X-Gm-Gg: AZuq6aLl9hVFnVlI+LaPDPu1hrNIKFT6JtQB3rcuwYgtp22i1mo7VgPiLs7SpDEyf47
	ka/XZP7EtwYgH9wDI5kSCw1SHja9e2OR20/2NAIn83NUzmv2WS5Q3QVpe0qg+IMUFFIzIHnxycR
	yVRkUJvDon7qIvkgUcGpmF+YC3dSec69n/bGGdS5/N23nYtZpV0OPMQtCaUVdxkfNTaSpFGpxc9
	CQ34OMLGMi9T/KUOo1p+0TFSx3x8I/kOQFkAdL0aEUpWYURuj4JBVjKmnnDLjwjx/p/CvsFWtV4
	IGVFxnienuafY0Efhg4guAL6Pp1kBqZMGgB2N+tQWskDp6tMT8aUeHXkO5dKV1dALirORLUsyla
	HZIWGDlGSN2KSjyYf/eAXF6YlBLw0kddwt8cCNgMcrWU3z2ldscCswyAWTciDbVSBl5W+yzfSoj
	RoInKIhnPO43vdy/tEp+SuFMsJgOaaQWLVI7MA1/447DQojfPDpXg=
X-Received: by 2002:a17:90b:3cc5:b0:353:38c8:b612 with SMTP id 98e67ed59e1d1-3568f302f98mr1833830a91.12.1770872801964;
        Wed, 11 Feb 2026 21:06:41 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567aeb1643sm2373312a91.1.2026.02.11.21.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 21:06:41 -0800 (PST)
Message-ID: <704f1950a3ab0a941fe673930086afeae0d6147d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: use reg->var_off instead of reg->off
 for pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Wed, 11 Feb 2026 21:06:38 -0800
In-Reply-To: <CAADnVQLZh4Bk++vEW97mL0mMCUJu075vQFS2Kkhf9zXP5b2zLw@mail.gmail.com>
References: <20260211-ptrs-off-migration-v1-0-996c2a37b063@gmail.com>
	 <20260211-ptrs-off-migration-v1-2-996c2a37b063@gmail.com>
	 <CAADnVQLZh4Bk++vEW97mL0mMCUJu075vQFS2Kkhf9zXP5b2zLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI2LTAyLTExIGF0IDE4OjIzIC0wODAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gT24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgMjozMuKAr1BNIEVkdWFyZCBaaW5nZXJtYW4g
PGVkZHl6ODdAZ21haWwuY29tPiB3cm90ZToKPiA+IAo+ID4gLSBJbiBtYXJrX3B0cl9vcl9udWxs
X3JlZygpIFdBUk5fT05fT05DRSgpIGNoZWNrcyB3ZXJlIHJlbW92ZWQKPiA+IMKgIGJlY2F1c2Ug
aW4gc29tZSBjYXNlcyBoZWxwZXJzIHRoYXQgcmV0dXJuIGxvY2FsIGtwdHJzIGNhbiBub3cKPiA+
IMKgIHJldHVybiBwb2ludGVycyB3aXRoIG5vbi16ZXJvICcudmFyX29mZicgKGUuZy4sIGEgcG9p
bnRlciB0bwo+ID4gwqAgYSBzcGluIGxvY2sgaW5zaWRlIGEgbWFwIGVudHJ5KS4KPiAKPiAuLi4K
PiAKPiA+IEBAIC0xNzEyOSwyOSArMTcwNzQsMTMgQEAgc3RhdGljIHZvaWQgbWFya19wdHJfb3Jf
bnVsbF9yZWcoc3RydWN0IGJwZl9mdW5jX3N0YXRlICpzdGF0ZSwKPiA+IMKgewo+ID4gwqDCoMKg
wqDCoMKgwqAgaWYgKHR5cGVfbWF5X2JlX251bGwocmVnLT50eXBlKSAmJiByZWctPmlkID09IGlk
ICYmCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpc19yY3VfcmVnKHJlZykgfHwgIVdBUk5f
T05fT05DRSghcmVnLT5pZCkpKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBPbGQgb2Zmc2V0IChib3RoIGZpeGVkIGFuZCB2YXJpYWJsZSBwYXJ0cykgc2hvdWxkIGhhdmUg
YmVlbgo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGtub3duLXplcm8sIGJl
Y2F1c2Ugd2UgZG9uJ3QgYWxsb3cgcG9pbnRlciBhcml0aG1ldGljIG9uCj4gPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcG9pbnRlcnMgdGhhdCBtaWdodCBiZSBOVUxMLiBJZiB3
ZSBzZWUgdGhpcyBoYXBwZW5pbmcsIGRvbid0Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogY29udmVydCB0aGUgcmVnaXN0ZXIuCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICoKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBCdXQgaW4g
c29tZSBjYXNlcywgc29tZSBoZWxwZXJzIHRoYXQgcmV0dXJuIGxvY2FsIGtwdHJzCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYWR2YW5jZSBvZmZzZXQgZm9yIHRoZSByZXR1
cm5lZCBwb2ludGVyLiBJbiB0aG9zZSBjYXNlcywgaXQKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBpcyBmaW5lIHRvIGV4cGVjdCB0byBzZWUgcmVnLT5vZmYuCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKHJlZy0+c21pbl92YWx1ZSB8fCByZWctPnNtYXhfdmFs
dWUgfHwgIXRudW1fZXF1YWxzX2NvbnN0KHJlZy0KPiA+ID52YXJfb2ZmLCAwKSkpCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEodHlwZV9pc19wdHJfYWxsb2Nfb2JqKHJl
Zy0+dHlwZSkgfHwgdHlwZV9pc19ub25fb3duaW5nX3JlZihyZWctPnR5cGUpKSAmJgo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBXQVJOX09OX09OQ0UocmVnLT5vZmYp
KQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
bjsKPiA+IC0KPiAKPiBUaGlzIHBhcnQgbG9va3Mgb3Zlcmx5IGFnZ3Jlc3NpdmUgdG8gbWUuCj4g
SSBkb24ndCByZW1lbWJlciBzZWVpbmcgdGhlc2Ugd2FybnMsIHNvIGFueSBrbm93biBjb2RlIG9y
IHN5emJvdAo+IGlzIG5vdCB0cmlnZ2VyaW5nIGl0LCBidXQgY2FuIHdlIGtlZXAgdGhlbT8KPiBU
aGUgZmlyc3Qgd2FybiBjYW4gc3RheSBhcy1pcywgbm8/Cj4gQW5kIHRoZSAybmQgY2FuIGJlIGNv
bnZlcnRlZCB0byB0bnVtX2VxdWFsc19jb25zdCgpIHRvbyA/CgpJIHRoaW5rIGl0IGNhbiBiZSBw
cmVzZXJ2ZWQgYXMgb25lIHdhcm5pbmc6CgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
ICghKHR5cGVfaXNfcHRyX2FsbG9jX29iaihyZWctPnR5cGUpIHx8IHR5cGVfaXNfbm9uX293bmlu
Z19yZWYocmVnLT50eXBlKSkgJiYKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFdBUk5fT05fT05DRSghdG51bV9lcXVhbHNfY29uc3QocmVnLT52YXJfb2ZmLCAwKSkpCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKCkknbGwgYWRk
IHRoaXMgaW4gdjIuCg==

