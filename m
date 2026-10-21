Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580667;
	b=Q+X2NJ/CeojwrNbyRdfqGVnD58Wvx9NeRR+xKZUA//MX5D/wuBPwjsMMVw8iadFXkxTT
	 C6RgMjzZygu9D0orVZZ+zg8Isx5TnXcX5Hi/l8ZdXVQ4nZhrDu6xwxj3uvFYyR8ekP/RN
	 xT1eynzJB37ElmY4Ww8rXFSdWsOirXeJm9Vpzuj7pDycuwbvXar48lnOcxnR47X2gWNMH
	 w2C2gRPz4NvzK07Q6FJz8eYT+/0heiu7GgmDmdV5b6pH1d7vNP2S5N/pX200tBfwXdp6g
	 wiA0rtQTpvoGLeclvW+Zz+uo6Qbg73knJh7y+O5uQuZ5iembaVYApmdkxXRUQFH9KwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580667;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=757j6HC9/ZJcr0KvzkZU6AFyWK11pyb92mCjzCpfo6Y=;
	b=YPFOaMhXEv0gnh1cEJhx3/eo+AZLKA5sBlSqYg/h0yEWPlWZG2vYhnbiClx1xjE5XwhE
	 qany3tTrNueskjUsdQfasKwCcNO5qCImLXxxadqSNOWicObytzZGhmuC93Kpx6GTzJrNy
	 xTYzgA7pidSAVKl84O02ZMTKAwzO0QKZBOzlPwynjXKhSCpUWJLdY/9C04MbKe9Spo1cd
	 9HbzlKuloISTumm4cBX5V/iFvsV+HEjKgIeKcm7/qbMpdwwaAJ978uEyVx11Gy3IxauP/
	 yslGIeDgN+Cm05BRDfldCcLb3TmAn9tlLw38dAI2UPTf7NV2ZgH0kA2S+nfR1S3nkLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZqeHBMbu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A6606A319;
	Wed, 21 Oct 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZqeHBMbu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6070F1F000C9;
	Wed, 21 Oct 2026 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580666;
	bh=757j6HC9/ZJcr0KvzkZU6AFyWK11pyb92mCjzCpfo6Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZqeHBMbuj5HPn0jHjN8UcyVsdpArJ9Ux1/1JVpKTayRxx1TuNkn7xXuC7OaE4YB6p
	 et3ByO0EdjxPImpbDNTZISmmL6OvcuyHKQtF85Nod65YO5RF0B1gtwaeq7+Emiw2Kr
	 5pq5UKziYxfe97yzXpZk18t/1MRc4uyhHh+DLzsWfaNeSR7WcY6WgQaoHqour6gW+z
	 CYE4UZQK1TLrr/6ES0mfUExvDBIACPJLwyXWqQCBYGAywkzYfS5ip8Uq1kV3Jyh1EB
	 L+mzOynzyLspsQiG+MIt/fweOzxsh6TisBWlbRX/xDt5Y6HkO4UjA7wYjWR0/HqMEs
	 HvJEnXWKBJMAw==
Content-Type: multipart/mixed; boundary="===============1776289824786463327=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5a586e05ad8d24d79759c1d99d6d58eb661dc6f4a4c8d258e05a4962cfe7e59e@mail.kernel.org>
In-Reply-To: <20261021103957.17532-1-ayushmanrout27@gmail.com>
References: <20261021103957.17532-1-ayushmanrout27@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use memmove() to load bytes from an skb and an xdp_buff
From: bot+bpf-ci@kernel.org
To: ayushmanrout27@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,hawk@kernel.org,drosen@google.com,netdev@vger.kernel.org,ayushmanrout27@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 11:04:26 +0000 (UTC)

--===============1776289824786463327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Use memmove() to load bytes from an skb and an xdp_buff

TL;DR: bpf_skb_load_bytes_relative() still uses memcpy() and may corrupt data
when its destination is an overlapping dynptr slice; should it get the same
memmove() change, or should the commit message explain why not?

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1789,7 +1789,7 @@ BPF_CALL_4(bpf_skb_load_bytes, const struct sk_buff *, skb, u32, offset,
>  	if (unlikely(!ptr))
>  		goto err_clear;
>  	if (ptr != to)
> -		memcpy(to, ptr, len);
> +		memmove(to, ptr, len);
>
>  	return 0;
>  err_clear:

Should bpf_skb_load_bytes_relative() get the same change?

It has the same pattern and still uses memcpy():

net/core/filter.c:bpf_skb_load_bytes_relative() {
    ...
	ptr = start + offset;

	if (likely(ptr + len <= end)) {
		memcpy(to, ptr, len);
		return 0;
	}
    ...
}

Its proto declares .arg3_type = ARG_PTR_TO_UNINIT_MEM, the same arg type as
bpf_skb_load_bytes() uses for 'to', so the verifier should also accept a
slice returned by bpf_dynptr_slice_rdwr() as the destination there.  The
helper is available to tc programs through tc_cls_act_func_proto() and to
sk_filter programs.

Since ptr is only checked against skb_tail_pointer(), the source can overlap
a rdwr slice taken from the linear area.  For example, in a tc program:

  p = bpf_dynptr_slice_rdwr(&ptr, 8, NULL, 64);
  bpf_skb_load_bytes_relative(skb, 0, p, 64, BPF_HDR_START_NET);

This takes the memcpy() path with dst = src + 8, which on x86 with FSRM
would repeat the first 8 bytes, the same corruption the commit message
describes for bpf_dynptr_read().

The Fixes: tag and the subject ("load bytes from an skb") would seem to
cover this helper as well.  If it is left out on purpose, could the commit
message say so?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39587398602
--===============1776289824786463327==--
