Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB54E9C32
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799734; cv=none; b=JsBLpqN94MuCnFj4KNMWcAkg4RMRIdBer6Ghlon7bJiCr/bqVQ9mZ5+R5g1w2gxiCvju/Mc+kkawN5wAZ4/UhaRUXPYMjfNRRoX9LJbbC/nCQ57+db2bvAyEMPdxuAuWpWY4p3TFLr0kHYzyhpXFn6N7LjZ78+/0vH2RVRa/U48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799734; c=relaxed/simple;
	bh=sejMhlTFp0bKQp+nBsyHvE5RauTefzuyoSkbNytPa7I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UgxK8YZ5RFX7eW+m7QCbYGf4QrEqKlh5ECm7S4N0R0MiQGhHJe6PFRZNV7BnAx+hE/V2WWUW8s7karuegxiYMglTc7jMftoE6ttjYMtSrfglxVzJ2UIvfzVvfJHotN7vD6fxMWub+FHFmQDg64zLlI2jvv3uqXjjqtwQugO33mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naSwgm/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naSwgm/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8641F000FF;
	Wed, 30 Sep 2026 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799732;
	bh=ZkGNz84rX5cQNm5hzBSnbs5uLz96AV8tLl8SA6XA3Mo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=naSwgm/yMhAyhOjrhYhe4IZO/f3y1ERs8BNV4PBg1Kzn4Tx2MBxGW376YH18SqWTR
	 aTS/3kOlU6VeRpoEvPW6SArt66aOIs36bWl1Ho3kvFP5sRVKaXIAXVt9QQwcRnQcxi
	 VhDh4foQh7abHnvs7oGkxnCgzZuf5pBS/WmNyvQyf2QEChn3S9ZPz1wpqdQx3WV7cP
	 aiSNwh6p8z5HCHbOCwdDthPxg9ni2yVxVuIishYp3/mPVG7pqIYkzBqJuLA8vfrGcN
	 JP0tLmDu3fC6NecSMg5Dx9lbFsjeiyrrkZrXWCjaxGh78PBchx5FJ4scqK4xtCxsAT
	 48Tl3ceDH6aBQ==
Content-Type: multipart/mixed; boundary="===============7178183494180677940=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <293a8af9c9209aee56a34777be1829a17b9a3ef752c9a02b9a146e03de45a26a@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-6-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 05/14] bpf: Allow names of Rust types and functions in BTF
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:11 +0000 (UTC)

--===============7178183494180677940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow names of Rust types and functions in BTF

TL;DR: Nit only: btf_name_valid_identifier() now duplicates
btf_name_valid_section() and its name and comment are stale; the review
suggests merging the two helpers.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> +/* Names in BTF of Rust are not C identifiers. Allow any printable character */
>  static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
>  {
>  	/* offset must be valid */
>  	const char *src = btf_str_by_offset(btf, offset);
>  	const char *src_limit;
>
> -	if (!__btf_name_char_ok(*src, true))
> +	if (!isprint(*src))
>  		return false;
>
>  	/* set a limit on identifier length */
>  	src_limit = src + KSYM_NAME_LEN;
>  	src++;
>  	while (*src && src < src_limit) {
> -		if (!__btf_name_char_ok(*src, false))
> +		if (!isprint(*src))
>  			return false;
>  		src++;
>  	}

This isn't a bug, but btf_name_valid_identifier() now performs the same
checks as the neighbouring btf_name_valid_section(): an empty string is
rejected, every character up to KSYM_NAME_LEN must satisfy isprint(), and
the result is !*src.

The remaining '/* set a limit on identifier length */' comment and the
'identifier' in the function name also describe a restriction that is no
longer applied.

Could the two helpers be merged into one (or one call the other) under a
name that no longer says 'identifier'?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============7178183494180677940==--
