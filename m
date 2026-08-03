Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758042F7F1F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721838; cv=none; b=fqQWWpBHhr2Ul5lDYZJ+tn0wiBK+HaVqOH9diMv85axCyd56RCYpf0TS2eyX9bJgtkXLX69dotjnzYlieGHPsq+oE2RzR0KzblZpY5PBSI000KVTPll2AMmh8royk04VHSELp9jpPP9TzKXZalxAEjo06TpDNf0LX24ADWzhY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721838; c=relaxed/simple;
	bh=LSw6b7s3OpjvX0k8ZpAdh5znTOmqr7Xlze+4SAjV6D4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GylV77JdjG0ZmuWGbNHbolKQUS5zj2JmKXe6XlkXfzvcxU/jczgjRq9/giSuzUNiJkAby5NV8ZC80J50iUnQgOMJAogoFe1bkCpiu6b8NsXzFbih/FdHFdBvG0OHmbxP26zAtw5l5gHwiR02ffTD8e2qF+1tKOfAJOZQV0nbco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diNn8oA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diNn8oA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F71F00A3D;
	Mon,  3 Aug 2026 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785721837;
	bh=axm8MQai3qDuVDIFrJIeq0ylnfxg9GaX04OZ9TpUEao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diNn8oA6r1JEf2t4azcur5rw9TByEDKQvT95cHc4Myhjrqs0M/50mUGXbzxcXGNtY
	 5T9P8LJ6Cug6jsZLdVtZgj+Uuvcl2CKuA2d4M/T8GrgWQRq9RZLFIWa2QQmwgg8f/G
	 FyN1S19usYBBhwIE9YZm3L7VsW7ag2zuhuSOg1egWS6Utk7vaiFA/Oura+B7MZM0S6
	 6WModdeHeb6utFQZQhJ1Wfeu7cS0MlS5TuO/ujisAbvlbfBbQRBXifFLqcp8GMVbGt
	 ALYCM+afmpW0YErHX7pKV/J03mfB7oyu13mKHqYRDYY1Y14xvLFVQsyAZm38zMOA3l
	 e7lTfUljI07/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3] bpf, cgroup: Fix invalid storage access after
 __cgroup_bpf_attach failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803013934.4036646-1-pulehui@huaweicloud.com>
References: <20260803013934.4036646-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 01:50:36 +0000
Message-Id: <20260803015036.E47F71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] When updating a cgroup BPF link via `bpf_link_update`, `__cgro=
up_bpf_replace` does not allocate new `cgroup_storage` for the new program =
and lacks map compatibility checks, leading to severe out-of-bounds kernel =
memory access.
--

--- Patch [1]: [PATCH bpf v3] bpf, cgroup: Fix invalid storage access after=
 __cgroup_bpf_attach failed ---
commit 91e5396c1d1312a251035a5e4902151e56fc5bdf
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed

This commit fixes a potential invalid storage access issue when replacing a
cgroup BPF program in multi-attach mode fails midway. It saves the old
program's state and storage prior to the update, and properly restores them
in the cleanup path on error.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c6..57fd1d784e440 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

While reviewing this file, I noticed a potential issue in __cgroup_bpf_repl=
ace():

> static int __cgroup_bpf_replace(struct cgroup *cgrp,
> 				struct bpf_cgroup_link *link,
> 				struct bpf_prog *new_prog)
> {
[ ... ]
> 	cgrp->bpf.revisions[atype] +=3D 1;
> 	old_prog =3D xchg(&link->link.prog, new_prog);

[Severity: Critical]
This is a pre-existing issue, but does this function properly handle
cgroup_storage when replacing the program?

If a user replaces an existing cgroup BPF program using bpf_link_update with
a new program that uses a BPF_MAP_TYPE_CGROUP_STORAGE map with a larger
value_size, could this result in an out-of-bounds memory access?

It appears we swap the attached BPF program on the link here without
verifying that the new program's cgroup_storage maps have identical
value sizes to the old program, nor do we allocate new appropriately
sized storage buffers.

Since the verifier authorized the memory access for the new program based on
its larger map size, could bpf_get_local_storage return the smaller old
buffer leading to out-of-bounds read and write accesses?

> 	replace_effective_prog(cgrp, atype, pl);
> 	bpf_prog_put(old_prog);
> 	return 0;
> }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803013934.4036=
646-1-pulehui@huaweicloud.com?part=3D1
