Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA53D5234
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103888; cv=none; b=RU+13oA/u6/ezricyYmHhZr/sbrWk4F7wcOJ3mG5hLGmR6L4YH/jjvhe55nfm4//J6xRzzCNay9j0+f7Du1QrWxbCchV9H4dJFmW/EytLlpNGse2la/Fe9zMvl33dnipX05fwjqnNu3CKfzWIt0qPJ1tZYoxEtMYN6jPvHz/TW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103888; c=relaxed/simple;
	bh=cg0fOJ/rOGe8lwKajljAkAEV6vusUKLvwhSExtpu0pg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCLsOQ1xPLVP1ZJm9vG2ATQstJKm/Ks7dPxxo1TjbSzgmlAVWpltsZPZvYQ5ubqGuKgKtI+nXN+VQ4bWSHLzZ20UY9VstuVVyMbRFF/ZhLlIhXy5WHPLFB7S+6ZkflfDuAV4Jlv71Vhaazs3dwQextQrZMPlFEVuef94KuFXzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOa83R1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOa83R1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938ECC2BCB7;
	Mon, 18 May 2026 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103887;
	bh=cg0fOJ/rOGe8lwKajljAkAEV6vusUKLvwhSExtpu0pg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gOa83R1iOYC8yFb9j/tN4HDf8tFsTFCLUGl3VgQSnq06CQvfxq4NoOeHILiF+pNvA
	 fUnR/kgUVN9eTxucg8IzHuJrHEzM/YfHE9NvlLRwkXkjvjBUY7aq78WYN7iezI0YtY
	 qgbOjrbpIyVvs/2IIa5K5EV+CkQXBNWaHSDN+6quSbaYyaWqfkSWPc0wNB6OrCKhMq
	 5sEtfhm+WDlI85GmKTrRqOPQzyfSvo6grfy3AdiZ+nlSGOv96iptVXhaddo4KxCEhi
	 n/lUc4z2rw9vwGeaqTWPtadknps8EGQMBKC7CkhDWXUaO7FmehK6kPMTJLWZ9Hla8h
	 b1zMNZhf4gNTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 05/11] libbpf: Detect uprobe syscall with new error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518105957.123445-6-jolsa@kernel.org>
References: <20260518105957.123445-6-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 11:31:26 +0000
Message-Id: <20260518113126.938ECC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing kernel dependency causes immediate selftest failure and li=
bbpf feature detection breakage.
- [High] libbpf feature detection breaks backward compatibility by not acce=
pting the old ENXIO error code.
--

commit 674b83913f8f61b2f16ba8f8b86e6bf8e84da5a3
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Detect uprobe syscall with new error

This commit updates libbpf's feature detection and the uprobe selftests to
expect the uprobe syscall to return -EPROTO instead of -ENXIO. This is in
response to an optimized uprobe fix that changed the syscall's error code.

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

Is it possible this change breaks libbpf's backward compatibility with older
kernels? Since probe_uprobe_syscall() detects uprobe syscall support on
various kernel versions, replacing the check rather than allowing either
(e.g., errno =3D=3D ENXIO || errno =3D=3D EPROTO) might cause libbpf to sil=
ently
fail to detect uprobe support on kernels that predate the EPROTO change.

Also, looking at arch/x86/kernel/uprobes.c, the kernel-side change does
not appear to be present in the tree yet:

SYSCALL_DEFINE0(uprobe)
{
	...
	/* Allow execution only from uprobe trampolines. */
	if (!in_uprobe_trampoline(regs->ip))
		return -ENXIO;

Will replacing this check cause immediate regressions for both feature
detection and the selftests until the kernel dependency is merged?

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

Similarly, does this selftest change introduce an immediate regression if
the running kernel still returns -ENXIO?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518105957.1234=
45-6-jolsa@kernel.org?part=3D1
