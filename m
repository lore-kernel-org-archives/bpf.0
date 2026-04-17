Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354221474CC
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460627; cv=none; b=P3WiZdqFRfFQd7whx0tOtwVz46i7oQ9FE11pcNnguJfcBPKFKKKRtEULXsh8ngq9qVBE9Rb0TOhAFlJsGwpeOMo7FzE6h2zmFSwtnIMOL6q3xJqMKUcBDYBoY6ZtaePSUvaMiUh3hvpxRJc1bpNp/M9a6sgIA2ow0o76c4JLU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460627; c=relaxed/simple;
	bh=upu99ggINWAFh9S8/JW/fTyJkneKfK0RAWBKJeUcjfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiJG5KLoI18+bqyVQx0eRB33y4QvslOhC0p6xMZw1KiuJOCpRG+++zXOxG0aQOQDdDaHwGX+aA/MPwN19gXmQ03QNfZ5JHD6X8BQF6RCDIFpXkjdx0r54i2SUg3gXosg69JCHImxCZYbVPPzqmxbh9WnfDHtBmskUEm9V+c9VcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf12e4KB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf12e4KB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9516a653so6096665ad.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776460625; x=1777065425; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=05TJCvFAG0GoCswjYDEDF+y8NWW0JYIRQsWFFeFikgY=;
        b=Yf12e4KBOy6fP1z8bO/puYqEmnWA8arbgIWPett1/sBO0mf2VG5GKjBgkW/ihldDsi
         YB0w80YdlX82UTCURc+REJq5tYs+bE51Y//qS8rqJMxSI/W8uawOt9EOAzXpIyh0X9Uq
         G2WuhlyHdiuaQYYjAwwPT+zdajFiOLUh6xRrvPPfD9r3up8Fas/mjcNwJ2e4Z+KJJQjx
         lA1xE4Hoxg0DFuHaCqfpI/Gt4QaMpUXJNegFx/6/B5I00/J28yujhMwo9EkFGI35oY7z
         NcmZ+dD4d+Kg27u6SEYABzAyH708i5nTFFLkN645IsdilqJVvEPooZjoAt8WS8ps53ML
         McQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776460625; x=1777065425;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05TJCvFAG0GoCswjYDEDF+y8NWW0JYIRQsWFFeFikgY=;
        b=Hok6qniYH4p0ZDIz9mAYd4tzWRbiArN1XTGAIZskJtqgjHcvneI7ZkR8c22vCtNk2H
         15rgUrVFM8XbCTDeYUF+DYobXePzEWHegjWj96ORt5N1ObI4f/fN/xrJFshPKas4w/L0
         I0+XjlodkmV23FIpCaqchqDm/FTiRz58RCEJxK2lWXp9hQjivccvADyj644lasjTd2Is
         DPyXr/2cA55tqqFPLxk3/OKcG45pvgUQDZ/kA/p+T++FRt7ST9pWwE3vux28yuoQomcT
         FbfeEQH3/ggP8Gkibjiwtc1jTw/Fb3J3pPoxZeKvullzdWG1YXh8OLblzraNAYEdrYQu
         Gz8g==
X-Gm-Message-State: AOJu0Ywv49m6hD+eU70dsTwXS9vAcRYuNeILNQB9XVo5b2CmidpehYSA
	YpvCPuzr+j2dP6WMKybrE5e/3n/8TTy1CcCnk3qaTHGm2av5MhoqEDG8
X-Gm-Gg: AeBDiet0h1wwQYkbT13wfLdm5A0/zcxywKgkepqjVm/cOVALQgcuXhyYSOylkJXn6up
	HIJbIEln8/Vyu+CQIC5ICEUxvUjDDvUZT9GmdSJkzTxB0iHBaLRtF1Z97Cq1zhIwTQBiS5j6LMO
	OD0keXb1BlCn0o4ac1DRxtJsJUjla1Xigob+NLr7LaDPMUqOorfYl3/hNW90ccyTwjuUk+fyHfz
	122rurBDOyGECuTCEGr2ySHcR0bEbLKY4PQSWhp7Aawk6spNz7i2DSXCBaZMZikTy7RxLfj5+S9
	gRtlZxLsnKriMma8eQp2z8e/ZTP/wxLAK0LBmGhCMa8KyLbMzNa1vqcjLh0wIdg/NiihY1WMFTa
	eFDUAKsq0OBnzX4xjbRQq1Umg3tVq1+KNKTZLBfOJU+TDINkvDrzgon1NuV4w9rsCcK2OTxkHck
	7zruJIZw/lO3ltKhPztVCmrJZyXd5FBcKjAUw/dLowMEowLuHWaLOu+AI4uBgLr/8=
X-Received: by 2002:a17:903:3e27:b0:2b0:5795:9ead with SMTP id d9443c01a7336-2b5f9d50132mr32173325ad.0.1776460625445;
        Fri, 17 Apr 2026 14:17:05 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa174c3sm27896835ad.21.2026.04.17.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:17:05 -0700 (PDT)
Message-ID: <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Paul
 Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Fri, 17 Apr 2026 14:17:02 -0700
In-Reply-To: <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
	 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
	 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
	 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
	 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
	 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote:

[...]

> > Could you please comment about the witness idea?
> > Suppose reg_bounds_sync() is modified to preserve the properties I
> > described above, would it be sufficient to check two candidates:
> > tmin and tnum_step(tmin) to identify a register in an invalid state?
>=20
> IIUC, your idea is, if there is a witness, it should be one
> of tmin, tnum_step(tmin).
>=20
> - I don't think tmin, tnum_step(tmin) works, because you might
> need several applications of tnum_step from tmin to reach umin.
>=20
> - Assuming tnum_step(umin) to reach the first intersection of umin
> with the tnum (let's say x), x might not intersect with the s64.
>=20
> -  I think one of tnum_step(umin), tnum_step(smin), smin, umin works
> to find the common intersection point among u64, s64 and tnum.
>=20
> - But even then that particular intersection point must also intersect
> with the u32 and s32 (when mapped to those domains). That
> complicates the reasoning.
>=20
> Also how would you ensure property 2 described above
> in reg_bounds_sync()?

Continuing this train of thoughts, consider the function
find_witness_aux() from [1]:

    /* pre-conditions:
     * - (u32)a_min <=3D b_min
     * - b_max <=3D (u32)a_max
     */
    static bool find_witness_aux(u64 a_min, u64 a_max, u32 b_min, u32 b_max=
,
                                struct tnum tnum, u64 *out)

If there is a tnum T, a 64-bit range A and a 32-bit range B, such that
`(u32)a_min <=3D b_min && b_max <=3D (u32)a_max`,
it can find a value that belongs to A, B and T if such value exist.

I believe that this function can be used as a basis for complete
witness check including signed and unsigned ranges:
- Each intersection between signed and unsigned ranges produces one or
  two unsigned ranges.=20
- If e.g. (u32)a_min <=3D b_min does not hold, further subdivision is
  possible.

Meaning that final witness check will need to enumerate several ranges
and call find_witness_aux() several times.

Wdyt?

[1] https://github.com/eddyz87/find-witness
