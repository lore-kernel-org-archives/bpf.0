Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4515345753
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779530910; cv=none; b=aVlyNILubKQtZOr3b935yFv/0xRXmT7fvfWkEbW9iS4uh1PS7omtRRE8+cBfYcOSAAtZWxau/kz2gU3+k+qEOy9JMvcrt1Wd5/n8fYOyy0/Viti3Qif6+ICV9HiSdSnZ9F/63qUZyxXYcMjh4mcJ6YxBdDrtvaQKz/bEMn+rU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779530910; c=relaxed/simple;
	bh=oKFundsfiZ8How+jTrbT7HNuqvCyo8PSQCgsOQkQLQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d44aEVfZM5yVvNDHOiG5Eot2/0nmCzf8hT4l+yCFv3V5W2X35H5i9+UMOenJ0aKXuW5QIjQzCBcDUVWhvfTCWtwhO95raMVS87p1fN939Vktvalo/VHojLohusMaIpuchCBl+j9EjHECLWPr/iSVFrRdXOM1Fd4B3whLgBQDgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgwPhPOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgwPhPOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584DB1F000E9;
	Sat, 23 May 2026 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779530909;
	bh=J3vWKTmATVCwd5BAXxgYLejn+r5UwHI/s6gfTN+dgFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CgwPhPOTEZu7IObpvZRKGM5xwCOciYh2lcIrunPaR50QvE37u/3f4N4+mXx++pndk
	 GXUiyv5xpiGjyjTNldyiQdqo3zSFhoiE2eStsneG7JcmJRUP6kzWTdlwAbPcelB1Bn
	 o4LS8gUIhpm57WLUGXDXSk/WLcZOSurOdBLesogGFsNR9Zo7t+mPNIsxRP+6N0p/9F
	 5UfWjwXXDkv8gK7+Lvu1KqC0jtLoenAOhtllrpOqn5El9DacdlxE+9M5o6ZbAtlMfF
	 hqQ9ELFcdKdDC+44PdyY0NiAufqoErt8mqiXkGMJyXTwc4oVcPTTU/67yMyp7F/+Z6
	 3/W+y7Qffpq8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add return value tests for lsm
 cgroup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523085806.417723-3-xukuohai@huaweicloud.com>
References: <20260523085806.417723-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 10:08:28 +0000
Message-Id: <20260523100829.584DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] BPF test programs for the `socket_create` LSM hook incorrectly decl=
are `struct task_struct *task` as their argument instead of `int family`.
--

commit b7003df7335bb1051987324aa639e3088d3673b5
Author: Xu Kuohai <xukuohai@huawei.com>

selftests/bpf: Add return value tests for lsm cgroup

This commit adds tests to check return values set by the bpf_set_retval()
helper for lsm cgroup programs.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/tes=
ting/selftests/bpf/progs/verifier_lsm.c
> index 38e8e91768620..2072671ed6439 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c

[ ... ]

> @@ -188,4 +188,49 @@ int BPF_PROG(null_check, struct file *file)
>  	return 0;
>  }
> =20
> +SEC("lsm_cgroup/socket_create")
> +__description("lsm_cgroup with -4095~0 retval test 1")
> +__success
> +int BPF_PROG(lsm_cgroup_set_retval_zero_valid, struct task_struct *task)

[Severity: Low]
Is this argument type correct for the socket_create hook? The LSM hook for
socket_create expects (int family, int type, int protocol, int kern), so
the first argument should be int family.

Using struct task_struct *task incorrectly casts the first integer argument
to a pointer. While it works here because the argument isn't dereferenced,
could this cause issues if this code is used as a template and the argument
is accessed in other tests?

> +{
> +	bpf_set_retval(0);
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523085806.4177=
23-1-xukuohai@huaweicloud.com?part=3D2
