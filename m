Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31298EED8
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525467; cv=none; b=f6kKubxL7Kx6U253YB/q32GGyPzzyJM/3URDXddBCsb2CxIkVMtHVsklYNnTij1vACaF54V7tMlTGP/ExzssNLa5/k+PsgLAG5t51ipQ84oCK6wECSYOig7qbNzLnekuhsRtWP/FbuSkFVsMrExZBr1tXygU/WilBjzCcbWDIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525467; c=relaxed/simple;
	bh=45i+AwMIxoQKaRmRQ2Hd6AjY+txs14YbO2UTC5ZA3ZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SUou6ALkLc4QnWf4FICvSaD5gqzxycCnNGXfcKKxTXz8WggiXuTSlvd9VdQRGL4Leuque81YivGIyJdkd305ny0byJCSm1igrrjPS3w9zpYNO/FH3xc91VbNVubR2S91PI1lz7BUDwCFZf70hFnqAZEPmfLwlpzUTloyMNHftRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6XHjqty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6XHjqty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44BFC19424;
	Sat, 18 Apr 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776525466;
	bh=45i+AwMIxoQKaRmRQ2Hd6AjY+txs14YbO2UTC5ZA3ZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=W6XHjqty5Pf9flF/BopEq5W4UVTJV+lEuqmq5Hr3uazfpf0XyoSqVS7Atu5ZDfnM+
	 woyTpUfaEwMNvrd1t2JhERbYZ5B4SImfPQPNRgf3ZqioIo0LNV312lxFPk4UZPm3Tr
	 rFhzjP4RXZ0GSBgG68wW+JnQ9EAnczUZRXE1QoloucfKnKRSWxtrDhn7OUMbHfFbQu
	 4UKogGxJZUurTyn1319NKOj7tZWoGJLKmJ1Ys9pmsNLSyrkV/Z3rh2pGe/FZej7dlS
	 X8Dby538NUOXBRmOtctHDlFxNDX/IKdkLpfYP3FybB2xpSwTOJRslJWF95Jv2qohvd
	 1ildGYDGmytLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 5/6] selftests/bpf: add usage example for
 cpu time counter kfuncs
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418131614.1501848-6-puranjay@kernel.org>
References: <20260418131614.1501848-6-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 15:17:46 +0000
Message-Id: <20260418151746.B44BFC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Incorrect and redundant file descriptor validation in BPF skelet=
on test.
--

commit 0a7806f6db918db501677b21fa0e15ae508d1ada
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>

selftests/bpf: add usage example for cpu time counter kfuncs

This commit adds a selftest example demonstrating how to measure the
latency of BPF kfuncs or helpers using the time stamp counter and how
to convert the measured values into nanoseconds.

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c b/t=
ools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
> new file mode 100644
> index 0000000000000..067307f0c4c29
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
[ ... ]
> +static void cpu_cycles(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct test_cpu_cycles *skel;
> +	int err, pfd;
> +
> +	skel =3D test_cpu_cycles__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_cpu_cycles open and load"))
> +		return;
> +
> +	pfd =3D bpf_program__fd(skel->progs.bpf_cpu_cycles);
> +	if (!ASSERT_GT(pfd, 0, "test_cpu_cycles fd"))
> +		goto fail;

Is it necessary to validate the file descriptor here? The BPF skeleton API
guarantees that after a successful open_and_load(), all programs and maps
are created with valid file descriptors, making this validation redundant.

Additionally, if a file descriptor check were needed, shouldn't it use
ASSERT_GE rather than ASSERT_GT? 0 is technically a valid file descriptor,
so if pfd evaluated to 0, this test would falsely fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418131614.1501=
848-1-puranjay@kernel.org?part=3D5
