Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4907274B46
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994220; cv=none; b=Y2K3ykrQJN+hWog8VVBnIbaDaM7uGG7Ssa1SmDi4RSgbr30M0ot+b5yQnw/luyUXNVDtZqj/gkRVmOaYGwbpUoqWdxRhygPd4HLpsnOcuZVjHgKYEeVqRpwIGHYw7EkdAaPaYrzJQAbwhpdrZOjnS27HZHmf+/Jj4opK627eoBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994220; c=relaxed/simple;
	bh=DF0hp91yBA2IJAFlxnvAzo4MEGhvESd1wlh0lLOgcv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J6x842roEXOOWt3va7PGhe8pn+nvgHzJNSoP2xO8qhFiO+nB1S5cRlyQc3Iv9iOTOegw9HVsmM8Mwyr4905xKppFfZ7xhFbovGzJTm3hAFc05c3pdN+Zfa6aauOxSxXlYhCMSxonSOF8RUkI9DTMMGaWqsX+evstDabRfufWjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnLi6X7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnLi6X7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123021F000E9;
	Tue, 14 Jul 2026 01:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994218;
	bh=uGED9+bBGopQk5/M4o06ZLz5Qw/uCUpjgvFcOkchivw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnLi6X7ytg+Upj8IrCIWCCtZxMOvWy5qXIlXnOZ0GdK/0I6ucU7QZ2/hOa6Z4h/Jr
	 3aHc8qiAWDOUZUATq52+zqVPILL8IeR3S04k1krQQl5uxb0uNeCpCRktNtU3EeW1A9
	 KLhEU8gbc7yyRB0S0zWGmOBswAEfPm9Gd+EXQ1pBK+YZyjkxwHdTwcPs6QDGi4GfhQ
	 7Icu2Yc7moPEeFBxDqFSc8gLeYAvbLle30nPgerPdKDV0OXmu6oeOphJ4wvy/MQL5R
	 p8I72bXdHsVN9dyZl2c7CRZ+LE3ZZfiFSXFKuSCbo/JLaqil53NOUmVNOpSaMc/UEz
	 kPjRHmazUWzeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714014659.401063-1-pulehui@huaweicloud.com>
References: <20260714014659.401063-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:56:57 +0000
Message-Id: <20260714015658.123021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In-place updates of `item->cgroup_storage` in the active RCU-prote=
cted `bpf_prog_array` cause data races with concurrent RCU readers, leading=
 to NULL pointer dereferences or Out-Of-Bounds memory accesses.
--

--- Patch [1]: [PATCH bpf] bpf, cgroup: Fix storage null-ptr-deref after re=
placing prog ---
commit 3d155d588030a7a30403e9ee7737c108f47b5cb3
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix storage null-ptr-deref after replacing prog

This commit fixes a storage null pointer dereference when replacing a
program by allocating, assigning, and linking the required cgroup storage
for the replacement program during link_update.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c6..52b5b685a93c5 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1014,6 +1014,7 @@ static void replace_effective_prog(struct cgroup *c=
grp,
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
>  		item =3D &progs->items[pos];
> +		bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);

[Severity: High]
Does this in-place update of item->cgroup_storage create a data race with
concurrent RCU readers?

If CPU1 is executing bpf_prog_run_array_cg() under the RCU read lock and
starts running the old program:

CPU1:
bpf_prog_run_array_cg()
    while ((prog =3D READ_ONCE(item->prog))) {
        run_ctx.prog_item =3D item;
        func_ret =3D run_prog(prog, ctx);

And CPU2 concurrently replaces the program with one that doesn't use storag=
e,
it updates the storage in-place:

CPU2:
replace_effective_prog()
    bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
    WRITE_ONCE(item->prog, pl->link->link.prog);

If CPU1's executing program then calls bpf_get_local_storage(), it could
read the updated NULL storage pointer while still executing the old program:

CPU1:
bpf_get_local_storage()
    storage =3D ctx->prog_item->cgroup_storage[stype];
    if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
        ptr =3D &READ_ONCE(storage->buf)->data[0];

Could this lead to a NULL pointer dereference or out-of-bounds access?

>  		WRITE_ONCE(item->prog, pl->link->link.prog);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714014659.4010=
63-1-pulehui@huaweicloud.com?part=3D1
