Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641927;
	b=LW6rJRKTDzArH7MYoGTvYlgx/NpqJmPR28pEIPhKtyzvbf5X1H65JLVLYVXAlIZ8US8N
	 XeWxTIWU3vr2UBD+YZEzbbTUN+kUE6ewHB8QI2ykCBlt/X34na2QOBXdChM8Ep0CPHTty
	 RsR/rjdb4hvj4nGbc/laRnKELirGcKM+IrnISO8cCkOh71ZQl+vteuxlZ3+L9s3H6xOo2
	 U4CCgQDXjPXUcoss4QFNiYd2GQZBNW4RdmpRiirhAVQ9etig2dJCsPfpNY9BrvTPtlQzG
	 nGW0DTL1HZZm2FFHCxXus5oPMiy/EsVsDwJm+VR3nLctZKIH3LbEaU8aGrl8Fw1Secg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641927;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YLH2UR3otvJh0rkfBU8t6Z7bUYP8/MPDxxyi23K0SsI=;
	b=0JTeXlxV1E3CoIwfzleCkowwoIedzOsMV1pL2f3PQZxgfoj2kSn3Hc6Iht09KXg9f5Zi
	 lPvz/aY7F36TxnV4CQ0MoDLUDwTa5HwjXGzBicv24EZpNYlVP0smJvhHLJ+S+rm8O9WFQ
	 ff/Qq44QwTqjs4TY4g0UNTWJoHjCJ1BS0WgDhwKV7hkrnCZ4lao03u4WfA08KMtcdOgil
	 pQXeU4TVPCGRFQCcxzjRSLAlFwW1bTaHxop0AsYNw5zhBXApMFWYeaRaFNP2OZiAdI/u6
	 Z+ggl4nNoFb9p1eH/nKtzn5CN9/Sffl5XmtuFIPJBIjq49+U3EEvXOWsL0thh/Ewesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xg44/L05";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33638606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xg44/L05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF311F000C0;
	Wed, 25 Nov 2026 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795641926;
	bh=YLH2UR3otvJh0rkfBU8t6Z7bUYP8/MPDxxyi23K0SsI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Xg44/L05mKvucZtPTedEOlSDqNGoWwTX85qHlLgN7sX2jhn2verY2JsNeLV0qAumd
	 wvMHKD978axNHWTVK4Lut/3rGkM6H7NKa2rWlh0dfNqHQx12UKzwHlt2aEiEGIDMRm
	 DNVxxYXqICO8CxM29Z78nZx9/X965hxiteEaXKBJ4FBAvebiOXdhn8eWFZH2jlEZjs
	 hunmAi6G7UgyrHNUerWYKt2u34hUFF+Ff+OGYVdf+MQwmvsjsE4dLDFwoqyIteEBXY
	 bz9CRB7ZupaOP4OUVbeTa77BVlecX+kDkKz+Kd60R6xmwvIl+YyQdZyclHCmEMSuBt
	 gdu6V7wbCDgMw==
Message-ID: <sashiko-outbox-234173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 1/5] resolve_btfids: Do not tag functions
 which work on BPF objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125212849.868523-2-a.s.protopopov@gmail.com>
References: <20261125212849.868523-1-a.s.protopopov@gmail.com>
 <20261125212849.868523-2-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 21:25:26 +0000
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
- [Low] resolve_btfids: missing Fixes trailer for fmodret_tag() BPF type
  exclusion
--

commit 36940d1b337a769c63009cfc2b22cfd69fcc61f9
Author: Anton Protopopov <a.s.protopopov@gmail.com>

> resolve_btfids: Do not tag functions which work on BPF objects
>
> A program on tracing_iter_filter() which returns -EACCES makes the
> verifier miss that a global subprog throws. A function which takes or
> returns a bpf_* or btf_* type, or struct btf, works for BPF itself:
> for the verifier, a link or a map. Do not tag it.
>
> __sys_bpf() loses its tag. A program can still deny a bpf command on
> the syscall, which is on the error injection list, or on a
> security_bpf*() hook.
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

[Severity: Low]
This fixes a bug in the automatic fmod_ret tagging where internal BPF
functions were left modifiable.  Should this include:

  Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return error=
s")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125212849.8685=
23-1-a.s.protopopov@gmail.com?part=3D1
