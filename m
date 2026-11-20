Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211483;
	b=VCPoVbkN1Y2ogcjEGuti9x8ApbQk3KojWg3IGG+W28iojaWet2QGtlC80hewKpvNuiHn
	 aqr4ztWM16BFD7aARadZY/Gaa0k7vmiu7JjMYlP96zgDtSHRS+AAzv3wm+schkE56y/mH
	 vIxYpWrukmBI7Lljrl1Q6UOUrxB33dwIH6hzpd2SqsAGgi7TIwKy0A0+XPCa1PMgkMZXf
	 LC5JIMppspNoOBCNPsO90czXV6L2ZGVAhnQsGx/IKBKCWZuOYeT/ad62Gp4ntocaiscZq
	 UEzQEqNfoU90NRTfd2RD4XxWNSjhOoNs39XneCkKUjy5FZ3COpUjopIyG8bJSsmEvKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211483;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=7pN0An2W1WL3+dLYHKizIvZYkGTf3fMECbJ0tuwCnOk=;
	b=SxZC6pXA4WB76IF+ea7lPsVSlV47S8DQmKFknSpB+epofL+o/Qlx0C2AvyPmxL8K8sp5
	 jhGIxeUg00lW5W6MgVwzwomcFCsDtIksASvdhsQMwKnaeiKVpwcb7K8THC3fLANNGZr6Z
	 cIB/7TehuXYzM1mLfa/geF+K27lOMI/ta1C0UITFBjD9S1theMkxxlFNrdv4wy8Ma+b28
	 kwj98MD0QZe45wPdr0YTlLFYmvilIpcBVSRHbYDemclMdUjqrbTH1RAnXjuFSQ5F4Sid7
	 Jc/DH8tjJ3TrFeyLGIOphuSeV+eXupM/thNTjygxhWop82bWOXH5tWb4PXSBazXieYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMSvQp+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A460A2603
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMSvQp+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DF1F000C4;
	Fri, 20 Nov 2026 21:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211483;
	bh=7pN0An2W1WL3+dLYHKizIvZYkGTf3fMECbJ0tuwCnOk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AMSvQp+wSjki6mBLilZOAfLMbtW9ybfqjacpg2zLsqydZOFF9WjZFPKnq+4jNc/6G
	 cd1W4xnryXC2u9T8EfkLWpKCfchrqKjOAl5c62hThDjQVPFPGH4y1+Ir1WlvQD8UbK
	 Du57+VMv/uktK2LAV0JjiCh2rPYgKioxj4ZB9tt6gWPPdFvoy6c6CxXhxjFjO3NVkN
	 VlT7InW3FaTahPV6rwyCWUd0YDyHCaf46xOXgkVFgoHpa92x7cpqqP/HdAjvIZJ24d
	 zPJwd149Fd0ed7fNtUNs1iYWyxBiZyLDUtbUHdZI8WOQ8KYJxjsDPOW2LGCJiFsc71
	 i710UwkBUlqGQ==
Content-Type: multipart/mixed; boundary="===============6301437953220876200=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d12918e1e98c19f299d7d8c896775f147c6b08e321806c64ff075dd37c8425fe@mail.kernel.org>
In-Reply-To: <20261120204959.614908-5-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/49] bpf: Delete scalar evolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:22 +0000 (UTC)

--===============6301437953220876200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Delete scalar evolution

TL;DR: Nit only: a comment on loop_stack_entry's counted bit still mentions
max_header_count, a field this patch removes; the comment is only fixed later
in the series.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -420,8 +391,6 @@ enum bpf_guard_edge {
>  };
>
>  struct loop_stack_entry {
> -	struct bpf_verifier_state *entry_state;
> -	u32 max_header_count;
>  	u32 loop_id:23;
>  	u32 terminates:1;

[ ... ]

This isn't a bug, but this hunk removes max_header_count from
struct loop_stack_entry (and struct bpf_loop_iters), while the comment
documenting the counted bit further down in the same struct is left in place:

	/* max_header_count follows from the state at the entry, not from patience */
	u32 counted:1;

Could that comment be rewritten or dropped together with the field?  No
field or variable named max_header_count remains in the tree after this
patch.

The comment is only rewritten later in the series, in 29203c388956 ("bpf:
Give a loop a checked trip count or may_goto"), so every commit in between
keeps the dangling reference.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============6301437953220876200==--
