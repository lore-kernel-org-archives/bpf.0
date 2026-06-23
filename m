Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DE377550
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179606; cv=none; b=C6ImoZYIx8dDwdRG9Xg4hEZMf6TfkApfSnWVRbpaoOCT+c9KwzJciqI9soO+6ON2POYpvBnAg2S8IIdo8T6G8CfS0SzQFY1kZbP6G5eabv9vXDKcMHEzRHuEza0M52DYK89s/n1xRFiiNXqG3Y1raouTE01fWlKgB/efBWRUh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179606; c=relaxed/simple;
	bh=9c0IPctu0UfYb92AEUmBp/zec+PcovN5nZTW3DR9ihs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S86KP9azK3+atRXSQ5ryjSfcpe9mwE0xOJATIuUFCC+9KsreLYCfVpmaDzFlni8POKPDecOb0AYb5sBC2Exh1/vjVFPGfIZ3f5Od1yuWsck/iKE/J2zz29MtIOjQkrN3W5UFymmbn6wpXRvECkQ/fUQvqlYLMVcyzNGIgh4Anp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG6FIf58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG6FIf58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2D31F000E9;
	Tue, 23 Jun 2026 01:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179605;
	bh=aRSe2R/rr+7EPV7rFEV1g7/oYAw0D2VEBAwKWVQCgDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YG6FIf58F9aCDj0Mkr40sAGSTGpRHIBGhBDdqtc1BK8+ckUEMR1Jp0YmmOHFQwDNh
	 OW/C5BN3me02dCtLIAzLqrS+NivyVPEGCm5/HqulxieQZmHY2QxeT8UIOJZTJC/rtx
	 4ENeWVO2DsOdnlKvegqSXQYrXQw9DZOjpmxz9jo06sMPu8E/LgbdTHQApN8ckkvutC
	 tWtIV+vJ3p83XceqYC8H1asswSF2Ajof3w2egD0GVdgn7fy8FRu/i0fm6jA12/pifC
	 KZsITiX3b4Q2hKxBcvLSgxAt5ljJx1KCoL3PAYJIa0BK4jyd1XMjrAmK1lE5GE1UB8
	 G6DzYOelPWdgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4] selftests/bpf: Cover partial copy of non-linear
 test_run output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623014027.402820-1-sun.jian.kdev@gmail.com>
References: <20260623014027.402820-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:53:24 +0000
Message-Id: <20260623015325.2F2D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added selftests `test_skb_nonlinear_data_out_partial` an=
d `test_xdp_nonlinear_data_out_partial` will unconditionally fail due to an=
 unaddressed arithmetic bug in the kernel's `bpf_test_finish` function, bre=
aking the selftest suite.
--

commit 99284be8e441ba5ead251137597e96ebcee998f4
Author: Sun Jian <sun.jian.kdev@gmail.com>

selftests/bpf: Cover partial copy of non-linear test_run output

This commit adds selftests to cover the partial copy of non-linear test_run
output for both TC and XDP programs. It uses a 9000-byte packet with a 64-b=
yte
linear data area and a 100-byte output buffer.

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/too=
ls/testing/selftests/bpf/prog_tests/prog_run_opts.c
> index 01f1d1b6715a6..beb6fa78fd949 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c

[ ... ]

> @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
>  	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt=
, info.run_cnt);
>  }
> =20
> +static void init_pkt(__u8 *pkt, size_t len)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++)
> +		pkt[i] =3D i & 0xff;
> +}
> +
> +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *=
skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN] =3D {};
> +	struct __sk_buff skb =3D {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +
> +	skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in =3D pkt;
> +	topts.data_size_in =3D sizeof(pkt);
> +	topts.data_out =3D out;
> +	topts.data_size_out =3D sizeof(out);
> +	topts.ctx_in =3D &skb;
> +	topts.ctx_size_in =3D sizeof(skb);
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "skb_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_partial_size");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_partial_data");

[Severity: High]
Will these assertions fail unconditionally due to an existing arithmetic
bug in the kernel?

In net/bpf/test_run.c:bpf_test_finish(), the length is calculated as:

    int len =3D sinfo ? copy_size - frag_size : copy_size;

    if (len < 0) {
        err =3D -ENOSPC;
        goto out;
    }

Since the packet length is 9000 bytes with a 64 byte linear area, frag_size
is 8936. When copy_size is 100, this yields a negative length of -8836.

This triggers an early error exit, completely bypassing both the partial
data copy to the userspace out buffer and the update of data_size_out.

> +}

[ ... ]

> +static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *=
skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN] =3D {};
> +	struct xdp_md ctx =3D {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +
> +	ctx.data =3D 0;
> +	ctx.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in =3D pkt;
> +	topts.data_size_in =3D sizeof(pkt);
> +	topts.data_out =3D out;
> +	topts.data_size_out =3D sizeof(out);
> +	topts.ctx_in =3D &ctx;
> +	topts.ctx_size_in =3D sizeof(ctx);
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.xdp_frags_pass_prog);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "xdp_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_partial_size");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_partial_data");

[Severity: High]
Will this XDP test also unconditionally fail for the same reason?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623014027.4028=
20-1-sun.jian.kdev@gmail.com?part=3D1
