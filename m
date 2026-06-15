Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0030E0E4;
	Mon, 15 Jun 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548786; cv=none; b=uInBvcOBuSyFMwL8DKGkIvliUKRKHmHyEyAvoDqqpxo8EZ67ZYFyAr6bMj1mmHEshrWBtIILyIxkJNRX2dSIjCYHuqHS7bMuVsrg0WmBhK+HoEDgFALg2tmqeJuecwr0EZirRGxqQSCcIkOFMQg8FqZ/Sa+/wnnMlHUIrbRE+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548786; c=relaxed/simple;
	bh=8IzHOxxoDVy4Ie+xULeDCZS7NlKodbk1gByjESBaMY0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TU/vuZQD5ucPJWfvKjdW5RpjK+zbpcGBF2nBPThI/zJbIcGBWO6ptfVxidgdexvA6tqm1PxR/Gof9mou1EVO5h0uk+IGqOafvCOQV92sPkvJ4obMzpV2mpZ+19RVTCHHtLiZBoA5sShuZghSeAJh0yB94PauudrHPF7dfaZAFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtjoLS6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtjoLS6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB01F000E9;
	Mon, 15 Jun 2026 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781548783;
	bh=8cjaxnVTkKtFxEZxU+TnoyaBRvRzZYYcWmbAlrHkSvo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MtjoLS6ygVe0ce64V4vA/hBOpyJqMOUNl2lvLgfqWVHkhLN5/RMJ8i6v+/TX4SCk6
	 EaT7CTjXNb4dLcpC9yD+kcU0o5n/P0F5qxsFERXpdnw4uR6vReIofMSvAPxRSAkRug
	 4wLygnwx5kkMJMzYAJ7UUmwiGnX2mfaiFXZ7On2zsOiSJOj0SfXv5Sl9OGeGjcJSbu
	 +5jH9g0jKrMTSglsdms3a7F3Sk4fQAp5Y361qsphN+2cFyq/kgOVryCUvo97DhULU0
	 H89a0j+Pk75J+RQ/3I6I49DzANdup6ADqyam+TXXdYhKonsy3e2K6hmBfZ5DL5pijv
	 QbPRyXLXBRDlw==
Content-Type: multipart/mixed; boundary="===============3705424124499032894=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22a4e602da5c745be6947e9ebf41759432280a7697b74614d84c55ba9c10aed5@mail.kernel.org>
In-Reply-To: <7feeed42d8b97d0db0eab2c1c30aa86f110fe49c.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
References: <7feeed42d8b97d0db0eab2c1c30aa86f110fe49c.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,bpf@vger.kernel.org
Cc: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,john.fastabend@gmail.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 15 Jun 2026 18:39:43 +0000 (UTC)

--===============3705424124499032894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index b62773ce5219..aa9374dbdb11 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -1232,6 +1232,244 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
>  	return SK_PASS;
>  }
>

[ ... ]

> +SEC("?tc")
> +__failure __msg("invalid mem access 'scalar'")
> +int skb_pkt_ptr_invalid_after_global_dynptr_write(struct __sk_buff *skb)
> +{
> +	__u8 *data = (void *)(long)skb->data;
> +	__u8 *data_end = (void *)(long)skb->data_end;
> +	struct bpf_dynptr ptr;
> +
> +	if (data + 1 > data_end)
> +		return SK_DROP;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +	global_dynptr_helper_write(&ptr);
> +
> +	/* this should fail */
> +	return *data;
> +}

These new cases all assert __failure with __msg("invalid mem access
'scalar'"), meaning they expect the verifier to invalidate the direct
packet pointer after a skb dynptr write.

This expectation matches the verifier behavior change in the companion
patch 1/2 of the series. That verifier change was rejected during review:
Alexei Starovoitov replied "Nack. You misunderstand what
bpf_is_kfunc_pkt_changing() is doing." and later "There is nothing to
fix.", stating the existing verifier behavior is correct.

If the existing verifier behavior is correct and packet pointers are not
invalidated by these dynptr writes, would these __failure expectations
hold? It looks like they encode the disputed behavior from the rejected
patch 1/2, so should this selftest patch land on its own?

The author appears to have agreed in the discussion and withdrawn the
series. Was this patch intended to be dropped along with patch 1/2?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27565623381
--===============3705424124499032894==--
