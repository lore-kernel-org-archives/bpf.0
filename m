Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08C3CF04F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413096; cv=none; b=HyLCpvGNKQklDNW7Bik9bfB2MbWsDQ5AjbWbgtmXMlALpCRFuGeQzS8zgrc8+1bC9f7pu8GW91NE5T06lVQlLNCgI6qIlD7c+ubpOI4HLqqDZaAQZfR5RHXud6LnqHQbgktX8N3BdCKKhouLxB8KE0eYNTPEDjLgyE/nKur6Br0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413096; c=relaxed/simple;
	bh=yohIXd5LtS8z4RxwoQ4HVSWJ3U4EcjQHCumMEuHSg0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gnPIBQ20loRuNIxaoIy9aKTkgUSKFOIJ/i4xGvT61epJKKI87oOFKd/qnHx1cElHqMKhYjA6Y2hY8xfVcJtqaGv9CxQoakPszcHbGEqg+AQDaqzOdKZZbtHfSdd4n5M0driTEr4gA3tXRtKUxGnLvmNbHabugipMtZnHOg+W4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxyq8R4H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxyq8R4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F3D1F00893;
	Tue,  2 Jun 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413095;
	bh=pUfQkOu0N/uc8iyFaycPu0WxYd0YOt/G5RiM0rPJXII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxyq8R4HS/0ok7jBv8qPL2Ehthv4y3/4nq7VWOPtzZXHhccGqbwpbM865mcUPmR71
	 MKkJ5M4+uKZYrhqP4neO4oXm7n29CJs6M7rTemDkEuVPv2cfgx+OYmKnrPkgMeihPG
	 Eo38+8Xtpt4q79DCKbCn0zSr+RYuxyC1qgb1TvFp2m4MdbaSMNpFCNqd/312aObzpp
	 CL8Gxe/SByzOQdkjCgjolJF/vhv3SVOmhDsf6hBslEIIFni7w37n05P6c14TQ7Uw01
	 z4TrNQK14G8uCW68ZpnlAf0QdwT1nrov2l91uEQSp0NqgbgD3WDNwc3to1qK5J6GtG
	 Vxh/0Xnq2lVzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/8] libbpf: Initialize CFLAGS before
 including Makefile.include
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init_bpf_only-v2-4-c76e5250ea1c@arm.com>
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-4-c76e5250ea1c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:11:34 +0000
Message-Id: <20260602151135.29F3D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removal of `override CFLAGS +=3D $(CLANG_CROSS_FLAGS)` breaks Cl=
ang cross-compilation when `CFLAGS` is overridden on the command line.
--

commit 6aa5adddfad905f5f29ccfe28312c5a00d2d1082
Author: Leo Yan <leo.yan@arm.com>

libbpf: Initialize CFLAGS before including Makefile.include

This commit reorders CFLAGS initialization to happen before including
Makefile.include so it is not affected by expanded EXTRA_CFLAGS. It also
removes the appending of CLANG_CROSS_FLAGS, citing redundancy with the
include file.

> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 168140f8e6461..eca584fb061e1 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile

[ ... ]

> @@ -84,7 +85,7 @@ override CFLAGS +=3D -Werror -Wall
>  override CFLAGS +=3D $(INCLUDES)
>  override CFLAGS +=3D -fvisibility=3Dhidden
>  override CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64
> -override CFLAGS +=3D $(CLANG_CROSS_FLAGS)
> +override CFLAGS +=3D $(EXTRA_CFLAGS)

[Severity: Medium]
Does removing this override directive break Clang cross-compilation when
CFLAGS is overridden on the command line?

While tools/scripts/Makefile.include already appends $(CLANG_CROSS_FLAGS),
it uses a standard assignment. According to GNU Make semantics, standard
assignments are ignored if a variable is overridden via the command line
(e.g., make CFLAGS=3D"-O3").

By removing the override directive here, the build system might fail to
unconditionally append cross-compilation flags (like --target=3D and
--sysroot=3D), causing Clang to fall back to compiling for the host
architecture instead of the intended target.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com?part=3D4
