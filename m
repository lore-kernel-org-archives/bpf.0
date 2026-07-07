Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DD3DD525
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456434; cv=none; b=F57vHsyhgHh5LvrimLqC21TkENzLIaFWd1t5ZXzgNsC7snElWAG3kxMVl3sXaOUI8aoXa9btUF3pbWOocymt5ki3xBvoyEKTmKljxHx4RiQH/tToCN9VNrIWYGt7QrhOKoJ3Ctg6RS5En3uJbib2y6c6sCT9cXVfI6rCAtkjuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456434; c=relaxed/simple;
	bh=Q5GWFuoij86cei55+3QNhr3PRW2DQhU4GaRJgGsXPS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5r0Kqlh0zNoyUQsGd4N3gG6iVW9JzabW6SLbopi4jGKkrpSNEcyHPTvtOwo8eFYWEFPMJuycZpT0KqmuHc4VgCTIEjksrqJWsneRTqAsoRwgSak0hd9g1OLsI4j9lRA8d0qAeMgwEdejff1klSWe9dk/sIpl5Anj8grfiiZnHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhCcHk7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhCcHk7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EDE1F000E9;
	Tue,  7 Jul 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783456432;
	bh=vzMgxEvQg9pRAsyVDqskaAy4MfYjHWnIcoffMZrECPc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JhCcHk7+XSQT5FugYmbZBxQlf5L8Zr9KQOHHhwnyq+RriL8Nl8d3Ffa9FyYu0dLrL
	 K2MmM7lZzT5nP0tNINaQQx7tjWcxE1wzoiHqvBVRHZsoVM/ADaqRPfEmYZgzG1rHbd
	 PXekBup49hGYjmrDTidbbE1mpHsukP53L0YCyBxnxBOmI8lr4bbZwa64ajJxScag2z
	 qf3UkXDkOxLOBQA37aT6ZCW0DlfMgAnLk53mQc1AVwIe6mYiINpDLP6ZRE50sohgin
	 miQWCaN/QLqzhUW0KJY9GYYudbVMOdJtJmusc9aFOVlvs2VYmSjZTQtmr5AkZT1+jX
	 eA2shzpbL6P1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: fix double-free of distilled base BTF on
 .BTF.ext parse error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <178345549172.94179.7948304165383170781@digiscrypt.com>
References: <178345549172.94179.7948304165383170781@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 20:33:52 +0000
Message-Id: <20260707203352.97EDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] btf_parse_elf() incorrectly uses IS_ERR() to check the return valu=
e of the public API btf_ext__new(), rendering the error path and the patche=
d double-free fix unreachable.
- [High] In `btf_parse_elf`, the out-parameter `btf_ext` is not initialized=
 to `NULL` at the beginning of the function. If the function fails early, t=
he error path reads the uninitialized pointer from the caller and passes it=
 to `btf_ext__free()`, causing a crash.
--

--- Patch [1]: [PATCH] libbpf: fix double-free of distilled base BTF on .BT=
F.ext parse error ---
commit 343ec621fb0622b822c4fef99c23ee0947343232
Author: Naveed Khan <naveed@digiscrypt.com>
Subject: libbpf: fix double-free of distilled base BTF on .BTF.ext parse er=
ror

This patch fixes a double-free in the error path of btf_parse_elf(). By
deferring the ownership transfer of the distilled base BTF until after
.BTF.ext is parsed successfully, it ensures the base BTF is freed exactly
once on failure.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 823bce895178d..35695f33c6942 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
[ ... ]
> @@ -1530,6 +1527,9 @@ static struct btf *btf_parse_elf(const char *path, =
struct btf *base_btf,
>  	} else if (btf_ext) {

[Severity: High]
This isn't a bug introduced by this patch, but immediately before this
else-if block, btf_ext__new() is called and checked using IS_ERR():

	*btf_ext =3D btf_ext__new(secs.btf_ext_data->d_buf, secs.btf_ext_data->d_s=
ize);
	if (IS_ERR(*btf_ext)) {
		err =3D PTR_ERR(*btf_ext);
		goto done;
	}

Since btf_ext__new() is a public libbpf API, doesn't it return NULL on
error rather than an ERR_PTR?

If IS_ERR(NULL) is false, the error path is never taken for malformed
.BTF.ext sections. Does this effectively make the double-free issue
that this patch fixes structurally unreachable?

>  		*btf_ext =3D NULL;
>  	}
> +
> +	if (dist_base_btf)
> +		btf->owns_base =3D true;
>  done:
>  	if (elf)
>  		elf_end(elf);

[Severity: High]
This is a pre-existing issue, but I have a question about the cleanup
path below this done label:

	if (btf_ext)
		btf_ext__free(*btf_ext);

If a caller provides an uninitialized pointer (e.g., struct btf_ext *ext;
btf__parse_elf(path, &ext);) and btf_parse_elf() fails early,
isn't the out-parameter *btf_ext left uninitialized?

Could this cause btf_ext__free() to read uninitialized memory from the
caller's stack and crash? Should *btf_ext be initialized to NULL at the
beginning of btf_parse_elf()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178345549172.94179.=
7948304165383170781@digiscrypt.com?part=3D1
