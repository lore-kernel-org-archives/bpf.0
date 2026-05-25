Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13F33B6EA
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722276; cv=none; b=slzGsvEVGRxZ3Z8ABbjNcT5qqiN5iz4HT83MYfKy+e6PCr/a4lNphdaoJR6KhSCsqWAR9s7Om3Bf+RmNQ25tsDLrKjte2yKNUVKZmqweyC6skh0IVl0X52rtvz+UzNunthSJK6dQmTDSO5H5+XQZh0kJKACVLz6SYezQJJTmtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722276; c=relaxed/simple;
	bh=essyR8KhcxscWTOQNqw1Fi+H16k8mZkMZC3sTbEiJZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ruJbsUZlFtEyOzjHRX8Y8Oam3aalrDe5YwIjzGAU8eEsr8a5UwCV9OOntWVJqqRjB7mAkhi0zDlySVvERaQN99OrrMvdoIG1VB7O+r0s8QpR3pSkI3weLUVZZXzElpTULXlDf7DcnthUhr2+dnXmPStuGFCIywkwPd64q4HTX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlI8PQQG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlI8PQQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035AB1F000E9;
	Mon, 25 May 2026 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722275;
	bh=7eJEUYqvQzGxCvl7eF41LFl2ghO6tKOrWePLHB3b2yE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FlI8PQQG4LpAt8fhnqTZiOw9cBKhsyKJk+l1Rsy2ifv6zFIWX68k0K/P9O0viQciC
	 eoGIqmxlnsm2Z7p5nwF0cNpZXzK+/CvYfOHabn+lUIFU9yAZmAVoA5zQN2bG7TQKFd
	 R0icvcb+7WHnDrxTYRUmdvCVRfcBFgkKS6XaLcLS17Cviso/m/3DSBTdXj0KiNcowU
	 KvOAodv2XOPDwYqUvTGhActgG+VNQGLEnnmu644ExXwu4y7GdtNVNwdROkXZTi3AeZ
	 DgYegtqm8uFn3AOkzsTtnqqBqQNV8nVWfmfNesRNOwnELuXYat6FZwmXxSfusQb563
	 S3doHGaeJVekA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add tests to verify the fix of
 encapsulating VxLAN in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260525142650.2569-3-leon.hwang@linux.dev>
References: <20260525142650.2569-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 15:17:54 +0000
Message-Id: <20260525151755.035AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the modern kernel/BPF comment sty=
le.
--

commit cb1735fb3bcd5263a9150a9e452a94ee09b427e7
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt

This commit adds two tests to verify that the skb transport header is corre=
ctly
set when encapsulating VxLAN using the bpf_lwt_push_encap() helper for both
IPv4 and IPv6.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c b/tool=
s/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_ip_encap.c
[ ... ]
> @@ -538,3 +545,149 @@ void test_lwt_ip_encap_ipv4(void)
>  	if (test__start_subtest("ingress"))
>  		lwt_ip_encap(IPV4_ENCAP, INGRESS, "");
>  }
> +
> +/* VxLAN Setup/topology:

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style? The modern multi-line comment style places the ope=
ning
/* on its own line, with the text starting on the following line.

> + *
> + * NS1 (IP*_ADDR_1)                NS2                  NS3 (IP*_ADDR_4)
[ ... ]
> +	SYS(fail_close, "ip    a add %s/32  dev veth8", IP4_ADDR_VXLAN);
> +	SYS(fail_close, "ip -6 a add %s/128 dev veth8", IP6_ADDR_VXLAN);
> +	/* Standard VxLAN devices to decap the encapsulated packets.  The inner

[Severity: Low]
This isn't a bug, but here is another instance where the multi-line comment
could be adjusted to have the opening /* on a separate line.

> +	 * Ethernet frame uses a broadcast dst MAC so the IP stack accepts it
> +	 * without ARP or FDB configuration.
> +	 */
> +	SYS(fail_close, "ip link add vxlan4 type vxlan id 1 dstport 4789 local =
%s dev veth8 nolearning noudpcsum",
[ ... ]
> +	return -1;
> +}
> +
> +/* VxLAN encap tests (IPv4-outer and IPv6-outer variants).

[Severity: Low]
This isn't a bug, but this comment block also places text on the same line =
as
the opening /*.

> + *
> + * Test 1 - functional: the BPF LWT xmit program encapsulates the packet
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525142650.2569=
-1-leon.hwang@linux.dev?part=3D2
