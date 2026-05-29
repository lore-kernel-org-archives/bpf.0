Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1F3A7849
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073317; cv=none; b=W09S/38/0QfoHzcJ1oUuI589eyrXRGDKJgHWOscYD0RjnblfQ+6P1c19VcikyZRWnPfnMjIdEWG5CZxc25u4LlOczEz33hqzscpWd6Tm2TWcWZlBlK/HlRQZvY0IveXJi24cuJ4ibWUsi5aOflqo7Ai8BAqYv0xrAajiHcb8iAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073317; c=relaxed/simple;
	bh=LAbTzmQ3sbqweXzQHOMOMYVyE8Qlir2z4hhSj71QCR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EyB8av2NioNirPEh3TatzNhBcQtLnTgsotjiXaRQHPFT6GtPU6DaXfipFvjDXdWejdbTnfbb8hgXwTF7BrWrw6vDggh5AhRkh+cpsXX9WgoD+0pOJ6xACXWAnTB2MURSib3JmAKJ/2ijmxnPikrVWPDfh/Nf2sMrIlKjzCT/GW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aexeUxNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aexeUxNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B61F00893;
	Fri, 29 May 2026 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073315;
	bh=L1u+wV3ZxObPw82wSlHGH2OxzO/uUzE++PykMmjLJoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aexeUxNd9JK4n3hKOAbmX0squnF63hYrqMkuQAEUX4caHQoAoMQxqWbhhGN8eyDRT
	 p+9d77a5ttir94zgYODM8nRCh4WFfnWm7Cls/MHXRyj6AV4+ADxic4UbQv7KRx3Yt8
	 1ndYfjhTBy5A5d5Yd2ipWRpLCvbgSPlrzaQCbRPWsIeeMO6nt0MrckQ4TTcY3iFRl9
	 9/D3jQ+XcB2ys1eQ+TvSvhxF5x8Ez8DFTTUCk9sPGfN06Nf/xbzzymkk1T8b+RKYM9
	 1gd0z0p8QDRcmsyzAeUj8/OuggSk9cRG2darJZoRLCddK1EX71fvuQYbc9PsDhBUvN
	 3OWhbnZthi/tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add tests to verify the fix
 of encapsulating VxLAN in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529151351.69911-5-leon.hwang@linux.dev>
References: <20260529151351.69911-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:48:35 +0000
Message-Id: <20260529164835.A23B61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The fexit program `fexit_lwt_push_ip_encap` is a global hook wit=
hout filtering, causing test flakiness when tests run concurrently.
--

commit 1b1d75b61046d2f71544d30d5afec12a9644a6b0
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add tests to verify the fix of encapsulating VxLAN in lwt

This commit adds two new selftests (IPv4 and IPv6) to verify that the
transport header of an skb is correctly set when encapsulating VxLAN using
the bpf_lwt_push_encap() helper.

> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c b/=
tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
> new file mode 100644
> index 0000000000000..e9043fe654eb7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap_fix.c
> @@ -0,0 +1,36 @@
[ ... ]
> +SEC("fexit/bpf_lwt_push_ip_encap")
> +int BPF_PROG(fexit_lwt_push_ip_encap, struct sk_buff *skb, void *hdr, u3=
2 len, bool ingress,
> +	     int retval)
> +{
> +	if (retval || fexit_triggered)
> +		return 0;
> +
> +	fexit_triggered =3D true;
> +	transport_hdr =3D BPF_CORE_READ(skb, transport_header);

[Severity: Medium]
Will this fexit program cause test flakiness when tests run concurrently?

Since test_progs executes test functions concurrently across multiple worke=
rs
by default, this global fexit program might intercept the
bpf_lwt_push_ip_encap call from a different test running simultaneously
(like the existing GRE test).

Because it only captures the first successful execution and has no filtering
for a specific test or network namespace, could it record offsets for the
wrong packet type and lead to random failures in the transport_hdr offset
assertion?

> +	network_hdr   =3D BPF_CORE_READ(skb, network_header);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529151351.6991=
1-1-leon.hwang@linux.dev?part=3D4
