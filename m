Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADE23E342
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073358; cv=none; b=dKAiWqukaiGveSPm6Gs1MOevpD6Noh7ud5IOsxtSwwjjJOY9zkyKpw08YI5VmKB9Iikg0i29c0qVtK88YnZD6he0IgP0hsyxKXmQyVlwdUwIGVBpZAZFlfZyOebjlOWDQP5tArqhc/mzYkmgRxipWi5ai/Uvw45bRyH4qgzg5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073358; c=relaxed/simple;
	bh=czV3QQNM9G3EUKx6030M3d1ab1SkNdlSTcYQ4lABBUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsOthox6Opjy6ZvBEcTZ4u9Qn5gh4UWM43GG1xcFkJ7fmypslQU224kKuXfRU2sPnpSZgryIyWiY/n0X9/deqa3TQP0LUEMNHN0RBYYvgknSE4U1YEqfsviWUTlLMTnKV7W3mDqkyGm+GnD1i5/Uvt3o8ohh0sbm1KQ5eU8kdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okkkGozY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okkkGozY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso62048575e9.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073356; x=1778678156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alKfWc0oKFzzNA9U/qXEFjRDoxsNVeARl1BB9iW+gKg=;
        b=okkkGozYmWhxpru83St8LOFej8nv/90nZRfNbANmXSgCbInH5wZQ84WQSu8Ms2JsF4
         flmJq92IuIHMeyBydxZUGuEd/cVpnRZj+JhZrqAS6Kg5HZMeeRe3+OIgC5SI7j5YuwDF
         umeIIWJxOQKkBOdeid1nQ/ve6urHIw1+H7OJEqe8wCW/ZZdpN37zdrr7FjIBldZn49Z8
         OQr9ul8awNyBD7xFeHdVgpP/A/7MjEvhnfi8DouP4DCOmenBzpCWSswNWzsiixAMyUZI
         9fl0eu2jtNwM2C633B3n0dvZa+9S8RAWrPZWu/muM3ez59L9YqYHZ1WDuBLmNi4hUKTr
         GK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073356; x=1778678156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alKfWc0oKFzzNA9U/qXEFjRDoxsNVeARl1BB9iW+gKg=;
        b=qkrnCpzk/MbRB8Av7Ez2jFmvQ9By9LBzwgwAUAkdhVnJgTeSh3A1JOW5q4axXVeSBd
         l5X62Zb7/7Cg5S+0S7V7taOQ8sqGbMzu6GglRt4edNtR8Ecrq3KR79NBQVh7AIDehVT9
         B6jUO8Zm9pFxGiCFZz842K2LWnqvNrrbD+K4tZJyXnu3c4CnEz4oV1AatbgHXbkegiRT
         HyzJjRv4QTpxLKBqesmfH204lUpMpDTK5uAtuvy4cuckAVBfh7yfOSq7CG7L6Xqj+Cf/
         hNWKakC9ge9I7XeY62JG90rkq+ZrVXv3MfnH7zX95AAv2yMXewoNvebgWgb77AuXbb2t
         UheA==
X-Forwarded-Encrypted: i=1; AFNElJ8D2mEaYDRsVUgkpS9SQ/wZ5sVI1u/o+bdRFmjEML0945844ky15Cvyp5g4LR5WFdx31+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGA2BIXS4zfDBSP2gCRDRmn5dhI2Wdfntn08tzASLMnDWaEu3
	L1s4GDvquGj/jOEg/zqZ+wA5zXtR93iPmv2c0wZEBu4Kuc/EeX7DH/cM
X-Gm-Gg: AeBDievlsX+jh4swDk+6UCBSiqBN8QkezIsk9oyDtWYWSdAbV/cxn7WZlUZRD3rmbSf
	DJXeeyL9f1WCHEfxKLiHpJSdjpo7Ulf+42W0viPrVR0OTkZv8EE0Cw8JEAimSV4lIK8R1CtthRM
	KB2tODMbdW9l3XN4y/BvTyNW+JEFNrLXX3NvjbDm4Lv6upQiPDeABXbTzxpeofZVbeWtAsIY82E
	zqrzr3Ss4BLZMYf/3iwxEcZpfotg7ha11u/gnERhOgRDzUOdYmQemh2sChABR/rDyVd1BdSITjn
	krHuctWZlE6rhnhZ63e5vAOeR+IaDy5XcR/uBHaHGNJqMXtoZTBiymHMPkfn98P758t6A4dIgIc
	O2KsnDioSI2YSpvOTPkqAKv1AHPGwJuEWEpkGCrhoeV7U5XJaLto+dcJehXH9p+fKDBLTheSHlk
	uHmsJlVL4Luo5ZR46/u1Jj+M484sP9+IcOWE92UmX1h0IfNj7R2dKiHLD4qR5Gqr7z2ilCrrOTO
	qhVAv7as3U/tl5CkOUaGe4Hx3N+f7igBqmQQ0pJb8ccnlBRgXaVVmnLEGKgXa5J2n5hwAtx3/E9
	A2hxAE7K+iUORmB8exoXR6MmSw/BweiK0z0dpm9vmqhuHskZeeYvoQ==
X-Received: by 2002:a05:600c:8485:b0:48d:364:e236 with SMTP id 5b1f17b1804b1-48e51f30493mr63601525e9.18.1778073355264;
        Wed, 06 May 2026 06:15:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b5a044c6307a465e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b5a0:44c6:307a:465e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b2039sm18333115e9.5.2026.05.06.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:15:54 -0700 (PDT)
Date: Wed, 6 May 2026 15:15:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>
Cc: paul.houssel@orange.com, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: add tests to verify the enforcement
 of CONFIG_CGROUP_LSM_NUM
Message-ID: <afs_CIQUer2tfh_3@mail.gmail.com>
References: <20260506065048.592474-1-paulhoussel2@gmail.com>
 <20260506065048.592474-3-paulhoussel2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506065048.592474-3-paulhoussel2@gmail.com>

On Wed, May 06, 2026 at 08:50:48AM +0200, Paul Houssel wrote:
> Add a selftest that verifies the kernel correctly enforces
> CONFIG_CGROUP_LSM_NUM as the maximum number of concurrently attachable
> per-cgroup LSM hook slots.
> 
> The BPF program side (progs/cgroup_lsm_num.c) defines 12 lsm_cgroup
> programs, each attached to a distinct LSM hook. The test side
> (prog_tests/cgroup_lsm_num.c) attempts to attach all 12 programs one by
> one to a cgroup, and verifies that exactly 10 succeed and 2 are rejected,
> matching the value of CONFIG_CGROUP_LSM_NUM set to 10 in the selftest
> Kconfig fragment.
> 
> Signed-off-by: Paul Houssel <paulhoussel2@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |  1 +
>  .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 ++++++++++++
>  .../selftests/bpf/progs/cgroup_lsm_num.c      | 92 +++++++++++++++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c

[...]

> diff --git a/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> new file mode 100644
> index 000000000000..0cce61cd7b26
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Orange */
> +
> +/*
> + * 12 LSM programs with lsm_cgroup attachment type, each on a distinct LSM
> + * hook. Used by prog_tests/cgroup_lsm_num.c to verify that the kernel
> + * enforces the CONFIG_CGROUP_LSM_NUM limit on unique per-cgroup LSM hook
> + * slots. With CONFIG_CGROUP_LSM_NUM set to 10, 10 shall be attached and 2
> + * rejected.
> + */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("lsm_cgroup/socket_create")
> +int BPF_PROG(hook0, int family, int type, int protocol, int kern)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_post_create")
> +int BPF_PROG(hook1, struct socket *sock, int family, int type,
> +	     int protocol, int kern)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_socketpair")
> +int BPF_PROG(hook2, struct socket *socka, struct socket *sockb)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_bind")
> +int BPF_PROG(hook3, struct socket *sock, struct sockaddr *address,
> +	     int addrlen)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_connect")
> +int BPF_PROG(hook4, struct socket *sock, struct sockaddr *address,
> +	     int addrlen)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_listen")
> +int BPF_PROG(hook5, struct socket *sock, int backlog)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_accept")
> +int BPF_PROG(hook6, struct socket *sock, struct socket *newsock)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_sendmsg")
> +int BPF_PROG(hook7, struct socket *sock, struct msghdr *msg, int size)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_recvmsg")
> +int BPF_PROG(hook8, struct socket *sock, struct msghdr *msg, int size,
> +	     int flags)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_getsockname")
> +int BPF_PROG(hook9, struct socket *sock)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_getpeername")
> +int BPF_PROG(hook10, struct socket *sock)
> +{
> +	return 1;
> +}
> +
> +SEC("lsm_cgroup/socket_shutdown")
> +int BPF_PROG(hook11, struct socket *sock, int how)
> +{
> +	return 1;
> +}

This should probably use a macro to avoid being so verbose. AFAICT, only
the attach point needs to change between program declarations.
