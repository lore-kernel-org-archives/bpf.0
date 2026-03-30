Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA603EC2C7
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911179; cv=none; b=tld7cUgrByG692RrmEsio+4tk9jmXHJvMZNUVO47cLrYRjAIfEw2ieO56/O5n64my3STkIyPR2tCsClN6OX1Bj3EsXUUYwuhSgg8UtcRqbZ3/iIPBS6L98ZmYoq7yAbEAqPBsdnkn4b4YXAtXHhwErmOM3ePHzYDkAsizxDgJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911179; c=relaxed/simple;
	bh=GlsvuczdAbPVycyTDaQJ9mijfxAn7/aMjggiH0GU16U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ctzoXQmcqF4jPERCT7vihg/HMOF41fySeQz8uUy1zDBmGQuIHFlPbN9+wVST7+YGX+hROougJnLAa1IqF/2Znfsa8HZEaptfOvg52Ap5tAD1DTd7NmQYeILTSZQ5v/kh2HMchvbw0Sozidvc2v2QCqpE+hOI8w3Lxbe5RXXXyLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrKY9O6w; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrKY9O6w"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76af79f029so106382a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774911169; x=1775515969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GlsvuczdAbPVycyTDaQJ9mijfxAn7/aMjggiH0GU16U=;
        b=QrKY9O6w8q9bADNrm7go5LaFhLZep9sNMEEGRc+GYuExvh1INF+JuoMpxyNTnd4ijB
         45IlrkICOQEGjCf/MxfsEUPiZfnHBnD7yYnFHQ/Xk6aM0FdE+dSQdSL47GhPIgMFbLdg
         1Ub4nAhWCO0VmsyuBFHyXsbwroQIUX+c6iC/neBGH+tfuXTDZBgVRmRqLU3m/hApCyvh
         4XfOrG5DCqmaH94J0vfgxv/vxYwnN7+z9VH8Hnofp6nnCiEJr74mCar6UQRYRGVfLPB4
         A2PlN89mmEMHkMNjjtSD3Bw5an+7eUwYw8r9pNXpSGH9LNJ2PPCxJ2dcxCPIY+r88IJT
         S8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774911169; x=1775515969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlsvuczdAbPVycyTDaQJ9mijfxAn7/aMjggiH0GU16U=;
        b=OmGyDs4dUOeZmIwcXWz2Ocu4QxWQbzeWYUooyDqyORhJa/8fG1Ste/a/bXYVfRvtwv
         /NQ1GaGA3oqR49O/c9DRhh7sMzJo7ufDO/0TdwqjyRBc1LHs8re4MQKG9Xc6EW93la2h
         UoNJL39i2wC0rLiM39epjFnMjVjfjEAtLR4QC/OqfG3b1MAsszL8HxImF9z5af+D3gj/
         2g8GTT/Lmu0iqaNbXIpwpJkEm8lEZ+DVc3pLlN/f1QHJMAEXV4P+nFpOWhIDGYoT3LvH
         qGoqdq2VkOAwilFr6e51d20izNXUhlkH6HQ3EZT2tXlerjKFKRKfykUrIpHVWrTQbwbI
         TPaA==
X-Forwarded-Encrypted: i=1; AJvYcCXDUFWyTBXUpLGXuGMHKZ2BLU/o74wU88UHytOI+2q7leDFINzQhqXf1qGzu4hg/8V4QLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/6MTAOfDNsrRvlIEesOOYr9j3E3sFiFz1pAcUzF7JA3EDqnQ
	8wL6eEw2QDTcVHEmVz+wLW+oENJA7yA2YEAkDBd4QS4zWy1WA3fe8lZF
X-Gm-Gg: ATEYQzwYYp08vcv7NL1tA7wgwSFWfjiaLR+096z/HZJJvgB2a9C27de6HuUI5qavpy/
	2DrgFysyaVpZGnEfmX/jWQsajVa5cjHQLW5ETiTnSU2iUTHEFXtfJqWcEiAHiGChM94Z3BP2lBG
	ebJwhMwyjro4Xs/yF3Pg9hX1FK7mXR3v4JkZ3UlBuuwihLdolTq+KSW5QvIqxATN+YwZPAHV1gy
	N3I683kXk/69Dd97CJAKlVMCE2VTtc9YshKj+xSE+nCeM3mnoOmfD8G4u96e/rqEqKCCeATOSYV
	Dcb4BMx6HxuRSB+xv4HZOQGQkyY3Qq2fKuyfL+yffdqI0YdjRAXrZWnlYEGoQbqf1CxsG7WYlnP
	p+7WrsVBkrNUZsUmFVzdkw5I1ACkkBX/A7JPu5gYGNBmZ2EEYumIWiWpDDFwYV9ghoh75f3OhiK
	Vamb2daofA5+YlVLW6nG2XArCiVtELjFcAZuC7D5NNBXwIxpwUfX8=
X-Received: by 2002:a17:903:13d0:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0cdd18cd6mr170216365ad.40.1774911168911;
        Mon, 30 Mar 2026 15:52:48 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm89875875ad.38.2026.03.30.15.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:52:48 -0700 (PDT)
Message-ID: <2a1bd41bdcde117ba40bfe568d007a80a1ca5ab2.camel@gmail.com>
Subject: Re: [PATCH 2/4] selftests/bpf: make str_has_pfx return pointer past
 the prefix
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, 	andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Date: Mon, 30 Mar 2026 15:52:45 -0700
In-Reply-To: <m27bqtpc3z.fsf@kernel.org>
References: 
	<20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
	 <20260326-selftests-global-tags-ordering-v1-2-5dd2ced5d9ad@gmail.com>
	 <m27bqtpc3z.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE2OjMyICswMTAwLCBQdXJhbmpheSBNb2hhbiB3cm90ZToK
ClsuLi5dCgo+IE5pdDogT3RoZXIgdXNlcnMgb2Ygc3RyX2hhc19wZngoKSBjYW4gYWxzbyBiZSB1
cGRhdGVkPzoKPiAKPiAtLQo+IDE0ODrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghaW5fcmVn
ZXggJiYgc3RyX2hhc19wZngocGF0dGVybiwgInt7IikpIHsKPiAxNDktwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5fcmVnZXggPSB0cnVlOwo+IDE1MC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXR0ZXJuICs9IDI7Cj4gMTUxLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+IC0tCj4gMTUzOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGluX3JlZ2V4ICYmIHN0cl9oYXNfcGZ4KHBhdHRlcm4sICJ9
fSIpKSB7Cj4gMTU0LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluX3Jl
Z2V4ID0gZmFsc2U7Cj4gMTU1LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBhdHRlcm4gKz0gMjsKPiAxNTYtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29udGludWU7Cj4gLS0KCkFjawo=

