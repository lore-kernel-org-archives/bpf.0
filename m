Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E01DC985
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782580338; cv=none; b=Y7x2rJfts7XoLxJJEhtOyr2RIdbJCmwO4kxNYhrPpDiNqUfTaGScwEFsbETyDEi5A6l5dpnb9bwWtttz+zd7G+tKSjkOvbPQi6pHz9/SuOCmbNgA2k6gu/Flom3riuc/xqfeVfh8M/p7oRkH85DZoZox6wmZhTf6TScvi9N67Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782580338; c=relaxed/simple;
	bh=4C7+ZlvBM880SZ5QT2UQPAm3Z+bLLMeY2T3Son5DllQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fQ50wOkWzunPIPu9j8uL42gtCZ9JskIDlyyf+PWrHOUYtmxydsqvkJn7oSL+L6Aj2/+HmAqMHMaqgHADqeFh8qeV54PwozF8Jp7xGEx23jgVtXWQm7GKRGpmEnIpj09aH/DgaQo8tzQKmc00v5CacySMAG/PYJCh2pufIjRnMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R30oIF0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R30oIF0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88391F000E9;
	Sat, 27 Jun 2026 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782580337;
	bh=rYPs+vk47eRLfKOi0uXyEjQEQZeGiA7phGxLIpHntek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R30oIF0Vu0D3hVqyG7twSp6FvMA4Wv9Gp8RfQBzg1DDI6zXx3pBvOwU/5CgVUqUGE
	 bv++LgBg+VSSL5pNX80mg8I1Ia6GY5iGnBtmJHhnHKttNK/1eIxTbF+8hvrAZVXsvo
	 rb4vov7Yo7s8+6R+awioTHiI3UMh1lx2JipmKYiixGz+IdFnMgVf5FPjcPHWZgEA7r
	 clJoHGJlHZdglmLzK10bc5ZgAFKwaFejONtKf7lIl2HjDWNpD8QuHxHMrRdsAEEbzZ
	 aF+Yjmjp7FCMmT+Roo0EnNwhieMdz5eF7Enfr1UnKcXNIuMQl2xJ6xzgLv3sXCpxZ0
	 /6qK0hCLNp6uA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 10/12] bpf: Support attach and detach for
 SDT observer program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <1b13b561aae721fec70107256228a77fbc0e8987.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <1b13b561aae721fec70107256228a77fbc0e8987.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 17:12:16 +0000
Message-Id: <20260627171216.D88391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Trampoline key space collision between SDT probe offsets and B=
TF Type IDs leading to verifier bypass and arbitrary memory access.
- [Low] Multi-line comment opening is not on its own line, violating BPF su=
bsystem guidelines.
--

commit b1194a14a242f8613863b3524830be07aca1a7e7
Author: Xu Kuohai <xukuohai@huawei.com>

bpf: Support attach and detach for SDT observer program

This commit adds support to attach an SDT observer program by reusing the
bpf trampoline attach and detach mechanism. The trampoline is keyed by
the target program fd and the offset of the probe. The function prototype
is resolved from prog->aux->sdt_probe.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 93c196f38b878..6548a2dd76da6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1270,6 +1270,12 @@ struct btf_func_model {
>   */
>  #define BPF_TRAMP_F_INDIRECT		BIT(8)
> =20
> +/* Trampoline is for an SDT probe site: arguments arrive in
> + * BPF registers recorded by the SDT macro at build time,
> + * described by btf_func_model.arg_regs[] instead of ABI order.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style?

The opening block comment normally has the text starting on the next line:

/*
 * Trampoline is for an SDT probe site: arguments arrive in
 * ...

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8b2c73bb6c2a8..53897ff1100fa 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> +static int bpf_sdt_link_attach(struct bpf_prog *prog)
> +{

[ ... ]

> +	err =3D bpf_link_prime(&sdt_link->link.link, &primer);
> +	if (err) {
> +		kfree(sdt_link);
> +		return err;
> +	}
> +
> +	/* use orig_off to compute the key as orig_off is unique for each probe=
 */
> +	tr_key =3D bpf_trampoline_compute_key(tgt_prog, NULL, sdt->val.orig_off=
);

[Severity: Critical]
Does using sdt->val.orig_off here create a risk of trampoline key collisions
with BTF Type IDs?

Looking at bpf_trampoline_compute_key():

include/linux/bpf_verifier.h:bpf_trampoline_compute_key() {
    if (tgt_prog)
        return ((u64)tgt_prog->aux->id << 32) | btf_id;
    ...
}

Because the instruction offset is passed in place of the btf_id, an SDT pro=
be
at an offset could generate the exact same 64-bit key as a subprogram with a
BTF Type ID matching that offset.

If both an SDT observer program and an fentry program attach using this same
key, they would share the same trampoline.

Could this allow the verifier to treat arbitrary scalars from the SDT probe
context as trusted pointers if they are passed into the fentry program?

> +	tgt_info.tgt_addr =3D sdt->probe_ip;
> +	tgt_info.tgt_name =3D sdt->val.name;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D10
