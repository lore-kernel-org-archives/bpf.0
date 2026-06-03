Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFAD391E54
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515940; cv=none; b=ktzJnpof4wb6dUqQCyDOTXttEut0MbEcDU734Y5iNNu/cPfOfRLquFmQ0c/4Sn/X+JqshnAi5LMIR238SGk/ZLzqGgcbHo5VmLV6SLXHiDUTQhRww1FW9nBO3F9c6RWk2juDtTSW/pXFp+yKvQxCFkimvpYpRS7JlYiMEyDVu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515940; c=relaxed/simple;
	bh=nLqnaeiJ+3wt2xV6Gn/xRaaMUZDBircrtE7eif8zo2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cum/moPr+MIlrNB82wPjDm5eWy9USlaA3zDpzD5NBmltZ/FgxQwKUX5PvqhWhq8go4CWv2pDjVuIavc9uH73yNVMFhy5+X/K19zU+NhLms5TyCJSMSYPvlqFOqaUJFUwQb24Zh3ljXWWbcCSKz+j+xEw1v5NSILhKe29uWQ2omg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvhg66Hh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvhg66Hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869171F00893;
	Wed,  3 Jun 2026 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780515938;
	bh=KIqYHJU7oHSoKXzzzPsqJaWqedk+nGw1EXJZM8YJ9Ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yvhg66HhU55QcuNpXVfvdxOJ6bpWcnF3JmmUiaaaG3N9GYIHBWz2lB7y+hgCBD7Px
	 9nB4TZ+WI6tsDoQEQjQb5S06Y/OipcQpg0kVPC9V+feLd77YFprDoVh9ARhzZxOG7e
	 jvx4tzTjkk8UAIyi3klIEWtkhLCJtsSWMNWAR1/fiQPdDhnWc7vIu9z+5QkkoPkCS9
	 AboxJtRgzhKHLUN+eIuPz4lSZfywwFHxbNragYlsufd0kKQJBxc8Y2m9aqZWFJ/ffd
	 4eO6xOJU/W4AgT9ndsfna5VzsE7Qxa3mZvTer0snRbF9myb6lbre/dz0qFYt8Wi9Df
	 oA7D6Q/aOE1wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test signed loader error
 paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603192425.468046-2-daniel@iogearbox.net>
References: <20260603192425.468046-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 19:45:38 +0000
Message-Id: <20260603194538.869171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `sign_bu=
f()` creates temporary files insecurely, allowing a local unprivileged atta=
cker to overwrite arbitrary system files when the test suite runs.
- [Medium] File descriptors for BPF maps and programs created by the genera=
ted BPF loader are leaked on successful test executions.
--

commit 7aafce9894d76167cd91e47285b324f5b6424c29
Author: Daniel Borkmann <daniel@iogearbox.net>
Subject: selftests/bpf: Test signed loader error paths

This commit adds a new test suite which drives libbpf's gen_loader to
exercise metadata hash checking, signature validation, and immutability
invariants.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/too=
ls/testing/selftests/bpf/prog_tests/signed_loader.c
> index 0000000000000..557487250bc6b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
[ ... ]
> +static int sign_buf(const char *dir, const void *buf, __u32 len,
> +		    void *sig, __u32 *sig_sz)
> +{
> +	char data_tmpl[] =3D "/tmp/signed_loader_dataXXXXXX";
> +	char key[PATH_MAX], sigpath[PATH_MAX];
> +	int fd, pid, status, ret =3D 0;
> +	struct stat st;
> +
> +	fd =3D mkstemp(data_tmpl);

[Severity: High]
Does this create a Time-of-Check to Time-of-Use race condition?

Since mkstemp() creates the base file in the world-writable /tmp directory,
a local attacker could monitor the directory, read the random suffix, and
create a symlink for the expected .p7s file before sign-file executes.

Because sign-file writes to the .p7s suffix without O_EXCL, could this
follow the symlink and overwrite an arbitrary system file?

Should this use the securely provisioned dir argument instead of
hardcoding /tmp?

> +	if (fd < 0)
> +		return -errno;
> +	if (write(fd, buf, len) !=3D (ssize_t)len) {
> +		close(fd);
> +		ret =3D -EIO;
> +		goto out;
> +	}
> +	close(fd);
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		ret =3D -errno;
> +		goto out;
> +	}
> +	if (pid =3D=3D 0) {
> +		snprintf(key, sizeof(key), "%s/signing_key.pem", dir);
> +		execlp("./sign-file", "./sign-file", "-d", "sha256", key, key, data_tm=
pl, NULL);
> +		exit(1);
> +	}
[ ... ]
> +static void metadata_match(void)
> +{
> +	struct gen_loader_fixture f;
> +	bool ran;
> +	int r;
> +
> +	if (gen_loader_fixture_init(&f) =3D=3D 0) {
> +		r =3D run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob, f.data_s=
z,
> +				   f.excl, sizeof(f.excl), NULL, 0, true, f.ctx, f.ctx_sz, &ran);
> +		ASSERT_TRUE(ran, "loader ran");
> +		ASSERT_EQ(r, 0, "honest loader retval");
> +	}
> +	gen_loader_fixture_fini(&f);

[Severity: Medium]
Does this leak the generated map and program file descriptors?

The run_gen_loader() execution dynamically creates BPF maps and programs,
writing their file descriptors into the ctx buffer. By the time
gen_loader_fixture_fini() frees the buffer, these file descriptors do not
appear to have been closed.

> +}
[ ... ]
> +static void metadata_ctx_max_entries_ignored(void)
> +{
[ ... ]
> +	r =3D run_gen_loader(gopts.insns, gopts.insns_sz, blob, data_sz,
> +			   excl, sizeof(excl), NULL, 0, true, ctx, ctx_sz, &ran);
> +	if (!ASSERT_TRUE(ran, "loader ran") || !ASSERT_EQ(r, 0, "loader retval"=
))
> +		goto free_blob;
> +
> +	for (i =3D 0; i < nr_maps; i++) {
> +		struct bpf_map_info info;
> +		__u32 ilen =3D sizeof(info);
> +		int fd =3D md[i].map_fd;
> +
> +		if (fd <=3D 0)
> +			continue;
> +		memset(&info, 0, sizeof(info));
> +		if (ASSERT_OK(bpf_map_get_info_by_fd(fd, &info, &ilen), "map_info")) {
> +			ASSERT_NEQ(info.max_entries, GATING_BOGUS_MAX,
> +				   "ctx max_entries ignored for signed loader");
> +			checked++;
> +		}
> +		close(fd);
> +	}

[Severity: Medium]
Are we also leaking the generated program file descriptors here?

The cleanup loop only iterates over nr_maps to close the map file
descriptors, but it seems to omit iterating over nr_progs to close the
created program file descriptors.

> +	ASSERT_GT(checked, 0, "inspected a created map");
[ ... ]
> +static void signature_authenticates_insns(void)
> +{
[ ... ]
> +	r =3D run_gen_loader(insns, insns_sz, blob, data_sz, excl, sizeof(excl),
> +			   sig, sig_sz, true, ctx, ctx_sz, &ran);
> +	ASSERT_TRUE(ran, "valid signature: loader loaded and ran");
> +	ASSERT_EQ(r, 0, "valid signature accepted");
> +
> +	memcpy(tampered, insns, insns_sz);
> +	tampered[insns_sz / 2] ^=3D 0xff;
> +	memset(ctx, 0, ctx_sz);
> +	((struct bpf_loader_ctx *)ctx)->sz =3D ctx_sz;

[Severity: Medium]
Does zeroing out the ctx buffer here lose track of the open file descriptors
from the first successful loader run?

Accumulating open file descriptors across multiple subtests could potential=
ly
lead to resource exhaustion.

> +	r =3D run_gen_loader(tampered, insns_sz, blob, data_sz, excl, sizeof(ex=
cl),
> +			   sig, sig_sz, true, ctx, ctx_sz, &ran);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603192425.4680=
46-1-daniel@iogearbox.net?part=3D2
