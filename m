Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2A2E62B3;
	Mon,  7 Sep 2026 02:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747682; cv=none; b=aLPO2+2NDTEYjgf+/KPXVNHEhfvtIaljhKSY8ZiD6LdEDVR9H2MJrhiw3mp2qlufcBO2BwyfKnrpKMgzd7+yPogiGXLP81Hag4ltv7mTuOBpUq0/N4SdodzZDpMtoo8kRpYLFsO27/KZtYR0F7/qLv8M/Xr/TYnQi5XqDNLhf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747682; c=relaxed/simple;
	bh=ws7gxeHQDrnTax5VzBWWyEB2r1KH9p7KoSxpVrfDgjI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PKJYz5trGel9hepMrh+sS3Sz5IeXv7nhRvVvRv5mnxckO+IXb59Acow7tBIEP+8Eq0pyamDSDFYJDLE9DZ77Dr2Nx5HeJB+Q11FY7/c5nQ2JnALcKda3QYaYDdeG4qfOvVZsH8XUjTxPtAJ+HLVTV1ng0M7puqCOw0GEhZ6UDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR/0o/7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR/0o/7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA3D1F00A3A;
	Mon,  7 Sep 2026 02:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747680;
	bh=yLpupu9SILJ/9A4Edt/xwKO4fWRd8v4TF4voOjLeGuk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RR/0o/7aGcFePxOJTaJLT52/CrsTHYjASDOHSQs0w9CIp+KTSKjgkKKg8QJD0S+95
	 7b1J6yrMWzgFT7IwkZ4HNUdqlFyQFy6Lt/f6d5+WcbrA9KccMaJWE7wtrT52yGMSCI
	 GQEEWwmEcS9OindeCQtMx+vFgK9ddfun/h8F1g9I7tcMu2KkoNNATYah411tWuch+p
	 //JPB6xnkO2nTiW7imRO9bdjh3wrk5/6uW473aLm8TdEuFbLb6fXZBGpXmMkhgghcP
	 TWtI8dHxIPjjNP8Ol6Ll/mlNVhpwn//ednxW/BeFBWx4hviU4Nfg9h1DR8rnZCFIOF
	 8rvYqLtXYwsKA==
Content-Type: multipart/mixed; boundary="===============4929581208872793007=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0f83aa30c83e841418eaee2d442a193f73720c3e9288298ed6484e9b0d9c8b8@mail.kernel.org>
In-Reply-To: <178874362960.1415955.11629203769007485967.recursive-v3-2@tychen.cc>
References: <178874362960.1415955.11629203769007485967.recursive-v3-2@tychen.cc>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover recursive bpftool map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:21:20 +0000 (UTC)

--===============4929581208872793007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> index 000000000000..9c88743a8f84
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> @@ -0,0 +1,465 @@

[ ... ]

> +static bool dump_map(__u32 id, const char *options, char *output)
> +{
> +	char command[MAX_BPFTOOL_CMD_LEN];
> +
> +	snprintf(command, sizeof(command), "%s map dump id %u", options, id);
> +	memset(output, 0, OUTPUT_SIZE);
> +	if (!ASSERT_OK(get_bpftool_command_output(command, output, OUTPUT_SIZE - 1),
> +		       "dump_map"))
> +		return false;
> +	/* The helper doesn't terminate or strip the output. */
> +	output[strcspn(output, "\n")] = '\0';
> +	return true;
> +}

Is the comment accurate?  Looking at the helper's implementation in
tools/testing/selftests/bpf/bpftool_helpers.c, get_bpftool_command_output()
forwards to run_command(), which on the capture path does:

    if (!suppress_output) {
        n = fread(output_buf, 1, output_max_len - 1, f);
        output_buf[n] = '\0';
    }

Since dump_map() always passes a non-NULL buffer with a non-zero size,
suppress_output is false, so the helper does NUL-terminate the buffer.

The strcspn() line is only stripping the trailing newline, not adding
termination.  Would "The helper leaves the trailing newline in place"
be more accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34073252721
--===============4929581208872793007==--
