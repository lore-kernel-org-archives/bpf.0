Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335153D9035
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791116; cv=none; b=ofjHznI4L/xvOIBHZclzMYR6PSPTBccxxFr14IB6BDFeZEHYhsBq1uGmlZ+e7ngLU59TZ2DEoDaoaN6mAg9P7b+W60IHNQTFRn/sfe65m6OLUcbytaHRAGKudMub/Pvf1KaDrksv+WLDqWZt+CEzDDqPz2xLuk4M8x8I2ayK7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791116; c=relaxed/simple;
	bh=WfE0AATCEPgroFvIlEqq2krzpEkzSON3pKCWKMDt+PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U/4XiDnXuar+RedM4ZuUJdg/r1w9vXSTv22TvMjcfKhyk3baAxfvAAbl/UDgDmh9LQ+zxPzeLbFz4KoXjdcWc0SZ7YwgGXzRQmUIKR80E3NKUgrhRcDZAA0nVjT8T0j/lwNUh543uVEBA3ZHoAQnqzd+s19wyZlHceTINxyHpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhTYc35Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhTYc35Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE3C1F000E9;
	Tue, 26 May 2026 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779791114;
	bh=aty2Zuq6/D1tqkcG9d4/2mQlX82rU42LQQ4tZvd2AQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BhTYc35YNpRlYyImdAFClRujJklvYWmK0zy01LbN5WGGSR2NTzQ4mk9lFL5SQ1UNQ
	 VnBAyRDiRJHQhvyiKIqQA/72xZ2Izceo+K3CJB18czRbdS6+d8mkn+toWXTzAym+ZL
	 FaRKNLv6ztaPK8oPZUSnirOJeXdsA9tqu6yti/E/+Tj6BGV+0UzQ14hkVJG468Vzl3
	 pYoUNN2ZmTLgx8gL/5Q09CIgsfjDOzLIQhp4uE5ZWllCVIlN3BklqZaDctOsA4P/5P
	 1Bn7cJARmOmeOIQbADeCxI2EGGMoT+w79zS9zUVMXBP4l8jvgNzDzOq7FTqDEEqmP4
	 5xXLohZFlnIDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/6] selftests/bpf: test cases for loop
 hierarchy computation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-better-1m-reporting-v1-3-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-3-51e4f2c59780@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:25:14 +0000
Message-Id: <20260526102514.AFE3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The expected verifier log output in `fwd_edges_no_loop` incorrec=
tly expects an unconditional jump `(05)` for a conditional jump instruction=
, which will cause the selftest to fail.
--

commit f35c2f4d237eac02dd241fbf85f69d40722f62de
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: test cases for loop hierarchy computation

This commit adds test cases covering various branches in bpf_compute_loops
for loop hierarchy computation. It includes tests for single bounded loops,
independent loops, nested loops, diamond control flow graphs, and irreducib=
le
loops.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c =
b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
> new file mode 100644
> index 0000000000000..db26157e3e14a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c

[ ... ]

> +/* Case C: forward edges, no loops. */
> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("          0: {{.*}} (b7) r0 =3D 1")
> +__msg("          1: {{.*}} (05) goto pc+2")

[Severity: Medium]
Will this test case fail because of a mismatch in the expected verifier log?

The inline assembly below uses "if r0 > 0 goto 1f;", which is a conditional
jump. This translates to opcode 0x25 (if r0 > 0x0 goto pc+2), but the __msg
assertion explicitly expects opcode 0x05 (goto pc+2), which is an
unconditional jump.

> +__msg("          2: {{.*}} (b7) r0 =3D 2")
> +__msg("          3: {{.*}} (05) goto pc+1")
> +__msg("          4: {{.*}} (b7) r0 =3D 3")
> +__msg("          5: {{.*}} (95) exit")
> +__naked void fwd_edges_no_loop(void)
> +{
> +	asm volatile ("					\
> +	r0 =3D 1;						\
> +	if r0 > 0 goto 1f;				\
> +	r0 =3D 2;						\
> +	goto 2f;					\
> +1:	r0 =3D 3;						\
> +2:	exit;						\
> +"	::: __clobber_all);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-better-1m-=
reporting-v1-0-51e4f2c59780@gmail.com?part=3D3
