Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FF347FE1
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912558; cv=none; b=o29pnFL512AwgqY32KpE7Y6B1OGBfxks2WjHed/3v9Bosab7ZwtCn/JVPHrZzalGgcTORJgyKzvfmkGdZBN8PIpH2uh9SQCSZeGhccZI8nnp9PsWqDVFxk686C6yWf97xxk6zdp+rAG5CLquhfSfLmr4L5x2X9nsEzprIFOZpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912558; c=relaxed/simple;
	bh=BwmX/YzsZE8pbu/FpIZz8PAB8Vcnz0mQXDmVXjzPkus=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NAv/LyzrDWNOsyDzkLrAgF9dr0gP8I+ViJiGOnbs9Ic2JHohTrel86S5dJu1Pu7eS3iWQui7WzIUCHPUECU7uu5Odkm2bEtL+xoy9HvXWJuPYoBD3+CiIDfMt95AIrqYcd3qG3IbJebNq+fkunMJmxzwqKa7iKiFvWRAwQJdm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R28Ujg7W; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R28Ujg7W"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a0a0b46cd9so1044981eaf.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912555; x=1782517355; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcUddctejMpapsVncnHW3mI9Fo9R84jgCFZYXYvjIaM=;
        b=R28Ujg7Wx7fohYbODoTKN+/W4LAJ0Mpg0s26a2MsE85LlE6DAO7RBRaO3kakowlkHq
         nPUI5+Rhk5Ph5BfFNsa8oqn93RM6B4OtBIoC/Htm3SBpKrTv5Yd83rgAvCfXUB6XqpNN
         KS9gFgyEhr21+NzATjk27Q93oDzoAcaoWP65TvTbkGFRtSdagSZjD20GE5sW3ysnOY8D
         4mSI8O6ubuDDv4d657R9816yzwmG4oiVBHiqfq883uAIjGNEPJTbYFZVWRRx3dcUfCex
         JSMmAFY4z1QXd4UyoeHjg7ZHUn7aqLePkhlG2a74l5EykwXHFqq5Zwou7yAKjaG4fvsk
         wwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912555; x=1782517355;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcUddctejMpapsVncnHW3mI9Fo9R84jgCFZYXYvjIaM=;
        b=mxBpiFMy4hQrsVx3IkE/rojtsNAh1uHroDfzXEGAp1+wxG78NGSbWTfFc8rAwy3XvO
         MCqKtDpiWFvqd1Blub+NVdqXy/oYQg0a9cMJWgMG/iZakT/2V07NlK0A8ZdGztMiN73C
         2jrogdBvZLtbM2QLhqKsmMWhx7Fs3nmBaI53cigkeLu9IK2Ej9VbnnHHfy6bzcHm1y9Q
         myv3BsINu9Y7Vj58Vv75hYmRob0jdGnzkEbpIRn9cA3B6rF5unTEE9DUMoxCNPJn7d/e
         FYTwGfDy0pzd0+xdVnrzSgFZ8dU3OSpTKdHsmkfyOH2LS989HiI4ksHdlAd9C3DnWREA
         ZE4A==
X-Forwarded-Encrypted: i=1; AFNElJ827xiFVU2wPTMCtLqBhvsU21iyFQFJ1LvGLPNudNnaE66NTEb5LvFr0/sfGAfRb0JKHVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkdZUys+SKFGynwTAAIxrd5zAG4Z/D7pBICQXyf3TphBBdMNa
	MsMzSpmlzn5lQeCb2sB/W27d110NvFFIafb41MFkXf3M0egncMOXelmV
X-Gm-Gg: AfdE7cnmWnCbNkyfNCILMUMD+sT1Qz/ky1o3fQsVUSpgn2BshC7lHtxKqIWuY18mPfc
	4TCRhgicwurQWdsA9XS8d8MbCVHgky4zIoIVyGoa3D5RAyKbjDO+AYHQhg6EaE5VBUHvY6mqeXm
	60O04LWa34bbCTglWLusi5USQO4/GFBZcL3FP4z8mT9swV5OwR9BDTwfGWzoMoUWSZtoM4B0FuU
	4x8BO/cRASGWatKl/4PhNe6WXmnjYfSctuJdAMdoU2k19pmR/536opVMIMZwA+5YQ4IOZzGxbTr
	uzzsR9t4+6nzdF7WWH9KjjpbqXdx9ZJag2Jf8GegqzGRvGCTJ5FVFNsLA9pTouVjNRfUD90rMsW
	gtrDfioe3NWVWRLnmEb8wVSGWzPLDtjtAe8TFF5GguPhiDxAogY0ImXgVrFbBEYZqJ92Q5chU90
	ohV8RHjUTRNZJj6yZL1yAaMUrG+O7IIhSEh7ewp7snI/WpMMr0kTfJqxLlXb5jrH2ANAuNz9KT0
	bJX5f4=
X-Received: by 2002:a4a:edca:0:b0:69d:82e6:69e4 with SMTP id 006d021491bc7-6a0de0ffae8mr3505362eaf.47.1781912555373;
        Fri, 19 Jun 2026 16:42:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea1520e4sm839035eaf.15.2026.06.19.16.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 16:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 16:42:33 -0700
Message-Id: <DJDFA66W97OU.2VSS5QIMHBXCJ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 10/17] bpf: Report Resource Lifetime
 reference leaks
X-Mailer: aerc
References: <20260619205934.1312876-1-memxor@gmail.com>
 <20260619205934.1312876-11-memxor@gmail.com>
In-Reply-To: <20260619205934.1312876-11-memxor@gmail.com>

On Fri Jun 19, 2026 at 1:59 PM PDT, Kumar Kartikeya Dwivedi wrote:
> +		bpf_diag_report_irq_resource_state(env, env->insn_idx,
> +						   "IRQ flag restore mismatch",
> +						   bpf_diag_scratch_printf(env,
> +									   0,
> +									   "This IRQ flag was saved by %s IRQ kfuncs, but the restore c=
all belongs to the %s IRQ kfunc family. Save and restore operations must us=
e the same family.",
> +									   flag_kfunc,
> +									   used_kfunc),
> +						   "Restore the flag with the matching IRQ restore kfunc for the s=
ave operation that created it.",
> +						   env->cur_state->active_irq_id ? 1 : 0);

same concern as in the previous patch.

>  		return -EINVAL;
>  	}
> =20
> @@ -1137,6 +1150,11 @@ static int unmark_stack_slot_irq_flag(struct bpf_v=
erifier_env *env, struct bpf_r
> =20
>  		verbose(env, "cannot restore irq state out of order, expected id=3D%d =
acquired at insn_idx=3D%d\n",
>  			env->cur_state->active_irq_id, insn_idx);
> +		bpf_diag_report_irq_resource_state(env, env->insn_idx,
> +						   "IRQ flag restore out of order",
> +						   "IRQ-disabled regions must be restored in last-in, first-out or=
der, but this restore does not match the currently active IRQ flag.",
> +						   "Restore nested IRQ flags in the reverse order they were saved.=
",
> +						   env->cur_state->active_irq_id ? 1 : 0);
>  		return err;
>  	}
> =20
> @@ -7258,11 +7276,19 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, struct bpf_reg_state
>  			if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
>  				verbose(env,
>  					"Locking two bpf_spin_locks are not allowed\n");
> +				bpf_diag_report_resource_state(env, env->insn_idx,
> +							       "nested spin lock",
> +							       "This path already holds a bpf_spin_lock. The verifier all=
ows only one regular BPF spin lock at a time.",
> +							       "Unlock the current bpf_spin_lock before taking another on=
e.");
>  				return -EINVAL;
>  			}
>  		} else if (is_res_lock && cur->active_locks) {
>  			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK | REF_TYPE_RES_=
LOCK_IRQ, reg->id, ptr)) {
>  				verbose(env, "Acquiring the same lock again, AA deadlock detected\n"=
);
> +				bpf_diag_report_resource_state(env, env->insn_idx,
> +							       "recursive resource spin lock",
> +							       "This path already holds the same resource spin lock. Taki=
ng it again would deadlock.",
> +							       "Avoid reacquiring the same resource spin lock before it i=
s unlocked.");
>  				return -EINVAL;
>  			}
>  		}
> @@ -7289,6 +7315,10 @@ static int process_spin_lock(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
> =20
>  		if (!cur->active_locks) {
>  			verbose(env, "%s_unlock without taking a lock\n", lock_str);
> +			bpf_diag_report_resource_state(env, env->insn_idx,
> +						       "unlock without lock",
> +						       "This unlock operation has no matching active lock on the c=
urrent path.",
> +						       "Take the matching lock before this unlock, or remove the u=
nmatched unlock path.");
>  			return -EINVAL;
>  		}
> =20
> @@ -7300,14 +7330,26 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, struct bpf_reg_state
>  			type =3D REF_TYPE_LOCK;
>  		if (!find_lock_state(cur, type, reg->id, ptr)) {
>  			verbose(env, "%s_unlock of different lock\n", lock_str);
> +			bpf_diag_report_resource_state(env, env->insn_idx,
> +						       "unlock of different lock",
> +						       "This unlock does not match any active lock with the same t=
racked identity on the current path.",
> +						       "Unlock the same lock object that was most recently acquire=
d.");
>  			return -EINVAL;
>  		}
>  		if (reg->id !=3D cur->active_lock_id || ptr !=3D cur->active_lock_ptr)=
 {
>  			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
> +			bpf_diag_report_resource_state(env, env->insn_idx,
> +						       "unlock out of order",
> +						       "Locks must be released in last-in, first-out order, but th=
is unlock does not match the currently active lock.",
> +						       "Release nested locks in the reverse order they were acquir=
ed.");
>  			return -EINVAL;
>  		}
>  		if (release_lock_state(env, type, reg->id, ptr)) {
>  			verbose(env, "%s_unlock of different lock\n", lock_str);
> +			bpf_diag_report_resource_state(env, env->insn_idx,
> +						       "unlock of different lock",
> +						       "The verifier could not release a lock state matching this =
unlock operation.",
> +						       "Pass the same lock object and lock kind that were used for=
 the matching lock operation.");
>  			return -EINVAL;
>  		}
> =20
> @@ -7473,6 +7515,10 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, struct bpf_reg_stat
>  		verbose(env,
>  			"%s expected pointer to stack or const struct bpf_dynptr\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_resource_state(env, insn_idx,
> +					       "invalid dynptr argument",
> +					       "A dynptr argument must be a pointer to a dynptr stack slot =
or a verifier-provided const struct bpf_dynptr.",
> +					       "Pass the address of a stack dynptr object, or use a const d=
ynptr pointer returned by the verifier-supported path.");
>  		return -EINVAL;
>  	}
> =20
> @@ -7495,6 +7541,10 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, struct bpf_reg_stat
> =20
>  		if (!is_dynptr_reg_valid_uninit(env, reg)) {
>  			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> +			bpf_diag_report_resource_state(env, insn_idx,
> +						       "dynptr is already initialized",
> +						       "This kfunc constructs a dynptr and requires an uninitializ=
ed dynptr stack slot, but the selected slot already holds dynptr state.",
> +						       "Use a fresh stack dynptr slot, or release/destroy the exis=
ting dynptr before reusing the slot.");
>  			return -EINVAL;
>  		}
> =20
> @@ -7511,12 +7561,20 @@ static int process_dynptr_func(struct bpf_verifie=
r_env *env, struct bpf_reg_stat
>  		/* For the reg->type =3D=3D PTR_TO_STACK case, bpf_dynptr is never con=
st */
>  		if (reg->type =3D=3D CONST_PTR_TO_DYNPTR && (arg_type & OBJ_RELEASE)) =
{
>  			verbose(env, "CONST_PTR_TO_DYNPTR cannot be released\n");
> +			bpf_diag_report_resource_state(env, insn_idx,
> +						       "const dynptr release",
> +						       "This release operation was given a const dynptr. Const dyn=
ptr values are verifier-provided views and cannot be released by the progra=
m.",
> +						       "Release only mutable dynptrs that the program initialized =
or reserved.");
>  			return -EINVAL;
>  		}
> =20
>  		if (!is_dynptr_reg_valid_init(env, reg)) {
>  			verbose(env, "Expected an initialized dynptr as %s\n",
>  				reg_arg_name(env, argno));
> +			bpf_diag_report_resource_state(env, insn_idx,
> +						       "uninitialized dynptr use",
> +						       "This operation requires an initialized dynptr, but the sta=
ck slot does not currently hold a valid dynptr on this path.",
> +						       "Initialize the dynptr on every path before this call, and =
avoid overwriting or releasing it before this use.");
>  			return -EINVAL;
>  		}
> =20
> @@ -7526,6 +7584,10 @@ static int process_dynptr_func(struct bpf_verifier=
_env *env, struct bpf_reg_stat
>  				"Expected a dynptr of type %s as %s\n",
>  				dynptr_type_str(arg_to_dynptr_type(arg_type)),
>  				reg_arg_name(env, argno));
> +			bpf_diag_report_resource_state(env, insn_idx,
> +						       "wrong dynptr type",
> +						       "The dynptr is initialized, but it was created for a differ=
ent backing object type than this operation accepts.",
> +						       "Use a dynptr constructor that matches this operation, or c=
all an operation that accepts the dynptr's current type.");
>  			return -EINVAL;
>  		}
> =20
> @@ -7594,6 +7656,10 @@ static int process_iter_arg(struct bpf_verifier_en=
v *env, struct bpf_reg_state *
>  	if (reg->type !=3D PTR_TO_STACK) {
>  		verbose(env, "%s expected pointer to an iterator on stack\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_resource_state(env, insn_idx,
> +					       "invalid iterator argument",
> +					       "Iterator state must live in verifier-tracked stack memory, =
but this argument is not a stack pointer.",
> +					       "Pass the address of a stack iterator object for iterator ne=
w, next, and destroy calls.");
>  		return -EINVAL;
>  	}
> =20
> @@ -7607,6 +7673,10 @@ static int process_iter_arg(struct bpf_verifier_en=
v *env, struct bpf_reg_state *
>  	if (btf_id < 0) {
>  		verbose(env, "expected valid iter pointer as %s\n",
>  			reg_arg_name(env, argno));
> +		bpf_diag_report_resource_state(env, insn_idx,
> +					       "invalid iterator type",
> +					       "The kfunc expects a recognized iterator state pointer, but =
this argument does not match a valid iterator type.",
> +					       "Pass the exact iterator state type expected by this kfunc."=
);
>  		return -EINVAL;
>  	}
>  	t =3D btf_type_by_id(meta->btf, btf_id);
> @@ -7617,6 +7687,10 @@ static int process_iter_arg(struct bpf_verifier_en=
v *env, struct bpf_reg_state *
>  		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
>  			verbose(env, "expected uninitialized iter_%s as %s\n",
>  				iter_type_str(meta->btf, btf_id), reg_arg_name(env, argno));
> +			bpf_diag_report_resource_state(env, insn_idx,
> +						       "iterator is already initialized",
> +						       "Iterator creation requires an uninitialized iterator stack=
 object, but this stack range already contains iterator state.",
> +						       "Use a fresh iterator stack slot, or destroy the existing i=
terator before reusing the slot.");

Maybe shorten bpf_diag_report_resource_state() name to bpf_diag() ?

