Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4C3BCD26
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001087; cv=none; b=dQAIFgO0uDzM8Ld0wBj684Hi6C3hhbSEMytPgXOEss/bH2jomUv4YQ+S47uJgEy+Ntf363RAhbZoQlrlA1zOQWat+GtTV4qr82t0fCkSqEHpFh1hD6Q/327Wr8CE03ydrlDwd0QIcitn9ldMUCgQb8iFFdEnev2fLyaqyRTBrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001087; c=relaxed/simple;
	bh=afLRo5nxPZ5GOlB+xhsiXt6r+d8uK/V6XJLuSFQ/M3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3g5Hh+ru9pI8yogN/VMQLGoBk/qMXRbe8jLvdlyoN3IrEgLR84XAnagKjy7tqaN+EKqiKEQQVC3vxgDpvJ3g2t204MVrjzBHb+1cu1XDxc9T1QFMV6injEfPl4MKx1vZcq5diBlknxMi6eGmXyER0VT/CkQgdPzu5f5ORlWirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUlq3Bhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUlq3Bhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67591F000E9;
	Mon, 17 Aug 2026 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001085;
	bh=uddfXaMkmWwwsZVsBxdv4cLASBaDxSB0GM/7RIM6n8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUlq3BhqdDDOHFH1rsat4dfe73MblEOjL5Kq9ZJbdfbyF5ElugtjnDSB3bCR8YTms
	 noXxm/a4VpHTBN3wU1AamUN2GwzKkSNKhvbX0kMWJiKEu3LYDHUrP+LkY9AaJ42weN
	 /tiqUzyp5rDuhK+k4EdRnn+rKIudBF5HfO9sfqzGaKmfMrKkWd+NMlcLyFi4YlgGzs
	 SWeOcaw3hKUVb4EQL2X3+WzjmwOzRNZqOCzQhskHi1kgx8USRGtD6sMeLOH5K4QVcI
	 mN1NCbjCrmm5w9VVJlU2nAhTn3OSJYqMRMMVa7wLjfvgRjuD9HVIj+28yyydH7y0hr
	 8TA0lTf/wjdLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:11:25 +0000
Message-Id: <20260817211125.A67591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch silently rejects callback subprograms with stack argum=
ents by returning `-EINVAL` without emitting a verifier log message.
--

--- Patch [1]: [PATCH v2 1/2] bpf: reject stack-argument callback subprogra=
ms ---
commit 0a06c150da6a5163953fb53d000c974d1e9a97dc
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

bpf: reject stack-argument callback subprograms

This commit rejects callback subprograms that declare incoming stack argume=
nts
when processing callback calls. It prevents out-of-bounds reads in callbacks
that attempt to read arguments from the helper's native frame instead of the
synthetic verifier values.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fdc5fbb1f78ca..5fcefc0eaba00 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9285,6 +9285,8 @@ static int push_callback_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *ins
>  	err =3D btf_check_subprog_call(env, subprog, caller->regs);
>  	if (err =3D=3D -EFAULT)
>  		return err;
> +	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
> +		return -EINVAL;

[Severity: Medium]
Does this silently reject the callback subprogram without providing a verif=
ier
log message? Returning -EINVAL without using verbose() leaves the user with
an opaque error when a BPF program uses a callback subprogram with stack
arguments. Would it be helpful to add a verbose() log here to explain the l=
oad
failure to BPF developers?

> =20
>  	/* set_callee_state is used for direct subprog calls, but we are
>  	 * interested in validating only BPF helpers that can call subprogs as

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817204812.1637=
171-1-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
