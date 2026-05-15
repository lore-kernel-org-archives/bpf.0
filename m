Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729973DA7EE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865797; cv=none; b=reAUj/I1GhjMxPRw2YXrYPe0t1HBveSSALQXk1JOer0jZ4GIuIxzCFeUK6o1cyD5PV7U6jEQJe8D01otLl6xCucSJIXa6nIpbR0vZuMyRhLXqPfpt2r6tlSJ9RCTafOh/VLHJtoloDh7xBWYrkJtDiNSTFzynnUd8sRr/g1FS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865797; c=relaxed/simple;
	bh=yZOTde1ellY+/v76AyqQbpcBfixPidjBMyQS7ssTF38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZiBCVX3iekmenmtc7RaXhOYH6UdxEJaENxvq5Ll9WeYCnIsjf4xN4F4BYyPWjfkYnuHgy2t9W6l3HMxtgWovNAogn53LviFQktfBnUHpZoNqD1Og01nAHkztXiVSOx+BDWoNeDekIMzYKZpBt3HGf4Q1YYEJ3NPgpW4NHdob9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNZjsuJq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNZjsuJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B7BC2BCB0;
	Fri, 15 May 2026 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778865797;
	bh=yZOTde1ellY+/v76AyqQbpcBfixPidjBMyQS7ssTF38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pNZjsuJqyumxzu8o3d8ORZQZYJm2Sk6gqq/9TW63FXE6niaeheIG7/9xHN1jnMDq8
	 dVkzg/KhQFr+92rLPSbch0OdEVixIc7AF1//xSFs0+FDT71KEnImdVObHDAzVX2iPa
	 MfJLapSerkhW1Ewy6lsUCQA33PkZDvOIZkz1MIS7V6NBphpZvUBwt5NbR0y9Xm+NDe
	 +OPi7JxTMXEduBpW/DG7Tm4xBd5pl2S2KggCmhghveuzolzGX2anQzurIDbshv5J7R
	 4+MZV9K+EZ+6f9/Na6vN/L5mN6JyzmPOOlB2QCQPeYafIsHc5UWwjPhnilBz+beNrG
	 C7H5XnFq6vcsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 8/8] selftests: drv-net: add netkit devmem
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514-tcp-dm-netkit-v5-8-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-8-408c59b91e66@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 17:23:16 +0000
Message-Id: <20260515172317.28B7BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test function `check_nk_rx_hds` is missing the `@ksft_disrup=
tive` decorator.
--

commit 6b7595d97efcd40188639cc504f84e6faae25b3e
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests: drv-net: add netkit devmem tests

This commit adds nk_devmem.py with four tests for TCP devmem through a netk=
it
device. The tests duplicate the original devmem tests with adjusted paramet=
ers
for the netkit environment.

> diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/=
testing/selftests/drivers/net/hw/nk_devmem.py
> new file mode 100755
> index 0000000000000..300ed2a70ab44
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py

[ ... ]

> +@ksft_disruptive
> +def check_nk_tx_chunks(cfg) -> None:
> +    """Run the devmem TX chunking test through netkit."""
> +    run_tx_chunks(cfg)
> +
> +
> +def check_nk_rx_hds(cfg) -> None:

Should check_nk_rx_hds() also be marked with the @ksft_disruptive decorator?

Since run_rx_hds() configures NIC hardware parameters (HDS, RSS, queue leas=
e)
that bring the interface down and up, it appears this test will disrupt
network traffic.

Without the decorator, this function bypasses the framework's test filtering
and will run even if the user explicitly disables disruptive tests.

> +    """Run the HDS test through netkit."""
> +    run_rx_hds(cfg)
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-tcp-dm-net=
kit-v5-0-408c59b91e66@meta.com?part=3D8
