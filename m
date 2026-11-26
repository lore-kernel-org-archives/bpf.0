Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703256;
	b=uBEZTyT0yBo4qmnLC0kK8eZZcFh/85sNFgbqEnVsHnJJUHCuEdwrwYsKstlkxWq1N/p3
	 iojuCLDs7WhxNsmU8ZuY/COE2FwkCwfO4t49BlsB/QrRY0GtN6I6S2wDg1tVlGt5Q2iBJ
	 HAzM01M0nqe6wyVuQYSW2r5EzKV+2A3k8fsRku8pkL/+wqFmuPitG3MhcrWnW+XP81MME
	 lvswzBF4f1AJb9G9mNe6fxFHSJ7nWmDSrkiWlV6QWrajDBsvon73Nv7S4VkW3WKwgELfr
	 LDpimBqvSLSw9+i4/BaySw2cO0tdrW1LVXqNk/tptLXAs67eHtr8pWwFJb6PrdMBh5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703256;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s/UB48bTQ9wKBvZS6OaHhTA0Ln+kkVY6fbGQj24jh14=;
	b=VeoSRMwTFtBa2IHuUr2nLW6BEcwJ0po/1qws/KFIb/LkygduKQhmOTv7nRdnqmV5t9sD
	 YyEgPAiocUTfgn3y9OFfJWOfq4ZE/ucgxNrrHOVOKjd2Sf6fdxqkEVjlGDRWpQEK8evOz
	 RNEBpKS3Tp2p559q3ia9Cz59PBOEqCcSUcV2v3oYXS0I/YAvedXTLya6VO6ufxHQJwSWM
	 M8yiTHjKOc4kR7ZzfvCUjYeJmpW7yogYVqW+5W6SqyzeJWm+DcPYLJdf3rkntgq3dKHOT
	 kouzaEOXUbKkrfyVpTP4UYUahPdgCXYV8U5KjgWAiZT0DwT2Hv6RJIgsQRxwJrKl+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTODQqUM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F7606A32D
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hTODQqUM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F4B1F000C0;
	Thu, 26 Nov 2026 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703256;
	bh=s/UB48bTQ9wKBvZS6OaHhTA0Ln+kkVY6fbGQj24jh14=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hTODQqUMNeztUg7DJ7eTXnXtlTh4A73LCXiaoajyMeqWAEip1+miUd1vU6+oZEekH
	 NVykjMaugkHNcu0yq9RquSSLYg3JYjchNnF54tJKgPTJpUZ1lna369Z3vdfeq+lQiU
	 /Py1oI//tGt4KM5i0pe9dAwV73zLkJoWw6eADvVN8z5RCETG45Hrb26PdMHmgO0EA0
	 GWJmoifNrATZAwLr/s6fAOt2BHeJw+HRTD8RcspYli+xjrn1SdSGN+AQA4yJAI55fZ
	 40mIccy8JX0qb4w9d+y+axy5iHizQmxsZvsQP8pJgacqeTyzQE/qmWuApNvlMa0b1T
	 JyhPGQJ/dMdeg==
Message-ID: <sashiko-outbox-235703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 2/7] resolve_btfids: Do not tag functions
 which work on BPF objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261126142915.1106330-3-a.s.protopopov@gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
 <20261126142915.1106330-3-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:27:35 +0000
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

commit 22ec6a5284d69e95482c5c70ca4fae778848a0da
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
This fixes the tagging of internal BPF functions in fmodret_tag().  Should
the commit message include a Fixes tag:

  Fixes: 4dd950adacad ("resolve_btfids: Tag the functions that return error=
s")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126142915.1106=
330-1-a.s.protopopov@gmail.com?part=3D2
