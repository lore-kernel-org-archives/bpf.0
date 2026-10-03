Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810C388392;
	Sat,  3 Oct 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057301; cv=none; b=u5gvl8UGFyZbvYe/yS6bjZ5yqT6hYbPOEN2w7RNyXuFs0T7pwzBRKTKeZUPK47TnghWXKcTDtXAtb3aM0Vo+VZckwVV+fPXfrq6f93ouH8ETSX7gVmqsKAHIfVVlC0/mXk3pVIV0vkvbydm4Bbv5ta4ur90NX4GoO/CO6PPOQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057301; c=relaxed/simple;
	bh=0hrGlVJCRfOMt5ho8I4qSbnBHd6OOpTx0PeOwbgffUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m18rfEndaJ2jX56DXmdWkLwuas9tP4ZBN7mau7Nm4ECn8w6VHpAyeqKknb0zvFe5gopsPdLpEyBsxZ8vtQwPDA4FOmpqPYScRODs6JzAx/Wp2jyzX8/ENts8xdT9QLOq1uDMRZaDnPfFCUlKX5yGum6xf1uGWw3jde4SvrmLRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K43i6YCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K43i6YCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DA31F0089C;
	Sat,  3 Oct 2026 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057299;
	bh=7e8M0cFq/O+bIlh0i6f0BWbV1X1TEEnxm8EJQQ/Cyh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K43i6YCFhJnXE/w1xGWNXwXqNoj7G+ShqnUdq2PdA2PMlKilpvfuVpfiY2ok5nTlV
	 F1H9HBUxbmGjAdtFyyeI5dWRigwn0nZ/QvGfKFrgF4iXMhukvdARB+VKb5Wn1HlvGQ
	 jUCrEsYjSzALN8Akz0oA8hl3ykARMt41au8oWE2sAHAFL5JPU3jhAsFqFMlKlyBhyk
	 lexflYKmjyQ1bqHnT9LMNfAXLYi012wrmmsV5fGzDZwuagy8wAgia1P4EBg3dJDS5E
	 6+jCOlU8/CkT31Z84CWrzb9iWgW1cbhGupHY/mulCYTAEmqiKiBHaI5MkEkNVOVODV
	 0xGGpR6xAwswQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 6/7] selftests/bpf: Test BTF sysfs inline
 representations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>
In-Reply-To: <20261003194323.817885-7-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
 <20261003194323.817885-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:54:58 +0000
Message-Id: <20261003195458.E5DA31F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpf: module_btf memory leak when .inline sysfs entry is missing
- [Low] bpf: missing continue statement after unexpected stat() failure lea=
ds to cascading failures
- [Low] bpf: partial memory leak on unexpected mmap success in btf sysfs te=
st
--

commit de628b5a108fca7fc52dbae8ef2aa0fc5fbd85bd
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test BTF sysfs inline representations

This commit tests BTF sysfs inline representations by loading vmlinux,
vmlinux.inline, and all module/module.inline entries in /sys/fs/btf. This
verifies the kernel and module inline representations and sanity-checks
relocations.

There is a minor memory leak on an error path in test_btf_mmap_sysfs()
when the mmap with an invalid size unexpectedly succeeds:

tools/testing/selftests/bpf/prog_tests/btf_sysfs.c:test_btf_mmap_sysfs() {
    ...
	raw_data =3D mmap(NULL, end + 1, PROT_READ, MAP_PRIVATE, fd, 0);
	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
		goto cleanup;
    ...
cleanup:
	btf__free(btf);
	if (raw_data && raw_data !=3D MAP_FAILED)
		munmap(raw_data, btf_size);
    ...
}

[Severity: Low]
Does this leak the final page allocated by the end + 1 size?

If the oversized mmap unexpectedly succeeds, it allocates an extra page, but
the cleanup label only unmaps up to btf_size.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_sysfs.c
> index 3923e64c4c1d0..069c4483b3a21 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c

[ ... ]

> @@ -75,7 +80,78 @@ static void test_btf_mmap_sysfs(const char *path, stru=
ct btf *base)
>  		close(fd);
>  }
> =20
> +static void test_btf_inline_sysfs_all(void)
> +{

[ ... ]

> +		if (!base_btf) {
> +			module_btf =3D btf__parse_split(btf_path, vmlinux_btf);
> +			err =3D libbpf_get_error(module_btf);
> +			if (err) {
> +				/* A module can be unloaded while its sysfs entry is iterated. */
> +				if (err =3D=3D -ENOENT)
> +					continue;
> +				ASSERT_OK(err, "parse_module_btf");
> +				continue;
> +			}
> +			base_btf =3D module_btf;
> +		}
> +		if (stat(inline_path, &st)) {
> +			err =3D errno;
> +			if (err =3D=3D ENOENT)
> +				continue;

[Severity: Medium]
Does this early continue leak the memory allocated for module_btf?

When an .inline file does not exist, the continue statement bypasses the
btf__free(module_btf) call at the bottom of the loop. Since most modules
might lack this representation, this could leak memory for every module.

> +			ASSERT_OK(err, "stat_inline_btf");
> +		}

[Severity: Low]
Should there be a continue statement here to avoid cascading failures?

If stat() fails with an error other than ENOENT, the code asserts but falls
through to parse the nonexistent or inaccessible inline file instead of
jumping to the next iteration.

> +		if (base_btf =3D=3D vmlinux_btf)
> +			test_btf_mmap_sysfs(inline_path, base_btf);
> +		inline_btf =3D btf__parse_split(inline_path, base_btf);
> +		err =3D libbpf_get_error(inline_btf);
> +		if (!err)
> +			btf__free(inline_btf);
> +		ASSERT_OK(err, "parse_inline_btf");
> +		btf__free(module_btf);
> +	}
> +	closedir(dir);
> +
> +	btf__free(vmlinux_btf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003194323.8178=
85-1-alan.maguire@oracle.com?part=3D6
