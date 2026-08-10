Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96E2D9ECA
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786329569; cv=none; b=ubfjKD3XA83mu4pXkZF922nT1XJy/R9bCgI072HvKp/qQyIDTAflkjTjR85kyNEgChn2Vxbcx77weLPWWchja23QQ0wHRCsIeGwOQtut1N4zlRzTMD5TxudIIapOwh4NEp32cSZeZSv6sY5LQ4GsNXBlYgLGIWf97xkmEZ/t9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786329569; c=relaxed/simple;
	bh=DYKUlGSo57lDWQwKtM9mLqK06XyjLvpRESTUTJnGfIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DObl6oKFqNjiShpt3MWi9+q7UWcHS/BQTdXfkZk0YS1eudc1NmV99aNzr+yGcbIaPRUXyydALEg+HuhBP/rBpzVVvi8Re2J6hmiNkZmoisbD2PkPKnlhwHqzZZN82fTYm1ea+EChBBf0VdyENZQD9UaWg6Fu2JVoDoCHGxZVUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a52Aqy+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a52Aqy+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659F91F000E9;
	Mon, 10 Aug 2026 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786329567;
	bh=DbOVh2CHnXnc52CJGGEvXgxC0kDeHmcA7PzIidJBJUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a52Aqy+gLYIf2dcIzIybunevEzZ4mTzqNTfPLPUOVp+e63NEj/pwl30QG+O++elPW
	 0M6dn8RxbifqNB/3/wtgekqzPZwMlZFv0F+gQl3Vt57whNbva2Fcblq6oaVQnhxgGi
	 hR5BeY5VA5evmI24mHrT6+gby2eaRlgVeq4UQLANBLfy18gtPP+Yf4SZ56PJYoJ3gO
	 nJKzLmOOMK31sO5qvsUQmIziWJDNf6uFWOqQZkuSfTCHAjyb/kaci1Ino6WcP8Pes5
	 94gUfhSJdeaRGf3oUsVVaDwpsgNBHwMlWzgwF5ctZObS/5iGxHCXuMJfh0A/HSf+/x
	 1bUuIJ8Y10u8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] bpf: Fix UAF in bpf_trampoline_multi_attach_free on
 update failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810022304.211544-1-hui.zhu@linux.dev>
References: <20260810022304.211544-1-hui.zhu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 02:39:26 +0000
Message-Id: <20260810023927.659F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Ignoring errors during BPF link detachment leads to a Use-Afte=
r-Free of the `bpf_prog` when ftrace or trampoline updates fail.
- [Critical] The patch is incomplete: it fixes a UAF of the trampoline imag=
e when `bpf_trampoline_update()` fails, but leaves an identical UAF if ftra=
ce direct modifications fail during multi-detach.
--

--- Patch [1]: [PATCH v3] bpf: Fix UAF in bpf_trampoline_multi_attach_free =
on update failure ---
commit 569677dafd5f99230e4a9c93925fbe240c10aadd
Author: Hui Zhu <zhuhui@kylinos.cn>
bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure

This patch modifies bpf_trampoline_multi_attach_free() to only free
old_image if it differs from cur_image, aiming to prevent a use-after-free=
=20
when bpf_trampoline_update() fails. It also changes=20
bpf_trampoline_multi_detach() to return void.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index e07af35ed0402..b76d162517e36 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
[ ... ]
> @@ -1632,7 +1632,18 @@ static void bpf_trampoline_multi_attach_init(struc=
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
> +	 * old_image !=3D cur_image correctly identifies a stale image that
> +	 * is safe to free.
> +	 */
> +	if (tr->multi_attach.old_image &&
> +	    tr->multi_attach.old_image !=3D tr->cur_image)
>  		bpf_tramp_image_put(tr->multi_attach.old_image);

[Severity: Critical]
This is a pre-existing issue, but does this logic leave another window for
a use-after-free if ftrace modifications fail?

During bpf_trampoline_multi_detach(), if __bpf_trampoline_unlink_prog()
succeeds, it updates tr->cur_image to a new image or NULL. If a subsequent=
=20
call to update ftrace fails (for example, a memory allocation failure insid=
e=20
update_ftrace_direct_del()), ftrace is not updated and continues to point=20
to old_image.

Because tr->cur_image was updated, the condition here evaluates to true.=20
This appears to erroneously free old_image while ftrace is still using it,=
=20
potentially causing a crash when the traced function is executed.

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
>  }

[Severity: Critical]
This is a pre-existing issue, but by treating detachment as always
successful here, do we risk a use-after-free of the bpf_prog itself?

If __bpf_trampoline_unlink_prog() fails inside bpf_trampoline_multi_detach(=
),
the error is logged with a warning, but execution continues. In this scenar=
io,=20
the active trampoline image still contains a jump to the BPF program.

Since bpf_tracing_multi_link_release() proceeds to destroy the bpf_link=20
and drops the final reference to the bpf_prog, the program memory is freed.=
=20
However, the ftrace hook remains active and points to the freed bpf_prog,=20
which can trigger a crash when the traced function is called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810022304.2115=
44-1-hui.zhu@linux.dev?part=3D1
