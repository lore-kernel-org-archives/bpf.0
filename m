Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6738F928
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764681; cv=none; b=B7GPUPNeeaG7mtmBOGJ7D/uuu2dizMuqrEpGwghHrsNj5HEm8dwn5l+LoJn9s75/YF8SNuAskr+GQyFrFVj5rqWuDQRM7H+/hDrfz3Y82BLvRNb9STO4/3NopQ6Xi9S5blNnujtl/5JBy8q9asgXa4OpHWVom6FCsIp7iiWH02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764681; c=relaxed/simple;
	bh=XIaB7vtqgYoCePJI7G2LSvSaYog7k0Am/lneJErh8WQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAJIWxCoh3kKV3+j+NkDqc/6vFHQI/CZzfx9lZW7Q23wQahQv+e6IABDMNNtt56G8dNTwGvE9aGHc/y3yAQF2ZartyJglJ0UJ3SpWg9CzAfxWW89YG7c22lAllIXIyisVykmU+nSYh6exxVzjjwbsbiDS9QBbg7LaeWJUonLLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdLwyTdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdLwyTdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C191D1F00A3A;
	Tue, 26 May 2026 03:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764680;
	bh=QQ49nET6z0+FSSiJrUU6kR6I4m02AFAJ2+LYICK6qTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PdLwyTdFW3dcM+D1dI1/wVEUcRvdj/EvuQOWLRqAG+Qm0CL3Yzi/0eNlxJNDnT/c/
	 EcfUMpnoOQV8wao9BQ2fXuPz/5g0V2KoMozWjvRejEeKCWyiY/O8BDD5554Ds+1xFp
	 pHMRnUHaNJ3zlhfvnnva12di8UxOVA4kZPc9+L282CEPWiCKifVwpZdbILp88soyHN
	 tQbk+7lXpE9S5LxLx4b/dPvpMz4HM0uFo0AOWh+/HgCpTePygt9GT2v1n11JF/e8E3
	 tT2NTRnQeqc8LsVCgGLIVklD9YfAQjQAQsFwGc3Z7x9sTmYrRVhVn4KZWKF1kaSYx/
	 lioFEjziXEP3Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 05/11] bpf: Pass flags in
 bpf_link_create for struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: hannes@cmpxchg.org, tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com
In-Reply-To: <8dfc661158419f7331cc645368b051a424229fdc.1779760876.git.zhuhui@kylinos.cn>
References: <8dfc661158419f7331cc645368b051a424229fdc.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 03:04:39 +0000
Message-Id: <20260526030439.C191D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Use-after-free of bpf_struct_ops_link on error path due to con=
current cgroup_bpf_release().
- [Low] Missing UAPI flag validation allows BPF_F_ALLOW_OVERRIDE for non-cg=
roup struct_ops.
--

commit 0fc91684192f5637c6cbd64910eb1eb3203843c6
Author: Hui Zhu <zhuhui@kylinos.cn>
Subject: bpf: Pass flags in bpf_link_create for struct_ops

This commit extends bpf_struct_ops_link to include a flags field, populated
from attr->link_create.flags during link creation. This allows userspace to
pass flags like BPF_F_ALLOW_OVERRIDE when attaching a struct_ops.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index e63f926d87283..45a6cc1d86c83 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -1425,7 +1425,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	struct cgroup *cgrp;
>  	int err;
> =20
> -	if (attr->link_create.flags & ~BPF_F_CGROUP_FD)
> +	if (attr->link_create.flags & ~(BPF_F_CGROUP_FD |
> +					BPF_F_ALLOW_OVERRIDE))
>  		return -EINVAL;

[Severity: Low]
Does this allow userspace to pass BPF_F_ALLOW_OVERRIDE even when
BPF_F_CGROUP_FD is not specified?

For non-cgroup struct_ops, this flag would be accepted but silently ignored
by the kernel. Should this reject the combination with -EINVAL to safely
allow future reuse of the flag bit?

> =20
>  	map =3D bpf_map_get(attr->link_create.map_fd);
[ ... ]
> @@ -1463,6 +1464,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  			goto err_out;
>  		}
>  	}
> +	link->flags =3D attr->link_create.flags;
> =20
>  	err =3D bpf_link_prime(&link->link, &link_primer);
>  	if (err)

[Severity: Critical]
Can this error path trigger a use-after-free on the link object if
cgroup_bpf_release() runs concurrently?

If cgroup_bpf_release() iterates the struct_ops_links list and processes
the link before bpf_link_prime() returns an error:

Thread 1 (cgroup_bpf_release):
    bpf_link_inc_not_zero(link);
    link->cgroup =3D NULL;

Thread 2 would see this in the bpf_struct_ops_link_create() error path:

kernel/bpf/bpf_struct_ops.c:bpf_struct_ops_link_create() {
...
err_put_cgroup:
    if (link && link->cgroup)
        cgroup_bpf_detach_struct_ops(link->cgroup, link);
err_out:
    bpf_map_put(map);
    kfree(link);
    return err;
}

Since link->cgroup was set to NULL by Thread 1, the error path incorrectly
skips cgroup_bpf_detach_struct_ops() and unconditionally calls kfree(link).

Because Thread 1 still holds a valid refcount, won't it later call
st_link->link.ops->detach() and bpf_link_put() on the freed link memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D5
