Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D543BB9FA
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715090; cv=none; b=nxYCI18rfSJ8sMA1bK8TRxK+xdoIH/LYqOZfrniKMsQkMxNDjMnypFbZ48EB7HO/ODuCdM7jujv2ZEld5tqimkBGALEzopInhQTqkLSXpYIq1Laq0gu3mhUPRFo4KLIvcFTpi2rrhp7cRaiwf3hAEiCLo3ToySKBquNRX3l3kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715090; c=relaxed/simple;
	bh=wioUsjAaowAgOMyZ0qehCaoWsA19jUhdtUQZkYfyykA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q2rsz5f2/C7oFTJXmvWtlZAJhpFPmRcyT98CTYjkOT0eQ4T2HdVCpYpH9q9P5Bk1PnCDI+FdmyNWfDYb5e5w1220G1jL/oV9y4QbVRK4AS8fBhAJqMeNUjocEz0nUaWEMp/WN45MLpyfJ2hDjtN1W6d//qAOPu8CQhCd0BAuEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoefUsIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoefUsIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5121F00A3A;
	Sun,  6 Sep 2026 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715088;
	bh=QyR10Uk3Nl85AjpJPiga5N18CSZzBbappGqvhJc9sHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VoefUsIu95k6CiZcQifAOjYB1Qv2VcRdTa6SkdEwUH5vh9bntG9Umn5Skf1KzTcnr
	 x9ohF5tQEzWikcS4P6sJbDx5xsAa+re7sWYW77OJoi1MnySxtf9EDZLv5hgL8a1t/0
	 Qx3QHfVtcl+hRo6o60D8SGHY0LUoOkkJV8kKb/iUWk9qm7KqArQTYqEYs34MWehKNi
	 mtEO+pa1bkUrZpoOlRQy1Rf9dt8h7cf5OH8Yp7uh30mGIRSvNFDWlp6IDLsug6P3E6
	 gkXk6IgBVWk5e4UkCYDza8d64i7zKNoshGm/ACEZdWF5U0tyZV34wxICs57/6wKqjo
	 EuGb78WRTjQ/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover bpftool ring buffer
 event_pipe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260906170747.1212378-3-hi@tychen.cc>
References: <20260906170747.1212378-1-hi@tychen.cc>
 <20260906170747.1212378-3-hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:18:07 +0000
Message-Id: <20260906171808.5B5121F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message claims to test 'pinned map selection', but it=
 is never implemented or exercised in the test code.
- [Medium] The commit message claims to check 'pretty JSON output', but the=
 test never invokes bpftool with the pretty print flag.
--

commit 7060e09603777e15c3fff0503b5038d8629bb63d
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Cover bpftool ring buffer event_pipe

This commit adds selftests for bpftool's ring buffer and perf event pipe
output. It aims to verify plain, JSON, and pretty JSON output formats, as
well as map selection methods and error handling.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c b/t=
ools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
> new file mode 100644
> index 0000000000000..2099bf1020930
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
[ ... ]
> @@ -0,0 +1,381 @@
[ ... ]
> +static bool consumer_start(struct consumer *child, int map_fd, bool json,
> +			   const char *option, bool pair, bool capture_errors)
> +{
> +	struct bpf_map_info info =3D {};
> +	__u32 len =3D sizeof(info);
> +	const char *path =3D bpftool_path();
> +	char *argv[12], id[16];
> +	int out[2], ready[2], n =3D 0, err, err_fd;
> +	struct pollfd pfd;
> +
> +	if (!ASSERT_OK_PTR(path, "bpftool path (set BPFTOOL to override)") ||
> +	    !ASSERT_OK(bpf_map_get_info_by_fd(map_fd, &info, &len), "map info"))
> +		return false;
> +	snprintf(id, sizeof(id), "%u", info.id);
> +	argv[n++] =3D (char *)path;
> +	if (json)
> +		argv[n++] =3D "-j";

[Severity: Medium]
The commit message states the test will check "complete plain, JSON and
pretty JSON output", but in consumer_start() the test only ever appends the
"-j" flag.

Is there a missing test case or flag assignment here to exercise the "-p"
(pretty JSON) bpftool output path as promised?

> +	argv[n++] =3D "map";
> +	argv[n++] =3D "event_pipe";
> +	argv[n++] =3D "id";
> +	argv[n++] =3D id;

[Severity: Medium]
The commit message claims to "Exercise ID and pinned map selection", but
consumer_start() hardcodes "id" for the map selection argument.

Is the logic to use "pinned" paths missing from this test implementation?

> +	if (option) {
> +		argv[n++] =3D (char *)option;
> +		argv[n++] =3D "0";
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906170747.1212=
378-1-hi@tychen.cc?part=3D2
