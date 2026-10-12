Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3D34C155;
	Mon, 12 Oct 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823971; cv=none; b=dfOCWAcO+IrKZ6dcNCuPcAiFeniWPOUmC4uChJibUjyK2vvI/LRxT+BJBaB9lZaHHYuv9FTCQEHVtk8WC86zE16v6QgCQdYMXC/5nENyS2VgW8A7XQ37MlaOIY5iop22BOxakbXJOZIX9YVHQBKXnQ9xCvOR1pjs+Ob1LTv73xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823971; c=relaxed/simple;
	bh=scwGMuPE0hrrZP4D6QXEPaQi1+dpyjIIFgtHBiqxgEM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HPUZL48/S7KF6lyrXx1IF2QgAdMOtLlMgPe/fNZjh6Vvm5YA1dSwBx3gLajUwPUAlKjZujYNgg3h9eTzHaCcOfNd39vb917EgAkP9YN18VDnPgvyT0KsJzNzIO19ZgS6/ahcRVgGGm4oEUJ7AhgqgIuBkzad28pQIKnwgZ5QRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB9j+z7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB9j+z7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4791E1F0089B;
	Mon, 12 Oct 2026 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823970;
	bh=/w6Qp1TZW0zbH/6OVQSyQAhWTe9E7S6zLff6d0ONEXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JB9j+z7KogFA3zMR06ZeF0BNXQ1pBDzAM8Qiit9gMB/qU6gKEOq6Wbb3IpiAzonlK
	 znDtVJ8SqZOb6lxtGVcrcCQyh9NxvVMH/IZ3EbtmsbuXpwvYbpI4mjsylXsnEJJIdT
	 S0OYNDYjmGUWkvd1sc9HGm7C/9JrIM95Z/9QaqpmcDPHkAM6S8tIFbfUZ9QCwqOVk4
	 sQivOrdPMS9pxdFT0tE0j3Gy6P2uUfnl/4Jlylij05iT/c9kenQACP5qsDz0PLkmdl
	 F5XpuyTXTJzAKh4eFSeKQ4F4pICgw+zhsS/pmjeRDzFxK99OTNrCboMdaI71qBdPIs
	 nxUb9w0Jsp1WQ==
Message-ID: <sashiko-outbox-168438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 21/21] selftests/bpf: Benchmark
 tracing_multi bpf progs attachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261012154024.29423-22-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-22-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 16:52:49 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: bench fails with EMFILE due to unraised RLIMIT_NOFILE
- [Low] bpf: benchmark time overflow on 32-bit due to long truncation
--

commit d6a7c4ba0d33ae305098f82b092a318e73ea06fb
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Benchmark tracing_multi bpf progs attachment

This commit adds an x86-64 one-shot generic benchmark to compare the
performance of attaching 1000 individual fentry links versus a single
fentry.multi link for the same 1000 BPF program targets.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attac=
h_progs.c b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_p=
rogs.c
> new file mode 100644
> index 0000000000000..6cc6851eb488e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_tracing_multi_attach_progs=
.c
[ ... ]
> +static long create_and_attach_fentry(void)
> +{
> +	int link_fds[TARGET_CNT];
> +	long start_ns, end_ns;

[Severity: Low]
Will this truncate the 64-bit nanosecond timestamps returned by get_time_ns=
()
on 32-bit architectures?

get_time_ns() returns a __u64, and storing it in a 32-bit long drops the up=
per
32 bits. Also, if the elapsed time (end_ns - start_ns) exceeds roughly 2.14
seconds, the signed 32-bit long will overflow into a negative value, result=
ing
in negative benchmark times and malformed speedup calculations.

Loading 1000 targets and links could easily exceed 2.14s on slow or emulated
32-bit hosts.

> +	int err, i, j;
> +
> +	start_ns =3D get_time_ns();
> +
> +	/* An ordinary fentry program is bound to one target when it is loaded.=
 */
[ ... ]
> +	for (i =3D 0; i < TARGET_CNT; i++) {
> +		link_fds[i] =3D bpf_link_create(ctx.fentry_prog_fds[i], 0, BPF_TRACE_F=
ENTRY, NULL);
> +		if (link_fds[i] < 0) {

[Severity: Medium]
Will this benchmark predictably fail with EMFILE due to exceeding the defau=
lt
1024 file descriptor limit?

The benchmark attempts to load 1000 target programs, 1000 fentry programs, =
and
1000 links (over 3000 FDs total) sequentially without raising RLIMIT_NOFILE=
 in
setup_libbpf() or bench.c. Running this locally without manually increasing
the open file limit via ulimit -n will cause bpf_link_create() or program
loading to fail.

> +			err =3D errno;
> +			for (j =3D 0; j < i; j++)
> +				close(link_fds[j]);
> +			fprintf(stderr, "failed to create fentry link %d: %s\n",
> +				i, strerror(err));
> +			exit(1);
> +		}
> +	}
> +	end_ns =3D get_time_ns();
> +
> +	for (i =3D 0; i < TARGET_CNT; i++)
> +		close(link_fds[i]);
> +
> +	return end_ns - start_ns;
> +}
[ ... ]
> +static void setup(void)
> +{
> +	double fentry_multi_ms, fentry_ms;
> +	long fentry_multi_ns, fentry_ns;

[Severity: Low]
Similar to the issue in create_and_attach_fentry() above, will these signed
long values overflow and yield negative durations if the elapsed benchmark
time exceeds 2.14 seconds on 32-bit architectures?

> +
> +	prepare();
> +	fentry_ns =3D create_and_attach_fentry();
> +	fentry_multi_ns =3D create_and_attach_fentry_multi();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012154024.2942=
3-1-leon.hwang@linux.dev?part=3D21
