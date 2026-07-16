Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F983596E1
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192746; cv=none; b=OFtHXhYC0PAYiFHd8fBAOMx/Q5kuFgmGCdi+OzNgFltlVJoprfel3H9IBl54y3RZFsd58bo6uvKeBaRR2tqrzwLyLVW9pfOn+QJqVUkrblcpk8tTzs/BgPSCU+H9LTy8KFhrHCKiAIQthyUu86ovnjPBQ8a1T6XYXKbGRIus26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192746; c=relaxed/simple;
	bh=HpaTSISORJUYc9PniMkvcxrsDPb3BHQ2lZ1HJKc9N9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I5Ntiv0H3jo/rhF+CWPsSqBlrW5YKgfT55DIiPOKtiuYxDUURvrdoqkbjhB5Q2Q2XUPpXQU/i/A1dOLMWLZ/Mh1y7x1LcYxlXmwYqyCVpTd5zum2FSrG5IRzM8D8cHk/mnUgv9JUbdK2oMm2H7hOMjNagv9lcsKIpEaLgAN+S/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V40IrP+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V40IrP+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B601F000E9;
	Thu, 16 Jul 2026 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784192745;
	bh=3ZpnSjktarW7EeR1GU3nA9jHzRW0AIpspZMmrJMC9C0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V40IrP+u8Mxlz8HK3HVewggyTQePhYgdLWJL/59GvjTGLOsfpYzqu2p7rjqIECdN2
	 ZoG8eAf8G2FRCdmmsI52PpZAPTeYnJTvMCtyTFyF0bJD35H4/g2vF4XGLagArkbxGT
	 eBjhxO1ZIzr+i0NZRpMMuO5/8WKyU7rFc7PXf1flHny3+EAZky1u9fdZYntcTBbL2z
	 NcpTN7KT0gtCyLGcWEtPhozSVzAQzy1W/rwpb166nve8mGhvudjfe+0RrVWZsD3Qw5
	 kolutgDCs7zBgt0rY9Cjd11lOlCboC7I9sW4/XXZWjJMOrB6L/kvYL0iXGskkvkZ/i
	 dGtfpciNXV4kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix stale old_image UAF on trampoline
 update failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <76dfd8edea81af878f52739431a218cd1d214ab2.1784191209.git.zhuhui@kylinos.cn>
References: <cover.1784191209.git.zhuhui@kylinos.cn>
 <76dfd8edea81af878f52739431a218cd1d214ab2.1784191209.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:05:44 +0000
Message-Id: <20260716090545.34B601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] BPF subsystem coding style violation in multi-line comment.

Pre-existing issues:
- [Critical] Use-After-Free of trampoline image on detach failure path when=
 ftrace deletion fails.
- [Critical] Use-After-Free of BPF program memory on detach failure path wh=
en trampoline unlink fails.
- [Critical] Use-After-Free of trampoline image on attach rollback failure.
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf: Fix stale old_image UAF on trampol=
ine update failure ---
commit add7893089763b05b38780203210dc401d0f2955
Author: Hui Zhu <zhuhui@kylinos.cn>

bpf: Fix stale old_image UAF on trampoline update failure

This patch addresses a use-after-free where old_image could be freed
even when bpf_trampoline_update() fails. It fixes the problem by verifying
that old_image and cur_image are different before allowing the memory to
be freed.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 6eadf64f7ec90..a78fbf726fad5 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1585,7 +1585,17 @@ static void bpf_trampoline_multi_attach_init(struc=
t bpf_trampoline *tr)
> =20
>  static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
>  {
> -	if (tr->multi_attach.old_image)
> +	/* Only free old_image if it is no longer the active image.

[Severity: Low]
Does this violate the BPF subsystem coding style? Multi-line comments
should have the opening /* on its own line.

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
This is a pre-existing issue, but does this logic safely handle the case
where ftrace deletion fails in bpf_trampoline_multi_detach()?

If __bpf_trampoline_unlink_prog() succeeds, unregister_fentry_multi()
sets tr->cur_image =3D NULL.

Then update_ftrace_direct_del() is called, but it can fail (e.g., if
hash_sub allocation fails). If it fails, the error is ignored and ftrace
continues pointing to old_image:

bpf_trampoline_multi_detach() {
    ...
    if (ftrace_hash_count(data->unreg))
        WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->unreg));
    ...
}

When bpf_trampoline_multi_attach_free() executes, old_image !=3D cur_image
evaluates to true (non-NULL !=3D NULL), causing old_image to be freed.
Could ftrace then trigger and execute the freed memory?


[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free of the BPF
program memory if the trampoline unlink fails during detach?

If __bpf_trampoline_unlink_prog() fails (e.g., returns -ENOMEM) in
bpf_trampoline_multi_detach(), the failure is ignored:

bpf_trampoline_multi_detach() {
    ...
    WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoli=
ne,
                                              NULL, &trampoline_multi_ops, =
data));
    ...
}

The detach function returns, and bpf_tracing_multi_link_release()
unconditionally frees the BPF program memory:

bpf_tracing_multi_link_release() {
    ...
    WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
    bpf_tracing_multi_link_free(tr_link);
    ...
}

However, because unlink failed, ftrace still points to old_image, which
contains hardcoded assembly jumping into the now-freed BPF program memory.
Could this result in a use-after-free of the BPF program memory if ftrace
is triggered?


[Severity: Critical]
This is a pre-existing issue, but can the trampoline image be freed while
ftrace is still using it during a failed attach rollback?

In bpf_trampoline_multi_attach(), if update_ftrace_direct_mod() fails,
the rollback sequence attempts update_ftrace_direct_del():

bpf_trampoline_multi_attach() {
    ...
    if (err) {
        if (ftrace_hash_count(data->reg))
            WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
        goto rollback_unlink;
    }
    ...
}

If update_ftrace_direct_del() fails, ftrace remains configured to call
the newly allocated cur_image.

Then bpf_trampoline_multi_attach_rollback() unconditionally frees
tr->cur_image:

bpf_trampoline_multi_attach_rollback() {
    if (tr->cur_image)
        bpf_tramp_image_put(tr->cur_image);
    ...
}

Could ftrace execute the freed cur_image in this scenario?

> =20
>  	tr->multi_attach.old_image =3D NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784191209.gi=
t.zhuhui@kylinos.cn?part=3D1
