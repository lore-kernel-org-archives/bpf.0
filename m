Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0F3DCDAC
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229995; cv=none; b=QyuoI5mrBpvOn+8gnutghySIcd6gxlnEA3QrCSl3gs64Us6VAk300wBJ+h8Ez2us1NdeRI0ERnXAXwLNWLBOo1LzVgXYXZ6Gc3iwKFyrJ5ZwR3u5/yRSebvKVPjiHc/U0J/PKDIYm9Aq/aRwkkRHXfWUV4jR/17hmRusSW/0gRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229995; c=relaxed/simple;
	bh=6XacaxBZP9IlLMkVwKCK7/HLjHGl4RuHv5OARaiUMNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1BtoiXSwcSvL21W1pnFnVOjjtCdkUES85H/fEyERKDqN2pOlJKD2FilHstUpEKxKx7svu37CF+x+gU9ib6817PjLTb4w9DT5/1y61lLu5NkWMumYTYcDNU0aEFKqOuKXnn7Zuz8RdY2WdhxyOsf5nS0aekl2ybIZOenbRRmuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTri3co2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTri3co2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F361F000E9;
	Tue,  1 Sep 2026 02:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788229994;
	bh=hp/qdtVRpaGJUC7DK3jNjIqVxTDs1SLRCC5kGFYmk1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTri3co2e8rw8kLvFfgj1yActR/xPPj1bt/109o5ZMsqUwZhQ98ldcP0HZbbacY6n
	 jsapKBY1clFohlC7CRdl+F6uaxxHngFBWE0ZFhAvICgxz2VwYzFe049/vrjkHpApgM
	 2RG71B72m3nQ7zvNtd+97FQc5KAzafttqrUUec4YZAHICFf2yl5by0cycEl7i6M74C
	 OV8R6+aPBW0SSxxOQJxrAm68gkvzxem8YLSvqTmmm0yAMheNCBQfDgSKD4+JijiWmL
	 KqZQ8ODZBjYHVvpDooxp1Bulbt6Mr7/Ntaz3EcXdObdoFRJ4Zsivuj+RjNxPljcaZ3
	 S13d3qnsfGh+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: Add memcg async reclaim
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <abe85ccba1c3e658d4f8dc25ef958214abaf362c.1788228773.git.zhuhui@kylinos.cn>
References: <cover.1788228773.git.zhuhui@kylinos.cn>
 <abe85ccba1c3e658d4f8dc25ef958214abaf362c.1788228773.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 02:33:13 +0000
Message-Id: <20260901023314.08F361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Insecure temporary file creation using mkstemp() followed by clo=
se() and reopening by name.
--

commit 6ab0cdc46bdb6e587b82be1eda75b832722b30af
Author: Hui Zhu <zhuhui@kylinos.cn>
selftests/bpf: Add memcg async reclaim test

This commit adds the memcg_async_reclaim selftest. It verifies that
BPF-driven async proactive reclaim mitigates refault-induced slowdown
under memory pressure using the bpf_wq and bpf_proactive_reclaim() APIs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c=
 b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..1270d73c9116e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
[ ... ]
> @@ -0,0 +1,480 @@
[ ... ]
> +static int write_file(const char *filename)
> +{
> +	int ret =3D -1;
> +	size_t written =3D 0;
> +	char *buffer;
> +	FILE *fp;
> +
> +	fp =3D fopen(filename, "wb");

[Severity: Medium]
Does this code reopen a securely created temporary file by name?=20

The file descriptor from mkstemp() was closed earlier, which can create a
Time-of-Check to Time-of-Use (TOCTOU) race condition. If an attacker replac=
es
the file with a symlink during this window, it could lead to unintended file
truncation or writes.

[ ... ]
> +static int real_test_child_work(const char *cgroup_path, char *data_file=
name,
> +				char *time_filename, int read_times)
> +{
[ ... ]
> +	printf("%.6f\n", elapsed);
> +
> +	fp =3D fopen(time_filename, "w");

[Severity: Medium]
Similarly, could opening this time file by name present a symlink truncation
risk?

[ ... ]
> +static int
> +run_high_low_workload(double *high_elapsed, double *low_elapsed, int rea=
d_times)
> +{
[ ... ]
> +	snprintf(high_time_file, sizeof(high_time_file),
> +		 "%s/memcg_async_high_time_XXXXXX", dir);
> +	snprintf(low_time_file, sizeof(low_time_file),
> +		 "%s/memcg_async_low_time_XXXXXX", dir);
> +
> +	fd =3D mkstemp(high_data_file);
> +	if (!ASSERT_GE(fd, 0, "mkstemp"))
> +		goto cleanup;
> +	close(fd);

[Severity: Medium]
Closing the file descriptor returned by mkstemp() here discards the security
guarantees it provides, opening the race window.

Could the test be refactored to pass the open file descriptor instead of
relying on the filename string? This same pattern appears to be repeated for
all four temporary files created in this function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788228773.gi=
t.zhuhui@kylinos.cn?part=3D2
