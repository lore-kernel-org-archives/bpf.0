Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FE277818
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625565; cv=none; b=AXo/A6GEBOIsfIu0CZgXjBkPXfwKPq1/bxe9naGgIKupGXJwWly6EUVUpLgmwmFVSySLYuPkWsnt6/kHUKGbqt1YuMHbPGLQJ5APqff7a+OMGQ/sREByNz9oWbysjg5yZ0xDfqBJy0LShHHw/rJNwqQcghaD9W7rWIfrfJGokLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625565; c=relaxed/simple;
	bh=npT7Uf5cUSc7pKMxJ1lKzE/jiHajii93kAHePg5cVNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQxlJYTInzG8ZbhFc+6cN4CYaiq2qkbmn8BBEVpoO3fZh+Dh7QTn2KrjZMQiRV3l6UW7h0GZRlaB3ICaQCXM/w+5QcdZNgWSXIxNrAuAwzPHr28ZCUAF9uvCir1O6ngxJjBMs7LQptu+G5tyh3LwsRbj08C/nyVAlkEpfFM3FX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCOTAjrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCOTAjrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDD1F000FF;
	Thu, 17 Sep 2026 06:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625563;
	bh=1Uvv+CNG+OK2EAQtaOq4fk/ArNo8jEIa260BCVe7lfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCOTAjrEAf7j7Mxd2FJBeEZSI1doBj0LfSsuIpy5qeIGh+tNTimBre7fEmxIWBD/v
	 DAV5hmWNjTgOUxNHoExCXSIPMZnog2xCL2JgBCbBQT64qmJjRAWuX0CBLo1Bg4kbdD
	 WYROECjyX6kaTJIGmuCb3lDJR22/ijbisB47RdHNLbwZf0H7X23fpSEYseOpWwLkjY
	 g+JgBkUzhsQ0iKoWjezA1dxjlOVgjqt3HAOi1fdn+e/lg79GzizO/0Cq2ysRiivDh8
	 P488230KMZKfqQortcjS+c0QjyGl9ddwaiftwEYinHrb0izmYoOREACLy8xfW8vDLy
	 g1YwcHiUo5ynw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 18/20] selftests/bpf: Add an end-to-end
 .bpf_cleanup exception test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055818.3934773-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055818.3934773-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:12:43 +0000
Message-Id: <20260917061243.92EDD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments do not follow subsystem style
--

commit 5918cbd599a9ba7808857475f6ca49093862b54a
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add an end-to-end .bpf_cleanup exception test

This commit adds an end-to-end test for .bpf_cleanup exception handling, us=
ing
inline assembly to construct landing pads and cleanup records. It validates
both successful exception propagation scenarios and various edge cases that
the kernel is expected to refuse.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> index d1e45b765af26..0000000000000 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c

[ ... ]

> +	/* foo3 throws; every pad runs and the cookie is delivered at entry. */
> +	if (test__start_subtest("throw_from_foo3"))
> +		run(skel, 101, THROW_COOKIE, PADS_FOO3_THREW);
> +
> +	/* foo3 returns 2 ^ 1 =3D=3D 3, so foo2 throws from its own second regi=
on;
> +	 * foo3's frame is long gone, so its pad must not run.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style? The guidelines prefer placing the opening /* on its own line for
multi-line comments.

> +	if (test__start_subtest("throw_from_foo2"))
> +		run(skel, 2, THROW_COOKIE, PADS_FOO2_THREW);
> +
> +	exceptions_cleanup__destroy(skel);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c =
b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> index ce2dac306a84c..0000000000000 100644
> --- a/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_fail.c

[ ... ]

> +"3:"					/* landing pad */
> +	"r1 =3D jt0_%=3D ll;"
> +	"r1 +=3D 8;"
> +	"r2 =3D *(u64 *)(r1 + 0);"
> +	/* gotox r2. Spelled as a raw insn on purpose: the "gotox" mnemonic
> +	 * only reached the LLVM assembler in llvm 22, and BPF_RAW_INSN()
> +	 * needs <linux/bpf.h>, which this file cannot have -- vmlinux.h
> +	 * already defines the uapi enums.
> +	 */

[Severity: Low]
This is also not a bug, but does this comment formatting comply with the
subsystem guidelines? Like the previous instance, the preferred BPF style
places the opening /* on a separate line.

> +	".8byte 0x20d;"
> +"l0_%=3D:"
> +	"call bpf_unwind_resume;"
> +	"exit;"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D18
