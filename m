Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38334C10F14
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5C92083D
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 23:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPzpekff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfDRX5x (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:57:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33644 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfDRX5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 19:57:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so1871982plo.0;
        Thu, 18 Apr 2019 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C81N3SrKdMzhaIwnU/sT9Ye4tBcGdex3mPvJ6ps0R64=;
        b=YPzpekffO3iXx6Ix0UXtMnPnZaPGdZfoHFh+ui9S88eZI0pEMdPCXzFyZAfUWYELZj
         b1ygz9dHvEH0E+GpWgRmo3rrh1dR8zgSRSECgutasi5huWlySUwoJzB9y1zq6nbV8PaQ
         pGNZsYVUJJrO5xCrECuQL+v26lZHytscjMsFub08W5qjMuLPs7j3WYRDvOMOIid3Roby
         mRVa5mqgyHjVdKQ2BMj62KBHzBQXEofv+fPUTA+KVEMsnfvxn8tRE+YaJnVYQjCgJy7g
         lyiv3bCjcCwj1utHaEkJUPCnnPcsG50mPViBfAO+r0JgLD1TgUX4gEYjl0C61I+H1yNk
         0P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C81N3SrKdMzhaIwnU/sT9Ye4tBcGdex3mPvJ6ps0R64=;
        b=mToNGqgwAllvJCCm85dOj1WUPpFc9C1tSA52uaFMv73LO0YZHFx0NS27QcXAotZuGu
         ky/kWDHamJeIz4/b7KXtvd5lCAhxi/2xNoMQzCKcGlUxYMYFEWDCmjOP/ihBS/KpMJgA
         e0RnYZoM8dxcIEDtmtw8swir228B3A52ht8a1r46VrggXBScBUD6JEi8e4HsDGip/IjP
         dOncj3n4Vb3gkv97vCErp3jhPGQV73+NhKTTzX+xb27knQaYaJl4alOGpucfHlZlxE2M
         egsnP0ev1RpQvORklSMwXzsnO7eHrBrnHHO/Ts2rJ83B7+NzFixHyBQFOzO0hMOqShaB
         IL0Q==
X-Gm-Message-State: APjAAAUlzZAKZoFxCHsF3zZzJzrAYAgcQ7kEKhtU2jc/KX5WkSaASCVC
        LkejsWDTAHXFcjv09HhH4b0=
X-Google-Smtp-Source: APXvYqyZhpQckJM1rXmYifDdMQTP8WRA2/jm0BKiEIYlprT6Wkt6/McwQZlieL8t563bkrUeSyPa8w==
X-Received: by 2002:a17:902:7d91:: with SMTP id a17mr493821plm.338.1555631872145;
        Thu, 18 Apr 2019 16:57:52 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:99e3])
        by smtp.gmail.com with ESMTPSA id p9sm4842436pfi.186.2019.04.18.16.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 16:57:51 -0700 (PDT)
Date:   Thu, 18 Apr 2019 16:57:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be
 zero extended into hi32
Message-ID: <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
 <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 15, 2019 at 06:26:12PM +0100, Jiong Wang wrote:
> eBPF ISA specification requires high 32-bit cleared when low 32-bit
> sub-register is written. This applies to destination register of ALU32 etc.
> JIT back-ends must guarantee this semantic when doing code-gen.
> 
> x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
> back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
> etc.) and some other 64-bit arches (powerpc, sparc etc), need explicit zero
> extension sequence to meet such semantic.
> 
> This is important, because for code the following:
> 
>   u64_value = (u64) u32_value
>   ... other uses of u64_value
> 
> compiler could exploit the semantic described above and save those zero
> extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
> JIT back-ends, are responsible for guaranteeing this. Some benchmarks show
> ~40% sub-register writes out of total insns, meaning ~40% extra code-gen (
> could go up to more for some arches which requires two shifts for zero
> extension) because JIT back-end needs to do extra code-gen for all such
> instructions.
> 
> However this is not always necessary in case u32_value is never cast into
> a u64, which is quite normal in real life program. So, it would be really
> good if we could identify those places where such type cast happened, and
> only do zero extensions for them, not for the others. This could save a lot
> of BPF code-gen.
> 
> Algo:
>  - Record indices of instructions that do sub-register def (write). And
>    these indices need to stay with reg state so path pruning and bpf
>    to bpf function call could be handled properly.
> 
>    These indices are kept up to date while doing insn walk.
> 
>  - A full register read on an active sub-register def marks the def insn as
>    needing zero extension on dst register.
> 
>  - A new sub-register write overrides the old one.
> 
>    A new full register write makes the register free of zero extension on
>    dst register.
> 
>  - When propagating read64 during path pruning, also marks def insns whose
>    defs are hanging active sub-register.
> 
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  include/linux/bpf_verifier.h |  6 ++++++
>  kernel/bpf/verifier.c        | 45 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index fba0ebb..c1923a5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -133,6 +133,11 @@ struct bpf_reg_state {
>  	 * pointing to bpf_func_state.
>  	 */
>  	u32 frameno;
> +	/* Tracks subreg definition. The stored value is the insn_idx of the
> +	 * writing insn. This is safe because subreg_def is used before any insn
> +	 * patching which only happens after main verification finished.
> +	 */
> +	s32 subreg_def;

could you use u32 instead ?
DEF_NOT_SUBREG==0 and valid subreg_def = insn_idx + 1 ?

Then if we miss regs[i].subreg_def = DEF_NOT_SUBREG; somewhere
it will still be conservative.

>  	enum bpf_reg_liveness live;
>  };
>  
> @@ -234,6 +239,7 @@ struct bpf_insn_aux_data {
>  	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
>  	int sanitize_stack_off; /* stack slot to be cleared */
>  	bool seen; /* this insn was processed by the verifier */
> +	bool zext_dst; /* this insn zero extend dst reg */
>  	u8 alu_state; /* used in combination with alu_limit */
>  	unsigned int orig_idx; /* original instruction index */
>  };
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5784b279..d5cc167 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -980,6 +980,7 @@ static void mark_reg_not_init(struct bpf_verifier_env *env,
>  	__mark_reg_not_init(regs + regno);
>  }
>  
> +#define DEF_NOT_SUBREG	(-1)
>  static void init_reg_state(struct bpf_verifier_env *env,
>  			   struct bpf_func_state *state)
>  {
> @@ -990,6 +991,7 @@ static void init_reg_state(struct bpf_verifier_env *env,
>  		mark_reg_not_init(env, regs, i);
>  		regs[i].live = REG_LIVE_NONE;
>  		regs[i].parent = NULL;
> +		regs[i].subreg_def = DEF_NOT_SUBREG;
>  	}
>  
>  	/* frame pointer */
> @@ -1259,6 +1261,19 @@ static bool is_reg64(struct bpf_insn *insn, u32 regno,
>  	return true;
>  }
>  
> +static void mark_insn_zext(struct bpf_verifier_env *env,
> +			   struct bpf_reg_state *reg)
> +{
> +	s32 def_idx = reg->subreg_def;
> +
> +	if (def_idx == DEF_NOT_SUBREG)
> +		return;
> +
> +	env->insn_aux_data[def_idx].zext_dst = true;
> +	/* The dst will be zero extended, so won't be sub-register anymore. */
> +	reg->subreg_def = DEF_NOT_SUBREG;
> +}
> +
>  static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
>  			 enum reg_arg_type t)
>  {
> @@ -1285,6 +1300,9 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
>  		if (regno == BPF_REG_FP)
>  			return 0;
>  
> +		if (rw64)
> +			mark_insn_zext(env, reg);
> +
>  		return mark_reg_read(env, reg, reg->parent,
>  				     rw64 ? REG_LIVE_READ64 : REG_LIVE_READ32);
>  	} else {
> @@ -1294,6 +1312,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
>  			return -EACCES;
>  		}
>  		reg->live |= REG_LIVE_WRITTEN;
> +		reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx;
>  		if (t == DST_OP)
>  			mark_reg_unknown(env, regs, regno);
>  	}
> @@ -2176,6 +2195,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  						    value_regno);
>  				if (reg_type_may_be_null(reg_type))
>  					regs[value_regno].id = ++env->id_gen;
> +				/* A load of ctx field could have different
> +				 * actual load size with the one encoded in the
> +				 * insn. When the dst is PTR, it is for sure not
> +				 * a sub-register.
> +				 */
> +				regs[value_regno].subreg_def = DEF_NOT_SUBREG;
>  			}
>  			regs[value_regno].type = reg_type;
>  		}
> @@ -3376,6 +3401,9 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>  		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
>  	}
>  
> +	/* helper call must return full 64-bit R0. */
> +	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> +
>  	/* update return register (already marked as written above) */
>  	if (fn->ret_type == RET_INTEGER) {
>  		/* sets type to SCALAR_VALUE */
> @@ -4307,6 +4335,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  				 */
>  				*dst_reg = *src_reg;
>  				dst_reg->live |= REG_LIVE_WRITTEN;
> +				dst_reg->subreg_def = DEF_NOT_SUBREG;
>  			} else {
>  				/* R1 = (u32) R2 */
>  				if (is_pointer_value(env, insn->src_reg)) {
> @@ -4317,6 +4346,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  				} else if (src_reg->type == SCALAR_VALUE) {
>  					*dst_reg = *src_reg;
>  					dst_reg->live |= REG_LIVE_WRITTEN;
> +					dst_reg->subreg_def = env->insn_idx;
>  				} else {
>  					mark_reg_unknown(env, regs,
>  							 insn->dst_reg);
> @@ -5380,6 +5410,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  	 * Already marked as written above.
>  	 */
>  	mark_reg_unknown(env, regs, BPF_REG_0);
> +	/* ld_abs load up to 32-bit skb data. */
> +	regs[BPF_REG_0].subreg_def = env->insn_idx;
>  	return 0;
>  }
>  
> @@ -6319,6 +6351,9 @@ static bool states_equal(struct bpf_verifier_env *env,
>  	return true;
>  }
>  
> +/* Return 0 if no propagation happened. Return negative error code if error
> + * happened. Otherwise, return the propagated bits.
> + */
>  static int propagate_liveness_reg(struct bpf_verifier_env *env,
>  				  struct bpf_reg_state *reg,
>  				  struct bpf_reg_state *parent_reg)
> @@ -6337,7 +6372,7 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
>  	if (err)
>  		return err;
>  
> -	return 0;
> +	return bits_prop;
>  }
>  
>  /* A write screens off any subsequent reads; but write marks come from the
> @@ -6371,8 +6406,10 @@ static int propagate_liveness(struct bpf_verifier_env *env,
>  		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
>  			err = propagate_liveness_reg(env, &state_reg[i],
>  						     &parent_reg[i]);
> -			if (err)
> +			if (err < 0)
>  				return err;
> +			if (err & REG_LIVE_READ64)
> +				mark_insn_zext(env, &parent_reg[i]);

I'm not quite following why it's parent_reg here instead of state_reg.

If I understood the code the liveness can have all three states:
REG_LIVE_READ64 | REG_LIVE_READ32
REG_LIVE_READ64
REG_LIVE_READ32
whereas 2 is a superset of 3, so 1 should never be seen.

If so, why in propagate_liveness we have this dance:
+       u8 parent_bits = parent_reg->live & REG_LIVE_READ;
+       u8 bits = reg->live & REG_LIVE_READ;
+       u8 bits_diff = parent_bits ^ bits;
+       u8 bits_prop = bits_diff & bits;
        int err;

-       if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
+       /* No diff bit comes from "reg". */
+       if (!bits_prop)

I'm struggling to see through all 3 combinations in respect to above diff.
Shouldn't propagation of REG_LIVE_READ64 remove REG_LIVE_READ32 bit
and clear subreg_def during mark_reg_read() instead of
once in propagate_liveness() ?

