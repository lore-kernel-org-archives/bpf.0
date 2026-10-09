Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211B4E4309;
	Fri,  9 Oct 2026 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548720; cv=none; b=EDf4UZpH6+VpranpAltuyKbSgSnaOd8p2IKwznQjnk737/EaFhWO8gfaTisxKomsE7wVK5hUirEIo9EQypgJ8ZlXteMJSPM0lwYI8O20bjiMbzm/HyZ0Ni6WgYdpdy4CPWmjYZXR2STYhu296nUmcHit2SE0ceAs8elCjTkCP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548720; c=relaxed/simple;
	bh=D90RR251TL42XQkdQNivz8BUuDdfDfPcrU0W2dhTXcM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hYJ+rr+2x2fSHeDGg9q6BaAUblE5D1R2ttU+QNUtT+99cVVvhgFPNPDPXnAm6nDvrkNkuIx7Nu4GSGCGpexdgA24uFEpQ2/Xb/UBwgrq+TNPg+r8rbQTKHdHtUsxpZ5RjPyEwR7t3yjC0OxwQw7viVqGwXiG/HXL90aQ28qrnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyXDHxAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyXDHxAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD61F000FF;
	Fri,  9 Oct 2026 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548710;
	bh=uA4IKSnD2SRFAx9kqaxLqh+76Z8Fvkjw7O8i3d4/g7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CyXDHxADugT8n6tlB6BHgzn8b9oHToI+fnOZRI5JPrND26znDufbCT6JVQIOVVmio
	 7Ed2Alsi50VrAQr8V9yGtDjpznambsCfGgGMVYSg5W71T1sX/gS7MVfABmpK0DlVZQ
	 F+cjUAs+C2J0n1F1Sl4/m9z7W3NXrCV7oRqCQzkebZSburGiaiOYE4DdhJ6m95tfIc
	 tWPpzmWSwgbTVGHfsqJRN0mL5C6GH/HxC00qMx/L5Z5ADqHGP3KYKB4WsqD0S7pZRI
	 VaU5hMVi6QW3CDQCSLNNXyysLWGcdRkdxsxpW8zNs2+ntgD+OUb1Hx9vmGPu3XZK46
	 77KU2f1K92ouQ==
Message-ID: <sashiko-outbox-165534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 6/7] selftests/bpf: Test BTF sysfs inline
 representations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>, linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261009112324.1442319-7-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
 <20261009112324.1442319-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:25:09 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: flaky test in test_btf_inline_sysfs_all() due to miss=
ing -ENOENT check
--

commit df90a8288d824aad2169294b18c9baff7baa8c42
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Test BTF sysfs inline representations

This commit adds tests to load vmlinux, vmlinux.inline, and module entries
from /sys/fs/btf to sanity-check inline representations and kernel
relocations. It also tests mmap functionality for vmlinux.inline.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_sysfs.c
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c

[ ... ]

> +static void test_btf_inline_sysfs_all(void)
> +{

[ ... ]

> +	while ((dentry =3D readdir(dir)) !=3D NULL) {

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
> +			if (err !=3D ENOENT)
> +				ASSERT_OK(err, "stat_inline_btf");
> +			btf__free(module_btf);
> +			continue;
> +		}
> +		if (base_btf =3D=3D vmlinux_btf)
> +			test_btf_mmap_sysfs(inline_path, base_btf);
> +		inline_btf =3D btf__parse_split(inline_path, base_btf);
> +		err =3D libbpf_get_error(inline_btf);
> +		if (!err)
> +			btf__free(inline_btf);
> +		ASSERT_OK(err, "parse_inline_btf");

[Severity: Medium]
Is this ASSERT_OK() missing a check for -ENOENT?

When parsing the module BTF earlier in the loop, the code correctly handles
the case where a module is unloaded during sysfs iteration by checking for
-ENOENT.

However, a time-of-check to time-of-use race can occur here. If the module
is unloaded in the small window between stat() and btf__parse_split(), the
parse function will return -ENOENT. This causes ASSERT_OK() to fail and
could lead to flaky tests in parallel testing environments.

> +		btf__free(module_btf);
> +	}
> +	closedir(dir);
> +
> +	btf__free(vmlinux_btf);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112324.1442=
319-1-alan.maguire@oracle.com?part=3D6
