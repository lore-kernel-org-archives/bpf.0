Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493538;
	b=dOIQvSHUDgItjESnaJcaSN9Uuvd50E9ACbPMG26/EqoeYok6zufLTHbH7TQu/xgfBulk
	 GH5qIG2DpCZwtn1sPEUlqXMWjn8s/yC3zESxjX9Fy129Zs86PLuvOrAuJt6qOXQHJeWZ5
	 RHa1AE2MkT72ASY9GugFncR/VZCbtj49ml5oWF5Gjozfo1HoqcfPFtVrzdUMUrX2Y1nBo
	 9VTDHp++mGs5Hx6BB8uGTKSKwVlpjRd6lQeaJ8Vxk5MJHx/5xPWgHxLOcQZ/ammqLqc46
	 pRlVXzOpCRRQw/ccLNFo+pHrJ91vOQbWffNv0GZmWicabNa2NIRbfK9n0dBTEmkxsgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493538;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KeMzwCuL1HDw5ZoSQ8kH1JqNJ7FZsCuEkwC13MbO6B4=;
	b=5jKtyOLS8++WJss4EUi+wqCajK+JOjRDJ+36bBP+2Bh9CaPP4h997i287Smkop9sawQ2
	 B12bWhtB3zH1De8dsAr2Xbv4APwSeel4+Ei4gSmdY/wYfAINR21I3CeGlkuGv+I7P9tVX
	 1vebGXeJFicFZl0zUwr9aWd0KAba9P5uZnVnoJz8e6RZmm4adnf9IakmKJPKNU5wQmhIP
	 ijkvvdC7yiZKWHI08Xsun635qhDVZfb1zLD3wmrJLqqQpoMBk2JybfGvcHPwh79PLiLL3
	 C7Kr+Ut86heYHWpdZY5X6RoQM0ru4pq5Hu6M+gg0GxEddi5qAk8GSmEjy7vSprJMkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oLjiM/83";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5291606A334;
	Tue, 20 Oct 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLjiM/83
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C551F000C4;
	Tue, 20 Oct 2026 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493537;
	bh=KeMzwCuL1HDw5ZoSQ8kH1JqNJ7FZsCuEkwC13MbO6B4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oLjiM/8378oQWHbeHHTvZqBrVku6NYdSv6ACiM0nkE95m9N7pdRzorVAF1nvrwpY/
	 cuzZvFVfJcWgFQEQi4ssFTeAGCNhkmBAUP28kaRV0MWrWzM/CyKbu+dVqqqSQe85QD
	 uWfOT0/Qm85g1vDwvsULBoy8uu2TUZx4AOboJ+QEJ1APMFNoPAbMEzRV1OGMiHTNjU
	 Ya0Z1OZv32beiesjuBXdZNXe3GNe2PUPoAAu5dLqylH4awPxJC7htt/e5m7mviex7h
	 Ov9YytY+CdrZ0mDC2c5J1U1QSYqxX7zyI7Wy5ebV0qQSOtoct6foZI1TkOCQ58WNcV
	 65FU7ZcLKo4Tg==
Content-Type: multipart/mixed; boundary="===============8834276171442868486=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0f730af064fbd00f1b18405237995d4e78b3672fb4ee14eeaa26784aad4b9228@mail.kernel.org>
In-Reply-To: <20261020102512.518479-8-mahe.tardy@gmail.com>
References: <20261020102512.518479-8-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,willemb@google.com,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,horms@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kuniyu@google.com,memxor@gmail.com,emil@etsalapatis.com,almagui@kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 10:52:16 +0000 (UTC)

--===============8834276171442868486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test forbidden bpf_ksock_sendto() LSM attach

TL;DR:
- Selftest calls bpf_ksock_sendto() without a prototype until a later patch,
  so the test may not build or run here (bisectability)
- Double blank line nit

> diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> --- a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> +++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
> @@ -33,7 +33,26 @@ int BPF_PROG(socket_sendmsg_ksock_send, struct socket *sock, struct msghdr *msg,
>  }
>
>  SEC("lsm.s/socket_sendmsg")
> -__description("bpf_ksock operations other than send are allowed from socket_sendmsg LSM hook")
> +__description("bpf_ksock_sendto is rejected from socket_sendmsg LSM hook")
> +__failure __msg("calling kernel function bpf_ksock_sendto is not allowed")
> +int BPF_PROG(socket_sendmsg_ksock_sendto, struct socket *sock,
> +	     struct msghdr *msg, int size, int ret)
> +{
> +	struct bpf_ksock *ks;
> +
> +	ks = ksock_ctx_get();
> +	if (!ks)
> +		return ret;
> +
> +	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);

Is there a BPF-side prototype for bpf_ksock_sendto() at this point in the
series?

ksock_common.h declares bpf_ksock_create(), bpf_ksock_connect(),
bpf_ksock_acquire(), bpf_ksock_release() and bpf_ksock_send() with __ksym,
and this patch only touches progs/ksock_lsm_verifier.c, so nothing declares
bpf_ksock_sendto().  vmlinux.h carries types only, not function prototypes.

With a recent clang this should be a call to an undeclared function, which
is an error.  With an older clang the call would be emitted as an undefined
external symbol without __ksym/BTF information, and libbpf would fail to
open or load the object.

Either way ksock_lsm_verifier.bpf.o, and therefore RUN_TESTS(ksock_lsm_verifier)
in prog_tests/ksock.c, would not build or run at this commit, which breaks
bisectability.

The declaration is only added by the later patch "selftests/bpf: Test ksock
sendto()" (65327a57ba55), which adds this to ksock_common.h:

  int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
                       const union bpf_ksock_addr *addr__nullable,
                       u32 addr__sz) __ksym;

Could that declaration move into this patch, or this patch be reordered after
that one?

> +	bpf_ksock_release(ks);
> +
> +	return ret;
> +}
> +
> +

This isn't a bug, but there are two consecutive blank lines here after
socket_sendmsg_ksock_sendto(), while the other programs in this file are
separated by a single blank line (checkpatch --strict reports "Please don't
use multiple blank lines").  Could one of them be dropped?

> +SEC("lsm.s/socket_sendmsg")
> +__description("bpf_ksock acquire and release are allowed from socket_sendmsg LSM hook")
>  __success
>  int BPF_PROG(socket_sendmsg_ksock_allowed, struct socket *sock,
>  	     struct msghdr *msg, int size, int ret)

[ ... ]

> @@ -103,6 +122,7 @@ int BPF_PROG(socket_connect_ksock_allowed, struct socket *sock,
>  		return ret;
>
>  	bpf_ksock_send(ks, send_data, sizeof(send_data));
> +	bpf_ksock_sendto(ks, send_data, sizeof(send_data), NULL, 0);

This call to bpf_ksock_sendto() has the same missing-prototype problem
described above.

>  	bpf_ksock_release(ks);
>
>  	return ret;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39408886865
--===============8834276171442868486==--
