Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03529408
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632788; cv=none; b=D8oYMKztYpKnZkEmwa/yGNklmOM8mjikjPFHvphNAuhaxp2NIjwbaT9tokU2SEjFvEc29le3fJ2+3j7JffhmdNI/tQPyBK6e7q5BmshohL3Yx3HxcSd+z79+aKv806DLQSC9iANPF2ZLbjfVh9RP4oAbCNCLLlsVneUveiq6r2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632788; c=relaxed/simple;
	bh=EF8RFePAQT8smGs+aK8h3WRzjf2NktyUmoaRM2DJlk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SFgoRVbL0+hYlVn0CDU/CtbfFZ9J1+L8QU0xrlsnzP46S6OQ8FY68h8pqPJv0YbvVUWCGfMfdejEn9/4nY/Z1GshF1ql8j3y1TLE8CVwE/02O9EPc6umZ0Kz2Cm5wz/OE+YOp5xrHdWwjgd8T/gts5MprjFeSY4Z0NysBDBOcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeTPN2rA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeTPN2rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336D6C2BCB0;
	Wed, 13 May 2026 00:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632787;
	bh=EF8RFePAQT8smGs+aK8h3WRzjf2NktyUmoaRM2DJlk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SeTPN2rAzoftKY/KtWa2mb4mcllVs2Qu6rcwerd+O7VccquOli/WD9Yfap+Hu8Ifj
	 kakXyTJjGD/bg/NNNqa5jSaZMd7Ts4O0ksEd0Y1JqpM73AruZJRrzjMtzxJQfv+ynF
	 YiUcQS/a+ip1LD75NIb6jdCztG+B5UBytDOGTQuYq/Un3IubuXkt4+aNRlnOl8SMX0
	 7DTprXTCtpBMPRzDljTQnNxbSIn3h4l19UjLws03LN40T/nPWLu+n3HwX5jZa8uDyv
	 NgQFXGQljspJkbqsrwEXNJFltNe4XURm15BkB0UoTnrcImnTL+5TtXMSjlQChfS883
	 hBJTifwhDQ9WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/4] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511174920.433155-4-kuba@kernel.org>
References: <20260511174920.433155-4-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:39:46 +0000
Message-Id: <20260513003947.336D6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Silent data loss, stream corruption, and race condition in the=
 trim_sgl error path on wait_for_memory failure.
- [High] Removing the alloc_encrypted shortcut eliminates the verdict retry=
 mechanism, causing connection hangs on ENOMEM.
--

commit 1c563620cb643329347417380b885f1f7483dc0f
Author: Jakub Kicinski <kuba@kernel.org>

net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf verdict

bpf_exec_tx_verdict() may modify the record and the plaintext/encrypted
sk_msg pointers, requiring them to be reloaded. The post-wait shortcut
could dereference a cached msg_en pointing to a freed record if the
verdict split the open rec before returning -ENOMEM. This commit drops
the shortcut to prevent a use-after-free.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 3bfdaf5e64f50..360f71fd78842 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c

[ ... ]

> @@ -1255,9 +1254,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, s=
truct msghdr *msg,
>  				tls_trim_both_msgs(sk, orig_size);

While this error path wasn't introduced by this patch, is it safe?

If bpf_exec_tx_verdict() returns -ENOMEM, execution jumps to wait_for_memor=
y.
At this point, try_to_copy bytes have already been appended to the record,
msg_iter advanced, and copied incremented.

sk_stream_wait_memory() releases the socket lock and sleeps. If it wakes up=
 and
returns an error, execution jumps to trim_sgl and calls
tls_trim_both_msgs(sk, orig_size) to truncate the record.

Does this discard the try_to_copy bytes without decrementing copied or
reverting msg_iter, returning success to userspace for deleted data?

Because the socket lock was dropped during the sleep, could a concurrent th=
read
have pushed the record and allocated a new one, meaning trimming this new
record using the stale orig_size from before the sleep corrupts the concurr=
ent
thread's stream?

Also, if the verdict split the record before returning -ENOMEM, would orig_=
size
refer to the freed record, causing out-of-bounds trimming logic?

>  			goto send_end;
>  		}
> -
> -		if (ctx->open_rec && msg_en->sg.size < required_size)
> -			goto alloc_encrypted;

Does removing this shortcut eliminate the verdict retry mechanism?

If the verdict fails with -ENOMEM on the final data chunk (where
msg_data_left(msg) =3D=3D 0) and memory subsequently becomes available, rem=
oving
this jump means execution falls through to the loop condition and immediate=
ly
terminates.

The record is fully constructed in ctx->open_rec but is never pushed to the
engine or transmitted. Does this leave the data stuck in the buffer
indefinitely until a subsequent sendmsg or socket close triggers a flush,
causing the protocol to hang?

>  	}
> =20
>  send_end:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511174920.4331=
55-1-kuba@kernel.org?part=3D3
