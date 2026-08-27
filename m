Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E4363C64
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 05:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809096; cv=none; b=OjueMaSth9t7s86eW0aweLN0yipgg2lyHdrGz0YlxqdgXvDn6zOLL1h1isJLBLlanJfUwIF1jvjwYF3ZU1a/RUpeu7JsBhXFvy7gf034O3+0EvLNAUVJTucwbdqaG8JUQwqOE3mUz5Jogdyw6sdtt2R/Jn+x7xSkLgD0xkhf9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809096; c=relaxed/simple;
	bh=dVLM/6fRZ126cg8vajy54E0eP9DoIRXx/kbY0tkThrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GxHLiugmD+TxWPUDrnYrosUD+02/sJ6RTTOGhiANO/LvXOdOrkqOrReU+rY+anPrjsqMjyU49j7XQlNVTjL9MwfIIwQoe8txyGLTFqOE3y6ZVM/WCvQWOPfYP7ToG4NLZAV2jWgL4bUZnbL7Ru3LZw1mYq0V8OTVr1g4qrd4PbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDganFdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDganFdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FFC1F000E9;
	Thu, 27 Aug 2026 05:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787809095;
	bh=+0/JOYbBYBpafWlVYjlHlLfVVH8tfsI5N1VPypyKqPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDganFdlwGr5difWnRxw98dXlVnDpMNHd2TfVwNKi9jmKOKcUGBR92ISR+acodbhv
	 mVe1DjVw41NkTiLL1RpWEVX4173pJbcVjSjlooh1nRDdiIILRq3FBN5egVLQRrtY2D
	 vdfmq1J7gc0AqwkIWGBKoFJOUgLUBuHqJ6EPHp0rt6//MoYh+KmI2ScYqKkEhDb3cd
	 X9RdvsbS37Nv5WWQt1NCz8cQq83bXSmcOvJCV0DNbx/yQtlvfc6TzlloaqQFCAEJXk
	 JPtElHagWm5lidHAq9v8YtK8kYPfHttBU0AYN7nV44OJTxWRp09UAnr5FeQ1BpZu4T
	 ammYuRfBRW+vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 __bpf_sk_storage_map_seq_show
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQgU2VjdXJpdHkgRk9SR0UgTGFicyk=?= <blbllhy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260827051859.45511-1-blbllhy@gmail.com>
References: <20260827051859.45511-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 05:38:14 +0000
Message-Id: <20260827053814.E0FFC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Socket local storage elements are removed from the RCU-protected B=
PF map inside the socket's destruction path (`__sk_destruct`), violating RC=
U-001 rules and causing a use-after-free of the socket because the socket c=
an be freed while a BPF iterator is still using it.
- [High] `bpf_selem_unlink_nofail()` concurrently sets `SDATA(selem)->smap`=
 and `selem->local_storage` to NULL, causing guaranteed NULL pointer derefe=
rences in concurrent `bpf_selem_unlink()` and `bpf_selem_unlink_map()` path=
s.
--

commit cabffb2f3787054c5c6ba2a413eaf5dc639ba23d
Author: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show

This commit addresses a NULL pointer dereference in
__bpf_sk_storage_map_seq_show() during concurrent socket closure. It adds a
NULL check after re-reading selem->local_storage to prevent dereferencing a
cleared pointer.

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fad..7228520aa2b6e 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_f=
ile *seq,
>  		ctx.map =3D info->map;
>  		if (selem) {
>  			sk_storage =3D rcu_dereference(selem->local_storage);
> +			if (!sk_storage)
> +				return 0;
>  			ctx.sk =3D sk_storage->owner;

[Severity: High]
This is a pre-existing issue, but does this patch fully address the
underlying TOCTOU race?

If a socket without SOCK_RCU_FREE (e.g., AF_UNIX) is closed, __sk_destruct()
in net/core/sock.c calls bpf_sk_storage_free(), which unlinks the storage
from the BPF map.

Couldn't a concurrent BPF iterator in __bpf_sk_storage_map_seq_show()
operating under rcu_read_lock() find the storage element before it is
unlinked, and read ctx.sk =3D sk_storage->owner? The socket is then
synchronously freed by __sk_destruct() without waiting for an RCU grace
period, leaving the iterator to pass a dangling pointer to the BPF program
via bpf_iter_run_prog(prog, &ctx).

This appears to violate the remove-before-reclaim ordering (RCU-001) since
the socket is removed from the RCU-protected BPF map inside the socket's
destruction path.

[Severity: High]
This is a pre-existing issue, but might this only fix a downstream symptom
in the iterator path while leaving other concurrent map operations
vulnerable?

When a socket goes away, bpf_selem_unlink_nofail() in
kernel/bpf/bpf_local_storage.c sets SDATA(selem)->smap to NULL without
holding local_storage->lock.

If a concurrent map deletion calls bpf_selem_unlink(), it acquires
local_storage->lock first, sees selem->snode is still hashed, and calls
bpf_selem_unlink_map(). Could bpf_selem_unlink_map() then unconditionally
dereference the now-NULL SDATA(selem)->smap, crashing inside
select_bucket()?

kernel/bpf/bpf_local_storage.c:bpf_selem_unlink_map() {
    ...
    smap =3D rcu_dereference_check(SDATA(selem)->smap,
                                 bpf_rcu_lock_held());
    b =3D select_bucket(smap, local_storage);
    ...
}

Similarly, it looks like bpf_selem_unlink() could use a potentially NULL
local_storage for lock acquisition:

kernel/bpf/bpf_local_storage.c:bpf_selem_unlink() {
    ...
    local_storage =3D rcu_dereference_check(selem->local_storage,
                                          bpf_rcu_lock_held());
    err =3D raw_res_spin_lock_irqsave(&local_storage->lock, flags);
    ...
}

>  			ctx.value =3D SDATA(selem)->data;
>  		}
>  		ret =3D bpf_iter_run_prog(prog, &ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827051859.4551=
1-1-blbllhy@gmail.com?part=3D1
