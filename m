Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F893E49D7
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451507; cv=none; b=LO7ICWVzkB5ZY518ENip7sg3+gbKV+UX8Ob5AdiMFHXHATsVam12qmvrNMy4hDIVuw1+aW0JW4HO+gL/QrrAhhmBXrzQG8One7BTD/ZSCDBiOgvCPJEs3cwsGsJ/ZVmHG1UwH90a1zduU/XzTDhYYD7hA+fXmT1Ma49wK7+/klM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451507; c=relaxed/simple;
	bh=19tHQdfD/8aCJgHkadLv7ZXr6kaZLGyopFfwI5xyfIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QvL3XLpFvJZnKQUUCOtY9LaG3ObYyFWHQ2/kOaEOEc8UWLPL4S++fImm4Yo9TXf3YCk+S2lJdHaxLi1HTunfEFaYy3bK75dkFQ292iTOj0s8cun7RM6O3QzP0vSui7V1YTeLrn+fZ/rmmd/OaOYXTmPYuacl9mcRdtEHiNWVxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5mDPLmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5mDPLmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E81F00A3D;
	Thu, 30 Jul 2026 22:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785451503;
	bh=ArayUYNMM+zrMC8Trhi/1wBSPS0WIfTdZOmJnMEJycI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5mDPLmXLGRKxpzIdyt9YxNdkoKjFcCyzmnEaPjVMQiC1FHlfic3a/f1GMtbqN69g
	 v/61zBLOeRNOTbUN+qNCDOGAnbniUSo8QdZ7h4IGd2JSkfGkrZSVoYiyKcIl4uAdXk
	 NOxfDliW7pe5j6I4qlRgiFC5zSH39HPlMtGBmDliD9cwMLMY+Mlt9V2xnbYoVkoyij
	 Q/gXEUtOh4H5kMl4k1TnXEDdT3sm3lwLxxH6mfxaVje+cy+KxqwJSPT5Tf9macIif1
	 8CM8HESASDtXN5qGkyzc+2OTm6XTfKR4aK9hPlKB7+EY4P5Yvge7fE1/zKr9aeYKVC
	 KRL34Rc5eGQtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBGZXJuYW5kZXogKEFudGhyb3BpYyk=?= <jose.fernandez@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
References: <20260730-bpf-iter-tcp-refcnt-v3-1-754b9c8a6717@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 22:45:02 +0000
Message-Id: <20260730224503.002E81F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double release of socket references when batch reallocation fails,=
 leading to a crash.
--

--- Patch [1]: [PATCH bpf v3] bpf: tcp: Fix use-after-free in bpf_iter_tcp_=
established_batch() ---
commit a3c30aa4537ca1f20e7ead4267815490d8e97126
Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Subject: bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

This commit fixes a use-after-free condition in the TCP iterator caused by
reqsk_queue_hash_req() modifying a socket's refcount after insertion into
the hash chain. It switches to using refcount_inc_not_zero() while holding
the bucket lock and skipping unincremented sockets. Batch completeness is
now evaluated by checking if the walk left any socket behind.

Link to v2: https://lore.kernel.org/bpf/20260717-bpf-iter-tcp-refcnt-v2-1-8=
e81f0ac6f3e@linux.dev
Link to v1: https://lore.kernel.org/bpf/20260620-bpf-iter-tcp-refcnt-v1-1-8=
83bf9e69495@linux.dev

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 209ef7522508f..1034757a53280 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c

[ ... ]

> @@ -3162,10 +3163,14 @@ static struct sock *bpf_iter_tcp_batch(struct seq=
_file *seq)
>  		return ERR_PTR(err);
>  	}

[Severity: High]
This is a pre-existing issue, but could this lead to a double release and
crash if the batch reallocation fails?

When bpf_iter_tcp_realloc_batch() fails (e.g. with -ENOMEM), it returns the
error here, but iter->end_sk is not reset.=20

The seq_read() loop will then abort and invoke the stop callback,
bpf_iter_tcp_seq_stop(), which blindly calls bpf_iter_tcp_put_batch()
again:

	if (iter->cur_sk < iter->end_sk)
		bpf_iter_tcp_put_batch(iter);

Inside bpf_iter_tcp_put_batch(), the sk pointer and cookie share a union. T=
he
first release clobbers the sk pointer:

	cookie =3D sock_gen_cookie(item->sk);
	sock_gen_put(item->sk);
	item->cookie =3D cookie;

On the second call, would this dereference the previously stored cookie as a
socket pointer, causing a panic?

It is noted in the commit message that this double-put bug was fixed upstre=
am
by commit 980a81345275 ("bpf: tcp: fix double sock release on batch
realloc").

> -	expected =3D bpf_iter_fill_batch(seq, &sk);
> -	WARN_ON_ONCE(iter->end_sk !=3D expected);
> +	bpf_iter_fill_batch(seq, &sk);
> +	WARN_ON_ONCE(sk);
>  done:
>  	bpf_iter_tcp_unlock_bucket(seq);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-bpf-iter-t=
cp-refcnt-v3-1-754b9c8a6717@linux.dev?part=3D1
