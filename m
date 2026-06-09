Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E240F8DD;
	Tue,  9 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012558; cv=none; b=IdSUGUgmb+Zn+O7kXhqDOoyasMNavmx4chvmMITD6HDE4BH1j2LKkBxYBS5QkGqPtlNqxX0E9yv+u9AjbUudK7y2dY2xsrqfbg0wjOyPYEQ7MmhKJkVCIH9dRZXCbFg9qznKoDYNjxCXlTh/oDoWkQ1Fpp8SZNtuwAeWkPcXqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012558; c=relaxed/simple;
	bh=Y1wUWHBKm3/Zs/CE7pVm2ZqFO23AzDHIRLAyKzRX6lM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sl0CmGpy+U/cXYHETQUqejZj27jN+DMSDcRs0wEMqNrxRu2ZXqNe7dQv0nsOx13j3TgOQbvLgeoFvajs9i2kwlc7gt6Pgo2a/LPGjPzAgGw3Cxz39iXGQxiGodNgu8Ygpps+cSmLXasE1b3O/sb/o4It8MCy76lLWc7UsqDTFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKqQE5Wg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKqQE5Wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A37E1F00893;
	Tue,  9 Jun 2026 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781012557;
	bh=NquCjEZvusEGIuHGHHSR69tFVmrlWzkYk7LEGsWixW4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mKqQE5WgOFpvZ44wPQowGLeJ/srCSqIn4C48bIkEDGSPG9RfGJAATFl4ck0aUtglK
	 Q/SEIzSzlE04Z6D2GXPfkrQVIzd54Cx91ETFYAQoj8QYHl5RhjO2HvEAns9S777ZKn
	 TYbJuuXVZs2p1Lw4vmkxmaHfAzugUt6sJpWgrfMJaYffBK4EtuvBqT+lv9c4q9cTYM
	 I+X9z0LAN9Q1xAcUzNQmXbX3kC5FAGfd7QCswrFECTz5znLWw0TFPrqyFRWhf+j0ZE
	 vAlT3XqRw9hqXFV7qq6I92Sqi01ma2iWP860uEUm0oa7oOAUB5wCV3AAtcYrhbU07I
	 XuaiCKIYLNcbA==
Content-Type: multipart/mixed; boundary="===============7615833700415675074=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30794e5dc88b1aabb86bd03cccd8e29d3c7f3fd9d98f88f2a7656b9a481d23b5@mail.kernel.org>
In-Reply-To: <20260609131100.3097225-1-chenyuan_fl@163.com>
References: <20260609131100.3097225-1-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf] libbpf: Skip bpf_object__probe_loading() when BPF token is in use
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,chenyuan_fl@163.com,daniel@iogearbox.net,eddyz87@gmail.com,linux-kselftest@vger.kernel.org,mykyta.yatsenko5@gmail.com,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 13:42:36 +0000 (UTC)

--===============7615833700415675074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 234ebb868e2e11460c8be69f6726ec05ff912183
> Author: Yuan Chen <chenyuan@kylinos.cn>
> Date:   Tue Jun 9 21:11:00 2026 +0800
>
>     libbpf: Skip bpf_object__probe_loading() when BPF token is in use
>
>     bpf_object__probe_loading() tries to load trivial SOCKET_FILTER and
>     TRACEPOINT programs to verify the BPF environment works.  When a
>     BPF token is in use with restricted program type permissions, these
>     probe loads may fail because the token does not allow the specific
>     program types, even though BPF loading is perfectly functional.
>
>     Fix by skipping the probe when a token FD is present: BPF token
>     creation itself proves the kernel has a working BPF subsystem.
>     Real BPF issues will be caught during actual program and map loading.
>
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

This looks like a fix for a regression introduced when token_fd was wired
into feature probing logic. The CI bot suggested in the v2 review that this
should include:

  Fixes: f3dcee938f48 ("libbpf: Wire up token_fd into feature probing logic")

The commit f3dcee938f48 added token_fd support to bpf_object__probe_loading(),
which made the trivial SOCKET_FILTER and TRACEPOINT probe loads subject to the
token's restricted program-type permissions. This can cause the probes to fail
even when BPF loading is perfectly functional.

Should this patch include the Fixes tag to help backporting and tracking the
regression it addresses?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d..a3ce25928120 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5167,12 +5167,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
>  		BPF_EXIT_INSN(),
>  	};
>  	int ret, insn_cnt = ARRAY_SIZE(insns);
> -	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> -		.token_fd = obj->token_fd,
> -		.prog_flags = obj->token_fd ? BPF_F_TOKEN_FD : 0,
> -	);
>
> -	if (obj->gen_loader)
> +	if (obj->gen_loader || obj->token_fd)
>  		return 0;
>
>  	ret = bump_rlimit_memlock();
> @@ -5181,9 +5177,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
>  			errstr(ret));
>
>  	/* make sure basic loading works */
> -	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
> +	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
>  	if (ret < 0)
> -		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
> +		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
>  	if (ret < 0) {
>  		ret = errno;
>  		pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27208871676
--===============7615833700415675074==--
