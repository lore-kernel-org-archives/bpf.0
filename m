Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600630;
	b=rcnOWnxgZXANOZtRjo+gH7qbv/SmnROz0MaUDR7wYoUw3Oq6B58dKDUCmFJ+Y1chIj1E
	 YrV6XdQ0xXz25osocLrbqvfbGtDlhcSXGW6+e7A6CDy9LA/GpPql/ZMRH7w8ExjMxwJog
	 9VOXR61TdZ7RAgHMft8hy80okLtVou1szJ2uCuB0GeSKmoAUf6u0b1LlHIp8q79mKjiJx
	 zTdNXqQ1+0SBsN1gOynJD+RA/C7xoU1wuKirCeIs74ImIeCwejCLN0xnOhAchvol9XnWo
	 u27SXnIzNHfK8bSYeLpUggG2PDWC1VbnrU5z+drffwnYsrt9/VGKPWOsqIEhPuunQAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600630;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=3I9FF88P2q7bt1FMGLPxScdGviwzl5MeRLq/bpUR0iU=;
	b=vVhG1pVhX6HruPB8yMcrhas0wcFu0ZygncW1grlAYr33vzfMnDl7UEc5iZlhpppj/O85
	 4UvwYPASceToqFQDDJeFNulb2GbGpGRyWVv6UGGrTdDdn9rOIAMaPBTwJBfaTOcDgIq7O
	 yPEydIrCaXgNo79PYbZf7kll30JLhaZA0dZG8ARrK+cgoUpe4T6EnyEJz6FQKAA7kI+hC
	 rj0d4fBoOa2Wn/gd8fM9/KRy6yPs86px5z/vsxlkZumDOrGFiAX5hN5w75ZFywcJ1IOvx
	 FQf+1GIvGkUU78Hbk3TWJBtiFbZqErKWc1WqPWdGYk04snk9Q7T6pmhszfGbmn89qbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EV0YWUtz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03C606A32A;
	Wed, 21 Oct 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EV0YWUtz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAF81F000C1;
	Wed, 21 Oct 2026 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600629;
	bh=3I9FF88P2q7bt1FMGLPxScdGviwzl5MeRLq/bpUR0iU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EV0YWUtzTsJQey2htZ0GwJVEAPswNk5/OQBMqAFQcibn95fREK3Av99qz3MNz72/W
	 qb4+t8ADrL8E80QqTWQB+9GPbz6Ax4wAVdVEYhwx4nv2Onv7vcv0126DULLFrDeyh6
	 0/TelodcvVA8EFF6UWPNiYI2WWJx0MnKIrzlTOdZJ4XgPkJ+oOwLPwsrzPCqzwJPOb
	 OmsBN6oQ2DH3DW2TaFqtbLLxnqZlIp59NDCbvZtBB5csTXGszC1vd0ARNWSBI3zB+g
	 kPgumQXgcD0G8XpFdedLq3oQ70fbZbfuSK4cMIV0tYwKWYMTl2lu6f9wVN8Pl4ich0
	 iSnK+S3etKxkg==
Content-Type: multipart/mixed; boundary="===============7309015236229723418=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <053c6a0f6e94a626bf00b3a32ce9bcf7eaf89014b45c210ef3331e88b946d808@mail.kernel.org>
In-Reply-To: <20261021155629.68813-1-phx0fer@gmail.com>
References: <20261021155629.68813-1-phx0fer@gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: use READ_ONCE/WRITE_ONCE for saved_data_ready in the verdict path
From: bot+bpf-ci@kernel.org
To: phx0fer@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 16:37:09 +0000 (UTC)

--===============7309015236229723418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: use READ_ONCE/WRITE_ONCE for saved_data_ready in the verdict path

TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
5a685cd94b21 may be the better target (medium confidence), though 2ef2b20cf4e0
may be deliberate for stable backporting. The code change itself is not
criticized.

> bpf, sockmap: use READ_ONCE/WRITE_ONCE for saved_data_ready in the verdict path
>
>     sk_psock_start_verdict() and sk_psock_stop_verdict() access
>     psock->saved_data_ready with plain loads and stores, while the sibling
>     sk_psock_stop_strp() uses WRITE_ONCE for the same field.  sock_map_link()
>     / sock_map_unref() touch the same psock from another CPU without the
>     lock, so KCSAN reports the race:
>
>       BUG: KCSAN: data-race in sock_map_link / sock_map_unref
>       BUG: KCSAN: data-race in sk_psock_start_verdict / sock_map_unref
>
>     Use READ_ONCE() for the reads and WRITE_ONCE() for the writes, matching
>     the strp sibling.
>
>     Fixes: 2ef2b20cf4e0 ("net: annotate data-races around sk->sk_{data_ready,write_space}")
>     Assisted-by: LLM
>     Signed-off-by: Dudu Lu <phx0fer@gmail.com>

Is the Fixes: tag pointing at the right commit?

2ef2b20cf4e0 only annotated the sk->sk_data_ready and sk->sk_write_space
accesses, plus the saved_data_ready store in sk_psock_stop_strp().  Its
parent already had plain loads and stores of psock->saved_data_ready in
sk_psock_start_verdict() and sk_psock_stop_verdict(), so it left the verdict
path unannotated rather than introducing the accesses changed here.

The psock->saved_data_ready field, and the lockless reads of it that the
KCSAN reports are about, came from 5a685cd94b21 ("skmsg: Get rid of struct
sk_psock_parser"), which folded parser.saved_data_ready and parser.enabled
into psock->saved_data_ready.  Should the tag be:

  Fixes: 5a685cd94b21 ("skmsg: Get rid of struct sk_psock_parser")

The verdict start/stop code itself dates back to ef5659280eb1, but there the
unlocked reader tested parser.enabled rather than saved_data_ready, so this
attribution is a medium confidence suggestion.  It is also possible that
2ef2b20cf4e0 was chosen deliberately, since the context lines of this patch
depend on it for stable backporting.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39631503837
--===============7309015236229723418==--
