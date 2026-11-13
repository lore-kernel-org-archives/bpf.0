Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608831;
	b=PARj8tCePObcFYj6lQDHmucnCTTe9s2l8zQ53alPXvlgduP6ebynryTkI7jkUSYxGGX1
	 OT4hvzeLFPAatIl2pXGGdFtaUtqQtgYJCbRH4kdjLnhm+VCvmxEcJFNM/tPvX6CNX12bO
	 nn6YlsNhqHj/mBIXM0esIudvYbV2YempbN0QoRx2VsuhYTFZFOHmbAzgTlXjn/r+ZYt8I
	 9zvfJPEFz6T6Q+R/IJsrcBlDtU4xIdjZ/ypKYB7Fzvj2Jl7gzaa8dVnAwNu6qzjbZcgo7
	 7H8m9hPqwYZ5RUUj+Qs7LVo/sNeKB649YgXe47Qf99pqA83eZU+uA2LbllKZ8glVm/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608831;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GACYChRxvh8l0R71XPrOTkQkzrVUaOg8eaEAk/KLdBI=;
	b=5I4rCoI1I07Ggi0oidJv1kdNqgDVj+P5EO48TTMqHQuEocekUcRLaxndIFocFIpqKnTV
	 F/oswujYLlpBDRJz/Nu33K84kmsaz2s/T7TxZKqQLlKBpL9GN87ptZqyHnkSI14QZJJaj
	 6KPpJax7rwbkPt4G+0jdzASNMiEfqV7RnpIqb8nVaUzxpc9EUl5IHdeF6CzRMe2l2Ppxb
	 m0fSnbyXqLO8sKZ6MKCoqMUuYuW+lg5j1uxmEj48Bkzhf9M5Nc+kQiuM6JMGhMhj8gZXP
	 X0ZYwUEyum1AQSHj65isj/6XcfqDevw5JePzjQBXoQTlgsA9fHSeKD/nfXKujKHFpxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbEMxuoF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D015606A331;
	Fri, 13 Nov 2026 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbEMxuoF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F08E1F000C8;
	Fri, 13 Nov 2026 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794608830;
	bh=GACYChRxvh8l0R71XPrOTkQkzrVUaOg8eaEAk/KLdBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbEMxuoFHYN9EoVx/4y9Hrlzl8J7k2QFlt/CQW/uR9myulk+uMWuRfF+kS1PIPPnG
	 i64SHV9he47ucQuYHjxcVCcomuKbYMM+jNvz5lx0vEx6I/ujN1tk4fsiYd+4flzSHE
	 LANRMZ1P5wcIh3DHX32aK6LB9wlCXn++XM0VTw4SFojNxwo6aVkTeBzBTZFfbHd8wT
	 eT/Ls4TFXtx9oi+IgMI3GhOAh3txMtB5BChpDMur9lTxDS95mDz9UWsquT1X8aDROH
	 1MUh3HTbYoHPSj5IKV3f9HPCNvScX0fPeBGzcuSx8Z1lz96RQAJODMrHZE4HzhJ0r3
	 D7IC6YBipyNlw==
Message-ID: <sashiko-outbox-213807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] selftests/proc: Add KALLSYMS_QUERY_*
 ioctl tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuel Wu" <wusamuel@google.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261113221248.3535369-18-wusamuel@google.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-18-wusamuel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:27:09 +0000
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
- [Low] selftests/proc: main() bypasses kselftest reporting and harness
  helpers
--

commit cea94aa72f17dbd75f99a6a582f1fe997f0b838e
Author: Samuel Wu <wusamuel@google.com>

selftests/proc: Add KALLSYMS_QUERY_* ioctl tests

This commit adds a selftest for the KALLSYMS_QUERY_BY_NAME and
KALLSYMS_QUERY_BY_ADDR ioctls on /proc/kallsyms.

> diff --git a/tools/testing/selftests/proc/proc-kallsyms-query.c b/tools/t=
esting/selftests/proc/proc-kallsyms-query.c
> new file mode 100644
> index 0000000000000..7788cb0f30f83
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-kallsyms-query.c

[ ... ]

> +int main(void)
> +{
> +	struct {
> +		struct kallsyms_query_by_name q;
> +		__u64 extra;
> +	} qx =3D {};
> +	struct {
> +		struct kallsyms_query_sym s;
> +		__u64 extra;
> +	} sx =3D {};
> +	struct kallsyms_query_by_addr qa;
> +	struct kallsyms_query_by_name q;
> +	struct kallsyms_query_sym sym;
> +	unsigned int cnt =3D 0;
> +	__u64 first_pos =3D 0;
> +	char name[512];
> +	__u64 size;
> +	__u64 len;
> +	int err;
> +	int fd;
> +
> +	fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		ksft_exit_skip("open(/proc/kallsyms): %s\n", strerror(errno));
> +	scan_text();
> +	if (!ref.vfs_read_found)
> +		ksft_exit_skip("vfs_read is not in /proc/kallsyms\n");
> +
> +	/* Exact name in vmlinux, with name and module buffers */
> +	sym =3D bufs(sizeof(name_buf), sizeof(mod_buf));
> +	q =3D name_q("vfs_read", "vmlinux", &sym);
> +	err =3D by_name(fd, &q);
> +	if (err =3D=3D -ENOTTY)
> +		ksft_exit_skip("KALLSYMS_QUERY_BY_NAME is not supported\n");
> +	if (!ref.vfs_read_addr) {
> +		qa =3D addr_q(0, &sym);
> +		assert(err =3D=3D -EPERM && by_addr(fd, &qa) =3D=3D -EPERM);
> +		ksft_exit_skip("kallsyms addresses are hidden\n");
> +	}
> +	assert(!err);
> +	assert(sym.sym_addr =3D=3D ref.vfs_read_addr && sym.sym_size > 0);

[ ... ]

> +	close(fd);
> +	return 0;
> +}

[Severity: Low]
Could this test use kselftest_harness.h (FIXTURE(), TEST_F(), and the
ASSERT_*/EXPECT_* macros) or the kselftest.h result helpers
(ksft_print_header(), ksft_set_plan(), ksft_test_result_*(), and
ksft_finished()) instead of running sequential raw assert() checks in main()
and exiting with a bare return 0?  As written, a normal run emits no KTAP
plan or result lines, and any failed check aborts the process with SIGABRT
rather than reporting which subtest failed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113221248.3535=
369-11-wusamuel@google.com?part=3D7
