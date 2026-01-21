Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2C41C2F3;
	Wed, 21 Jan 2026 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028638; cv=none; b=Mer4N2IgUGxhkbgvKlMz3HNxijHJ7DbzJ2rco4XTNzh84cMvSPHGbOEFDpMN1vnbiiEMpRfg6c10H57rv9fQYuun3jcJchN3fK8ICgPWooCcfIoMMxs1E0EFXuSuVCQIjJpdR3EWVx/GEdLKrFYby+AUzlNIaU3c7chmS4lCxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028638; c=relaxed/simple;
	bh=+LsOHFiMLGaW4+Qp5yJtaNMGWwXHdDzvMwcCWBENWas=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hz8KrwEUDLboBtplOzvYv4uG0HDcRUjZPgSnF0IAsCLALpn4RnluDuC4dbnP1WCFtY5KAq1+/ny7sp7OGKeRS69Dp0Oc4KttYI9gJP3MUhI1scoV6Sz7+v6FKOtPpKLhn/rRE7gCWCQl8iwSnLxhZQvXVYfSZdTt6urk8lmuYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDvX4xqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDvX4xqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AD7C4CEF1;
	Wed, 21 Jan 2026 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028637;
	bh=+LsOHFiMLGaW4+Qp5yJtaNMGWwXHdDzvMwcCWBENWas=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oDvX4xqFDtzlo74dBnk20kceHKIoVtTOJiAwqgHvmRgcAjo2808aXDeahfBRWFrLR
	 wj24bCDMjH5XW5D1iEt1S9bNGh4wGmfvgI3qurJQzUViAYhwP0XdAYhsbOoA8Ig3VZ
	 IPvKe0Nrjkirkbeus8Y63cmwWp70rPtax96fBxPHyacY+LJbZyVxlOIod20p9Wisms
	 yRiOigw0mG4MUD0rwhSEOCQ4H6niKB8PAFTLqW8MX1oycihsmc1/szv7OCHq50n7M+
	 nj8rUekGE+GH4bYxYcpfMrRB3HVKoJFbwK5l5ewzVPdpw1sBbEn9JY3PKDXRWXuFYG
	 FFFgU3mU2z+UA==
Content-Type: multipart/mixed; boundary="===============3596951627756990129=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad4c694cdb5ec78a78956b2b397a6052d4d0ef426eb85769781ce2a0baddf08a@mail.kernel.org>
In-Reply-To: <20260121-bpftool-tests-v3-2-368632f377e5@bootlin.com>
References: <20260121-bpftool-tests-v3-2-368632f377e5@bootlin.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: convert test_bpftool_metadata.sh into test_progs framework
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,qmo@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 21 Jan 2026 20:50:35 +0000 (UTC)

--===============3596951627756990129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c b/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c
> new file mode 100644
> index 000000000000..b5598741a01c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_metadata.c

[ ... ]

> +static void run_test(struct test_desc *test)
> +{
> +	int ret;
> +	char cmd[MAX_BPFTOOL_CMD_LEN];
> +
> +	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog load %s %s",
> +			test->bpf_prog, test->bpffs_path);
> +	if (!ASSERT_GT(ret, 0, "format prog insert command"))
> +		return;
> +	ret = run_bpftool_command(cmd);
> +	if (!ASSERT_OK(ret, "load program"))
> +		return;
> +
> +	/* Check output with default format */
> +	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog show pinned %s",
> +		       test->bpffs_path);
> +	if (!ASSERT_GT(ret, 0, "format pinned prog check command"))
> +		return;
> +	ret = get_bpftool_command_output(cmd, output,
> +			MAX_BPFTOOL_OUTPUT_LEN);
> +	if (ASSERT_OK(ret, "get program info")) {
> +		ret = check_metadata(output, test->expected_output,
> +				ARRAY_SIZE(test->expected_output));
> +		ASSERT_OK(ret, "find metadata");
> +	}
> +
> +	/* Check output with json format */
> +	ret = snprintf(cmd, MAX_BPFTOOL_CMD_LEN, "prog -j show pinned %s",
> +		       test->bpffs_path);
> +	if (!ASSERT_GT(ret, 0, "format pinned prog check command in json"))
> +		return;
> +	ret = get_bpftool_command_output(cmd, output,
> +					 MAX_BPFTOOL_OUTPUT_LEN);
> +	if (ASSERT_OK(ret, "get program info in json")) {
> +		ret = check_metadata(output, test->expected_output_json,
> +				ARRAY_SIZE(test->expected_output_json));
> +		ASSERT_OK(ret, "find metadata in json");
> +	}
> +
> +}

The original shell script also verified the map listing output:

> diff --git a/tools/testing/selftests/bpf/test_bpftool_metadata.sh b/tools/testing/selftests/bpf/test_bpftool_metadata.sh
> deleted file mode 100755
> index b5520692f41b..000000000000
> --- a/tools/testing/selftests/bpf/test_bpftool_metadata.sh
> +++ /dev/null

[ ... ]

> -bpftool prog --json | grep '"metadata":{"a":"foo","b":1}' > /dev/null
> -
> -bpftool map | grep 'metadata.rodata' > /dev/null

[ ... ]

> -bpftool prog --json | grep '"metadata":{"a":"bar","b":2}' > /dev/null
> -
> -bpftool map | grep 'metadata.rodata' > /dev/null

Was the "bpftool map | grep 'metadata.rodata'" check intentionally removed
from the converted test? The original script verified that the metadata map
appeared in bpftool's map listing, which tests a different code path than
the "prog show" commands. If this was dropped on purpose, it might be worth
a comment explaining why; otherwise this appears to be a test coverage
regression.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21225032840

--===============3596951627756990129==--
