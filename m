Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65BA3B960F
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687635; cv=none; b=BYw7/zg0GeGS6yxuy/wKychu5A9ncop1YLgOeJ7V2FxTMvEsFX6DqCQRW2kFZIudFzPtCDg2cTuHov4F27R1JbVLUvP4MrpgbYesAIAAU9DsnFQWBhm736t/3s9rOuJxlZunaBn7TLGBwER+7jm4XGHvKOMau56ShrcJ7uSi35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687635; c=relaxed/simple;
	bh=3ukju+2BzvUM86FVtSzhLZm9MCUxIf8xZbh3LYs/wQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WO/1orPV/MUk0MHwO8EgclT2q4+6Wv7CT0SheijW3OojRpFz13M5/n/iDsO7jiyA03ywnrQqBgpM/2Wvq3UyqHq4SQP4+TLZZ9PHjnAN9VCiBs9GSniquAol2RP3PchV00RD4Q5+h4jNECS5OQrDFA6yckjyZErxru7FADLBxFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBWDIL0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBWDIL0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B6A1F000E9;
	Wed, 17 Jun 2026 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781687633;
	bh=gF3mHhDYhqRXNoifrMB+F1Mo12Uxrsu2NbvXJuFcfuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBWDIL0/SIzvkMbHLOyDZUp7nzIVJDKxSso//CMq5PAMMNmgqWm6zs7+rHOJ+ZmVC
	 IGqoBnQhdiPyOYJ/LpUvDvCBNVukpxoefQiCyM8qbBFBE1A+jTUC/+4rRCrojP0OKS
	 xnfEWhex874vSmVjAcRDcZRXu0qDJbk9P3wE43NonTQgekAJDyQnOE7Mf6W8hxBimI
	 bgwirrogMPXu0INMQFlR8iM3+iePJitTkl5GdRJvxc+JM/XTnusu3mECeM4Mx9Qa9j
	 3vJM0JPrjmgIVqWHNXBzpTfbEWjEQZc6ja1c3SWL+kSTnNrWXHdUp0K9NvSGCrQElS
	 Gv5FWou/Gof/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools/bpf/bpftool: Fix vmlinux BTF leak in cgroup
 commands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
References: <24357C69B4405079+20260617090117.280222-1-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 09:13:52 +0000
Message-Id: <20260617091353.75B6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpftool map and struct_ops commands in batch mode cause a Use-Afte=
r-Free due to missing NULL assignment of the btf_vmlinux global after freei=
ng.
--

commit 0812ae583a5122b98ffb4e25bf0e712dcec5d4d5
Author: Yichong Chen <chenyichong@uniontech.com>

tools/bpf/bpftool: Fix vmlinux BTF leak in cgroup commands

This commit fixes a vmlinux BTF leak in the bpftool cgroup show and tree
commands. It ensures the BTF object is loaded only once during a tree walk
and properly released with the global pointer reset, preventing issues in
batch mode.

> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index ec356deb27c9e..ce69d1e5468e3 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -78,6 +78,13 @@ static unsigned int query_flags;
>  static struct btf *btf_vmlinux;
>  static __u32 btf_vmlinux_id;
> =20
> +static void free_btf_vmlinux(void)
> +{
> +	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +	btf_vmlinux_id =3D 0;
> +}
> +

[Severity: High]
This isn't a bug introduced by this patch, but seeing your proper fix for
resetting the btf_vmlinux pointer here makes me wonder if batch mode is
still broken for other commands.

Do map and struct_ops commands have a use-after-free in batch mode?

Looking at tools/bpf/bpftool/map.c in do_dump(), it frees the global
btf_vmlinux but doesn't set it to NULL:

tools/bpf/bpftool/map.c:do_dump() {
    ...
exit_free:
    free(fds);
    btf__free(btf_vmlinux);
    return err;
}

In batch mode, a subsequent map command calling get_map_kv_btf() would see
a non-NULL dangling pointer and reuse it instead of reloading the BTF:

tools/bpf/bpftool/map.c:get_map_kv_btf() {
    ...
    if (!btf_vmlinux) {
        btf_vmlinux =3D libbpf_find_kernel_btf();
    ...
    *btf =3D btf_vmlinux;
}

The same pattern appears in tools/bpf/bpftool/struct_ops.c where
do_struct_ops() calls btf__free(btf_vmlinux) without setting it to NULL,
and get_btf_vmlinux() reuses it if it's not NULL.

Should these other files also be updated to correctly reset btf_vmlinux
to NULL when freeing, similar to your fix for cgroup commands?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/24357C69B4405079+20=
260617090117.280222-1-chenyichong@uniontech.com?part=3D1
