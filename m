Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468830;
	b=s1DeGpbCcNxEGr7a5i5OOgY+PJiQkKqlU+J8Ff4cuuA/XvexRyRDaK4ZAgEPRGtsmr6d
	 v1rd94+ViQnufHS/56PShiPgYKKhx93JKGh6+pbOS/8oYt2YlGkvAG65RISSOurCYarJ1
	 DMHOucnJH4T0m6yyTD21qb0ZwuJJhpwgPuk0OPG70YGPYGqfdUTqz1WcoD0Ua7n0oIEiu
	 ZmhfNQCyHWF0K896gKtHOWvspcwD32ldPbU9ESg4t6ePl/T6+WIqUAuv/1uts/BwzB9z2
	 pb2s4UUfyWLQIMxRIFbIsa4FQOYZpix5zBNarHr42nO4VS5kq9N+OL7eJ1pw0IeuMYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E1b5Sfsy5ZWsAVdxZQ8ZCmtw3CNPOoNcv9bN+yxCBEU=;
	b=JXYpKsgeJ/my7aRT5NlUKFBUB+FWlPqGqcf1QlovSG0rLcxsLRfzuGBYXEQ3ziZcCyWH
	 4pz6dq/Aiy80aBCiHJ55yldj0G9cqiOgwVT3vANZ6wGvKKtBInsYoUHMWn2097CbimAKw
	 TdqTMIB0rJncbXjQpJBEm2v84GWnjCTbsjRFLGUchjEtg945444jgGzHLPeEYEsqiwWx8
	 rZtLoWgu+Oa/AvwIuiByzBwBxa/sZl3QPFZWcfOG2BC1rWFrPJgvrqtAi5NRsqHobbufj
	 0H0azKgDowpi4IauV/5L7ZALgJjt8cUDE5uZXB54xUbfcIYT+2d8SxatPQaNNeQMe0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQF0UN7q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACE606A333
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQF0UN7q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2256A1F000C4;
	Mon, 23 Nov 2026 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468830;
	bh=E1b5Sfsy5ZWsAVdxZQ8ZCmtw3CNPOoNcv9bN+yxCBEU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SQF0UN7qWaRgfqdSI51k41+ZP/h7VyHd8aTI+WTlxs5n6Dtmmcd6SgqauIrdJLDaq
	 dRCzcLQRsPU3rsa2/KVBiP/0DxmvRXOntaR3t/McZ+pPrxadQMqRRCdayLJRujH6+t
	 iu0HID3xAO68u5fvHrroBB/AaSvOwHH3lcxZZgnuM6plHA10WhzFDw49rP7+UQC5d6
	 bS1mmjWM/+QrDII36tXV9g6ZFpp7PcKljuS/Z9CWesz1XQElqtDVvXbEpgdoMzRn3z
	 WRfVSHFfFDJGNkthxnIaYXifT6xzZuqHELeiJDgJ2x8cFuTE4q5E7EWa5FzYWwqb37
	 DfLt8G+yjwCKQ==
Message-ID: <sashiko-outbox-230078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 09/10] libbpf: Add ring__new() and
 ring__free()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <672644a3994795301e66804ad18983a65efd0d75.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <672644a3994795301e66804ad18983a65efd0d75.1795467315.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:20:29 +0000
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
- [Medium] libbpf: ring__new() bypasses libbpf_err_ptr() on error return
  paths
--

commit 3d8ab4da44ad53020ae84560a8e42655f36bab40
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

libbpf: Add ring__new() and ring__free()

This commit adds ring__new() and ring__free() to allow creating and freeing=
 a
standalone struct ring directly from a ring buffer map fd without a
ring_buffer manager.

> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 90ed354118de3..e794448dcb891 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
[ ... ]
> @@ -204,6 +206,44 @@ int ring_buffer__add(struct ring_buffer *rb, int map=
_fd,
>  	return libbpf_err(err);
>  }
> =20
> +struct ring *ring__new(int map_fd, const struct ring_opts *opts)
> +{
> +	struct ring *r;
> +	int err;
> +
> +	if (!OPTS_VALID(opts, ring_opts))
> +		return errno =3D EINVAL, NULL;
> +
> +	r =3D calloc(1, sizeof(*r));
> +	if (!r)
> +		return errno =3D ENOMEM, NULL;
> +
> +	r->page_size =3D getpagesize();
> +	r->standalone =3D true;
> +
> +	err =3D ringbuf_map_ring(r, map_fd);
> +	if (err) {
> +		ringbuf_free_ring(r);
> +		return errno =3D -err, NULL;
> +	}
> +
> +	return r;
> +}

[Severity: Medium]
Should ring__new() wrap its error returns with libbpf_err_ptr() (-EINVAL,
-ENOMEM, and err) instead of setting errno and returning NULL directly, mat=
ching
other public pointer-returning libbpf APIs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795467315.gi=
t.memxor@gmail.com?part=3D9
