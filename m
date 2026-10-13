Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C84FB9A8
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903692; cv=pass; b=Z+jkPj55/V5OPnzjmOvZIx4jYs7ynVdnkHjiHX/Uu/cfMRLhDRQPVYrynpJhn1HTIFuQoHSdBgaEHLdBjRAIxgUh8FEbWY7eGESfResA4wsy2WqaZG7TRJimLEdC4WK/DLiQx005OvDFmh6Bak55/AK8Y2Ch4hdfbyM8vT8qo9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903692; c=relaxed/simple;
	bh=tw/fVrFqpZzJSyIZ5wzwHJRG0AwN51iLSFbnVvJXUeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a336SFvMnq3nae1g7thot3XCveJj1DVMsh4FcPs7k+5TSiaw9zwurwe7YUmCjnYxVaWsl3pNu9JaowgkAWZNzadCGTIM1TCW/XyORGf1aHHHSz/miN90MPYxETNIObfpa07+HQmdjTkpAB7quTdS930PO4jNxY9h3eZoI33qOXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdeFJnFj; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdeFJnFj"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso25680a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791903689; cv=none;
        d=google.com; s=arc-20260327;
        b=fz8thRYgCej9Xnsgqe1k4QXVgLFkEAkwgi2bfib9DV9qE645sNHMlvzES3OcT82a1a
         X8ADjEgAaSz/h98jwA+azZJIfeyjQHZ3hzwLFJB/G1fvMX6/NDlesm3uGOpPEQuYUf1g
         C6kr5iWnTGZIAzUYElUZscpv9FFzfrl3odAv/fOMGHUlZ+rP+KH77e96swVtov2gALkf
         tq17Hqyj4vYiHbn0wa91cp22gcoxustRRVhQ6rRF1q7pJjMtVUdkhDKcUcb0eYkKm2pr
         dNiIlhInhFsX2f58C/NKe1e63cMmTZ4cqwE9ttTdnQpUeqjdO8tiNNM8f4pmvzSD+fA7
         jYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rymSkdZezJnGb9FeGEEgvGAMLZUCeRFNqmLOcwpB228=;
        fh=PQ3mZQ5oYgX41QMRRCdlMk+3hu9Q+dJUn5s5efnw4sI=;
        b=ZQUvm8/n8JwZ9rtc4ARPjcDX7QHOJx28m+r4bYFsJ2NMvTONFnIrEQ/dFJRyJcu5s8
         Wtq0MDGByHRZvHAdbStUbsomAo0ppXsdAWW6EAhfMlrHE1Xj0whaJylvSkMy7tosaO7C
         oxB0iCiHTg0pXjDeCvVx9hB47A3gdUuid1n81bJ2Mhl26yU1iICvUOrG9f96vp1E9yks
         W0sTMAiwR1p+BOUAlf99rOEGtQdcYBrnhWCOohxZlr7//vKA5I3vLF3AAgkRcOqja4FK
         gj3R3Dr+dYOXstS0kSfUBhu+8RS7Ss156ioiaMFAqBU9KlLOjWqjwMA3e04eG9Y6NEG0
         KuxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791903689; x=1792508489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rymSkdZezJnGb9FeGEEgvGAMLZUCeRFNqmLOcwpB228=;
        b=qdeFJnFj9/9ZCIJ7Kl78fEn7Xr+7jToAszoCs9mnnUQMkFGdtUq0Vt9xvt82Rhbm98
         Xf4cYvqAc17Yz175Kr4jlW67zTllhSSH1TgIDA+fyEEycY0r7xXbkzNcgccmd5XaMrl8
         I744D6yhxytWlq6Kmwg5eHsxn1USSFKJbvfZ4s72dI5NJaEXpkbgt3hFlBRxYhFhAwNd
         TjMe4oWQGgmTo8sbIAlxbLQ3SxUMJNSSqoc56SPxHMNo4LzsMgWRrs9IMHqASXesSUjl
         wOTSjrOTYaUMF0iFUM4ds5+t1Gnl59uapjglfYsFriknYC9uCpOB8nhVnZ3fi5GwcXTR
         hbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791903689; x=1792508489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rymSkdZezJnGb9FeGEEgvGAMLZUCeRFNqmLOcwpB228=;
        b=rLB4pOytF82nMBSVg9q4mCE7H8nLxcRbp1YPTqyMcSxwWqXywWssP/POvJKYxsylZY
         sRk/Syl40wtl/bkrEFpAgZgcjEPMiz0/sIgoQdeLUd8wJTMHt2DI1DCQ3AWQX/Wim9mH
         BYIi424de02trZhFoxY5EXgb8/IwAXyFYGvf9Z7nnr0ilrQBFJCQgLTxYZFkaS/uDtuP
         DsKqM2nNHMnLeYkV81Bf+JeYF9QFy93k9XlbqbY7GYiLj62LxoPQza31Ma50ZZQLu2YK
         4ko2yLcjOZ6amUNT2qecpLfmD2A6sYxh144z+1vHLvfTVLkxlSPQoPKFWEP4/vPLtkDL
         tkjw==
X-Forwarded-Encrypted: i=1; AKwUvBzicYTa8/zrTyzLRvmUl6mKKC1IDovbTqo9JMMx34jtIjxYsmyzvdVL9P6yMPPjYRruHwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHMLJBwY830vj98mC+kgq9yKIrr1miZq1X5D4AgVtCMX+miQ4+
	vz4R9HvePeKOuu7Hm4UbdZ2Womfkr0pbbCBhcXjK0AckJVdg6cvEkQXnkZS7/zSbwHUC3SCsCGU
	9l+AcklkQ5mulw3IXXdFZOsBScadvVYwKS3hrAbhSPpNTvBAdtfKsrxkd
X-Gm-Gg: AYBFou3/GU5P3XJ6BP+Zl82W00+BNR7nm0rj0g4oQ1LV0IF/W5ojjn56yn8ye38k1o4
	GQJ8k767TrU1JxuUfGWBc64NK8JqFToZX93IZrEk37szi/Esf/kS4uQYyLwrRHmCYk/i2BGHrVt
	4vmwfzLIOQQB8v6ryoxD8m2gJUU91ShjEABIaa84ITBZVu4/KsE0vshKAjkb8d8LpD+rO4mqDZD
	GHnbfgOcRMfQ/rhixdcwE+bXcytnIH56+vpnQDbSM358eyej1rgblzhYWIOHzSkwNavtmTx0IHq
	wTxa5h7XeIks70D4R53FiwpQipyfucoFeNQuOzn2NiEKMsscjv7VuGSqfJbQcDULuRON6wFPgYl
	yNun4qUliqYM=
X-Received: by 2002:a05:6402:652:b0:6ac:bdfe:116 with SMTP id
 4fb4d7f45d1cf-6b199a8e6camr137824a12.16.1791903687982; Tue, 13 Oct 2026
 08:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012082148.1698596-1-almasrymina@google.com>
 <20261012082148.1698596-7-almasrymina@google.com> <sashiko-outbox-169237@kernel.org>
In-Reply-To: <sashiko-outbox-169237@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Oct 2026 08:01:16 -0700
X-Gm-Features: AclHuK8M8mD59YUfA3CRA-iHfHLQ1szT4G06vA9qiJ8Q4zstPlMFFHmXtF7_XfU
Message-ID: <CAHS8izNBV==1fOkO+NP-vBznqtLZe9EzdkEj08gC_uZHiTRLhg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/6] net: kunit: test netmem, page_pool, and
 skb frag refcounting
To: sashiko-reviews@lists.linux.dev
Cc: linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 1:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] net/kunit: kernel panic in TCP devmem test due to unset skb->u=
nreadable
> --
>
> commit 432a5016a6d079e3237437e79dd79f25313c4f7a
> Author: Mina Almasry <almasrymina@google.com>
>
> net: kunit: test netmem, page_pool, and skb frag refcounting
>
> Verify that non-pp (page._refcount / binding->ref) and page_pool
> (pp_ref_count) references stay balanced without cross-counter leaks or
> underflows across regular pages, page_pool pages, non-pp net_iovs, and
> page_pool net_iovs with both pp_recycle=3D0 and pp_recycle=3D1.
>
> > diff --git a/net/core/net_test.c b/net/core/net_test.c
> > index 9c3a590865d26..6f21e6baf7fb3 100644
> > --- a/net/core/net_test.c
> > +++ b/net/core/net_test.c
> [ ... ]
> > @@ -370,10 +370,1213 @@ static void ip_tunnel_flags_test_run(struct kun=
it *test)
> [ ... ]
> > +static void netmem_ref_test_tcp_devmem_recv(struct kunit *test)
> > +{
> [ ... ]
> > +     /* 1. Receive via tcp_recvmsg_dmabuf -> SO_DEVMEM_DONTNEED releas=
e */
> > +     skb =3D alloc_skb(0, GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_NULL(test, skb);
> > +     skb->pp_recycle =3D 1;
> > +     skb_add_rx_frag_netmem(skb, 0, niov_nm, 0, 64, PAGE_SIZE);
> > +     napi_pp_get_page(niov_nm);
> > +     TCP_SKB_CB(skb)->seq =3D 0;
> > +     TCP_SKB_CB(skb)->end_seq =3D 64;
> > +     skb_queue_tail(&sock->sk->sk_receive_queue, skb);
>
> [Severity: Medium]
> Does this code need to set skb->unreadable =3D 1 when injecting this devm=
em
> fragment?
>
> Without it, tcp_recvmsg_locked() checks skb_frags_readable(skb) and retur=
ns
> true. The TCP stack will attempt to copy the payload using
> skb_copy_datagram_msg() instead of processing it via tcp_recvmsg_dmabuf()=
.
>
> This leads to a kernel panic when __skb_datagram_iter() executes
> skb_frag_foreach_page() and retrieves the page pointer via netmem_to_page=
().
> Because the underlying memory is a net_iov, netmem_to_page() returns NULL=
 and
> the subsequent kmap_local_page(NULL) call crashes the kernel during test
> execution.
>

It certainly doesn't panic when I run it. And we're testing
refcounting here, I feel like going through a rabbithole of what skb
flags may be wrong on these test skbs may be pointless. And general
design is not necesasrily net-iov =3D=3D unreadable.

> > +
> > +     msg.msg_control =3D cmsg_buf;
> > +     msg.msg_controllen =3D sizeof(cmsg_buf);
> > +     ret =3D kernel_recvmsg(sock, &msg, &iov, 0, 64,
> > +                          MSG_SOCK_DEVMEM | MSG_DONTWAIT);
> > +     KUNIT_ASSERT_EQ(test, ret, 64);
> > +     KUNIT_EXPECT_EQ(test, atomic_long_read(&niov.desc.pp_ref_count), =
3L);
> > +     KUNIT_EXPECT_EQ(test, atomic_long_read(&binding.ref.data->count),
> > +                     base_iov_ref);
> [ ... ]
> > +     /* 2. Receive second packet & destroy socket to test
> > +      * tcp_release_user_frags() -> napi_pp_put_page().
> > +      */
> > +     skb =3D alloc_skb(0, GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_NULL(test, skb);
> > +     skb->pp_recycle =3D 1;
> > +     skb_add_rx_frag_netmem(skb, 0, niov_nm, 0, 64, PAGE_SIZE);
> > +     napi_pp_get_page(niov_nm);
> > +     TCP_SKB_CB(skb)->seq =3D 64;
> > +     TCP_SKB_CB(skb)->end_seq =3D 128;
> > +     skb_queue_tail(&sock->sk->sk_receive_queue, skb);
>
> [Severity: Medium]
> Will this second injected SKB also trigger the same panic since it lacks
> skb->unreadable =3D 1?
>

Same.



--=20
Thanks,
Mina
