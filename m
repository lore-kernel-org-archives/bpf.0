Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04639318EE2
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823485; cv=none; b=PRzvu2hW790K5DD0ufEpEMRMK/5tJ7aEbf0YIIEfbMOkJjezX2RFI4e3DIHZQFYVaPqsCY2w8M/l4HeaYD6uD7HaIbMv3RFi1WV2NKr9OTvM1zscXQj6+OgTjsrKyWLFhBDEGzpHLPK825Tg3WmBbUnl8Qt4oNci3nCdtRS6PIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823485; c=relaxed/simple;
	bh=yNwsXwP2iC8mNINa9AZ4QLRWCzQX6aAsEz16WvbyXwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UQEDHYqS2wJ8EIY3q5ayhVBdV9vnqUFp0u6xVSve3RaIM0RTSdnEQDEd1vALSw5flU9By2kE+lv61ptquOylpBJN2Jy6ELWBXzWQrX3+sWk/CuZtNuNVeKbfwnzXFr+4OWsezG+yCNTeLlG4UXF2FIHqJ+CkKEg20qsQaH4zJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDtvui2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDtvui2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843F11F000E9;
	Tue, 26 May 2026 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779823483;
	bh=VtkR4rbDeG8bpdxoNkMFftkSPfZqWtwKnaIe+WMwjqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VDtvui2TkwiX8dkPqBM4RvOpTD3Mv8boECwH/CNjKEdzm8zalAgS+rwME19DaAECR
	 7Q64dBo+akAasyZ3Rd3YV4+IvvSn0iCEC8MbQQrQFOS2taiApiy8icbQA2qDQFTa4P
	 zRbYdIg95btVOWRNhCbJrkLmFYuAEleTr2V0/sOyePMwEaCzCAZCfgb4dSBhgbqx83
	 v1ghG0AY4Z+taDUYpOCCeb+5rtHW4wZNwxDf2rCvhjT3DTHx1R2elr25O2hm+zpes8
	 4S39WVIFU9yN8RqfSDfFwyxbTW7SqpMzdOBOoSqHDntDopbEC+okMec4LMwY7V9Nmv
	 U+TnhM/wik6PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 4/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526153708.279717-5-mahe.tardy@gmail.com>
References: <20260526153708.279717-5-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:24:43 +0000
Message-Id: <20260526192443.843F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF subsystem style.
--

commit 67ff0f6d65a210627d2fdadf8ec80c32d95d6a59
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests

This commit adds a test for the bpf_icmp_send kfunc using a cgroup_skb
egress program. It verifies that ICMP unreach messages are correctly sent
back to the client and read from the socket's error queue.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> new file mode 100644
> index 0000000000000..0dc6b6ceafb4a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> @@ -126,10 +126,10 @@ void test_icmp_send_unreach_cgroup(void)
> +	for (int code =3D 0; code <=3D NR_ICMP_UNREACH; code++) {
> +		/* The TCP stack reacts differently when asking for
> +		 * fragmentation, let's ignore it for now.
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
kernel comment style for the BPF subsystem? The style guidelines require
the opening /* to be on its own line.

> +		if (code =3D=3D ICMP_FRAG_NEEDED)
> +			continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526153708.2797=
17-1-mahe.tardy@gmail.com?part=3D4
