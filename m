Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403245;
	b=lWoS/4JzO6vMNhF9f8MAXTkbge1HBhMaQnkSXlYjhK/5X/sEdrJaX+YHgz4W/OswVqUo
	 LLvJmZCILHK1k43SVVE+BGR0fApRN+zFaDPk8F2H5+cxljQ80qbk/q7ltmhEf7AROw6/O
	 GjbGuviLgtiuQXc/8Cpy/IqguAfuTQrFZoy9QjQxRj38/DQsp433At4PYZfCgE7Mkrw9I
	 GaLBy+TRQODaJQiodZHDGB4NrwqitxnR9UslLN+PR0QNjEe0GRPhz63l8yhLr6ciray02
	 gE/sU85rnsjkiGNY23OypR2HiWIyG6tx6Q+7okmN5hwIw7Xiyr0508X0hjmaDx/DFZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nz+lU6NzHkFTzHdV3toDL+lvzJMf2yK9WvWSOpYO6OI=;
	b=YWJVVXCpb6LQAJTbAuc4C6+A/qtD/hsikhfc5V79ArZ6yJZx6lLVg2NncgyP5hZHH48K
	 cG67+NvLFcvaIleA5NRIOQe2awaZ7UEWBLbXcg7TvdabDoQV++cHeg5kcIUHfvCk0ZLQt
	 7hMt6nwykOrv7kAmR69TotanyzCfrlALbbeonWAWbhuTQbXCcMXvG7F7wJygNOkwMxhO2
	 kMEvlLVkGup8GVuaA1JiSoLfDIRWOwBTYGE1gXzb/qkEw8kyKFCvJZ0cBM+w5drypNlDz
	 J50QMwNV/M9CasY0g1j6D8OVkXJ8t3m2gbM7FNk10pB9Vxsc4zybFJeFeKNBUmGTHcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJzCTCNm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F6606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJzCTCNm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481791F00A06;
	Wed, 11 Nov 2026 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403245;
	bh=Nz+lU6NzHkFTzHdV3toDL+lvzJMf2yK9WvWSOpYO6OI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJzCTCNm1N8K045Edp2WfH3wOW9xGRTeSHfDimdh49oXp56jXvwnOcoXAnE9r4sKR
	 KmhELwkZXoPRPn917/dprqnDIvYx9UrqLiuCr+A+6y/LKg2PSe2PbG7JQ/z9JjgIEa
	 jJz5CtxnyAwn8I3/NOohRqUxDHcp71m67COYir6WPx6wrtJA3FPb6e8ORXqzZ2LSEG
	 PQQS6zjoP/vnm42vEsok+/1Z9RwkjPoLqoZ574VsgfNbTgj2UqNjdwi3OpBeRtCdDa
	 1q4rA9qYotcjXCkY8xwg9MR3e1J3kNWPGsGKkDn/AeEN5vMyJHbQDQNTmTCfTvBGn1
	 dA48pDr7wAYVw==
Message-ID: <sashiko-outbox-209060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 03/12] io_uring/opaque: add backing
 accounting and immutable versions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Markuze" <amarkuze@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110132006.3280986-4-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
 <20261110132006.3280986-4-amarkuze@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:20:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] io_uring/opaque: wake batch limit bypassed in
  io_opaque_wake_budget()
--

commit 330c6e48123376b4807cfeaa9a7e897d4c81a279
Author: Alex Markuze <amarkuze@redhat.com>

io_uring/opaque: add backing accounting and immutable versions

This commit adds backing-byte and extent accounting, immutable payload
version references, bvec/anchor vector building, and generation handle
lookup for io_uring opaque TCP payload objects.

> diff --git a/io_uring/opaque.c b/io_uring/opaque.c
> new file mode 100644
> index 0000000000000..2fd9db898e672
> --- /dev/null
> +++ b/io_uring/opaque.c
> @@ -0,0 +1,399 @@

[ ... ]

> +static bool io_opaque_wake_budget(struct io_opaque_store *store)
> +{
> +	struct io_opaque_req *op, *next;
> +	unsigned long delay =3D MAX_JIFFY_OFFSET;
> +	unsigned long now =3D jiffies;
> +	unsigned int woken =3D 0;
> +	bool stopped, more =3D false;
> +
> +	guard(spinlock)(&store->wait_lock);
> +	stopped =3D READ_ONCE(store->dead);
> +	list_for_each_entry_safe(op, next, &store->budget_waits, wait) {
> +		struct socket *sock =3D sock_from_file(op->req->file);
> +
> +		if (!stopped && !READ_ONCE(op->stream->closed)) {
> +			if (time_before(now, op->retry_at)) {
> +				delay =3D min(delay, op->retry_at - now);
> +				continue;
> +			}
> +			if (!io_opaque_budget_ready(op, now))
> +				continue;
> +			if (woken =3D=3D IO_OPAQUE_WAKE_BATCH) {
> +				delay =3D 1;
> +				more =3D true;
> +				continue;
> +			}
> +		}
> +		list_del_init(&op->wait);
> +		/* A wake is not a reservation; the collector rechecks on entry. */
> +		woken++;

[Severity: Medium]
Can a closed-stream entry bypass the IO_OPAQUE_WAKE_BATCH limit here?

Once woken reaches IO_OPAQUE_WAKE_BATCH, any later entry on
store->budget_waits with op->stream->closed set skips the conditional block
and increments woken to IO_OPAQUE_WAKE_BATCH + 1.  For all subsequent open,
budget-ready waiters on the list, woken =3D=3D IO_OPAQUE_WAKE_BATCH is then
false, so they are all woken under a single store->wait_lock hold instead of
being deferred with woken >=3D IO_OPAQUE_WAKE_BATCH.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132006.3280=
986-1-amarkuze@redhat.com?part=3D3
