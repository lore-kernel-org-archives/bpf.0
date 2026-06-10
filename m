Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16933DBD7D
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088749; cv=none; b=Wni2/uLjkPP9M4ZFQzh70eimWeL+gD1dWWC2cxqIE+gp126LIPPxxricNKO7W96O2Zy/zyYD3y26RVbkB1xIxV/7QKfB0YWkEBVvh0+ix3C/qBY0EredgKcp8fh5gFcdJ3IkdFefZzangvwuBxg7ccih8HOZEwVW/PJMQzqLANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088749; c=relaxed/simple;
	bh=c0evrJyy3gc7h3HbpxRgdXmZfk6aV6d3JmOCU+uSWj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpqrLUZZJGZdE/ggPp5cASjYu5h6XJFUsVLVULmsVAzXZ1V4v4FHOiFbF7g+NGdD22XGRS7onxq1/1sYW9/O6BCXDTrqpAx1A+HcGck2j91xyCNsDwE2pbq+zedjSnawdBAyJ+IMgLvZCyNRb84d3buVT2KyN0lmtDwfY+5rA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDDndo9D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=icr2JjsO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDDndo9D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="icr2JjsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781088745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDfYzHZ/iAtjAqdLJHyxkbGm1bEccQWrFTq9p8hRVjQ=;
	b=CDDndo9DAMhPpktaGpxCfGN5piozxFWzvHrGohofODaeflV481FzvkAaqMz9UECrVuKVqn
	K6Lr8M0h3vuG9zZNJGW6F2gzs42Tah2SrhsNe7ch/tEoGxbq+bx5UUvvmZXMT66qetida1
	ps5isAkpokXqxRMOUOLJAoY3NxJKXAI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-MKOJpheONRq8KdyNIFpk5w-1; Wed, 10 Jun 2026 06:52:24 -0400
X-MC-Unique: MKOJpheONRq8KdyNIFpk5w-1
X-Mimecast-MFC-AGG-ID: MKOJpheONRq8KdyNIFpk5w_1781088743
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4600c8cb13aso4059672f8f.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781088743; x=1781693543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDfYzHZ/iAtjAqdLJHyxkbGm1bEccQWrFTq9p8hRVjQ=;
        b=icr2JjsOXN8Zhl8A174DmyMp9E29Sw2cszww5tHSx7JCLdErn5sPSY/rE7t9JV7fnG
         V8Ad4ILdgz7U4DCSOUZRF62BUIit0IZPppt1QuKMrM4qVBPJ+1TVk/mspd+hTyC730ni
         sWrFJMDYe+VW+/H3Th3nmTomoNa+alI2dKe1fsdDDqWLg+y7psHoyewDFCotZmgMFc+a
         fwr1MB04CiLI1lg+9sF2px9PS8btulZa8Or16v6ds6Pc4gz8uX/zJqd1MhsQjya+UBKi
         YB2B7r/oP6Gk4WI4sDxoJrtNf92ThIwwPp25Wdt0VtfGSS7BfNFWaGx9UEBrC6X/NDKI
         2VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088743; x=1781693543;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDfYzHZ/iAtjAqdLJHyxkbGm1bEccQWrFTq9p8hRVjQ=;
        b=jko35zb6BxquV1/XNIo0yqMZSisDHwU22kz8nwfMyUClURiba5KQIdMWaotK9DrI74
         qGgEdNoOpO1sqpqfHk29Psbk45GczMaLfe2JOoctDUz22MjTxW7nEDXayRWRJAfm/MRi
         2k7G66Lu18vHZyRqWPOnR+LuQ0X141m1uyQ+2ZbmH2dudtbJmHVFAY4/gpMc0BHhz0zG
         5Im753J48C3o6ySWDMT23ToFldXTwgpmBjDjnB4mxZtl8MONsyYWgfCLCqry5/Nl2jLA
         /PKtVAB5+FIEMjL2bwF+ZOPnsyTCGvk4U3sceayZUpmgLgborY9QWZ7nZXyGqhBjCm/m
         Tg0A==
X-Forwarded-Encrypted: i=1; AFNElJ+O+80rNd/MwfswejfnUlsxkdwOZI2uPEp1WxpEgB6s3kAO3SPDZFQnEAGr7ygKz34al0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkx99H61lqHQBVzoTA8mjrdJzg1XLHBhTdmnuIodDjpaBrDL+L
	P7AjrETDlbYGjJv9BIYGlrrp2qOoZ3jy/Ud4J3muWHudjL/1LiiY70waZWNPbP/a/H9XboFJvfX
	8auNILRc8ZpgpLRlqVfVi4z7AcM53lixtwf73MgmP4KvtRcluCowSPw==
X-Gm-Gg: Acq92OEwj1XWpPzGzVObp6gfE6JtGCsqn66pxqpLvhWLWrvoYc4uKrH1vNmlSbGNdJM
	4J3WPBoKFCTVpYWqwjGUWmaormU+pvl0JCsl94ORR9p75GXOjLBFQK5P/1dSmEiauEadpVTO2J/
	lDra2SgcytyzQsjbi9AwiLgljjO+1tqHeMPMY7vKjr8O4zd7fJmbsIyCEOWFsKIknxYKFubef+V
	D43ddNH52OTWph8wm6p3rT8ZeZU17o4a23Tm0pmlxYZJ7WbSxoveTjDfjQmaXBvlEa0diIpp1o+
	J9uQBs+lg1xe5QafS8B8XGLSptjg8ejTj1WChJN9bRCDSq8kKSxDOJ0Ulpzp0Aq50WVWaWEGmA4
	CWZkrHvVAS+LiJ/cu5wRfhVEHEanO15LB2IGkV2va6TcREt0x3YKQCNzREAc=
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id ffacd0b85a97d-46030631ba3mr27398903f8f.35.1781088743515;
        Wed, 10 Jun 2026 03:52:23 -0700 (PDT)
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id ffacd0b85a97d-46030631ba3mr27398861f8f.35.1781088743089;
        Wed, 10 Jun 2026 03:52:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm67667793f8f.18.2026.06.10.03.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:52:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 51F137BC7E2; Wed, 10 Jun 2026 12:52:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis
 <emil@etsalapatis.com>, Sun Jian <sun.jian.kdev@gmail.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private skb
In-Reply-To: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 10 Jun 2026 12:52:21 +0200
Message-ID: <871peeacre.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sun Jian <sun.jian.kdev@gmail.com> writes:

> Generic XDP devmap multi redirect uses skb_clone() for the
> intermediate destinations and sends the last destination with the
> original skb. This can leave multiple destinations sharing the same
> packet data.
>
> This becomes visible when a devmap egress program mutates packet data.
> One destination can observe changes made for another destination. The
> last-destination path has the same problem: the last destination runs on
> the original skb, so its egress program can modify packet data still
> shared with earlier cloned skbs.
>
> Native XDP broadcast redirect does not have this issue because
> xdpf_clone() copies the frame data for each destination. Generic XDP
> should provide the same per-destination isolation before running a
> devmap egress program.
>
> Fix this by making cloned skbs private in dev_map_generic_redirect()
> before running the devmap egress program. Use skb_copy() instead of
> skb_unshare() so that allocation failure does not consume the skb and
> the existing caller error paths keep their ownership semantics.
>
> Add a selftest that covers the last-destination case where earlier
> destinations do not have a devmap egress program, while the final
> destination does.
>
> Tested with:
>   ./test_progs -t xdp_veth_egress
>   ./test_progs -t xdp_veth
>   ./test_progs -t xdp
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

With a few nits (see below):

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

> ---
> v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=3DNWi+N-0sJZWvMwY=3Df4iF6=
-3TVMS8=3Dm07Zmw@mail.gmail.com/
>
> Changes in v2:
> - Move the private-copy step into dev_map_generic_redirect() so the
>   last-destination path is covered as well.
> - Use skb_copy() instead of skb_unshare() to keep caller ownership
>   unchanged on allocation failure.
> - Add a generic XDP last-destination selftest case.
>
>  kernel/bpf/devmap.c                           |  10 ++
>  .../selftests/bpf/prog_tests/test_xdp_veth.c  | 151 +++++++++++++++++-
>  2 files changed, 158 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..59f267685bc6 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -700,12 +700,22 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, s=
truct net_device *dev_rx,
>  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff=
 *skb,
>  			     const struct bpf_prog *xdp_prog)
>  {
> +	struct sk_buff *nskb;

nit: this definition could go inside the if statement block below, to
make it obvious that nskb is not used outside that branch.

>  	int err;
>=20=20
>  	err =3D xdp_ok_fwd_dev(dst->dev, skb->len);
>  	if (unlikely(err))
>  		return err;
>=20=20
> +	if (dst->xdp_prog && skb_cloned(skb)) {
> +		nskb =3D skb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		consume_skb(skb);
> +		skb =3D nskb;
> +	}
> +
>  	/* Redirect has already succeeded semantically at this point, so we just
>  	 * return 0 even if packet is dropped. Helper below takes care of
>  	 * freeing skb.
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/too=
ls/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> index 3e98a1665936..1f0b9ade12fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c

It's customary to split changes to the selftests into their own commits.

-Toke

