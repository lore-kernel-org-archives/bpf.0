Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAB3E168C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915657; cv=none; b=P7Pa8P7VSklzxjPXPd7vWoINb8J3TScHeZfmov4l1XVCM2j+hTrlJW+4avDi7kCJ+zBoQ6THskYTD5zcVAoFw8NNkvwBiFp26D/ok1pOyEt9aqI4U9hhkc91FPZWAiFCJodEhwo4ViHP3dCrKNt8Q8F71Oa6HEs3DgeBCgLBGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915657; c=relaxed/simple;
	bh=qcZEcfd1jZXrLWsou7LjpnE9j6o02bk4zq6F+7vh+OM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T/nmmtlwUpyq6qJCCGdjeiOwcHEHlYxerZ7x0oym3qQSFbl2VlI1rLwrVU+p5VgEAG5pZfzwOq2zcK6yYovzyrGpFRj2YH9op+eZu+i29PVLCeDBDKq/l8VsA9yotHT27kenQJxpbOoBH3PNwUfMmNlQrBxiCTADgGzzFATmjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGfWHbZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGfWHbZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B091F000E9;
	Wed,  5 Aug 2026 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785915655;
	bh=iuiWk6wzoOhlJ7DCLmTqnoZ9MuUVYqe8+zp2SVQddQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGfWHbZ9rQTZJAfz7K1ARVmsPEbgP9QvD7Ld+3Y0A6vaM+ACjam/fWvWOrwRukmaL
	 yQnC4BhFLyx/n7QOhKSx/Fu1wr/9Dqww9Rsf0UudZTHIW6a01NhQdF/n8O3DTzGRDp
	 q4xy/8Fsb4sm/qf2brSWYi4Hr407RLWL9bmap/Tw8vCqfPkJWVeW9vuWpI+S4bghqq
	 CdZvOmzMzWOLfLM+iwhfG+uRY7on7UpbmGSqIRuim6QhU5zCK1FiD+QrSdQm8hz07t
	 3e3bvDWniU3pRIHbr4ouRAGaT3Dr1+WRyW7N9+QlOGuYbaOoq8GhRWzTD0DMb6TPgc
	 qmvdkaE4o7K/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Track test_xdp_features DUT
 processes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bochao Cao" <bochaolucky@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805-xdp-dut-process-lifecycle-gmail-v1-1-45984df8d295@gmail.com>
References: <20260805-xdp-dut-process-lifecycle-gmail-v1-1-45984df8d295@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:40:54 +0000
Message-Id: <20260805074055.59B091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The test script deadlocks indefinitely during cleanup if terminate=
d while the DUT server is blocked in I/O.
- [High] The cleanup routine sends `SIGTERM` to historical PIDs that have a=
lready exited, risking the termination of unrelated host processes if PIDs =
wrap around.
--

--- Patch [1]: [PATCH bpf-next] selftests/bpf: Track test_xdp_features DUT =
processes ---
commit 3a3cec0883174021af4192cc572fb4e4f76dbd7c
Author: Bochao Cao <bochaolucky@gmail.com>

selftests/bpf: Track test_xdp_features DUT processes

test_xdp_features.sh waits for any xdp_features listener to appear and
uses pidof during cleanup. A concurrent test can therefore make another
test proceed before its own DUT is ready, and cleanup kills every
xdp_features process on the host. Record each DUT PID when it is spawned
and only terminate and reap recorded children.

Closes: https://bugs.debian.org/1136522

> diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/tes=
ting/selftests/bpf/test_xdp_features.sh
> index 0aa71c4455c05..f3aa4d1d52be2 100755
> --- a/tools/testing/selftests/bpf/test_xdp_features.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_features.sh

[ ... ]

> @@ -31,32 +32,53 @@ setup() {
>  }
> =20
>  cleanup() {
> -	ip link del v1 2> /dev/null
> -	ip netns del ${NS} 2> /dev/null
> -	[ "$(pidof xdp_features)" =3D "" ] || kill $(pidof xdp_features) 2> /de=
v/null
> +	for pid in "${dut_pids[@]}"; do
> +		kill "$pid" 2> /dev/null || true

[Severity: High]
Does this risk killing unrelated host processes if PIDs wrap around?

The script spawns a background xdp_features process for each test and recor=
ds
its PID in dut_pids. During a normal test, the tester process sends a
CMD_STOP, causing the DUT to exit cleanly, at which point the OS reaps
the PID.

At the end of the script, cleanup blindly loops over all recorded PIDs (most
of which have already exited) and unconditionally executes kill "$pid". If
the system is busy and any of those freed PIDs have been reassigned to
unrelated host processes, they will receive SIGTERM as root.

> +		wait "$pid" 2> /dev/null || true

[Severity: High]
Can this script deadlock indefinitely during cleanup?

If the script fails or receives a signal, the EXIT trap runs cleanup, sendi=
ng
SIGTERM to the DUT processes and calling wait on the PID.

The xdp_features server uses glibc's signal(), which defaults to SA_RESTART:

tools/testing/selftests/bpf/xdp_features.c:main() {
    ...
    signal(SIGTERM, sig_handler);
    ...
}

When the server receives SIGTERM, its handler sets exiting =3D true, but the
blocking accept() or recv() syscall is automatically restarted by the kerne=
l.
The server remains blocked forever and never exits, causing the script's
wait to hang indefinitely.

> +	done
> +	ip link del v1 2> /dev/null || true
> +	ip netns del "${NS}" 2> /dev/null || true
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-xdp-dut-pr=
ocess-lifecycle-gmail-v1-1-45984df8d295@gmail.com?part=3D1
