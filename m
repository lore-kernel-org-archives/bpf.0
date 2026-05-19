Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8183438AE
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231002; cv=none; b=L1xWn0x8R16gErkTOxxW9VKM4CmJAsUmkpTjHWC45OD/nfy+8DPjPZOuO41lq03H7ehcjqrn+pwUSvN94dJzm2qoohl9c12/b5kngCjoHmAZZFIqeZql5AYgwrylcvTeSuZvm2C8H33awlD5RdtPw6MzROZH6qfktHUeQ+e1Yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231002; c=relaxed/simple;
	bh=b50tP0UTUp8u09Ccu1cTazWih0EBTYvyvjvA4Y4Ja7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JISVdWsOGneITi6u2MCLFr2GNCQSHifBOQuvWchbb9OQZ//m146Kh0XTHJZXGtNNyi21poOHdfk++W+0SfnxzLPxeCvEh+CDYjdCtGLLvYRvAvh5OBxFJV4QUIae//7lxWAAruokgtr/niaaAb0FHsWSYFzDBw9kC9CxWWhve4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQQoazai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQQoazai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4F81F000E9;
	Tue, 19 May 2026 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231001;
	bh=S8V9QSNpHgkJrPm5sy37mdOPsh9paB802xJd+qufjXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQQoazai4rT/jE2/0jiRMeGRDnhGw5pEmE107TLefwICDErm08CKOmE2zykWipwSC
	 jR2uFsNNy43KDDZlAakx9ga+eOqCAjl/WBT+7Mph5EjkRZHqFK9QcrVlfDdHe63oPa
	 ojNm1Uk712JvMcWkU9xAivw5HmPrmA48Tk+zg/AEn/YIYgOqdgXnQnasQsWRLKVKro
	 KHD5N+0oenUD7PPP0LW20nok/FwxM8gGATsd1ErkZrJymwlWIYSWD3v8uDiznUzBKt
	 49DIVw2Z5L/4rIToIv7PiCTTVuaof5mPJLvlwIIu0Ayt/hnPt8W8HE8iogUsKHJwIh
	 YPSBPQTmDy/XQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 04/12] bpf: Remove unnecessary
 prog_list_prog() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Martin KaFai Lau" <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519215841.2984970-5-martin.lau@linux.dev>
References: <20260519215841.2984970-5-martin.lau@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 22:49:59 +0000
Message-Id: <20260519225000.EF4F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] replace_effective_prog() incorrectly uses absolute indexing in=
to the bpf_prog_array, failing to account for dummy programs left by failed=
 detach operations.
--

commit 77c3b439749a112ce3763d2ced5be03b93639458
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Remove unnecessary prog_list_prog() check

This patch removes the !prog_list_prog(pl) checks in replace_effective_prog=
()
and purge_effective_progs(). It cleans up conditions that are not expected
to happen, serving as preparation for attaching struct_ops to cgroups.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 876f6a81a9b61..71591f6dc4581 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -946,8 +946,6 @@ static void replace_effective_prog(struct cgroup *cgr=
p,
> =20
>  			head =3D &cg->bpf.progs[atype];
>  			hlist_for_each_entry(pl, head, node) {
> -				if (!prog_list_prog(pl))
> -					continue;
>  				if (pl->link =3D=3D link)
>  					goto found;
>  				pos++;

[Severity: Critical]
This is a pre-existing issue, but does using pos as an absolute index here
cause problems if a prior detach operation failed?

When __cgroup_bpf_detach() fails to allocate a new array via
update_effective_progs(), it falls back to purge_effective_progs().
This fallback uses bpf_prog_array_delete_safe_at() to replace the detached
program with a dummy program in the active array, and then removes the
detached program's node from the cgroup's hlist.

Later in replace_effective_prog(), we iterate the hlist to calculate pos.
Because the detached program is no longer in the hlist, pos represents the
logical index of the program (skipping the dummy program).

However, looking at what happens immediately after the found label:

found:
        BUG_ON(!cg);
        progs =3D rcu_dereference_protected(
                desc->bpf.effective[atype],
                lockdep_is_held(&cgroup_mutex));
        item =3D &progs->items[pos];
        WRITE_ONCE(item->prog, link->link.prog);

The code uses pos as an absolute index into the array (progs->items[pos]).
Because the array still contains the dummy program, the logical index
calculated from the hlist no longer matches the absolute index in the array.

Could this cause the wrong item to be overwritten, leaving the original
program pointer in the active effective array? Since the caller (like
__cgroup_bpf_replace()) drops the reference count of the replaced program,
would this directly lead to a use-after-free when the cgroup BPF hooks are
subsequently executed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215841.2984=
970-1-martin.lau@linux.dev?part=3D4
