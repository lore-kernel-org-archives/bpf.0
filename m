Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463104;
	b=Tx2VhqG4P/qJqd/wF+WOio5zMIKoc+vi1Ocj8dSUR/RQosNIjArxzwsf3IjXJiX8MHrH
	 hF8SgTGG9C+SneDlGhuc+eDtkfvORmIxRArS7q1s3qSvYJW1Wy4041zeraDouCeWIhf2G
	 m4N7jLX0uVyirMaKDKW0Y6rA771He5bGBdT7toFbpiCQYplz/NBpfvPadZr7qsq93oavz
	 p7VYHH0ArDqnhDxhD3U3ZUbzs9Pt0zVOF9LXDHZAyKLJR2dJjWqLMqTLllc+dU/Jj71I+
	 zjnJaCSyrLRDAHzwMVEFy8A76B183195HB6SqkIaeNUteX5XYFLLO+SiR4+2XwRavnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463104;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=qFiaG34Vx6WxRCrRur37gTgNAO5HEsjP/rzKx89zVOw=;
	b=3cvx3N807LHN1lMqo2oYhWF6pQtjJLYPNWQ5oIdTENwZ7SVbjRBpzqky/isy2BKZpa2Q
	 JVoGovANBqK3f5fL21mwEHxia/nW1ADVQRjeFgkssF9uq0ua+0V4ZvL7KXLHpVlE8mawp
	 qrHCWwZHY0gV1tZfiKQJk8isV37h5hl7fheS1q/cdrQp65wE13Cz7vfAtNMuWJ7zLpj6H
	 QaOA+uflqavYiDktfRi7J0DI4oYeguC4+bYY0tuee9AzUB87X6ax1sWRVunOvqs5jUbUr
	 cfw5O46KHMrx06xlOhkqzY5arW1Ydh+LdxNMEdhhI7TtcDJRkyvOyfrCyyXZoNT7G2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mg08BR33;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544E606A324
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mg08BR33
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B881F00A05;
	Thu, 12 Nov 2026 05:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463104;
	bh=qFiaG34Vx6WxRCrRur37gTgNAO5HEsjP/rzKx89zVOw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mg08BR33LdxCDWIo9Xk8O8MNlj8xeJqelncWwb2qxjnTYxP0B0OarPCgxg0+Ug8z4
	 jSkpAYOQhWogSxc9wxECMKwey3LEzqcwKnzuq+xp5HuBI0Dpr+3FdL7cEvHOHjxnO+
	 IYTsRIZ2laAfQvESzStumY8qWcoOXDjgS+Yn9PaQKVgIW3lVyCYTwEaN+mYwOkpM4y
	 enJWsUsgkqF/XW02G+S3QHUfGNAtGn4sPOr0qqexXx7z4uoFgCTGt9VH0yxVWgwhpT
	 EJXfbL0Z2jGgFoJfdD3C5iCyOEz258uECd0JPUtU/d1eYMcO/+p+86JUso8GfY9Z3n
	 codlGcmRIZr+w==
Content-Type: multipart/mixed; boundary="===============8433683740527222056=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4d767dd560c330fee6b646e99675d84ac5ddecc3f34e2cfc25eeaf580e9bf8d0@mail.kernel.org>
In-Reply-To: <tencent_F9B284A9B4D4533798FEAAFF2ACBAFB75E09@qq.com>
References: <tencent_F9B284A9B4D4533798FEAAFF2ACBAFB75E09@qq.com>
Subject: Re: [PATCH bpf v2] bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()
From: bot+bpf-ci@kernel.org
To: treebacker@foxmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,gregkh@linuxfoundation.org,treebacker@foxmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 05:58:23 +0000 (UTC)

--===============8433683740527222056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Fix ring capacity invariant break in bpf_msg_push_data()

TL;DR: In bpf_msg_push_data(), a push at the end of a ring with one free slot
may now take the copy path, possibly allocating a large GFP_ATOMIC buffer that
can fail with -ENOMEM; behaviour change may be unintended.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index d68b52150405..1bd59dbe4d11 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2883,6 +2883,10 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  	if (start > offset + l)
>  		return -EINVAL;
>  
> +	/* A push at the end of the msg works on the last element */
> +	if (i == msg->sg.end && start != offset)
> +		sk_msg_iter_var_prev(i);
> +
>  	space = MAX_MSG_FRAGS - sk_msg_elem_used(msg);
>  
>  	/* If no space available will fallback to copy, we need at

[ ... ]

Before this patch, a push at msg->sg.size with space == 1 read copy from
the free slot (0) and took the split path.  There psge keeps its whole
length and rsge.length becomes 0, so the code goes through:

	if (i == msg->sg.end) {
		if (!rsge.length)
			goto place_new;

and only one slot is used.

After this patch, i has been moved to the last element and
start != offset, so the existing check:

	if (!space || (space == 1 && start != offset))
		copy = msg->sg.data[i].length;

now sets copy to the full length of the last element.  Does this push now
take the copy path, allocating get_order(copy + len) with GFP_ATOMIC,
memcpy()ing the whole last element and calling put_page() on the original
page?

An element built from the socket page_frag can be up to 32KB, so could
this turn a zero-copy push into a higher order allocation that can fail
with -ENOMEM where it used to succeed?

The block comment says two slots are needed only when the push "falls
inside an element", and a push at the end of the last element leaves
rsge empty.  Would it make sense to require two slots only when the split
leaves a non-empty remainder, for example:

	if (!space || (space == 1 && start != offset && start < offset + l))
		copy = msg->sg.data[i].length;

where l is still the length of element i after the first loop?
Otherwise, should the commit message say that the space == 1
push-at-end case now takes the copy path on purpose?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43163306786
--===============8433683740527222056==--
