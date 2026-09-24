Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732920C029
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209927; cv=none; b=pJyNaOnYwdVcvIRDiiEEMJ470WLHEDaWoEqSAPwZckg+WHKoo5DuWrb14j7yHtrw15xUMd9KIrZTMFEGk0PjbD5RCI1r46yZOknEAqj/zNZwZSFl7osMwwwyJ/uGoS6/cDXjpjPxlctSH2Lp/wvYVIFPQpP7YCgf0dVmdPOell8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209927; c=relaxed/simple;
	bh=/svvMxPVsQohrMwJ2sj7UtbA7GFF7akua9zGyjtCBSY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LAQy8n7ZrlGA8WxPldb2xHPfC9I9fan4pGr7/SBQM9uuG3bCGFuwmTITygh502HkF4QFJlYr0tm5YA1oKwl+ETY9KqOD5GhZghBQvl0mH0C9xDLyMlsbcKZ0dvWocInkvx1gppvw8q7lFzrogW7qXVJrkQp2GFu9ySbusUggiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9ORBG0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9ORBG0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8F61F00893;
	Thu, 24 Sep 2026 00:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209926;
	bh=gSzSS5KKka/pNOJn19kn0LIoxX956jSyBRpHI065+k0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T9ORBG0ZVhjUl5TZ3AqXTPYgLmB2fUoL9vjgNwtEXx7KCf/mgggGqE2azfHHhM8UZ
	 LWaevThwE6qGQ/4OFU2Sm4F8qM5mwCE6SaozWGZJdh/ihW6FAywHjeD9HDmJN3d2cC
	 TkS7iRDdDhEjJT0z5rS8lc4EE7YnUyZqIzHZwGIMoHcb5d0pm7XU7HAwfxFnD9kgkt
	 g69v6WWE3pFGYXkHq7jMrtqHL6wBNCYOdM7qCIM0gXy8iFhAVZWp4Qmhuw0XYsummN
	 I/AoDKbaU1ltjCpOsdOANQjZuPVzS8Us9WBQXOygSybSw+9jRXjys8WSlvAaT/F8WZ
	 /YxFnbrvxjZfA==
Content-Type: multipart/mixed; boundary="===============8412255555463721515=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a4f527e064877f26ab1f9cdfeaba69a969517e76de2c24254f9a4325c4a02ef@mail.kernel.org>
In-Reply-To: <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v5 5/8] libbpf: Version bpf_program__set_autoattach() ABI change
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org,ast@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:32:04 +0000 (UTC)

--===============8412255555463721515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 85e1d9c775ab1..224fb0247a395 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index faea42f758479..d172c137cc376 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -393,6 +393,12 @@ LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
>  LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
> +/* this "specialization" should go away once the deprecation window for
> + * bpf_program__set_autoattach_deprecated() closes
> + */

This isn't a bug, but should the opening '/*' be on its own line? The BPF
subsystem comment style requires multi-line comments to have the '/*' on a
separate line:

    /*
     * this "specialization" should go away once the deprecation window for
     * bpf_program__set_autoattach_deprecated() closes
     */

> +LIBBPF_API int bpf_program__set_autoattach_v1_8_0(struct bpf_program *prog, bool autoattach);
> +LIBBPF_DEPRECATED_SINCE(1, 8, "use int-returning bpf_program__set_autoattach() instead")
> +LIBBPF_API void bpf_program__set_autoattach_deprecated(struct bpf_program *prog, bool autoattach);
>
>  struct bpf_insn;
>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35934836796
--===============8412255555463721515==--
