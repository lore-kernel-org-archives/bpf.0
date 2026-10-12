Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6F42046F
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813258; cv=none; b=kGX1yC28iGA5lXo3IVQsMMYSJZswM8lAYVXHF6RxpG1GuNfLQ/jPh4yuQGyfCw2Z/RVdmSj1jA7ql7GjfbpeF7E7WjGW4HkNz/hGWiBfM6ELp2gk6UAm7lYDB4a1Y7og+6OPQgTNAu10VrPmHIWr+qqe/kZ56YkiyDIJybKmZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813258; c=relaxed/simple;
	bh=PbuQRqueOXyIOgh5Gh2Bp9FRqluW3xjNWK6nX38zeo4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SP1Buztb7oDA/RTiI0JrLbZOMTINoC6CjnsyEE1Tnw8nLb4/GbE366qjFbzob07y0xBS+IeVsN6Dck2VCAOwndS4s1um0pA1yjqwTWvCD6mVJQYia2hqOLaRpDjfve22GCVEav6M/mGOkZoFKWq9dscojfVgbq+BeVdeQTcQuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZnaWF5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZnaWF5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CBD1F0089B;
	Mon, 12 Oct 2026 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791813256;
	bh=aBFgouB4uiJz/XXKd063nkM48xwcB+ShsDjKt67Hikw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZnaWF5d3KLDBvOlPPGNkg+dsP9wxLXiHcYpi2PbpC5CKa7oYEtrxRAFVkKT2aMEY
	 5C7b9KlUdnV5v3v8r9M2NYv9z/sF8m0ENOeHP5NATh0cKfijNxIIYocZYZtRO2Es3B
	 79u40WwY+zYjkDpKscUBpqjT4IpqjFLAwzCfDbINhVvxTGauQR/0HUU65+oFaZhDpI
	 8goqzGNCOpjrt0T+9bTvl1uDg/mtLmIr5uN1rVc9avx0Lh/RIIPz0xGohR7DBRyMUc
	 8D/iNwZ1+UV1Kt/mn8sO4kdBP/mn8q9EAz7vuemz4oOyel92oP6e5iykCB4iOTa68a
	 11OSBChWBzTCA==
Message-ID: <sashiko-outbox-168221@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 02/10] bpf: Recognize __nullable on pointer
 members of kernel structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261012133711.4030594-3-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
 <20261012133711.4030594-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:54:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: MEM_RCU map pointers bypass PROBE_MEM and NULL checks
--

commit cd9a005edc33a27f4ea8950cfa7c36fe9d72a985
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Recognize __nullable on pointer members of kernel structs

This patch teaches the BPF verifier to recognize the __nullable BTF type tag
on pointer members of kernel structs, assigning them the PTR_MAYBE_NULL fla=
g.
The flag is kept on trusted and RCU pointers, forcing BPF programs to
explicitly check them before use.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2f190abe34489..70fd44a6e1c56 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6785,6 +6792,8 @@ static int check_ptr_to_map_access(struct bpf_verif=
ier_env *env,
>  	ret =3D btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_i=
d, &flag, NULL);
>  	if (ret < 0)
>  		return ret;
> +	/* Nothing walked from a map is trusted, a __nullable member changes no=
thing. */
> +	flag &=3D ~PTR_MAYBE_NULL;
        ^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does stripping PTR_MAYBE_NULL here allow MEM_RCU map pointers to bypass both
PROBE_MEM and NULL checks?

When a CAP_PERFMON BPF program reads an __rcu-tagged pointer field from a m=
ap
structure (e.g., trie->root in struct lpm_trie), btf_struct_access() evalua=
tes
the tag and returns MEM_RCU in flag.

If we explicitly clear PTR_MAYBE_NULL here without clearing MEM_RCU or addi=
ng
PTR_UNTRUSTED, the verifier assigns PTR_TO_BTF_ID | MEM_RCU to the destinat=
ion
register.

Since bpf_may_fault_on_deref(PTR_TO_BTF_ID | MEM_RCU) evaluates to false (a=
s it
expects exactly PTR_TO_BTF_ID or the PTR_UNTRUSTED flag), the load is not
rewritten to BPF_PROBE_MEM. Because PTR_MAYBE_NULL was stripped, the verifi=
er
will permit the dereference without a NULL check.

At runtime, reading from a NULL pointer (like a NULL trie->root) would then
perform a bare memory load and crash the kernel. Does this active stripping
prevent the new __nullable tag from protecting these vulnerable pointers?

> =20
>  	if (value_regno >=3D 0) {
>  		ret =3D mark_btf_ld_reg(env, regs, value_regno, ret, btf_vmlinux, btf_=
id, flag);
>  		if (ret < 0)
>  			return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012133711.4030=
594-1-memxor@gmail.com?part=3D2
