Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C62E62AC
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104876; cv=none; b=sGOVm2L5aIsMGU6Bq+QZggBxOyyQQ/UH9pi/f3Wp5X0yMKkVjaJfEsE8SnLlkrXyMi/eL1bOGPg4Q27S+KbxFvOtrgHXKwwiiM+7djRhjwQwhgB4ZsTnRVcoF2n6devRjFvxv9dTpHOE3uPu9Vvm7rCSV5fRpodNedJJti9LfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104876; c=relaxed/simple;
	bh=+82B3NLEx4LrtkQpj+8ALvV8Tl0xlrn5YvTImJ32VG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2AdfAIs1cS8LwtPehwqr9nkSJIS/KOvdO6QvAVZEeWwPDB/TSaSWANsR7PdbfHTTpzUmYZMXoXihj/9KbmpBiM4ahDdy4BVWjz9I1wUykbGaFhbGdC1615esVb8UNbdf4gh7TLG2ZD01pYoS2rusNYjhPeRw1VR/LM7ZBnp0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlv1nIrI; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlv1nIrI"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so8585851eec.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773104874; x=1773709674; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akoYIziW8muXaychYuEvUAJsrcp8mbQ0T6TWo9HSPkw=;
        b=Hlv1nIrIOlYoAUH0q4eBSlqmi8xQueF9KWllpvtwF/BACwCUxVc5Trz/JF7TlIiYzw
         bvfozjCSX55tYqdheAFaSFJmZZdFJsQuJCyctc/FBdPDm2wgnEdFF4v7WEFzdMPEXE4Z
         NmN3GIY8x6IVtGY7rVEk2JqFvjfM7tQa30+3XZmdnWufBueoPS/mQP8Mp58KCGm07uCn
         kDDbus3sz3WCDVRIKCem0Z7dOjuga+9wiKPSLTS3az2CnR3w1u4n3abPeZIAPn6jpOo5
         Ug+XrWinfCBQdBheLfnxzqzXSaqvUqzcGcRtzjmxx/q72BdMseVFLOncIgBAawrCwX2K
         sYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104874; x=1773709674;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akoYIziW8muXaychYuEvUAJsrcp8mbQ0T6TWo9HSPkw=;
        b=uI5rRFpltuANESBobv4Vbmlxc0PI6h92uihf1Frq5VvFKVx++dDyoZ5xyGGRp26Cd9
         F/V7j9D92CEtJyLHNKFgVLFJnvKO0wD7QSfuhWEECdQ/YgK/DACrCQsfMmhIg4n/iBnj
         +UeH5CimHatRnsUR6+rfIGNyLiG7GF44gjHzBsIKzD0D0xAANiuD+UXm2esQegUxoyDp
         pC3XtxRHcqrpjCwxQVlzOgY2gFDn+EmnLSFs/GRd6tB55UW0o+l5Rda+xb6lW/oweAZt
         HEsAMerHu8TQSJczgw5b5YgHsh69/LYrU5/afghLHjhBzcoskfghCHuKoqNo9aETbuct
         ISCA==
X-Forwarded-Encrypted: i=1; AJvYcCXDlqQOJB+ajaQ2odX8E84Mvw8JCBt4nbeu7jX8r8SjJHI93kf74lx2jya+utzgZHucjUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jp53J8bzR1i4gh0tGcheS6v+Zgtp8iNeei0n6so/cZuzdGek
	7XoB+DWNQh6mf2jthdAHdt9LCnxlDWoO4RQNTvCq0JpXb25w96gsnWKzlxkkYN3R
X-Gm-Gg: ATEYQzyL09XuGUpBlPnMon2LSg61YLhN7H6lEQT+g0t3jrXcjrBnd+p1WFzvJKM3jdt
	q4JZf6XPYZVdbkJLfPAe06WCtXwyp5d9EO2l0H2YziIbYPMUjXEw2ezi+WAUQD1UHFh+rKmxdRU
	O/ZV1YoKIN+UdOWEZrbGGqqR5dv8g09VYEpC+XhAVAFoF9+fPXSulNhuiPmRDNFNf2MU8yMCKok
	AG4kNSCxAZ5MM6ZQ4ZdEMhF1B/F0ZUSskLL/BLX6OfVHb9RWgj9oqP0xTdm87JaNjP/mVENHcz9
	gefppHbbX+qpPc9iFhwPsUYjOVAWuG6W4ybXhlg8USR2Rd7xhn6v9BhXo5lCGl9rVXMjPhTqfru
	YfRjwTtl2vjWdDtHvCirhRUAYc3N3Pm4PyiJ5JpPN/oGyqFSDk4mBt7TqN/04AOTx9tXpEJiTUd
	ONHY6dqc0XfLsHhwGL/BjFHr4YMBj6j79uEh7vsuPALWe5i/UXc877ZatYoHilDQdfop6v1Oh4L
	uEeBas=
X-Received: by 2002:a05:693c:2b04:b0:2ae:5bde:a5c5 with SMTP id 5a478bee46e88-2be4e05d273mr5485811eec.30.1773104874422;
        Mon, 09 Mar 2026 18:07:54 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9362:b19:e25f:7640? ([2620:10d:c090:500::2:405f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f68esm12629324eec.29.2026.03.09.18.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:07:54 -0700 (PDT)
Message-ID: <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>
Date: Mon, 09 Mar 2026 18:07:52 -0700
In-Reply-To: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
References: 
	<5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 01:01 +0100, Paul Chaignon wrote:
> In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
> added a new round of bounds deduction because two rounds were not enough
> to converge to a fixed point. This commit slightly refactor the bounds
> deduction logic such that two rounds are enough.
>
> In [1], Eduard noticed that after we improved the refinement logic, a
> third call to the bounds deduction (__reg_deduce_bounds) was needed to
> converge to a fixed point. More specifically, we needed this third call
> to improve the s64 range using the s32 range. We added the third call
> and postponed a more detailed analysis of the refinement logic.
>
> I've been looking into this more recently. To help, I wrote a high level
> sequence of all the refinements carried out in reg_bounds_sync. u64 ->
> s32 means we used the u64 ranges to improve the s32 ranges.
>
>     /* __update_reg_bounds: */
>     tnum -> {s32, u32, s64, u64}
>     /* __reg_deduce_bounds: */
>     for (3 times) {
>         /* __reg32_deduce_bounds: */
>         u64 -> {u32, s32}
>         s64 -> {u32, s32}
>         u64 -> s32
>         s64 -> s32
>         u32 -> s32
>         s32 -> u32
>         /* __reg64_deduce_bounds: */
>         u64 -> s64
>         s64 -> u64
>         u64 + s64 -> {u64, s64}
>         /* __reg_deduce_mixed_bounds: */
>         u32 -> u64
>         u32 -> s64
>         s32 + s64 -> {s64, u64, tnum}
>     }
>     /* __reg_bound_offset: */
>     {u64, u32} -> tnum
>     /* __update_reg_bounds: */
>     tnum -> {s32, u32, s64, u64}
>
> From this, we can observe that we first improve the 32bit ranges from
> the 64bit ranges in __reg32_deduce_bounds, then improve the 64bit
> ranges on their own in __reg64_deduce_bounds. Intuitively, if we were to
> improve the 64bit ranges on their own *before* we use them to improve
> the 32bit ranges, we may reach a fixed point earlier. Said otherwise, we
> would need to move the *64 -> *32 refinements to the beginning of
> __reg_deduce_mixed_bounds. (The logic would then also better match the
> function names, but that's secondary.)
>
> After testing, this small refactoring does allow us to lose one call to
> __reg_deduce_bounds. Without this refactoring, the test
> "verifier_bounds/bounds deduction cross sign boundary, negative
> overlap" fails when removing one call to __reg_deduce_bounds. This
> patch therefore implements that bit of refactoring and reverts commit
> 5dbb19b16ac49 ("bpf: Add third round of bounds deduction").
>
> In some cases, this change can even improve precision a little bit, as
> illustrated in the new selftest in the next patch.
>
> As expected, this change didn't have any impact on the number of
> instructions processed when running it through the Cilium complexity
> test suite [2].
>
> Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
> Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

I wish we had better names for functions in question, e.g. like in [1].

Since sbmc is all the rage now, I tried to check if new and old
definitions for reg_bounds_sync() function are equivalent.
See [2], where I copied relevant definitions (except for tnum part)
and added a simple test to see if old and new functions compute the
same result. Running this test seem to show some differences, e.g.:

  Values extracted from log:
    s32: [-1741665249,  1482110531]  v_s32=3D-1202410177
    u32: [ 1358815199,  3092723295]  v_u32=3D3092557119
    s64: [  -509161414271901871,   9223372036728946880]  v_s64=3D9223372035=
652365631
    u64: [  9223372034449554622,  17937582659561010782]  v_u64=3D9223372035=
652365631

  Running C code directly:
  input:
    s32: [0x98304c1f, 0x58573643]
    u32: [0x50fddfdf, 0xb857365f]
    s64: [0xf8ef186430fcdf51, 0x7ffffffff88000c0]
    u64: [0x7fffffff70a33cbe, 0xf8ef18643857365e]

  old:
    s32: [0x98304c1f, 0xb857365f]
    u32: [0x98304c1f, 0xb857365f]
    s64: [0x7fffffff98304c1f, 0x7fffffffb857365f]
    u64: [0x7fffffff98304c1f, 0x7fffffffb857365f]

  new:
    s32: [0x98304c1f, 0x58573643]
    u32: [0x70a33cbe, 0xb857365f]
    s64: [0x7fffffff70a33cbe, 0x7fffffffb857365f]
    u64: [0x7fffffff70a33cbe, 0x7fffffffb857365f]

Of-course, I might have some bugs in the test definition, but in case
the definition is correct, I think I'm inclined to agree with Ihor
here. If we can't mathematically prove that the sequence converges in
a fixed number of steps, putting a loop on top of it seem to be a
reasonable thing to do.

[1] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle
[2] https://github.com/eddyz87/deduce-bounds-verif

[...]
