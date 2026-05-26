Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208103491C4
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831380; cv=none; b=Tj4SdeTXrCe5/Cp9EqsNzrr+gy0/wcx2MgHoZfYMoT+onphCRTrbJ9MpPw507TvSqqA8vfDsDDXpmFrYbG2piww0doDhOgHDzVG++xeit6+vKTvfslOgSK1JwO+aQ/On76nXsTfzVFoHBaRRJ3Bi8xSR4eYJzTtTjM29V2lKRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831380; c=relaxed/simple;
	bh=MgnksHi84SPHN6OVCOVfzYbnS6C/47M7QViWVOgm3Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJNs7gHuUTQ+lbgmsJaJQD9ciZiTc04INqDfX7Woac5PiQoSDaNATujaDhUvkNN0hnJfzMB+wjDToNYTaZisrVoc+dydj0c3uAefbbUgBY85sAgegrPPB3Cy04IXnI1fL2Wgr9C47WTbazaOisvGsyIsiaRnNq0ooARvHvvDTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4d51lxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4d51lxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0731F000E9;
	Tue, 26 May 2026 21:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779831378;
	bh=wKO5t/FAfSGB6ZzJytirV2bf/gcfsTTqYOVXfttSjqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4d51lxuHuEepCNMO0PDt/mP8ivTDCpe19uHMhlinYH7UwLxF1PGyTaE2JD+ZCd2E
	 RkuP9PXuWtoQxKBMNdSH7eYbTSLwaXPpAocaTIlofGTNDykWMlxZQiJjyAAgTibmpj
	 +6qzlY+FdhjVR6J0VSyFr25dPo0b6z7qJGmR/fuCTXzk/crNHz7QCzI/u5AN7k20L/
	 rn0LfDkphgaZM7D71NGDfqthgR5Msi3Z5iEKPfS8m+vHqDv2jSRJqXEObAq4i8qlyT
	 EacvdF308aCowXtVmCARyg8Un9yohG9T99/9eQ0Xl3BS+9cl5OfIP3FfqCUP0HMt5z
	 3cin31kue0jIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 07/13] libbpf: Detect uprobe syscall with new error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526205840.173790-8-jolsa@kernel.org>
References: <20260526205840.173790-8-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 21:36:18 +0000
Message-Id: <20260526213618.6D0731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The uprobe syscall feature detection and selftest changes expect=
 the kernel to return `-EPROTO`, but the corresponding kernel patch is miss=
ing from the tree, causing test failures and feature regression.
--

commit 241886d344e64ee01c001ddedecbb173dc73fef3
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Detect uprobe syscall with new error
   =20
This commit updates libbpf feature detection and selftests to expect -EPROTO
instead of -ENXIO for the uprobe syscall. The change is intended to align
with an optimized uprobe fix in the kernel.

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0cf..a37aaea5253e5 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_f=
d)
>  static int probe_uprobe_syscall(int token_fd)
>  {
>  	/*
> -	 * If kernel supports uprobe() syscall, it will return -ENXIO when call=
ed
> +	 * If kernel supports uprobe() syscall, it will return -EPROTO when cal=
led
>  	 * from the outside of a kernel-generated uprobe trampoline.
>  	 */
> -	return syscall(__NR_uprobe) < 0 && errno =3D=3D ENXIO;
> +	return syscall(__NR_uprobe) < 0 && errno =3D=3D EPROTO;

[Severity: Medium]
The commit message mentions a "previous optimized uprobe fix", but is that
patch present in the current tree?

In arch/x86/kernel/uprobes.c, sys_uprobe() still returns -ENXIO. Does this
cause probe_uprobe_syscall() to return false and silently disable the
optimized uprobes feature?

>  }
>  #else
>  static int probe_uprobe_syscall(int token_fd)
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52d..c944136252c6d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -762,7 +762,7 @@ static void test_uprobe_error(void)
>  	long err =3D syscall(__NR_uprobe);
> =20
>  	ASSERT_EQ(err, -1, "error");
> -	ASSERT_EQ(errno, ENXIO, "errno");
> +	ASSERT_EQ(errno, EPROTO, "errno");

[Severity: Medium]
Will this test now deterministically fail? Since the kernel still returns
-ENXIO, it seems errno will be ENXIO instead of EPROTO.

>  }
> =20
>  static void __test_uprobe_syscall(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526205840.1737=
90-8-jolsa@kernel.org?part=3D1
