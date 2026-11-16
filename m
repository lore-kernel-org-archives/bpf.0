Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839319;
	b=UtEh7VGoJwSTv1ifb7Trt/y/eEzUNYXLDbqgPumeyvajQrU0hARbiGLK7G/XWMES3INa
	 orYUfjtTy1Lr/ZsJZlxl0PgDrdXqB6vHSrpDddY4XQR/3eN99h93q4zmZK4N2SaBVrkZf
	 I/rhbKNvkr9SM1mUFY6p80ztfbIcvYhCA7SkB0nD3Ojx/h8CCSXKWxMHezMrer2Stk+L7
	 LpnfO72Ecc6uMzCPyoKtpIxwgvdufhdUcxvcWYvMGi9OCwMb6MzXBIEumTKmhvX68Gd0a
	 WSaFbxkRG3nMamm7Lb+Sue/U9tzP3qPIYzggOUkiXFY2KD7A0ZgjAwr47LMTibasREQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839319;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ZaQnGbid6q4zyYj9jfXt0T9/5f5P2B/asKQNYP1h4Jw=;
	b=GeYteXrSlSCo9BCkEAdddlyg4q2IiCfUpyxYbaRjSgDH6hN+mc0n1ni4NCxdAEwM11wM
	 9/FBbhZXRXVakCe7FKcmoOV3frQXJLczFIRWJhVF5PiVaDM9mKd8iByWtQPDyBDtx6nx1
	 GP9FY7NAwkpFd7O8Sj0/4QRhF+HezRf5TWtAyiLwqxoNetgcFVc42imM4/V4LZMedlG6T
	 8YgDwPpikVyKAR3bmGKK8Ki2HxgCmtStVBDQFZlq0LVAAq+s8p4vN69tgRTin6TiUOFBt
	 zav8eS9R0M+JypchFV0kygyD20rg5DBSTelHY6BVUdf2elOWnpUBXGsba4vD8wgjSxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGfUgus4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A230606A334;
	Mon, 16 Nov 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGfUgus4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788E41F000C5;
	Mon, 16 Nov 2026 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839319;
	bh=ZaQnGbid6q4zyYj9jfXt0T9/5f5P2B/asKQNYP1h4Jw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hGfUgus4Fy2nTqbefIVxGiyuLcnvQrUp29djC4CLV/DKYtqsJtHiD68QBKPkbnTku
	 ai4bR6iEyzM61fQxBw1gDVVO610uOkxHZYg3UXT3NQY7aaEquNodGfm9NQsvk3+gCH
	 z07EEPUNMQL2V6oZPl8ZJNzZPzMXen4xjUdToOh/xxR8a9PWm+Ck184zApeVSx4IMP
	 fgFShJyqvwKnJL7gNrOHPk9KBZQ43R88lZRJlCabpgQlbQx8DPmhq4NoP8/YWKSa8U
	 UZdK/chA1AO2PtGek+oB8Zeb6jf3aTWRgwTPA874MzCgQFblVH4bIod6vvKHQ4upeK
	 OjTmW7K8UkUQw==
Content-Type: multipart/mixed; boundary="===============5633468459010448984=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <81ad1174b88bd26130f0500e705feb4e2dc0a9f962c2ba950729846e5dc82f72@mail.kernel.org>
In-Reply-To: <20261116134652.322156-1-irlanki.s@samsung.com>
References: <20261116134652.322156-1-irlanki.s@samsung.com>
Subject: Re: [PATCH bpf-next v8] bpf: tcp: add ecn_init callback to bpf_tcp_ops for per-connection ECN
From: bot+bpf-ci@kernel.org
To: irlanki.s@samsung.com,netdev@vger.kernel.org,bpf@vger.kernel.org,kuba@kernel.org
Cc: cpgs@samsung.com,edumazet@google.com,davem@davemloft.net,pabeni@redhat.com,ncardwell@google.com,ast@kernel.org,alexei.starovoitov@gmail.com,ameryhung@gmail.com,kuniyu@google.com,daniel@iogearbox.net,andrii@kernel.org,corbet@lwn.net,linux-kernel@vger.kernel.org,lorenzo@google.com,maze@google.com,sporeba@google.com,motomuman@google.com,madhan.raj@samsung.com,srihari.k@samsung.com,g.pokhra@samsung.com,r.kumawat@samsung.com,raj.kumars@samsung.com,ts413.lee@samsung.com,ramyashree.s@samsung.com,daeil2.hwang@samsung.com,irlanki.s@samsung.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 14:28:37 +0000 (UTC)

--===============5633468459010448984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: tcp: add ecn_init callback to bpf_tcp_ops for per-connection ECN

TL;DR: Nit only: a comment in bpf_tcp_ops_get_retval() still lists
timeout_init/rwnd_init as the only bpf_get_retval() users, but ecn_init now
uses it too; the code is fine.

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c

[ ... ]

> @@ -258,7 +267,8 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return NULL;
>  	case BPF_FUNC_get_retval:
>  		if (moff == offsetof(struct bpf_tcp_ops, timeout_init) ||
> -		    moff == offsetof(struct bpf_tcp_ops, rwnd_init))
> +		    moff == offsetof(struct bpf_tcp_ops, rwnd_init) ||
> +		    moff == offsetof(struct bpf_tcp_ops, ecn_init))
>  			return &bpf_tcp_ops_get_retval_proto;
>  		return NULL;

This isn't a bug, but bpf_get_retval() is now also exposed to ecn_init,
while the comment in bpf_tcp_ops_get_retval() still reads:

	/* bpf_get_retval() is only exposed to timeout_init/rwnd_init, which
	 * always run via bpf_tcp_ops_call_int(). ...
	 */
	if (WARN_ON_ONCE(!ctx->saved_run_ctx))

The invariant still holds, since ecn_init is only invoked through
tcp_ecn_init_bpf() -> bpf_tcp_ops_call_int(), but the comment now lists
an incomplete set of members.

Could it name ecn_init as well, or say "the int-returning *_init
members"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43881864185
--===============5633468459010448984==--
