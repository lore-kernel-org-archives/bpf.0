Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD0314B66
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857156; cv=none; b=LP8AcevHnqMR1sQZ24d/cfC++IDe+3+hussd6egeoC53o4qBLK1hJNYEUtqqgcb7WMRwi4J7imF1X+b93B2/noRDdWChQvnRG4MWKdtbwILJygiZpN/CkSvPlZ3gMp5lJjHmHeMzIExVj8pmQc9nv6I9NldmkKDNNB2IEfGDqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857156; c=relaxed/simple;
	bh=X40SVEH2EWLhnCWRnzxRODXQMz51jpsCoC6upNBmCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEd4oRFAVWMxQKQQfxOoC7EsXxab8Ksp9Iy38+P5YgTbAZ1mhbZfMZHBHgYdZwYwUlZNVdh8d0lTIpMC358wY6XsLD8OUaVUhCATfndFj7bf8+GnoX2Wjp1YwY73zGUnyW80/e0YIb95jtQjSM7VqAqfjXHyF5ER3ZbyTFsrhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqfhOZES; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqfhOZES"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so23942915e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775857153; x=1776461953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDaPIZ/IfHPIrwdv48VKeRjdYY9bTC02cJ29tbREoyM=;
        b=IqfhOZESj/29g4eHZp9NUkR5QtO5p6xXkzH0PB8WZd5eDLca2DqXBiZrxysEnE27HK
         6UkLx/7nbPHC77kxV+BfULj6Vv3UcVsBXITP5ydyxv86LUQA0iGLJrmXj8+hnfMWd6nT
         COBhUSVDV49Vvxd2QEYLpMqlWpVvim0yILF5vZRiFY8TV/GuE2Owv32lUy9yl+mEkDbX
         daDzhjRYlXvQn7J/nSlWe1qfTOd0Jsx4Xqixma6MynhoO5QldIje7qtOUEw3PmjlwvOF
         kn2IG5QfLZQxDaJanskME73GqNR7B2ZTDgyMD+fuV8I5BXHczXFsplkVu8A7F6PuUol/
         6bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857153; x=1776461953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDaPIZ/IfHPIrwdv48VKeRjdYY9bTC02cJ29tbREoyM=;
        b=T3vlYujj1Ol0rzWR6HJBSyTSGTGm5+MTXg3M1Y5WX+AjwMH7Z5if50V2JPPRLkd8c4
         gSY6cf3xVstt0obrk7wpYr1sFCqWoxblBF8/mLhh6eNKfhz7Nbmew0p9TpR+F7aXdjB9
         w18SWXYDIVBQOjT6RkCG2CxOZxjuHjgagcNS2fSsbJpTTTkNlfAl3TRkVr7djgc16g2n
         dP0zvvAIzwiWRyj1JOwcNQFNE0C6atil6u0oyVhdqpOWv867YclxbPxvtXs+Tv6S2BKG
         a768f0aRvbdt24dUJGL8Aere5Ra2cMbutolcXlBNtgWD3xYnb4RXKnHK+4yZFF/dGuWp
         7FpA==
X-Gm-Message-State: AOJu0YzxUumWsVlPz/Yp1QTxRbEJRW2rf7Z58Gtlm97nU1hBolYRXmhO
	xv+5NoPtbtNZIpnwCHjdgPvUmrhpyrUEsuho9PMzqp7aIA/40hX2BIPgjr17Su2c
X-Gm-Gg: AeBDietyaNNHqafD5v3xVA9WVJXHKPTaTxxPo2ekFzfiFITiEzPY1W8VirXpxkjpFDy
	JDpSgHAqq/vGr1dyx+xtrVITOtdDwZ454hGTv+lbIwN4pOe8PoFaA4FAINUafZk8DZglKIZly5j
	8gtGI1cTkb+pSpXLTpvZ0Ny2k/m2s1/2E1a7P8GiNLl2zUd3/MQcUHGt+eGLMjLIulOnqZO3DAV
	2sBicNuCCgq4pFJUFcr4PL7AjlLQ+7NmIxhLu0IBq1yZMsDEN5QSO2dwTs9Ie3C3wn3ockmaSb1
	xrq+xYtiUYsTz8rlluq8DGwjAKUG4K+e3/F7Mmhn12dQmQoRJa7GHN7b2YTp5QW8w6vlbfkQM8d
	LE3YNmklbiOjCABzWPaLYOlRX21Dwwm+0ONPwQkRxUaVNrdEKMeyRy7VsL39ITqs7RoEuJ19+co
	mzgI3xq5svBj8DUI3iZvh/MsrnyB8hGC/qeBIl+OSY6fIaP00YZv0sIUlv8u0iFrPCdD8U7VRwB
	cSrkX/F0rPXPY9ysMySXFpIc4+ES1uGPwBMCQEnFBvpBx9L7z6G8PvRTP6xwrddyQlwqsNoXu+f
	lsbpHeE4XENpb0J7ZXwb7Yqkra5rbg==
X-Received: by 2002:a05:600c:3b29:b0:486:fbf6:abd4 with SMTP id 5b1f17b1804b1-488d67d24cbmr60170805e9.9.1775857153172;
        Fri, 10 Apr 2026 14:39:13 -0700 (PDT)
Received: from Tunnel (2a01cb01206cfcf44e874a0c0620d58e.ipv6.abo.wanadoo.fr. [2a01:cb01:206c:fcf4:4e87:4a0c:620:d58e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e51600sm10128900f8f.32.2026.04.10.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:39:12 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:39:10 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/14] bpf: simplify liveness to use
 (callsite, depth) keyed func_instances
Message-ID: <adlt_kFLi-rA_zTR@Tunnel>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
 <20260410-patch-set-v4-9-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-patch-set-v4-9-5d4eecb343db@gmail.com>

On Fri, Apr 10, 2026 at 01:56:00PM -0700, Eduard Zingerman wrote:
> Rework func_instance identification and remove the dynamic liveness
> API, completing the transition to fully static stack liveness analysis.
> 
> Replace callchain-based func_instance keys with (callsite, depth)
> pairs. The full callchain (all ancestor callsites) is no longer part
> of the hash key; only the immediate callsite and the call depth
> matter. This does not lose precision in practice and simplifies the
> data structure significantly: struct callchain is removed entirely,
> func_instance stores just callsite, depth.
> 
> Drop must_write_acc propagation. Previously, must_write marks were
> accumulated across successors and propagated to the caller via
> propagate_to_outer_instance(). Instead, callee entry liveness
> (live_before at subprog start) is pulled directly back to the
> caller's callsite in analyze_subprog() after each callee returns.
> 
> Since (callsite, depth) instances are shared across different call
> chains that invoke the same subprog at the same depth, must_write
> marks from one call may be stale for another. To handle this,
> analyze_subprog() records into a fresh_instance() when the instance
> was already visited (must_write_initialized), then merge_instances()
> combines the results: may_read is unioned, must_write is intersected.
> This ensures only slots written on ALL paths through all call sites
> are marked as guaranteed writes.
> This replaces commit_stack_write_marks() logic.
> 
> Skip recursive descent into callees that receive no FP-derived
> arguments (has_fp_args() check). This is needed because global
> subprogram calls can push depth beyond MAX_CALL_FRAMES (max depth
> is 64 for global calls but only 8 frames are accommodated for FP
> passing). It also handles the case where a callback subprog cannot be
> determined by argument tracking: such callbacks will be processed by
> analyze_subprog() at depth 0 independently.
> 
> Update lookup_instance() (used by is_live_before queries) to search
> for the func_instance with maximal depth at the corresponding
> callsite, walking depth downward from frameno to 0. This accounts for
> the fact that instance depth no longer corresponds 1:1 to
> bpf_verifier_state->curframe, since skipped non-FP calls create gaps.
> 
> Remove the dynamic public liveness API from verifier.c:
>   - bpf_mark_stack_{read,write}(), bpf_reset/commit_stack_write_marks()
>   - bpf_update_live_stack(), bpf_reset_live_stack_callchain()
>   - All call sites in check_stack_{read,write}_fixed_off(),
>     check_stack_range_initialized(), mark_stack_slot_obj_read(),
>     mark/unmark_stack_slots_{dynptr,iter,irq_flag}()
>   - The per-instruction write mark accumulation in do_check()
>   - The bpf_update_live_stack() call in prepare_func_exit()
> 
> mark_stack_read() and mark_stack_write() become static functions in
> liveness.c, called only from the static analysis pass. The
> func_instance->updated and must_write_dropped flags are removed.
> Remove spis_single_slot(), spis_one_bit() helpers from bpf_verifier.h
> as they are no longer used.
> 
> Signed-off-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

I tested this series with Cilium's complexity test suite [1]. We have a
lot of different configuration and some producing larger programs than
covered in the cover letter.

Overall, the impact is quite good. It reduces the number of processed
instructions by more than 60k instructions for some of our largest
programs. It also increases the number of processed instructions by up
to 20k in fewer other cases, but I think it's manageable because they
are not the largest programs so we have some room. The mean diff over
all programs is a reduction of a few thousands processed instructions.

For good measure, I also ran this patchset through a subset of Cilium's
CI. All looks good.

For the whole series, but probably only needs to be applied for this
patch:

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

1: https://pchaigno.github.io/test-verifier-complexity.html

[...]

