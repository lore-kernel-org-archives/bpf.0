Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44041F377
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057340; cv=none; b=Oda7MUsqyIBTjnsGGlusnYynxmuHKSodfyZ4TGHZC+PHKo6eRj82zlUH1kFYMojA6cQkSu1nhlR/Lk9xIs6ornGKnAKYwQllh6IP1yiSBFlTfGZ/Jyd7npS9xEq93S1qjHO7GBRdsfbWLyPDCuIxbFo6S4LhIW6uQjPgJ3kEAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057340; c=relaxed/simple;
	bh=XWmW4ufDh4s6kRn+eFs17roxMuhTqYePhbDCLJ47T08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r5PTQILdQMVnBzzm0jV87kx2JsSopl3YpQQsKFcfKuWgvIGDWNTRIx1fNXt95Snu5Xkgp9hzLNYPWAy1ZTY6G00zbNYloywx3iTp6ZNr0Rc61SdyKkbLJKAEKJAZD3aW4oxKlfa1MRMKnTInQ9enHoD8JsWykBSn0PzfVk3uiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEKY/dZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEKY/dZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F031F00A3A;
	Tue, 14 Jul 2026 19:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784057339;
	bh=Htq0sEmUG62rwqAPPheVYlx/9ntgIui67LeVt7Yanqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fEKY/dZKo0Kas4vXgyaNiksgZI4mLb8srB17MGsYA3v4kL9hhJw6zHM3scE5LAYH8
	 ovsIXfY+iUIKeP/vYQqZ70rb6z/akstgpZvTls9ryH+u60ap5M80WXmjW3n7fytsCi
	 kJ24iODmjUt/fX2JvHG5BEpatBT11ymhCBOgckTqY2Cbjbn9R5UovwjT8Cn7ktSIjx
	 eh7hVlqENvR4E/7r79G4sK2bWrDkV20dicPn+TFc8JgAMkIKMFfVIgMTppQavxb6qn
	 GBPA7yvW8p23G/1M7KFK51Wzj8jWeV6b+LanIE9R7dQiBsmJmu1p8qV/8yrDm/xPeP
	 PKbK7IkuL5nRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.16.y 3/6] bpf: Restrict JIT predictor flush to cBPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-3-2fc3e16263ac@linux.intel.com>
References: <20260714-cbpf-jit-spray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com>
 <20260714-cbpf-jit-spray-hardening-6-16-y-v1-3-2fc3e16263ac@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:28:58 +0000
Message-Id: <20260714192859.39F031F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Restricting the JIT predictor flush exclusively to cBPF programs b=
ypasses the Spectre v2/BHB mitigation for eBPF programs, exposing privilege=
d eBPF code, trampolines, and dispatchers to Branch Target Injection.
--

--- Patch [3]: [PATCH 6.16.y 3/6] bpf: Restrict JIT predictor flush to cBPF=
 ---
commit 8b8cdfd6b31b7472477f24189e670075eceab23b
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

bpf: Restrict JIT predictor flush to cBPF

This commit restricts the JIT predictor flush to only cBPF programs when
reusing memory in the BPF pack allocator. It skips the flush for eBPF
programs, trampolines, and dispatchers to improve performance.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 48208c3f58143..63569d23cfa09 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
[ ... ]
> @@ -999,7 +999,9 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole=
_t bpf_fill_ill_insns)
>  	pos =3D 0;
> =20
>  found_free_area:
> -	static_call_cond(bpf_arch_pred_flush)();
> +	/* Flush only for cBPF as it may contain a crafted gadget */
> +	if (static_branch_unlikely(&bpf_pred_flush_enabled) && was_classic)
> +		static_call_cond(bpf_arch_pred_flush)();

[Severity: High]
Does restricting the predictor flush to only cBPF allocations bypass the
Spectre v2/BHB mitigation when memory is reused?

The JIT predictor flush clears branch history left by the previous occupant=
 of
the memory. By gating the flush on was_classic in bpf_prog_pack_alloc(), the
mitigation is skipped if the new allocation is an eBPF program, dispatcher,=
 or
trampoline.

If a local unprivileged user loads a cBPF program, trains the branch predic=
tor
to jump to a specific offset, and frees the program, the kernel might reuse
this memory chunk for a privileged eBPF program. Because the new allocation=
 is
eBPF, was_classic is false and the flush is skipped, potentially allowing t=
he
attacker to trigger a misprediction and speculatively execute accidental
gadgets in the new privileged code.

Additionally, if unprivileged eBPF is enabled, an attacker can load an
unprivileged eBPF program, train the predictor, free it, and load another
unprivileged eBPF program with crafted gadgets. Since bpf_prog_was_classic()
returns false for native eBPF programs, the flush is also skipped for the n=
ew
allocation, leaving the crafted gadgets vulnerable to speculative execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-cbpf-jit-s=
pray-hardening-6-16-y-v1-0-2fc3e16263ac@linux.intel.com?part=3D3
