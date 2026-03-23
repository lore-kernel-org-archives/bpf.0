Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57439D6EF
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268620; cv=none; b=Bi27WmuZtP1M0Q2aTOOTJ90CZMJIEsBMGs8teLh5arbZV40Q+GiVmX4QsowMxlvrUm3HsymJrzWMMIJDirNVCcz2SmUGNee5Qu8P+EC0Gj7dHXNHYbEJU4cFJDZ1rufTsIFSivxyIE23RVm4ZsSIvVmrHdzBKnR8gI4vxrRJoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268620; c=relaxed/simple;
	bh=/lPaptTa9ONYDdCs6aw41RYxuMTuNeNfa5YxRQxWn84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQ0XNAhadkG+8nIN0jjAAWBwSrypPK7+fUpl/DOmOrNYeHOQihU3/KymaJvwLeXA1aDfQcT73GBRk+6aBbG+PuxCswvoEQGotVh9ehqhPWb3SHLzWLurll0LZGRi8SYlH6vYGbTNxGFtIE1T7t7d9czscMfGwOXpwW1XoxwIRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gt/ynNZA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gt/ynNZA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fe655187so36736205e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774268617; x=1774873417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgUhPID1XKvwITGkjGuOtdzgN4lB7YpI6bOfIoig5DA=;
        b=Gt/ynNZAgu1TiABFixD25gJFBoqgtRXPzLucvEMChngfL3EoQ4vOy3tR1nOjJbFJkt
         xZ3y0OAoKlIT/GLgwP2T6Ie0sv00QXYrpwVTu53lfJEhjlf7HbnK6i0Yt67TdUKfCNVC
         gIqtm7GYCYkuYUHSa/1WE5F5jYFCQ7QySluGzCEdd7GCsmtglPqwUU3AsqiZ3VcSmdNM
         ViGMth1BZQMJ4MDGzhHACJ8BmvBlsvKG7vxlSi/oWKjPssxMiEnmLB4cJJBNySvWeNpE
         Lnf+p0DgStwODybY2T5/rsNe0+ftoNpYwZSAV5BPPj0TlqfV5r0h2OAygWw7BPaqMChH
         NXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268617; x=1774873417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgUhPID1XKvwITGkjGuOtdzgN4lB7YpI6bOfIoig5DA=;
        b=fNKwa8xMPg19kSflVEi+bZyzv6L1Z9KS2WhvldFffzMMawFNd1Ap0sRrS1c3b/g5gA
         NA7i9RehNE6E+X97jK3DkjuDVuU9auS2l3VxGnYP/ozu/8g7r8kXlKQnzAv3BYOE6SHh
         mxjefixmvIOB98qyxa7PvVXEDNs1e3lg9z5K6XFAqWlWzvNVHuZ78vdpnmVDcgciG9OY
         lDfJqVqYluMUuRpevSTe9hxofNKrACHJFJJd4U8buIZ8hNHe3b82eH4AsvbPdAEeyngk
         9wyqDf2mI5fIMqtcbDTTaBn5Wgbs+nG/LraNjam3MYd+GvDVWbf9d1uo3VcAcBXLzUth
         BDSQ==
X-Gm-Message-State: AOJu0YzLZx+9wwyUqdF7GL74kS8Uu+StEfaHX8ZOSYYo9iEV8KdszbjW
	DEsqHOYOt0xbWY7UV/yw+brzzHTIgfaOGIpVk/Z2iq/09lIivE7mLE/JpxELE+vfFQo=
X-Gm-Gg: ATEYQzzGSH+shUtlpkyDcjbGGmnnYHdUqh0jAb+Gv9qYtPpnsS1TrjgL17zzcYejqQX
	AmN+bD9wSj0ZHS7dxV4BmYrqVniUG8aZBqVIHpii+9sXKLrUnZm2jkBCQoeZq9OOO/VekzOy4Jo
	532WNYVULTDU4qaiE2RC6ErJuwr1ywKGdd+Wsz9OWmBtkrAssuqa6eTF3Ap3yB+P8k354Sg6PT/
	QBcg8uc1Ex38AGw/DXuA8/IxWkZNHbo+abH+IZ1SAa27kDe5jyXjV6RXTNFN7QaUQFp+SI7ulYi
	RlgVA/guCokVQsszENur8fi1DINWpZTkIR8enN8s/HGHZdHAx2nRROr5a6FlE3tBtdWsKrrs0PT
	/NNvpCQUbaDt6ZXg7PP07NZ2/iv2QjKB8Rxm4GDtVLzqPdkd+8NAKPXT0dtAjxmCeZ5D0Hr140e
	5rGugjUDB+uy7oKuSDm/sc1CSeHj6oJJ82XViG6zbOyGRduaI/iFoe3Kfuz873XN2jzNtroku/v
	Bz7l2D3Tb0LWwouYEb5
X-Received: by 2002:a05:600c:4ecd:b0:485:3f58:d84 with SMTP id 5b1f17b1804b1-486fee30199mr156710435e9.32.1774268617057;
        Mon, 23 Mar 2026 05:23:37 -0700 (PDT)
Received: from u94a (2001-b011-fa04-7ee6-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:7ee6:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ab1sm147082645ad.5.2026.03.23.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:23:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:23:28 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based on
 range violations
Message-ID: <7vwyzvy7cwy2n4c52fcurg4dnv4bqijtovmkeh3zgu6ey266vc@dtt3r5usvev5>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>

On Fri, Mar 20, 2026 at 05:49:44PM +0100, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> 
> This patch fixes the invariant violations that can happen after we
> refine ranges & tnum based on an incorrectly-detected branch condition.
> For example, the branch is always true, but we miss it in
> is_branch_taken; we then refine based on the branch being false and end
> up with incoherent ranges (e.g. umax < umin).
> 
> To avoid this, we can simulate the refinement on both branches. More
> specifically, this patch simulates both branches taken using
> regs_refine_cond_op and reg_bounds_sync. If the resulting register
> states are ill-formed on one of the branches, is_branch_taken can mark
> that branch as "never taken".
> 
> On a more formal note, we can deduce a branch is not taken when
> regs_refine_cond_op or reg_bounds_sync returns an ill-formed state
> because the branch operators are sound (formally verified). Soundness

Nit1: would be nice to get a link or at least mentioning of Agni,
otherwise it is not obvious where this claim comes from. And that seems
like a healthy dose of project promotion, too.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

...
> +/* Learn more information about live branches by simulating both branches being
> + * taken using regs_refine_cond_op. Because regs_refine_cond_op is sound when

Nit2: while this statement is very specific, "sound" is a rather
uncommon vocabulary in current codebase, I see no such usage.

  $ git grep -A1 -ie sound -- kernel/bpf/ Documentation/bpf/
  Documentation/bpf/kfuncs.rst:   no warning will not be a common occurrence or take place without sound
  Documentation/bpf/kfuncs.rst-   justification, but it is a possibility that must be accepted if one is to

> + * the branch is taken, if it produces ill-formed register bounds, it must mean
> + * that the branch is dead.
> + */
> +static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
> +{
...
