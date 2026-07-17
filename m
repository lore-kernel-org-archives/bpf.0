Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A530100E
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315818; cv=none; b=RWpB4Z1P1vovtKFfR7iFyBaAbg+BvV/WHz/6OkyxZR6/qmU6+1Gmj0G3opEuxVv9PxNP9EkoRLuHTB/qyQVPx88/dPRRk2A6bawEP/oWF8jWyBu4QdtxpVHhlHLqJziW0qzFfnLAwExJaPBRVw5eZX632QwkKl54ZRO0ziXxP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315818; c=relaxed/simple;
	bh=7fJaq1l5N5N02ClBB+qPmIegXr0gERkflA8HMhgu/DI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OpbouL3p86uVWm4KR+ryNRgjj7Yi6ep3e1ffCKXYGGvyqmt5DW2v0s1Zxs5A00h9FrbiI07HPZT6v9wS3qcqazigQ7ADs/kHeSjImliF0NMLg6Mr7669xbw1PFc36QYFFgbsiYwez2W8umHmfS8G/PMHYa2+d8QRvf221b8RR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAbOqoR3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAbOqoR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17B81F000E9;
	Fri, 17 Jul 2026 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784315817;
	bh=zj3tofjdmrNSxKKrD7bxwWn0rDnfVVXorKElIZMEJq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jAbOqoR3myZV2FjMkQPN9hyVcqiYRs+ImOzVq46oDxpce9JRbvuQ1E0/0QLAXJMEb
	 Bp1eIEwHhchcS49ICTJZaKMZOmQ9xRwxWhp5wiEwFIv4OmX4Zhp3uv3TP+oHPSsMcd
	 0SBryIb4RTkOzjz9ViDVfaR/ss3Cikxmo6cLdNOXF5dxxBVPL6swpLRrx5dl/32nMB
	 Odgkt8sevZ1wd8sOrV0mKXUQXi3nV/EZjjvTPGHCk1MekLPgC5LZCtZbtL1FH+zsR4
	 fBVAJ2kfdv2yL1BZXHN6O/reW6fpcMe6GFCM/duJYk5JF+/pFkShtxdST5Bzobi4bd
	 aOwYqc1yI+b1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix alignment of memory allocator objects on
 32-bit archs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Fietkau" <nbd@nbd.name>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717183632.99195-1-nbd@nbd.name>
References: <20260717183632.99195-1-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:16:56 +0000
Message-Id: <20260717191656.F17B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] On 32-bit architectures, the verifier's hardcoded 8-byte load (BPF=
_DW) for bpf_this_cpu_ptr()/bpf_per_cpu_ptr() causes a KASAN out-of-bounds =
read past the 4-byte percpu pointer and passes garbage data on Big Endian s=
ystems.
--

--- Patch [1]: [PATCH] bpf: Fix alignment of memory allocator objects on 32=
-bit archs ---
commit ed5f9ae93bc0fc6463cab51b598b3ca3395812da
Author: Felix Fietkau <nbd@nbd.name>

bpf: Fix alignment of memory allocator objects on 32-bit archs

The BPF memory allocator prefixes each object with a header. On 32-bit
architectures, the memory handed out was offset by 4 bytes. This patch pads
the header to 8 bytes to preserve alignment and updates the percpu pointer
offset accordingly.

> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198fe..ca7555b1da34f 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
[ ... ]
> @@ -142,7 +142,7 @@ static void *__alloc(struct bpf_mem_cache *c, int nod=
e, gfp_t flags)
>  {
>  	if (c->percpu_size) {
> -		void __percpu **obj =3D kmalloc_node(c->percpu_size, flags, node);
> +		void *obj =3D kmalloc_node(c->percpu_size, flags, node);
>  		void __percpu *pptr =3D __alloc_percpu_gfp(c->unit_size, 8, flags);
> =20
>  		if (!obj || !pptr) {
> @@ -150,7 +150,7 @@ static void *__alloc(struct bpf_mem_cache *c, int nod=
e, gfp_t flags)
>  			kfree(obj);
>  			return NULL;
>  		}
> -		obj[1] =3D pptr;
> +		*(void __percpu **)(obj + LLIST_NODE_SZ) =3D pptr;

[Severity: High]
This is a pre-existing issue, but does this 32-bit pointer write lead to an
out-of-bounds read when accessed by the verifier?

On 32-bit systems, the allocation size for percpu objects is typically 12
bytes (LLIST_NODE_SZ + sizeof(void *)). The percpu pointer is stored at off=
set
8 using a 32-bit store.

However, the verifier unconditionally patches bpf_per_cpu_ptr() and
bpf_this_cpu_ptr() to read this pointer using an 8-byte load:

kernel/bpf/fixups.c:fixup_bpf_calls() {
    ...
    insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
    ...
}

Could this 64-bit read access bytes 8-15 of the 12-byte allocation, causing=
 a
KASAN slab-out-of-bounds read?

Furthermore, on 32-bit Big Endian systems, does this 8-byte load place the
4-byte pointer into the upper 32 bits and the out-of-bounds garbage into the
lower 32 bits, leading to memory corruption or a kernel panic when the garb=
age
is later dereferenced?

>  		return obj;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717183632.9919=
5-1-nbd@nbd.name?part=3D1
