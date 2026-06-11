Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3E38D407
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221399; cv=none; b=svwipfZzX02XFhqhZazHdg/twvcSQLvF9qde9SLqgbBkEokW0G3ocGP+pCsTHTMW3nYRrvxEyC5scOZVJ+cez5jSJy8x83riUGTdn7STIwaO3g7MueFk24qUCo8Cn9AKvjyLbmWfyB935S5BBVAR5a9IX42a9z1yYdGRt7qzkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221399; c=relaxed/simple;
	bh=5lSnIDK1wdqlfNwUUZTMuxKnfXTDmw/1F5Ce0A3o618=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EAs8Hbaw/EtMZu1ZYcESx0MOJ0ZXPit3dJnZK7tVg71XbAc14p4ADy6G5j7nfhPoO0pe/tEsAkqDZvzRiuk9nvpMlED4RnhQxAWgsN6uIb1PVzfrDVljqM4oHgZLbS1nq5II3FhNiq/Esffhinb4SD32x22in0v52R9nJ5OwB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jdmIOjhq; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jdmIOjhq"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13809ed8fbeso754442c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781221397; x=1781826197; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U99eCWxst6ErXv9KV4MWiJMSbJM6dWOdUneYQftMWKo=;
        b=jdmIOjhqlc2et+bjgCpY5vzYXYLEVT4tM8bapKxp8davUFGjtay76wEwrE0afB/De+
         qNGImTMNXi18mV2uYPokOw2aDY7zC8xh65FEnqoZE4i0E0Zwxqyr6L4QUegbEX8TdPHz
         3RVPCb0MXGM9OA4RNrCZK5IisxRJs3/QYoF88VamNRZ+21+R2rUd2E3asq1mdsdRqqi1
         iCW1F473wgefhuReYgeIHrL2B9nRcK2s/tcP8861YVhju+PW65IPhfueUTDtUJECuhva
         rowO7cv66i9Q4TA8ntMwzT9vhIuG9ZHLzhePlcd0mExJ50bihlvH2xLX+i0TbUyAI+J9
         jrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781221397; x=1781826197;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U99eCWxst6ErXv9KV4MWiJMSbJM6dWOdUneYQftMWKo=;
        b=XOb0WCBihhO9Pnd5FntI6VHmgQhDJGtoRpDURYajqrAWGvmgxZEUvBrjj7nGinH9nL
         hFNrW5Qls8JnplADyjiFUuNztDNW8W90v+M0qRUwp9Q6T1yq/KrGZf7mPx1Lxra40Kel
         850fm2VowVNrwMxzVBVOPQuwn/AsPls7YFZ0pGCwmMseH2HN4GZjoRMzAshWu4jlWl3k
         tjqm0lchvw2T7ugTDAs5oEzuXeSSLe+EwQ5+cy99jYoXVlWoN9k3TV6g/8AwygWFVHBj
         4gFQ7owXUu7Bu2Xnyp++RUyqy7Aa2Wkzvi3RIO7muq4iZ74xlzCEbf56BU/4nulmqw4H
         Wi9w==
X-Gm-Message-State: AOJu0YxlZSkG+qRi59QbmFD80gSd9z/rs/ejuJTeHGkcjE6IxNsbWN6G
	haKn2d+uCzYJAheLFkarvGX5DkALcxD7SzqiWkl3ZexjH6beiZ/fAHspiXaZ9txaphg=
X-Gm-Gg: Acq92OGunG8XZvSCB3761rYLSDuily8nY8Ytj+tOpG2ZAcceGTnLiQFP83/rj1IVpLn
	bR07lGRqI5911JU0mMEl63WtL2M3V9iDHJ+kiRrsCZG71TqViLgNukj05/5YF6VbiccvRt2Lxyq
	jNJl3w/xI3Ggynib3pGfmN0O44+/vZYqH4Rhdn1e09GdCOVFpF+YD+Ex8tj1JEEKd7kFgEE1vFr
	6EI5RNzWH521fJHM1cvsDBYXhHTphaTmOPJaYMXDXnIAHxk/iBlnj7wfcC6xW45RbQtoqPbtMFs
	ITnh4s4Cqp6f/O4ISf4gHzVshNvo5JE0i5V7hKrAHSXbJZpbzVHg3WY4d0V6AtUxdOVMvCDsriY
	33E1qEr5zeD1/8A3fFp0dAZgAQqp6T6C2IqmUAjbJrX2lmfkbiXHSeGzzfg1bFJRE8CIAh6RGM2
	yEpv7u
X-Received: by 2002:a05:7022:3d0f:b0:137:f764:85f5 with SMTP id a92af1059eb24-1384bbc99a7mr206965c88.32.1781221396295;
        Thu, 11 Jun 2026 16:43:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3c95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97570asm358721c88.12.2026.06.11.16.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 16:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 19:43:12 -0400
Message-Id: <DJ6MABD6AW71.4585Y3MKTIGC@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Track spilled zero scalars for var-off stack
 reads
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Woojin Ji" <random6.xyz@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>
In-Reply-To: <20260611-bpf-stack-var-off-zero-v1-v1-1-0ec407376147@gmail.com>

On Thu Jun 11, 2026 at 6:11 AM EDT, Woojin Ji wrote:
> mark_reg_stack_read() currently treats a variable-offset stack read as
> known-zero only when every byte in the read range has STACK_ZERO type.
> This loses precision for stack bytes that are represented as STACK_SPILL
> but come from a spilled scalar const zero.
>
> Fixed-offset stack reads already preserve such partial reads from a
> spilled scalar zero as const zero. Variable-offset stack writes also keep
> a spilled scalar zero intact when a zero write overlaps it. The read side
> is therefore inconsistent and can reject otherwise valid programs: a byte
> read from a spilled zero becomes an unknown u8 and may then make a
> stack access through that value appear out of bounds.
>
> Treat STACK_SPILL bytes backed by a spilled scalar const zero as zero
> bytes in mark_reg_stack_read(). When such a spilled scalar is used to
> prove the destination register is const zero, mark every contributing
> source stack slot precise before state pruning can use an explored
> zero-spill path for a later non-zero spill path.
>
> This has to be done eagerly for variable-offset loads. Fixed-offset stack
> fills can record one source stack slot in the jump history and propagate
> destination precision back to that slot later, but a variable-offset load
> may source bytes from multiple stack slots. Seed precision backtracking
> with every zero-spill slot that contributes to the const-zero
> classification instead.
>
> Add verifier selftests for both sides: accepted programs that read a byte
> through a variable stack offset from spilled zero scalars, including a
> multi-slot range, and a rejected program that would be accepted unsafely
> by a naive implementation that promotes spilled zero bytes to const zero
> without tracking the source spilled slot precisely. Use
> BPF_F_TEST_STATE_FREQ for the rejected test so it does not depend on the
> current verifier checkpoint heuristic thresholds.
>
> Tested:
>   ./test_progs -t verifier_var_off
>
> Assisted-by: opencode:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>

Correctness of the patch aside, is this a problem ever see in real
programs? Unless I'm missing something this is extra complexity in the
verifier to address a theoretical possibility.

> ---
>  kernel/bpf/verifier.c                              | 52 ++++++++++---
>  .../testing/selftests/bpf/progs/verifier_var_off.c | 88 ++++++++++++++++=
++++++
>  2 files changed, 130 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd..c4b89fbd9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4058,14 +4058,21 @@ static int check_stack_write_var_off(struct bpf_v=
erifier_env *env,
>   * SCALAR. This function does not deal with register filling; the caller=
 must
>   * ensure that all spilled registers in the stack range have been marked=
 as
>   * read.
> + *
> + * If the const-zero classification depends on spilled scalar zeroes, ma=
rk the
> + * contributing stack slots precise so pruning cannot reuse a zero-spill=
 state
> + * for a later path containing a different spilled scalar.
> + *
> + * Returns an error if precision backtracking fails.
>   */
> -static void mark_reg_stack_read(struct bpf_verifier_env *env,
> -				/* func where src register points to */
> -				struct bpf_func_state *ptr_state,
> -				int min_off, int max_off, int dst_regno)
> +static int mark_reg_stack_read(struct bpf_verifier_env *env,
> +			       /* func where src register points to */
> +			       struct bpf_func_state *ptr_state,
> +			       int min_off, int max_off, int dst_regno)
>  {
>  	struct bpf_verifier_state *vstate =3D env->cur_state;
>  	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
> +	u64 zero_spill_mask =3D 0;
>  	int i, slot, spi;
>  	u8 *stype;
>  	int zeros =3D 0;
> @@ -4075,19 +4082,38 @@ static void mark_reg_stack_read(struct bpf_verifi=
er_env *env,
>  		spi =3D slot / BPF_REG_SIZE;
>  		mark_stack_slot_scratched(env, spi);
>  		stype =3D ptr_state->stack[spi].slot_type;
> -		if (stype[slot % BPF_REG_SIZE] !=3D STACK_ZERO)
> -			break;
> -		zeros++;
> +		if (stype[slot % BPF_REG_SIZE] =3D=3D STACK_ZERO) {
> +			zeros++;
> +			continue;
> +		}
> +		if (stype[slot % BPF_REG_SIZE] =3D=3D STACK_SPILL &&
> +		    bpf_is_spilled_scalar_reg(&ptr_state->stack[spi]) &&
> +		    tnum_is_const(ptr_state->stack[spi].spilled_ptr.var_off) &&
> +		    ptr_state->stack[spi].spilled_ptr.var_off.value =3D=3D 0) {
> +			zero_spill_mask |=3D 1ull << spi;
> +			zeros++;
> +			continue;
> +		}
> +		break;
>  	}
>  	if (zeros =3D=3D max_off - min_off) {
>  		/* Any access_size read into register is zero extended,
>  		 * so the whole register =3D=3D const_zero.
>  		 */
>  		__mark_reg_const_zero(env, &state->regs[dst_regno]);
> +		if (zero_spill_mask) {
> +			for (spi =3D 0; spi < MAX_BPF_STACK / BPF_REG_SIZE; spi++) {
> +				if (zero_spill_mask & (1ull << spi))
> +					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);
> +			}
> +			return mark_chain_precision_batch(env, env->cur_state);
> +		}
>  	} else {
>  		/* have read misc data from the stack */
>  		mark_reg_unknown(env, state->regs, dst_regno);
>  	}
> +
> +	return 0;
>  }
> =20
>  /* Read the stack at 'off' and put the results into the register indicat=
ed by
> @@ -4109,6 +4135,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>  	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
>  	struct bpf_reg_state *reg;
>  	u8 *stype, type;
> +	int err;
>  	int insn_flags =3D insn_stack_access_flags(reg_state->frameno, spi);
> =20
>  	stype =3D reg_state->stack[spi].slot_type;
> @@ -4235,8 +4262,11 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  			}
>  			return -EACCES;
>  		}
> -		if (dst_regno >=3D 0)
> -			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
> +		if (dst_regno >=3D 0) {
> +			err =3D mark_reg_stack_read(env, reg_state, off, off + size, dst_regn=
o);
> +			if (err)
> +				return err;
> +		}
>  		insn_flags =3D 0; /* we are not restoring spilled register */
>  	}
>  	if (insn_flags)
> @@ -4291,7 +4321,9 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env,
> =20
>  	min_off =3D reg->smin_value + off;
>  	max_off =3D reg->smax_value + off;
> -	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno)=
;
> +	err =3D mark_reg_stack_read(env, ptr_state, min_off, max_off + size, ds=
t_regno);
> +	if (err)
> +		return err;
>  	check_fastcall_stack_contract(env, ptr_state, env->insn_idx, min_off);
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools=
/testing/selftests/bpf/progs/verifier_var_off.c
> index f345466bc..2d4878270 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> @@ -59,6 +59,94 @@ __naked void stack_read_priv_vs_unpriv(void)
>  "	::: __clobber_all);
>  }
> =20
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero")
> +__success
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__retval(0)
> +__naked void stack_read_var_off_preserves_spilled_zero(void)
> +{
> +	asm volatile (
> +	"r0 =3D 0; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	"r2 =3D *(u32 *)(r1 + 0); "
> +	"r2 &=3D 7; "
> +	"r2 -=3D 8; "
> +	"r2 +=3D r10; "
> +	"r3 =3D *(u8 *)(r2 + 0); "
> +	"r1 =3D r10; "
> +	"r1 +=3D -1; "
> +	"r1 +=3D r3; "
> +	" *(u8 *)(r1 + 0) =3D r3; "
> +	"r0 =3D 0; "
> +	"exit; "
> +	::
> +	: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read preserves spilled zero across =
slots")
> +__success
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__retval(0)
> +__naked void stack_read_var_off_preserves_spilled_zero_across_slots(void=
)
> +{
> +	asm volatile (
> +	"r0 =3D 0; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	" *(u64 *)(r10 - 16) =3D r0; "
> +	"r2 =3D *(u32 *)(r1 + 0); "
> +	"r2 &=3D 15; "
> +	"r2 -=3D 16; "
> +	"r2 +=3D r10; "
> +	"r3 =3D *(u8 *)(r2 + 0); "
> +	"r1 =3D r10; "
> +	"r1 +=3D -1; "
> +	"r1 +=3D r3; "
> +	" *(u8 *)(r1 + 0) =3D r3; "
> +	"r0 =3D 0; "
> +	"exit; "
> +	::
> +	: __clobber_all);
> +}
> +
> +SEC("cgroup/skb")
> +__description("variable-offset stack read tracks spilled zero precisely"=
)
> +__failure
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__msg("invalid variable-offset write to stack R1")
> +__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !=
root")
> +__naked void stack_read_var_off_tracks_spilled_zero_precisely(void)
> +{
> +	asm volatile (
> +	"r6 =3D *(u32 *)(r1 + 0); "
> +	"r6 &=3D 1; "
> +	"r0 =3D 0; "
> +	"if r6 !=3D 0 goto "
> +	"+"
> +	"2; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	"goto "
> +	"+"
> +	"2; "
> +	"r0 =3D 1; "
> +	" *(u64 *)(r10 - 8) =3D r0; "
> +	"r0 =3D 0; "
> +	"r2 =3D *(u32 *)(r1 + 4); "
> +	"r2 &=3D 7; "
> +	"r2 -=3D 8; "
> +	"r2 +=3D r10; "
> +	"r3 =3D *(u8 *)(r2 + 0); "
> +	"r1 =3D r10; "
> +	"r1 +=3D -1; "
> +	"r1 +=3D r3; "
> +	" *(u8 *)(r1 + 0) =3D 0; "
> +	"r0 =3D 0; "
> +	"exit; "
> +	::
> +	: __clobber_all);
> +}
> +
>  SEC("cgroup/skb")
>  __description("variable-offset stack read, uninitialized")
>  __success
>
> ---
> base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
> change-id: 20260610-bpf-stack-var-off-zero-v1-34ad1bc3b533
>
> Best regards,
> -- =20
> Woojin Ji <random6.xyz@gmail.com>

