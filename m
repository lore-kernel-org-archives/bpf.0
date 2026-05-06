Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921D212566
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027346; cv=none; b=URhJGSA9hUUtrG7JQLACUi0Nk4tEyPd103Fw1NAKKngwFL4NVzR5cpo9IphASy/8P//TExcdQvMmlAyDpp5PXhLyGDwZxK2hpdI97sMBJqdWH/Cy0zUz+xQWgTg8Y2qU96mrSzW6zFPAT8YwtzYwTTYo+T+9nJ6D+yCk9KtjD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027346; c=relaxed/simple;
	bh=876SENz20ehhDYK305m/BcTmqnVZj/2jpLHfOlhRaSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uDMF2OGVNqimD8MVsat3aV1kvdtnsWa89Sc5fAeAjjESSt2Eh8GzzYW85aAdqlH+6bdbJx9dcWpmlVWI6mH6EdBrx0jBRmv+LyYB/UUqYAntaFqYkQfeuoAC61L5+HRVJm3WLcNS4QmMu6qEueIlRb+O50wK9KdWVY9fpzZqphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQIVhR9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQIVhR9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F3EC2BCB4;
	Wed,  6 May 2026 00:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778027346;
	bh=876SENz20ehhDYK305m/BcTmqnVZj/2jpLHfOlhRaSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nQIVhR9Xo4Vcs5smA78xODfPgwLQx9qzBOHtOpH7U3oBeUYJPUswyRxW5Xn5JKs65
	 hPSWDxr2NiZr9RdRGoIJFkDXprYf600uFMxHK0reUiYEJWqjof1BbcYOTEisjD2wOD
	 PVzx2omT++UmFappIVC4oBVoUeC6RqhcAHi7lJRhQ7zpRzpcTtPEYN4OBLNuHYnHIA
	 iF7wXHoPnu1cdmD+70aen3JoVPHrzxYKwGXdxSPdLhoRejMvTJ5seVKgGZf5MxXEmH
	 9ZToiCZ4uXtNjFs/sGlae8xxjlnupmXcdiToMEYAZJ4j4aWLhUiYvJzuLvgRA8bp94
	 0Oiz4RVOLmHOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/6] selftests: drv-net: refactor devmem
 command builders into lib module
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-tcp-dm-netkit-v2-4-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-4-56d52ac72fd4@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 00:29:06 +0000
Message-Id: <20260506002906.91F3EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The refactored `run_rx` and `run_rx_hds` helpers drop the flow ste=
ering and client port binding arguments, silently disabling flow steering f=
or standard physical NIC devmem tests.
--

commit 0ae7610db2ce14629da2e4367ef33db95c059f70
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: refactor devmem command builders into lib module

This commit refactors the devmem netkit tests to use helper builders in a
library module. It breaks out the rx/tx functions into a shared lib to be
used by both plain and netkit environments.

> diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py b/to=
ols/testing/selftests/drivers/net/hw/lib/py/devmem.py
> new file mode 100644
> index 000000000000..6f8a3f5aae14
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/lib/py/devmem.py

[ ... ]

> +def run_rx(cfg):
> +    require_devmem(cfg)
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

Does this drop the flow steering and client port binding arguments for stan=
dard
physical NIC devmem tests?

In the original code, socat was invoked with bind=3D{cfg.remote_baddr}:{por=
t}
and ncdevmem was invoked with -c {cfg.remote_addr}. The -c flag instructs
ncdevmem to install a 5-tuple hardware flow rule via ethtool to steer
traffic strictly to the specific RX queue bound to the devmem memory provid=
er.

Since run_rx() and run_rx_hds() call socat_send() and ncdevmem_rx() without
overriding their default arguments (bind=3DFalse and flow_steer=3DFalse), n=
o flow
rule is installed for non-netkit environments, and packets are distributed =
via
standard RSS hashing.

If packets bypass the devmem-bound queue, they are processed by standard
TCP host-copy paths. Could this cause the test to silently pass while
failing to actually exercise the devmem zero-copy feature?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-tcp-dm-net=
kit-v2-0-56d52ac72fd4@meta.com?part=3D4
