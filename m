Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3D37C10A
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405093; cv=none; b=plmEQl52KJi+ocdpEeifbGv/YLtIIwIeYiOuAznc5KxSGQrh+Uc9h7lffkByzAFh6Datk0YOLJCKL6RM915uXAlFD+H76QYEAAQODVhwhZK/iv/RLs2plidZJcuNBe2ml9IJzrF3d4BPOEr/hYn2+DJ744oITTfGDRmXKcMZ2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405093; c=relaxed/simple;
	bh=xr4LRysHR4iFKDuq9pUL1jIWbfLhfza8c6tQMFMW6YI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MyIJtNVFhdaJC8AZ/4uAntpAbLVlXK7QIRYVjWx9GqUa73KL3B+I3ye7iudyk4t9+GXdm9hZ4VF1aaa0f7hpSgoDIrBoOj+L4MxrhU/SUucE5wfdui04kIZ12q0qGdPJoH1Bi9Z7Yzze1ToL5TONR5zwiNeMs/lc1URN/J1tXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKJFwKa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKJFwKa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF0E1F000E9;
	Mon, 10 Aug 2026 23:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405091;
	bh=JmDObI7kAJQzue8TxhoOwkR5xu98BxtAgaeTSvHgkCc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QKJFwKa9lFeOS+8QVzYdMXj3JStr9rlbPrrIRLFq9w4PHa6Htho5owfy3KVIYALgq
	 4ooLYMCLxwEUI4XmZ7BfRG6Z25lS3wxHsGwZ6xsjiRIYA89rWZ1dlTsneouwCQSojC
	 /x+jIZrRMgD28DV/uNf8OxY7/7wf9C17ma9XEsMWsO7fWeIGwujyDc62AuDl6U8Ti1
	 UC3CPDTM/gv6yF0u9VM550NHB53+aIa/iq7C56/wLHWT0AyQ/ng5U1Z2M1aHQJLpw3
	 NRq8Z+CgXcEowjmPBcDdiopwPsURkNm3HNkwlA7p9SPbIKmR6yRcoxUhPxc7u5bo2H
	 eISX9u8rV9Ngg==
Content-Type: multipart/mixed; boundary="===============7647468868833226400=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7da705ca01f2e33034afa325b543583f7458d8061e64c18584eeb787fe83d15d@mail.kernel.org>
In-Reply-To: <20260810221811.481040-1-daniel@iogearbox.net>
References: <20260810221811.481040-1-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Derive the atomic load register in one place
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: eddyz87@gmail.com,puranjay@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 23:38:10 +0000 (UTC)

--===============7647468868833226400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 4edba8182db1b..15d83684c6e94 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -414,6 +414,30 @@ static inline bool bpf_atomic_is_load_acq(const struct bpf_insn *insn)
>  	       insn->imm == BPF_LOAD_ACQ;
>  }
>
> +/*
> + * Given an instruction @insn, return the number of the BPF register that a
> + * BPF_ATOMIC reads the value at its memory operand into, or -1 if there is
> + * no such register. That is the register a BPF_PROBE_ATOMIC has to clear when
> + * the access faults. Like bpf_atomic_is_load_acq(), @insn is not assumed to
> + * be a BPF_ATOMIC here.
> + */
> +static inline int bpf_atomic_load_reg(const struct bpf_insn *insn)
> +{
> +	if (BPF_CLASS(insn->code) != BPF_STX ||
> +	    (BPF_MODE(insn->code) != BPF_ATOMIC &&
> +	     BPF_MODE(insn->code) != BPF_PROBE_ATOMIC))
> +		return -1;
> +
> +	switch (insn->imm) {
> +	case BPF_LOAD_ACQ:
> +		return insn->dst_reg;
> +	case BPF_CMPXCHG:
> +		return BPF_REG_0;
> +	default:
> +		return (insn->imm & BPF_FETCH) ? insn->src_reg : -1;
> +	}
> +}
> +
>  /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
>
>  #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 661e2d13a6042..c4bd70befbb5c 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -49,16 +49,7 @@ static int insn_def_regno(const struct bpf_insn *insn)
>  	case BPF_ST:
>  		return -1;
>  	case BPF_STX:
> -		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
> -		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
> -			if (insn->imm == BPF_CMPXCHG)
> -				return BPF_REG_0;
> -			else if (insn->imm == BPF_LOAD_ACQ)
> -				return insn->dst_reg;
> -			else if (insn->imm & BPF_FETCH)
> -				return insn->src_reg;
> -		}
> -		return -1;
> +		return bpf_atomic_load_reg(insn);
>  	default:
>  		return insn->dst_reg;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index add3affc57035..73a2e8bb1782a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6485,21 +6485,16 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>
> -	if (insn->imm & BPF_FETCH) {
> -		if (insn->imm == BPF_CMPXCHG)
> -			load_reg = BPF_REG_0;
> -		else
> -			load_reg = insn->src_reg;
> -
> +	/*
> +	 * A negative load_reg means that this instruction accesses a memory
> +	 * location but doesn't actually load it into a register.
> +	 */
> +	load_reg = bpf_atomic_load_reg(insn);
> +	if (load_reg >= 0) {
>  		/* check and record load of old value */
>  		err = check_reg_arg(env, load_reg, DST_OP);
>  		if (err)
>  			return err;
> -	} else {
> -		/* This instruction accesses a memory location but doesn't
> -		 * actually load it into a register.
> -		 */
> -		load_reg = -1;
>  	}
>
>  	dst_reg = cur_regs(env) + insn->dst_reg;

This isn't a bug, but since the point of bpf_atomic_load_reg() is to keep
this derivation in one place, would it be worth converting the remaining
instances in const_fold.c and liveness.c as well?

Both files have the same three-way BPF_CMPXCHG/BPF_LOAD_ACQ/BPF_FETCH
mapping behind a BPF_STX + BPF_MODE == BPF_ATOMIC guard. In const_fold.c
around line 204-209 it marks the register as unknown, and in liveness.c
around line 1212-1217 it marks the register as none. Each could read as
'int r = bpf_atomic_load_reg(insn); if (r >= 0) <clear r>;' instead of
repeating the switch.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31438625403
--===============7647468868833226400==--
