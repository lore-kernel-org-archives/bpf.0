Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452082C21C4
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219914; cv=none; b=O4Ept/nFs2ifxpg9uvPBoBWd2KlQBIm/73ERcJJ42lW8cxx8OD8EzYKQqB/r+g/SJ6X8cY3b/90BxSpJxdzkPN0dgSOuj3eF0xe69+MLzB6uUa391N1ZQhCvE1RTt0YusWxL7vAN1l6/OcODP4Pwq0q/ZFiythLgShScKAudUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219914; c=relaxed/simple;
	bh=aM5b5vNx6lnROqXxqIiYbMqcU2KE+K9FYUrL8vdt3yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aBfLD72S1YPKy7TMAh2S/ft5NPGZxjomYMdOtlShEBOQIVn6FnbDx1WM+sEJ309HiBkTKKQI0//zzuKo5qb8qz49VlKuDa4EQnNJ06XvGCUzkeVYP6N7+/8tMX1OfKOOLRxMX+Nqwdn7j4/Q+s0rjxvfJ/VhCEm5qytSvfESwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn4xC9+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn4xC9+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0A51F000E9;
	Tue, 23 Jun 2026 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782219912;
	bh=x02nPPcOcl/JckPjCCtFsnbCgNv6RKH/PgdInaQV8xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bn4xC9+cBGyTr0X5TzeoeN94Gzy2W3uKNVFImu5lInshcFCKr9agLS3RUz6/gVIwM
	 2rkw+lhHj8jxtO9gK/jbV+i3WIU6pgSEr+rBAfz1OHjaLAS4h+TwHiZ6xCI/YgVkuG
	 bmcm9C0x9RKI1GoRogl4QW9QEuoBtooHpaONjnvkrxd5JcKsx07+EyQaofhXWOXbuO
	 gxsTgNypYvPf9tzL3XMPT57dBzM8Wg4FWDdSXKWfduSGaWZjeHygrO5fpkRPwM1vHY
	 EKzvzHCjUEaRS5W7buCK1dCzQUOQ+wxbyyCWFj1Th6Rkf4WDmxvo+IvOl8Y1OQ5X1u
	 PgeyWycTbPvBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Cover pseudo-BTF ksym
 log masking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-2-a190ebb8f3e2@mails.tsinghua.edu.cn>
References: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
 <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-2-a190ebb8f3e2@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:05:12 +0000
Message-Id: <20260623130512.BA0A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unprivileged arbitrary kernel memory read via BPF_PSEUDO_BTF_I=
D leading to KASLR bypass and data leak.
--

commit 8c947383f7091d6bcf372bba38b8938dbc9b02e4
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: Cover pseudo-BTF ksym log masking

This commit adds a selftest to verify that an unprivileged raw socket-filter
can load the bpf_prog_active typed ksym. It ensures the load is accepted
and that the verifier log correctly masks the ldimm64 immediate address.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index c16f8382cf17d..16de1595f0157 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c

[ ... ]

> @@ -77,6 +79,23 @@ __naked void dummy_prog_loop1_socket(void)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__description("unpriv: pseudo btf id log masks address")
> +__success_unpriv
> +__msg_unpriv("0: (18) r1 =3D 0x0")
> +__not_msg_unpriv("0: (18) r1 =3D 0x{{[1-9a-f][0-9a-f]*}}")
> +__retval_unpriv(0)
> +__log_level(2)
> +__naked void pseudo_btf_id_log_masks_address(void)
> +{
> +	asm volatile ("r1 =3D %[bpf_prog_active] ll;"

[Severity: Critical]
This is a pre-existing issue, but by validating that unprivileged programs =
can
successfully load BPF_PSEUDO_BTF_ID instructions against btf_vmlinux, does
this highlight a potential KASLR bypass and kernel memory leak?

When an unprivileged user loads a BPF program using BPF_LD_IMM64 with
src_reg =3D BPF_PSEUDO_BTF_ID and the BTF ID of a non-struct kernel variable
(such as bpf_prog_active), __check_pseudo_btf_id() assigns the register
type PTR_TO_MEM | MEM_RDONLY:

kernel/bpf/verifier.c:__check_pseudo_btf_id() {
    ...
		aux->btf_var.reg_type =3D PTR_TO_MEM | MEM_RDONLY;
		aux->btf_var.mem_size =3D tsize;
    ...
}

If the user then issues a memory read instruction against this register,
check_mem_access() processes PTR_TO_MEM without enforcing
env->allow_ptr_leaks (unlike struct reads in check_ptr_to_btf_access):

kernel/bpf/verifier.c:check_mem_access() {
    ...
	} else if (base_type(reg->type) =3D=3D PTR_TO_MEM) {
    ...
		if (!err && value_regno >=3D 0 && (t =3D=3D BPF_READ || rdonly_mem))
			mark_reg_unknown(env, regs, value_regno);
    ...
}

Could this resulting SCALAR_VALUE then be extracted via maps or return valu=
es,
allowing unprivileged attackers to read sensitive non-struct kernel variabl=
es?

> +		      "r0 =3D 0;"
> +		      "exit;"
> +	:
> +	: __imm_addr(bpf_prog_active)
> +	: __clobber_all);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-f01-13-pse=
udo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn?part=3D2
