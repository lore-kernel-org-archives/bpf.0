Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159483;
	b=mQW+7GooWVQpJed4mrlsNygIQqifFzhbMJp8iFqWsksyl3zcfdCD16sPFitHgKr5H1kH
	 GaCcJT7j2X2BlRQXTKVShd/ngQBcsInFKX0PRyC/VYDHF9HmDjApaBfOUTbX/L9JtI9nu
	 1JZqH01pnfr35QUK/xnAKODC1hsrlP2MoIzB2KKdwxhxTLpW0ddJ4cR7qrFByy6C1ekeO
	 ZX7Xvz5LCPfJJ3PdNnM7Gsm6J6Sfi5+rSPXM74GOwwlOYaCp3LzK4mkIvO+2MTFk+nG8b
	 +EVfPoxX0d4yOLki88wiYDbeCJZRJvMkf+eU3i7CcBkRuQWGiPQaQWF7EFmCqAuKwyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bdb0XTS4ra5ikY8lPMLNviGFcKW6pLN3XsTnTCmqSX4=;
	b=CPqOdOS6KlsR8R5vp/hvUwF5b/KippYx/z6LCVE3Yz0dTFte8I7U3F4UtufsdbBkaG+D
	 dR66mATFIOnXY2PZ90MZsdMHcPutx0hR+B0CW+uY8DMVs+0HjgLiYgNt/lRLYp2N1OjDk
	 lg6iJNQOJf3yXYG3d+f28TqkgioxMnyCRfZGAbADGQTFD5VsZhuJFY32rJ65OlYJZBy7P
	 O1G3fIya1qBhv9CffsBTKmfjg6frhdvMJByrZ554TRjz9XWTh3bQE2Ft1yLQc1Q3Oue5O
	 k/GORmwUC6qa3eZfhA61msye4lPnKmPthjXvIHC6bxUz3/H79mNehwAyXxcelsn406w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Dz0U/3bH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616BA606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dz0U/3bH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE161F000D0;
	Fri, 20 Nov 2026 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795159482;
	bh=bdb0XTS4ra5ikY8lPMLNviGFcKW6pLN3XsTnTCmqSX4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Dz0U/3bHN2fC5Zf1cMDKfYgKFhJYzZ8dhtRgnoZLHjMHeUNs3SsP2LDamDzv8Eqbh
	 DekeQ4SCYUIrznxlad9SMo9LGE7vpLv7Z6EMatgbNl1DKdv0mOOQIqhMdpumzk/qlC
	 hgK6bdm2vg5u9JO/Qk4LorWUianXNofm6tLTSR1HqGivF+vkEoqkTCn9vu3WO9lnR7
	 wLO3zjBglvpRN0/CIYqyGYy6ivrtSTtS4J9Eu0MxhEUSDf1OdfqXF6Jk29DiHtW5Mh
	 taZzwKvscz6xmB4Jhvc7i45CHG4G/p8aaK2g1vRo64LQrDjp85I6+jr5S6JsR1QSZh
	 aBjWezmHtMODg==
Message-ID: <sashiko-outbox-224622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] selftests/bpf: Add benchmark for seccomp filter
 install
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, bpf@vger.kernel.org
In-Reply-To: <23962b56d36f05c2176053d772cc9739e2e48ba5.1795139109.git.xukuohai@huaweicloud.com>
References: <cover.1795139109.git.xukuohai@huaweicloud.com>
 <23962b56d36f05c2176053d772cc9739e2e48ba5.1795139109.git.xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:24:42 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests/bpf: seccomp insn budget undercount and overflow in
  setup()
- [Low] selftests/bpf: barrier hang on malloc() failure in producer()
--

commit e23b8e529406f7cf306411e18be355c8be76105c
Author: Xu Kuohai <xukuohai@huawei.com>

selftests/bpf: Add benchmark for seccomp filter install

This commit adds a benchmark to measure the throughput of installing
seccomp filters in batches from worker threads.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_seccomp_install.c b=
/tools/testing/selftests/bpf/benchs/bench_seccomp_install.c
> new file mode 100644
> index 0000000000000..5044d786bdf4b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_seccomp_install.c
> @@ -0,0 +1,249 @@

[ ... ]

> +static void *producer(void *input)
> +{
> +	struct sock_filter *insns;
> +	pthread_t thread;
> +	void *ret;
> +
> +	insns =3D malloc(ctx.filter_len * sizeof(*insns));
> +	if (!insns) {
> +		atomic_inc(&ctx.drops.value);
> +		return NULL;
> +	}

[Severity: Low]
Can a malloc() failure in one producer thread hang the remaining workers
on ctx.barrier?

When ctx.sync is enabled, setup() initializes ctx.barrier with
env.producer_cnt threads.  If malloc() fails here, this producer exits
without spawning worker threads, so the workers created by the remaining
producers block in install_batch() at pthread_barrier_wait(&ctx.barrier)
for the rest of the benchmark run.

[ ... ]

> +static void setup(void)
> +{
> +	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> +		fprintf(stderr, "PR_SET_NO_NEW_PRIVS failed: %d\n", -errno);
> +		exit(1);
> +	}
> +
> +	if ((args.filter_len + 4) * args.batch > SECCOMP_MAX_INSNS_PER_PATH) {
> +		fprintf(stderr, "the batch exceeds the seccomp insns budget of one tas=
k\n");
> +		exit(1);
> +	}

[Severity: Low]
Does this budget check undercount the kernel's per-task seccomp
instruction calculation and risk 32-bit overflow?

bpf_convert_filter() expands the cBPF filter built by fill_filter() from
args.filter_len to args.filter_len + 4 eBPF instructions (3-insn prologue
and 2 insns for BPF_RET | BPF_K).  seccomp_attach_filter() then charges
prog->len for the new filter plus walker->prog->len + 4 for each existing
filter on the task, reaching (args.filter_len + 8) * args.batch - 4 on
the final install of a batch.  Because setup() checks
(args.filter_len + 4) * args.batch (and does so in 32-bit unsigned
arithmetic, which can wrap on large --batch values), combinations such as
--filter-len 4090 with default --batch 8 pass setup() and fail every
seccomp() call in install_batch() with ENOMEM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795139109.gi=
t.xukuohai@huaweicloud.com?part=3D3
