Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8A33120C
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345186; cv=none; b=ZVNUBMAq51wpdq+RFujkYI9dx53JmAWlxdiwKRYyI5uIP1fBV/fz7ZiHMgkNUKeAoVSv5/aRhkcyYD1DNROJg2LFjxmFkJXKBZrUnqNk860W2ajkJAf7+1RphN+7DBdSgl92/JSp05lEMOeWPR+O/rZU2+OLxxm8GVDofV/WEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345186; c=relaxed/simple;
	bh=Qadx53QvWilhq9MDcNeTRMxY0QWQress4Ijir9giALk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsJOwUaNNz9uxRUJ+37Lt4OWG4PcFJ2PT+CuNkZ1gewuD5CHF9eEYi7It7xBNDkU+bldL+lE7ro47k4Vy7euajOa2HHT5+fcDpW41x+N0UfMkXKBGWclvumKDXMpJKiPZJC4QGBTRBpxppnZ3W/268WjpeJHZfx3h1wsRw52a6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToPTFPtr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToPTFPtr"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38df1889fb9so86927121fa.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345183; x=1776949983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv964ooOzYXB6W8HstVVTpZA3ZTxP4eNpwGTeBP2ByI=;
        b=ToPTFPtr0GZwWt0VjUOVCRd9noTugYkc4MugLuC0vQ3lm2e9CDwrTzFOsgNKxvQ4qP
         IyU0xY654VZXupzhKu7Ixjvvs5DMBsuh2Alnmu5nH2Z6VERLk2vT2wIkubUYYAzT+gH0
         4vxvJRBy8j+EkPZDpQrnmJk/bElsFL8sdZyy1xmeA8uAzjlxrovSpsiJ28hIiQ2hYCFI
         o+PndXxm8IHc7IefES2zf5z0lytVNH9GpNf/EJaLNL3a+47ZXw3q4/0JeZSXdrfNJnyH
         MpHItT+EFUGhXe4h9LqVXEbg5CulMHPqSA+IHW9vD3DEuYlvDY+oG5k3wOLWw3ckMHK5
         PqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345183; x=1776949983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv964ooOzYXB6W8HstVVTpZA3ZTxP4eNpwGTeBP2ByI=;
        b=k1yy2H2D1+wBeb4EONkhJkCS4P05NIPu+VaIpXeXB0Q8xY9S7Q9SHisEqFLrpLr/5f
         OeM8LFLUhP1R3/x0pb87SXAdOBe6OQt1N951BTwMA2sfW9Tcw5kO33+9PBDk7JkSDodK
         S9V7nSVt8x8snwl8sJlmrrCtoPilTQ8yDfgNb0ZqUQMWvfr+r/mbOjmpQFk4DvSg2gZY
         gQe4Fg/yEnBY2EAfcPSMcPjVOYsUg5/u5zV9GR48ZGpVRczzXUepBWyPy0b2yG+uoqj7
         uPnmLO6VQde0MaXAIX91BjqonlgGSR28+kvTHZCVi5p49DOTGkYkdbwGKnWsGA32pnkS
         nChQ==
X-Gm-Message-State: AOJu0YwXJxUbSlo/uLGOrJMY63E6YwX1STcbVNtrxWOpnVMW2TzAqxaZ
	vvTNoGdqOl0bumU7X5gkKAtJfopR2X8grFZQHO/t7YC4czbzA5fKn7aeEmrBSs2w
X-Gm-Gg: AeBDiesxOJPtxZJ8uyxMRGz1oK+dUiWZAC7hjk1TqZJaZr8t4FMZVZWgkh3N1PSu1UC
	LyFM0qeo7/xCgs4tahLojO2vVfDU7F6umXamAq3MMlyGjGPe1SjdxjCQojCgb/eul1AWd+cRJCo
	syTN7XhxjFLl3ehGu3eqx3sGN/Ps/HaagXIPOrCp4W9eWKu6LS46vUFJ0lC0ox+ZLvVQxALTRoy
	OZXGx73dhHH0NOZaVgChwtvdmXL3c/BwFdTvpUzeTsdpOrwPwu9CV7uAjQ3xQzL1HKAl4ERvApz
	+8Heslb4Zgsj6X51TtM8F3dq0z7ZHTgYZBySAmwLRv8JhozVu1a0JBQqJHItZ5gGpFDvvVqLPlA
	b5Rw4bfZBZLIHg8eXOpXKy0UhCbeGwwDfwC4okr0BaHGgP+K9VWDyvfIJ1VIP76qOO4/nIcOkxc
	/J64Mv8CHzSN1N9QYz8fq2zsd7YHM2qzzcdVBDE0LUAXH7vDEJmJ7xyKfEw5EoL0V39X84pw44o
	nJUja09PvdjxP63dUeumZZQdAwd1wagR9w7OYL5bLimHxhj8Ge4sRUwwEzFelcb5nsd6QVrG+Po
	IHXZosWypUG8s5jVq6ev74sP6JLrjCvNuoaZALbOC660kUlmj40tV5AgJ00lWjc=
X-Received: by 2002:a2e:be8b:0:b0:38a:4e7a:c236 with SMTP id 38308e7fff4ca-38e4be65235mr80004411fa.12.1776345182864;
        Thu, 16 Apr 2026 06:13:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b55a04a9836ebec0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b55a:4a9:836e:bec0])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e9ec2be19sm11472211fa.31.2026.04.16.06.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:13:02 -0700 (PDT)
Date: Thu, 16 Apr 2026 15:12:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Helen Koike <koike@igalia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH RFC bpf-next 5/7] bpf: Remove dead code from u32->*64
 refinement logic
Message-ID: <81b908c5d1212a3523c66758bea15187155ac74c.1776344897.git.paul.chaignon@gmail.com>
References: <cover.1776344897.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776344897.git.paul.chaignon@gmail.com>

This patch fixes an inaccurate refinement in the verifier uncovered by
selftest "(s64)[0x2; 0x100000000] (s32)<op> S64_MIN":

  19: w0 = w6                   ; R6=scalar(smin=umin=2,
                                ;           smax=umax=0x100000000,
                                ;           var_off=(0x0; 0x1ffffffff))
  20: w0 = w7                   ; R7=0x8000000000000000
  21: if w6 s<= w7 goto pc+3    ; R6=scalar(smin=umin=smin32=umin32=1,
                                ;           smax=umax=umax32=0x7fffffff,
                                ;           var_off=(0x0; 0x7fffffff))
                                ; R7=0x8000000000000000
  [...]

  =====================
  ACTUAL   FALSE1: scalar(u64=[1; 2147483647],u32=[1; 2147483647],s64=[0x1; 0x7fffffff],s32=[0x1; S32_MAX])
  EXPECTED FALSE1: scalar(u64=[2; 2147483647],u32=[2; 2147483647],s64=[0x2; 0x7fffffff],s32=[0x2; S32_MAX])
  [...]

Before the conditional jump at instruction 21, R6 has a minimum 64bit
value of 2. After the fallthrough, it's minimum value is 1; the 64bit
ranges grew. That should never happen after a condition: we learn
more information about the register so its ranges should only shrink.

This is happening because of the last refinement in
deduce_bounds_64_from_32(). Under specific conditions, we run

  reg->smin_value = reg->s32_min_value;
  reg->smax_value = reg->s32_max_value;
  reg->umin_value = reg->s32_min_value;
  reg->umax_value = reg->s32_max_value;

The 64bit ranges are thus updated even if the new values are less
precise. We should be using min()/max() instead, as done elsewhere.

Instead of fixing this refinement logic, we can just remove it. Indeed,
it's a special case of the new logic introduced above, in the same
function, by the previous commit ("bpf: Improve 64bits bounds
refinement from u32 bounds"). It corresponds to this case:

    u32:   xx             xx             xx             xx
         |---------------------------|---------------------------|
    u64: xxxx                                                  xxx
               ^                                           ^
               (s64)S32_MAX                                (s64)S32_MIN

Fixes: 9f5469b84577 ("bpf: Get better reg range with ldsx and 32bit compare")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bcf8a38a4d72..7ce3d979cd6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2318,44 +2318,6 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 			new_smax -= 0x100000000;
 		reg->smax_value = new_smax;
 	}
-
-	/* Here we would like to handle a special case after sign extending load,
-	 * when upper bits for a 64-bit range are all 1s or all 0s.
-	 *
-	 * Upper bits are all 1s when register is in a range:
-	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
-	 * Upper bits are all 0s when register is in a range:
-	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
-	 * Together this forms are continuous range:
-	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
-	 *
-	 * Now, suppose that register range is in fact tighter:
-	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
-	 * Also suppose that it's 32-bit range is positive,
-	 * meaning that lower 32-bits of the full 64-bit register
-	 * are in the range:
-	 *   [0x0000_0000, 0x7fff_ffff] (W)
-	 *
-	 * If this happens, then any value in a range:
-	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
-	 * is smaller than a lowest bound of the range (R):
-	 *   0xffff_ffff_8000_0000
-	 * which means that upper bits of the full 64-bit register
-	 * can't be all 1s, when lower bits are in range (W).
-	 *
-	 * Note that:
-	 *  - 0xffff_ffff_8000_0000 == (s64)S32_MIN
-	 *  - 0x0000_0000_7fff_ffff == (s64)S32_MAX
-	 * These relations are used in the conditions below.
-	 */
-	if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
-		reg->smin_value = reg->s32_min_value;
-		reg->smax_value = reg->s32_max_value;
-		reg->umin_value = reg->s32_min_value;
-		reg->umax_value = reg->s32_max_value;
-		reg->var_off = tnum_intersect(reg->var_off,
-					      tnum_range(reg->smin_value, reg->smax_value));
-	}
 }
 
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
-- 
2.43.0

