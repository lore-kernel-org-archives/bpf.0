Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6A4F55C7
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648186; cv=none; b=jbfwQTjG+mJI8ii/UhDVZC8U1OlpMCftP1261boREF3vHZLum1Ib2b4JvgtOLalvtXxo3Ts/dZ8Lq4o2aRdyi7YRe/RwC6Db4vDeu0xeVarFh3VumJvkR6Es5vb//Jl4x4OVpmbHzLUHqp/IutwXJaJl+ZtdJ56dzpxjr2ngNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648186; c=relaxed/simple;
	bh=8z8PosveR/Yh8C14doBiIRtfnsbjFZVCsIep8Jq8D1w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OT+o79Qct/TSIWFvz6dyiODADyjZ0iJlripI2L8m5q4tiDgsAixKIiUZvuE3sqQs8G9VgId5S2YTfi9qoaChgcXv+o/Rp8IpyduH4u9vH/lB+uYg23b/CTplMAoM/d2GrMdyNKRBUgMO7hjrbt5t1RkXF4AARcWp3Fc/tDvTUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERVQOPit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERVQOPit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FD41F00893;
	Thu, 17 Sep 2026 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789648173;
	bh=KyXMAJM1XnFYlnLh97YwXYsjoCHr8tk2suS17nzyzIE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ERVQOPit30dtefXpyj3+wfdme310f2HF8LZQoKfjEYkUdc7PENiWtdgcO9vUJLlmX
	 P20oucALoSaYUXcn+JSN3ivWCX3mMBGv3Ew4NrUMcmfHj2o0/tZsEt0KnvqtzoY8F/
	 Igxh3aat0i45wq54plrsHBzvoYQxw59HYbplB3JJwMTAyP/CqBSG5XgjpTgtTD+FlO
	 kIKxc+fX4sIQNS3aEICUhE1XOLLWJjvwtJhV57jV9DV+D9QBwMyjteonypJyFBb2nn
	 9NyWXNkzLVqgdE2ypkC+U4ktHcTA7Zco8A/4IdlA3pE3GvTLGk80mZndco1gP8PrTV
	 LZ3ovOZ7TpFRQ==
Content-Type: multipart/mixed; boundary="===============8858641052853572488=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <50e3a26862014530432aff8c80ffc734c63815b616dc01ea11b7ef1e1197e7d4@mail.kernel.org>
In-Reply-To: <20260917111127.3780880-9-memxor@gmail.com>
References: <20260917111127.3780880-9-memxor@gmail.com>
Subject: Re: [PATCH bpf v6 08/10] bpf: Assign lock identity to callback map values
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 12:29:32 +0000 (UTC)

--===============8858641052853572488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index bba5a727c6516..1aa245faa30e2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -46,17 +46,10 @@ struct bpf_reg_state {
>  		/* valid when type == PTR_TO_PACKET */
>  		int range;
>
> -		/* valid when type == CONST_PTR_TO_MAP | PTR_TO_MAP_VALUE |
> -		 *   PTR_TO_MAP_VALUE_OR_NULL
> +		/*
> +		 * For CONST_PTR_TO_MAP, PTR_TO_MAP_KEY and PTR_TO_MAP_VALUE.
>  		 */
> -		struct {
> -			struct bpf_map *map_ptr;
> -			/* To distinguish map lookups from outer map
> -			 * the map_uid is non-zero for registers
> -			 * pointing to inner maps.
> -			 */
> -			u32 map_uid;
> -		};
> +		struct bpf_map *map_ptr;

The new comment lists the register types that use map_ptr, but should this
include PTR_TO_INSN?

PTR_TO_INSN registers inherit map_ptr when they're created from a
PTR_TO_MAP_VALUE register of a BPF_MAP_TYPE_INSN_ARRAY map:

  kernel/bpf/verifier.c:check_map_mem_read()
    regs[value_regno] = *reg;
    add_scalar_to_reg(&regs[value_regno], off);
    regs[value_regno].type = PTR_TO_INSN;

and that map_ptr is dereferenced later:

  kernel/bpf/verifier.c:check_indirect_jump()
    map = dst_reg->map_ptr;
    if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->dst_reg))
            return -EFAULT;
    if (verifier_bug_if(map->map_type != BPF_MAP_TYPE_INSN_ARRAY, ...

kernel/bpf/states.c:regsafe() also byte-compares the union for the PTR_TO_INSN
case, meaning it relies on map_ptr.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35216153389
--===============8858641052853572488==--
