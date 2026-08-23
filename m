Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427C30D40F
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495331; cv=none; b=GMyTWtV7G+SHDO8ELtdgDLRQ4ZZx1pVzorzY2ZEVyNCuUlda9HMXQqEm0iELEYfxjwoB9OEEOmkoFz9A4T5fVT0OqWlbquZYRyabKHGvFlWEzEKkzJct+iNIHxDJlqanSe4YjAZ6pEl2m9lQl1a0a5NRZ/lR0KIK/kCH79YQd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495331; c=relaxed/simple;
	bh=iZENpyGy2PtfHPYA4Ci1IudEgofB4wvQZVWuOQ1P1AE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzR/A3gI2jVGmWcTovuPHfYrZk8tzvB+CNlLjVkf1Lb5xCdv/BXNDrY6WVZNQids3xHzI/CTczgcZN9QFrQ12YG9Ri9BMflIghgEkDXw5+ppwE3znbOyMuG0RjntIa6/NHAlKDbiz7O5tU8FX6wEFYpS6wR4CX5eThvuRV7rJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxnLF/Iz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxnLF/Iz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7611F000E9;
	Sun, 23 Aug 2026 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787495330;
	bh=WTAKzXCtB1LzurnJHlvwosnasJ2gzGqGKJ90F2z+UiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxnLF/IzAFGRdGhs+xtdICS8y7wBO73/a3JOY3fqs2hA9A8slcj0W0+tRanTmOlHP
	 ZNCJvRHp1vgF83L/JRBowoskPOhG/Iz+xAdIoYCqUnHHy58DD6CIPTH5ZY90fRc2Zl
	 VDgWQR1lYfAWjQoDrO2oGaLEhjuyMe+NRfb24NJCrxjUjqnR9H36/s+5uY5xqoVK2O
	 MsfgGuo1bMIlzNt5rLsBffUJLbvwH5alzFJOOKyRyX0xFJDVJvkTSBGxl5AL4G2PxN
	 3Va9KOiAF/dQX+92HFbCI+8s/zVt5G2zf4vGxs+c7xgJn2rp3kS6js/TOZmt/kLKck
	 rqyLYy8rKgwTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: cover stream capacity
 and partial read edge cases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <c5a79efbd3cb52cc0668ab50db5379c907cfe6a6.1787492521.git.shijianlin11@foxmail.com>
References: <cover.1787492521.git.shijianlin11@foxmail.com>
 <c5a79efbd3cb52cc0668ab50db5379c907cfe6a6.1787492521.git.shijianlin11@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 14:28:49 +0000
Message-Id: <20260823142850.2A7611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The `test_stream_oversize` test fails to verify its stated claim=
 that an oversized push does not permanently consume stream capacity.

Pre-existing issues:
- [Critical] Unvalidated `len` parameter in `prog_stream_read` can be cast =
to a negative integer, leading to a massive out-of-bounds read of kernel me=
mory on 32-bit systems.
--

--- Patch [5]: [PATCH bpf-next v4 5/5] selftests/bpf: cover stream capacity=
 and partial read edge cases ---
commit f20a230c79a9f103af40866a70610a281adb0a0f
Author: Jianlin Shi <shijianlin11@foxmail.com>

selftests/bpf: cover stream capacity and partial read edge cases

This patch adds test coverage for recent fixes to BPF stream capacity
and partial reads. It verifies that an oversized bpf_stream_printk()
does not leak capacity and that bpf_prog_stream_read() handles
unmapped pages correctly.

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index e4e9374309e26..9a21f055d80aa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
[ ... ]
> @@ -58,6 +58,71 @@ void test_stream_syscall(void)
> +void test_stream_oversize(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct stream *skel;
> +	int ret, prog_fd;
> +	char buf[8] =3D {};
> +
> +	skel =3D stream__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
> +		return;
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.stream_oversize);
> +	ret =3D bpf_prog_test_run_opts(prog_fd, &opts);
> +	ASSERT_OK(ret, "oversize run");
> +	ASSERT_OK(opts.retval, "oversize retval");
> +
> +	/* Oversized push must not permanently consume capacity on this prog. */
> +	ret =3D bpf_prog_stream_read(prog_fd, BPF_STREAM_STDOUT, buf, sizeof(bu=
f), NULL);

[Severity: High]
This is a pre-existing issue, but can the length parameter passed to
bpf_prog_stream_read() cause an out-of-bounds read?

In kernel/bpf/syscall.c:prog_stream_read(), an unbounded u32 length
from user space is passed down:

kernel/bpf/syscall.c:prog_stream_read() {
    u32 len =3D attr->prog_stream_read.stream_buf_len;
    ...
    ret =3D bpf_prog_stream_read(prog, attr->prog_stream_read.stream_id, bu=
f, len);
}

Since bpf_prog_stream_read() takes an int, large values (e.g. 0x80000000)
are cast to negative integers.

This negative length bypasses the loop exit conditions in
kernel/bpf/stream.c:bpf_stream_read():

kernel/bpf/stream.c:bpf_stream_read() {
    while (rem_len) {
        ...
        cont =3D bpf_stream_consume_elem(elem, &rem_len) =3D=3D false;
        chunk =3D elem->consumed_len - cons_len;
        n =3D copy_to_user(buf + pos, elem->str + cons_len, chunk);
    }
}

Could this result in a negative chunk size being passed to copy_to_user(),
which is then cast to a massive unsigned value on 32-bit systems?

> +	ASSERT_EQ(ret, 3, "bytes after oversize");
> +	ASSERT_OK(memcmp(buf, "foo", 3), "payload after oversize");
> +
> +	stream__destroy(skel);
> +}
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/s=
elftests/bpf/progs/stream.c
> index 8e8e1339dc743..02fe07a00cebd 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
[ ... ]
> @@ -119,6 +124,19 @@ int stream_syscall(void *ctx)
> +SEC("syscall")
> +__success __retval(0)
> +int stream_oversize(void *ctx)
> +{
> +	int ret;
> +
> +	ret =3D bpf_stream_printk(BPF_STDOUT, _BIG_STR);
> +	if (ret !=3D -E2BIG)
> +		return ret;
> +
> +	return bpf_stream_printk(BPF_STDOUT, "foo");

[Severity: Medium]
Does this code actually verify that capacity is not leaked?

Since a single oversized push of 1024 bytes leaves most of the capacity
unused, won't this subsequent write of "foo" succeed even if a leak
occurred?

Would it be better to loop and exhaust the capacity limit to properly
detect a leak?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787492521.gi=
t.shijianlin11@foxmail.com?part=3D5
