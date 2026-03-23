Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C418939A047
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267965; cv=none; b=XiUtDwiCIQpNTeGO8Rjihdb2eN9U0wlHTyiibdS7dXBMIWFqgu4AJjtn7JhfIaHEF0d+F1pFho8hdUJKEiRnWnu+3SPrikqXjh9qfnU7JmNXfLtNDZt9tipUCy0wYX/Ci1kEm2MGGpEbDf4m0/8xK3FNSxxbQRlki5kcq8Ha9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267965; c=relaxed/simple;
	bh=G9ixPhvBqPPIlQcDw6zmx1J6a3IMqhxyWG9gf7DETi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB5wqWE86ep2XtTr+7vj+OA8P2ejGnlQtnCkTvMfEU0u2CH+Fmkc4D5rxWCCQixnOOZVO9s3/heWwZ4DKcTnRbxNb0KJ4xcaKosySynZE8lpsvRCE6Oge+PvANC1P6HnshvHFyPKsTJBAZmTHW8vfvyS+XrAMoEPJMQvCoNTqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZCPpt4bm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZCPpt4bm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso47643335e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 05:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774267962; x=1774872762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJv2VaNVmDYHoN0i0HOacz1PHY0sr9ffrSaK1baeJaQ=;
        b=ZCPpt4bmFAGWRYN4SYnZvmURvoUV294do18s/k1nv8drD4zSIf4SafRvJjlQGvOCLq
         Wxo0A4pzloeiWGEmy7tfXgWgYqlDk3Df+od45p0eEgakhUga1fMbxYWOAdidT/btG/u1
         XZRxAGNgK6+m9Wa00jbJXedGsywP5w+4wtG+WZfD8vTBCz5cHj8iHue9amL4q0YMQ9vt
         Z/I0ksN63YdgwX7eaIQqa3krlJrtT/AZ2GZKbYWNlNXKN5T/caedSC3ptaLxIMupbgFR
         heG9h7an2djmYv5yEcL6mwhpd54ZNzmjxL/qGM8AIOF++TIMdhAaR9NLPYNgJa2a0j3F
         pQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774267962; x=1774872762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJv2VaNVmDYHoN0i0HOacz1PHY0sr9ffrSaK1baeJaQ=;
        b=FUT4+Bm/LiCyNCVsBvSIIB4Al+E+QLs44XLHU1MxRHozXcPmzs094onzV16IJm9EcP
         3yMJwVeGBx8yHFk9ZW5MHBTUchUhKWEbl1ple63KmAB4Yixzqm6/JDAMs2H0qzPVwX3+
         Y4annt6N48RBEH7+yD1huSHhF3oiPptlYfOEJdzIw1C9NhhF6yYHlrD9RUg0buDgxCOL
         Ti3Ynv9T/DvdeROFoCaFqRhuX5vB/vg8HJSpoWYck7/4BKTtf5rFyV7nUw/q0IrU1UQs
         kTSUCnzoDh+bvlmdO+xgOsoWbW+rcqW5AxYlYI1wUh3f26GPy9W4+5bia6a0ReUrXHYY
         Qh9w==
X-Gm-Message-State: AOJu0YxHHSSPPgsezgq6+w073jxlhhT+KDFLkYzmt/dzbu7FKuaf5i3w
	5wujrwoZA9gmovWWL6uEGbpSDDguzH+IZq6Ux0aGJ33sc5TSFX7uf+YEtEtwyFuGNKo=
X-Gm-Gg: ATEYQzyMY4hD0M+xzPNegZtiAbY/B5GIdcIPNi9RlOiqpC6AaVS88qhbE/SpJkd8SAx
	5hSgHndvCONmLp82BGD8tS4yBJ4ZMNsmBsPhVrPjpGFHTdt4+i6G3XYmdvi/w7IKgbTJFlD4Jl+
	G1YfyYflHDPzxXMEHWSBgI0JwkYlOiY5MMi+zkYhauWMfaF2EL+Jn6SNeKm7dRXM4Kjs4Wh3VS1
	ddGo4vqiFs0E5hRh70pTFRmG3NCR84zmD4wxv5FBf065vmQk2Q9WHBFN2cutK6dSUOeNq9BO/9T
	1bGMBiV3zTj5tAoHg8azH6qPnyOzg2Yngrn87YtTH74AvrHqisSM/vUavhYW2bEEU98gjURd4X5
	N5dry27k176sNQbKHgMA3jl70kqHSNxc/I5SDR5hiPaNtpJNNoH1Xh7XziGGOzUWT1wfcSX0fLM
	nW5KNQUuUEEs2qMSu7XEcTkdTs4eAodr+u6eZdwJe2/yzSqE9lBg47nUh0kwdowilx5aXGqtI4C
	U5X0Wt7aB3AZBWa6Fl4
X-Received: by 2002:a05:600c:ad1:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-486f8a9eda0mr182748215e9.0.1774267962026;
        Mon, 23 Mar 2026 05:12:42 -0700 (PDT)
Received: from u94a (2001-b011-fa04-7ee6-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:7ee6:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b8b95sm110748985ad.83.2026.03.23.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:12:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:12:33 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
Message-ID: <tg73xy4pml4rvriysppziwm6nxzgmfih2mqkvla5wl2coqbqut@ioj7ltsfrslm>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <704bf39f66a98877f66a4982c77cddb42f14fc82.1774025082.git.paul.chaignon@gmail.com>

On Fri, Mar 20, 2026 at 05:49:30PM +0100, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> 
> In the subsequent commit, to prune dead branches we will rely on
> detecting ill-formed ranges using range_bounds_violations()
> (e.g., umin > umax) after refining register bounds using
> regs_refine_cond_op().
> 
> However, reg_bounds_sync() can sometimes "repair" ill-formed bounds,
> potentially masking a violation that was produced by
> regs_refine_cond_op().
> 
> This commit modifies reg_bounds_sync() to exit early if an invariant
> violation is already present in the input.
> 
> This ensures ill-formed reg_states remain ill-formed after
> reg_bounds_sync(), allowing simulate_both_branches_taken() to correctly
> identify dead branches with a single check to range_bounds_violation().
> 
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

Thought given reg_bounds_sync() is used if various different places, I
wonder how this will affect current syzbot reporting. In comparison the
rest of the patchset seems to try to preserve current behavior.

Being nosey, I also look at the Sashiko review[1], which gave the
following review:

  Does returning early here expose invalid bounds to
  reg_bounds_sanity_check()?
  When regs_refine_cond_op() produces overlapping bounds for logically dead
  branches (e.g., umin > umax), reg_bounds_sync() previously repaired them.
  With this early exit, the invalid bounds remain.
  Will the subsequent call to reg_bounds_sanity_check() detect this violation
  and trigger a kernel warning via verifier_bug() and BPF_WARN_ONCE?
  Additionally, since reg_bounds_sanity_check() handles failures by marking
  the register as unbounded, could this cause the verifier to explore dead
  branches with unconstrained registers and falsely reject valid programs?
  While this is resolved in the subsequent commit "bpf: Simulate branches to
  prune based on range violations", could this intermediate state break
  git bisectability?

Given if we get invalid bounds in reg_bounds_sync() to begin with, then
there is no guarantee that what the BPF verifier ended up with can be
trusted at all, so returning early shouldn't introduce new safety issue,
and the rest about falsely rejecting valid program doesn't seem like a
concern, too, for similar reason.

1: https://sashiko.dev/#/patchset/cover.1774025082.git.paul.chaignon%40gmail.com

...
