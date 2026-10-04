Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A402BE034
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098081; cv=none; b=K9sMSOavGgAOkhj7a+qV7UiIndlUgRFRxIktpRgaaiFoLzQ0zdPtysHFof+Cwu1c0wev7kewKqc0n5O6kP7PBt28LE16uCymD1BhCFtR0N1xiw7ubaQAUTbHM7T7/RqT1bwTkgbCgr3aHo2Ewdw9URAIy1LW3B1Y6Z0nBBY1Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098081; c=relaxed/simple;
	bh=MiVGJpuUzXu1NMw1IGIa5iuBIj0kbgFmcxq3QLtfIJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds7H5jx1sq1dfsKSG0l9QP89md0HwAxeQ1YsP/+x0c2Vxh9KIS1CSnee8POlAvAW7x3/KLR8dsTk1FkH8Mb2f10aTeQCyjw5K4xGW1vWfmSxax3ltzlcOyAa371nMB3qTbfeV8gjPWkRpDK7NSxrfnCIxx5VCQC1GIKsbQozraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OStH2/lx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OStH2/lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9AC1F0089E
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 07:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791098079;
	bh=1NP5uIuhYLbhcM2uz1aoanTRWECoG3FcknJPg8EgHx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OStH2/lxzhyDirYchL7nUiNlvjGnqsO5rT/TJbdqlXZPixerivaOmIXyDhhYqV5Bd
	 DveuymYcjxf38xYeJAydBUBj7COrEHB5EY/isuh4Zllib//y67/J/759xrBaWR5A1A
	 i8sekO81GdjYqXps1HzdLAI6twTs6IVNxXhfOkHCxBW4MNnKO96cAhFjGLeTrysLVu
	 ZEQTeOLSnmf0ouVJdlmKTKdiVHtLhLqAI4z4niI1kKmkJzPIm8fRseb75I/ve0j6CD
	 M2t0gzcC1JJbzkxuAKtH86G5VWl8hR0VsGcpqRj6YiAFnBGKRWCdK0CONfjc+SROoc
	 9WxaqAN6ksPvQ==
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49df0f3a690so125792fac.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 00:14:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwdz99bSj5vzOEPJJ9m1UiWVGc78hrtRZt7gZqR8Zb6mGGq0t0Hise/gx2GWq4S2j1Easg=@vger.kernel.org
X-Gm-Message-State: AFuF++mq2EjPsy4Ugt6UT0oz8ndQ3HBBAZp+YZpM18pWqMcOE6eHSslZ
	HvanZ8dArx1/Fc8OSgFWpLmoT3xWEuKeB7sx6y4oXjn4z5umoEJJkq9qrAjMeczPU/TShfCKXDQ
	YFo/oAdSIzormUfDebczQcaLaINPYOOE=
X-Received: by 2002:a05:6871:520f:b0:48f:e0e5:a1d3 with SMTP id
 586e51a60fabf-49e15ed2fddmr5903566fac.40.1791098078440; Sun, 04 Oct 2026
 00:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-tls-fix-sk-kcsan-err-v2-0-e939a2ebdd56@proton.me> <20261003-tls-fix-sk-kcsan-err-v2-2-e939a2ebdd56@proton.me>
In-Reply-To: <20261003-tls-fix-sk-kcsan-err-v2-2-e939a2ebdd56@proton.me>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 4 Oct 2026 09:14:27 +0200
X-Gmail-Original-Message-ID: <CAL4WiirzoFX6W01xKK4uAiQ+BzecwidVDH8uB9f3cPsiVV_iww@mail.gmail.com>
X-Gm-Features: AclHuK9W8DDTR-B8tQjMNP0pR-aQh83-yiuA0tUmfDsx6xga3FUayfeLkAZfL3o
Message-ID: <CAL4WiirzoFX6W01xKK4uAiQ+BzecwidVDH8uB9f3cPsiVV_iww@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: annotate lockless writes to sk->sk_err
To: quanyeyang@proton.me
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 4 oct. 2026 =C3=A0 06:44, Quanye Yang via B4 Relay
<devnull+quanyeyang.proton.me@kernel.org> a =C3=A9crit :
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
> ---
>  include/linux/skmsg.h     | 2 +-
>  net/core/skbuff.c         | 5 +++--
>  net/strparser/strparser.c | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Has this patch changed between V1 and V2 ?

You are supposed to carry the Acked-by and Reviewed-by tags collected
during prior iterations.

Please help reviewers, they need to recover their precious time.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thank you.
