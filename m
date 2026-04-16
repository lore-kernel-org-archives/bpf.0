Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5333120C
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348676; cv=none; b=hkqvLfNF5s7jKUwJBwqrNl7xJDdf609+5D5iUnI3FAqYBWD27KZ7TRWO1SqHksaCx8Dt6Wln4Agx/DpEvQ5ktcecXEoeGhzKonR5Ec43+yOdu5g+jNkUqgkxPftd0iRKLOTosnjl2fUkbT9I17hPzU1HLPm4KU+ATc9rEnIC1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348676; c=relaxed/simple;
	bh=Jo2wLJ3Vk0m3DAWZWBw5zk9FjZbusVRlJ3p3VXn42iQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b0VYtCu7bvVdtPshSkyAUFxFo8jQtfiOc/T1NlnGYwlDP4PwtsUbBdu1onwZd4p/ZRSIQ+X8udBFJ1PwBP31UbjOHRIKdiVtz+hJ9k3CgMjkivqQpnlndufw1TI5EQQb8HNwvcvppAn8ZehL3fhJIOHZ6w7zk7+kyN4Xd5/QKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9YG+DcR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9YG+DcR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso3666014a12.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776348674; x=1776953474; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2LEegCsou5Ku+cEMPUyMrHkJkU+oGi9hyRt3vijjuw=;
        b=j9YG+DcR4OL2oj7cW58gjroBInoqRwPaXvyBqes4YuDR1N0/lMNBUFVx5Eiln0q11l
         ExJtoYHLx4teg+LYLOwznGJXY/nzBJJ5T1wJf+X8Z6XPvnMBH4yR5gli1JcFA0hKBEbK
         dvdj8sMtlQFg3c7AXhxb1wMnvKprdTxvY2XIbiB28YenVUm1/UN0F5RO02hcnmQOCOzl
         K1FnqVoDS26p5OYAfvOFairKORWY2YRMVT/cfo471cFo7caW90Dki4HhHggToRRPqQ5V
         uvC5L8MHgXn5+pGGsEWBNIaOvqi/f5MWz7UaB3Qd1FMtVni1rSMddk3D7t1pCLkmcVH9
         sCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776348674; x=1776953474;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2LEegCsou5Ku+cEMPUyMrHkJkU+oGi9hyRt3vijjuw=;
        b=TNxY/psWKDmipdw349ZNZEe44KbhyGvSnR4Jn9+sRJpmvlnLLV0jDZx1Y5Y4tnT1TE
         ROWQmBqDP5l4gI3B9+Fi5KYIcTDvziPVvOcdPf+ByeVtlyYN8x7lhXK6nnNYpFy+iUF7
         EFISMtZIgWSPlK+l6YYUrgVyImISfmTV6s3+yUalUoaXPmPp3mh1bGaHBfKXinwIgTPU
         z3389PGn1pxiMc2eR1qwVkk1By/LPt/LHH5saCbXbbee1SYI5yrzdl6DydByfFPVDQsR
         iy2XyK3nVYwqz3IIfntTaIdUkkgokvJHrbpzviye3vjX1T9K8piOez7dJDlX4/iZzUjd
         YZbA==
X-Forwarded-Encrypted: i=1; AFNElJ/c/84uY20SwEiMWRpyCXulid+WBB7S7scpTKv0S+EVpmyZ/7xh+1sAN6O2AggxwmMIzmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl11uaEVo1T3Pg35TrN+xeg6zS4mjjG09Ii7KgAhKzAFNMB2Lo
	txrHIwVw7OKcOOx78AF47CHSZmkCPLz7P4IjDRFm5EWcZRCz+f32c/I1
X-Gm-Gg: AeBDieufaB5lKmiPZ88m3HU0k4MQUi4LuF7nx0stAOVU8rOqcucRslq9vjCc9d+qqPh
	nXim9JWG4c3dz3yC7x9o8YPPrkyGFc1hiBwnaA5dSp+04aLoQdAR8TpdmutuGknvtu4+AJb1Ze0
	GSKPEvUG5XAh70QJGp0YuSAtczIOwSSLiMEeB00td8miMKOcpLEhhuwcLdHkyFRWT3a+KdMwM0f
	qRT10YDVQTNWW/yZVBFkCQvV4kUrae/enwUnaOP9Otd81TCASUVQCz+W97NwihwPQZuCCC9MQw0
	jhiIQJbAU14vHGcO+J2JRqLrE7YqCKSsCmDA0j5OZjJbjf2DMmwf9JJM8Mgma6xj3RMq+vHZT+q
	MNaNcQ5bOFIHicsziwb9l0U4hSs4kObXp8SiM0hny9ebdtxdExB0+rx2OVUBbA1CBGMCwsPlkbX
	CcjCu8pClnyZfCKvf9r/+v2LLkjOsTGLFbSkZj1AJ8G0tawqTyY70tNliN/n1Z6RosIRyh8iyAG
	SX2KWf4NFklbgcn9MuJFtZOyiG41wMBWMCL43LFfW7se1+tD6+jlFRG
X-Received: by 2002:a05:6a20:748b:b0:39c:1f:3211 with SMTP id adf61e73a8af0-39fe3d618e2mr26680940637.20.1776348674000;
        Thu, 16 Apr 2026 07:11:14 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ece9d4sm4726935a12.5.2026.04.16.07.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 07:11:12 -0700
Message-Id: <DHUN1UJ0DLBC.3UC7SXBAV2FOW@gmail.com>
Cc: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin Lau" <kafai@meta.com>, "Kernel Team" <kernel-team@meta.com>,
 "Eduard" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <ad8Fr4jDKvp-oxAw@gondor.apana.org.au>
 <CAADnVQJCpJ0bTVPQ0LwoNubsK7-HsdePWgdMz8DX=v9cjgvyKQ@mail.gmail.com>
 <aeBxQn8ATaNuEF4X@gondor.apana.org.au>
In-Reply-To: <aeBxQn8ATaNuEF4X@gondor.apana.org.au>

On Wed Apr 15, 2026 at 10:18 PM PDT, Herbert Xu wrote:
> On Tue, Apr 14, 2026 at 10:13:21PM -0700, Alexei Starovoitov wrote:
>>
>> No need for such guarantees. It's best-effort only.
>> If the walk skips entries it's fine.
>> As long as it terminates eventually it's good.
>
> There is no guarantee that this walk will terminate (unless you
> finish it in one go).  In a pathological scenario, after each
> walk attempt, the hash table could be rehashed such that the
> entry that you're resuming from gets moved back to bucket 0.
>
> More practically, the walk is essentially useless if you encounter
> a rehash/resize event before calling rhashtable_walk_enter_from,
> because half of the hash table could be missed because the entry
> got moved near the end.
>
> I think a better interface is to detect such a rehash/resize event
> and then fail the rhashtable_walk_enter_from call.

that's certainly a cleaner interface. the user can retry
if resize occurs.

