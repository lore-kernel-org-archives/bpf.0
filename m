Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021168;
	b=LKR1/vjARmPSjFfWhByl4wu+01B8Y0Iv6okbL5IPNpnSAznuf6bUbMAyA+PFgctd4NI1
	 8bIBskDBhF3Qq/RrXbnpofhCBkNJEudmfcGooDj6RfodpzCYCqq30NP2vujuVO10YSgYe
	 ZF2v9x9uiob54uJdfFmo3oTlZHFGvb3pYsKDNrF/7bo3vxDpX+EJfv9lUKjmuz6KtfknN
	 gWdsqi/EvaRyLMv86AZiYT7HOLmBH95XxnwErmZ7gpN8wlFDpkRn6mRjg+XGJo0jWvFY1
	 r9F8H8/L985zj1cp6LBmeIxRxuMtjTvhUgxIxRGSb71XV/N7RtbY6+pl9LbyTvrPNvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021168;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KbEU+1WNBf+4R4WccJCACFF5j/g97nHdTx3WBO4ApNw=;
	b=lMSOXhYqOpcoP2Io6ZYpz96sRxX0YWsOEhUYcnWZFRjht33IBfiYLxannzRebiwzQtAs
	 cnF44LbOG6INezmPbOlkOKqWImJWD2+wMQlvxLb5ZoqO58lK5oOUD0pEM7QcTm9QzXPeu
	 saWvHt0ud/0facXUhkohlFiA2v3s9MAblJ1Y6cn7WZvIH+LhheKbHWjmSDLC9u3R60fPJ
	 ew2z9C95tujw1QaStbe2mjmL5hqc8g/H8BxXSRpx1fOBvp/XUxx6l9rfdzLhEaL5YLpV2
	 G7eBN3Q2bV5h/V+tYPFG8/j6AvzSqQg9vrCOc0XegbEfHHK2m+otxQIN4PFbu7pAg9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXIsfmDo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88AD606A330
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXIsfmDo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2A81F000CA;
	Wed, 18 Nov 2026 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021168;
	bh=KbEU+1WNBf+4R4WccJCACFF5j/g97nHdTx3WBO4ApNw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OXIsfmDoxPEtI/Dwy0P3piyq1UHMbdWLP336dPIlQLq0zScuQm2Xc3X6yplipKuML
	 XXERcttsA5I31DYacxWIiUvuvNrYcxXHQPw69oG2PKsbeO1c745oyfhYlyqYXqZBzq
	 EWKd3CT1SzDI3TplLXIfxK3Mo3MrzKvNAV4wBfxm7lxOv602WKUpazCF1CnSqvw1QZ
	 gOnRairbRHyLR+IJfxtHYq6xlDe/OJOu4BGj/io0wOpZeVdoyzryNKGSW+vGDiM2uR
	 C0ENscJo7cBL4SoqgnHKchujZcB0e1d5WtyiCnwBKmMofA0kKMAQP3VutccKzawH+J
	 9CUkF+IxcEpzw==
Content-Type: multipart/mixed; boundary="===============4923379696212313141=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e5fd05a670861cd47cf6112096c1904ea418ef9335cbeb9badd54ed87c24e1f0@mail.kernel.org>
In-Reply-To: <20261118161053.1768878-1-yonghong.song@linux.dev>
References: <20261118161053.1768878-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 16:59:26 +0000 (UTC)

--===============4923379696212313141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations

TL;DR: Zero-extending unsigned 32-bit enum values in CO-RE relocations may
make GCC-built objects, which appear to emit sign-extended values
(unverified), fail to load with -EINVAL, in libbpf and kernel
bpf_core_apply().

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c

[ ... ]

> @@ -875,10 +882,7 @@ static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
>  		if (!spec)
>  			return -EUCLEAN; /* request instruction poisoning */
>  		t = btf_type_by_id(spec->btf, spec->spec[0].type_id);
> -		if (btf_is_enum(t))
> -			*val = btf_enum(t)[spec->spec[0].idx].val;
> -		else
> -			*val = btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
> +		*val = bpf_core_enumval(t, spec->spec[0].idx);
>  		break;

Can this break objects built by GCC?

bpf_core_patch_insn() compares the local (orig) value against the
instruction immediate using a full 64-bit compare.  In the ALU path that is
insn->imm != orig_val, where the int imm is sign-extended, and in the
LDIMM64 path it is:

    (__u32)insn[0].imm | ((__u64)insn[1].imm << 32)

Clang emits unsigned enumerators zero-extended, which is the case this
patch fixes.  From reading the GCC source (not verified by compiling), GCC
appears to emit every 32-bit enumerator sign-extended:

gcc/config/bpf/core-builtins.cc:pack_enum_value() {
    ret.reloc_data.default_value = enum_value;
}

bpf_expand_core_builtin() then does expand_normal(data->default_value) and
wraps it in an UNSPEC.  An SImode CONST_INT is stored sign-extended in RTL,
so 0x80000000 would be printed as 0xffffffff80000000.  GCC's btfout.cc also
sets btf_kflag to BTF_KF_ENUM_UNSIGNED, which is 0, for unsigned enums.

For a GCC-built object calling bpf_core_enum_value() on an enumerator of
0x80000000 in an unsigned enum:

Before this patch, *val was the sign-extended 0xffffffff80000000, which
matched the instruction.

After this patch, btf_enum_value() returns 0x80000000 for kflag == 0, so
bpf_core_patch_insn() would report "unexpected insn #N (ALU/ALU64|LDIMM64)
value: got ..., exp 2147483648" and return -EINVAL.  The same code is built
into the kernel through kernel/bpf/relo_core.c, so bpf_core_apply() is
affected as well.

Would objects built by Clang now load while GCC-built objects that loaded
before are refused?  The core_reloc/enumval tests are not in
ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc, and the test added by
0aff1079d5e1 ("selftests/bpf: Test CO-RE relocations of unsigned 32-bit
enum values") uses UINT_ENUM_VAL1 = 0x80000000, so it may show this in the
test_progs-bpf_gcc lane.

Could the validation for 32-bit enums compare only the low 32 bits and
accept upper bits that are either zero or a sign extension?  Alternatively,
the GCC encoding could be determined before changing orig_val.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44347609693
--===============4923379696212313141==--
