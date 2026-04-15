Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C5282F0E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215315; cv=none; b=qNvBm6+JDNJCTRPqinmQa2fDQhkfF52Cn+X7FlYqfuhDNt+Rd0TF7HbX50Pl7DDktky4zqM7S6Gs44rGPJgMu2yKRQDoUO2J3tCKK4aLN8NahQNoa9sFCZklornfOMke7OUSHNXYhOVgiAXnn2j/vPekeDYMMam4VmBwJTREzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215315; c=relaxed/simple;
	bh=RKBw4JJ7pGSwHsfhXe7EpSi8RZ/bYMuxqoez4J4gYf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shxh6+eE2RRcs1gQfKE36dt8h+vFXlH4fSzrQXHUdausDVfI4FbjCweKbfyTCrjQnw3lilrjb1Bj851MSF8uU51noyCXK8h7PwUREM2E7fcvIftWuS9qgLP4s5/jIDheNau8OBRkwQ3AQ8e2ucVyb8w6wsd7o96ZJeHa0Kh15Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTOB+iZ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTOB+iZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DA5C19425;
	Wed, 15 Apr 2026 01:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776215314;
	bh=RKBw4JJ7pGSwHsfhXe7EpSi8RZ/bYMuxqoez4J4gYf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fTOB+iZ1Nr993ltcDEXMbiBuENwHVPBarV5YgLxT1khI5BhNodFo3fHom6GASOH7E
	 R0I7vNMRtT2z6B75WL8CNluJGLMsfbFR66XkfaEL19a1WbqMHvhvnY1io4rStfvAXw
	 iFklPWZsHZ8AGhylRMzJuycJ46nhXcqKI1S24zNE729UEAXzcUQYfVEKQMnN6w4KKs
	 F9IMjDVGxZ4cZtnzl1YN4YG5cvpxNHw8lwW4AzJcFtscNVgxkfThyt0qTxz7sfRjMM
	 9sabCpeiTt2ouNtd7LX3TdC87gnypS4ggypkdCtDiEDlRs45aoqaP90v0prFtmeP/g
	 6qeQSNCg+yRBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: copy BPF token from main program
 to subprograms
Reply-To: sashiko@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414-subprog-token-fix-v2-1-59146c31f6f1@gmail.com>
References: <20260414-subprog-token-fix-v2-1-59146c31f6f1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 01:08:34 +0000
Message-Id: <20260415010834.C7DA5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] BPF token capability delegation is ignored for JIT blinding becaus=
e blinding_requested is evaluated before the token is attached.
--

commit 6cda306e3c0e6ae78f183769fc6ebeb4369f35c3
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: copy BPF token from main program to subprograms

This patch fixes an issue where bpf_jit_subprogs() omits copying the BPF
token to subprograms' aux data. By copying prog->aux->token, subprograms
inherit the same capability delegation as the main program, allowing
bpf_prog_kallsyms_add() to succeed for token-loaded subprograms.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1110,6 +1110,7 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env)
>  		func[i]->aux->exception_cb =3D env->subprog_info[i].is_exception_cb;
>  		func[i]->aux->changes_pkt_data =3D env->subprog_info[i].changes_pkt_da=
ta;
>  		func[i]->aux->might_sleep =3D env->subprog_info[i].might_sleep;
> +		func[i]->aux->token =3D prog->aux->token;

While this ensures the token is propagated for bpf_prog_kallsyms_add(), does
the token delegation still fail for JIT blinding?

Looking at bpf_prog_alloc(), it sets:
    fp->blinding_requested =3D bpf_jit_blinding_enabled(fp);

And bpf_jit_blinding_enabled() calls bpf_token_capable(prog->aux->token,
CAP_BPF) to bypass JIT hardening for privileged users.

However, at the time of bpf_prog_alloc(), prog->aux->token is unconditional=
ly
NULL, as it gets assigned later in bpf_prog_load(). As a result,
bpf_token_capable() falls back to checking the current process's global
capabilities.

If an unprivileged user provides a valid BPF token granting CAP_BPF, the ch=
eck
fails, and blinding_requested is set to true. This state is then copied to
all subprograms in bpf_jit_subprogs():
    func[i]->blinding_requested =3D prog->blinding_requested;

Are token holders incorrectly forced into JIT hardening due to this sequenc=
e,
disabling direct tail-call optimizations?

>  		if (!i)
>  			func[i]->aux->exception_boundary =3D env->seen_exception;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414-subprog-to=
ken-fix-v2-0-59146c31f6f1@gmail.com?part=3D1
