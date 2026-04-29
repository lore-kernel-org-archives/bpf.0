Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B75349B0D
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502612; cv=none; b=IbrHYEQuAjsZoqr+yJzgSInImhQ+j+LVz5OaOm8HPnjD8NvTOlj10/JcDM52fwtVW3fiPv5HeaL30VXxbRuiuHrQDILRDy7rv+BPPlBrMNy4SV4zA3EAhB40qy4+f9AbftOEleUHcLIba4SJCmnzJBq9YAV+ntJbOBuSioKun4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502612; c=relaxed/simple;
	bh=Zds3eFcp5U20grtyUYjYx8r2VuIXRd0+IynPt6adMbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VVhiSnKd0J0pLlsh+M4DwINzHExBiMNwsMVeCyQ2zZ2kDgPz+ZMddpXVFvkbu5RweQAZG+0iMzlrqYZ7nPG1LAO+6YT3Xant5OeSZX9dwSL94uR/XAIxoJl1+RBrvfJQ7RSfkrtvUzWNPl1qWdoSPiq6zP1UaDV/4sTNy6TrqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFbXkA5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFbXkA5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8A9C2BCB4;
	Wed, 29 Apr 2026 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777502612;
	bh=Zds3eFcp5U20grtyUYjYx8r2VuIXRd0+IynPt6adMbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aFbXkA5YkcH8kUDsz6/Mn4y9nbaPgGVonUEESayrXE55n0npFRE9y8wSicCAKxoj6
	 OlCFbc2+Zr0u9AQ05CFI1G4vgmCjWsX/JXDe7NqhMz+UgvcjRRRPtBodd9raADy7zB
	 9MproTP2cihydPdf2rlGOHmtK9QbRkA6bMnrstXG6YeMVcbz7VbuI7cyof0mRBrxH+
	 tB0Op9oddp4uVunC7//3hUgqZzQx733InOQDUX5Ku5oNKOdqdlRjYtb/PZu4jxPh3V
	 c96GNwwyIa8L1HWlIaoUSH3+oSj10nnkBOBd/fGmgwShk7zyBEHV51EG46omDFUIij
	 A0yTS5SVwwafA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 09/11] selftests: drv-net: refactor devmem
 command builders into lib module
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-tcp-dm-netkit-v1-9-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-9-719280eba4d2@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:43:31 +0000
Message-Id: <20260429224332.3C8A9C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing TEST_FILES entry for new python library file.
- [Medium] Uncaught KsftSkipEx exception causes test script crashes instead=
 of graceful skips.
- [Medium] Silent test coverage loss: payload validation and hardware flow =
steering are disabled for the plain environment.
--

commit 5feef3ad6211668eb3cfa3fef7cca6cbdcb65a36
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: refactor devmem command builders into lib module

Adding netkit-based devmem tests is a straight-forward copy of devmem
test commands plus some args for the nk cases, so this patch breaks out
these command builders into helpers used by both.

> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/tes=
ting/selftests/drivers/net/hw/devmem.py
> index ee863e90d1e0..33648e39577a 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py

[ ... ]

> @@ -76,14 +42,9 @@ def check_rx_hds(cfg) -> None:
> =20
>  def main() -> None:
>      with NetDrvEpEnv(__file__) as cfg:
> -        cfg.bin_local =3D path.abspath(path.dirname(__file__) + "/ncdevm=
em")
> -        cfg.bin_remote =3D cfg.remote.deploy(cfg.bin_local)
> -
> +        setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem=
"))
>          ksft_run([check_rx, check_tx, check_tx_chunks, check_rx_hds],
> -                 args=3D(cfg, ))
>      ksft_exit()

By calling setup_test() directly in main() before ksft_run(), does this
prevent ksft_run() from catching the KsftSkipEx exception that is now
raised inside setup_test()?

Previously, the require_devmem() check was inside individual test cases,
where ksft_run() could safely intercept the exception and emit a standard T=
AP
SKIP message. It seems this might now abort the script with a Python
traceback on systems where devmem is unsupported.

> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py b/to=
ols/testing/selftests/drivers/net/hw/lib/py/devmem.py
> new file mode 100644
> index 000000000000..e95fc38337fa
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py
> @@ -0,0 +1,215 @@
> +# SPDX-License-Identifier: GPL-2.0
> +"""Shared helpers for devmem TCP selftests."""

Since this patch creates a new shared Python utility file that is imported
by test scripts, does it need to be added to TEST_FILES in the subsystem
Makefile?

Without a Makefile update, tests may fail with a "No such file or directory"
error when executed from an installed location after running make install.

[ ... ]

> +def ncdevmem_rx(cfg, port, verify=3DTrue, fail_on_linear=3DFalse):
> +    if hasattr(cfg, 'netns'):
> +        flow_rule_id =3D set_flow_rule(cfg, port)
> +        defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
> +
> +        ifname =3D cfg._nk_guest_ifname
> +        addr =3D cfg.nk_guest_ipv6
> +        extras =3D f" -t {cfg.nk_queue} -q 1 -n"
> +        if verify:
> +            extras +=3D " -v 7"
> +    else:
> +        ifname =3D cfg.ifname
> +        addr =3D cfg.addr
> +        extras =3D ""

The commit message notes there are no functional changes to the existing te=
sts,
but in this else branch for the non-netns environment, extras is
unconditionally set to an empty string.

Does this ignore the verify=3DTrue argument and silently disable the "-v 7"
validation flag, skipping payload validation?

[ ... ]

> +def run_rx(cfg):
> +    if hasattr(cfg, 'netns'):
> +        configure_nic(cfg)
> +    port =3D rand_port()
> +    socat =3D socat_send(cfg, port)
> +    data_pipe =3D (f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | head -c 1=
K"
> +                 f" | {socat}")
> +    ns =3D getattr(cfg, "netns", None)
> +
> +    listen_cmd =3D ncdevmem_rx(cfg, port)
> +    with bkg(listen_cmd, exit_wait=3DTrue, ns=3Dns) as ncdevmem:

In the original check_rx() test, the listen command included
"-c {cfg.remote_addr}" and socat used the "bind" argument.

Are those arguments intentionally omitted here? It looks like dropping them
removes the 5-tuple hardware flow steering setup present in the original te=
st.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-tcp-dm-net=
kit-v1-0-719280eba4d2@meta.com?part=3D9
