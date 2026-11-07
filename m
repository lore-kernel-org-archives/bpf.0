Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025189;
	b=IyVIer18rzKpxQqic/NQ0xEE8lzCbo/LW6xFAbVQylDdRp2a1wBNhj/MbtHoEXB0kQOU
	 i2Bf9WthFn9WvJf6bcNvi99Uxjh5Eiv1bVNM4sG7r8OHA/RXlm0uVee/0vEvVRD7IdhwV
	 gVzIOR2HhlcOuVkaPtLZXykSf+oHR1ZpO8/qCXKgEaPEpB+2LsO9n4vg65Ms/MqW6TZd7
	 A+dn97EXzfkK/1w3FOXajRJJH5bnHDJoAFuhJzSzg7KIz4lkEse1LlgXr4yJW6HKa7fvc
	 nOsMBM796SjAnJ5b6m1IwFgMxSYoCDpLaQxtWJVJVIhMHt1xhZ9XhY1O46V7jdfN4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025189;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ku/UEQAb7LiN8XRk7qECDwqucihhsWNByqWCK1HRm90=;
	b=K+6oj8kjkGKknng4FXXyTSqNZazKPk+/WfzRT+4mPHlphvJRCzyRbU7tOtbk8yfi2+tY
	 H+ABcjWq/WmozdVnipu2eVyrZ1zPuIbr4x/viFhRfd9xd4pvwt4QLH2V70JDkcPb2c2+e
	 VTY4Bjy/gIUpS9ySSsRWkJZtNl9ftRnq/b1s2KiRlvQcEG3MBS55ySLRpAbwEvHZsfY17
	 ObS2gAJs7LEn1Z+hlXIJDfvTKs5cpECdvZCyTdYInwmPQcyUsy8hRt7dsB3lIMrtZ3n5j
	 +WbcCraUX3HkUpStruj9a+K/gClHLulp9jcEvVg4TKU9wVcvAslleey+zuMmIUH7toQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZAou2Jw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C9606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZAou2Jw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC2B1F0089F;
	Sat,  7 Nov 2026 04:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025188;
	bh=ku/UEQAb7LiN8XRk7qECDwqucihhsWNByqWCK1HRm90=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kZAou2JwU2LCSGUogbybtp/O5+IHt1WhKyH9Lo0v+4DJH6znlvwufkLNQj8Y9KGTc
	 8lk37uNZmidjAvOBRiH3/h9zu90eDfF/Km8QsSjaQUWg3ikPJMQ8CPeoP+rJMDbr/Z
	 T0x1inKjUL9kU+RsE5ODdsrBln5X5F0es7D4w+Vo6LyOfc/QP7i0P/sg9n9v6jEcVs
	 XvLjlNzyMl9bhoKrVEcll5M3SCLXkVa1eNKU5ZgcyL8fEUc/uTkBXAD94FECartApy
	 JxAdbMpdm84ocVWemrnc38N14dm1PwEUQ1REBM3TSEdZYGUd5O9FJ4OacPuWW3QuoQ
	 3Ucyza/mymGyQ==
Content-Type: multipart/mixed; boundary="===============5162376912718975019=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e97ef2e8cc0107846c8df26cec99ef8f7f1537ea3b932ba5a75e12371390aafc@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-33-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-33-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 32/46] bpf: A loop is one iteration shorter behind the jump that counts it
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:19:48 +0000 (UTC)

--===============5162376912718975019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: A loop is one iteration shorter behind the jump that counts it

TL;DR: Possible s64 wrap when adding "moved" in bpf_clamp_scev_regs() may
leave a wrong base/step, so the verifier could drop values a register can
really hold; scalar_step_add() resets the step in this case.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -3887,7 +3933,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
>  clamp:
>  		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
> -		if (r == entry->iv_reg)
> +		if (r == entry->iv_reg && !moved)
>  			iv_bounds(&bounds, entry->iv_range);
> +		if (moved) {
> +			bounds.r64 = cnum64_add(bounds.r64, cnum64_from_srange(moved, moved));
> +			bounds.base = imod(bounds.base + moved, bounds.step);
> +		}

Can this wrap in a way that leaves bounds.base wrong?  linear_bounds() only
rules out signed overflow of entry + slope * (n - 1), not of the extra
"+ moved".  cnum64_add() wraps modulo 2**64, so if entry + moved + slope * k
crosses S64_MAX or S64_MIN, the signed value is off by 2**64.

When the entry is a constant, step is |slope|, which need not be a power of
two.  Then 2**64 mod step is not 0, and the residue computed by

    bounds.base = imod(bounds.base + moved, bounds.step);

no longer matches the values in bounds.r64.

scalar_step_add() in kernel/bpf/verifier.c handles this case: it calls
check_add_overflow() on reg_smin()/reg_smax() and resets the step if the add
can wrap, noting that keeping the step "requires 2**64 mod s = 0".

bpf_set_reg_range() installs the new base/step as is, replacing what the
register had, and reg_bounds_sync() then uses base/step to round smin/smax to
values congruent to base.  The intersection with reg->r64 does not help,
because base/step are replaced rather than intersected.  Could this drop
values the register can really hold?

Should this fall back to step = 1, base = 0 (or skip the register) when adding
moved to the bounds can overflow s64, as scalar_step_add() does?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============5162376912718975019==--
