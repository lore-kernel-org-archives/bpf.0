Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CD155C97
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786816; cv=none; b=FvmxKW46G8RPkDLz4oYSgFTYyRhEf52dZa9QphF1Jz81/S1Ue63iyjC+Udqti98YT1wtYqdtD3wIpoc4pBNqJccQvP1UDU3REcA71Br5bYqpl2jRJzXFCtkaFMs61as5Tsk3lhGZ9xYTP0FduX9Cv4Xx4bp0xitNJ9M6vj8E/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786816; c=relaxed/simple;
	bh=cbevScF7h1eXQpcRl9/AyiZCm+jZprnWa4ChvkCGQVc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rDT/J02x6b42ptm+/r0PwRg/ACmy2EXDuc74g6UKBFvHNNYukonaWwy5PDrhgvHbLlxrgyilNdnvJ1OtEhkpKC9LriIMITdHCFJF5LmZNNjPRpIHSgxW5o1wOrua8olsUkradI6GJJ6C0n/idex6G7FPTT2xs7RQDLklDlCCBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SffwTD/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SffwTD/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C3D1F000E9;
	Tue, 30 Jun 2026 02:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782786812;
	bh=WlKKEJdyywAXXx1psWuykzRH09mlO8sBeslSP4y7q6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SffwTD/2tawrxlWvZniYlxqjjPODpiYjGubUbz+/DxbSvP1tCcZnryxm0G5YJCWNn
	 oZAdZtZ0Jc9r3BZ7S4hfbrI+aZXOLbvWtdpD3tH1KsodGD7YRSrur2XiOtBHDERnuo
	 3DdyPsoR9O4WspyhErJBbzQUNtdUsmJY3V3dHZYD3PcOezvaATdhG9SDy1+VuOP/2B
	 wwNs9udax7uyip9XZkNUqEiRcvpa177DgiguO2SzBJUkXbY+DqDHw1o8BxVsP4Lqc/
	 9N74N+J+IrNo0OOyk3CbG2qeolLcnX72I53wZYiiTjXZ2+ho10QvjefWZo/36LyDUb
	 xF5CKdZhGX0kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add benchmark for tail call
 performance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630022306.10017-1-yangtiezhu@loongson.cn>
References: <20260630022306.10017-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 02:33:31 +0000
Message-Id: <20260630023332.60C3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Memory leak on the error path in `tailcall_measure`.
- [Medium] Hardcoded CPU affinity causes test failure on systems with fewer=
 than 3 CPUs.
- [Low] Redundant file descriptor validation for BPF skeleton-generated map=
s.
--

commit f098091b64abfdc8c42b360eefbec9dae2a20a03
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Add benchmark for tail call performance

This commit introduces a new benchmark to measure the runtime performance a=
nd
overhead of BPF tail calls. It uses a tracepoint on sys_enter and toggles
between direct and bpf2bpf tail calls, along with a shell script for automa=
ted
testing.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_tailcall.c b/tools/=
testing/selftests/bpf/benchs/bench_tailcall.c
> new file mode 100644
> index 0000000000000..a203017f5e282
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_tailcall.c

[ ... ]

> +static void tailcall_measure(struct bench_res *res)
> +{
> +	__u32 key =3D 0;
> +	__u8 *values;
> +	__u64 total_hits =3D 0;
> +
> +	values =3D calloc(ctx.ncpus, ctx.percpu_size);
> +	if (!values)
> +		return;
> +
> +	if (bpf_map_lookup_elem(ctx.map_fd, &key, values) !=3D 0)
> +		return;

[Severity: Medium]
Does this error path leak the memory allocated for values? If
bpf_map_lookup_elem() fails, the function returns immediately without calli=
ng
free(values).

> +
> +	for (int i =3D 0; i < ctx.ncpus; i++)
> +		total_hits +=3D *(__u64 *)(values + i * ctx.percpu_size);
> +
> +	res->hits =3D total_hits;
> +	free(values);
> +}

[ ... ]

> +static void tailcall_setup(void)
> +{
> +	int main_fd, target_fd, jmp_map_fd;
> +	__u32 key1 =3D 1;
> +
> +	ctx.skel =3D tailcall_bench__open();
> +	if (!ctx.skel)
> +		exit(1);
> +
> +	ctx.skel->data->my_pid =3D getpid();
> +	ctx.ncpus =3D libbpf_num_possible_cpus();
> +
> +	if (tailcall_bench__load(ctx.skel))
> +		exit(1);
> +
> +	jmp_map_fd =3D bpf_map__fd(ctx.skel->maps.jmp_table);
> +	ctx.map_fd =3D bpf_map__fd(ctx.skel->maps.pcpu_hits_map);
> +	ctx.percpu_size =3D bpf_map__value_size(ctx.skel->maps.pcpu_hits_map);
> +
> +	if (ctx.map_fd < 0 || jmp_map_fd < 0)
> +		exit(1);

[Severity: Low]
This isn't a bug, but are these file descriptor checks necessary? After a
successful skeleton load, fields like skel->maps are guaranteed to be valid
and bpf_map__fd() cannot return a negative value.

> +
> +	main_fd =3D bpf_program__fd(ctx.skel->progs.tailcall_bench_main);
> +	target_fd =3D bpf_program__fd(ctx.skel->progs.tailcall_bench_target);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh b/t=
ools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
> new file mode 100755
> index 0000000000000..c687f34455e8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh

[ ... ]

> +# 2. Strict error handling configurations
> +set -eufo pipefail
> +
> +# 3. Use default bench binary path if not exported by the framework
> +BENCH_BIN=3D${BENCH:-./bench}
> +
> +# 4. Run with strict core affinity and isolation for reliable profiling
> +RUN_BENCH=3D"numactl --physcpubind=3D0,2 --membind=3D0 nice -n -20 $BENC=
H_BIN -w5 -d20 -a"

[Severity: Medium]
Will this hardcoded CPU affinity fail on systems with fewer than 3 CPUs?
If CPU 2 does not exist, numactl might fail and immediately abort the script
due to the set -e configuration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630022306.1001=
7-1-yangtiezhu@loongson.cn?part=3D1
