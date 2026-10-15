Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E383DDDDB
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108467; cv=none; b=Iv8vCWUETbf2OVqLPnIgf2Y7cc7lasd2vrj7ZSjgndbqgNXXSDTmO+K8Mcx6salCDjWT1uht+s/r4yd4gfBH27RqtAjAw60WR3rPquRo4sPqbQB0ytuWGVXGV3iHyxCaRX8JJW1c3EADR+tSvEaS1LryFndwdQOKGk8QpknTf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108467; c=relaxed/simple;
	bh=/gejSnB13MZOhRYUe0M/h+nvXcy+j33d14U6isrxcm0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=dov3z/qR9eaj4JulechZItB1lDH5qyx0WcZeyR6Apw7l5j2z80zSVAQH1T8Z3dc8AUqaHhjZiciZqq+xrKKSf1QglgQv55LDYZr4X0DXly1+mCEkiq1XPz/l639crnPWLWhiQjztw51IRvr+TfmnnxGLITyLjkmV5Xp9SL0LVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpwMzPFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpwMzPFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935FB1F000C4;
	Thu, 15 Oct 2026 23:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108465;
	bh=j5ZNPLJHxmd4BLbAcGfVM2PxlQogXU9uwMzZjAhG7Ms=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HpwMzPFx1Qa/kw2Wk5bskwFW85FkMdNzcP3QcmAa53FWwagv6Bd6wMFMV9XAeyvor
	 rsgm6hMHH2B22UilfZCYVIILaDa4FsVCqcxgde6Un0BAmoTSIQpiKNjldKB8cMJFkf
	 41cybrxRuzEO5VGzqHTEJQZcUUP/ZRUYxTbSzEql7RcnVaFZZJHjidsQSu9Gf3rFrE
	 mq06olUKKbPltJ/ypy6whEKijd6NtCwcoaj9lceUvu2JbIyKfmNaYe/hz5yBq/LUGx
	 v0+d5EtzSnte/XyXeMcSRH1gd4vEm3K10PvZVYAHZxOXbNfrU8FQlrZxz+E0nifGDI
	 Qjxz7KV5m7QDQ==
Message-ID: <sashiko-outbox-173494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261015234125.3152346-7-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
 <20261015234125.3152346-7-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 23:54:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: PTR_MAYBE_NULL is lost when reading __nullable members from=
 untrusted pointers
--

commit 6e594b49287fcdc28cc76204149bfee8d35d1dd9
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Recognize __nullable on pointer members of kernel structs

This patch teaches the BPF verifier to recognize the __nullable BTF type tag
on pointer members of kernel structs. It reports these as PTR_MAYBE_NULL,
intended to force BPF programs to check them for NULL before dereferencing
them, even when read through a probed pointer.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f143b1b18b5ca..b4d9ad3ca966b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6712,9 +6714,9 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
>  			 * aggressively mark as untrusted otherwise such
>  			 * pointers will be plain PTR_TO_BTF_ID without flags
>  			 * and will be allowed to be passed into helpers for
> -			 * compat reasons.
> +			 * compat reasons. A __nullable member stays nullable.
>  			 */
> -			flag =3D PTR_UNTRUSTED;
> +			flag =3D PTR_UNTRUSTED | (flag & PTR_MAYBE_NULL);
>  		}

[Severity: Medium]
Does the untrusted pointer path just above this block also need to preserve
PTR_MAYBE_NULL?

Looking at check_ptr_to_btf_access(), if the parent pointer being
dereferenced is untrusted, the code executes this branch:

    } else if (type_flag(reg->type) & PTR_UNTRUSTED) {
        /* If this is an untrusted pointer, all pointers formed by walking =
it
         * also inherit the untrusted flag.
         */
        flag =3D PTR_UNTRUSTED;

When btf_struct_access() processes a __nullable pointer member, it sets
PTR_MAYBE_NULL in the flag variable. However, because this assignment
overwrites the flag entirely, the PTR_MAYBE_NULL modifier is discarded.

As a result, the pointer is typed as PTR_TO_BTF_ID | PTR_UNTRUSTED without
PTR_MAYBE_NULL. The verifier forgets that the pointer can be NULL, bypassing
the required NULL check and violating the explicit design intent described
in the commit message.

Will BPF programs be able to bypass the verifier's mandatory NULL check
for __nullable members of untrusted pointers because of this?

>  	} else {
>  		/* Old compat. Deprecated */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015234125.3152=
346-1-memxor@gmail.com?part=3D6
