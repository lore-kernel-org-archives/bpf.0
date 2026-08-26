Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20F3C8C52
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772329; cv=none; b=LCD+qAo9mqtyQlzsDzjvF9SF2EAJwYQPPwcVe2xclbqD7oNLQDHrMpXEZkkG3McI8vw2EGOdNm4KaYlFtrBsFb247p4SM/l8kHYwM7hCyCXoH6i5/ms6VlwFV1+RnY7J2P1HH4nNw6ITpmWpTbeSGob3/7D1Uuq0KjNWLvdrg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772329; c=relaxed/simple;
	bh=hG8g05pGPH+6UmR078nV9fyfil3rdgQlKfPc7S+5l/A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UCFjjD7jGZaSpG68jefZmJl8HTr9RVl3kgaSPmT54EQ2ggyFg94N+bl9XfCrrlowb+r9sfMVxgXgGzmFjHbbEUCvOmpID4hPFeilTjjoGFmcjWw5THKEyFxReKYdieY+r2+2Raz9/NQ7vvBMPhdnxTs53VCkEorH1SfC0Nvcc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/VUyLdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/VUyLdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF571F000E9;
	Wed, 26 Aug 2026 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787772318;
	bh=CUeVZ/yevBTOzlffdlIcMmfnLkyceCZ/Z54TXlyLzcA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=h/VUyLdD5XJwiZ/paV+JcLghMQfjKjAJlz9Pgs/ilqORoXCayadI3oayGQjQsNYJk
	 AI6O2+UObSk800cSqx2IPz3y1tP6UpJi2rPTV6O1isKmQnUrK8Df94ZDegckVF/Cv1
	 yXRSlnSrY1g+9JEEkBOPRYUo7xyjjb2Tt5DocKqpHFW2qCEUnz1LeZ8TaNk5WrcYDL
	 EM7tiSpCUsD3SfplOk55MFc4p/S0nci4qRsYXrTtKvWfYnU2Xou+Zqn657LkqIiJNm
	 4EZGNPKTkcbz5cJ3pW7aQxST92ORrAEnKm8anA+MtXz5tgfT64e5O/+k7+ZRiFUX5S
	 pQt6mIrzOC5yA==
Content-Type: multipart/mixed; boundary="===============0419327835408082227=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <92499ba02e75b23ee516d99b01d1f846bfa9f0e5b393dff8301c7bacb8232989@mail.kernel.org>
In-Reply-To: <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 3/5] libbpf: Convert bpf_program__set_autoload() to load-type enum
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:25:18 +0000 (UTC)

--===============0419327835408082227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 677f95c8adc5274970774bb635eca58cda6397dc
> Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
>
>     libbpf: Convert bpf_program__set_autoload() to load-type enum
>
>     Convert bpf_program__set_autoload() from bool to enum bpf_prog_load_type,
>     to unify the API with the new tri-state load type. Reject
>     BPF_PROG_LOAD_TYPE_DYNAMIC to preserve the original autoload on/off
>     meaning; only BPF_PROG_LOAD_TYPE_DYNAMIC is dynamic-load-only. Also
>     restore autoattach when leaving BPF_PROG_LOAD_TYPE_DYNAMIC via
>     set_load_type(), fixing a bug where a program left dynamic load and
>     became autoload-eligible but never re-attached.
>
>     Assisted-by: Claude:claude-sonnet-5
>     Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>     Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

This looks like a bug fix for stack argument support. Should this
include:

  Fixes: d8626c4dc022 ("libbpf: BPF programs dynamic loading and attaching")

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c3fe1de432108..cd1d00c47841b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -15295,15 +15289,28 @@ static int bpf_program__set_dynamicload(struct bpf_program *prog)
>
>  int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
>  {
> +	if (!prog)
> +		return libbpf_err(-EINVAL);
> +
>  	if (prog->obj->state >= OBJ_LOADED)
>  		return libbpf_err(-EINVAL);
>
>  	switch (type) {
>  	case BPF_PROG_LOAD_TYPE_DYNAMIC:
>  		return bpf_program__set_dynamicload(prog);
> -	default:
> +	case BPF_PROG_LOAD_TYPE_AUTO:
> +	case BPF_PROG_LOAD_TYPE_DISABLED:
> +		/*
> +		 * Leaving the dynamic state: set_dynamicload() cleared
> +		 * autoattach because dynamically loaded programs are attached
> +		 * explicitly. Restore the default for the target load type.
> +		 */
> +		if (prog->load_type == BPF_PROG_LOAD_TYPE_DYNAMIC)
> +			prog->autoattach = true;
>  		prog->load_type = type;
>  		break;
> +	default:
> +		return libbpf_err(-EINVAL);
>  	}
>
>  	return 0;

Does this unconditional restore overwrite an explicit user setting?
autoattach is a user-visible knob (bpf_program__set_autoattach() at
libbpf.c:9830) whose default true is set once in
bpf_object__init_prog(). Because the code cannot distinguish 'cleared
by set_dynamicload()' from 'cleared by the user', this sequence
silently re-enables auto-attach:

    bpf_program__set_autoattach(prog, false);
    bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC);
    bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_AUTO);

After this, bpf_object__attach_skeleton() will attach the program
during skel__attach() even though the user asked for it not to be
attached. For a tc/XDP/cgroup program that is a live behavioural
change. The same holds if set_autoattach(false) is called while the
program is DYNAMIC and the load type is later moved to AUTO or
DISABLED.

Would remembering the pre-DYNAMIC value or only restoring when
set_dynamicload() actually cleared it preserve the intended fix without
overriding the caller?

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 54d7558612893..a56068f0f1122 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h

[ ... ]

> @@ -376,7 +389,18 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
>  LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
>  LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
>  LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
> -LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
> +/**
> + * @brief **bpf_program__set_autoload()** is retained for backwards
> + * compatibility; **bpf_program__set_load_type()** is the preferred API.
> + * The enum's numbering (DISABLED=0, AUTO=1, DYNAMIC=2) matches the previous
> + * bool semantics (false=0, true=1), so existing bool callers keep compiling
> + * and behaving unchanged. Only BPF_PROG_LOAD_TYPE_AUTO and
> + * BPF_PROG_LOAD_TYPE_DISABLED are accepted, preserving the original
> + * autoload on/off meaning; use bpf_program__set_load_type() to set
> + * BPF_PROG_LOAD_TYPE_DYNAMIC.
> + */
> +LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog,
> +					 enum bpf_prog_load_type autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
>  LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);

Could this follow libbpf's API documentation convention? Per
Documentation/bpf/libbpf/libbpf_naming_convention.rst, the convention
expects 'Parameters are denoted with the @param directive, there should
be one for each parameter. If this is a function with a non-void return,
use the @return directive to document it.'

The block has neither @param prog / @param autoload nor @return, even
though the function takes two parameters and returns a non-void int
whose new error condition (-EINVAL for anything other than AUTO/DISABLED)
is precisely the part a caller needs documented. Compare
bpf_map__set_autoattach() a few hundred lines below (libbpf.h:1164-1171),
which uses @brief/@param/@return as the convention requires.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000627295
--===============0419327835408082227==--
