Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316593A75A0
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699230; cv=none; b=iKtd0+DGOkcmDZUFXicWQ9dazHc5wL8PlhZlgeygHIodr62ny03N2yW+u9vtTRXqKJTKNSQGgbLVlwq5Tb80ADbtv3c82jGA16L/L4Ze5nh48EACPK+Hr6rnKF4lo+yXHUibbaE+/6rgIBHs6NOWkjUs8drsQjlY3UCZ8t9h/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699230; c=relaxed/simple;
	bh=XtAziFXnH4G6jBDQallWM5Kj7X2Pb0iI5FyXv+OhKLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uOESOYcuxYglETR4UNMNoA27Zx6tVmY+9qisawfJXVSEEC2vVSTKyMjcnalXrnPfatFnGKL5AAecuIXmgmnQPOLAf16qvq6eDot3NJF1rxi8hNQKm5VaF3qOJSJeo63RxsB3rJCo3psRUTwGtUl7/BsEPngPzDpJos2ef63FGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHwScXBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHwScXBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6693CC19425;
	Wed, 13 May 2026 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699229;
	bh=XtAziFXnH4G6jBDQallWM5Kj7X2Pb0iI5FyXv+OhKLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kHwScXBO80bbbXDJuIP+2+CzOCJajbBeEd3agsDWMpLFAuLXV+TqvUmqz9rRy8wTO
	 mL4WvDKYLF0AIscWoqAZxWDAZrZVKbdKOl/PN3byhgJ3dSmga5WysiPycz4DYQ/9pr
	 yye8GSLaKbVMBesKhC8InszC8niMrg4kTQjPRWXlXLYR9ynMxpHbdZTUHlcuxR7dps
	 aLJEoo6zF0uuULZhmnqzaJjgtRI9uFrPj9j3DG68Qh/iXIQCn+LH0KjZMkTHdu5J6y
	 lIkkmTCUp8QojSFJF9HvFkN3+JR6sqGinyABqj5JViVvsxSN8ogrvZVrU6wFG9kUsp
	 O4n9CA15L2rEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 8/8] selftests: drv-net: add netkit devmem
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511-tcp-dm-netkit-v4-8-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-8-841b78b99d74@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:07:07 +0000
Message-Id: <20260513190709.6693CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Uncaught `KsftSkipEx` exceptions in `main()` cause the test to fai=
l instead of reporting as skipped.
- [High] Global NIC configuration changes are leaked if the setup phase fai=
ls, breaking exception safety and corrupting the host NIC state.
- [Medium] The commit message incorrectly claims that `nk_qlease.py` config=
ures the NIC once in `main()` to avoid re-toggling settings.
--

commit daf9f495f84bddbf201c5b6c6297e5e878d7ea77
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add netkit devmem tests

Add nk_devmem.py with four tests for TCP devmem through a netkit device.

> The NIC (HDS, RSS, queue lease) is configured once in main() before
> ksft_run() and torn down in a finally block via cleanup_nic(), mirroring
> the nk_qlease.py pattern.

Is this description accurate? Looking at nk_qlease.py, it does not configure
NIC settings in main(). Instead, it configures and re-toggles settings like
rings and RSS within individual test cases using defer() for cleanup.

Could the commit message be updated to reflect this accurately?

> diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/=
testing/selftests/drivers/net/hw/nk_devmem.py
> new file mode 100755
> index 0000000000000..0e36a0fa96888
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
> @@ -0,0 +1,55 @@
[ ... ]
> +def main() -> None:
> +    """Configure the NIC once, then run the netkit devmem test cases."""
> +    with NetDrvContEnv(__file__, rxqueues=3D2, primary_rx_redirect=3DTru=
e) as cfg:
> +        setup_test(cfg,
> +                   os.path.join(os.path.dirname(os.path.abspath(__file__=
)),
> +                                "ncdevmem"))
> +
> +        require_devmem(cfg)
> +        configure_nic(cfg)

If require_devmem() or configure_nic() raises KsftSkipEx because the
environment lacks devmem support or sufficient NIC channels, will this cause
the Python script to crash with an unhandled exception instead of cleanly
skipping?

Because these functions are called outside the ksft_run() test runner loop,
it appears KsftSkipEx won't be caught, resulting in a non-zero exit code
instead of Kselftest's expected SKIP exit code (4).

Furthermore, if configure_nic() raises an exception halfway through its
modifications (for example, if an ethtool command fails after initial ring
modifications), will this leak global NIC configuration changes?

Since configure_nic() is called before the try...finally block, an exception
here would cause the script to terminate immediately. This bypasses
cleanup_nic() and leaves the host NIC permanently modified.

Should configure_nic() be moved inside the try block to ensure cleanup_nic()
is always executed?

> +        try:
> +            ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks,
> +                      check_nk_rx_hds], args=3D(cfg,))
> +        finally:
> +            cleanup_nic(cfg)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-tcp-dm-net=
kit-v4-0-841b78b99d74@meta.com?part=3D8
