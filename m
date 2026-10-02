Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03E425860
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790931071; cv=none; b=ZZFLDfHaWY2U/cGWLbLCjXxfO1lc2XSdJuhbU6Mpfv0ZOG7ttOz0LLNi8Cwy1yrnF1iVPVK3QksamLAhdN0lXoEq8Y+BBjVepr1xHOurQq/aq83UvVgvKuNMKukMAa28n+uEQpHyCpWgzg+A+So67lr7LNumyv8jye3meoOJggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790931071; c=relaxed/simple;
	bh=xoWZSIEv7HOInPUI8RIa16dxBru7TiEIR0PQ+44/t6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF37u8TETcpOXVlDELYyVVoe4/IMl7TK1S3PTdnEUAeu7FHFdjTf6QuXmOBC74xSuSwfY0/fQmQzPdmtUE6Y8FmTD4lkEla6jhSvdNtNvwtZMntU6sPmOnA5tPhbv64Dz+bC7uolSY5ljqgL6Ev1NZBSfiWyljdu6PpZeSUgaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6CwfXrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6CwfXrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D58D1F008A0
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790931070;
	bh=xoWZSIEv7HOInPUI8RIa16dxBru7TiEIR0PQ+44/t6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E6CwfXrqQb0ca/jAvz7YROY5bHpJF4gr3nFeN1YRgDr/ljfULSibjnxFBWQkfvaHP
	 R+VUR0S4iVpoAO+HOtldmgN+zffqbTW5ibz53LX+y79Xdqfn/hdFnLI747Cet6YvrG
	 NYuDprSPlzK8u65zcenVZp/zBCR0aGRjwAChWe9Djeca+a3joQP4VU2yXPfxrCObpf
	 db0cgA8PwjafAgK7jTcmMubgwBVSyrU5tjCNtRdEoYG+7Cq4CfF6LuordswqhMHiI9
	 Jv1msMShx4yIvkbsOIm5aShMcOBhJIfQt4sAu+UB6zM0M7uvyBqUdYp3oK/I1rJCra
	 l3Uaid2P4ZJOA==
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4f5968707fbso161079b6e.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 01:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw4674QgUnC4FNXFYHLSfHDVoHvIz/MG8nl4rBb0JyYDS7rm+2c1+IYn+dAprHgGJiRNI8=@vger.kernel.org
X-Gm-Message-State: AFuF++liHkAdLw/4F8tQP5Bx+TNvHElNbHNhgLQECmVu6lwmYPlreeq8
	o5kcdy+b+70PgsNf14UtCG0ExKaaArIzy5ldu5Qk+leNn4fTzhlftNwp3iuK7dL1bLrmUq0c1VT
	UJj36Wc3uk//LWSVhg66aagKxEWBMRjY=
X-Received: by 2002:a05:6808:169e:b0:4f4:ad3:3ce5 with SMTP id
 5614622812f47-4f529d36462mr1470621b6e.17.1790931069475; Fri, 02 Oct 2026
 01:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me> <20261002-tls-fix-sk-kcsan-err-v1-2-baa0ba056323@proton.me>
In-Reply-To: <20261002-tls-fix-sk-kcsan-err-v1-2-baa0ba056323@proton.me>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 10:50:57 +0200
X-Gmail-Original-Message-ID: <CAL4WiioVeB1Hj9p5t2iO6r_Nhon-n3ooDC3hwOuOX+JVVpMz4A@mail.gmail.com>
X-Gm-Features: AclHuK8ma2xr2S7Nd2mIXaqvV1AfESX8_NNCLGgVpsMCRSopQdfu6BquIF1bhJw
Message-ID: <CAL4WiioVeB1Hj9p5t2iO6r_Nhon-n3ooDC3hwOuOX+JVVpMz4A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: annotate lockless writes to sk->sk_err
To: quanyeyang@proton.me
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 9:29=E2=80=AFAM Quanye Yang via B4 Relay
<devnull+quanyeyang.proton.me@kernel.org> wrote:
>
> From: Quanye Yang <quanyeyang@proton.me>
>
> do_recvmmsg() and getsockopt(SO_ERROR) clear sk_err with xchg()
> without the socket lock. TCP, MPTCP and kTLS already peek the same
> field with READ_ONCE() or consume it via sock_error().
>
> sock_dequeue_err_skb() still uses plain stores. tcp_recvmsg() can
> call it via MSG_ERRQUEUE before lock_sock(), so those writes race
> with the annotated readers and with sock_error(). The same unmarked
> stores exist in strp_abort_strp() and sk_psock_report_error(), which
> run on the TCP/TLS socket.
>
> Annotate those writers with WRITE_ONCE(). No extra ordering is
> needed; this does not change who wins when ICMP error-queue entries
> overwrite sk_err.
>
> Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365=
@redhat.com/
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
