Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8B3BBFD2
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192138; cv=none; b=n3CW08paGQfxXaGXjSlJQLh3WwZoy0wdK53nINz5Gy8/Kw+AWnNDsvjxpPm9nbRMSvrKW2kO1H9QmAyqnjXPXlNxTQGr0qvfX8ymsg8iDfvD56F2YaJKpZuNjRPi9AlrInPMclpGmGSay8HPieVsbeGeBIHxgdcPG3ByQJ/SKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192138; c=relaxed/simple;
	bh=1CwbXjjeMKa5QP83hChL0YIVcbivtHyc/jDJ0KNGddE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vv8f4jz5oiZlcpjhI9y8xFbMS29tc60zy+G49Q4EJmLnjJJNCT58W2YfadRrPdOGLhwjqxNsoaLMSwXMH/6CficoJrEUXMXUsoUPFXzlOHDfpkgvQOFuNkmv4iS1AU9Riy+WZjs/21yclVgrWg8zfDqxOPFfWtygoW8Eiat5NBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs7iYMyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs7iYMyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1258C1F000E9;
	Thu, 16 Jul 2026 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784192133;
	bh=O8mBw6MDKWGC8IMw7KD6N1giam7twGluWFt1wieFigQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vs7iYMykiMx8vH3VlHuiVAnZtuYrrsW6/TZnsIQKPRv+jv7uz5ib78vFhd7tlZeR0
	 p3f0sTA3pNxA0I9YxN87gBrSrLB3tb0cZXCQU081YVpM8laB3SrK2PK6lD4ks817yn
	 CT1QXk1tifp/52LDeTp14fMRt2x5+FFWQCZ0GQDo+a3UjkHeuIuFSI/xHN+u32HqdF
	 HBO1EHBdZF+HbHNomwXicveynOB3JGnspM/fopXL/4jseRX+Hd2VXhz5+3smLGR2+5
	 dCLqdBFjNv8zeEDnekGDlOsYstgj7bYtf2dLabLP+NBkpveQMglnkHrkwFsf6zw9GZ
	 Im/WqqyP4dZXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpf: Fix UAF in
 bpf_trampoline_multi_detach when ftrace update fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <d1fcbede8f311db5cfa7cbe34371de7b63186ce5.1784191209.git.zhuhui@kylinos.cn>
References: <cover.1784191209.git.zhuhui@kylinos.cn>
 <d1fcbede8f311db5cfa7cbe34371de7b63186ce5.1784191209.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:55:32 +0000
Message-Id: <20260716085533.1258C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Rolling back the trampoline image during detach introduces a memor=
y leak of the trampoline image and its executable page.

Pre-existing issues:
- [Critical] Failing to update ftrace during detach causes an exploitable U=
se-After-Free of BPF program memory.
--

--- Patch [2]: [PATCH bpf-next 2/2] bpf: Fix UAF in bpf_trampoline_multi_de=
tach when ftrace update fails ---
commit 74c497eb28abb2878db6016026226008d3d6f7a6
Author: Hui Zhu <zhuhui@kylinos.cn>
Subject: bpf: Fix UAF in bpf_trampoline_multi_detach when ftrace update fai=
ls

This patch updates bpf_trampoline_multi_detach to capture ftrace update
failures and uses a rollback mechanism to prevent freeing the old trampoline
image while ftrace still points to it.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -1734,13 +1734,41 @@ int bpf_trampoline_multi_detach(struct bpf_prog *=
prog, struct bpf_tracing_multi_
> -	for_each_mnode(mnode, link)
> -		bpf_trampoline_multi_attach_free(mnode->trampoline);
> +	for_each_mnode(mnode, link) {
> +		struct bpf_trampoline *tr =3D mnode->trampoline;
> +
> +		/* If the batch ftrace update failed for this mnode's path,
> +		 * ftrace still points to old_image. Use rollback to restore
> +		 * cur_image to old_image (putting the new cur_image if any)
> +		 * so the trampoline keeps the image ftrace is calling.
[ ... ]
> +		 */
> +		if (tr->multi_attach.old_image &&
> +		    tr->multi_attach.old_image !=3D tr->cur_image &&
> +		    ((err_unreg && !tr->cur_image) ||
> +		     (err_mod && tr->cur_image)))
> +			bpf_trampoline_multi_attach_rollback(tr);

[Severity: High]
Does this rollback leak the trampoline image memory?

In a successful detach, tr->cur_image is typically set to NULL. By calling
bpf_trampoline_multi_attach_rollback(), we restore tr->cur_image to
tr->multi_attach.old_image instead of freeing it.

When the link is subsequently destroyed, bpf_trampoline_put() is called.
Because the BPF program was already unlinked from the trampoline earlier in
this function via __bpf_trampoline_unlink_prog(), tr->progs_hlist is
completely empty.=20

This causes bpf_trampoline_put() to directly free the trampoline structure:

kernel/bpf/trampoline.c:bpf_trampoline_put() {
    ...
    if (hlist_empty(&tr->progs_hlist[BPF_TRAMP_FENTRY]) &&
        ...) {
        ...
        kfree(tr);
    }
}

Because bpf_trampoline_put() expects tr->cur_image to be NULL when no
programs remain, it does not free it. Is there another mechanism that
will eventually clean up this restored image, or is it permanently leaked?

[Severity: Critical]
This is a pre-existing issue, but does keeping the old image active still
lead to a use-after-free of the BPF program itself?

Even though the rollback preserves the trampoline image so ftrace can safely
call it without faulting, the BPF program was already unlinked by
__bpf_trampoline_unlink_prog().

Since bpf_trampoline_multi_detach() unconditionally returns 0, the caller
proceeds with tearing down the link, ignoring the ftrace detachment failure:

kernel/trace/bpf_trace.c:bpf_tracing_multi_link_release() {
    WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
}

This continues to bpf_link_dealloc() which calls bpf_prog_put(link->prog),
freeing the BPF program's memory.

Because the ftrace hook could not be removed, won't ftrace eventually fire
and execute the preserved old_image, which contains hardcoded direct calls
to the now-freed BPF program?

> +		else
> +			bpf_trampoline_multi_attach_free(tr);
> +	}
> =20
>  	trampoline_unlock_all();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784191209.gi=
t.zhuhui@kylinos.cn?part=3D2
