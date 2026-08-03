Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61529400966
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769039; cv=none; b=JeK5Qmy3JgldDulCP6yv19wlrosOWvmcT4OwUWpYb+o+ydbzM39h4exkrVyz0veJDHQJ0cHCAUnmWJ8ccrmDGtkKlemtGrpTCl6E2qM78WghpdJdKLoz3XpjYljuvbKH6EigCK/gbYVRpEcVAgzhPrlV0wHlx/16VC5juKyagSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769039; c=relaxed/simple;
	bh=7Fi/7uJTOf41ey1A4hhmMHGm3EzsQszyWDsr9DqMjOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KhNViRpeR0YX6wfw+ZWCTdlmzT1VHBFwYGG/8oHKEbWLjqC0H7KoAFF+VYUcBZ0F9qkzRUBB7gRb9z+ZgLoDKq/mYjjTWMPI1mQe5ZkplcSbXEwoy7lAQOTapGbnxCqkIdmXGcQTchPuMdIU2+FZNWClhAbcc8cF4dCd89PB+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSWH/x/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSWH/x/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D941F00A3E;
	Mon,  3 Aug 2026 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769037;
	bh=Tjj+QHHu2ggVxUkEwHGUuhi6P3gnVtP704rH4M4SMA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lSWH/x/ON1FfCq6prEMwiqm3wBU1yehJg6nT7/LIADsCEZ/ZrJMufKZV1EKGDnfsB
	 Wd7Umvau8gckTZ9pc6S0d7xUfkzaSnnkJ7yqtGaBYO5e9FyhfNkab8a2hN2afHWxrT
	 JzgCzrCpzOqorB6A2ZTtNYgdvoY3zi/Il+CAmT73tC0Iivw4cR5VmhBQ44K+iTnfIg
	 RiCUImvFLW703WFmUn9XgVV6uQvjytVsGxSmGPuVCgnphI726phug8ynkImZHtMYID
	 DgfpfTmFvnGCAZkXQIVIkBocxdKMQ0ClL52ewrgGn5M4dEGq9uim4oNPQn37lL7SSs
	 subi2hJe82hkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix sanitize_err() register selection for
 BPF_K
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803-c3-035-sanitize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn>
References: <20260803-c3-035-sanitize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:57:16 +0000
Message-Id: <20260803145717.56D941F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch modifies `sanitize_err()` to handle `BPF_K` instructio=
ns, but this code path is mathematically unreachable because BPF_K instruct=
ions bypass ALU sanitation entirely.
--

--- Patch [1]: [PATCH bpf] bpf: Fix sanitize_err() register selection for B=
PF_K ---
commit 08e8e3769c4c795ad93d26ddc7c02599ba8cab32
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Fix sanitize_err() register selection for BPF_K

This patch modifies sanitize_err() to correctly report the destination
register for BPF_K instructions when generating ALU sanitization errors.
It ensures the source register field, which is zero for immediate
constants, does not interfere with the diagnostic output.

Closes: https://lore.kernel.org/bpf/20260729153536.F3E2E1F000E9@smtp.kernel=
.org/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13562,6 +13562,7 @@ static int sanitize_err(struct bpf_verifier_env *=
env, const struct bpf_insn *ins
>  	static const char *err =3D "pointer arithmetic with it prohibited for !=
root";
>  	const char *op =3D BPF_OP(insn->code) =3D=3D BPF_ADD ? "add" : "sub";
>  	u32 dst =3D insn->dst_reg, src =3D insn->src_reg;
> +	bool src_is_imm =3D BPF_SRC(insn->code) =3D=3D BPF_K;
>  	struct bpf_reg_state *regs =3D cur_regs(env);
> =20
>  	switch (reason) {
> @@ -13571,7 +13572,7 @@ static int sanitize_err(struct bpf_verifier_env *=
env, const struct bpf_insn *ins
>  		break;
>  	case REASON_TYPE:
>  		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
> -			regs[src].type =3D=3D SCALAR_VALUE ? dst : src, err);
> +			src_is_imm || regs[src].type =3D=3D SCALAR_VALUE ? dst : src, err);

[Severity: Medium]
Is this code path actually reachable for BPF_K instructions?

Looking at can_skip_alu_sanitation(), it appears to unconditionally return
true when BPF_SRC(insn->code) =3D=3D BPF_K:

kernel/bpf/verifier.c:can_skip_alu_sanitation() {
        return env->bypass_spec_v1 ||
               BPF_SRC(insn->code) =3D=3D BPF_K ||
               cur_aux(env)->nospec;
}

Since sanitize_ptr_alu() and sanitize_val_alu() both check
can_skip_alu_sanitation() first, won't they always return 0 for BPF_K?

If so, this would prevent sanitize_err() from ever being called for these
instructions, making this new logic unreachable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-c3-035-san=
itize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn?part=3D1
