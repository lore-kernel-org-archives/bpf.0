Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B9368D68
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192981; cv=none; b=PZAEnxhmXo8WExWcTkO8agJ+fxTup8SJPboj/amM5a6dC6YMXQ3KIxiQVW1RKZVudy7l4XsRhVF4t1lMbLLgwbddAqYNUHpvoui/siVmontwJfh6r6/AEMot/kWpYgBQQkbtY6my49t15cGCDoTixDmu3HOKrryzLWftDTjtEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192981; c=relaxed/simple;
	bh=1w9PkzakOlQNcRNev8T/tV1P078nW1w3W9iwAyCvmu0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HChN2FfeaKjqqOolGqPQuUeLNmGNeqqkJ1IZ2a4V/2+Px54g6bbojxiBhLH5waNM3feouj5qU8bXBx5fwqCrzk0ecfKjBncRkYRW0fGke6ib0KVJLmfipM/L/CnDwnJL6ZVSNObRIgCQjSsyGvePVbCddYS8bA1+PMvbb3eF+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8pQD3r8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8pQD3r8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4168C1F000E9;
	Thu, 16 Jul 2026 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784192976;
	bh=jXcz3g6eL69E9xrbd9ZK68gAaU0bKBzBpvZO4hZap9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8pQD3r8giz0zj4m81TIzYZkGKMj/pA7pvnm2hHjHs+pG9elwMmJEZmVmFU4f9voX
	 SzZodQd18FDeVo3/r5SMgNsafmm4cMIZxthw+NLIrRB2bSumlwT5G6C/I2DyzkONQm
	 juJ0xJeI5WAEZwvjqgPn7eZPYDt3Q9xePZHqWg8ROBe/F91o3BHZbpaVkeFbWd002R
	 78lDvDtKySwY3ZO7Dw6bGKP+r/rJRl1jtrkIYFyLojbE7tf7K6c+hoeRMdwUbVzxK1
	 0Hio6s8ypsDpLPohRpSxzrZ3qbYdaUiDZdXi+8bkYWyN8cz8k8dx4AL7w7Bm2pDpmh
	 UOtm2DJAh/RFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/resolve_btfids: fix OUTPUT leakage from kselftest
 causing corrupted build paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716085733.1761196-1-yijiangshan@kylinos.cn>
References: <20260716085733.1761196-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:09:35 +0000
Message-Id: <20260716090936.4168C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch forcibly overrides the `OUTPUT` variable to the source tr=
ee directory if its origin is `command line` or `environment`. This breaks =
intentional out-of-tree builds for kernel tools and selftests (such as BPF =
and HID) which explicitly pass an `OUTPUT=3D` path on the command line. By =
overriding the requested path, the build writes artifacts into the source t=
ree instead of the expected output directory, violating read-only source tr=
ee configurations and causing the selftest builds to fail because the `reso=
lve_btfids` binary is missing from the required location.
--

--- Patch [1]: [PATCH] tools/resolve_btfids: fix OUTPUT leakage from kselft=
est causing corrupted build paths ---
commit b49b49183f48428e27843ec3019b42192ca9ed12
Author: Jiangshan Yi <yijiangshan@kylinos.cn>

tools/resolve_btfids: fix OUTPUT leakage from kselftest causing corrupted b=
uild paths

This commit addresses corrupted build paths caused by the OUTPUT variable
leaking from parent makes like kselftest. It attempts to fix this by checki=
ng
if OUTPUT comes from the command line or environment, and if so, overrides
it back to the source tree directory.

> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids=
/Makefile
> index 7672208f65e4b..eee88c73fd7a1 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -26,6 +26,22 @@ HOSTAR  ?=3D ar
>  HOSTPKG_CONFIG ?=3D pkg-config
>  CROSS_COMPILE =3D
> =20
> +# If OUTPUT was inherited from a parent build's command line (e.g. from
> +# kselftest), it points to the wrong directory and may lack a trailing
> +# slash.  The tools/build Makefile.build concatenates $(OUTPUT) with
> +# filenames without a separating slash ($(OUTPUT)%.o), so a missing
> +# trailing '/' produces corrupted paths such as "mmmain.o" instead of
> +# "mm/main.o", and the linker cannot find resolve_btfids-in.o.
> +#
> +# When built via the kernel build system, OUTPUT is set by
> +# scripts/Makefile.include (origin "file") from the O=3D parameter, which
> +# is correct.  Only a command-line origin indicates leakage from a
> +# parent build and needs to be reset.  Both "command line" and
> +# "environment" origins indicate leakage; "file" (set by Makefile.include
> +# from O=3D) and "undefined" are legitimate and must not be overridden.
> +ifneq ($(filter command line environment,$(origin OUTPUT)),)
> +override OUTPUT :=3D $(srctree)/tools/bpf/resolve_btfids/
> +endif

[Severity: Low]
Does this override break intentional out-of-tree builds?=20

When building BPF or HID selftests out-of-tree, the build system explicitly
passes an OUTPUT=3D path on the command line. Because the origin is evaluat=
ed as
"command line", this logic unconditionally overrides it, discarding the pro=
perly
requested out-of-tree path.

Won't this cause artifacts to be written directly into the source tree, vio=
lating
read-only source tree configurations and causing the build to fail when it =
looks
for the resolve_btfids binary in the expected output directory?

>  OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> =20
>  LIBBPF_SRC :=3D $(srctree)/tools/lib/bpf/

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716085733.1761=
196-1-yijiangshan@kylinos.cn?part=3D1
