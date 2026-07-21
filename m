Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A0C33F597
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644013; cv=none; b=dH/IJAZMGzef0rqOneBbBJtqV3yEEVc5HFNHZOl0kg0q292vwMPWM1YwofRNIhtemSVCaIJkVK6b0S+vVcAyCumuJABoRfVaC7KLIdekdvs4PE1qBOdAgqlz+EV4dTCfZ4lKFQ5jVHw4t5UJuEx3eOtliCJGTJnLgzKB9x4eP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644013; c=relaxed/simple;
	bh=hhOarQnkxEE7tu/hU216roFVIy3qncqg46ePhg5wW3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UU2gPR3VhwcLjETky/6nr54GX7gmfUIdM6ZUkOsJVlq3SNghjBtFaTDql13Mx112N6o+SAc7qOdtFbo9nzjdeq562NNXhi5uiJ5XA6dca8ozC6yhskrYIWtGZOxKJGFDkGHlwqwI6b5acex5FCp8N6nWKEIqvvQZK9XpUzRvYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgNjb7X+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgNjb7X+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B81F000E9;
	Tue, 21 Jul 2026 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644011;
	bh=ywXq2i7XAVh5qrAkyv83Lx61mRY9/rwbbv5q/Hq7pP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jgNjb7X+a+CRrvWFGQ5fn+HsM0lY2L/p6+X5EgSj71JQIp+su/CZkeg3N2wUTZ2Tb
	 qApE70mzZ30gJ/6ip37pgGZETcY4KEemTWNxRDm8p6MpE35v0JKLbvX7B4A2I4z+Ih
	 zMH8nd1SAwti9KAyBl6igVZFdDRbQKys+ofmgeDIF8AdMXKEJK3s33xJ0LEz7Uikhi
	 VbIinfQTwmzoqv+ZdxeGEHOzOW1nbmhQPHBEHllHaRxesAl9gRFZmoe8TMXNwQQWVa
	 cCMdcvjtTlXjHGKT0GpOIy2H67hdKnitI+x77IsvRKazRNp5lD1msTUCapmg/GRCWU
	 y3yV9+fnFJX3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/21] selftests/exec: convert the binfmt_misc bpf
 test to the kselftest harness
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260721-work-bpf-binfmt_misc-ptinterp-v2-7-e57866e4ae0f@kernel.org>
References: <20260721-work-bpf-binfmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org>
 <20260721-work-bpf-binfmt_misc-ptinterp-v2-7-e57866e4ae0f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:26:50 +0000
Message-Id: <20260721142651.B20B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] FIXTURE_SETUP unconditionally mounts the bpf filesystem, leaking=
 stacked mounts in the host mount namespace for every executed test case.

Pre-existing issues:
- [High] The selftest runs as root, uses predictable temporary paths withou=
t O_EXCL, and ignores the return value of mkdir, allowing a local unprivile=
ged attacker to mount a symlink attack to overwrite arbitrary files.
--

--- Patch [7]: [PATCH v2 07/21] selftests/exec: convert the binfmt_misc bpf=
 test to the kselftest harness ---
commit d2f3d4f22570fe58bd70c6c3a7484277cc3de4f4
Author: Christian Brauner <brauner@kernel.org>

selftests/exec: convert the binfmt_misc bpf test to the kselftest harness

This commit converts the binfmt_misc bpf test to the kselftest harness.
It introduces a fixture for common setup and teardown, replacing the open-c=
oded
main function and moving helpers to a shared header. The test cases are spl=
it
into individual TEST_F blocks.

> diff --git a/tools/testing/selftests/exec/binfmt_misc_bpf.c b/tools/testi=
ng/selftests/exec/binfmt_misc_bpf.c
> index cb89d2766fe2a..dd541c0a464da 100644
> --- a/tools/testing/selftests/exec/binfmt_misc_bpf.c
> +++ b/tools/testing/selftests/exec/binfmt_misc_bpf.c
[ ... ]
> @@ -186,92 +139,76 @@ static int run_case(const char *objfile, const char=
 *handler,
>  	return ret;
>  }
> =20
> -int main(void)
> +FIXTURE(bpf_handler) {
> +	char obj[PATH_MAX];	/* struct_ops object of the case under test */
> +};
> +
> +FIXTURE_SETUP(bpf_handler)
>  {
[ ... ]
>  	if (stat("/sys/fs/bpf", &st) < 0)
>  		mkdir("/sys/fs/bpf", 0755);
>  	mount("bpf", "/sys/fs/bpf", "bpf", 0, NULL);

[Severity: Medium]
Since FIXTURE_SETUP is executed prior to every test case, doesn't this
unconditionally mount the bpf filesystem without unsharing the mount namesp=
ace?

Since there is no corresponding umount in FIXTURE_TEARDOWN, this seems to l=
eak a
stacked mount on the host's /sys/fs/bpf directory for every test case execu=
ted.

> -	if (access(BINFMT_REG, F_OK) < 0)
> -		mount("binfmt_misc", "/proc/sys/fs/binfmt_misc", "binfmt_misc", 0, NUL=
L);
> +	if (!binfmt_misc_available())
> +		SKIP(return, "no binfmt_misc");
[ ... ]
> +/* A "$ORIGIN/..." PT_INTERP resolved to an interpreter next to the bina=
ry. */
> +TEST_F(bpf_handler, origin_relative_interpreter)
> +{
> +	char src[PATH_MAX], app[PATH_MAX], interp[PATH_MAX];
> =20
> -	/* Case 2: $ORIGIN-relative PT_INTERP -> co-located interpreter. */
> -	printf("[*] case 2: $ORIGIN interpreter resolved relative to the binary=
\n");
>  	mkdir(RELOC_DIR, 0755);

[Severity: High]
This is a pre-existing issue, but does ignoring the return value of mkdir()
here allow a local symlink attack?

Because the test requires root privileges and uses predictable paths in /tm=
p/
(like RELOC_DIR), an unprivileged attacker could pre-create /tmp/binfmt_rel=
oc/
and place a symlink inside it (e.g., app -> /etc/shadow).

Since the attacker owns the pre-created directory, it bypasses the
fs.protected_symlinks and fs.protected_regular sysctl mitigations.

> +	snprintf(app, sizeof(app), "%s/app", RELOC_DIR);
> +	snprintf(interp, sizeof(interp), "%s/binfmt_bpf_interp", RELOC_DIR);
> +	ASSERT_EQ(artifact_path(src, sizeof(src), "binfmt_bpf_app"), 0);
> +	ASSERT_EQ(copy_file(src, app), 0);
> +	ASSERT_EQ(copy_file(INTERP_PATH, interp), 0);
[ ... ]
> diff --git a/tools/testing/selftests/exec/binfmt_misc_common.h b/tools/te=
sting/selftests/exec/binfmt_misc_common.h
> new file mode 100644
> index 0000000000000..854c7a6d34e17
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_misc_common.h
> @@ -0,0 +1,98 @@
[ ... ]
> +static inline int copy_file(const char *src, const char *dst)
> +{
> +	char buf[4096];
> +	int in, out;
> +	ssize_t n;
> +
> +	in =3D open(src, O_RDONLY);
> +	if (in < 0)
> +		return -1;
> +	out =3D open(dst, O_WRONLY | O_CREAT | O_TRUNC, 0755);

[Severity: High]
This is a pre-existing issue, but does opening the file without O_EXCL allow
the symlink to be followed and the target file truncated?

If an attacker pre-creates the symlink in RELOC_DIR, when the root-executed
test opens the predictable path without O_EXCL, it will follow the symlink =
and
truncate the target file, leading to local privilege escalation or denial of
service.

> +	if (out < 0) {
> +		close(in);
> +		return -1;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-work-bpf-b=
infmt_misc-ptinterp-v2-0-e57866e4ae0f@kernel.org?part=3D7
