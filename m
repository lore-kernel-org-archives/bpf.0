Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB72D8370;
	Thu, 13 Aug 2026 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580538; cv=none; b=r7HgcsAZ+WP+j599Fn8FJujP927tq/vtWgHtWuxDpjBTAV/5rlui9VIyfsmZs0Qb5zSnSgVTsHQcudt34XMfVMItXHRV1U5SCSUP/daFNAqavjksTEtsxsolrgdrDU1WevvBjKduXmhuA/XdQfBMkKPKfl0Lqbb7VOlebVuFlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580538; c=relaxed/simple;
	bh=IZCtIwMgIam1NuychOS41K1ib6ff5DnZvV0sxlrpQO0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NfRFfpDd662rub8LvxS5A3xbSb/TGBhSXHaw7Tty8Lq9KCkSZhlJfJibGfz82zfL4TxDjcomRXUlFbGRp0T/tjATqYR7TwFN25NpbKJGOC2hpjjsi63JHufpGagBmy7sjUZyPW55mf4fWQianuFD00R4WqDHYljwxXuVKY/f+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei2SKeKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei2SKeKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2921F00A3A;
	Thu, 13 Aug 2026 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580537;
	bh=DHdix0jwz+cYIxf59zyMaEXeIIOrEGcfePsOeno83wE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ei2SKeKSlExapaH0+ChZIkOruQNeIW7rI2IWTsfqde8lpz/UmdsW6eas2mscqFTsf
	 +xN0NFjfLav/FE65AjNB0jCiMkZWlRn9N8y5s+ckk+EXBWWh+BesZFvrrDzbCDzSTn
	 xh1ElLsqAgD2cSWIsKmjxysM50yMueW2GzUauVlK8XI/YrfEQ5CDA+LdijX805gn13
	 Zf9GDCP2aGKxuHhOg2GK3qQI1HEyU21ocoIcb/izc4Xi9z3CKyer9dI6UAnfhnMPKL
	 mu09FxrpxCkO7QR71asVgPcWlWImEt8zQyJ7BXQRKO9SM+ZhGwDUVAH+MDa3qdI84T
	 E2hYxkE8rabBA==
Content-Type: multipart/mixed; boundary="===============2442601514520147488=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <67d3fde7d6f3c2a8a4673c4d8e35e4250d610287f30794f42f502570a63e13cd@mail.kernel.org>
In-Reply-To: <20260812231905.2956588-2-tjmercier@google.com>
References: <20260812231905.2956588-2-tjmercier@google.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
From: bot+bpf-ci@kernel.org
To: tjmercier@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,tjmercier@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 00:22:16 +0000 (UTC)

--===============2442601514520147488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> @@ -476,7 +522,7 @@ static void htab_mem_dtor(void *obj, void *ctx)
>  	if (IS_ERR_OR_NULL(hrec->record))
>  		return;
>
> -	map_value = htab_elem_value(elem, hrec->key_size);
> +	map_value = (void *)elem + sizeof(struct htab_elem) + round_up(hrec->key_size, 8);
>  	bpf_obj_free_fields(hrec->record, map_value);
>  }

This isn't a bug, but would it be worth storing the element header offset
in struct htab_btf_record (next to key_size) and keeping htab_mem_dtor on
the shared htab_elem_value() path, rather than open-coding
sizeof(struct htab_elem) here? Everywhere else in the file the header
size is now the per-map htab->key_offset, reached through
htab_elem_key()/htab_elem_value(). The hardcoded form happens to be
correct today because htab_mem_dtor is only installed for non-preallocated,
non-percpu, non-LRU BPF_MAP_TYPE_HASH maps (LRU requires prealloc, and
HASH_OF_MAPS uses map_check_no_btf), which is exactly the case where
key_offset == sizeof(struct htab_elem). The invariant is invisible at the
call site and there is no comment or assertion tying the two together, so
the open-coded copy silently diverges from the accessor if another element
layout ever registers this dtor.

> @@ -869,17 +929,17 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  	struct bucket *b;
>  	int ret;
>
> -	tgt_l = container_of(node, struct htab_elem, lru_node);
> -	b = __select_bucket(htab, tgt_l->hash);
> +	tgt_l = (struct htab_elem *)container_of(node, struct htab_elem_lru, lru_node);
> +	b = __select_bucket(htab, htab_elem_hash(htab, tgt_l));

This isn't a bug, but the commit adds htab_elem_lru_node() for the
htab_elem to bpf_lru_node direction, while the inverse conversion stays
open-coded and is now duplicated verbatim at two sites (line 358 in
prealloc_lru_pop() and line 932 here), each needing an explicit
(struct htab_elem *) cast to silence the incompatible-pointer warning.
Would a small counterpart helper, e.g. htab_elem_from_lru_node(), keep
both directions symmetric and confine the cast to one place?

Commit message issue:

>     bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
>
>     The htab_elem struct is used as the per-element type for all BPF hash
>     map types and includes bpf_lru_node in a union with a ptr_to_pptr
>     pointer. For standard (non-LRU, non-PCPU) hash maps, the 24 byte union
>     allocated for every element is entirely unused. For non-preallocated
>     PCPU maps, ptr_to_pptr only requires 8 bytes, leaving 16 bytes of unused
>     overhead in the union. For preallocated PCPU maps ptr_to_pptr is unused
>     since elements are freed to the PCPU freelist.
>
>     Eliminate this per-element memory overhead by splitting htab_elem into
>     dedicated structures for each map type:
>        - struct htab_elem: Minimal structure for standard hash maps and
>          preallocated PCPU maps (saves 24 bytes per element).
>        - struct htab_elem_pcpu: Structure for non-preallocated PCPU maps
>          containing ptr_to_pptr (saves 16 bytes per element).
>        - struct htab_elem_lru: Retains struct bpf_lru_node for LRU maps.
>
>     Because element sizes now vary by map type, add key_offset to struct
>     bpf_htab to track the dynamic key offset. Update helper accessors and
>     lookups to compute key and value offsets using htab->key_offset.
>
>     Pointers to struct htab_elem in the existing code (e.g. htab_elem_hash)
>     serve as generic base element pointers. This is possible because
>     htab_elem, htab_elem_pcpu, and htab_elem_lru share a common initial
>     sequence, making pointer casts safe.

This isn't a bug, but could the changelog gain a paragraph on the
map_in_map.c side? The patch also touches kernel/bpf/map_in_map.c and
kernel/bpf/map_in_map.h: it adds bpf_map_type_is_htab(), grows
inner_map_meta to sizeof(struct bpf_htab) via the new
bpf_htab_map_meta_size(), and copies key_offset into the meta map with the
new bpf_htab_map_meta_init(). That part is the non-obvious
correctness-critical consequence of making the key offset a runtime field,
since the verifier's inlined lookups read the offset out of the
inner_map_meta. A reviewer looking at the diff would most benefit from an
explanation of why inner_map_meta must now be sizeof(struct bpf_htab) and
have key_offset copied. Also, the sentence about making pointer casts safe
mentions the common initial sequence but doesn't name which casts rely on
it (htab_elem_lru_node(), htab_elem_get_ptr_to_pptr(),
htab_elem_set_ptr_to_pptr()).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31651309438
--===============2442601514520147488==--
