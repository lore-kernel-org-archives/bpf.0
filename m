Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41D3AA9E2
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788083115; cv=none; b=THOOXaIL0v05KclizbwBb11UikfrWoTv8G9LbISIupE0bZ5EI2yiik4LGu9tKaEouaOKlZzhHK8OlNJ2yLYmxc5f/uXkQYpRGvTTf4Jpd+o2aT0kVzLiBJE9udVAn3uAYwzd5cs5mowbLbaBG8rTHA6uWXNF9ek/DwSaWTNHM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788083115; c=relaxed/simple;
	bh=6GJvWbUBj50XHgl3Qy5K3+RX2r5HTNYkIfj58ICQzeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sxab+k/S8enkAy/dIlc65iHmh5IAmHmatUDUQ6MzvLJacYRyScLG7pbj62xsl6SjEwLJ0seWUlSDrPHxR5OSBKr0kEPi1nDldQZgkGxy6hUbhWqqZTkis0SrGL3J67m+WxtvJj2XiXeho6bspfYf97UZHBXeqgfZn/IZ7iAZf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSIscRDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSIscRDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDD1F000E9;
	Sun, 30 Aug 2026 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788083113;
	bh=zbF/DY/PD90FQwf1R/p8kfnDn5DWcdJxUP60TFtN3ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSIscRDTjTnw5ZXimoC3VFaD4NA5lNQKlVl/bDmB4UqHTYFk5FmGoRpPA085VK1E9
	 Z0moT8Bivr4YdABMcrjAcUegyHh84Yn+R/H1og/2XvSaqEBjTCQZ9+8p48CFToszyb
	 Nzgcp/jj2xZ8l3GyzSW4LnGcLiKRGmoc5k4ozPVO3lvCiMVePcvoFC0dwxwIAYmI0c
	 H6YRha6Pk8U6LgJs/8M0TbheurdQRTGjNiPZ7RfbMWKPk9YAmLa2oijTj9x6CYNSEN
	 T/EqZNEMjA9z8F8rabIjvElQfYs+xG1o7lw413qR4HDb1civM1ji5xWPtj0JiY1v7Y
	 6OUlMY/yYWrtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/6] bpf: Separate stream readiness from
 capacity accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260830093514.4105972-4-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
 <20260830093514.4105972-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 09:45:12 +0000
Message-Id: <20260830094513.55EDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded accumulation of zero-length stream elements leading to m=
emory leak and potential kernel OOM.
--

commit 0e18588b75a5e2877e4350149476217ae3dc124c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Separate stream readiness from capacity accounting

This commit separates stream capacity accounting from readiness by
introducing a new readable byte counter. The new counter tracks how many
bytes are actually available for userspace to read, while the existing
capacity counter remains solely for enforcing the stream limit.

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 99a89533eaef6..b1e6767d8754d 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
[ ... ]
> @@ -88,6 +88,21 @@ static void bpf_stream_notify(struct irq_work *work)
>  	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
>  }
> =20
> +static int bpf_stream_readable_bytes(struct bpf_stream *stream)
> +{
> +	return atomic_read_acquire(&stream->readable);
> +}
> +
> +static void bpf_stream_publish(struct bpf_stream *stream, int len)
> +{
> +	if (!len)
> +		return;

[Severity: High]
If a 0-length string is pushed, does this early return bypass incrementing
the readable counter? It appears the 0-length element has already been
allocated and added to the log in __bpf_stream_push_str() prior to this.

> +
> +	/* Pairs with atomic_read_acquire() in bpf_stream_readable_bytes(). */
> +	(void)atomic_add_return_release(len, &stream->readable);
> +	irq_work_queue(&stream->notify_work);
> +}
[ ... ]
> @@ -176,14 +191,16 @@ static bool bpf_stream_consume_elem(struct bpf_stre=
am_elem *elem, int *len)
> =20
>  static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, =
int len)
>  {
> -	int rem_len =3D len, cons_len, ret =3D 0;
> +	int read_len, rem_len, cons_len, ret =3D 0;
>  	struct bpf_stream_elem *elem =3D NULL;
>  	struct llist_node *node;
> =20
>  	mutex_lock(&stream->lock);
> +	read_len =3D min(len, bpf_stream_readable_bytes(stream));
> +	rem_len =3D read_len;
> =20
>  	while (rem_len) {

[Severity: High]
Can this lead to an unbounded accumulation of 0-length elements in the log?

Because 0-length pushes skip incrementing the readable counter in
bpf_stream_publish(), bpf_stream_readable_bytes() can return 0 here. This
makes read_len and rem_len both 0, which entirely skips the while loop.

Since the loop is bypassed, readers cannot drain and free these 0-length
elements. Furthermore, because bpf_stream_consume_capacity() adds 0, the
allocations never hit the stream limit. Could a BPF program repeatedly
pushing empty strings cause a memory leak and potential kernel OOM?

> -		int pos =3D len - rem_len;
> +		int pos =3D read_len - rem_len;
>  		int chunk, n;
>  		bool cont;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830093514.4105=
972-1-memxor@gmail.com?part=3D3
