Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210138;
	b=MPSvKi+/zWegL5EAWG113WDymvRfr0e9GxD1hQM6w5TCM6NOmaKLaoGzt5JIMpjchYyy
	 gtipK4CvNlB63eK6hndfgCvaECUc4mV7okK69Z9HIFnNsD7+H54FxaasljiOpKsFYknzV
	 BlHwyu0BQJraSOeI3nIAVZFR0u+PCsnn/hgYLsvvmT6XQqS9L3kx/pDaaGh46k5kmBe/b
	 Gkall0qmeP9uknsZsAY+6MeNMF01EfiLAK7ElJiVI+oEi+xpuS917qOpE5lwnB3qNb/3n
	 7C+JSXASmSL6nAn2Gmjhn0KwFhdWhG6gmLg5cWHK6nLSRN8GQhGSlvvCB3VTqmXRhnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210138;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ZwHlf0ZOX3FjsBhl+HDEeMqmyXm1SbcJpENrUAuKRP8=;
	b=0Wxu2EKSjxE3OiL5x0fcIr1K68l8YJw3Clk82lRjL3uvgbApCtn0v8Xup6hjOKO9rnmV
	 sx17KfwQ7+h5EPuhYGSnMt3I8zsZYLOxDoBWMhHH/WL6tUM59aiLLrbtKjdm/PUj8aUXk
	 Vb/Bn7/Eo/Q0+rtzcTT4pFydVmKyuPz0z4NlRxDLjxs8lmy4aoLHD7RgQuEBTA7Z7pLCK
	 +7SjJXMGN0DbQ5pJpPJr63T78LASA/RYrJWOReBhzZIggcbCePA0aYXPRhwupFj/RkeBG
	 fMplXDY/wi3K3We/yQj9X4grSB3Ees768lokbkfci10c9W5r8GLu7dpIhgJqvb6cbNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVXDk63E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357B606A6A0
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVXDk63E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E11F000D1;
	Fri, 20 Nov 2026 21:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210137;
	bh=ZwHlf0ZOX3FjsBhl+HDEeMqmyXm1SbcJpENrUAuKRP8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XVXDk63EAmQPWUL4q/ZvWsk5HryCw3q3DyC0777gaRdVMr9LuUePaU+qt/QijcJRQ
	 k1QJNqGhwnMbN6bUAcLMMhVAhxA4qfj1XE5t0BbM8fQnYdwwbFqOcbHHsGyJ9gBoNE
	 znkK9TBL7IIcKCuoQ04apR2zoSFMd1xCC4uM0dx53aG8B1VyzvMqBudXw/6YWdPYE2
	 9KDQgQ58a4/dt2YQZGnCpyUnJWiBG2PCAyy85sbgY13JS17vdnf1JTBAV4X7frs+Zn
	 9XDpfOHtghitafMvTmHvuyobZ12+D2OcJyZzKgjzrL8UGGWK5EFaFh5yooBZPf/SU9
	 Va1xBLd7X8xAw==
Content-Type: multipart/mixed; boundary="===============0752122056131701683=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d52c6e9ad24cb8b60a18d555e3813f3e102989e2ee8d2e2c9e434e0828826346@mail.kernel.org>
In-Reply-To: <20261120204959.614908-7-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/49] bpf: Record what each insn reads and writes
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:28:56 +0000 (UTC)

--===============0752122056131701683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Record what each insn reads and writes

TL;DR: Nits only: in bpf_insn_aux_data, may_read_mask may belong beside
may_write_mask rather than under the caller-frame flags, and the new 1-bit
flags are u32 while neighbours are u64.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -858,10 +882,19 @@ struct bpf_insn_aux_data {
>  	u64 non_stack_access:1; /* instruction can access non-stack memory */
>  	/* true if some jump or call instruction targets this instruction */
>  	u64 jump_target:1;
> +	/* it can read or write the frame of a caller, in a call with a known callee */
> +	u32 reads_outer:1;
> +	u32 writes_outer:1;
> +	DECLARE_BITMAP(may_read_mask, MAX_BPF_STACK_SLOTS);

This isn't a bug, but could may_read_mask go next to may_write_mask and
live_stack_before, under their "stack slots in the current frame" comment?

As written it sits right under the reads_outer/writes_outer comment, which
is about the frame of a caller, while compute_may_write_masks() fills
may_read_mask only from the top frame of the instruction.

Also, the two new 1-bit flags are declared u32 while the other flags in
this group are u64.  Is that intentional?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============0752122056131701683==--
