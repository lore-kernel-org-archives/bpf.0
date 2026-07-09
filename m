Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A89406816
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593335; cv=none; b=RmdeH+f517wMf9zdzq9hVlKFn3tiqzreMks+pimZkZNOOAGyfAyrJZWFzDdT5o4PKu22xXgZQIMqZQ6uCKWXbcGU9OsQSe3JdOouD+jdVjHk2oadVFg91PHuHRRWiQt02BfipxdWsQFSJdzvcXItizpqpa6gcqmqnf2VUfXu4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593335; c=relaxed/simple;
	bh=3QyryRvLvijlZ5n0G7D3HTuKUFaPyc+OrQQT9h3HdGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VByGH2/ZOijwtmZpF06WB8VzGj0NUhrdd+d/EQBfZPI5u7+jrFWeKMpcCUWssrRcRO7dRxcCrP16eeewzRZiyVX8N9eT2XSg8wnznIYDtbmk/qyaeKGapqlQjLFJCzMGjTwHMpIGcJOkoRgBaHvzCDfOCQ9afBJG6OJhG+89vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flX8fhrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flX8fhrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27C11F00A3A;
	Thu,  9 Jul 2026 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593334;
	bh=/up9Gu+UjKWg4SCwSDv+NRzwdbSX6da53T6vXuSMqxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flX8fhrz0I8Y+Yxx03fuy1/4btwmQHemcNvVLAeEohpfXJusRmStgV9N/rkjcSC1l
	 YfsDxzlf950VBkPt1y+z74Qq2qLIpKmcYKopDu/mzw2X6sOW3gJ6jljsCRkyHUemqW
	 YYh3qJ01GSdurhFHWK+3SDRvfWAoOnEB7sw2wjn2CQoZomLauMzrDttcZr9ZwHJ5fd
	 yhZCfJEc7DHXn0iTOI7Qgqp4TGRSlT6ZDiMDnMkLI/1cnweAeIm3kQNPPPLuAM1bsK
	 1GqawG2qGZjsdYa7/CfDlUHyiBiezczJDeGzAd8JIJiQCle5LcXSR0jNcZ1DaJFnhg
	 P//GBI2j3WZHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 02/10] bpf: mark instructions accessing
 program stack
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-2-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-2-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:35:33 +0000
Message-Id: <20260709103533.F27C11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the modern kernel/BPF comment st=
yle.
--

--- Patch [2]: [PATCH bpf-next v5 02/10] bpf: mark instructions accessing p=
rogram stack ---
commit 03ab01d124457ab321033266bf176b6f34230aec
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: mark instructions accessing program stack

JIT compilers need to know if load/store instructions target the BPF stack =
to
avoid over-instrumenting them with KASAN checks. This commit makes the
verifier mark instructions accordingly, setting non-stack-access true if any
state leads to an access other than PTR_TO_STACK. It also ensures instructi=
on
patching maintains correct markings.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 188ea6205d617..0eda5512baece 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -172,8 +184,14 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
>  	 */
>  	data[off].zext_dst =3D insn_has_def32(insn + off + cnt - 1);
> =20
> -	if (cnt =3D=3D 1)
> +	if (cnt =3D=3D 1) {
> +		/* A non-memory accessing insn could have been replaced by a
> +		 * memory accessing insn, systematically mark it for non-stack
> +		 * access
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment in adjust_insn_aux_data()
follow the preferred BPF subsystem comment style? The BPF guidelines require
the opening /* to be on its own line for multi-line comments.

> +		data[off].non_stack_access =3D is_mem_insn(insn + off);
>  		return;
> +	}
>  	prog_len =3D new_prog->len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D2
