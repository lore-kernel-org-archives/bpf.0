Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB89480954
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100536; cv=none; b=mylwJDi2fnloKbbT+EoR4MQT+3A6vlAIScT0jeVmYItnoBVQBc9svh6XLwZpY3Qky7QjyYlKNmIUgEZ9I7M15KM3OzAyiSZjR6zVjlRx2Mf9N7uA8cE4IFYKOlfQfeVqyuCcFrcqBCbivGJ6KI6WAZpdcafOc0MwNhQy0e3deWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100536; c=relaxed/simple;
	bh=PkSmW5b+hBfPRAW83AEuN3aOhSR04lIjcy+Q5JLdoNg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IxgYI/1uNW8b0DcdlxF6zpzuBcEwuquUw7iFgjuCxWRM/kzVT0AMWX4emYHi//3oOT3vCh75gjfxUL3oGlZG6m5MdWrVAs4gf/qJP7+6cPlxw+kxwYe5x+IV3idexoPvnSJo5tDTFGS3sCLlvOPTrPKxwqke5Mhs52tI2ykWTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKFXchjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKFXchjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7721F000FF;
	Tue, 22 Sep 2026 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100524;
	bh=HgQAsSqSv9nYZw6g66l7UGaGzy2iYS4OFb+IbRylDxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKFXchjozSVJwGCMM/2LFyMNUFmm+5b0fXf+6HxlU8cIMVIryyJNoD+T/gapuPNOR
	 cavg6qXRpnrwfLN35w09goV5+ZXoaZKXrqvONhfqi9aN+hWO861gMl85NQlVDVLMG5
	 8ZVVfsNSAa/ghqLWAFRl1gHYW2yiL7h8HbkovPriMIONc/4lP7CNwYl4aLs/YUJ50V
	 t7J1dvtsli0hzJQJoHJNtmlwJfdu65Twx7gix8gYVk8/qDub3ELAcdymssneowbKZ7
	 1WrlyVqMB69odOIJDQoZEsS+taT2ooSg8+BnX+VQjNc3Ir307fnBZoZgl+SEPEgkYi
	 pgJ+v/8yVUsfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3] bpf: Speed up htab lookups for u32/u64 keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
References: <20260922-hashtab_fast_hashfn-v3-1-b7b0e9bc33ac@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 18:08:43 +0000
Message-Id: <20260922180843.CB7721F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: missed u32/u64 lookup optimization for LRU/per-CPU/of_map v=
ariants
--

commit 88a648ce718a5816a7cc1175a104d2f26afc58c0
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Speed up htab lookups for u32/u64 keys

This commit introduces specialized hashing and specific lookup entry points
for 4-byte and 8-byte keys in BPF hash maps. It achieves significant
throughput improvements for standard BPF_MAP_TYPE_HASH lookups.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6f331c80130d7..f744a42bb8139 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -783,7 +805,16 @@ static int htab_map_gen_lookup(struct bpf_map *map, =
struct bpf_insn *insn_buf)
> =20
>  	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
>  		     (void *(*)(struct bpf_map *map, void *key))NULL));
> -	*insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
> +	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u32,
> +				  (void *(*)(struct bpf_map *map, void *key))NULL));
> +	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem_u64,
> +				  (void *(*)(struct bpf_map *map, void *key))NULL));
> +	if (map->key_size =3D=3D sizeof(u32))
> +		*insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem_u32);
> +	else if (map->key_size =3D=3D sizeof(u64))
> +		*insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem_u64);
> +	else
> +		*insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);

[Severity: Medium]
Does this miss an opportunity to apply the identical u32/u64 lookup
optimization to the LRU, per-CPU, and hash-of-maps variants?

It looks like specialized JIT lookup generators were added here for
standard hash maps in htab_map_gen_lookup(), but identically structured
functions in the same file such as htab_lru_map_gen_lookup(),
htab_percpu_map_gen_lookup(), and htab_of_map_gen_lookup() still
unconditionally emit a call to the unspecialized __htab_map_lookup_elem.

Would it make sense to update those generators as well, so these heavily
utilized map variants do not miss out on the same performance gains?

>  	*insn++ =3D BPF_JMP_IMM(BPF_JEQ, ret, 0, 1);
>  	*insn++ =3D BPF_ALU64_IMM(BPF_ADD, ret,
>  				offsetof(struct htab_elem, key) +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-hashtab_fa=
st_hashfn-v3-1-b7b0e9bc33ac@meta.com?part=3D1
