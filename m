Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC006397E96
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643918; cv=none; b=FLU/IIkp/7PjSDgJZZGupBYb4yd6Hh5+R0pRdjK8QayJyt3wDTaWQwRcfoxPup0gb9PNKhFjoKZZ2zoupT7q2SM1ixrUzgN+fQYT2YthgNAeg5tmmUy9MnHknHJvkI2ztuLsS78MUZL3/E8rJR9QmmwhTf4wr4j1igf+S7TRu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643918; c=relaxed/simple;
	bh=1dJ+UttwuGXZkx1wu76R6R8/WBn2WakKljvZI9JFZbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oCrR3umJHTZwoUzCXQiNcPRyIuyfWrrW67M+dUKxS5hOTTdheemx7JhGqqjL1pCrkRL6gghzXvqb2nG89s7hb7t5xpkabq3yq1bLCvNsrieiB4MLS2lC22kJOCHLMzzyctWSu1eyytTcjYPQZY1u00VKgoy8pdSGF8Nxg7QpVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emO2wCEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emO2wCEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6C21F000E9;
	Tue, 21 Jul 2026 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784643917;
	bh=FdPkvH8V3VCQb2XQ4P3NVBEdtBKsNQRoRREQyzCUdC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emO2wCEX4bwKLPlJYTc+WOhxX49LDaUtfWCOF/k9Id3Qqs15dY2K3WaglN0gIKqJO
	 QTvZiX+rbykjg2pXCFTUvslIj7V+ynZzxuYeZGCx02JHtqXskHlPR5upLVFPT8wjSq
	 dPlZJu6m7ApFv8J8aHXjt0+aStA0zwNOILtIQs8QimqqGgrV7Tek0LSi4BJwyEtC1D
	 hwA04XcvdSg/bGxg4XjjgVX6cPcgCkJC4MzGCTfWOlVuSd4lN7sY+gYVXZARpYA83u
	 Ni16Fuzd0nzvxeFt0tyvtL41j1lS4ABbrWQ5Z3iD70pzWMGNUMAxwlDVzRXUWFmQRb
	 jNJyh35nqRzJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/21] selftests/exec: test the transparent
 binfmt_misc mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-13-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-13-e57866e4ae0f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:25:16 +0000
Message-Id: <20260721142517.2C6C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Insecure usage of predictable `/tmp` files without `O_EXCL` enable=
s Local Privilege Escalation via arbitrary file truncation and TOCTOU race =
condition.
- [Medium] Continuing execution after stat/fstat failure leads to uninitial=
ized memory read.
- [Medium] Stack-based buffer overflow in the test interpreter when copying=
 environment variables.
--

--- Patch [13]: [PATCH v2 13/21] selftests/exec: test the transparent binfm=
t_misc mode ---
commit f9d24508b6065861653a1b024a163b3671852433
Author: Christian Brauner <brauner@kernel.org>

selftests/exec: test the transparent binfmt_misc mode

This commit adds tests for the transparent binfmt_misc mode, verifying the
identity a transparent dispatch constructs from both activation paths. It
introduces a static transparent binfmt_misc test and a bpf-backed handler
test.

> diff --git a/tools/testing/selftests/exec/binfmt_misc_transparent.c b/too=
ls/testing/selftests/exec/binfmt_misc_transparent.c
> new file mode 100644
> index 0000000000000..de59dc8c5695e
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_misc_transparent.c
[ ... ]
> +/* The target only has to carry the magic; it is never actually loaded. =
*/
> +static int create_target(void)
> +{
> +	char buf[128] =3D MAGIC "\n";
> +	int fd;
> +
> +	fd =3D open(TARGET_PATH, O_WRONLY | O_CREAT | O_TRUNC, 0755);

[Severity: High]
Does creating predictable temporary files in /tmp without O_EXCL while
requiring root execution introduce a TOCTOU race or arbitrary file truncati=
on
vulnerability?

If a local unprivileged attacker pre-creates TARGET_PATH
(/tmp/binfmt_transparent_target) as a symlink before this test runs,
could they truncate arbitrary system files?

Furthermore, since this file is later executed as root via execl() in
TEST_F(transparent, dispatch):

    if (pid =3D=3D 0) {
        execl(TARGET_PATH, TRANSPARENT_ARGV0, "argone", "argtwo", (char *)N=
ULL);

could an attacker swap the contents of this predictable file just before
execution to achieve local privilege escalation?

[ ... ]
> diff --git a/tools/testing/selftests/exec/binfmt_transparent_interp.c b/t=
ools/testing/selftests/exec/binfmt_transparent_interp.c
> new file mode 100644
> index 0000000000000..2a71c47067582
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_transparent_interp.c
[ ... ]
> +int main(int argc, char **argv)
> +{
[ ... ]
> +	/* AT_EXECFD refers to the very file that was executed. */
> +	execfd =3D getauxval(AT_EXECFD);
> +	ok(execfd > 2, "no AT_EXECFD");
> +	ok(!stat(binary, &stb), "cannot stat the binary");
> +	ok(!fstat((int)execfd, &stfd), "cannot fstat AT_EXECFD");
> +	ok(stb.st_dev =3D=3D stfd.st_dev && stb.st_ino =3D=3D stfd.st_ino,
> +	   "AT_EXECFD is not the binary");

[Severity: Medium]
Since the ok() helper logs an error but does not abort execution, what
happens if stat() or fstat() fail here?

Does this lead to reading uninitialized memory from the stb and stfd structs
during the stb.st_dev =3D=3D stfd.st_dev comparison?

[ ... ]
> +	/* And so did the kernel's copy of it: the same strings, NUL separated.=
 */
> +	for (i =3D 0, expect_len =3D 0; i < ARRAY_SIZE(want); i++) {
> +		size_t len =3D strlen(want[i]) + 1;
> +
> +		memcpy(expect + expect_len, want[i], len);
> +		expect_len +=3D len;
> +	}

[Severity: Medium]
Is there a risk of a stack buffer overflow here if extremely long environme=
nt
variables are passed to the test interpreter?

The want array is populated from BINFMT_TEST_BINARY and BINFMT_TEST_ARGV0.
Since expect is a fixed-size stack buffer (PATH_MAX + 32) and there is no
bounds checking before this memcpy() in main(), could an attacker overflow
the buffer by invoking the interpreter directly with oversized environment
variables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-work-bpf-b=
infmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org?part=3D13
