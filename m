Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C742D74B
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100833; cv=none; b=KAqVjSZHOZb8sTkvglEum9XMChBF3iSkq0J+Ib+yim0Z+HkgLRWoWqMEAt+kymTkVEqx+2iz9ejcLBdTB2s7CWxW18PSzLyQTRO7Qa8OvxtBxzXfxtexdoFWpHdphVC1Z4gwDIBTmTW7fs8cBgodcQa/eq78a1ZBSf/qwyMswLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100833; c=relaxed/simple;
	bh=Gyb0UcEQZfKem5H/Om/UYEld8rlCaO1rBksPTYhUDo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m2R99zV0XSUVcxYUsJbNXbnbOc7LQ5v11VwZCbvdJ2R3gtA8vT9LMvkykHK8kzVqhPsTwR242giTf/ZON6QA/+gc8qnI1u26SNI6gIYBF4mbWh5OUTGrTJtDql2EXYSPF7ghFHfZvb49RuJud5cWbA41FrD1hki5njNm9LS2kX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAT6WrXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAT6WrXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E7A1F000E9;
	Fri,  7 Aug 2026 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786100832;
	bh=nOL+fzjpROp1ss1rsvn5yJJDnRq81F80W6ZgDeDRZsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bAT6WrXsSSUovBbixg8aMPkzUVcj59mEpN51ZSYZIZm0ZmEpMZsauxpoTaIiJZta3
	 Ic3G+cgyye2QkyZXFD7M80DBQbcjrh9RyK3eWJhWlyo5A7eKVD+ntM6Nql2+U1+uRf
	 /uQEnuOuaJ3KK74q36W+UGf6Aoqo7yNcgf0ahEm/Cx5Qtop8xOHWA993jFAHmRQHbc
	 0rQBhSCCH8GC0cc/dBJZKCDoSW1FARz3Q57SzdlB/wYjEyAa/eqG9SdKZXWSi4FFP0
	 5NW3Vqx9dJpl6sAz4fw7sImbLg9SKhsMkIFQq7L91dtmxH3Q0Adqndv7FLmowmn4/w
	 qdiAqx68/Gqng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v6] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260807104403.1013064-1-pulehui@huaweicloud.com>
References: <20260807104403.1013064-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 11:07:11 +0000
Message-Id: <20260807110711.C4E7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing expected_attach_type validation in __cgroup_bpf_replace al=
lows attaching incompatible programs to cgroup hooks via BPF_LINK_UPDATE.
- [High] Lockless reads of link->prog race with concurrent link updates, le=
ading to a Use-After-Free of the BPF program.
--

--- Patch [1]: [PATCH bpf v6] bpf, cgroup: Fix storage null-ptr-deref after=
 replacing prog ---
commit 8ecaeff0e405145eaf841d2d2d05043d5e1a974d
Author: Pu Lehui <pulehui@huawei.com>

bpf, cgroup: Fix storage null-ptr-deref after replacing prog

This commit fixes a null pointer dereference issue during bpf_prog
replacement for an active cgroup link. It prevents the panic by rejecting
link updates if the new program's cgroup storage is incompatible with the
existing program.

Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicl=
oud.com
Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaw=
eicloud.com

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c6..5cc9b2d92fd58 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -1056,6 +1070,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
>  	if (!found)
>  		return -ENOENT;
> =20
> +	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does this function also need to validate
expected_attach_type before allowing the replacement?

In __cgroup_bpf_replace(), the code currently checks:

    if (link->link.prog->type !=3D new_prog->type)
        return -EINVAL;

However, it does not check expected_attach_type. Could an attacker with
CAP_BPF use BPF_LINK_UPDATE to swap a program with a different
expected_attach_type (for example, swapping BPF_CGROUP_UDP4_SENDMSG onto a
BPF_CGROUP_INET4_CONNECT link)?

If the verifier validations are bypassed at runtime, the incorrect context
structures could lead to out-of-bounds accesses and guaranteed NULL pointer
dereferences when the program executes on the hook.

>  	cgrp->bpf.revisions[atype] +=3D 1;
>  	old_prog =3D xchg(&link->link.prog, new_prog);

[Severity: High]
This isn't a bug introduced by this patch, but can this xchg() lead to a
use-after-free of the BPF program when racing with lockless readers?

Following this swap, bpf_prog_put() releases the old program, which is freed
after an RCU grace period. However, generic reader functions access
link->prog locklessly and in preemptible context.

For example, in kernel/bpf/syscall.c:bpf_link_get_info_by_fd():

    if (link->prog)
        info.prog_id =3D link->prog->aux->id;

And in kernel/bpf/syscall.c:bpf_link_show_fdinfo():

    const struct bpf_prog *prog =3D link->prog;
    ...
    if (prog) {
        bin2hex(prog_tag, prog->tag, sizeof(prog->tag));

Since these readers can sleep on copy_to_user() or seq_printf() and do not
hold rcu_read_lock() or take a reference count, could preemption cause the
RCU grace period to expire before prog->aux or prog->tag is dereferenced?

>  	replace_effective_prog(cgrp, atype, pl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807104403.1013=
064-1-pulehui@huaweicloud.com?part=3D1
