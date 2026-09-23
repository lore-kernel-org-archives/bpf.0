Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6C3B895A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200206; cv=none; b=EZ0YMsqFzYrKr110+UG17/OjYafzBE0/6S46tu0/WWGoPaAuzTI6QtjIxQko25kaJRsr05al1QG/AUZQ9tBBEa9GCX/GvA5M36SbAx5hKWhyMo4CTyym3rQP49HkR6/pttzHjFsC80x5Cvu2tC0c4ZZQ2lE+nTlq5ai1EhCOqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200206; c=relaxed/simple;
	bh=/mJv5gCtvC/swf3EfVXWeaU89XvYrBUee4ZqQWC0Cfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dbSKfbltgOG0hHltQ7bbSWKDciZI6YqNrONnQcyWVyTh24Iis/IKbb9cF9omX7JTA5l8Q8+a3ZuPppEe5YYzLVCtZ5zJKhRlIWi+/4frmnwfNKmEP3ym303/oxWnYILKPQUWUeynAok9yZE1UhKR+pyojGsW39LVYzqV43mASB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRZeKRc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRZeKRc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0F81F000FF;
	Wed, 23 Sep 2026 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200204;
	bh=SDaSNoiYd1NZgECLxf/whSGrL5Wrw2vkcmE0Edz7PnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRZeKRc5I7MBuRtRz6ksIICeCILX+fvxwvUo2U/OR66clVBshJC1wHS7BBatWEiEV
	 JR3KRicxPFtB/pnKpoALc9k23pW/UJsscVpUv+0Fu/KFOImezZjGSmGsuq3Lo/rEFh
	 CDVFB1wOIhJ3GiZ9CUFjsHfoWEwBL9eL11wnTibpoIh1kOcTHj+WT1WxnLPlItR2in
	 yBgTV8Pj/AMdYy2qB96BVbqhktLe41oce5/gNt+4wOMMmKMJ5ZxTfjhLvX7qh6KMNY
	 soYr7iKOSGReJFf7fFjzuroVxTm9E3KRyTCQDJqKTqT53USQbv70232RMzQtQNNnEm
	 gWyGX0ueAFKBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923213719.224838-4-kuniyu@google.com>
References: <20260923213719.224838-1-kuniyu@google.com>
 <20260923213719.224838-4-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 21:50:03 +0000
Message-Id: <20260923215004.7D0F81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation for BPF_SOCK_OPS_RCVQ_CB_FL=
AG
--

commit 304bdb98cffa8e2d03b8207be4eaaadba075d6be
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().

This commit introduces opt-in callbacks to bpf_tcp_ops that are invoked when
the TCP stack enqueues or dequeues data to the receive queue. These callbac=
ks
allow a BPF program to parse each skb and dynamically adjust sk_rcvlowat to
suppress unnecessary EPOLLIN wakeups.

[ ... ]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0aaa54359aebc..3f0877b5867bd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7148,8 +7148,17 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> +	/* Call bpf when the TCP stack enqueues/dequeues payload
> +	 * to/from sk->sk_receive_queue.

[Severity: Low]
This isn't a bug, but does this comment violate the BPF subsystem multi-line
comment style? The BPF guidelines request that multi-line comments have the
opening /* on its own line.

> +	 *
> +	 * Only bpf_tcp_ops is supported.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),

[ ... ]

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 0aaa54359aebc..3f0877b5867bd 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7148,8 +7148,17 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> +	/* Call bpf when the TCP stack enqueues/dequeues payload
> +	 * to/from sk->sk_receive_queue.

[Severity: Low]
This isn't a bug, but this appears to be the same multi-line comment style
violation mirrored into the tools header.

> +	 *
> +	 * Only bpf_tcp_ops is supported.
> +	 *
> +	 * It can be used to adjust sk->sk_rcvlowat and suppress
> +	 * unnecessary wakeups before sufficient data is available.
> +	 */
> +	BPF_SOCK_OPS_RCVQ_CB_FLAG =3D (1<<7),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923213719.2248=
38-1-kuniyu@google.com?part=3D3
