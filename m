Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4013A450C
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377963; cv=none; b=WZsxzxJVOs+bU+xSEQ0zybrjqqIyfzXucuUgiX4lFD1DILK+d9u+NniiTafTabddGby9SxZb7V9LyJWB3Z7HEsfp9/rydGoa6fn51FSEenVVO6SP778Gh0lH1WeyWox/D/dAnUK9C6/zIv6vWDNGePj79rqk3kj83BRNhzD5nds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377963; c=relaxed/simple;
	bh=y+wo9iDBeS0npMhD30rCCyek5oK7q7whGhlUCHN1HNg=;
	h=Message-ID:Date:From:Content-Type:MIME-Version:Subject:To:Cc:
	 In-Reply-To:References; b=pvkJV5HoA2hSTEsJ592vUxuvDTt1sKQgkATn6etRr054KMy1FNvdexZafKGE+7pZXaDrMRa2tfRrlh0oC4o7UN5p/fgtf1q36hN2xZd3ARoY8mCWCOGieeJgjPC0rT4Bk5kGrELVWZ0xOztqbg0bXl+kUhNg3wpXpGyPiUj7aSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgtb2z3c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgtb2z3c"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ab232cc803so18909035ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774377962; x=1774982762; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:content-transfer-encoding
         :mime-version:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+wo9iDBeS0npMhD30rCCyek5oK7q7whGhlUCHN1HNg=;
        b=hgtb2z3ck8Yx/38H1rKpkroQaw4J5kt8YKAEPdPZygaxPwld+KNoseNNno20d4YXI+
         KAIJJfgonX7OavkZJaBi9WYX82TIw5ejEqY3M61w3zRe4mUANlROnLfNVe5nznANB/uY
         WbY5i1dYTeSM35iSwq9iRGQTrqCT8JzChsQF0ajRQgdB2PQ7SJKDTiIATl/pHNv1QB3A
         OulkT1mFO3AtVmBUVVfC3RaV+FRHn/yPd8bmiFP59LdNnlZfQiXJG1zm4UOl+xla7JWY
         Q2aa/v2b/XURZlG42p6xmGv5KqV9x2nG6Pd8e25cq8sAwY+9uG+LNXO0J3eSJMMhwxVm
         KMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774377962; x=1774982762;
        h=references:in-reply-to:cc:to:subject:content-transfer-encoding
         :mime-version:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+wo9iDBeS0npMhD30rCCyek5oK7q7whGhlUCHN1HNg=;
        b=fmNRCNtv44HzPysWbEycPeEgRxjOdfXQJcvW57TKvQeWAu5o8jMb6E44D9t0VXtxNn
         QhgHHrAR7hc9i7eD1VzxZYYSu0u8RPyYEoV/e8JWjO5f4N+8/AQI7AouoodPt7n5WUYF
         /00Md5Qpip2HImZ/q2yMiBRC9bxhPUpYUoD3/fOeE1lAohMRPBVnmxbCYm92kfkB0/La
         9QqUjzCDTlcKNgh/oWBEsvyBOjqySH0tbm04YcazdAnARmx790SCiSGB0Um+X71jnqLH
         UMjCw/Lq/h361lQlOqGaaLDal7xsR+BVDNF5fWB7IzxqKvnmT6fhJ9HvELjtKJeEb7oe
         sLbA==
X-Forwarded-Encrypted: i=1; AJvYcCUzoOYaQg7ITH1wSN63mHm1Y4hr8jYY8VgV2T6ElBMf9NBnF9sa5P3jLjCb86xwRsdH18A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cPjH7saxzPa9O2ZTaW0uNXy+AoTD/LczcOsDb+4AcUS+AZiz
	cYNnb5aElkhrbZPpfYfT4sqenFm18KGXkV5ePMwIBTWAiKFq4HKZVRM1
X-Gm-Gg: ATEYQzzAcoy/JC9MCAP4PF0jR6ME/s4we67STqrO7sPal2yROkwWPVk2EJwZYoICa4w
	EywvJWd/CvI/yb812eLlkZP25c8HaQ3fzHlf31hvnHxBTzFcCaLQ2ypjkoE+7GzzJTuKwpOWR3X
	ayngqBPhbHoIZ0tc4JERgm+AXfPPPTIR9GC81s/XPAvQBajxpM24xVdSG/poIwJzmz6qp4KP7zA
	OF749uRp63hZ8a5hZ4Sxqb/PAHUGfOWvDFx/CbKHXQnvYfFc7Q/16GP8UGFjBuLWnfV1f3Sm0Dn
	TKU0z+FTfJqHj4cBA6WQ5GHZGo+RNTw6S5jkdv/siILguHKqVzZhRLqQSsg5+hyuJsgP30AsaHe
	kq8mK+QW04y+f5BBP/t/PtSWGsprAbssUMHHlgVdQwy6qcKTO8JHCMmlxBrotzacQv9+izV8kw8
	7UBz1hF3VUXAru8HLdhyUenelb
X-Received: by 2002:a17:903:1b4e:b0:2b0:6895:5535 with SMTP id d9443c01a7336-2b0b0a8c433mr6729765ad.33.1774377961993;
        Tue, 24 Mar 2026 11:46:01 -0700 (PDT)
Received: from [127.0.1.1] ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm221497615ad.45.2026.03.24.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:46:00 -0700 (PDT)
Message-ID: <69c2dbe8.170a0220.226f48.721e@mx.google.com>
Date: Tue, 24 Mar 2026 11:46:00 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Subject: Re: [PATCH] docs: Document pahole v1.26 requirement for
 KF_IMPLICIT_ARGS kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: 
 <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
References: <20260324062028.2479059-1-suzhidao@xiaomi.com>
 <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>

T24gVHVlLCAyNCBNYXIgMjAyNiAwODoxMjoxMiAtMDcwMCwgQWxleGVpIFN0YXJvdm9pdG92IHdy
b3RlOgo+IEkgZG9uJ3QgdGhpbmsgdGhhdCdzIHRydWUuCj4gQXQgbGVhc3Qgd2hlbiBpbXBsaWNp
dCBhcmdzIHdlcmUgZGVzaWduZWQgdGhlIGdvYWwgd2FzIHRvIGF2b2lkCj4gcGFob2xlIGRlcGVu
ZGVuY2llcy4KPiBQbGVhc2Ugc2hhcmUgZXhhY3Qgc3RlcHMgdG8gcmVwcm9kdWNlLgoKSGVyZSBh
cmUgdGhlIGV4YWN0IHJlcHJvZHVjdGlvbiBzdGVwcyBhbmQgY29kZSBwYXRoIGFuYWx5c2lzLgoK
UmVwcm9kdWN0aW9uIChVYnVudHUgMjQuMDQsIHBhaG9sZSB2MS4yNSk6CgogICQgZ2l0IGNsb25l
IGh0dHBzOi8vZ2l0aHViLmNvbS9zY2hlZC1leHQvc2NoZWRfZXh0LmdpdAogICQgY2Qgc2NoZWRf
ZXh0ICYmIG1ha2UgLWokKG5wcm9jKSBMT0NBTFZFUlNJT049LXRlc3QKICAkIG1ha2UgLUMgdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvc2NoZWRfZXh0CiAgJCB2bmcgLS1ydW4gYXJjaC94ODYvYm9v
dC9iekltYWdlIC0tY3B1cyA0IC0tbWVtb3J5IDRHIC0tIFwKICAgICAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvc2NoZWRfZXh0L2J1aWxkL3J1bm5lciAyPiYxIHwgZ3JlcCAiZnVuY19wcm90byIK
ClJlc3VsdDogMjMvMzAgdGVzdHMgZmFpbCB3aXRoOgogIGxpYmJwZjogZXh0ZXJuIChmdW5jIGtz
eW0pICdzY3hfYnBmX2NyZWF0ZV9kc3EnOiBmdW5jX3Byb3RvIFszODJdCiAgICAgICAgICBpbmNv
bXBhdGlibGUgd2l0aCB2bWxpbnV4IFs1MzgxM10KClJvb3QgY2F1c2U6CgpUaGUgS0ZfSU1QTElD
SVRfQVJHUyBtZWNoYW5pc20gcmVxdWlyZXMgcGFob2xlIHYxLjI2IGZvciB0aGUgREVDTF9UQUcK
Z2VuZXJhdGlvbiBzdGVwIHRoYXQgZW5hYmxlcyByZXNvbHZlX2J0ZmlkcyB0byBkbyBpdHMgYnRm
MmJ0ZiB3b3JrOgoKMS4gc2NyaXB0cy9NYWtlZmlsZS5idGYgZ2F0ZXMgZGVjbF90YWdfa2Z1bmNz
IG9uIHBhaG9sZSA+PSAxLjI2OgoKICAgICBwYWhvbGUtZmxhZ3MtJChjYWxsIHRlc3QtZ2UsICQo
cGFob2xlLXZlciksIDEyNikgPSAuLi4gZGVjbF90YWdfa2Z1bmNzCgoyLiBXaXRob3V0IGRlY2xf
dGFnX2tmdW5jcywgcGFob2xlIGRvZXMgbm90IGVtaXQgREVDTF9UQUcgQlRGIGVudHJpZXMKICAg
Zm9yIF9fYnBmX2tmdW5jLWFubm90YXRlZCBmdW5jdGlvbnMuCgozLiByZXNvbHZlX2J0Zmlkcy9t
YWluLmM6OmNvbGxlY3Rfa2Z1bmNzKCkgKGxpbmUgMTAwMikgZWFybHktcmV0dXJucwogICB3aGVu
IG5yX2RlY2xfdGFncyA9PSAwOgoKICAgICBpZiAoIWxpbmstPm5yX2RlY2xfdGFncykKICAgICAg
ICAgcmV0dXJuIDA7Cgo0LiBXaXRoIG5vIGJwZl9rZnVuYyBERUNMX1RBR3MsIGJ0ZjJidGYoKSBu
ZXZlciBjYWxscwogICBwcm9jZXNzX2tmdW5jX3dpdGhfaW1wbGljaXRfYXJncygpIHRvIGNyZWF0
ZSBfaW1wbCB2YXJpYW50cyBhbmQKICAgc3RyaXAgJ2F1eCcgZnJvbSB0aGUgb3JpZ2luYWwgcHJv
dG8uCgo1LiBSZXN1bHQ6IHZtbGludXggcmV0YWlucyB0aGUgMy1wYXJhbSBwcm90byAod2l0aCAn
YXV4JykgZm9yIGFsbAogICBLRl9JTVBMSUNJVF9BUkdTIGtmdW5jcy4KCkJURiBldmlkZW5jZSBm
cm9tIG91ciBwYWhvbGUgdjEuMjUtY29tcGlsZWQgdm1saW51eDoKCiAgJCBicGZ0b29sIGJ0ZiBk
dW1wIGZpbGUgdm1saW51eCB8IGdyZXAgLUE1ICdbNTM4MTNdJwogIFs1MzgxM10gRlVOQ19QUk9U
TyAnKGFub24pJyByZXRfdHlwZV9pZD0uLi4gdmxlbj0zCiAgICAgICdkc3FfaWQnIHR5cGVfaWQ9
Li4uCiAgICAgICdub2RlJyAgIHR5cGVfaWQ9Li4uCiAgICAgICdhdXgnICAgIHR5cGVfaWQ9Li4u
ICAgIDwtLSBpbXBsaWNpdCBhcmcgc3RpbGwgcHJlc2VudCwgMy1wYXJhbQogIChubyBzY3hfYnBm
X2NyZWF0ZV9kc3FfaW1wbCBleGlzdHMpCgpXaXRoIHBhaG9sZSB2MS4yNiwgcmVzb2x2ZV9idGZp
ZHMgY3JlYXRlcyBzY3hfYnBmX2NyZWF0ZV9kc3FfaW1wbAooMy1wYXJhbSwgZm9yIHZlcmlmaWVy
J3MgZmluZF9rZnVuY19pbXBsX3Byb3RvKSBhbmQgcmV3cml0ZXMKc2N4X2JwZl9jcmVhdGVfZHNx
IHRvIDItcGFyYW0gKGZvciBsaWJicGYga3N5bSBtYXRjaGluZykuCgpZb3UncmUgcmlnaHQgdGhh
dCB0aGUgZGVzaWduIGdvYWwgd2FzIHRvIGF2b2lkIHBhaG9sZSBkZXBlbmRlbmNpZXMgLQp0aGUg
aW1wbGVtZW50YXRpb24gY291bGQgYmUgZml4ZWQgaW4gcmVzb2x2ZV9idGZpZHMgdG8gaGFuZGxl
IHRoZQpuby1ERUNMX1RBRyBjYXNlLiBCdXQgdW50aWwgc3VjaCBhIGZpeCBsYW5kcywgdGhlIGRl
cGVuZGVuY3kgZXhpc3RzCmluIHByYWN0aWNlLiBKb25hdGhhbiBDb3JiZXQgc3VnZ2VzdGVkIHJh
aXNpbmcgdGhlIG1pbmltdW0gdmVyc2lvbiBpbgp0aGUgcmVxdWlyZW1lbnRzIHRhYmxlIHRvIDEu
MjYsIHdoaWNoIHNlZW1zIHRoZSBjbGVhbmVzdCBmaXguCgpTaWduZWQtb2ZmLWJ5OiB6aGlkYW8g
c3UgPHN1emhpZGFvQHhpYW9taS5jb20+Cg==
