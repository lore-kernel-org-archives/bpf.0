Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA2312836
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370161; cv=none; b=QYbdWJYHUPg6QW8AT8WnYYTfmC46trQ9PQjSL9qtMi85T+qTSnw8Gpni+sdNdEnknITF6CvncJxLo6wVoUbheCrn/JJwxu2qTE73LCrmxeB6rap2aMmE7l7pgaWU+pDAtvzbQ3+PRRoVYBZ49zGpyf76cBnVg6HnRXdvswzWy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370161; c=relaxed/simple;
	bh=KTDzVSD5Hp4Ze8N7BbZ2JLCcFPudRKrxiPYLL6Y+rhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QCJzbMFgjr1Bq6RvmjRONIItDRHFB8j58uWP+JvzvNu1rX9TwJC+yFqV2BtoML1NgtEHEaZsrJvdXfqBkEVZCdHNYu15SPgppUovO/wdH82cOCF5G1txuQ/vVvzG9puGHxf6qsBZowNABzOCbHGWYa+DPXDNqc1GD3zeJmpga/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7vyQsID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7vyQsID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227EB1F000E9;
	Thu, 21 May 2026 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370160;
	bh=navlOB+CzeFvlKT25o7c3/Xf3L/m8wHdWHM0yNIAHds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L7vyQsIDWMWP+L9RguPPM8aai4aun280qlRogdRqbLL0ZA6gox5gQPaRKUG5ls7Ru
	 KgYs3/RvpFDRv4HDla/yQIoGyfRQVspAyhc3b1EuC71XFduIJ2LQnS2AF/cqNLeBBS
	 a6Xy8w7PdwJFCIqA9QfEs+IAM6ydGYatoLo3u2cY4e4/rfVO210oNbq+Fkqiju9vXA
	 Urlgg6gfTjpk/s8WVJQ3vmxgOEByGkL/9SxXHKcHZSMbNKQv0m1Fre9Ep/QbKMHRgo
	 GnekJiExflIGmonnNi0zIdnIWmGPiK1qZcNe6/6ZGFfyluhn4DDYVW27IAOiDQcB4D
	 ZuokzlMEltCyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 06/12] libbpf: Detect uprobe syscall with new error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521124411.31133-7-jolsa@kernel.org>
References: <20260521124411.31133-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 13:29:19 +0000
Message-Id: <20260521132920.227EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing kernel-side dependency causes selftest failure and feature=
 detection breakage
--

commit 2bfbf90e3446befa63868457a72590c57c20d562
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Detect uprobe syscall with new error

This commit updates libbpf feature detection and selftests to expect
EPROTO instead of ENXIO when the uprobe syscall is called outside a
kernel-generated uprobe trampoline.

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

[Severity: High]
Is this patch missing a kernel-side dependency? Looking at the current kern=
el
tree in arch/x86/kernel/uprobes.c, SYSCALL_DEFINE0(uprobe) still explicitly
returns -ENXIO:

if (!in_uprobe_trampoline(regs->ip))
        return -ENXIO;

Without the corresponding kernel patch to change this to -EPROTO, will
this cause libbpf to incorrectly conclude that the uprobe syscall is
unsupported, and cause the updated selftests below to fail?

>  }

[ ... ]

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
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521124411.3113=
3-7-jolsa@kernel.org?part=3D1
