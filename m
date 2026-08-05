Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B6489882
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903442; cv=none; b=m9fUAlmD11dMziFVTUZQzqxz8lDKGcSNVyfURnsO+4Ox1k7bKb2UzEv40yytwubWhQttGKxwrdRLTkwo5ekd3+fCS9j44Wzb2vu9ULZ4UMI3gjn540yYpEtSym83vDNljmNV9cuEGo+phvJSoY7aL3LDJIkOfKjjyLv0ihN/8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903442; c=relaxed/simple;
	bh=oWYMTQhfBpQfliQTr/h5IBFAacusXejEyyqaq80Hkbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivpEt2zBkWLO2h35KjGuQqMe91l/tWEmTFGMSeIysQtmS79MO5alZI4kWBDZri7RxVmTdSpRc53nucFXME/s1hUtOJlSm4lLMYqHrhilhe+fw0ViSughem0KO55UMx6KbvDR/+Wu3vZ5fNWDutW5aawhx1dCAbKxQy7HFvshx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk4bBFm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk4bBFm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729191F000E9;
	Wed,  5 Aug 2026 04:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785903440;
	bh=maYhxj+Ygo/BlFGY3AFkgNNJebGaxWXJnqIS/G3MlBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dk4bBFm4QUNl5fcfsT2MHyxC/Zn4MCnOIPqGFoRJtm1R8DGN4AOuW1rE/0ZyLvPmr
	 nleepOg9EZnheOdxQp9oFvuayfGI+55pxDrMOJJy3BBYIrX55ixsMIgQuCWVFXqVrJ
	 dpoOmkJMxxZ8Z+3qv9TqyzaXVdEeifzCXh6WXYVMMBD5nwG46hcVb3TdofxQ+qFNv9
	 lBRzTlvbfOYzJTE6IQCounCXi7PRd9GyycgZCNwZJN+vTQUw4O+LxI0YfsRDWhZ9/o
	 32EYir5LFo5D5gxpX5H4xjEE7JFSIi3fSPY5IH5aQJ1kFIcYjrO0wRL0OieMq0R1xA
	 B7D/54ezxmiYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix prog UAF in
 bpf_trampoline_multi_attach() register-path rollback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <6edcc3d19ab91511372a9c3f00d90fdc66a31d83.1785902527.git.zhuhui@kylinos.cn>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
 <6edcc3d19ab91511372a9c3f00d90fdc66a31d83.1785902527.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 04:17:19 +0000
Message-Id: <20260805041720.729191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Memory leak of pinned BPF program on consecutive ftrace update f=
ailures.

Pre-existing issues:
- [High] Use-after-free of BPF program if trampoline image allocation fails=
 during detach.
--

--- Patch [2]: [PATCH bpf-next v2 2/3] bpf: Fix prog UAF in bpf_trampoline_=
multi_attach() register-path rollback ---
commit d47fe23104c85648ed4814b819490191dd04b447
Author: Hui Zhu <zhuhui@kylinos.cn>

bpf: Fix prog UAF in bpf_trampoline_multi_attach() register-path rollback

This commit fixes a use-after-free in bpf_trampoline_multi_attach() where
ftrace rollback failures could lead to the trampoline image and attached
program being unconditionally freed while still active. It resolves this by
pinning the program to the current image if the register-path undo fails.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index c08d1a09e6381..7fac27374ece1 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1744,8 +1746,47 @@ int bpf_trampoline_multi_attach(struct bpf_prog *p=
rog, u32 *ids,
> =20
>  rollback_unlink:
>  	for_each_mnode_cnt(mnode, link, rollback_cnt) {

[ ... ]

> +		if (via_register && err_undo_reg && rtr->cur_image) {
> +			WARN_ON_ONCE(rtr->cur_image->pinned_prog);
> +			bpf_prog_inc(prog);
> +			rtr->cur_image->pinned_prog =3D prog;

[Severity: Medium]
Can this result in a memory leak if multiple operations fail on the same
trampoline?

Since pinned_prog is a single pointer, if multiple programs attached to the
same trampoline experience ftrace update failures, the previous program
appears to be overwritten without releasing its reference.

Is there a way to track multiple pinned programs to prevent permanently
leaking the bpf_prog and its associated resources in this rollback path?

> +		} else {
> +			bpf_trampoline_multi_attach_rollback(rtr);
> +		}
>  	}
> =20
>  	trampoline_unlock_all();

[Severity: High]
This isn't a bug introduced by this patch, but does a similar use-after-free
exist during detach if trampoline image allocation fails?

If a user detaches a program but bpf_tramp_image_alloc() fails (e.g. from
memory pressure), __bpf_trampoline_unlink_prog() removes the program from
the active list but leaves the image unchanged:

kernel/bpf/trampoline.c:__bpf_trampoline_unlink_prog() {
	...
	bpf_trampoline_remove_prog(tr, node);
	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
}

In bpf_trampoline_multi_detach(), the rollback logic requires old_image to
differ from cur_image to pin the program:

kernel/bpf/trampoline.c:bpf_trampoline_multi_detach() {
	...
		if (tr->multi_attach.old_image &&
		    tr->multi_attach.old_image !=3D tr->cur_image &&
	...
}

Because the image allocation failed, old_image =3D=3D cur_image, which bypa=
sses
the program pinning logic. The caller bpf_tracing_multi_link_release() will
then unconditionally drop the program reference via bpf_prog_put().=20

Could this allow ftrace to execute the freed BPF program memory since the
active ftrace image still contains direct calls to it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785902527.gi=
t.zhuhui@kylinos.cn?part=3D2
