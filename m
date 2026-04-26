Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E37083C
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232784; cv=none; b=Jb9WU+b2IFHstpLMP3UZd00dVKrUQCDhJyLszlzBV6Hg5/hMKnCBaV0aL15pbmRDgCF7/fkhMo2g4gakilAto6gyEXD5bO8cWMccBUCSt78wBq3h64d2nMt64XC0hxNhGBQid1UXPGklBnF+oPtpgKagraQw2AvRbvrJIaxzSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232784; c=relaxed/simple;
	bh=KekeLiMdd+Eglf2xOo4MmjsefIpqUzS6cVbGYeOCA/M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SuXLMMkawuGmubXictbHy1UviilcgOJX/mbMm7mZxwAU22FaGjqRcI2JWBw8XM+quiT1NQuCsQOVln7OEwZOAlYlPyW/QeqaghY6Lm1kv1s7oNI0+IadZPyBGEokvc/1dHj/ZYBPKXyOFYbhV9h9wnw8teleKz8Mirf4gcWM1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahs/dWUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahs/dWUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22572C2BCAF;
	Sun, 26 Apr 2026 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777232784;
	bh=KekeLiMdd+Eglf2xOo4MmjsefIpqUzS6cVbGYeOCA/M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ahs/dWUZcMihg39w6ZNljXeLaZEGqoKhF+jpB/nT9aJQBR+0dAPd6FNXECpQSSC0B
	 VIJN2SYfGuc+dUczdRKLCBMo/nc9rMJJPKIE1L1ew+KX8ndHy/GdBWzuJYJYhR8BAv
	 o0D4+NcjXpPL928eD6HTIYbAkqO+jfd1M2XHDTRXTsU82qHPAbJLEYn7z2arEqcq+q
	 DpYGQ7hMWyrPRH/EYfJ0tOHQvhd+F+UnS4eaP8LT4AFel3YPXMzFbXBYUSGwBXmMch
	 t/cXfQPJjBI6nYaa4oO/ZcETUHmcfRMtm8DY4VXGaTnvsuIg++x+C4Tha+YVHCX+1T
	 IPF9GPhtTUTxA==
Content-Type: multipart/mixed; boundary="===============7655040983883981349=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <56396e7e296f2a43e1e293c614f9dfc5f74143c7b96dc2506cca69823befd4d4@mail.kernel.org>
In-Reply-To: <20260426190338.4615-9-emil@etsalapatis.com>
References: <20260426190338.4615-9-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v9 8/8] selftests/bpf: Reuse stderr parsing for libarena ASAN tests
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 26 Apr 2026 19:46:24 +0000 (UTC)

--===============7655040983883981349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index c4c34cae6102..ee637809a1d4 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> @@ -789,6 +789,43 @@ static void emit_stderr(const char *stderr, bool force)
>  	fprintf(stdout, "STDERR:\n=============\n%s=============\n", stderr);
>  }
>
> +static void verify_stderr(int prog_fd, struct expected_msgs *msgs)
> +{
> +	LIBBPF_OPTS(bpf_prog_stream_read_opts, ropts);
> +	char *buf;
> +	int ret;
> +
> +	if (!msgs->cnt)
> +		return;
> +
> +	buf = malloc(TEST_LOADER_LOG_BUF_SZ);
> +	if (!ASSERT_OK_PTR(buf, "malloc"))
> +		return;
> +
> +	ret = bpf_prog_stream_read(prog_fd, 2, buf, TEST_LOADER_LOG_BUF_SZ - 1,
> +				    &ropts);
> +	if (ret > 0) {
> +		buf[ret] = '\0';
> +		emit_stderr(buf, false);
> +		validate_msgs(buf, msgs, emit_stderr);
> +	} else {
> +		ASSERT_GT(ret, 0, "stderr stream read");
> +	}
> +
> +	free(buf);
> +}
> +
> +void verify_test_stderr(struct bpf_object *obj, struct bpf_program *prog)
> +{
> +	struct test_spec spec = {};
> +
> +	if (parse_test_spec(NULL, obj, prog, &spec))
> +		return;
> +
> +	verify_stderr(bpf_program__fd(prog), &spec.priv.stderr);
> +	free_test_spec(&spec);
> +}
> +

The verify_test_stderr() function hardcodes the use of &spec.priv.stderr.
Since it lacks an unprivileged parameter to select the unprivileged spec,
any expected messages specified via __stderr_unpriv() might be silently
ignored.

While this doesn't affect current libarena tests (which don't run in
unprivileged mode), it creates an API inconsistency. The function defines
__stderr_unpriv macro in test_progs_compat.h but doesn't actually verify
those expectations.

This concern was previously raised in v8 by Sashiko AI:
https://lore.kernel.org/bpf/20260421221653.75221C2BCB0@smtp.kernel.org


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24964771851
--===============7655040983883981349==--
