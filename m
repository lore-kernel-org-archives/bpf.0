Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8637E5F6
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238580; cv=none; b=IxlF1WkkeBjjsBIvbsPEpzK1nXAa1XEMfqH0j8J0y7d9WNKaiBtQCxO0zhs+BbGAlDvtT+tt8rD9Kz1WkyOfRZUFhpJ5FnvQ/3zRnLok9L6T3fFZY+XDa3QFQTnGivBYGCRsvVcZs+puNXMVbJFnr2YSkYsKn5jMZYtGJj2ji/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238580; c=relaxed/simple;
	bh=Iumu5EjJoHqMDvmbq0m95lCdHmWylcJkye7qe3kEX68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrinvMoupL4IrF+IZXAX1vj8CR9F7ih2KRY5GMr+zDywdCU5T4b1OJSSsMsRuJ4663+tSlEnWp0N2rTI5IvcI6e9+ELemuGTZJKvy76+BUvK/PsFUL1vhOZUr8/TBHq2N4WTEpiSbHGOP5rp3KI1aglZS0KbXXTTaqCeX2ZyfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNTAvfAE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNTAvfAE"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so782998a12.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784238578; x=1784843378; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4q70pu8gCG4h/ZmXT+E+aeZSDDltPkZ5AUUhkUEJN/U=;
        b=iNTAvfAEiF1sWXuajF8BZdfiyIwVbFc0l2cJLbt1kzcyxsuVoSNSj1D1AstEHCSAhV
         kNbzLthbmd4zwy7rS6JxFR7QLJ9r+W4YsKfL2POkb/25DX16kw79P8LN1CbgQkqlZHXd
         s/k0NG3nqix7cfeUFFmfiaZUc1Em7RY5/TUBY2ozvx3AqZQEr8+L+Jbs5/zMius9UPot
         mDC99FI3gPJUMB6ydunphcFlwCr9zrD/dNzqqcCUXcK9lvKVHvInpo7fyFt2Astm3A1D
         BR5i/i4VQLg4k3clTK2d/VbmaOg/92rROiemycwqesBbrdrZRAv4n/REPbou5Z68/E6y
         AHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784238578; x=1784843378;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4q70pu8gCG4h/ZmXT+E+aeZSDDltPkZ5AUUhkUEJN/U=;
        b=qXei61Ocs4nrL3IPocOOsYLZCLrBgFylQVLJ0pbU5pqmhh28x+AXlRtBIa2PD7DDbe
         ziTU+5YCE5tfb3MfccgfKtJ5m13mvnX+tXxPTW1FIIHIpEchBCqDoJjuiS9OZh2Mt4ea
         Qz6wNBOdrkcpjduV5TZwWEUyKUruQFUHL+Fsdu/7yb5gcG5vzml5rBwJXh+/iRBsfF0t
         ber0W7OTfuTF7fX+WJphR8JRhY+6YqV05r4rm32IJHq6SbthhOVFUKYcXZd7PHmyRhmg
         YuiePLVjJ/kcJlLI1u9OM9LxKUopGaQ6FdiEHVoFgxzSluJGMt5XozwLWzRZ6zCHFnqk
         CG/w==
X-Forwarded-Encrypted: i=1; AHgh+Rp1pq2zAa/4g6GGpZZGQI7YdKICUl8reEJmJP19h3Nnk0hbHS+rMluoF8hNFkB84jcLznc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrxDXr26SQIIfOxluHKOgyk7P2lMp4vUz49SsNF73mfWX9egk1
	TTO/6yFWFhMN4dcRsotZtq+ar+HCDsKAfg1XqDwdkv+PT4rtBJJR3d5k
X-Gm-Gg: AfdE7cnJhigRG3OAiDerU0E7ceNxsqQE+DFj3z8wyIZFetJqevBj59+5avKGImVwhQB
	YFKETtt/Z4B4gZA7CJO597eNGF6PtLuv+Jw3BwEFQxGOB9OEMPIzenoRyofQ2ULarK75uFY+98o
	SZ/nPN5HyU5Ck0neSUhhLmouuV9EPUNc7pHkArMJh2IakkfldvUIjYhV7csMIMVMwBQ6swnX12Z
	8SdWP2SuucTnFq/Q2fJSRdD+W+zF4QtgJkL/uZL0w8oNRtXgUWPg5vbXxduSrKzkotnjISfBWaN
	B7+my1sWL56J/f8wlwDGtagdwSi77LMpJtD+Kxni2Dbvo84ONpkz/JFJXNOFNdQWNirr4WLc+Jd
	XF1z4UBu0NXV47YWcgK/v7GdRyxqBwdzIw3cwFSQXuACSz6ezU3lo1F2JsZ9nHPKpMXsmDzmFNi
	fQW3K6JcYLix+0j8veRguqzAemTqdUPOCmguE/C8wYv0sYNQVGW2wU4DG68m4=
X-Received: by 2002:a05:6a20:430f:b0:3c3:8315:80b6 with SMTP id adf61e73a8af0-3c38dbff098mr4813258637.32.1784238578129;
        Thu, 16 Jul 2026 14:49:38 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ecf:2571:4379:368f? ([2620:10d:c090:500::2:b47c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd426bf2csm11910992c88.1.2026.07.16.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:49:37 -0700 (PDT)
Message-ID: <2e1f303e25a5d763511dd34d10bb9d197a0fbad8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/17] bpf: Track verifier register
 diagnostic events
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 16 Jul 2026 14:49:35 -0700
In-Reply-To: <20260713153910.2556007-6-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:38 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> +void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
> +			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
> +			 const struct bpf_reg_state *old_reg, const struct bpf_reg_state *new=
_reg,
> +			 const struct bpf_diag_mod_target *origin)
> +{
> +	struct bpf_diag_history_event event =3D {
> +		.mod =3D {
> +			.hdr =3D {
> +				.insn_idx =3D insn_idx,
> +				.kind =3D BPF_DIAG_HISTORY_MOD,
> +			},
> +			.target =3D target,
> +			.reason =3D reason,
> +		},
> +	};
> +
> +	if (old_reg && new_reg) {
> +		diag_snapshot_reg(&event.mod.old, old_reg);
> +		diag_snapshot_reg(&event.mod.new, new_reg);
> +		if ((reason =3D=3D BPF_DIAG_MOD_WRITE || reason =3D=3D BPF_DIAG_MOD_SP=
ILL) &&
> +		    diag_mod_snapshot_eq(&event))
> +			return;
> +	}
> +	if (origin) {
> +		event.mod.origin =3D *origin;
> +		event.mod.origin_valid =3D true;
> +	} else {
> +		event.mod.origin_valid =3D
> +			diag_mod_insn_origin(env, insn_idx, &target, &event.mod.origin);
> +	}
> +
> +	diag_append_history(env, &event);
> +}

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 648adf3b7aaa..4a468299f05e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1834,6 +1834,50 @@ static const int caller_saved[CALLER_SAVED_REGS] =
=3D {
>  	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
>  };
> =20
> +static void bpf_diag_save_caller_saved_regs(struct bpf_verifier_env *env=
,
> +					    struct bpf_reg_state *regs)
> +{

...

> +}
> +
> +static void bpf_diag_record_caller_saved_invals(struct bpf_verifier_env =
*env, u32 insn_idx,
> +						struct bpf_reg_state *regs)
> +{

...

> +}
> +
> +static void bpf_diag_record_call_ret(struct bpf_verifier_env *env, u32 i=
nsn_idx,
> +				     struct bpf_reg_state *regs)
> +{

...

> +}
> +
>  /* This helper doesn't clear reg->id */
>  static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>  {
> @@ -3448,6 +3492,22 @@ static void assign_scalar_id_before_mov(struct bpf=
_verifier_env *env,
>  		src_reg->id =3D ++env->id_gen;
>  }
> =20
> +static int bpf_diag_stack_slot(const struct bpf_func_state *state,
> +			       const struct bpf_stack_state *stack)
> +{

...

> +}
> +
>  static void save_register_state(struct bpf_verifier_env *env,
>  				struct bpf_func_state *state,
>  				int spi, struct bpf_reg_state *reg,
> @@ -3525,8 +3585,14 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
>  	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE, err;
>  	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
>  	struct bpf_reg_state *reg =3D NULL;
> +	struct bpf_reg_state *old_spill;
>  	int insn_flags =3D INSN_F_STACK_ACCESS;
>  	int hist_spi =3D spi, hist_frame =3D state->frameno;
> +	bool old_was_spill =3D bpf_is_spilled_reg(&state->stack[spi]);
> +
> +	old_spill =3D bpf_diag_reg_scratch(env, 0);
> +	if (old_spill)
> +		*old_spill =3D state->stack[spi].spilled_ptr;
> =20
>  	/* caller checked that off % size =3D=3D 0 and -MAX_BPF_STACK <=3D off =
< 0,
>  	 * so it's aligned access and [off, off + size) are within stack limits

I think that changes in the verifier.c are too invasive and callsites
for bpf_diag_record_mod() clutter the code too much. Please consider
changes as in [1]:
- Expand the API to be used from verifier.c with begin()/end()
  primitives taking/using a snapshot of a register being modified.
- Derive target/origin descriptor from the register pointer.
- Avoid stashing caller saved registers in a scratch buffer,
  as these are set to NOT_INIT and the effect can be recorded
  right away.

[1] https://github.com/kernel-patches/bpf/commit/a89d27ea45c15a199f8e376535=
519306469a1f06

[...]
