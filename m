Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A61A9B46
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693660; cv=none; b=Rk7H5Lb895Cp+j1KbIEm1ZTewBxZhpkWY44OzGVXec5SKkPdlKcRHrkJu7OWVU3lS3cqOhAldlNrDtg2xtogEL/NREhRfQozoHrAIsuTGhWo56Z8Un0PE5ArCLuisHp9X8gHuW891vddKEOkU5hrzRuLewlg7dzRYLfp2cWSlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693660; c=relaxed/simple;
	bh=ukCKm+qhBiz6hVo/G6YRUBCbPdbm5E8/m01uUrJI8UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM0coul/8ZBJpe2XHCWwC3r1aCp/lSS3lLL0qbBQK/KGi1apzSgFAJykymnGG6xKD+ecQMEld9h7551j/TT0X1/T2vBci7MCk+zF/wCxvE8r/wZ6m1k4e1W7tIYyRHOX0ra7oIUSJLSar8qLHze8MUsoyLY5z7jieJN2hwzf+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HSxQCQft; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HSxQCQft"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso64649635e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 22:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772693657; x=1773298457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z/KJ4kNw+0NGrLuccIsZ6fMrdhnAMn1U5m0OPOPzqE=;
        b=HSxQCQft7iDCWYe4N7ihm7yYQy0dbHPIi+wi3pCoOkfPf/+UuG2Ipx96le256BAlDd
         hCX+4oBj3fspUHmJVRz3U9Qkrk4nUZoprFELWm//yMrrrhHMx4j1c3WhqRyZRA7KYb56
         DoKKre+SwYww3J3culUPcoGB6B5qvyQdFew2+rq4Ushm0q54AMpl/75LFf5m3WLt8dFz
         UicGg7xjFDlcEeEQrO9lK48gykqANax0V/Bb9UtxGbuQ26xI6jxic3KE4CGu5CDoUl9W
         6P8R5rnJb5owdvqmTou5Umj8yqA8smuyr8N62nZ1y8WsZpEiAq5WbQ7ZoX06BT8pLzBU
         WlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693657; x=1773298457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z/KJ4kNw+0NGrLuccIsZ6fMrdhnAMn1U5m0OPOPzqE=;
        b=ekf0ituf5V1VpWaqVO7VKHb/EBtYR4DarWym3YySsDLciQuTLdKXhm61ewdbPpTfxn
         mip4Yt7Hpq2z8IVYhVg+O1ey2ynYjNFZV/mJ64eJufmsl/jVIma/bbWY+UO3t8neaMRz
         SrDxFh+OHlOVpP/5Qur32rjr/sRbIW/qA2QldqYV5rKGqGnkwJ3zq4x6rkpmHA9sD1sD
         QJTdNaDYc7GZh1s3lQStRzEo2m8sd61vszfyl7w7idDCtCHYtxYy/uCHzwUQ0nDVVSK9
         UfJWBUN+UT8T3oAMHmea+wPJZs5EMJ01+dvXdncW35z8wwbNOUM7XlhGTCzDGNaRCLzx
         GRHw==
X-Forwarded-Encrypted: i=1; AJvYcCU6u9ID7+oV+3uWlSndK8l88jnWn+f/ZfjxH6t/j9cSEjXIXWOzaNd3tQZG+eMxSKuAYxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySaZJ1nS48jO994Kmk231xGOz1KwS9dOd6p0Ivh+iodEoTpn3t
	4NMkKjgcM8OWGGChoEVi7nAwnIjGv4iCFfgz0fbQ0RwdCL3jr24HVtGsA8NqLGGSSGU=
X-Gm-Gg: ATEYQzz9c9CEMFsZJ9bNDb4D6Aeb5TCSrtxqydqc5yV5loyNlvh928pI/I/yYLtIiei
	t3LOZBOBn8nVQrxu2kknlQmo59RFlLv4sIIq2mOUvFlIv6tBtKmOhcNJNPIhnhXAi+hOmfQMNlu
	TxWfQF1mNItOb1WdenhicMFul5U+oRQP/lIiEEceEsK4HbgOTH/FYqyTQ60R/Aj1LYc7y4izN7g
	lbF1K+OZp8v8rst0UbiouMqqfl5wDHC+WlB7rMf2AVf91sfu1umqHNrXDvv4DrCxBgLmdOKCKm6
	ayLGLSlnmRwwtd2cuTgS/yLZbKQpX9YOxwUHhJkjIkWOtcxIgfbS+95/L9sjdOrrj06LsXBzdJx
	rK9asyErLHxIhCd5YYE5ukjKsr6GP6+iJaK7Se8ZXem4xEWPPOiIaflqSW92M0sf3FffLXs5G/k
	yt9LUHem1WO5hPjnX44a2dt/WYwdU=
X-Received: by 2002:a05:600c:64ce:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-485198608e9mr81013575e9.10.1772693656679;
        Wed, 04 Mar 2026 22:54:16 -0800 (PST)
Received: from u94a ([2401:e180:8d64:d29:4e45:ea04:c978:dc5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6e190fsm223044395ad.82.2026.03.04.22.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:54:15 -0800 (PST)
Date: Thu, 5 Mar 2026 14:54:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>

On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
> On 3/3/26 11:27 AM, Paul Chaignon wrote:
> > In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
> > added a new round of bounds deduction because two rounds were not enough
> > to converge to a fixed point. This commit slightly refactor the bounds
> > deduction logic such that two rounds are enough.
> > 
> > In [1], Eduard noticed that after we improved the refinement logic, a
> > third call to the bounds deduction (__reg_deduce_bounds) was needed to
> > converge to a fixed point. More specifically, we needed this third call
> > to improve the s64 range using the s32 range. We added the third call
> > and postponed a more detailed analysis of the refinement logic.
> > 
> > I've been looking into this more recently. To help, I wrote a high level
> > sequence of all the refinements carried out in reg_bounds_sync. u64 ->
> > s32 means we used the u64 ranges to improve the s32 ranges.
> > 
> >     /* __update_reg_bounds: */
> >     tnum -> {s32, u32, s64, u64}
> >     /* __reg_deduce_bounds: */
> >     for (3 times) {
> >         /* __reg32_deduce_bounds: */
> >         u64 -> {u32, s32}
> >         s64 -> {u32, s32}
> >         u64 -> s32
> >         s64 -> s32
> >         u32 -> s32
> >         s32 -> u32
> >         /* __reg64_deduce_bounds: */
> >         u64 -> s64
> >         s64 -> u64
> >         {u64, s64} -> {u64, s64}
> >         /* __reg_deduce_mixed_bounds: */
> >         u32 -> u64
> >         u32 -> s64
> >         {s32, s64} -> {s64, u64, tnum}
> >     }
> >     /* __reg_bound_offset: */
> >     {u64, u32} -> tnum
> >     /* __update_reg_bounds: */
> >     tnum -> {s32, u32, s64, u64}
[...]
> Hi Paul,
> 
> (trying to do my part with the code reviews and learn in the process)

+1, still

> Side note: you might be interested to know that Eduard is working on
> consolidating signed and unsigned domains [1].

\o/

When I last look into this[1] there's was the "Interval Analysis and
Machine Arithmetic: Why Signedness Ignorance Is Bliss" paper[2] that
looks rather promising. And lately there was also "Program Analysis
Combining Generalized Bit-Level and Word-Level Abstractions"[3] (haven't
read) that seems more specific to BPF verifier.

> If I understand correctly from the pseudocode there is a dependency
> loop between *64 -> *32 -> *64 -> *32 -> ... and so on.
> 
> This got me curious, why don't we actually try to compute a fixed
> point here with a loop? If we were, we wouldn't have to guess how many
> iterations need to be there, and the order of the narrowing steps.
> 
> So I implemented a dumb loop in reg_bounds_sync() with a limit, and
> added global counters to collect stats. Pasting a (mostly vibe-coded,
> sorry) patch at the bottom.
[...]
>   $ grep bounds_sync tools/testing/selftests/bpf/veristat.log | grep -o 'max_iters.*' | sort -u
>   max_iters 2 avg_iters 0.09
>   max_iters 2 avg_iters 0.10
>   max_iters 2 avg_iters 0.11
> 
> This is across 400+ progs of various sizes. The vast majority of
> reg_bounds_sync() calls don't change anything (0 iterations), and
> those that do converge in max 2 iterations.
> 
> My interpretation of this (assuming I haven't messed up anything while
> experimenting) is that the situation you hit in [2] is rare. And I think
> it is safe to implement a loop in reg_bounds_sync() with a reasonable
> iteration limit (10 maybe?).
> 
> Am I missing anything that makes it a bad idea?

My (limited) understand that this would make verification of BPF
verifier with Agni[4] much harder, because it have to unrolls all
loops & branch based on the result. Having known number of calls and
no limited makes verification easy. Paul and Harishankar has a much
better understand there.

From a conceptual view, we're trading always the understanding of
fix-point convergence (or the potential to understand it); with a loop
subtle difference will be hidden away. Might be reasonable as a
security-hardening tactic, but seem to hurt the codebase on the long
run. That's my 2 cent.

1: https://lore.kernel.org/all/ZTZxoDJJbX9mrQ9w@u94a/
2: https://doi.org/10.1145/2651360
3: https://doi.org/10.1145/3728905
4: https://github.com/bpfverif/agni

[...]
