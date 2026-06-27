Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4802D12EC
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782573134; cv=none; b=ugbzWvARFDZCe5yXEjXLQ73cQ9AcEuiD8FVXey7qHuVGlNwMRQXbLRJxzGdWLeRK08s0MIF71nd/0FIYsD6tM/idv+aZG/55+uIo6CDYyZpqzwoKbDG0sgopJM6u4Tw6fplxQyT/FT1p0nJsc7z7gMxtMvoohmO77sh86fwzeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782573134; c=relaxed/simple;
	bh=g7Yv5tPOiNi3n50ZLI4G66BKZxKC/OajcgYbI4bsaOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vGYMna0ytjex8jli72gKTFKBfn7VONfs6blr64kd6oGC3f/aSUiAIhNItjjT6w/VqPHaM4UXTnMwhTfLAWaXb4KeVcExqY7iE1IyIFMGMFZN+AZ10yTfx5jspjdhA7gOAXEtTgo563UfZIpkmg1ADkqskf5JBTXYuuD9nHcBza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRVmVaVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRVmVaVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44851F000E9;
	Sat, 27 Jun 2026 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782573132;
	bh=sr9srG2ukVA6Qd6Z7vuUew7HiVy5Avqj+g1WGGXRj5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CRVmVaVwfg318BEt6Q4Fk+QsIOSEH5ndcgaij5+K95prDx339jRSfPW+jQ20DKeCl
	 lmXP/BcIjRYbU66jWltfkvqECzoBU+hbLN1CyBZrJbzyEFco4S6gKNKazR1YzenQqq
	 I5YsTjzYMOh3yW5LlXFCZXJZVmFdrDxvSzPX1hf681rVfZhKIy6NU+MBjxOC90HZyX
	 3nr7GZrquW+UIleJgFJsQ/6XjX0m6Py6Fn3aYaFVOTwUu3t0RzZ7X/l59ZtCAPILxU
	 ecjCw+2HhyjisWEyRkRxsP1FIiRnrkQsxvOsd5RdbJuPdbraPiRrado2svX4TW37iJ
	 dWOU9obnS2Nuw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 08/12] libbpf: Add libbpf support to load
 SDT observer program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Kuohai" <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <b097ab082dc6cdde03ace4ad53e9e52b567a976d.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
 <b097ab082dc6cdde03ace4ad53e9e52b567a976d.1782571533.git.xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 15:12:11 +0000
Message-Id: <20260627151211.C44851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The SEC_DEF for the newly added `bpf_sdt` section is missing its=
 attach function (`attach_trace`), which completely breaks auto-attaching f=
unctionality for SDT programs via libbpf and BPF skeletons.
--

commit 507bbcea213558e6c107385fb1d4d27318f9df5b
Author: Xu Kuohai <xukuohai@huawei.com>

libbpf: Add libbpf support to load SDT observer program

This commit adds libbpf support for loading SDT observer programs. It allows
passing the target BPF program file descriptor and probe name to the kernel
so that the kernel can look up the probe in the target program's SDT map.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index dbc08a1931015..273991b80f8f7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -10587,6 +10595,7 @@ static const struct bpf_sec_def section_defs[] =
=3D {
>  	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
>  	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
>  	SEC_DEF("usdt.s+",		KPROBE,	0, SEC_USDT | SEC_SLEEPABLE, attach_usdt),
> +	SEC_DEF("bpf_sdt",		TRACING, BPF_TRACE_SDT, SEC_NONE),

[Severity: Medium]
Is the attach callback missing from this SEC_DEF? Without a fifth argument
like attach_trace, the prog->sec_def->prog_attach_fn pointer will be NULL,
which silently skips auto-attach functionality for SDT programs when users
call a BPF skeleton's __attach() function, forcing developers to manually
manage BPF link creation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782571533.gi=
t.xukuohai@huawei.com?part=3D8
