Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF334F259
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343245; cv=none; b=D+1n/G/8SigXKmaBz36VGSgOtlxYiiO4l5loTm7Y5VcxCYOSyf50gcqNFQlHEmJOSSqrAcz456kBPULrS5xHLHKcY8YXR2dPWtRnfB4z2SlwZ3N6WQOdoRWKhxxUeHT7Y9pdwwVQCKI6VfeiYavYtyScwOjPDd+D03++N7FWsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343245; c=relaxed/simple;
	bh=CHunTucNbI3s6OeTZHbM2Yceh+oAzbqjzV9TfbVVOuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nR8T7jvcIS8FnMLViSca910hrRt8i3XlSSoQg9KhsOxBHgpjD/hPvLatI9V8M/Z+6flC0UliajoMEmRCeGwX510Tf2DcOH26nXFeJq1vwuC8HoxMCxmK4TCglk/I1qGYlj3Mj0E5GjPGZwQwr1EUIJN0hmSYV64Yd6qZk4m6gHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi0mOBPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi0mOBPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555121F000E9;
	Mon, 10 Aug 2026 06:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786343243;
	bh=MlVtDYidM/jZcYli/X9qjWyxWUVUh8Nr9TWBn6NlFjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mi0mOBPg4MBCf6VlSxV6IFbEXxh/l9CronYiNtf01wqo6HojhOOB1oP6ssDR+Mnu2
	 I8n0PsCz5++Xa8rCEF5j14/Mp9FvHZaukwAky+b7PPOUOa6CKlsKMnDK9W6Mi3+GQm
	 8R+08hFwZm8DwjYcBor3qnmctj69f8VgOPHSLZItPlQwijrKwfTyXa+24y8XJFPfVT
	 5fuO/llnWa+9TwXWWU08ADFWhTPBDZ9RReRHA+WOsfKm1QNZU5P8pVTr5LB27iQgmY
	 L6hOfk7Is0nBs78ivLaVW9IK5EIRuVeBM/Nj0QV5tVOVk+pNgQC/3gQB/nyg6UjeaE
	 wnVBoEELRsMAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] bpf: Fix UAF in bpf_trampoline_multi_attach_free on
 update failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810061329.224276-1-hui.zhu@linux.dev>
References: <20260810061329.224276-1-hui.zhu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 06:27:22 +0000
Message-Id: <20260810062723.555121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ignoring errors from `__bpf_trampoline_unlink_prog()` during detac=
h leads to a Use-After-Free of the BPF program.
- [High] Ignoring errors from `update_ftrace_direct_del/mod()` during detac=
h or attach rollback leads to a Use-After-Free of the trampoline image.
--

--- Patch [1]: [PATCH v4] bpf: Fix UAF in bpf_trampoline_multi_attach_free =
on update failure ---
commit 12049949b83ebddc54a6fdad57fa0b635706dbda
Author: Hui Zhu <zhuhui@kylinos.cn>
bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure

When bpf_trampoline_update() fails before modify_fentry_multi() or
unregister_fentry_multi() is called, cur_image is unchanged and ftrace still
calls into it. Freeing old_image in that case causes a UAF. This patch only
frees old_image when it differs from cur_image, and makes
bpf_trampoline_multi_detach() return void.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e07af35ed0402..90b70ea0d3709 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1632,7 +1632,17 @@ static void bpf_trampoline_multi_attach_init(struc=
t bpf_trampoline *tr)
> =20
>  static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
>  {
> -	if (tr->multi_attach.old_image)
> +	/*
> +	 * Only free old_image if it is no longer the active image.
> +	 * When bpf_trampoline_update() fails before modify_fentry_multi()/
> +	 * unregister_fentry_multi() is called, cur_image is unchanged
> +	 * (cur_image =3D=3D old_image) and ftrace still points to it. Freeing
> +	 * it would cause a UAF when ftrace calls into the freed memory.
> +	 * On success, cur_image is either a new image or NULL, so
> +	 * old_image !=3D cur_image means the image is stale.
> +	 */
> +	if (tr->multi_attach.old_image &&
> +	    tr->multi_attach.old_image !=3D tr->cur_image)

[Severity: High]
This is a pre-existing issue, but does this condition still allow a
use-after-free of the trampoline image if ftrace updates fail?

If __bpf_trampoline_unlink_prog() succeeds in bpf_trampoline_multi_detach(),
the active image is updated and old_image !=3D cur_image will be true.

However, if the subsequent update to ftrace fails due to memory pressure:

    if (ftrace_hash_count(data->unreg))
        WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));

ftrace will return an error without updating its hooks, leaving ftrace
pointing to the original active image (old_image).

Since old_image !=3D cur_image is true, won't bpf_trampoline_multi_attach_f=
ree()
then free old_image while ftrace is still executing it?

A similar issue appears to exist during error rollback in
kernel/bpf/trampoline.c:bpf_trampoline_multi_attach() if
update_ftrace_direct_del() fails, leaving ftrace executing newly allocated
images that are subsequently freed.

>  		bpf_tramp_image_put(tr->multi_attach.old_image);
> =20
>  	tr->multi_attach.old_image =3D NULL;

[ ... ]

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 891897f8a1b35..29260951aa871 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3687,7 +3687,7 @@ static void bpf_tracing_multi_link_release(struct b=
pf_link *link)
>  	struct bpf_tracing_multi_link *tr_link =3D
>  		container_of(link, struct bpf_tracing_multi_link, link);
> =20
> -	WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> +	bpf_trampoline_multi_detach(link->prog, tr_link);

[Severity: High]
This is a pre-existing issue, but does dropping the program reference here
lead to a use-after-free if __bpf_trampoline_unlink_prog() fails?

In kernel/bpf/trampoline.c:bpf_trampoline_multi_detach(), if unlink fails:

    err =3D __bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline, N=
ULL,
                                       &trampoline_multi_ops, data);
    WARN_ONCE(err, "__bpf_trampoline_unlink_prog failed: %d\n", err);

the detach path ignores the error. The ftrace direct hook remains active and
the active trampoline image remains unchanged, keeping its hardcoded call
to the BPF program.

Since bpf_tracing_multi_link_release() proceeds to drop the link's reference
to the BPF program, if the program's refcount drops to zero and it is freed,
could ftrace continue to jump into the freed program?

>  }
> =20
>  static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810061329.2242=
76-1-hui.zhu@linux.dev?part=3D1
