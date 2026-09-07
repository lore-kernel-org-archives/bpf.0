Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958473C585B
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823401; cv=pass; b=ay9D+TNvq0mgMP7bQPALlVrbr0XR0FruI5eycZ4nxNkuHobfzlEor0CtSvYJ/mh+B7NEQkzPu4O1e7RcDWc7ncs1grBjBH4EpPBfT9YalIMFBxnk07wnpBrxEqg5mAGCegIaHMf4buRJmcNBYmmCm7xyQDdmjP7dvddbca6TAPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823401; c=relaxed/simple;
	bh=jfAp60OBp4doOiN+x+Yf0On7RHIw5hZfHkDWrPwTz6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9EHj2ltCwKxx4J3wN/PaG69sQxO7aRTJXhSu4E7XlUw2bHwPmCUxxFn2QRHmz5uXUaBCpvOAuVRWlpaPufVnZsfJPYHuLrXKsQNufwDYrlMaABD5AI3fj0a2Myiaf7LBsCGtEERz8Fh/+PJt7UmY+oYRS4ScO4rCwrxmgdRa10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HpzOhlsq; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpzOhlsq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso33472945ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 16:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788823400; cv=none;
        d=google.com; s=arc-20260327;
        b=fjQ/g6al5htTU1K7QhBglKj92fG9esvI9c+WzPWPdZle5CguvCYcUruB5PiymjdGnl
         x8ly579GwdDazK+RbVKT61sWNFtoPoYQKsOY6Nr8Q7kQgcL1/40O6FfZ1Ke5aY0aJf6q
         CMe7ksNLNDNmjWAsX0xkmAYq9Du5vRmg9Jh2Kh/gNttzHpnnZdoTlWwUGGqrZBrj8bcS
         tUJJw7FgcpHzFt+LWhlzPRXdrYMp0RK4b14ScTPmHi5TtG8FgS+zPuDw17uHN1u4wh/E
         oFS9UnPZnsrFcI56zmm3+gVMRlfG6n/Y62zNh+Ph7iQrD5eUW0f4iNQ8jrCc+XWKxZG2
         Lvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0IgSRwxcuB6vnZUxcMMegnldun7vRf9Aq4Po2V8pKwA=;
        fh=Hqe44f71BYbynX6zBP8isOWZTZWN+So9KVb4FTHvTo0=;
        b=VzwTrprgGAZSh77+ZFqSo7RNPqCloDSyvvhQUZtlYOuXwgkRiAMs/yyoLwq7y8kzvB
         Ahre3RQeLWBN8kbUdkt82Uhz3i4r8obyBVqj8p/0n/lTnUsjdCm/1/EjOfGTcidnMzAT
         ITQhj5h6nYq4gF8bz1QWfPeqHBhYVVfsNwwSK3uWx5CzKV5Q4YN3daeny97VwZNN/JuE
         7zF/sY71bOn9yELqrgtMcDaTzkLb1u89vVCVqfxY5LKRG56PzdrO1UdJZES3wACAOQEO
         pEasn2t+1h1ZoNFrcSZfwo1B36diUxsPQISQDkqD2PRNvsMVDH6Mwu9JBOzjvEz+viV9
         zhDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788823400; x=1789428200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IgSRwxcuB6vnZUxcMMegnldun7vRf9Aq4Po2V8pKwA=;
        b=HpzOhlsqs1wTA1S2qEtpNxFT1eY274fqC9BMPpUDx7bLrVEmt9ohAcHvk8GzPshCwF
         0FZ4a2Fu5wZ9jdxdoX6XCAMO/ZGDKwHAWmd9hQCF6knaaR5gPMgHzZzD5jeMFGWHsDeZ
         wxZo1TolvpdeZZXz+SSaHfWdqhzrXkW8JxDgeF6oy45jtfELHkLKYenRq46VlNd5sw4l
         Tk7P9wFAQYfexwEhMQXAhFSAuWpMDlrcEid9kRzOkYHbD5ALyZj0d6ICGSHLXdM401qL
         /i9diuZHsYJu8lnsAbDbDgcA3xUc4k6Vxv5o90HrsCwQlBhQ0761KsOO+fYpPPUuAJnd
         GS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788823400; x=1789428200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IgSRwxcuB6vnZUxcMMegnldun7vRf9Aq4Po2V8pKwA=;
        b=fwJIvxxTi6d0Ns/4eZIIt3eho5ns3S0AUxefttvugmiDl/+OjcQcbyK09ayiatRx7f
         ASKDTtTqYmhJMUs7qVEhBzQFJfTegF6Qt6Hg81bYj56OxM7DpLVBzNyhoTg5ZtRVVKbf
         xg1lI9Ex9ohuVyxn/wKTDfquBusTNbNWUovVEYxiaAgmqXYRAF0TuwApMBcMd0q4Kn5L
         SMss+AsfCTP+FOEPSknaOfcgfJYmXMVyPyd401q9Q0AVdDBy4DMRuYD+CZEQmXyoShRN
         L1LqEJ17B7RWkEBm+kgVmkmoTJocM3jYp8/sEWGZxJ539whTkx5djcZMmlIZr5xBNJq4
         nJag==
X-Gm-Message-State: AFuF++kEO21JLnZOw9NLFJ4pa9LCBSsGn5zfIsMAhnb0VQxy8sRDQBLW
	xBPyuegAEdKM9YHDBX/xlWeYCBzCLT9ckiUsP2+t4Ad8xiEo9xVyU5RdtF9c6N/dLFPF0Zrt5kW
	8aTCN4tX6L24vioy+NAFvf1VufcOxF5MP2xrLPNRh
X-Gm-Gg: AYBFou22GO9R79PkoCxc0/2gZQBO4BQzIjAaoEKrMfXs5pNK7MPTcl0ICM07o09VHng
	pS3EfgVwOu1K4nBBEFQDGNlApfiypwahP9vrk/i5FfJs5rmYQVYUQZH04VpGuw1dohg7BeaIltH
	G7joD/39Bma2QXDzYOpsXa9xlaHcw8S6ZtpT7n3u/orWuH1eummAVt/QpZfak/kYMWadQ711yqB
	cCq1f9oL3F54bSAGhEMrRM1377FnLrum3dVjKeSBaHdUSM80ZrOeW2xbY3erS7W3rzYzbosNeZH
	G2gQxW3lRcLrO4BTEbRyC2jc2G5wDb1yP050JU8bUSKt7K8+Y0iZVLsVhnwRJMNSxi2nU/lJU1x
	vwKHVFVaTtdGF7G9UyV03aKdNFB1OX1uzHlbhBMRI1yol0gJrWEGJoD/o
X-Received: by 2002:a17:90a:d2c7:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39b262e4e02mr36924728a91.23.1788823399150; Mon, 07 Sep 2026
 16:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906074135.185212-1-jiayuan.chen@linux.dev> <20260906074135.185212-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260906074135.185212-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 7 Sep 2026 16:23:06 -0700
X-Gm-Features: AcwNN1Xz9UhdXiFIx-Dg3fA6cQJzjy8WgHXHsftsUBO_tigszkI2pXJJ9JByUSk
Message-ID: <CAAVpQUCzacvL7n0DejvtYQB2ZnHiUM_sg4-d==iviyvVKv=_xg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Fix out-of-bounds read of sk_protocol in bpf_sock_destroy()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Shuah Khan <shuah@kernel.org>, 
	Aditi Ghag <aditi.ghag@isovalent.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:42=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> sk_protocol lives in struct sock, not in struct sock_common. A timewait
> or request sock handed to bpf_sock_destroy() by the tcp iterator is
> neither, so reading sk->sk_protocol runs past the object:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in bpf_sock_destroy+0xc7/0xe0
> Read of size 2 at addr ffff8881047d11b4 by task test_progs/428
>
> Tainted: [W]=3DWARN
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x91/0xf0
>  print_report+0xd1/0x630
>  kasan_report+0xf3/0x130
>  __asan_report_load2_noabort+0x14/0x30
>  bpf_sock_destroy+0xc7/0xe0
>  bpf_prog_c3dd61f9d9cd9f37_iter_tcp6_timewait+0x9f/0xb7
>  bpf_iter_run_prog+0x538/0xde0
>  bpf_iter_tcp_seq_show+0x26b/0x4b0
>  bpf_seq_read+0x424/0x1210
>  vfs_read+0x197/0xe40
>  ksys_read+0x119/0x240
>  __x64_sys_read+0x72/0xc0
>  x64_sys_call+0x647/0x27e0
>  do_syscall_64+0xe5/0x610
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Only check sk_protocol on full socks. tcp_abort() already knows how to
> deal with TIME_WAIT and NEW_SYN_RECV socks. Also fix the comment, it
> never matched the code.
>
> Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Closes: https://lore.kernel.org/bpf/20260702224519.800135-1-xmei5@asu.edu=
/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
