Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690723B38AA
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885865; cv=none; b=r/iZqaKjM5p5kqQGhD8sP20dcvhkOGQ+IYpgJG2Wrfqv6jmX3u9Q2r3FOq/8TbwqZtTbjYm2WV2jqejGxv8eIJUrRByvBXVC+CDfIvjt5UYAey5mlk8o81/kDigG4q5lMPgbMcIliU3mvXk9FDgYwE3d4jg/lha2w9sn9cgQVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885865; c=relaxed/simple;
	bh=TDppbc35T4vhbhgno2ei2F4nDNc4OtWWTAWIzmfseg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6j/vhjwa+LH0EEjp1xI+SKb67BsfqZfmhYdw7Ek4QTSb7a5hz6nW+eEgUyXTMZ37ajAWq3ii4kOfzj6jeBFXUimNh6tXoP/Q8ZDeYVWRskr6aRA7SOlK3lq7IG0N9ahv4+juysEJEpgwcL95vcGXK5MZ037KKhcv51fR3Uv1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd1wM0x7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd1wM0x7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDD1F000E9;
	Fri, 19 Jun 2026 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781885862;
	bh=QQso15NpjcPVkcN49D0alf5DNsvVtsRXsWW5vKArmmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vd1wM0x7mmEVdLm5wnpeMCaLVOjCE1L6ZvBTVdSo6qHiFBcLhHhPP6SuT/186DA+U
	 VcG108f+SlzpKyal45uVLNDDVmKiagEQiJkAS2R9sTDZUHm8z3my+mBgVNNVvuz+0d
	 Y9oEhGBHqdk9P0ImlAc2pHxbsPSQi1KYQfLxV6iTQedlfrlOln+66ZxqWt7C8La42z
	 RIc0iabFwa9XoEYsAQFtdyZVoDg+dNw6niz3OhlMaU+eB7TxaoxbXpCFNIIguB8xgC
	 pEUIwUjoNmVZBRN9SC340pBn6Ra/YKu7nlFBjDPyEz3vpVKfxSffV5sUcyaBCFpEEl
	 k22UP44WvEb4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Require CAP_BPF for pseudo-BTF ksym
 loads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-1-f950f69fe60c@mails.tsinghua.edu.cn>
References: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
 <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-1-f950f69fe60c@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 16:17:42 +0000
Message-Id: <20260619161742.8DBDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF_PSEUDO_MAP_IDX and BPF_PSEUDO_MAP_IDX_VALUE bypass pointer lea=
k protections in the verifier log, allowing unprivileged users to leak kern=
el map pointers.
- [High] Users with CAP_BPF but without CAP_PERFMON can leak kernel symbol =
addresses via BPF_PSEUDO_BTF_ID.
--

commit eb6468c26c927b42e4085a370817e6247920a14e
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: bpf: Require CAP_BPF for pseudo-BTF ksym loads

This commit restricts BPF_PSEUDO_BTF_ID loads to callers with CAP_BPF. It
aims to prevent unprivileged users from using the verifier log to leak
resolved kernel symbol addresses.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce0..dbf5df995fc24 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17639,6 +17639,11 @@ static int check_pseudo_btf_id(struct bpf_verifi=
er_env *env,
>  	int btf_fd;
>  	int err;
> =20
> +	if (!env->bpf_capable) {
> +		verbose(env, "BPF_PSEUDO_BTF_ID loads require CAP_BPF\n");
> +		return -EACCES;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does checking only for CAP_BPF fully
prevent kernel symbol leaks here?

Pointer leaks typically require CAP_PERFMON, which is checked via
allow_ptr_leaks. If a user has CAP_BPF but lacks CAP_PERFMON, they can still
reach __check_pseudo_btf_id(), which uses kallsyms_lookup_name() to resolve
the concrete kernel address and embeds it into the instruction's imm field.

Because BPF_PSEUDO_BTF_ID is omitted from the is_ptr check in
print_bpf_insn():

kernel/bpf/disasm.c:print_bpf_insn() {
    bool is_ptr =3D insn->src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
                  insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE;

    if (is_ptr && !allow_ptr_leaks)
        imm =3D 0;
    ...
}

Could triggering a verifier error dump the resolved kernel symbol address
unmasked into the log buffer, allowing users with CAP_BPF to bypass the
CAP_PERFMON privilege boundary?

[Severity: High]
This is also a pre-existing issue not introduced by this patch, but while
reviewing the pointer leak protections in print_bpf_insn(), it appears
BPF_PSEUDO_MAP_IDX and BPF_PSEUDO_MAP_IDX_VALUE might also bypass the
masking.

When a user loads a BPF program with fd_array and uses BPF_PSEUDO_MAP_IDX,
check_and_resolve_insns() resolves the file descriptor to the direct kernel
pointer and embeds it into the imm field:

kernel/bpf/verifier.c:check_and_resolve_insns() {
    if (insn[0].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
        insn[0].src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
        addr =3D (unsigned long)map;
    }
    ...
    insn[0].imm =3D (u32)addr;
}

Since print_bpf_insn() strictly checks BPF_PSEUDO_MAP_FD and
BPF_PSEUDO_MAP_VALUE, could this also allow users to leak kernel map
pointers if verification fails and the instructions are dumped to the log?

>  	btf_fd =3D insn[1].imm;
>  	if (btf_fd) {
>  		btf =3D btf_get_by_fd(btf_fd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-f01-13-pse=
udo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn?part=3D1
