Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9986399360
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547888; cv=none; b=QMrNKwBgP26llQ5j1LDvqYKtl+PI7ZYOfL88I2XuNbrxTgVQj11UBu7kjhsfHUHqYEEfbv3ONAosRd3rrhVCK5bEUrpU4lP6T7yIXW5a6zGhbov2OkLXPRLiZwnAHJ4jPwnk7H3COtKNNj56G1DPRLKghwliYbJqZopC3tCfb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547888; c=relaxed/simple;
	bh=mWv8JdEEVjqdiV4xb7fR0ar5WZBXCFpV6WdyffPPqg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lgmoGVyrz6XMGDuYE8aa0vUeWM2PqvUA6ibr/smbOEjdbRIBsrecb3e51y9vGIsdTr5ln88mJMIBxJgOX3F3dhQtMxqUDmG145wRJxd4FZAPDlaczdMF0BQDm5GwgEIsrR2V1Pfgt6M+nOVdkT0EOZTrEEL/ntm/mI+sKKBC01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXwTVNp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXwTVNp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F62A1F00A3A;
	Mon, 20 Jul 2026 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784547887;
	bh=V1ZpiTOcR91E1RdsSApEdSEK1wdyQt6fJCruY/s7zxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXwTVNp2eqzHydDkdJ3CXSFh+LW7L9zUjBwoX2f4VegDtNt5jtrVbjZgukyq3SLBo
	 7ygtojN2/yrtqtw/l1CtxIYNUirtl2yEqsV5qBrcmWTu2Lqfn32vMNkN2fd3ejwkvC
	 1SlCva8hD76cayJg29k0b+9cxPKdGv/tb5BjWLDS1TNHPtsQP03A/uwqKr+uTzjkTX
	 xGbvtbAaZ02hLarZgMdvZ+DzYFAz0kNiGTW6rBSrvKR6d6W0zFJ/x3zJ+xA4etMV0M
	 mSAAiqdzF1IaSyddTJyY504o803VDK10E8F2c2ChpyaBfbiz3vN0jU/qYFBhJCPMYq
	 0kAc7UMCxBg2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/21] selftests/exec: test the transparent binfmt_misc
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-14-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
 <20260720-work-bpf-binfmt_misc-ptinterp-v1-14-ddb76c9a508e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:44:46 +0000
Message-Id: <20260720114447.4F62A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stack-based buffer overflow in binfmt_transparent_interp when co=
ncatenating strings into the `expect` array.
--

--- Patch [14]: [PATCH 14/21] selftests/exec: test the transparent binfmt_m=
isc mode ---
commit 9d915ef86186ae5a0a73c74e07d46a93d08f7fe5
Author: Christian Brauner <brauner@kernel.org>

selftests/exec: test the transparent binfmt_misc mode

This commit introduces a transparent dispatch test for binfmt_misc from both
activation paths. The dispatch routes to a shared asserting interpreter that
validates the kernel's constructed identity from inside the process.

> diff --git a/tools/testing/selftests/exec/binfmt_transparent_interp.c b/t=
ools/testing/selftests/exec/binfmt_transparent_interp.c
> new file mode 100644
> index 0000000000000..2a71c47067582
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_transparent_interp.c
> @@ -0,0 +1,130 @@
[ ... ]
> +int main(int argc, char **argv)
> +{
> +	const char *binary =3D getenv("BINFMT_TEST_BINARY");
> +	const char *argv0 =3D getenv("BINFMT_TEST_ARGV0");
> +	char exe[PATH_MAX], real[PATH_MAX], buf[PATH_MAX];
> +	char expect[PATH_MAX + 32];
[ ... ]
> +	/* Distinct from the binary path, so a classic argv splice is caught. */
> +	want[0] =3D argv0 ? argv0 : binary;
> +	want[1] =3D "argone";
> +	want[2] =3D "argtwo";
[ ... ]
> +	/* And so did the kernel's copy of it: the same strings, NUL separated.=
 */
> +	for (i =3D 0, expect_len =3D 0; i < ARRAY_SIZE(want); i++) {
> +		size_t len =3D strlen(want[i]) + 1;
> +
> +		memcpy(expect + expect_len, want[i], len);

[Severity: Medium]
Could this overflow the expect[] buffer?

If the user executes this test program with BINFMT_TEST_ARGV0 or=20
BINFMT_TEST_BINARY set to a string longer than PATH_MAX, expect_len + len=20
could exceed the size of the expect[] buffer. Since there is no bounds=20
checking before the memcpy(), this would result in a stack-based buffer=20
overflow.

> +		expect_len +=3D len;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-work-bpf-b=
infmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org?part=3D14
