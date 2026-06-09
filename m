Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63746AEFB
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017824; cv=none; b=VJafSXxvXTA+a+LkQ1+jxoQay8gQ9gprg6fbD4tVuy1yQCEY1XkvvpUyVlwy1q+0WSq2zVjc8d75CbuPX2YAHNStfGnXaES96ThFBMkx4BsfXc+yaHAz8IZGBKPZo7QJUDi12/PEvISnAUHAgX1abpUxalc0yxyX5cXtMxCRlD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017824; c=relaxed/simple;
	bh=7tFvcLRgr1Oz3FHp9pHN7MppJqlaRAvNVSUCF93em3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iLyjGwJIsmmgsZIedfuBCEV7ItosZ9zgtn//Oi+oaU86Il37shJ0pCISMRKO9Y1DKy5jQFSrNDQpE9lZaUnWV0OQ7kpw8NMFuXrVH35L10w0IoHcNvoYFTEJpeCUMuyBfXwAGrMzEf3ba5GhTSTGo6ErZaeP9Bp1Gqdaedi1Zig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUF3Acct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUF3Acct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678141F00893;
	Tue,  9 Jun 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781017819;
	bh=x7xw55vDddNGWsmECuGz4hbdpg2S7wwkckOsB2h7dkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eUF3AcctQlUk1QvqSQ+tffeX0IDHQz7KoFu0c7bN1m+WJawi9IygR7lR/ZHjvdX8h
	 g0oF0x6A4VerO82TNEFHTgCgQHhi33NNTM6LPgKXI3gXSprggW1VAEXpVSJqpv5X5c
	 6owV0JXTBJ8KIUYoA4hJQBabY5oN79z+PYnE6ZrOx26SNQ1Jxz8p301EqfR6wLpWLw
	 8q/+QgSMUfa4/ya89zqOCAVy8Qsr8nQ5mCi5vVuUQTdluI+21MfDz3c1gNpBo0ugQ4
	 wo9KXNydPntAvORXsiFV9P7/FpCEbY71v8Czee7+RJ8CeSFMmrZLOoHJo94Xto/mqu
	 Grpjf8As1T0SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject scalar addition from untrusted
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
References: <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:10:18 +0000
Message-Id: <20260609151019.678141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch only prevents `scalar +=3D untrusted_ptr` (BPF_ADD) =
but fails to reject other ALU operations like `BPF_SUB`, `BPF_XOR`, and `BP=
F_MUL`. This allows attackers to trivially bypass the new check and trigger=
 the exact same verifier type-confusion bug.
--

commit cfb0cd2267dc0023c68b5a917127e38cfcf1a758
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

bpf: Reject scalar addition from untrusted memory

This commit attempts to fix a verifier issue where an untrusted PTR_TO_MEM
is added to a scalar, which would previously return early and leave the
verifier state stale. It rejects the addition before the early return,
while leaving pointer +=3D scalar handled by existing rules.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd7099..c6b350f9585ae 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14823,6 +14823,14 @@ static int adjust_reg_min_max_vals(struct bpf_ve=
rifier_env *env,
>  				 * This is legal, but we have to reverse our
>  				 * src/dest handling in computing the range
>  				 */
> +				if (opcode =3D=3D BPF_ADD &&
> +				    base_type(src_reg->type) =3D=3D PTR_TO_MEM &&
> +				    (src_reg->type & PTR_UNTRUSTED)) {
> +					verbose(env, "R%d tried to add from %s to scalar\n",
> +						insn->dst_reg,
> +						reg_type_str(env, src_reg->type));
> +					return -EACCES;
> +				}
>  				err =3D mark_chain_precision(env, insn->dst_reg);
>  				if (err)
>  					return err;

[Severity: Critical]
This isn't a bug introduced by this patch, but by restricting this check
explicitly to BPF_ADD, does this leave other ALU operations like BPF_SUB,
BPF_XOR, or BPF_MUL vulnerable to the same regression?

If an attacker uses BPF_SUB or BPF_XOR (e.g., scalar ^=3D untrusted_ptr),
the new check is bypassed. The code then falls through to calling
adjust_ptr_min_max_vals(), where it hits an early return for untrusted
PTR_TO_MEM:

kernel/bpf/verifier.c:adjust_ptr_min_max_vals() {
    ...
    if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type & PTR_=
UNTRUSTED))
        return 0;
    ...
}

This early return skips the validation block that would normally reject the=
se
unsupported operations on pointers. This accepts the instruction without
updating the scalar's verifier bounds state, while its actual runtime value
is manipulated by the pointer.

Can this verifier state desynchronization be leveraged to achieve
out-of-bounds access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-f01-03-sca=
lar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn?part=3D1
