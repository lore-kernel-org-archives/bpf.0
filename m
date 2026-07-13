Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145933A9DA
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959449; cv=none; b=DYLaWF3rNWDW2FSx/C643qrdEz2KDTBbwdEgtxITsqCsG+zeVmlHW3kgUtfzWnsWlXYt2CpYw1PwgPZ4+0r+Hx2/kIHhINIZ1RiB5FyEycjWqJqtTFnKQRslTUW/UO4kGBjIUUUGgZnqJ6UtfJ6kbTHuAWyk6PntVGMi4uxUKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959449; c=relaxed/simple;
	bh=e0DAUA/YqzW6K/U5vCb8nue9ylfKDAta0fXLcznb2PA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=unWoViPcbuHTJHPfLy8c7ST6rnxZeLnG6mlSrwPhsuVUPU1Aazm6r2IADN6Q9ezJu0Owrw7VoJDXr/HJOsACUpvY3aWt++Jtj0t9kUXOmfO4tDFqVGjCRsVF4eawp2tC+GtbQABz8ms0u19q7RjKu9+mURE3C5/WHCdxeqfEXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPOeQCzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPOeQCzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B491F000E9;
	Mon, 13 Jul 2026 16:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783959446;
	bh=FIPHeX6GOLLJ40uiRFSrnFqau/hjhLpLMh/P3kPTHwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oPOeQCzfoCeWn8AHpWySkwD3+46DMAY0GMmfk8/UPUCvA5u4p9PHMloORtiKnrp5l
	 Vce9iubB3xYNNB1kU/m86o1nIwTN+paq2Ma6KuHTPy+eVAQZeF23+cBDydW3VhOQJU
	 8AsM4h6hs0Js1yOtWNTP4sDx7vtGwaiaXini3hYPLslcubX+DvcFYlPaJ7NAbLTaEU
	 Ex8NZJaTmUdwmP2O8L0p7Lpl+YulYdfjYvCmUA1Qctrgs4vsbtlunFdthPP25Gwc2V
	 5S9JnqVaklaepZokaC24A6f017p+AITCz9xV3QBizPZpkTAslnRX/FGL6t9KfLaQrG
	 STyeeFspVidMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 3/9] libbpf: Probe percpu data feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713154024.30851-4-leon.hwang@linux.dev>
References: <20260713154024.30851-1-leon.hwang@linux.dev>
 <20260713154024.30851-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:17:26 +0000
Message-Id: <20260713161726.C4B491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The capability probe for percpu data incorrectly emits warnings =
and returns a negative error code when map creation fails on older kernels,=
 breaking the silent probing expectation and causing double warnings.
--

--- Patch [3]: [PATCH bpf-next v9 3/9] libbpf: Probe percpu data feature ---
commit 4bf6930d4ace160491d05ec9880c9cadc9f81bc7
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Probe percpu data feature

This commit adds a dedicated feature probe to libbpf for detecting whether
the kernel supports global percpu data. It checks this capability by
attempting to create a simple percpu array map and loading a basic socket
filter program that accesses it.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0bb..ef9581c113035 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> @@ -620,6 +620,38 @@ static int probe_bpf_syscall_common_attrs(int token_=
fd)

[ ... ]

> +static int probe_kern_percpu_data(int token_fd)
> +{

[ ... ]

> +	map =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "libbpf_percpu", size=
of(int), 8, 1,
> +			     &map_opts);
> +	if (map < 0) {
> +		pr_warn("Error in %s(): %s. Couldn't create simple percpu_array map.\n=
",
> +			__func__, errstr(map));
> +		return map;
> +	}

[Severity: Medium]
Should this probe silently return 0 instead of propagating the negative err=
or
code and printing a warning when bpf_map_create() fails?

When running on older kernels that genuinely lack BPF_MAP_TYPE_PERCPU_ARRAY
support, this code will print the pr_warn() above and return a negative err=
or
code.

Because the caller feat_supported() expects 0 to cleanly indicate a missing
feature, returning a negative value causes feat_supported() to print a seco=
nd
warning: "Detection of kernel kernel supports percpu data support failed".

Does this unintentionally pollute the logs with double warnings when apps a=
re
safely falling back on older kernels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713154024.3085=
1-1-leon.hwang@linux.dev?part=3D3
