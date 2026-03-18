Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9C1C3BF7
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796625; cv=none; b=ZC663Covt8qQOSguB+99Z9XjpS6XS7oblVbglFUt+2R682gfQG3xfrHO4Nzf/zceC/zTSX1eF0sE7LLs7+PyPiqz4IReSs61W3PB/c9h3TSTMP63IyeorgrOo4kn3CIsODYIhr9SAocUARrhBi91Qoe4Wnhy896oUXpotjBeiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796625; c=relaxed/simple;
	bh=DTeTh9HkFr1HwIr/fpiM8wwGmtDhm73tDpmPlqYuDEY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DQIrCT5Of0bcLMg3IZSrUOqgiPE+sgjGvXtR+7l9/3ctgTSaJnwDK9uRQElOeeQfpHVouRzMWirBht0DCJkwRmL+cl2gnkEUnWJlSEFzE2TDIGFIhkmRIVlDiS3wQFK/wB+ZBcyiaq3ni+16B945+PPEs38InjuEQspEi+jEyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9K+h3/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9K+h3/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7F0C4CEF7;
	Wed, 18 Mar 2026 01:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773796625;
	bh=DTeTh9HkFr1HwIr/fpiM8wwGmtDhm73tDpmPlqYuDEY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=V9K+h3/eXjWwToBl8P1rNYSD6gUg/pF4GAjvCZNiEk86RtCx/+O5hIKTcPuBuJIzN
	 4JdsfS/cEudT9LK1hzHorGWRn7yr5MA+HqcylZJguCuZBxZb+oOkotMhBFmZyBN31I
	 v5biFVhAySC1sUipN/MWum26hGR00IkzsZ1AFBcAzDBBy39wy6Z05/jw5ZTLTU4wXK
	 +Lh817ZtKS6VKheoC7dFJG7WEfurd+HJxfVKsT/D1/jgR0r6NF2nHKswTzcQbaibst
	 4taFA5o9cdN2oWm4TjRgKH3vV05dreHmNYakYCd/tdgXvdZWy/EsC2PtlwRzGza6Ub
	 0Kfx/0zEZZNlA==
Content-Type: multipart/mixed; boundary="===============4354743106886035103=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ba36210cf90805c1099d9cd92f2c435237115e43681bb45ab74e8b841b5fd12@mail.kernel.org>
In-Reply-To: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
References: <20260318004118.1780755-1-ZeroXJacks@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
From: bot+bpf-ci@kernel.org
To: zeroxjacks@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,gregkh@linuxfoundation.org,jolsa@kernel.org,kpsingh@kernel.org,haoluo@google.com,john.fastabend@gmail.com,sdf@fomichev.me,martin.lau@linux.dev,andrii@kernel.org,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,shung-hsi.yu@suse.com,menglong8.dong@gmail.com,zeroxjacks@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Mar 2026 01:17:04 +0000 (UTC)

--===============4354743106886035103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 01c18f4268de..5e0fbeca8f37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> 		val = reg_const_value(reg2, is_jmp32);

[ ... ]

> 		} else {
> +			if (reg1->umin_value == (u64)val &&
> +			    reg1->umin_value != U64_MAX)
> 				reg1->umin_value++;
> +			if (reg1->umax_value == (u64)val &&
> +			    reg1->umax_value != 0)
> 				reg1->umax_value--;

When umin == umax == val and val == U64_MAX, the umin guard
prevents the increment (U64_MAX == U64_MAX), but the umax guard
allows the decrement (U64_MAX != 0). This leaves umin_value at
U64_MAX and umax_value at U64_MAX-1, creating an inverted range.

This state survives reg_bounds_sync() because
__update_reg64_bounds() recomputes:

    umin = max(umin, var_off.value)   -> still U64_MAX
    umax = min(umax, var_off.value | var_off.mask) -> still U64_MAX-1

and then reg_bounds_sanity_check() catches umin > umax, triggering
verifier_bug() which calls BPF_WARN_ONCE().

The scenario from the commit message (var_off with mask=1 after
JGE U64_MAX) reaches this path because is_scalar_branch_taken()
returns -1 for BPF_JNE when tnum overlaps but is not const, so
both branches are explored.

The same pattern applies symmetrically when val == 0 (umax guard
fires, umin proceeds), and to all the s32/s64/u32 variants at
their respective type boundaries.

Would it make sense to handle this dead-branch case before the
individual adjustments? The BPF_JSET | BPF_X case in the same
function already does this:

    /* Forget the ranges before narrowing tnums, to avoid invariant
     * violations if we're on a dead branch.
     */
    __mark_reg_unbounded(reg1);

A similar approach here, or skipping adjustments entirely when
umin == umax == val, would avoid the verifier_bug() trigger on
what is an architecturally expected dead branch.

> +			if (reg1->smin_value == (s64)val &&
> +			    reg1->smin_value != S64_MAX)
> 				reg1->smin_value++;
> +			if (reg1->smax_value == (s64)val &&
> +			    reg1->smax_value != S64_MIN)
> 				reg1->smax_value--;
> 		}
> 		break;

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23223625211
--===============4354743106886035103==--
