Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D64306D26
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277093; cv=none; b=KSxkSs8yaauqHEfj/RCcwCoB/At54i79d1wtBDBXs4vZq2BSYPz6dqtnzbDH0NfR3cbqXYy6/Ass/Lu+nnlf8SCMQQZkUJYH/YlkdGXjLbYCa4rRuSjvnKq2mt+xADOfqMgbZceyLq51EWI2/Pw+xv9nNyg9OjZkcdA2sRPuzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277093; c=relaxed/simple;
	bh=iaKOcter0zkCbmhrmmL8/WU05F12dugtxd2AKPFSH1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJ2JMSc5eLCssjDj3MgZVJ25jI3zpEHLjixmviCS7WF6KSuxOrXw/gqu/cakSsPs7Lnw0iIAYV9C4nYyHH+jTj/RlmUxJxgoPGS1JV6eZFGqVJV4K4ySfVq47X17Yor/3/gr8XQ4bgtbfja+ZfqG47EkyRzpZA+Tc26PjVS0v2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsQVfOHr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsQVfOHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCA3C2BCB0;
	Fri,  8 May 2026 21:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277093;
	bh=iaKOcter0zkCbmhrmmL8/WU05F12dugtxd2AKPFSH1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qsQVfOHrlPn286Am1TmDQgvIytjyP86DSJ6jUutSBUNr+fHhmkX1RAz13aMZA0Wmc
	 RzTk2VgiEiSV9Cezzzf4BfS+Y4qks18B9UnPc8rxe6HBN/5GlGB6//BDFOBzkynX96
	 cct5LiXTIOD4CG4ebnC7OZ4jbZFf4M3D5/qVd7WNobOOZyCdIYfAtMV2yQ9tEFZy4e
	 Okptdaxjj/4tn5F1olctS7djvln2zkHVzc4cgzgQCv38/rInA4eN/A05PoPuqcJhwt
	 2JsOoyxQDco6r2hySOF4JNKxwA2TwKpPD5/CfPwwuDG3FXutpGj1Jo8KEipTVc7s6p
	 +EAHlZ9m+DhzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
Reply-To: sashiko@lists.linux.dev
To: "Linpu Yu" <linpu5433@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508144344.694-1-linpu5433@gmail.com>
References: <20260508144344.694-1-linpu5433@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:51:32 +0000
Message-Id: <20260508215133.7FCA3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Returning -ENOBUFS when rejecting a TX-only AF_XDP socket during ma=
p insertion is semantically incorrect and deviates from previous behavior.
--

commit cc939da4429db85f32555fd19f4546a51d44ca3d
Author: Linpu Yu <linpu5433@gmail.com>

xskmap: reject TX-only AF_XDP sockets

This commit rejects TX-only AF_XDP sockets during XSKMAP updates to prevent
a kernel crash in xsk_generic_rcv(). It checks if the socket lacks an Rx
ring and returns an error before inserting it into the map.

> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index afa457506274c..3bff346308d0f 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map,=
 void *key, void *value,
>  	}
> =20
>  	xs =3D (struct xdp_sock *)sock->sk;
> +	if (!READ_ONCE(xs->rx)) {
> +		sockfd_put(sock);
> +		return -ENOBUFS;

Should this return -EOPNOTSUPP or -EINVAL instead?

Earlier in this same function, -EOPNOTSUPP is returned when the socket
family is not PF_XDP. Returning -ENOBUFS might be semantically misleading
for userspace since the socket intentionally lacks an Rx ring by design,
rather than experiencing a temporary buffer shortage.

> +	}
> =20
>  	map_entry =3D &m->xsk_map[i];
>  	node =3D xsk_map_node_alloc(m, map_entry);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508144344.694-=
1-linpu5433@gmail.com?part=3D1
