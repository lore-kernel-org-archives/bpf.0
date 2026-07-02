Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71D35202D
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003722; cv=none; b=DAvgzYyHb7JRDfRXI7QSd4zzz3ndd8EJnnp2717ivrAfSrbtnAdTGb3mnl+/tKuftiovvNLelN4WWrO5JRRpdmn2+KiE3xdPR5cYK0keWPAt9WKNfoF1J4yvMPJNvFrdBzPunu1x/bIYUBzjDT2rX+LsSJzhh5JlWTWjUUrtnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003722; c=relaxed/simple;
	bh=r1KbzCKwOoA9Umv8Nid7WMcHoDENG0mQY4ItHEU3wXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k0l5ZeAg4h/HqxN+5B+EZYVkUKt1phN4iHXnqg5osFMfNJttLJbuw/tvfF77SgjASR56gHk8wD0PJZt+GKzn0s62CfgA5B7NtmRIs4PW4TCUSEr2iD16atAZeyDhlqRPa8p/7BAM1/bmZgYgsvpnkGqeJKWcmaC7fA2OrQh+wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVQxc2kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVQxc2kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDBB1F000E9;
	Thu,  2 Jul 2026 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003721;
	bh=Na6KlzwsmH1mOlmO6enzKo5WiuCN7axllwvjPgHObNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVQxc2kpAhiej4/Clk9iCPEspVzp/gxjSAvUCi4TU4jzQuhZ5Fv7ik2L+J4fAFxuu
	 0NC7JhzDjbwMRcPFSFuJ0ykwiWTN+uDlX3//jibPR1j+7/EXI2q+JGmlOjLqrUwi1U
	 1ZiN8Jo1ZXbjkZBfeVenBEzMsx0qyDhxlfZVWx9yqOHe23HMNL22noLkYY6orK8dje
	 SR9f1IHfEK7+4VLzKOX1/mcraT1BmIApZ68c+EAj8rQIGv3kdmuqBUSUgIbr6sVtci
	 nZwLT4ZdSPzQtIERg3OrGZn229So9J1aGLGelZ9hCJnLPV4POiaZvqG3zE6Hw7/oq6
	 e0zbYv/aQAu4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: Verify load-time signed
 loader metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702143605.252797-6-daniel@iogearbox.net>
References: <20260702143605.252797-1-daniel@iogearbox.net>
 <20260702143605.252797-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 14:48:40 +0000
Message-Id: <20260702144840.EDDBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] In `signed_btf_fd_array_rejected()`, if `gen_loader_fixture_init(&f=
)` fails partway (e.g., `bpf_object__gen_loader()` fails), it returns non-z=
ero and the code jumps to the `out` label. Because `have_fixture` is set to=
 `true` only *after* the function call, the cleanup block `if (have_fixture=
) gen_loader_fixture_fini(&f);` is bypassed. This causes a memory leak of r=
esources like `f.skel` which were partially allocated by `gen_loader_fixtur=
e_init()`. Setting `have_fixture =3D true` before the call (as correctly do=
ne in `lsm_signature_verdict()`) would prevent this leak, since `gen_loader=
_fixture_init()` zeroes the struct before allocation.
--

commit 029153a8d1d1ffbf9c42e3430f45b09e6533827c
Author: Daniel Borkmann <daniel@iogearbox.net>
Subject: selftests/bpf: Verify load-time signed loader metadata

This commit updates the signed gen_loader selftests to verify load-time
metadata enforcement. The kernel now folds the loader's frozen exclusive
fd_array maps into the signature at load time instead of checking it from
within BPF. The patch adds multiple test cases to ensure the signature
logic and bounds are strictly enforced.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/too=
ls/testing/selftests/bpf/prog_tests/signed_loader.c
> index 5fc417e31fc61..b3ac3d9b0e316 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
[ ... ]
> +static void signed_btf_fd_array_rejected(void)
> +{
> +	char dir_tmpl[] =3D "/tmp/signed_loader_btfXXXXXX", *dir =3D NULL;
> +	__u32 sig_sz =3D 8192;
> +	int map_fd =3D -1, prog_fd =3D -1;
> +	unsigned char *buf =3D NULL;
> +	struct gen_loader_fixture f;
> +	bool have_fixture =3D false;
> +	struct btf *btf =3D NULL;
> +	union bpf_attr attr;
> +	int fds[2];
> +	__u8 sig[8192];
> +
> +	syscall(__NR_request_key, "keyring", "_uid.0", NULL,
> +		KEY_SPEC_SESSION_KEYRING);
> +	dir =3D mkdtemp(dir_tmpl);
> +	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
> +		return;
> +	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
> +		rmdir(dir);
> +		return;
> +	}
> +	if (gen_loader_fixture_init(&f) !=3D 0)
> +		goto out;
> +	have_fixture =3D true;

[Severity: Low]
Does this leak partially allocated fixture resources on failure?

If gen_loader_fixture_init(&f) fails partway through its setup, it returns
non-zero and the code jumps to the out label.=20

Because have_fixture is set to true only after the function call succeeds,
the cleanup block at the out label:

    if (have_fixture)
        gen_loader_fixture_fini(&f);

is bypassed. This skips the cleanup of resources like f.skel which may have
been allocated prior to the failure.

Should have_fixture be set to true before calling gen_loader_fixture_init()
so that any partially allocated resources are safely torn down?

[ ... ]
> +out:
> +	if (btf)
> +		btf__free(btf);
> +	if (map_fd >=3D 0)
> +		close(map_fd);
> +	if (have_fixture)
> +		gen_loader_fixture_fini(&f);
> +	if (dir)
> +		run_setup("cleanup", dir);
> +	free(buf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702143605.2527=
97-1-daniel@iogearbox.net?part=3D5
