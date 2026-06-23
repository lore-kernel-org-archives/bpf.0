Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152FF3C4563
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200173; cv=none; b=px1G/X+xYYc7s9Wcu63GjG+QyPylTVnRGOLd3AUlEsYIhfPIaXqU3rudXE5R4mXz+NRB/XTTTrfE6GLgku+j0wn9kgwsEeXSxQ9Nd6MSCK3V+LIhlsv8hfEHlFkd5fHarbaA0O/LcDplZTO/NcFVaRvYzUnDHf6TZB6kVYSeJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200173; c=relaxed/simple;
	bh=d6mPOsqCkwAu594skfKVms9q8DnQ30I2mPleheSM15A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EfvCgnWX+ErX+S/fQHXskvQLrKqZ1iMtsj7O1bFLAcZUf+8UWS+ZQW0ntnWskarFZboyfFVwzvdJn5ZvaIAd7IvTIEOXxSkGI4b6UkCiZPlcy9ojif9KjjOjl325CZ02kNt9Ia0JND1jUyYyjWMmra/hVIh2J7FE7klnE3TR81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/feItCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/feItCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FC21F000E9;
	Tue, 23 Jun 2026 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782200167;
	bh=tKa5Bxv2KzCgi4a1Nzz7HeIvnRgCO0Ocz2W13L2Biic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/feItCFzxbmWCmdvGnmi2cLOhj4up7nWFVtcOpPC+YSHJkQQDnvosjQp/IK3BYgw
	 1pYJ9uUpkKQDmu++Q7P10YzfLexQLABauSoD/KGu5HXK5GRX0cUEcO6tGzdIHFlYdn
	 9MhjfyWd8cKvB+jC0d25VfzG7JeIcb3ggusLlVEZxwyWcw3Hhe6HBaK8gOvYw8a2vp
	 6s9PK4oYMDQtV7pTNPwk+5Nqy6Hrgh28B34ZPfOEqL0AHFRv9SNBsTr7K1jHpRsQ+s
	 V4GmJWKggeYb6gSVm2Eh5Ja+N3SUWOyeCTRFiLsfUdFNJda7NAK3zjezZR+2mRONUx
	 1YmCTn4u/DqaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] tools/bpf/bpftool: Reset vmlinux BTF after
 struct_ops commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <871EC84E76334A24+20260623072220.1421837-3-chenyichong@uniontech.com>
References: <20260623072220.1421837-1-chenyichong@uniontech.com>
 <871EC84E76334A24+20260623072220.1421837-3-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:36:06 +0000
Message-Id: <20260623073607.27FC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Severe memory leak of the btf_vmlinux object during cgroup tree =
traversal or repeated cgroup commands in batch mode.
--

commit f6cbf97292c743366f83c8ee625e792b14e79b4f
Author: Yichong Chen <chenyichong@uniontech.com>

tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands

struct_ops frees the global btf_vmlinux object. In batch mode, a later
struct_ops command can reuse stale state. This resets the BTF pointer
and cached map info state.

> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_op=
s.c
> index aa43dead249cb..4dba7c96e5f60 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
[ ... ]
> @@ -642,7 +651,7 @@ int do_struct_ops(int argc, char **argv)
> =20
>  	err =3D cmd_select(cmds, argc, argv, do_help);
> =20
> -	btf__free(btf_vmlinux);
> +	free_btf_vmlinux();
> =20

[Severity: Medium]
This is a pre-existing issue, but while you are fixing the batch mode state
for struct_ops, could a similar btf_vmlinux memory leak be occurring in
cgroup commands?

Looking at tools/bpf/bpftool/cgroup.c:do_show():

	btf_vmlinux =3D libbpf_find_kernel_btf();

In batch mode, does every cgroup show command overwrite the global
btf_vmlinux pointer without freeing the previous BTF object?

Similarly, in tools/bpf/bpftool/cgroup.c:do_show_tree_fn():

	btf_vmlinux =3D libbpf_find_kernel_btf();

During a cgroup tree command, nftw() calls this function for every cgroup
directory. Does it load a new kernel BTF object each time and overwrite the
global pointer without freeing the previous one, creating a leak that scales
with the size of the cgroup hierarchy?

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623072220.1421=
837-1-chenyichong@uniontech.com?part=3D2
