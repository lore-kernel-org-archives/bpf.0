Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C861361656
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349372; cv=none; b=oVMBJq0aFo0Q3fkW2XrwWiVhWnfExy6YH3KMKJlVuBjGZdggTUT35C8MX9p2gwU1GWWfFjByYJcgSQ4KrAIBwZevcftmklYCCYWUOWFVQsCEFJmCuV+H5+5ygPciMdmzxPuMvuFZkljWwKTFlw1wGdBC5wt1ByFUaCmwWuB5eOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349372; c=relaxed/simple;
	bh=IMyke1lLGso4z3KW8yEnJQNKmWZNu9Huyr/uhbdC498=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N6k1yn55AXVeUBjQaclG9oG3JseavOYknoBewpmuaefcR7cjYwjVXGSd7NLM8NeERL82xhnMRn6We0+bemuxBuuTn7T2Cq8EYVKwuqzaKItnGX2tdDVRBHPHZjMdSWWt4RLI3JQHunqkarb50ruqImitEGfbY/WLRCZQZNho4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=NuyHNivo; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="NuyHNivo"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137dd51129bso135540c88.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780349369; x=1780954169; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts4sQ2Jyi5YLB2B6pHys9si3HnOpG+5KxY3WcN5b3dU=;
        b=NuyHNivo56fAmDACZ6vPWxZfYvnQlgu/ZMSNXN4iq+mX8NKKzBfxM9XPCiDRSm0YrP
         49rAPizuP+1tnlFlhA9otP2MPyxPfX6Ioygb9Ow8ll0VKzMVz/7K/H/YfwC3RtFdDbQk
         KQoo9nq6l9GdwsxKRMZcwgKF5MN6JT9x4akbX53L4YLspzFEw0D1c/6njwhlj8Sl9o1B
         UuIWljY0KbU8FbAR4fPqxhFPIzMTstt7bb1E/npR0z2sNfEmDCx+J2XBO9oox3ZEU99m
         +D4+wqEqJpY0pR5iaG81ijnNI5CeMnoOGCaaIo8pr5iXbFX9NaKKkjL054Rf84Gs6fpW
         WAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349369; x=1780954169;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts4sQ2Jyi5YLB2B6pHys9si3HnOpG+5KxY3WcN5b3dU=;
        b=cG30hq77o6pxKVw4cHvRGYBfuiUZWOtp/zKtlCvW9ktvHoVMmD9PdWaCjC21SUCyoD
         5JNVGcxeGArB44QiTAcWfKknu6bOaVMNCb7aCstHxkID381nvn+a2P7++kqFQNHvCzVT
         0XW1ryr++AO+54pMdVOXHBVrDNE2KxsES2NLX4BLWjCGq2qBD8xk/ZY6M+2psnjcN+99
         6x/2fDAdLcUnN9vMC5MGix0SLx1XDoTvL3HhBA+17GE5+7nnj89bKrbluB6m/XEu56jG
         RxTMCLbXUR6KYztaQZx3M/t2CnVOkOWbjS8mD4P5uS6Gnr/y/7wKFYMIA0qGopWeTKpS
         dQig==
X-Forwarded-Encrypted: i=1; AFNElJ/RDSSdM/A9UMiJQO4nR1mYqPwDmMQqWsDJk11LidhxVsDPg7ZQeRCzW6ejs7RyxnqkUEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyww+564P7tOJFG5pytugqTLqDb+tfLWvU2GwCcSNu9ffrn5fds
	S6ZPRjwnajoeb+fA8ludgyd4O2XTSiM7VuIG2kN42BbeajDkoRITNp2wnf7UlDHS5Mo=
X-Gm-Gg: Acq92OGUKr9VEKpc5yKpKscDq+TdFqoxYHnAXSji52/rWB90EhmyHED0TAXJyE6G1vI
	9YoOoKPZ9Rfiojc9SchUVrJJwmXt87fTUnGrQtJtyt8oSImUChhJgOWC3+FvxXhqHBLvrH5By45
	OFucyNJvP/wrBVjH7DOk204nGNdojEUaTeaivsgqgC00V71yj7YkAWiBy5hBYYhFiQkqZc2XFud
	P20b5UddTPd8KCtVB27tWDGGyS1ksFgjskkSkTYJc/bfYWH8mzewEKUCsmyLg8znjvPxysNYLt3
	9T+CgaAhxCvrHUPLEbIgnbOhha7hU5kmelUDCvdtPWx0laIYQiJZTw1+iVE3e/ly3TS5OWQDYpn
	3FtN5Hy9Hc3zOmevHNTyLfp49vDYOGVNDci2OcH33+go8+hLKr0bdKo0ujG3shqz/Py8yeNv3xy
	Ycxm7PACvozEgSG+A=
X-Received: by 2002:a05:7022:2202:b0:130:68a1:a237 with SMTP id a92af1059eb24-137d42839eamr6446612c88.35.1780349369146;
        Mon, 01 Jun 2026 14:29:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::a782])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed130dafsm9490501eec.0.2026.06.01.14.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 14:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 17:29:26 -0400
Message-Id: <DIY16FWK8YDS.1HLJ3UPVQ3LT7@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 5/6] bpf: report register diff summary
 for hot callchains
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-5-b3ede0588a75@gmail.com>
In-Reply-To: <20260527-better-1m-reporting-v3-5-b3ede0588a75@gmail.com>

On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> When a hot callchain ends at a iter_next, may_goto, or
> callback-calling instruction, compare cached states from
> explored_states to identify which registers or stack slots most
> frequently differ between states. Report the top 3 most varying
> locations.
>
> The full states diff computation would require some statistical
> analysis similar to k-means. To keep things simple, approximate this
> by modifying states_equal() to return the first location where old and
> current states differ, and counting most frequent diff locations.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One nit below.

> ---
>  include/linux/bpf_verifier.h |  15 ++++
>  kernel/bpf/states.c          | 184 +++++++++++++++++++++++++++++++++++++=
------
>  kernel/bpf/verifier.c        |  57 +++++++++++---
>  3 files changed, 225 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 347a155d8e21..cc83359774f5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -662,6 +662,17 @@ struct bpf_loop {
>  	bool irreducible;
>  };
> =20
> +struct bpf_state_diff {
> +	u8 slot;
> +	u8 frame;
> +	enum {
> +		DIFF_OTHER,
> +		DIFF_REG,
> +		DIFF_STACK,
> +		DIFF_ARG,
> +	} kind;
> +};
> +
>  struct bpf_callchain {
>  	u32 insn_idx[MAX_CALL_FRAMES];
>  	u32 curframe;
> @@ -1631,5 +1642,9 @@ int bpf_fixup_call_args(struct bpf_verifier_env *en=
v);
>  int bpf_do_misc_fixups(struct bpf_verifier_env *env);
> =20
>  int bpf_compute_loops(struct bpf_verifier_env *env);
> +int bpf_sample_state_diffs(struct bpf_verifier_env *env,
> +			   struct bpf_callchain *cc,
> +			   struct bpf_state_diff *top_diffs,
> +			   int *nr_diffs);
> =20
>  #endif /* _LINUX_BPF_VERIFIER_H */
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 877338136009..b1256658189d 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -4,6 +4,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/cnum.h>
>  #include <linux/filter.h>
> +#include <linux/sort.h>
> =20
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
> =20
> @@ -696,7 +697,7 @@ static struct bpf_reg_state *scalar_reg_for_stack(str=
uct bpf_verifier_env *env,
> =20
>  static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_stat=
e *old,
>  		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
> -		      enum exact_level exact)
> +		      enum exact_level exact, struct bpf_state_diff *diff)
>  {
>  	int i, spi;
> =20
> @@ -720,8 +721,11 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  				old_type =3D STACK_INVALID;
>  			if (cur_type =3D=3D STACK_POISON)
>  				cur_type =3D STACK_INVALID;
> -			if (i >=3D cur->allocated_stack || old_type !=3D cur_type)
> +			if (i >=3D cur->allocated_stack || old_type !=3D cur_type) {

This new logging of divergent stack slots is identical throughout stack saf=
e. Can we factor
it out into an error label at the very end?

> +				diff->slot =3D spi;
> +				diff->kind =3D DIFF_STACK;
>  				return false;
> +			}
>  		}
> =20
>  		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_INVALID |=
|
> @@ -735,8 +739,11 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  		/* explored stack has more populated slots than current stack
>  		 * and these slots were used
>  		 */
> -		if (i >=3D cur->allocated_stack)
> +		if (i >=3D cur->allocated_stack) {
> +			diff->slot =3D spi;
> +			diff->kind =3D DIFF_STACK;
>  			return false;
> +		}
> =20
>  		/*
>  		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
> @@ -748,8 +755,11 @@ static bool stacksafe(struct bpf_verifier_env *env, =
struct bpf_func_state *old,
>  			old_reg =3D scalar_reg_for_stack(env, &old->stack[spi], im);
>  			cur_reg =3D scalar_reg_for_stack(env, &cur->stack[spi], im);
>  			if (old_reg && cur_reg) {
> -				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
> +				if (!regsafe(env, old_reg, cur_reg, idmap, exact)) {
> +					diff->slot =3D spi;
> +					diff->kind =3D DIFF_STACK;
>  					return false;
> +				}
>  				i +=3D (im =3D=3D 0 ? BPF_REG_SIZE - 1 : 3);
>  				continue;
>  			}
> @@ -763,13 +773,16 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
>  		    cur->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_ZERO)
>  			continue;
>  		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
> -		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
> +		    cur->stack[spi].slot_type[i % BPF_REG_SIZE]) {
>  			/* Ex: old explored (safe) state has STACK_SPILL in
>  			 * this stack slot, but current has STACK_MISC ->
>  			 * this verifier states are not equivalent,
>  			 * return false to continue verification of this path
>  			 */
> +			diff->slot =3D spi;
> +			diff->kind =3D DIFF_STACK;
>  			return false;
> +		}
>  		if (i % BPF_REG_SIZE !=3D BPF_REG_SIZE - 1)
>  			continue;
>  		/* Both old and cur are having same slot_type */
> @@ -786,16 +799,22 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
>  			 * return false to continue verification of this path
>  			 */
>  			if (!regsafe(env, &old->stack[spi].spilled_ptr,
> -				     &cur->stack[spi].spilled_ptr, idmap, exact))
> +				     &cur->stack[spi].spilled_ptr, idmap, exact)) {
> +				diff->slot =3D spi;
> +				diff->kind =3D DIFF_STACK;
>  				return false;
> +			}
>  			break;
>  		case STACK_DYNPTR:
>  			old_reg =3D &old->stack[spi].spilled_ptr;
>  			cur_reg =3D &cur->stack[spi].spilled_ptr;
>  			if (old_reg->dynptr.type !=3D cur_reg->dynptr.type ||
>  			    old_reg->dynptr.first_slot !=3D cur_reg->dynptr.first_slot ||
> -			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
> +			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap)) {
> +				diff->slot =3D spi;
> +				diff->kind =3D DIFF_STACK;
>  				return false;
> +			}
>  			break;
>  		case STACK_ITER:
>  			old_reg =3D &old->stack[spi].spilled_ptr;
> @@ -810,15 +829,21 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
>  			    old_reg->iter.btf_id !=3D cur_reg->iter.btf_id ||
>  			    old_reg->iter.state !=3D cur_reg->iter.state ||
>  			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
> -			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
> +			    !check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap)) {
> +				diff->slot =3D spi;
> +				diff->kind =3D DIFF_STACK;
>  				return false;
> +			}
>  			break;
>  		case STACK_IRQ_FLAG:
>  			old_reg =3D &old->stack[spi].spilled_ptr;
>  			cur_reg =3D &cur->stack[spi].spilled_ptr;
>  			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
> -			    old_reg->irq.kfunc_class !=3D cur_reg->irq.kfunc_class)
> +			    old_reg->irq.kfunc_class !=3D cur_reg->irq.kfunc_class) {
> +				diff->slot =3D spi;
> +				diff->kind =3D DIFF_STACK;
>  				return false;
> +			}
>  			break;
>  		case STACK_MISC:
>  		case STACK_ZERO:
> @@ -827,6 +852,8 @@ static bool stacksafe(struct bpf_verifier_env *env, s=
truct bpf_func_state *old,
>  			continue;
>  		/* Ensure that new unhandled slot types return false by default */
>  		default:
> +			diff->slot =3D spi;
> +			diff->kind =3D DIFF_STACK;
>  			return false;
>  		}
>  	}
> @@ -839,7 +866,7 @@ static bool stacksafe(struct bpf_verifier_env *env, s=
truct bpf_func_state *old,
>   */
>  static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func=
_state *old,
>  			   struct bpf_func_state *cur, struct bpf_idmap *idmap,
> -			   enum exact_level exact)
> +			   enum exact_level exact, struct bpf_state_diff *diff)
>  {
>  	int i, nslots;
> =20
> @@ -852,8 +879,11 @@ static bool stack_arg_safe(struct bpf_verifier_env *=
env, struct bpf_func_state *
>  			  &old->stack_arg_regs[i] : &not_init;
>  		cur_arg =3D i < cur->out_stack_arg_cnt ?
>  			  &cur->stack_arg_regs[i] : &not_init;
> -		if (!regsafe(env, old_arg, cur_arg, idmap, exact))
> +		if (!regsafe(env, old_arg, cur_arg, idmap, exact)) {
> +			diff->slot =3D i;
> +			diff->kind =3D DIFF_ARG;
>  			return false;
> +		}
>  	}
> =20
>  	return true;
> @@ -933,7 +963,8 @@ static bool refsafe(struct bpf_verifier_state *old, s=
truct bpf_verifier_state *c
>   * the current state will reach 'bpf_exit' instruction safely
>   */
>  static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_f=
unc_state *old,
> -			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exac=
t)
> +			      struct bpf_func_state *cur, u32 insn_idx,
> +			      enum exact_level exact, struct bpf_state_diff *diff)
>  {
>  	u16 live_regs =3D env->insn_aux_data[insn_idx].live_regs_before;
>  	u16 i;
> @@ -947,13 +978,16 @@ static bool func_states_equal(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
>  	for (i =3D 0; i < MAX_BPF_REG; i++)
>  		if (((1 << i) & live_regs) &&
>  		    !regsafe(env, &old->regs[i], &cur->regs[i],
> -			     &env->idmap_scratch, exact))
> +			     &env->idmap_scratch, exact)) {
> +			diff->slot =3D i;
> +			diff->kind =3D DIFF_REG;
>  			return false;
> +		}
> =20
> -	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact))
> +	if (!stacksafe(env, old, cur, &env->idmap_scratch, exact, diff))
>  		return false;
> =20
> -	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
> +	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact, diff))
>  		return false;
> =20
>  	return true;
> @@ -970,11 +1004,14 @@ static void reset_idmap_scratch(struct bpf_verifie=
r_env *env)
>  static bool states_equal(struct bpf_verifier_env *env,
>  			 struct bpf_verifier_state *old,
>  			 struct bpf_verifier_state *cur,
> -			 enum exact_level exact)
> +			 enum exact_level exact,
> +			 struct bpf_state_diff *diff)
>  {
>  	u32 insn_idx;
>  	int i;
> =20
> +	diff->kind =3D DIFF_OTHER;
> +
>  	if (old->curframe !=3D cur->curframe)
>  		return false;
> =20
> @@ -999,8 +1036,11 @@ static bool states_equal(struct bpf_verifier_env *e=
nv,
>  		insn_idx =3D bpf_frame_insn_idx(old, i);
>  		if (old->frame[i]->callsite !=3D cur->frame[i]->callsite)
>  			return false;
> -		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, ex=
act))
> +		if (!func_states_equal(env, old->frame[i], cur->frame[i],
> +				       insn_idx, exact, diff)) {
> +			diff->frame =3D i;
>  			return false;
> +		}
>  	}
>  	return true;
>  }
> @@ -1231,6 +1271,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>  	struct bpf_verifier_state_list *new_sl;
>  	struct bpf_verifier_state_list *sl;
>  	struct bpf_verifier_state *cur =3D env->cur_state, *new;
> +	struct bpf_state_diff diff =3D {};
>  	bool force_new_state, add_new_state, loop;
>  	int n, err, states_cnt =3D 0;
>  	struct list_head *pos, *tmp, *head;
> @@ -1320,7 +1361,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>  			 * =3D> unsafe memory access at 11 would not be caught.
>  			 */
>  			if (is_iter_next_insn(env, insn_idx)) {
> -				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> +				if (states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
>  					struct bpf_func_state *cur_frame;
>  					struct bpf_reg_state *iter_state, *iter_reg;
>  					int spi;
> @@ -1345,13 +1386,13 @@ int bpf_is_state_visited(struct bpf_verifier_env =
*env, int insn_idx)
>  			}
>  			if (is_may_goto_insn_at(env, insn_idx)) {
>  				if (sl->state.may_goto_depth !=3D cur->may_goto_depth &&
> -				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> +				    states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
>  					loop =3D true;
>  					goto hit;
>  				}
>  			}
>  			if (bpf_calls_callback(env, insn_idx)) {
> -				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> +				if (states_equal(env, &sl->state, cur, RANGE_WITHIN, &diff)) {
>  					loop =3D true;
>  					goto hit;
>  				}
> @@ -1359,7 +1400,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>  			}
>  			/* attempt to detect infinite loop to avoid unnecessary doomed work *=
/
>  			if (states_maybe_looping(&sl->state, cur) &&
> -			    states_equal(env, &sl->state, cur, EXACT) &&
> +			    states_equal(env, &sl->state, cur, EXACT, &diff) &&
>  			    !iter_active_depths_differ(&sl->state, cur) &&
>  			    sl->state.may_goto_depth =3D=3D cur->may_goto_depth &&
>  			    sl->state.callback_unroll_depth =3D=3D cur->callback_unroll_depth=
) {
> @@ -1392,7 +1433,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>  		}
>  		/* See comments for mark_all_regs_read_and_precise() */
>  		loop =3D incomplete_read_marks(env, &sl->state);
> -		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT=
)) {
> +		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT=
, &diff)) {
>  hit:
>  			sl->hit_cnt++;
> =20
> @@ -1588,3 +1629,102 @@ int bpf_is_state_visited(struct bpf_verifier_env =
*env, int insn_idx)
>  	list_add(&new_sl->node, head);
>  	return 0;
>  }
> +
> +static bool callchain_matches_state(struct bpf_callchain *cc,
> +				    struct bpf_verifier_state *st)
> +{
> +	int i;
> +
> +	if (st->curframe !=3D cc->curframe)
> +		return false;
> +	for (i =3D 0; i < (int)cc->curframe; i++)
> +		if (st->frame[i + 1]->callsite !=3D cc->insn_idx[i])
> +			return false;
> +	return st->insn_idx =3D=3D cc->insn_idx[cc->curframe];
> +}
> +
> +struct state_diff_cnt {
> +	struct bpf_state_diff diff;
> +	u32 cnt;
> +};
> +
> +static int state_diff_cmp(const void *a, const void *b)
> +{
> +	return cmp_int(((struct state_diff_cnt *)b)->cnt, ((struct state_diff_c=
nt *)a)->cnt);
> +}
> +
> +static bool state_diff_eq(struct bpf_state_diff *a, struct bpf_state_dif=
f *b)
> +{
> +	return a->frame =3D=3D b->frame && a->slot =3D=3D b->slot && a->kind =
=3D=3D b->kind;
> +}
> +
> +int bpf_sample_state_diffs(struct bpf_verifier_env *env,
> +			   struct bpf_callchain *cc,
> +			   struct bpf_state_diff *top_diffs,
> +			   int *nr_diffs)
> +{
> +	struct bpf_verifier_state_list *sl_i, *sl_j;
> +	struct state_diff_cnt *diff_cnts =3D NULL;
> +	struct list_head *pos_i, *pos_j, *head;
> +	u32 leaf_insn, callsite, hash_idx;
> +	int i, cap =3D 0, nr_locs =3D 0;
> +
> +	leaf_insn =3D cc->insn_idx[cc->curframe];
> +	callsite =3D cc->curframe > 0 ? cc->insn_idx[cc->curframe - 1] : BPF_MA=
IN_FUNC;
> +	hash_idx =3D (leaf_insn ^ callsite) % env->prog->len;
> +	head =3D &env->explored_states[hash_idx];
> +
> +	/*
> +	 * Single bucket accumulates up to 64 states, no cond_resched() necessa=
ry.
> +	 * See limits in is_state_visited().
> +	 */
> +	list_for_each(pos_i, head) {
> +		sl_i =3D container_of(pos_i, struct bpf_verifier_state_list, node);
> +		if (!callchain_matches_state(cc, &sl_i->state))
> +			continue;
> +		list_for_each(pos_j, head) {
> +			struct bpf_state_diff diff =3D {};
> +
> +			if (pos_i =3D=3D pos_j)
> +				continue;
> +			sl_j =3D container_of(pos_j, struct bpf_verifier_state_list, node);
> +			if (!callchain_matches_state(cc, &sl_j->state))
> +				continue;
> +			if (states_equal(env, &sl_i->state, &sl_j->state, NOT_EXACT, &diff))
> +				continue;
> +			if (diff.kind =3D=3D DIFF_OTHER)
> +				continue;
> +			for (i =3D 0; i < nr_locs; i++) {
> +				if (state_diff_eq(&diff_cnts[i].diff, &diff)) {
> +					diff_cnts[i].cnt++;
> +					goto next;
> +				}
> +			}
> +			if (nr_locs =3D=3D cap) {
> +				int new_cap =3D cap ? cap * 2 : 16;
> +				struct state_diff_cnt *new;
> +
> +				new =3D kvrealloc(diff_cnts, new_cap * sizeof(*new),
> +						GFP_KERNEL_ACCOUNT);
> +				if (!new) {
> +					kvfree(diff_cnts);
> +					return -ENOMEM;
> +				}
> +				memset(new + cap, 0, (new_cap - cap) * sizeof(*new));
> +				diff_cnts =3D new;
> +				cap =3D new_cap;
> +			}
> +			diff_cnts[nr_locs].diff =3D diff;
> +			diff_cnts[nr_locs].cnt =3D 1;
> +			nr_locs++;
> +next:;
> +		}
> +	}
> +
> +	sort(diff_cnts, nr_locs, sizeof(*diff_cnts), state_diff_cmp, NULL);
> +	*nr_diffs =3D min(nr_locs, *nr_diffs);
> +	for (i =3D 0; i < *nr_diffs; i++)
> +		top_diffs[i] =3D diff_cnts[i].diff;
> +	kvfree(diff_cnts);
> +	return 0;
> +}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54b7ad65b7fc..d09c014462f1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17292,13 +17292,13 @@ static void free_callchain_profile(struct bpf_v=
erifier_env *env)
>  	}
>  }
> =20
> -static void print_callchain_entry(struct bpf_verifier_env *env,
> -				  struct bpf_callchain_entry *entry, int idx)
> +static int print_callchain_entry(struct bpf_verifier_env *env,
> +				 struct bpf_callchain_entry *entry, int idx)
>  {
>  	struct bpf_callchain *cc =3D &entry->cc;
>  	const struct bpf_line_info *linfo;
>  	struct bpf_subprog_info *sub;
> -	int i, insn_idx;
> +	int i, err, insn_idx;
> =20
>  	verbose(env, "#%d most visited simulated stacktrace (visited %llu times=
):\n",
>  		idx, entry->count);
> @@ -17316,6 +17316,38 @@ static void print_callchain_entry(struct bpf_ver=
ifier_env *env,
>  				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
>  		verbose(env, "\n");
>  	}
> +
> +	insn_idx =3D cc->insn_idx[cc->curframe];
> +	if (bpf_is_force_checkpoint(env, insn_idx)) {
> +		struct bpf_state_diff top_diffs[3];
> +		int nr_diffs =3D ARRAY_SIZE(top_diffs);
> +
> +		err =3D bpf_sample_state_diffs(env, cc, top_diffs, &nr_diffs);
> +		if (err)
> +			return err;
> +		for (i =3D 0; i < nr_diffs; i++) {
> +			struct bpf_state_diff *d =3D &top_diffs[i];
> +
> +			switch (d->kind) {
> +			case DIFF_REG:
> +				verbose(env, "    Most varying: R%d (frame %d)\n",
> +					d->slot, d->frame);
> +				break;
> +			case DIFF_STACK:
> +				verbose(env, "    Most varying: fp-%d (frame %d)\n",
> +					(d->slot + 1) * BPF_REG_SIZE, d->frame);
> +				break;
> +			case DIFF_ARG:
> +				verbose(env, "    Most varying: arg#%d (frame %d)\n",
> +					d->slot, d->frame);
> +				break;
> +			default:
> +				/* shouldn't really happen */
> +				continue;
> +			}
> +		}
> +	}
> +	return 0;
>  }
> =20
>  static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subp=
rog_info *sub)
> @@ -17340,16 +17372,16 @@ static void disasm_subprog(struct bpf_verifier_=
env *env, struct bpf_subprog_info
>   * Print several most visited simulated stack traces,
>   * and a disasembly of related subprograms.
>   */
> -static void print_hotspots(struct bpf_verifier_env *env)
> +static int print_hotspots(struct bpf_verifier_env *env)
>  {
>  	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS + 2) =3D {};
>  	struct bpf_callchain_entry *top[3] =3D {};
>  	struct bpf_callchain_entry *entry;
>  	struct bpf_subprog_info *sub;
> -	int i, j, bkt, nr_top =3D 0;
> +	int i, j, err, bkt, nr_top =3D 0;
> =20
>  	if (!(env->log.level & BPF_LOG_LEVEL))
> -		return;
> +		return 0;
> =20
>  	/* Collect the hottest callchains */
>  	hash_for_each(env->callchain_htab, bkt, entry, node) {
> @@ -17366,7 +17398,7 @@ static void print_hotspots(struct bpf_verifier_en=
v *env)
>  		nr_top++;
> =20
>  	if (!nr_top)
> -		return;
> +		return 0;
> =20
>  	if (!(env->log.level & BPF_LOG_LEVEL2))
>  		bpf_vlog_reset(&env->log, 0);
> @@ -17388,9 +17420,14 @@ static void print_hotspots(struct bpf_verifier_e=
nv *env)
> =20
>  	/* Print the hot callchains */
>  	for (i =3D 0; i < nr_top; i++) {
> -		print_callchain_entry(env, top[i], i + 1);
> +		err =3D print_callchain_entry(env, top[i], i + 1);
> +		if (err)
> +			return err;
> +
>  		verbose(env, "\n");
>  	}
> +
> +	return 0;
>  }
> =20
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_st=
ate)
> @@ -17527,7 +17564,9 @@ static int do_check(struct bpf_verifier_env *env)
>  		insn_aux =3D &env->insn_aux_data[env->insn_idx];
> =20
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> -			print_hotspots(env);
> +			err =3D print_hotspots(env);
> +			if (err)
> +				return err;
>  			verbose(env,
>  				"BPF program is too large. Processed %d insn\n",
>  				env->insn_processed);

