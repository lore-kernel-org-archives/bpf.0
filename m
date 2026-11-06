Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965357;
	b=ztc0srTfrAH7WVosBYFsqpyFClL8ccvtVAjpTKFgoyz0Y15JoG8YhtyzsHZw+L93BvuU
	 1ZXCGAotoJ9VfOrtjsb8oAIFor8SpH7yoaBXP1LZB91D44jVNFRjDMbP1TGoFSqoa8iyb
	 vGEWF3kyMCMKEhls2dTqs0V5X/yMFOeun3izNRWlLsoBbrZ7sbqRuyUqmzCmAUeEenTID
	 +yARfdehUaT+eIHSQq669h3z5NXzYMuJv5O+qf3YzzupM7YGp2YwUzmxo3J1Zo0WIwpx5
	 KRC8uoDI44lH/mmRwzmRjPFdxGQjfQWicjB6pl7GDVEtPRJjM3qIuHrr2Lyo671tdfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965357;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YYsPTynzBX9gV8dhcoFx3zLMDBKxqQjqKcXI5wTXHVc=;
	b=Cfl3TyUsbWtR7oPEo/mxn0YLhbiUr2swy3vUeVSPkdGzxYFY/h4HSV9c4B5Nb6usqGHL
	 EWUS7fPPhOxKiiWraZoUuAF+surda3Q0vVHjZJJdA4giziMxWv9L6FiTJ1WfUB9wsUp3n
	 tgnFqG164gD92GvOuE3DrfhAqETbLR12qNd+4wLTEH2r23s2DB3wgCCJd28UKaze12CKM
	 1YSikrYJCU0zpxPANQNugeRZGMhUuHR6fAVHPwCQccF5lvqYMqiDVOaDlgH6TFTXfIWpK
	 K0+PHmCRe3SxLdE2bOaQG8bouOjDTvEKS8e01iT+cj739DHt4vj8XBSRflMIX87TFxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvqMl0ac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25482606C7CA
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvqMl0ac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830541F0089F;
	Fri,  6 Nov 2026 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965356;
	bh=YYsPTynzBX9gV8dhcoFx3zLMDBKxqQjqKcXI5wTXHVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvqMl0acNVIyd5SFTgLoQUSDUE5wkihlwc+ts7glsGb7BJQ5AxTGjoOHJK4jDhRwB
	 noeKycKD4GsP6qIZPBuRWJEc3nn+qZTMwfVsDk1sP08tkdpMFs24q60/EjkYjPfqXq
	 6OfCb8bbfWYfxmkLGCqh0hxw8lNva+4YHea90DCQhndl0jcNfukgXDdV+V/LKZuSUw
	 inLq0QPEjA+ggTxC5vSAUmaL53BC5mP5u6SvB6d0dsCxEUHMhFRZRSFv7B/8P5gn2J
	 LDwgh4L/uFZGwCdBJYxubi+RQKuFz1GOT06thUdS5WhUunlmIGro4BeiM9MHux/YFe
	 w/GIqF4k/3ULw==
Message-ID: <sashiko-outbox-201331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF
 with clang KCSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <au27Y9m78_3EH2v1@gmail.com>
References: <au27Y9m78_3EH2v1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:42:36 +0000
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
- [Low] bpf: tcp: missing Fixes trailer and truncated commit log
--

commit f5456603019de81f20f04a8d77446db12563aeac
Author: Breno Leitao <leitao@debian.org>

> bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with clang KCSAN
>
> My arm64 KCSAN builds of linux-next fail since next-20261015, because
> bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
>
>   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in=
 bpf_tcp_ops_set_rcvlowat_kfunc_set
>   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
>   Failed to generate BTF for vmlinux
>   Try to disable CONFIG_DEBUG_INFO_BTF
>   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>
> This is clang 22.1.3 and pahole 1.31 (current pahole master behaves the
> same), with CONFIG_KCSAN=3Dy, CONFIG_DEBUG_INFO_BTF=3Dy and CONFIG_WERROR=
=3Dy.
> v7.4-rc1 is affected as well. With pahole 1.31, the same config without
> KCSAN builds fine.
>
> The kfunc came with 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust
> sk->sk_rcvlowat."), and 201a454df948 ("resolve_btfids: Fix the
> --fatal_warnings exit status") made the missing BTF fatal with
> CONFIG_WERROR. Without CONFIG_WERROR the kernel builds, but bpf_tcp_ops
> is never registered:
>
>   initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs
>
> This seems similar to pahole behaviour sched_ext hit with a bool
> argument, discussed in [2] and worked around in f2f095c87603
> ("sched_ext: Work around pahole 1.32 dropping
> scx_bpf_task_set_lazy_resched() from BTF").
>
> Here the argument is an int that clang reassigns, its location list has
> no DW_OP_entry_value, and pahole 1.31 drops it as well, so staying on
> pahole 1.31 does not help.
>
> Not reassigning the parameter is a workaround for me, with any pahole: cl=
ang
> then describes @rcvlowat in w1 from the entry, the kfunc is back in BTF,
> and __bpf_tcp_ops_init() returns 0 (tested in virtme):

[Severity: Low]
This fixes a build and kfunc registration failure in
bpf_tcp_ops_set_rcvlowat().  Should this include a Fixes tag?

  Fixes: 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.")

Also, the commit message ends with a trailing colon and references [2]
without a corresponding link, as if the trailers were truncated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/au27Y9m78_3EH2v1@gm=
ail.com?part=3D1
