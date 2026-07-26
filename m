Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C9224DD17
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785079164; cv=none; b=baCf42wPdkgk8LwQOeMrWgBavVG5fv8KN+yiIZ6mM/LdDGK5cGemkRjjf+gT+zxe4xqCpl3jF2xjcFTR5a7izBdAqEGBOM6EtO9Kg7JkXdtCvyyocN4fNFXll9+WzWKgSAmdUSQ5sC8v7zXpC2mT1nQXMq70UiT/7NdXbOtutgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785079164; c=relaxed/simple;
	bh=NpWdyAKwPj4X4WcZG5Kt5k//gei4TocvG47gzmaoagQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iL8dx0T/PqtAazpWRL+k4pm9lMk94D9ijVFGQ8IL2L09WL5coTPuucFLmTjnDMZjPafM48raXaiHLZSHEOrnmwH5ywv2uW4TwuNBg48CrD8/cG698EWbdVd5fU94ogj8y7wdHlJIsUE1LyXdU082EzrhojptIjAA81QLd8CDY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luCssmwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luCssmwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F3B1F000E9;
	Sun, 26 Jul 2026 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785079163;
	bh=g8SAOM01gvt/O4ZlOYb8jpDDXdYr7Dj5mXstS5RreC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luCssmwWYhMZHEK//prTQ0HIm+qBzJUrb2XIxiQ/WtsfPymLTF3s8xWev0UceAc36
	 ogbihKjXl1QftD6PgXYBmb4hBiZIc4KqqJKidewf3tF+jbE8zuy/AkABzGzGY1ZNl/
	 QUl6Ds6ebIymz32IU2nr5eUSQiH7ooqF8o43NQdI9/bKjamkTd/14z0Qm02Mo/4by+
	 meoCmQBD/LsIhVxnvPvhY6lhFMph08n9+gxLPcRteKcbIVUZikP3Ndipx5TLG0k+NF
	 HIDEGbEOamoqKtsC6DPbFsKMuQk8derMqvN4Ag0f83OKNLUCbRFLiOFsn7+btXoQBj
	 F8RsZszvHZ10w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Log error code on trampoline unlink
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin16@zte.com.cn
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn>
References: <20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 15:19:22 +0000
Message-Id: <20260726151922.C9F3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free due to flawed teardown design when bpf_trampoline_u=
nlink_prog fails
--

--- Patch [1]: [PATCH bpf-next v2] bpf: Log error code on trampoline unlink=
 failure ---
commit 8f743682724c96c3eba346cdcf6a1a3646dc28bd
Author: xu xin <xu.xin16@zte.com.cn>

bpf: Log error code on trampoline unlink failure

Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
code from bpf_trampoline_unlink_prog(). This aids debugging of race
conditions during link teardown.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d5..9cbe00bc8d051 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3547,10 +3547,13 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>  	struct bpf_tracing_link *tr_link =3D
>  		container_of(link, struct bpf_tracing_link, link.link);
> +	int err;
> =20
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> -						tr_link->trampoline,
> -						tr_link->tgt_prog));
> +	err =3D bpf_trampoline_unlink_prog(&tr_link->link.node,
> +					tr_link->trampoline,
> +					tr_link->tgt_prog);
> +	if (err)
> +		WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path lead to=
 a
Use-After-Free?

If bpf_trampoline_unlink_prog() fails (for example, due to a memory allocat=
ion
failure in bpf_tramp_image_alloc() during bpf_trampoline_update()), the cal=
ler
logs the error here but continues the teardown process.

Because the update failed, the old active trampoline image remains register=
ed=20
with ftrace or direct calls. However, the link teardown will unconditionall=
y=20
free the linked BPF program:

kernel/bpf/syscall.c:bpf_link_dealloc() {
    ...
    if (link->prog)
        bpf_prog_put(link->prog);
    ...
}

Furthermore, bpf_trampoline_put() might also free the trampoline itself whi=
le
ftrace is still calling it. This happens because the program was eagerly
removed from the hlist before the update failed, allowing the emptiness che=
ck
to pass:

kernel/bpf/trampoline.c:bpf_trampoline_put() {
    ...
    for (i =3D 0; i < BPF_TRAMP_MAX; i++)
        if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[i])))
            goto out;
    ...
    direct_ops_free(tr);
    kfree(tr);
}

Can a subsequent ftrace invocation hit the freed trampoline or execute the
freed BPF program and cause a crash?

> =20
>  	bpf_trampoline_put(tr_link->trampoline);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726230724742Z4=
CDN9ntFInEofAf2YxME@zte.com.cn?part=3D1
