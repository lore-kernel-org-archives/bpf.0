Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F312B69
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2mj7dlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B6FC433C7;
	Thu, 26 Oct 2023 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698321567;
	bh=iqR1qn+tLmLOg4FcVVQmy0ZfRrkAdueqP4HXJZV0S1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h2mj7dlASjVsBUMiwTpjnCzDdFZBcswitZd3CCbC8r29gEQ2goJwSbW5R9YGKi10v
	 4nQSa1ba5CP4BvS7FQ6vV/JOFMNAdpY+2uEijfE8K/nZSfyqwUjEdFMeddAiXnuvdb
	 t9eB1f5FimXNDZwDGuiSypLPjP+TWlN6qBbe7+VWCrfgcAIj0WbOu8Twdq+TuJQbUF
	 6lrWAiHxVShQ1PCDUsfFzzaoWPtYfFgEu/C41lidPAJ3SqeTqs2UCx0oGC2TS02K1Y
	 pU5zbq0itDHJzGbAQMYxlJ60Q/NF41XYOjFXxbC+8/VwxePFgqFmBoE3wkdR1d5ExJ
	 f1GR8SluqLk0w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com, xukuohai@huawei.com,
 pulehui@huawei.com, iii@linux.ibm.com, jolsa@kernel.org, Song Liu
 <song@kernel.org>
Subject: Re: [PATCH v5 bpf-next 5/7] bpf: Add arch_bpf_trampoline_size()
In-Reply-To: <20231024224601.2292927-6-song@kernel.org>
References: <20231024224601.2292927-1-song@kernel.org>
 <20231024224601.2292927-6-song@kernel.org>
Date: Thu, 26 Oct 2023 13:59:24 +0200
Message-ID: <87h6mdwq5f.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> This helper will be used to calculate the size of the trampoline before
> allocating the memory.
>
> arch_prepare_bpf_trampoline() for arm64 and riscv64 can use
> arch_bpf_trampoline_size() to check the trampoline fits in the image.
>
> OTOH, arch_prepare_bpf_trampoline() for s390 has to call the JIT process
> twice, so it cannot use arch_bpf_trampoline_size().
>
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x

Apologies for the slow turn-around:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # on riscv
