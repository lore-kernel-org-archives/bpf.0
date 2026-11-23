Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470283;
	b=i3gTRiZvuKZDmoWU3X8z5rbFUXIVntASL8Y91z7n+TILMuC5rEVCB02/wAu1eesBhVmQ
	 Al7rNhUs0iAdn0B5hhwJQHK1BM8lU3eb4caW21YOLqfs4nxkpO/ECoCGom/Lo4sOx0Od/
	 vjFsQWfu4goB2oH1s2t+WlifhBosGyfypaHRrl5Ppx2cK/B0BVr3pcg2oUR/lJzl+J+5E
	 NpifeKpvkHkmvnlFTvklxm4Q5mQ2BsRGAV7sukpRRWI+8+WTYo64SRm83YCsNgI0CGg82
	 eddzr39HO3Ks9vEb4dAF25N/YwhIPdxw/Cyrsr74io0x+09dF2cuh+Wu2V7r+ju9xqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470283;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=b9KMJd8ILQn9kiI6T5ef0qdZWNTj3EtOlVvb/ITxnN0=;
	b=bK452u9WQNeyLfi+N/GFdpimfSS5K0zn5lGPNImQusMktIoxxY58I1C5s08UnrWrfbbO
	 DIY9Py3FJn6BfzS1TyaAuI7kWnQMFFyZzKa29KWjg2xlP6SJaqSYARAj6hb1a8sbpWEec
	 iAFIbhmNGlZ/ylubPbEyV8obgpAlJyD+wzcuDPWpP67tBvQWywArEACrn84FzCYeUD8+J
	 GR2kYejGz87zJvTQTrc9l+XbbY5YBYfr3O+1HuJH+/5QaBrVfESAz/W2uM5gMYBsb4UTc
	 iXZYAaXuWEHqiChvKUuF3IqmrQp1Na7fc2bRSIUCtolYCZL8eKRc7/v/NwMhicbvdSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6ON6QMB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF045606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6ON6QMB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0161F000C4;
	Mon, 23 Nov 2026 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470283;
	bh=b9KMJd8ILQn9kiI6T5ef0qdZWNTj3EtOlVvb/ITxnN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l6ON6QMBeLxeG7d9yChoeIhrKiMHVxa2cU41pYKd3Vit/y3CAEYJ0CIG+uygUSJQ+
	 vu/jbM69EkP7/KqhaNnpUQfmlU07Iz5wiLYT5nvnu5WYQoMHh46w04/XZ5cW114UXE
	 LPOGDR0UwNpHqMrs4vQFqksR5sqhsNRjwFXGz8ICfkF17aJNNX5bt91Hu4RGpXHGvL
	 M0XKpQ8Yc7UxPMW8UZlEqZR4ytIwr7JEBGgfvqPVa901n8tLI1C6M8tinr8F+36sPf
	 4M5WkpwoyLfRVJAZB6VTbtG+QE+qW5reyESUestkyl5yiVSoaFJrQ2QEtj4SHKnQNS
	 +6pay1Dx6o31g==
Content-Type: multipart/mixed; boundary="===============5985596331353088215=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <81079675ffbec722c00fd9e0d1d07c4127138e19202a6e1bcf4a10464b10ce3a@mail.kernel.org>
In-Reply-To: <20261123205713.4094553-1-alexei.starovoitov@gmail.com>
References: <20261123205713.4094553-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Force BPF_JIT on x86-64 and arm64
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 21:44:42 +0000 (UTC)

--===============5985596331353088215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Force BPF_JIT on x86-64 and arm64

TL;DR: Nit only: the new ARCH_WANT_BPF_JIT_ALWAYS_ON Kconfig comment omits the
KMSAN exception, where bpf() can still have the interpreter and no JIT.

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig

[ ... ]

> @@ -26,8 +26,8 @@ config HAVE_EBPF_JIT_KASAN
>  config ARCH_WANT_DEFAULT_BPF_JIT
>  	bool
>
> -# Used by archs to tell that kernels that were compiled with BPF JIT support
> -# have no BPF interpreter.
> +# Used by archs to tell that kernels with the bpf() system call have the
> +# BPF JIT compiler and no BPF interpreter.
>  config ARCH_WANT_BPF_JIT_ALWAYS_ON
>  	bool
>
> @@ -36,6 +36,8 @@ menu "BPF subsystem"
>  config BPF_SYSCALL
>  	bool "Enable bpf() system call"
>  	select BPF
> +	# KMSAN doesn't see the stores of JITed progs and reports false errors.
> +	select BPF_JIT if ARCH_WANT_BPF_JIT_ALWAYS_ON && !KMSAN

This isn't a bug, but the new comment on ARCH_WANT_BPF_JIT_ALWAYS_ON
makes an unconditional claim, and this select adds an exception to it.

On x86-64 a config with KMSAN=y, BPF_SYSCALL=y and BPF_JIT=n is still
valid.  In that config the select above is off, BPF_JIT_ALWAYS_ON is n
because it depends on BPF_JIT, and bpf_prog_select_interpreter() still
installs interpreters[idx].  So that kernel has the bpf() system call
and the interpreter but no JIT, which is the opposite of what the
comment says.

Could the comment mention the KMSAN exception, for example "... unless
KMSAN is enabled", so it matches the select that uses this symbol?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45267122015
--===============5985596331353088215==--
