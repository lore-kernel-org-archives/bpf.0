Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A4037B02D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785903458; cv=none; b=hm1YLQRdbTKmJMtIGeerX9KvhkeA11sSqzRNIIe5osO2VzzZ1OGaT0DgPgEA7TGOSwGkeG00Tp82W876BWiJRn1pzKi3wMJOlZ3KnCgZ20L9yEK9TzEHR77gWAN3LTFKuwIkyWr4/uFB6r4OZsDp8gmjN1lZuoyBWCbORawik1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785903458; c=relaxed/simple;
	bh=RYAby9zss7E4DwvdxRfXtI1/miRQku9AFq/DuXtjRPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZ+6hlJQl4F/dzFRsktx6yJ+9V5sx4y1wdTd2POq4WshbypDupvUzhCRzVyBCyX7pyirpC62PbI/UWLVOIEDXbRU8w9PDLkaFzrDp4YGDrvY/S4/MurMfSTAPzQ+klZ+VzMg3m9iZquwqUcpT9T+cBOxtf7rjB7YIwrduuVwkik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKsSEkRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKsSEkRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957931F000E9;
	Wed,  5 Aug 2026 04:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785903456;
	bh=OtWxir51DSbFNgqiOwVXwB58exlGlvd6l14UWSjj0wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GKsSEkRUylonB0vm2kkhPabrV3vLp3sHbSMJf5hv0XhG016oDjcfIT5bqCBfolEYv
	 ih2O18EHV/vtBnqNNRHQqpaiGbIfwXc03oJYz9LgDY+iYT4BhvQrbQCMjSfl1hlDTF
	 O0whtzEax49w886fk5Vk9UJEwmFW5ci5ViY0q1+wHpQYNZogclSp7ZL5b9AJeMizO/
	 W6yEgBMreoeIwunuU1JHbv5H/n4bsFcASe7+USHpsFg4KyOd1KN9qKU9uBIMu88MYu
	 KQxxkwI7eXKSYEAfveRq+v9/cpDdiiPIOnjinAdIqsxjn9krJcwmMZJy5wlwbLTrxp
	 ZLZN0KI9N/LYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix UAF in
 bpf_trampoline_multi_detach on update failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <0276810360a8c0e57aab95a292ff6453242b969c.1785902527.git.zhuhui@kylinos.cn>
References: <cover.1785902527.git.zhuhui@kylinos.cn>
 <0276810360a8c0e57aab95a292ff6453242b969c.1785902527.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 04:17:35 +0000
Message-Id: <20260805041736.957931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Multi-line comment opening `/*` is not on its own line.

Pre-existing issues:
- [High] Incomplete fix: Use-After-Free of `bpf_prog` when `__bpf_trampolin=
e_unlink_prog()` fails.
- [High] Use-After-Free of trampoline image in `bpf_trampoline_multi_attach=
` error path.
--

--- Patch [1]: [PATCH bpf-next v2 1/3] bpf: Fix UAF in bpf_trampoline_multi=
_detach on update failure ---
commit 26ad7c4ab94aa890dec18cbc899359aabf65c015
Author: Hui Zhu <zhuhui@kylinos.cn>

    bpf: Fix UAF in bpf_trampoline_multi_detach on update failure
   =20
    The commit attempts to fix Use-After-Free issues in the error paths of
    bpf_trampoline_multi_detach() by changing when old_image is freed and
    introducing a rollback mechanism when ftrace updates fail. It pins the
    bpf_prog onto the image to avoid freeing it while ftrace might still
    direct calls to it.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index ed7999ad6c66c..c08d1a09e6381 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
[ ... ]
> @@ -1719,11 +1760,11 @@ int bpf_trampoline_multi_attach(struct bpf_prog *=
prog, u32 *ids,
>  	return err;
>  }
> =20
> -int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracin=
g_multi_link *link)
> +void bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_traci=
ng_multi_link *link)
>  {
>  	struct bpf_tracing_multi_data *data =3D &link->data;
>  	struct bpf_tracing_multi_node *mnode;
> -	int i, err;
> +	int i, err, err_unreg =3D 0, err_mod =3D 0;
> =20
>  	trampoline_lock_all();
> =20
> @@ -1735,13 +1776,65 @@ int bpf_trampoline_multi_detach(struct bpf_prog *=
prog, struct bpf_tracing_multi_
>  		WARN_ONCE(err, "__bpf_trampoline_unlink_prog failed: %d\n", err);
>  	}
> =20
> -	if (ftrace_hash_count(data->unreg))
> -		WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
> -	if (ftrace_hash_count(data->modify))
> -		WARN_ON_ONCE(update_ftrace_direct_mod(&direct_ops, data->modify, true)=
);
> +	if (ftrace_hash_count(data->unreg)) {
> +		err_unreg =3D update_ftrace_direct_del(&direct_ops, data->unreg);
> +		WARN_ON_ONCE(err_unreg);
> +	}
> +	if (ftrace_hash_count(data->modify)) {
> +		err_mod =3D update_ftrace_direct_mod(&direct_ops, data->modify, true);
> +		WARN_ON_ONCE(err_mod);
> +	}
> =20
> -	for_each_mnode(mnode, link)
> -		bpf_trampoline_multi_attach_free(mnode->trampoline);
> +	for_each_mnode(mnode, link) {
> +		struct bpf_trampoline *tr =3D mnode->trampoline;
> +
> +		/* If the batch ftrace update failed for this mnode's path,
> +		 * ftrace still points to old_image. Use rollback to restore

[Severity: Low]
Does this multi-line comment violate the BPF subsystem guidelines? The
opening /* of a multi-line comment must be on its own line.

> +		 * cur_image to old_image (putting the new cur_image if any)
> +		 * so the trampoline keeps the image ftrace is calling.
[ ... ]
> +		 * image if the trampoline is torn down first instead (see
> +		 * bpf_trampoline_put()).
> +		 */
> +		if (tr->multi_attach.old_image &&
> +		    tr->multi_attach.old_image !=3D tr->cur_image &&
> +		    ((err_unreg && !tr->cur_image) ||
> +		     (err_mod && tr->cur_image))) {

[Severity: High]
This is a pre-existing issue, but does this incomplete fix lead to a
Use-After-Free of the bpf_prog structure if __bpf_trampoline_unlink_prog()
fails?

When __bpf_trampoline_unlink_prog() fails, old_image equals cur_image,
so this condition evaluates to false, bypassing the logic to pin the
bpf_prog onto the retained image. This allows the caller to release its
reference to the bpf_prog and free it, even though the active ftrace
trampoline image still contains a direct machine-code call to the freed
prog.

A similar missing pinning logic exists in the non-multi caller of
__bpf_trampoline_unlink_prog() where it directly returns the failure of
bpf_trampoline_update() without pinning the prog:

kernel/bpf/trampoline.c:__bpf_trampoline_unlink_prog() {
    ...
	bpf_trampoline_remove_prog(tr, node);
	return bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
}

> +			WARN_ON_ONCE(tr->multi_attach.old_image->pinned_prog);
> +			bpf_prog_inc(prog);
> +			tr->multi_attach.old_image->pinned_prog =3D prog;
> +			bpf_trampoline_multi_attach_rollback(tr);
> +		} else {
> +			bpf_trampoline_multi_attach_free(tr);
> +		}
> +	}
> =20
>  	trampoline_unlock_all();

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
bpf_trampoline_multi_attach() cause a Use-After-Free of the trampoline
image?

If update_ftrace_direct_del() fails during rollback:

kernel/bpf/trampoline.c:bpf_trampoline_multi_attach() {
    ...
	if (ftrace_hash_count(data->modify)) {
		err =3D update_ftrace_direct_mod(&direct_ops, data->modify, true);
		if (err) {
			if (ftrace_hash_count(data->reg))
				WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
			goto rollback_unlink;
		}
	}
    ...
}

It proceeds blindly to rollback_unlink, which calls
bpf_trampoline_multi_attach_rollback():

kernel/bpf/trampoline.c:bpf_trampoline_multi_attach_rollback() {
    ...
	if (tr->cur_image)
		bpf_tramp_image_put(tr->cur_image);
    ...
}

Does this unconditionally free the newly allocated trampoline images even
when update_ftrace_direct_del() fails, leading to a UAF since ftrace
is still actively pointing to them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785902527.gi=
t.zhuhui@kylinos.cn?part=3D1
