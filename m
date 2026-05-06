Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41082211A09
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027348; cv=none; b=RVMwfCTefKCNsiVULdLpSvyO3xbDhnK/Pc+h1RDXFhEH+GeiSEEieSAm3wOmq7v8EkyYYFhF5bN0+4n6C9UO/Dwmu03aD0xYEkDd9Dco06/BwatLfSMZ+B5aoqB8utfRPQnl4l9/pRsTkmNX4F6K2Wye+cJRxgHtI/LYQh35cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027348; c=relaxed/simple;
	bh=/22O00oV0cR0jP4TbB5wl+W6nRhjs9EeVoldHSYTCAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5AGEPjz9JeGw7IhsFtvn/DMfTgIufqlNXFLC1IMxi/g41fbKuFCxMvYuVeleTUJwjRtDzLluuwj+rAFLWsXghuK02WZWLJEKXfrFzTGHMj4e4zni5Twxa8evY4c3pBib3ON6CxRK2UNnfa9X5lldoA1G11zp/RryV9DJaFMcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rajs8tp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rajs8tp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06754C2BCB4;
	Wed,  6 May 2026 00:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778027348;
	bh=/22O00oV0cR0jP4TbB5wl+W6nRhjs9EeVoldHSYTCAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Rajs8tp5EsnXe9EEPTtUOtINxcihg2XBjDGyFzOe3iEp6kBqqXKCyfhXXYmzi3Y3V
	 JYZWNyXkk/NM2xPFS+AV5/8+XFXplNr0Z3QTo+20nqcbPkHXBQTtmK9oLCXgtbSH5e
	 vhQlmhVldZoVeYwwfhRjDAwaCSCyyAIyOfJvI4RAgmMi7wTtqCPM+ocuGk2v+Y4o2h
	 G844ASzTUv0E5LwWYVfnspC7JxsIPJhVK02HdsFG3AkwN7gAj2AmBa4O7th2oJwjoA
	 0/c2o8tF+mTorGpQIoZNp08aMRi2eGWX9dyogstGyc0M0mWYplh8eJos45o02NF9hT
	 IbMXrPcO3HiLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 6/6] selftests: drv-net: add netkit devmem
 tests
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-tcp-dm-netkit-v2-6-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-6-56d52ac72fd4@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 00:29:07 +0000
Message-Id: <20260506002908.06754C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The path to the 'ncdevmem' binary is incorrectly constructed using =
string concatenation instead of `os.path.join()`, which breaks script execu=
tion when run without a path prefix.
--

commit 39598108535535c8a8daee8f3c206760a98e0c68
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add netkit devmem tests

This commit adds a new Python script to test TCP devmem through a netkit
device. It duplicates the original devmem tests with adjusted parameters
for the netkit environment.

> diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/=
testing/selftests/drivers/net/hw/nk_devmem.py
> new file mode 100755
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py

[ ... ]

> +def main() -> None:
> +    with NetDrvContEnv(__file__, rxqueues=3D2, primary_rx_redirect=3DTru=
e) as cfg:
> +        setup_test(cfg, path.abspath(path.dirname(__file__) + "/ncdevmem=
"))

Will this path concatenation fail if the script is executed manually without
a directory prefix?

If __file__ evaluates to just the filename without a directory,
path.dirname(__file__) returns an empty string. Concatenating an empty stri=
ng
with "/ncdevmem" results in the absolute path "/ncdevmem".

When this happens, the script will attempt to execute the binary from the
system root directory instead of the test directory.

Would it be safer to use os.path.join(path.dirname(__file__), "ncdevmem")
here to handle empty directory strings correctly?

> +        ksft_run([check_nk_rx, check_nk_tx, check_nk_tx_chunks, check_nk=
_rx_hds],
> +                 args=3D(cfg,))
> +    ksft_exit()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-tcp-dm-net=
kit-v2-0-56d52ac72fd4@meta.com?part=3D6
