Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF772192FA
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775681309; cv=none; b=VLoS+MrCqJzBIkXEEt2LMB/4N0Yhxdb1+xgDiLTV45moD1LJn+CqLSeWD0CpnVW0H5+4f53NN9HxPtDWmfP7ikHkb60XfwVFjORh5gE0upt1P3mYZmnEmpJaYbHEkG26ZEmLHdWOX3QJqGKdrGfc7wGJQ1iGVaUymzsTGpcfcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775681309; c=relaxed/simple;
	bh=rZuq/zPtRkz76ipIYLv1YVk/rAkHxhVtorWWQelkHf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkSsgtigkktU04mdqDcAZnaRBV24oOWUpLAyQ8KtGdoimH+GbIFFMxT9nYLoUyAXXA4w3PoVZoQpQu06bGqueTvwmoNjuK0gEDIS+c6+pqFzA4MSSzrbgOfKYsP7HFAdyKM43MEu4Fy9fwQHs7euGWbXHCbhPxwe3sd5rSGhP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFbN8fD2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFbN8fD2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488971db0fdso1445385e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775681306; x=1776286106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qs+GSw21D1xGjkkwNzosjssz6xwqG56NoQr4VL7iZMA=;
        b=qFbN8fD21MOYmDGjm8O7XFDYw59/kzUO8QUfh0ooI0xyoXFFNrosSwbhMj5beylVzC
         8P62vD9zT+8D04+HJ4+EgQWEZkxZ2x3zhK4wJE/KI7PewMsX9xt4g0W6xc1boJxqNLTo
         0gK0jvxv49h/BAdzLQR7/cZhi9GsdfbTemHDWV/aHF6vnUjxXdZLgCYwLNnTFMjLRd+/
         8Jb89cRRXURsZVBqJxhpLNcE/F5Q8VQ9HQ0w2YVgVhLoAPdseSOaMewuk9sKkGVWjzog
         WXBKFqN8YX8Spe4C7EFSfy1NSAL3X19HtOKF4Dt1OfpKeecle5uLkOYJqza3o9mVnHGT
         UaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775681306; x=1776286106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs+GSw21D1xGjkkwNzosjssz6xwqG56NoQr4VL7iZMA=;
        b=YL9wcdjaHSLogZDEn1HFnRU4+rB56HcTT6TezVTHVG2nkt/Njo5oQ1/TgFbUZGAD8C
         8oDJVXfxJ4p30HIxQaU/Bg1jM1fArqWfaWRZBgEkXeSjD5wZSIlHDjUw8y0IBhHpuUcz
         TGXnHvK94nUaz0iwCnxgEo9cvLAVtOZOvg5WEKxjrZKP6hi/HoI6dWsA8w9oUqLGL4kF
         kACEH+N1PGWAbnSU0aQC9O0hB5NKpJRP3NJFvhKpqzN3y+tm5sJFkAfRhphrpyqVpQxO
         ulZ4bvPsbVsj2iYukS8G3aMuB6Ru3Xl4Ox715WJr3UmGZVXjn0F2qBFU15CDvhlMflR6
         9PgA==
X-Gm-Message-State: AOJu0YyB6+ebDEueD1gdiuPQnnU7ECjNN8NxL0BLAuDBQQZvqnfuajR7
	uV1xlmyIprc8nAPg2qHhAjLcbsY5/U8ilYt4qKbo9VHqeTuMzQujlIyhbYC3hHet
X-Gm-Gg: AeBDietFI2KdukjVk78vCnIVUFDIwFlblCRNLZGTB7N3r1BEtbVhPEelH41lXCNLRnu
	X8SZfQZh+PosiMVdSqKXbXV1FrQQEGn+y7Jsl5tkUQG4Uj5iZYymRRJvE59y3D3d7EMhZEup0F1
	ps2b4ZpLJdsQLYo3dkxIbuYLnNyQRaGDGsBPGkqgORoSeGr4xsLiPnR3ZqvsphtQnguZ2pGPBY4
	U3sneYLdoohupaSsx0h9+9TPtYRFj/BP4XfkB1kJtNRqcMuiIDQj04JTBG4pHykuK+9vP49eBBW
	K68T0jLdxn5bygYsG69YceCoUkLAbSOU2VqDkFlDPEfNAPjUc4mAWK7gYMoUhDjN/OOJOw4Tf+L
	KPdEX3aV31MgEyYPSbucCffHvAiJ+KzfuQjQfAAfRWXSZ/EVoahJUOzX6Pn0bfA6xKipVPpmMo8
	4BGoxHNwBwfOPCKSe+GV3aJ/ysgSKNrZbIYgx9VZrj3d272SxQOEzGEk7ksl/s0kI/1VdgiSV8Z
	M/5VBU7JNztfPTpYQQNr1IqODJ7QpXZ+bgp9OciG3mzCwi5IAHADD6k5LOe2hVSRKBeAumvrcAP
	qNYdDsT3sndTmGK5S7WnBbwIw9vgBkEG50/SjvDhtA==
X-Received: by 2002:a05:600c:c84:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-488cd09b4c7mr15617165e9.30.1775681306017;
        Wed, 08 Apr 2026 13:48:26 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00037c778b43d13a98.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:37c:778b:43d1:3a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd2492e8sm17461635e9.15.2026.04.08.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:48:25 -0700 (PDT)
Date: Wed, 8 Apr 2026 22:48:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix reg_bounds to match new
 tnum-based refinement
Message-ID: <ada_F2WbRcnOYXWb@mail.gmail.com>
References: <ada9UuSQi2SE2IfB@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada9UuSQi2SE2IfB@mail.gmail.com>

On Wed, Apr 08, 2026 at 10:40:50PM +0200, Paul Chaignon wrote:
> Commit efc11a667878 ("bpf: Improve bounds when tnum has a single
> possible value") improved the bounds refinement to detect when the tnum
> and u64 range overlap in a single value (and the bounds can thus be set
> to that value).
> 
> Eduard then noticed that it broke the slow-mode reg_bounds selftests
> because they don't have an equivalent logic and are therefore unable to
> refine the bounds as much as the verifier. The following test case
> illustrates this.
> 
>   ACTUAL   TRUE1:  scalar(u64=0xffffffff00000000,u32=0,s64=0xffffffff00000000,s32=0)
>   EXPECTED TRUE1:  scalar(u64=[0xfffffffe00000001; 0xffffffff00000000],u32=0,s64=[0xfffffffe00000001; 0xffffffff00000000],s32=0)
>   [...]
>   #323/1007 reg_bounds_gen_consts_s64_s32/(s64)[0xfffffffe00000001; 0xffffffff00000000] (s32)<op> S64_MIN:FAIL
> 
> with the verifier logs:
> 
>   [...]
>   19: w0 = w6                 ; R0=scalar(smin=0,smax=umax=0xffffffff,
>                                           var_off=(0x0; 0xffffffff))
>                                 R6=scalar(smin=0xfffffffe00000001,smax=0xffffffff00000000,
>                                           umin=0xfffffffe00000001,umax=0xffffffff00000000,
>                                           var_off=(0xfffffffe00000000; 0x1ffffffff))
>   20: w0 = w7                 ; R0=0 R7=0x8000000000000000
>   21: if w6 == w7 goto pc+3
>   [...]
>   from 21 to 25: [...]
>   25: w0 = w6                 ; R0=0 R6=0xffffffff00000000
>                               ;         ^
>                               ;         unexpected refined value
>   26: w0 = w7                 ; R0=0 R7=0x8000000000000000
>   27: exit
> 
> When w6 == w7 is true, the verifier can deduce that the R6's tnum is
> equal to (0xfffffffe00000000; 0x100000000) and then use that information
> to refine the bounds: the tnum only overlap with the u64 range in
> 0xffffffff00000000. The reg_bounds selftest doesn't know about tnums
> and therefore fails to perform the same refinement.
> 
> This issue happens when the tnum carries information that cannot be
> represented in the ranges, as otherwise the selftest could reach the
> same refined value using just the ranges. The tnum thus needs to
> represent non-contiguous values (ex., R6's tnum above, after the
> condition). The only way this can happen in the reg_bounds selftest is
> at the boundary between the 32 and 64bit ranges. We therefore only need
> to handle that case.
> 
> This patch fixes the selftest refinement logic by checking if the u32
> and u64 ranges overlap in a single value. If so, the ranges can be set
> to that value. We need to handle two cases: either they overlap in
> umin64...
> 
>   u64 values
>   matching u32 range:     xxx        xxx        xxx        xxx
>                       |--------------------------------------|
>   u64 range:          0                xxxxx                 UMAX64
> 
> or in umax64:
> 
>   u64 values
>   matching u32 range:     xxx        xxx        xxx        xxx
>                       |--------------------------------------|
>   u64 range:          0          xxxxx                       UMAX64
> 
> To detect the first case, we decrease umax64 to the maximum value that
> matches the u32 range. If that happens to be umin64, then umin64 is the
> only overlap. We proceed similarly for the second case, increasing
> umin64 to the minimum value that matches the u32 range.
> 
> Note this is similar to how the verifier handles the general case using
> tnum, but we don't need to care about a single-value overlap in the
> middle of the range. That case is not possible when comparing two
> ranges.
> 
> This patch also adds two test cases reproducing this bug as part of the
> normal test runs (without SLOW_TESTS=1).
> 
> Fixes: efc11a667878 ("bpf: Improve bounds when tnum has a single possible value")
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Closes: https://lore.kernel.org/bpf/4e6dd64a162b3cab3635706ae6abfdd0be4db5db.camel@gmail.com/
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Hi Eduard,

This patch fixes the test case you reported and a couple variants:

reg_bounds_gen_consts_s64_u32/(s64)[0xfffffffe00000001; 0xffffffff00000000] (u32)<op> S64_MIN
reg_bounds_gen_consts_s64_s32/(s64)[0xfffffffe00000001; 0xffffffff00000000] (s32)<op> S64_MIN
reg_bounds_gen_consts_s64_u32/(s64)[0xfffffffe00000000; 0xfffffffffffffffe] (u32)<op> 0xffffffffffffffff
reg_bounds_gen_consts_s64_s32/(s64)[0xfffffffe00000000; 0xfffffffffffffffe] (s32)<op> 0xffffffffffffffff

but we're not out of the woods yet. While running reg_bounds* tests, I
noticed a few other unrelated failures.

---

reg_bounds_gen_consts_s64_u32/(s64)[0xfffffffe00000002; 0xffffffff00000000] (u32)<op> S64_MIN+1

This one hits an invariant violation on an impossible branch and the
bounds are set to an incorrect value that doesn't match what the test
expects.

  19: w0 = w6                ; R0=scalar(smin=0,smax=umax=0xffffffff,
                                         var_off=(0x0; 0xffffffff))
                               R6=scalar(smin=0xfffffffe00000002,smax=0xffffffff00000000,
                                         umin=0xfffffffe00000002,umax=0xffffffff00000000,
                                         var_off=(0xfffffffe00000000; 0x1ffffffff))
  20: w0 = w7                ; R0=1 R7=0x8000000000000001
  21: if w6 == w7 goto pc+3  ; [...]
  [...]

  from 21 to 25: R0=1 R1=0x8000000000000001 R2=0x8000000000000001 R6=0xffffffff00000001 R7=0x8000000000000001 R10=fp0
  [...]

  ACTUAL   TRUE1:  scalar(u64=0xffffffff00000001,u32=1,s64=0xffffffff00000001,s32=0x1)
  EXPECTED TRUE1:  scalar(u64=[0xfffffffe00000002; 0xffffffff00000000],u32=1,s64=[0xfffffffe00000002; 0xffffffff00000000],s32=0x1)

W7 is equal to 1 and, given R6's ranges, cannot be equal to W6. The
condition is always false. On the true branch, the verifier thus
incorrectly refines R6's value to 0xffffffff00000001.

This is a new type of invariant violation (i.e., involving the tnum)
that is not detected by range_bounds_violation(). I'm expecting it will
be handled by Hari's followup patchset. I've shared the program with
Hari so it can maybe be used as a selftest. I'm guessing we're fine
waiting for that fix as it's not failing in CI; if not, we could do a
quick fix in the verifier.

---

reg_bounds_gen_consts_s64_u32/(s64)[0xffffffff00000002; 0] (u32)<op> S64_MIN+1

This one fails because reg_bounds' branch detection logic doesn't match
the kernel's.

  ACTUAL   FALSE1: scalar(u64=[0; U64_MAX],u32=[0; 4294967295],s64=[0xffffffff00000002; 0],s32=[S32_MIN; S32_MAX])
  EXPECTED FALSE1: scalar(u64=[0; U64_MAX],u32=[0; 4294967295],s64=[0xffffffff00000002; 0],s32=[S32_MIN; S32_MAX])
  ACTUAL   FALSE2: scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
  EXPECTED FALSE2: scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)
  ACTUAL   TRUE1:  <not found>
  EXPECTED TRUE1:  scalar(u64=[0xffffffff00000002; 0x7fffffffffffffff],u32=[2147483648; 1],s64=[0xffffffff00000002; 0xffffffff00000001],s32=0x1)
  ACTUAL   TRUE2:  <not found>
  EXPECTED TRUE2:  scalar(u64=0x8000000000000001,u32=1,s64=S64_MIN+1,s32=0x1)

It's failing with that error since b254c6d816e5 ("bpf: Simulate branches
to prune based on range violations"), but was already failing before
with a different error (unexpected range). The root cause seems to be
that the test runs into an invariant violation, here as well.

We'll probably need to update reg_bounds's branch prediction logic to
match what the kernel is now doing. I can look into this next.

[...]
