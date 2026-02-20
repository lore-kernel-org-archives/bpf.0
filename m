Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37083375CF;
	Fri, 20 Feb 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585078; cv=none; b=OEKXpFxaw1Pv+mKceZNfvtygi8V+nk/Nset+bWvM/wi4p/X2rx/E+r3KRv8UoYrgId6l0YuLqTMdEwwdCA9cQ2ir3wl01zH1jDv3PO47aSrCwG3cc8eqE5v5t7lBrlNR8VLZn1DndJc4pptv4jukVvTOgH3Hm1YeyPAksfuNQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585078; c=relaxed/simple;
	bh=SL9xKLR9NjRtMmeBlNIWgCQaeCxBTcfw7fIeGgIa5v0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dAHbIZQNfNlMDACKllZ9+rNRKJLypPwLPA3jSMiCjux1v8fobTLd6WiUwd61o0xvh0+WPREFsVhuAwR7txYRrPaOsW0diCy1rA4+fN6J1UdPhCj3ZXOxx0MxXae2xRfbg8LoNahUCV+eEjfxWJ7Cu+H6p1EBg6j971pjuHrgPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2FYiHSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2FYiHSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC9C116C6;
	Fri, 20 Feb 2026 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585078;
	bh=SL9xKLR9NjRtMmeBlNIWgCQaeCxBTcfw7fIeGgIa5v0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=E2FYiHSKnv9vBirN7goMxlfZU5lSbkB2VxB3XOwHjxo/I09PGhjxT6AYwE98MGIH2
	 yMtAlfHyu8oOUi44VX71+qW65Y9M3DKG3UpAfQxXExHLEDEofKpnhUiaTZEMyuLKcW
	 DQ3ZLY5zvKgvgW+vSUeGAF/70VZeCnV+dn4NQcJIpEM0qIjMU/3CWhL+e1Nt7ktXpB
	 7J9xOsclN1YG885T3pRYEJV6bKNkxyyIEzDK7FgVHbEAafSWl114sfSNGusfN44NX6
	 ohhio6vsZES23zr+GVe1cDJDlQ8UiWe8SZzIIvfcVPja9B7dhwZDaQ0+GrlUjkxFLi
	 WMtiJ/n8VVJ9A==
Content-Type: multipart/mixed; boundary="===============9206972956287271655=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e41633c6d6d32fabb08ecc4ae8432a45afaa72aa61756601f4cdb9aebd039f86@mail.kernel.org>
In-Reply-To: <20260220100649.628307-9-jolsa@kernel.org>
References: <20260220100649.628307-9-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 08/17] bpf: Add support for tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 20 Feb 2026 10:57:58 +0000 (UTC)

--===============9206972956287271655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h

[ ... ]

> +BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing)

The existing BPF_LINK_TYPE_TRACING also uses "tracing" as its name
argument:

    BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)

This means bpf_link_type_strs[] will contain "tracing" for both
BPF_LINK_TYPE_TRACING and BPF_LINK_TYPE_TRACING_MULTI, making them
indistinguishable in fdinfo output via bpf_link_show_fdinfo().

The libbpf side correctly uses "tracing_multi":

    [BPF_LINK_TYPE_TRACING_MULTI] = "tracing_multi",

Should this be BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
to match?

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> +{

[ ... ]

> +	ids = kvmalloc_array(cnt, sizeof(*ids), GFP_KERNEL);

[ ... ]

> +	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
                ^^^^^^

The ids array above uses kvmalloc_array() to handle large allocations,
but the link struct uses kzalloc(). With MAX_TRACING_MULTI_CNT at 1M
and each bpf_tracing_multi_node being roughly 40 bytes,
struct_size() can request up to ~40MB of contiguous memory. kzalloc()
is limited to KMALLOC_MAX_SIZE (~4MB on x86_64), so this will fail
for cnt values above roughly 100K.

Would kvzalloc() work here instead? bpf_tracing_multi_link_dealloc()
would need to use kvfree() accordingly:

> +static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_tracing_multi_link *tr_link =
> +		container_of(link, struct bpf_tracing_multi_link, link);
> +
> +	kfree(tr_link);
          ^^^^^


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22220470181

AI-authorship-score: low
AI-authorship-explanation: Code follows established BPF subsystem patterns and Jiri Olsa's terse kernel commit style, with no AI-characteristic verbosity or over-documentation.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: BPF_LINK_TYPE naming collision makes fdinfo output ambiguous between tracing and tracing_multi link types, and kzalloc limits the flex-array link allocation well below the advertised MAX_TRACING_MULTI_CNT; neither causes crashes or data corruption.

--===============9206972956287271655==--
