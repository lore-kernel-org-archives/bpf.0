Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C74343893
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201513; cv=none; b=FY1l7VOSQH6XK9taD4MJ988I8TUE01UFI4lZA6u8Ijyvfn6euF5ILRN6rU9ubhTtIPEJPBFuNW4pNfO1J96iQbYrdQ6WDFts7ZAApSxZuYx5gorsE04khtc0RXNEDGQv92ewub4c3WI0BigpMKJMKJuRJLrJazGHaso/7ZFmOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201513; c=relaxed/simple;
	bh=juszH9PpbNPuuz4sihmM7uv5EdbRb4p4kmmmofGdMrc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=JB6obltVj6L83iiCq6M0K0qkbXrWvktPDj0JsinznuEENddow8vle3B5AhSKfBRJGSBcLOod4xMawMmVDUX++lRwamNxIGLpWzptMW1lhOnrSdu204e0SE83+fyftaVFpe+ioGTJiZS+mNhrQ3cJ8BiN7eZhNFjQ1p/F0YkrIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBeSAuJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBeSAuJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01261F000C5;
	Sat, 17 Oct 2026 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201511;
	bh=48TaoCltS3X5qvTfO57He1MDZ9f1wLKNNEDbuGWo3+k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mBeSAuJKxU6P+bkaYTRwfgG8NAB3fKF9qq5R1qiCQKl68TNUdDRW38Rccj62ks08V
	 muxWUD2KoPFuzN2tXD1A7eQAha62GdFP/uM5MQJk+5PUzzxdKZEgXXfFfJ7JY/GpYO
	 VCeOKeGklZ/Ky0YVucop9iDfGyIiN68cqOeGwV+PzLVMr5+IEu4dhTWRaIX7v5pRWk
	 M/glpwH7dZmmokwt25wxWwp70WruQNw+c+hahs0jco/tJRSFB2P2jFQJUSFb2nynSs
	 WbINBW1Yllord9/oa/8uxSQSfpNOOuY46zzMndtzUieaqcH6bl7Sg6UvPgEo9xh4bA
	 xvHu6VNwmy9Kw==
Message-ID: <sashiko-outbox-175146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 19/38] bpf: Fix stale offload->prog pointer
 after realloc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-11-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:45:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: unlocked offload access in bpf_prog_realloc() causes use-=
after-free
--

commit 3691aa3c9c7d9f29e407360a3a32c4201c98c86f
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Fix stale offload->prog pointer after realloc

This commit updates fp->aux->offload->prog in bpf_prog_realloc() when a
device-bound BPF program is reallocated during verifier rewrites so that
netdev unregistration does not pass a stale program pointer to
__bpf_prog_offload_destroy().

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 642f0ab8eb2d8..2154c18a5a4d8 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -269,6 +269,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp=
_old, unsigned int size,
>  		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
>  		fp->pages =3D pages;
>  		fp->aux->prog =3D fp;
> +		if (fp->aux->offload)
> +			fp->aux->offload->prog =3D fp;

[Severity: Critical]
Does this access to fp->aux->offload and the subsequent freeing of fp_old
need synchronization with bpf_devs_lock?

During bpf_prog_load(), bpf_prog_dev_bound_init() links offload into
ondev->progs under bpf_devs_lock and then releases the lock before
bpf_check() runs. As noted in kernel/bpf/offload.c:

kernel/bpf/offload.c:bpf_dev_bound_resolve_kfunc() {
	/* We don't hold bpf_devs_lock while resolving several
	 * kfuncs and can race with the unregister_netdevice().
	 * We rely on bpf_dev_bound_match() check at attach
	 * to render this program unusable.
	 */
	down_read(&bpf_devs_lock);
	if (!prog->aux->offload)
		goto out;
    ...
}

When verifier instruction rewrites grow the program via
bpf_check() -> bpf_patch_insn_data() -> bpf_patch_insn_single() ->
bpf_prog_realloc(), bpf_prog_realloc() runs without bpf_devs_lock while
concurrent netdev unregistration can run on another CPU under
down_write(&bpf_devs_lock):

kernel/bpf/offload.c:__bpf_offload_dev_netdev_unregister() {
    ...
		list_for_each_entry_safe(offload, ptmp, &ondev->progs, offloads)
			__bpf_prog_offload_destroy(offload->prog);
    ...
}

kernel/bpf/offload.c:__bpf_prog_offload_destroy() {
	struct bpf_prog_offload *offload =3D prog->aux->offload;

	if (offload->dev_state)
		offload->offdev->ops->destroy(prog);

	list_del_init(&offload->offloads);
	kfree(offload);
	prog->aux->offload =3D NULL;
}

Can this race in two ways?

1. bpf_prog_realloc() checks if (fp->aux->offload) and sees a non-NULL
   pointer, while __bpf_prog_offload_destroy() concurrently frees offload
   and sets prog->aux->offload =3D NULL, causing fp->aux->offload->prog =3D=
 fp
   to write to freed slab memory or dereference NULL.

2. __bpf_offload_dev_netdev_unregister() reads offload->prog (still fp_old)
   and passes it to __bpf_prog_offload_destroy(fp_old), while
   bpf_prog_realloc() concurrently clears fp_old->aux =3D NULL and frees
   fp_old via __bpf_prog_free(fp_old), causing __bpf_prog_offload_destroy()
   to dereference a NULL prog->aux or freed fp_old.

> =20
>  		/* We keep fp->aux from fp_old around in the new
>  		 * reallocated structure.

=E2=80=94
=F0=9F=A4=96 Generated bylinux-kernel-bot

Assisted-by: Google Gemini-3.1-Pro

---
Do youhave feedback on this review? Please let us know by replying to this =
email or filing an issue at https://github.com/google/linux-kernel-bot/issu=
es.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D19
