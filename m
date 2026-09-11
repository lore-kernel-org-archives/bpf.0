Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7C2367DF
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139020; cv=none; b=MKBMGiI4VFLki6TDh/zLgEcHf2vcqcwV++l1wKKeWlSOoDXNyHcu17G+wLOk82N+Q0v31xfVnqKeXRFNMuR1LOWHqXIovGeCBh84WwADUtf2PRMF/mj/m1/Uf7M/0kUB0w6+LURPKnTZ0Peh26fcvJ1za0v9lmpaf2i9VuDFHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139020; c=relaxed/simple;
	bh=JO+5n8hG5JknT1/U5zJROQW8bPuKleUoXc/H4G0sZCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3/DOIE2fsXS5nCyLQtK5zoXKYTxL5t4P3na454VfpstOQ/7+He9vfRK6ewHQCVLbU7K/cypeLeBCW3AqDLDN5TiHdM0ZjpjwFS7rcvdy9+24p2NasqgztgJgpeyI7HcNs6HM5ACnMdm9QXcybF9zhiJjGhAyyL3CLzeaD6qJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA61Uj/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA61Uj/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D3E1F000FF;
	Fri, 11 Sep 2026 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139018;
	bh=ul2vq3r/L3Jv3Id6xsAHaMi2HSbvfbJp82FgIITMgzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EA61Uj/H6ismsgy5lri8LNU1qrMA7QdiVNHZOkPbgSn3V6jKHarrzZG+/7JDjbOB3
	 +ZpF5+JHCjaUX89mEJVR/wrUXW27Ma6n4vAweG4FePCTRzIysl5Mpn7EtGowQo43ho
	 GZpzA62X1QrI56fdvrObG9I2zCThuA0sSJgFFTAgNITeb0cHVlWJTMmOpO+PQvojzo
	 uAzRmuGri2O8Ua18JOJsbhnrxQx9ssan4pMreC8ViJRcuRDupa6jsKxpbpzTu9Tqty
	 5WGogl7zu0/YZkIcMhEOUwV7VH9dL6UQ4r1etKAteg1RtdvvOcI3aZUx0XWSs9eeIZ
	 3Eh01uVa3YSVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Replace %pK output with 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911145011.kErTVDkS@linutronix.de>
References: <20260911145011.kErTVDkS@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:03:37 +0000
Message-Id: <20260911150338.91D3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect replacement of `%pK` with padded format specifier `%8d` f=
or UDP sockets causes a mismatch with native `/proc/net/` output.
--

commit c1f7209e53e018927a70341e583a110e2a63d48e
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

selftests/bpf: Replace %pK output with 0

This commit replaces the %pK format modifier with 0 in BPF iterator tests to
match a recent change in the networking subsystem. The socket pointers are
removed from the output formatting to align with native /proc/net/ interfac=
es.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_udp4.c
> index 23b2aa2604de2..9b789f09f1462 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
> @@ -57,13 +57,13 @@ int dump_udp4(struct bpf_iter__udp *ctx)
>  	BPF_SEQ_PRINTF(seq, "%5d: %08X:%04X %08X:%04X ",
>  		       ctx->bucket, src, srcp, dest, destp);
> =20
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK =
%u\n",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %8d =
%u\n",

[Severity: Low]
Does this %8d format incorrectly pad the 0 with spaces?

The networking subsystem replaced %pK with a literal 0, but replacing it wi=
th
%8d here in dump_udp4() causes a mismatch with the native /proc/net/ output.
Since BPF iterators are designed as exact drop-in replacements, could this
mismatch break parsers that rely on strict spacing?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_udp6.c
> index c48b05aa2a4b2..9766eff7069ff 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
> @@ -65,13 +65,13 @@ int dump_udp6(struct bpf_iter__udp *ctx)
>  		       dest->s6_addr32[0], dest->s6_addr32[1],
>  		       dest->s6_addr32[2], dest->s6_addr32[3], destp);
> =20
> -	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %pK =
%u\n",
> +	BPF_SEQ_PRINTF(seq, "%02X %08X:%08X %02X:%08lX %08X %5u %8d %lu %d %8d =
%u\n",

[Severity: Low]
Is the use of %8d here in dump_udp6() introducing the same formatting
mismatch as in dump_udp4()?

It seems it should use a literal 0 instead of %8d to exactly match the
networking subsystem's native output format.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911145011.kErT=
VDkS@linutronix.de?part=3D1
