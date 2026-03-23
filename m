Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB683B8937
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280024; cv=none; b=iSeUGj0je3GpJLapxrmGVDY8V1+kg6+XzzsOzjxm6GZiEIXHUQGltAn6fHcz6rEinjsiNzk5rg+YzsRlEdh8x3iqstzqv18kY74F5JvYLR8MIjlMSy1P2A6dD9moqAK2l01cGH7RFiGMbXEHjQzAJMMW9YrX8tfyOCqrk97yujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280024; c=relaxed/simple;
	bh=zvEh3H/y4ZJPQJ0s/097oODUzDXfvHIBC9AsJUKwSaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JTDZUHlUqS1sAbth1tP3wRTkdoCbHDWnQyoubNhUqyWIH5l/FDp8p1HKBFMK2OmcXt1mzP3BZNQUxC2UeyeEOvxlbd12g3cZXnmk9jqe2dn1zqf/bhcAFdIjdBWdQUv1XFzP5zEaknd09dNZVh2qrY16mVC+DpEjmX6YbQY5py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXETBS6O; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXETBS6O"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so412441f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774280021; x=1774884821; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AHyBQeKC71peZym8QtpGGXS0RvMc3ADTMqHW6Qa3XXw=;
        b=RXETBS6OPUkrWvUsG0YPZ7mll/VV1qLQICLbXgILSrHjeBo2IYJcZ5I4lxaYAcuCrH
         uMELw5ynRVaNEP0RMKiTqL8NKftjPf0FlVx9O5SDVH1r50pkLElS74iV92ZiVVj5Km/A
         sNRsByW3VQJCraEvb4xyMFo7Iw9hRerHba7fT1yc3xuH6NQjfQF7wi4B4qMi+0566QRD
         0MfQCGGdwbwekCNfMsspZxYesYLyFpq1QBRnieWx+ZK5ywBwAyzNGJ6O0j9rbEvfGdgC
         sZLlof3me7T+LPWHXuc2PPGblFNMvf/QIZTkROFz1T3B5I+N08d8I7lxs/LrMmJ6e0ls
         FzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774280021; x=1774884821;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHyBQeKC71peZym8QtpGGXS0RvMc3ADTMqHW6Qa3XXw=;
        b=CQUiCNJz38+8kinHO9vmFZKOhVYIL6/OOnb6eLv7HtymaXE4YEEPdXLa6mfj5DibZn
         RDbRMHL6hz/NUX/mgItk7zT9cTRB5BcsVfBMeJahloXREuF0C53ki8uBo9Tbrg/KHCNa
         V8IMsV6FJTsCM8FnhVfnWKEC8DlYp8uq2VEqhuZ3Pmy5Z5f9VmggEHsUm0v0VGPAKLxv
         vI4AfC8R/IAT3K/saNZ+keVBp4EIRzc/bePIulJU5wOJKy52J1i5PNsoXITQfFKBw2R3
         EVfsECt8FWR5Fxk4ZTGfh/VS4OVvpQRp1zYcjOsNBLsfUogu/XPqsCqxtzfq05xz6Qa3
         z7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0OQBKMEH+yIUn2+CtcH0iY1Ed92BV1Qd1VycwkxoZ/IDR6ys0KCyk/ow73kNOwNWr7q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZc/6R12yRPiz5XqbzhN9JXK7K+FUW+M2YOZPu7haO+RLIv+JK
	45Jddi9ISr1bEiJjZT5ugBgyIRFnNP9UfO3u2i8p9uufF48iTm+WpVdb
X-Gm-Gg: ATEYQzwp+/QpEl/hpHJHFU4z5yskSAuRmXJW+9fRXDPbMnbT4JtAEEEe6BK022SrJCa
	gGLHlBA0K2DpsrRQPQla+xXuQ36q6DUYbPxPKVUxvt7OkngOlkQ9pycsNZsiP7jNa3RIwDEwNWQ
	19zJIOAm812q7jG9QbPdlUHD4K1zCuVqxefEoVhZuhZ44N5np4YAiomCGYwutMdYjipEMjPr2xq
	fCHuEUTsStHJReOh4cl19P+Ig1hO0rllQL+n2GdGDNhy7CtanDSvPE/s8N+qOJxOjBSewOBCjXA
	0IeAKBi4jWlycd5CT+EasesMaLF/VNsu2fXXFBKzpViYrXwBZBJsejJde8dyCMcSCsY/1sa4sna
	CuAbhVI5iXc+FwZyxKWIJkM9IqRsWKSQYczn56s4bVqKJ7m1/3I7Wi/OwQ/Hb66lqP4JS9Xey0e
	yCFdAhthnVzqaxcSA=
X-Received: by 2002:a05:6000:1883:b0:43b:4440:9c28 with SMTP id ffacd0b85a97d-43b63fe235fmr19460348f8f.0.1774280020875;
        Mon, 23 Mar 2026 08:33:40 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm31058076f8f.20.2026.03.23.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:33:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
In-Reply-To: <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
Date: Mon, 23 Mar 2026 15:33:39 +0000
Message-ID: <87o6kek1bg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Chaignon <paul.chaignon@gmail.com> writes:

> In a subsequent patch, the regs_refine_cond_op and reg_bounds_sync
> functions will be called in is_branch_taken instead of reg_set_min_max,
> to simulate each branch's outcome. Since they will run before we branch
> out, these two functions will need to work on temporary registers for
> the two branches.
>
> This refactoring patch prepares for that change, by introducing the
> temporary registers on bpf_verifier_env and using them in
> reg_set_min_max.
>
> This change also allows us to save one fake_reg slot as we don't need to
> allocate an additional temporary buffer in case of a BPF_K condition.
>
> Finally, you may notice that this patch removes the check for
> "false_reg1 == false_reg2" in reg_set_min_max. That check was introduced
> in commit d43ad9da8052 ("bpf: Skip bounds adjustment for conditional
> jumps on same scalar register") to avoid an invariant violation. Given
> that "env->false_reg1 == env->false_reg2" doesn't make sense and
> invariant violations are addressed in a subsequent commit, this patch
> just removes the check.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  4 ++-
>  kernel/bpf/verifier.c        | 64 +++++++++++++-----------------------
>  2 files changed, 26 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..b129e0aaee20 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -837,7 +837,9 @@ struct bpf_verifier_env {
>  	u64 scratched_stack_slots;
>  	u64 prev_log_pos, prev_insn_print_pos;
>  	/* buffer used to temporary hold constants as scalar registers */
> -	struct bpf_reg_state fake_reg[2];
> +	struct bpf_reg_state fake_reg[1];
> +	/* buffers used to save updated reg states while simulating branches */
> +	struct bpf_reg_state true_reg1, true_reg2, false_reg1, false_reg2;
I can see Eduard suggested to store this in env to reduce stack usage by
the verifier. The rest of the refactoring looks like a correct
alignment. The only difference with the base version is removal of the
if (false_reg1 == false_reg2) condition, which is explained in the
commit message.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>  	/* buffer used to generate temporary string representations,
>  	 * e.g., in reg_type_str() to generate reg_type string
>  	 */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b638ab841c10..fbc29fb96a60 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17184,10 +17184,6 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>   * but we don't support that right now.
>   */
>  static int reg_set_min_max(struct bpf_verifier_env *env,
> -			   struct bpf_reg_state *true_reg1,
> -			   struct bpf_reg_state *true_reg2,
> -			   struct bpf_reg_state *false_reg1,
> -			   struct bpf_reg_state *false_reg2,
>  			   u8 opcode, bool is_jmp32)
>  {
>  	int err;
> @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
>  	 * variable offset from the compare (unless they were a pointer into
>  	 * the same object, but we don't bother with that).
>  	 */
> -	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
> -		return 0;
> -
> -	/* We compute branch direction for same SCALAR_VALUE registers in
> -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
> -	 * on the same registers, we don't need to adjust the min/max values.
> -	 */
> -	if (false_reg1 == false_reg2)
> +	if (env->false_reg1.type != SCALAR_VALUE || env->false_reg2.type != SCALAR_VALUE)
>  		return 0;
>  
>  	/* fallthrough (FALSE) branch */
> -	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
> -	reg_bounds_sync(false_reg1);
> -	reg_bounds_sync(false_reg2);
> +	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
> +	reg_bounds_sync(&env->false_reg1);
> +	reg_bounds_sync(&env->false_reg2);
>  
>  	/* jump (TRUE) branch */
> -	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
> -	reg_bounds_sync(true_reg1);
> -	reg_bounds_sync(true_reg2);
> -
> -	err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
> -	err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
> -	err = err ?: reg_bounds_sanity_check(env, false_reg1, "false_reg1");
> -	err = err ?: reg_bounds_sanity_check(env, false_reg2, "false_reg2");
> +	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
> +	reg_bounds_sync(&env->true_reg1);
> +	reg_bounds_sync(&env->true_reg2);
> +
> +	err = reg_bounds_sanity_check(env, &env->true_reg1, "true_reg1");
> +	err = err ?: reg_bounds_sanity_check(env, &env->true_reg2, "true_reg2");
> +	err = err ?: reg_bounds_sanity_check(env, &env->false_reg1, "false_reg1");
> +	err = err ?: reg_bounds_sanity_check(env, &env->false_reg2, "false_reg2");
>  	return err;
>  }
>  
> @@ -17597,6 +17586,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  	}
>  
>  	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
> +	copy_register_state(&env->false_reg1, dst_reg);
> +	copy_register_state(&env->false_reg2, src_reg);
> +	copy_register_state(&env->true_reg1, dst_reg);
> +	copy_register_state(&env->true_reg2, src_reg);
>  	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
>  	if (pred >= 0) {
>  		/* If we get here with a dst_reg pointer type it is because
> @@ -17661,27 +17654,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  		return PTR_ERR(other_branch);
>  	other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
>  
> -	if (BPF_SRC(insn->code) == BPF_X) {
> -		err = reg_set_min_max(env,
> -				      &other_branch_regs[insn->dst_reg],
> -				      &other_branch_regs[insn->src_reg],
> -				      dst_reg, src_reg, opcode, is_jmp32);
> -	} else /* BPF_SRC(insn->code) == BPF_K */ {
> -		/* reg_set_min_max() can mangle the fake_reg. Make a copy
> -		 * so that these are two different memory locations. The
> -		 * src_reg is not used beyond here in context of K.
> -		 */
> -		memcpy(&env->fake_reg[1], &env->fake_reg[0],
> -		       sizeof(env->fake_reg[0]));
> -		err = reg_set_min_max(env,
> -				      &other_branch_regs[insn->dst_reg],
> -				      &env->fake_reg[0],
> -				      dst_reg, &env->fake_reg[1],
> -				      opcode, is_jmp32);
> -	}
> +	err = reg_set_min_max(env, opcode, is_jmp32);
>  	if (err)
>  		return err;
>  
> +	copy_register_state(dst_reg, &env->false_reg1);
> +	copy_register_state(src_reg, &env->false_reg2);
> +	copy_register_state(&other_branch_regs[insn->dst_reg], &env->true_reg1);
> +	if (BPF_SRC(insn->code) == BPF_X)
> +		copy_register_state(&other_branch_regs[insn->src_reg], &env->true_reg2);
> +
>  	if (BPF_SRC(insn->code) == BPF_X &&
>  	    src_reg->type == SCALAR_VALUE && src_reg->id &&
>  	    !WARN_ON_ONCE(src_reg->id != other_branch_regs[insn->src_reg].id)) {
> -- 
> 2.43.0
