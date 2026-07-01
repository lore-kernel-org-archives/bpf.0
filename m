Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BA15B971
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914023; cv=none; b=N/snbpk4vBWbzYwLNvlq8lDG2ZvvlOXeMRaqkCf9Vv1cZorLVv57Vq4G6dH82ZfzMmiSMnaungBExy0tT00tTNM9jMdkAu4dT/42iPG6vaueM49IXPoxsU2KCPRBqk4nL6iWaissPf/CQnjUB1phOY+iUQ57c1pFW7aVBjXs6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914023; c=relaxed/simple;
	bh=3nvZfN0nI/0oN0R7O+KkW0jqKvDKyQsE9Q/yhhuXL9E=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EbwoGeKogO8jPles2bFJRLJi/48VqBS1ck53zIN27vtEXxI6Kgha5w9MpA9yD2xNGmabERD4WoYSd4rnH6BGKbvvWfuTAHwR9alzYZPhcQaYQmLX3q7MLqLlClT6VkxqrjTe1Kv5xAd4A9S9NsrFPsgUJ9zSjFz3pbUmSZLtO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgRq0b9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgRq0b9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFED1F00A3A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914022;
	bh=HDPeTH+Q9DAmApa/7jHeWKmsileZou7xHE8Qfn2BqLE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PgRq0b9qQ7vIpgN6OoNgxbwh3FAo9dvTg1kBfm3KqsA3qi1jmc0OT47Rm0eu6a8Nc
	 CirXIDtdmN9JAsJNqHP3UjHn3ck/EyvaAksZQnpPju/YCr2Et9KYRxmzVaaRbee9Rz
	 o/gdXgPD0DiG5D5MMJLXXzL4ympky2bjQT17yhh+sxvA3REc/vzpfOp51JMW5zkq13
	 y5aJ81ozPOG5MXzR2C1lPgiuRLYpTCvWXAto1xM2P0neDrur2oaY9Zkuv0XKfJEVRn
	 nrCP8NQ82ftnljjdXma9xlPq742ec4E3+kfMVHYgKhS+Wnuv6PoGlmX/AuF4HDb+rW
	 jHUuVi6xB+oPA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] tools/tracing: Add fetcharg performance
 micro-benchmark
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <178291353202.1566898.1316084678106262789.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291353202.1566898.1316084678106262789.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:53:41 +0000
Message-Id: <20260701135342.3CFED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Divide by zero in benchmark calculation causing a kernel panic
- [Medium] Buffer Overflow / User-Space Out-of-Bounds Write due to ignored =
`count` in `fetcharg_bench_read`
--

commit e30ac26f087c17e4a2160772405d441b6e416abd
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tools/tracing: Add fetcharg performance micro-benchmark

This commit adds a benchmark test module and a shell script to measure the
execution overhead of fetchargs across kprobe, fprobe, and eprobe
configurations.

> diff --git a/tools/tracing/benchmark/fetcharg_bench.c b/tools/tracing/ben=
chmark/fetcharg_bench.c
> new file mode 100644
> index 0000000000000..af18183c1f5d5
> --- /dev/null
> +++ b/tools/tracing/benchmark/fetcharg_bench.c
[ ... ]
> +static ssize_t fetcharg_bench_read(struct file *file, char __user *user_=
buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	char buf[64];
> +	int len;
> +	u64 start, current_time;
> +	u64 elapsed;
> +	u64 loops_per_sec;
[ ... ]
> +	start =3D ktime_get_ns();
> +	for (i =3D 0; i < BENCH_ITERATIONS; i++)
> +		dummy +=3D bench_func_ptr(a, b, c);
> +	current_time =3D ktime_get_ns();
> +
> +	elapsed =3D current_time - start;
> +	loops_per_sec =3D ((u64)BENCH_ITERATIONS * NSEC_PER_SEC) / elapsed;

[Severity: High]
Could this result in a divide by zero? If the system lacks high-resolution
timers or if the loop completes within the same timer tick, elapsed could
evaluate to 0 and cause a kernel panic.

> +
> +	len =3D snprintf(buf, sizeof(buf), "%llu\n", loops_per_sec);
> +	if (len < 0)
> +		return len;
> +
> +	if (copy_to_user(user_buf, buf, len))

[Severity: Medium]
Does this code ignore the user-provided count parameter?

If a user program calls read() on the debugfs file with a count parameter
smaller than the formatted string length len, it appears we could write bey=
ond
the bounds of the user-provided buffer by copying len bytes instead of
honoring the count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178291352217.156689=
8.14481561093843379745.stgit@devnote2?part=3D1
