Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDA38E5C4
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352698; cv=none; b=otRQnePrAroFNRkALlnsAgh3wPcg9BieZ75g9baugf/TFSOy0lTbeZhsEbur3VGz7ca4gfdWn+DSeSrIZBl6ROFohigaffzglIvy+zKTKzsDwnK90nVcMFVd6jEXYImd0M1LUvaYcfEJUhhWURtJF0M5m8Iop+kf88j1Zig6yJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352698; c=relaxed/simple;
	bh=zCM2oxe8Hrtxwx3aNdKPk6i8g3qZbdkhDIWWcRWfinE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dnYsIIJ5OUMoR9mFrOfstxPb73bUo/W9AWY6oRCc+rH4Q5snHiVug9tuEQD8hQ+H+Ga9DjtSCmzRU2WOjyonmPWb2PiPcoOxNczH7se4jQRBGv8Txbtk6vE+qF4lzu1qy8RJOOlGmyZrWoLXG9MsGb3HeoJmE3FlwJDOBtahPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUiVCyqQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUiVCyqQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c7cfa17fedso12918275ad.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782352692; x=1782957492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9n5i/bywaPQ72qnHtSGg1AZc0buCuHUeql/c9ax0kc8=;
        b=lUiVCyqQbjwt1TIljRFNZ3sg9+o56wgN3uit6t/oe3fy1x6h4qv5cDfBo9NE9mQnUK
         zRLMlX3FEIA98+n4Hn47q5bq0Qq9vSykl/fc6BMYFdrTGpve7+lrycuCW6kHk4HgWYdT
         7tndoLm01o1kPmzcGdWSWq6zqUg+r9dZRnGvpwBU6443npSNsYXaBtbNuepsa67HoB7O
         qdGs/DRlNd5dQrEZx2XWuBpII9teXRSGH9X+Y26S+7APPdoBqIGL4ofCLy6seC1+4HQh
         +mF/stzBIiAhARzaQCYt2eh49CBoZojU3+5Z6pWmFj8l9NPlShgKp43cAoXaw0KR9bqZ
         YdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782352692; x=1782957492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n5i/bywaPQ72qnHtSGg1AZc0buCuHUeql/c9ax0kc8=;
        b=nkeunJFYcN8KfqImesWxu8hCxGV3u8kmEMlf4B00z7OqwVFWjEuHGdFLrsMZ+PJwDE
         ROqaWxI4sH+jdvsPfm2/YoXnJwGkSgtuBpQiJQhErXvGiXRZCx8X0wu1M/FfA9YAeqhi
         QdxxSqQcrU7zTFLMaZcHbKyC0w1ccAuWYwMCuAn8tFYH8Y6WZCnJtoK5M3gzryjV1Bi7
         xktACM8WmXn05n6ja7lsz7RGnTBYZ/+8da/SQPmNmTRNQnrsLKHErwcaVaDM0n6zSkyZ
         8qCzUqmPuYgdqRe/1SmUBjfV/nRthzB4sCEODVOem9aLZX86wKDB/zRvd5rRA7XnmhIr
         iSAg==
X-Forwarded-Encrypted: i=1; AHgh+RrSHciLScvcTXpjVjr4KGUO7eQ5bQxU1hLVD1YXtSeIsYLmnAqmZeN+ZwLNG8y4jpbfQgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49r8DaXsIjvsCUzekm3spmQ/4PlFR8kL1uCDyk3RFalY1Bz3v
	MW+dHRuWGlrqul1MTn0ypY3rVw7ER8VhyvaNLroegS7ftRhA0WpPDDE5
X-Gm-Gg: AfdE7cnVEl53voXsbAgFgmaa0nP60RxKKgn2MSF1p7zBE958oiPrkBVS0DWQN5sR6tx
	a6O675mPu6fSpyvRqdGCTB0BfM3EOmoKxSW/ZZa2Fx9fKLuh5+BhTRKkddcNjgf83S3CfsTpE3G
	QJgkGk9PM6B8a3JGrnNfYw4fwCGGQsxxnVmYx/SwSr0k4juP73aCDG/8JlkyITWhg1ZZCWc753T
	Om8omZIIouS562XMpJqKg06u5kGqpkyhKy4lmtSIQ0u16gzhFXtDbACNOv9I2q+bXOEoZm6h1O5
	TMrIGRKQOB3nBR0Bii1zs+XToDoTprmLGUvZFZ0oogft3LDklcCiSAdSYOTS14G+7uu9i79te3W
	s9iuHfi4+PHGJdzna+gYi3ZxJHdhRHg7QDzBotdhLo/JQqEtpnrit011kHvq89/Jxttr2adafT8
	/Bacpm5JNEV7yWfATt2nUz0gC8dm8/fUrguotIRYAqVw==
X-Received: by 2002:a17:902:e744:b0:2c6:9897:dbaa with SMTP id d9443c01a7336-2c7fc657c47mr7520915ad.3.1782352691842;
        Wed, 24 Jun 2026 18:58:11 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae6c36sm8898405ad.23.2026.06.24.18.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 18:58:11 -0700 (PDT)
Message-ID: <d690e14fbf06fc0eb9e943c5270a26cb842d19c1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 10/17] bpf: Report Resource Lifetime
 reference leaks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Wed, 24 Jun 2026 18:58:04 -0700
In-Reply-To: <20260619205934.1312876-11-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-11-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c

[...]

> @@ -1120,6 +1124,15 @@ static int unmark_stack_slot_irq_flag(struct bpf_v=
erifier_env *env, struct bpf_r
> =20
>  		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %=
s kfuncs\n",
>  			flag_kfunc, used_kfunc);
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

It might be helpful to report where the previous spin lock had been acquire=
d,
however bpf_diag_report_resource_state() does not inspect the events histor=
y.

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

Same here.

>  				return -EINVAL;
>  			}
>  		}

[...]

> @@ -7300,14 +7330,26 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, struct bpf_reg_state
>  			type =3D REF_TYPE_LOCK;
>  		if (!find_lock_state(cur, type, reg->id, ptr)) {
>  			verbose(env, "%s_unlock of different lock\n", lock_str);
> +			bpf_diag_report_resource_state(env, env->insn_idx,
> +						       "unlock of different lock",
                                                               ^^^^^
                                                           nit: "of a diffe=
rent"
> +						       "This unlock does not match any active lock with the same t=
racked identity on the current path.",
> +						       "Unlock the same lock object that was most recently acquire=
d.");

Would it be helpful to report which object exactly would verifier
expect to be unlocked?

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

Should the error message point out what's in the register instead of
expected type?

>  		return -EINVAL;
>  	}
> =20

[...]

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

Nit: elaborate on which type is expected and which type the actual dynptr h=
as?

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

Similarly here (and in several places below), report what's actually in the=
 register?

>  		return -EINVAL;
>  	}
> =20

[...]
