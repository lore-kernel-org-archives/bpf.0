Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22046400DF0
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498600; cv=none; b=DM/kiJRd/GDUSxLUKETsOUoX0fBy6yRBJoyNtXai2YQY+rk16mxc/Zfo+H5hWTHgzPl8k73Z8Xk9+vuOH01UufwN+iv91DUBfguiW/GZKgAWmbTKR1w+4IHzGwjFSq80GCp5++abhYwxd/l0BuXr2g1j+UM4IYNH5kMvKvfDAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498600; c=relaxed/simple;
	bh=EJkO6acW9sNYd0oVTeqOs1/Z1IgcJlk6dcl1Nx2K2lM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rrLgBhu4AfwibMr9BcYd0N2RB2W3KVkJoavxP20zQhE4bb/WUM3/cPv96HUxOXLM6XPTzsGLTOgyli5v7w6D4AyfF0qPgIJQvnsYEW8S1YgZIs59VPBIYLKNTVrrBg1qdTZ/rYQLLsp7lCwTYUC6RjIGJ5S1TBLgrwP7o7XGbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Lvgc5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Lvgc5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12501F000E9;
	Wed,  8 Jul 2026 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498599;
	bh=6avrYTMumpeMMmCkDdNEZL/rA+mVqtjmnzNJzRGD1Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+Lvgc5rPL3ztquP03s0oJcAH/c7MPB8iIqksrDsKPEw58JnCAt3ZxKOgFH5UH90P
	 UTdLwGL1+vEIT1ZiI4ZbO8p1f+yx7FR/3gPwgN+b/WrhokR/n3hppFWxwf99cmYciT
	 s9457OUETlmvTJmJcT6uRl6/bIIixwFWEn43si5Oxegn8VYkmO885F5CimnfuUoGAy
	 s2ExhnDFaW2nbTFpz2YtjZQcG/7O3XnWv/5pxuJym1hDFRzWPpx9s0cXoySjYLezFv
	 uQTG4GoET37shuawFVlnkFod5Qk/UUhAbqiOs3p61G115uniLEoy9Ujl8ockmmPmhR
	 pYfFF5VgiUC4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 09/10] selftests/bpf: move bpf_jit_harden
 helper into testing_helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-9-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-9-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:16:38 +0000
Message-Id: <20260708081638.D12501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The refactored `set_bpf_jit_harden` function has been moved to a=
 common helper file and stripped of its internal `ASSERT_FAIL` calls. Howev=
er, its usage in the cleanup path of `check_blindness()` was not updated to=
 check the return value. Consequently, if restoring the sysctl fails during=
 cleanup, the test will silently leave the system-wide `bpf_jit_harden` con=
figuration in an altered state.
--

--- Patch [9]: [PATCH bpf-next v4 09/10] selftests/bpf: move bpf_jit_harden=
 helper into testing_helpers ---
commit 806a4cb4e9c458805fd71ac7ae0f57e00e8af6bc
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: move bpf_jit_harden helper into testing_helpers

Move set_bpf_jit_harden to testing helpers so that other selftests can
change the hardening configuration without re-implementing a helper.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/to=
ols/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 0222a9a5d0761..37c405fc2b0d2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -227,42 +227,6 @@ static void check_incorrect_index(void)
>  	check_mid_insn_index();
>  }
> =20
> -static int set_bpf_jit_harden(char *level)
> -{
> -	char old_level;
> -	int err =3D -1;
> -	int fd =3D -1;
> -
> -	fd =3D open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
> -	if (fd < 0) {
> -		ASSERT_FAIL("open .../bpf_jit_harden returned %d (errno=3D%d)", fd, er=
rno);
> -		return -1;
> -	}

[Severity: Medium]
Since this function's internal ASSERT_FAIL() calls were removed when moving=
 it
to testing_helpers.c, are we missing an error check in the cleanup path of
check_blindness() where it restores the sysctl?

tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c:check_blindness() {
    ...
cleanup:
    /* restore the old one */
    if (bpf_jit_harden !=3D '@')
        set_bpf_jit_harden(&bpf_jit_harden);
    ...
}

If restoring the sysctl fails during cleanup, this will silently leave the
system-wide bpf_jit_harden configuration in an altered state. Should the re=
turn
value of set_bpf_jit_harden() in the cleanup path be checked and asserted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D9
