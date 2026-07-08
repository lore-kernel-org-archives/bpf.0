Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240C334C2E
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480140; cv=none; b=pDfS5hF6ZCijOWwGP2cx+i39C7XvOx1WTAR/dKM08kD0bY5YqersiNdM7MHGkWFs/utkloXA4tyRlpadAf+TNiBzfpNgX6B9ri8Fd/wLIp9kWKK0T8PFGFgvoRlYOTknVa5Sh7UdF1IjgsMw1TckYqf+dff4SJmFxuUzTeNpvik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480140; c=relaxed/simple;
	bh=sjNFOC/OWgAvkJeODPACD+S9ts9MxeNi8qWQKEObbQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CP0MeTe7u3lkjg5AcC4XI7LxjCjdpbfLcKkJrEQcwFD7yoOi1L1di5sfg//2N1HkItfdhncoLR/TQuvmbIxp4WzYO8jWjQ9b6wViDnTCPx54sEb+vPSHjH7jSkh8SHfH0pSu2I8hNtGUrqod5UDoCeuX5nLYb9cWqd4SkKXILYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcN4RwuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcN4RwuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F8E1F000E9;
	Wed,  8 Jul 2026 03:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783480139;
	bh=AHm96Iv1Vl8dAmoNlbYxPY1I7gG2EwHCD5SdCP6sQ3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fcN4RwuLJog3mDgj36km5gRzetcfaldmUPQE3CVT1jHDAUugB0nDpFADM2GxsJ/6+
	 tTZScC/HfX8izg6ocVr8h+WkmWY38h7vuEcnDTx/bPaQLlHVMwzTXGGDgTjWvmuomA
	 rlpWMOuLD2/GgIjNn7hobVd/k6cnFIkiyhLatjNQ96PVjxB2uHohKITcrAhyxc9enE
	 yhBCrns3u5lWsZMlCO7V6H+xae8+pxIK+LpVOJxXZI/w5/sw1YS41dVNPFfz7stSjd
	 5V3HMnLZJ6cRy8jvPO8BKKfV2rkmKOpdtUS2we2zh5kL7YQONXWghvVFIy4PdkvUIH
	 L3v3O8wwa/J3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add XDP dispatcher FineIBT
 regression test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
 <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:08:58 +0000
Message-Id: <20260708030859.10F8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test modifies global host networking state by attaching an X=
DP program to the loopback interface, but is not serialized or isolated in =
a network namespace, causing race conditions in concurrent CI test runs.
--

--- Patch [2]: [PATCH bpf 2/2] selftests/bpf: Add XDP dispatcher FineIBT re=
gression test ---
commit 5a870a8bf864ee8b6c4ae366f0fe61e22b615aee
Author: David Windsor <dwindsor@gmail.com>
selftests/bpf: Add XDP dispatcher FineIBT regression test

This commit adds a regression test for the x86 BPF dispatcher's indirect-ju=
mp
fallback under FineIBT.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineib=
t.c b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
> new file mode 100644
> index 0000000000000..2d3fc4034eb90
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c

[ ... ]

> +#define IFINDEX_LO		1
> +
> +void test_xdp_dispatcher_fineibt(void)
> +{

[ ... ]

> +	attached_fd =3D bpf_program__fd(skel->progs.xdp_dispatcher_attached);
> +	unattached_fd =3D bpf_program__fd(skel->progs.xdp_dispatcher_unattached=
);
> +
> +	err =3D bpf_xdp_attach(IFINDEX_LO, attached_fd, XDP_FLAGS_SKB_MODE, NUL=
L);

[Severity: Medium]
Since this test modifies the global loopback interface by attaching an XDP
program, and lacks the serial_test_ prefix or network namespace isolation,
could this cause flaky failures in other concurrently running tests?

By BPF selftests convention, shouldn't tests that modify global networking
state either be isolated in a dedicated network namespace or use the
serial_test_ prefix to guarantee sequential execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c5a6bff16c0885d3ec7=
56a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com?part=3D2
