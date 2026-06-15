Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71F331EC0
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519193; cv=none; b=WsXE85OGWrGjT1ai3A3l+JCUGGTrpEajqg98K+Hv8ikXtERXtNzAdRUcfOQtW8MLmtJusZpfX7WP08slSKxSnBpHVTW1nHTR8tZ/l/WAry/BgV7nfbicgCqCG70PK40/Q5C8+cwt6kK3Y9blvwPnY6CNFdZC6cZ+J51PQUt7fOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519193; c=relaxed/simple;
	bh=IiCJ1cUM4vdBgjOXduDKV69Rm7uzky+6FsiYaGyXMws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jujPNOamVn12X4xGcTIRZFfppxpCkTNRfCwBnJ3NYWXgCGWUT30LQ8FQKel8oj7WyYxcg+p29H/aAsHl0ZglL9RMuK9EyzwH4+syZ4hnUEKX0VnTj2VH1DD9AjB19EFGwI94c+3B/8YzN9d2LsBjtcYpOsmhp6lQS1n3xiP49g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANGZ5yLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANGZ5yLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0521F00A3A;
	Mon, 15 Jun 2026 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781519192;
	bh=P7hFNB3bkruaQhfjNZAYnWGFe+AUQbn8Pk+wxKq6pI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ANGZ5yLob6zhy+gymLpPmDPo26NkWTtf62kwjvRHBx88rdf+XDluupAgUuo555S+V
	 gFQexlRoJb2WCLtI0MwsiPWZA1egjwdQuuv+EUhSC6mkWzny6huWlJVcv0rRZztppH
	 3pF0S844EjR+3arkw34owfsbU3imO/TG7phIZTVaKEbQzNz/mCMNLLEnVuUy8AVIX6
	 MoOCR7XFOLh65wXMsvxsTgaa7X5QLhyvu8ksCl9S/3COw60TvoJEh3CDrItSANKY4g
	 qENYU/HPi4H2QOvQp/01+fsI/sGfXcNpMc26yRrigy+un6rOEb5zhxC0gyDxhJ4lI0
	 Wa85UFD4AKj2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Test jited inline of
 bpf_get_smp_processor_id() for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260615100506.19558-5-yangtiezhu@loongson.cn>
References: <20260615100506.19558-5-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 10:26:31 +0000
Message-Id: <20260615102631.EE0521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Broken selftest due to missing kernel JIT implementation and inc=
orrect structural offset
--

commit 8f74b6910905428534e06ac6efaea6a8091a844f
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Test jited inline of bpf_get_smp_processor_id() for LoongArch

This commit adds a BPF selftest for LoongArch to verify that the
bpf_get_smp_processor_id() helper is correctly inlined by the JIT compiler.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> index 8560577f25576..02e562f56f9d3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -21,4 +21,15 @@ int inline_bpf_get_current_task(void)
>  	return 0;
>  }
> =20
> +SEC("fentry/bpf_fentry_test2")
> +__success __retval(0)
> +__arch_loongarch
> +__jited("	ld.wu	$a5, $tp, 16")

[Severity: Medium]
Will this test fail in the current tree? It appears the kernel-side JIT=20
implementation to inline this helper on LoongArch is missing. Without it,=20
this test will expect an inline load but the JIT will generate a standard=20
function call, causing the assertion to fail.

Also, is the offset 16 correct here? In the current tree's LoongArch layout,
struct thread_info contains a task pointer at offset 0, which means the cpu
field is at offset 24, not 16. The test appears to rely on an out-of-tree
configuration or prerequisite patch where the offset is 16.

> +int inline_bpf_get_smp_processor_id(void)
> +{
> +	bpf_get_smp_processor_id();
> +
> +	return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615100506.1955=
8-1-yangtiezhu@loongson.cn?part=3D4
