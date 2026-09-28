Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9114CC61B;
	Mon, 28 Sep 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610371; cv=none; b=Wlq/Nc02cIBc+tqurkSaCJYysrEJNnF7pznmgT8GArmzj3SXngFdNk5VSa4Dz5F2AilCRck/WBSf5BG+NPFLmD/geIPRzd7L5Twl3vbeTK/vM1CWZm13Q7KAAMfLSrHpo5cw3BJ075MW9CbmZTfUnaEiULHLfWwTgr7Z3C9UchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610371; c=relaxed/simple;
	bh=N5Ohrv3V+NnMgyUJTBdJmbYNr4yprKAMIjPlSO/ztSc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mtPjZWmukZY73atdI5Ezt2x394bvQjeUk8cLCXEBOVK7N4ELfXcOC1TuaR3DjwJ6fzmIB7d9daEb372dkit1G/k1Aigl7Y3LjNeXXC5WB53vPgHMJSuaXdfeys/bb30cuL3V/nxy/DtZcoCR8L1InRe9OF/zJpNM2uvCKvCOD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbJJsok6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbJJsok6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01051F000FF;
	Mon, 28 Sep 2026 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790610369;
	bh=1pa9vC5Lbo6L0EX98csRUk8Kmp6D4AGsfQlmAkk15TY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bbJJsok6gwM8UjEgMXy7k1eRABFk1R1ghWgNu5gAFqsE8tR2Nt7OguyLvBsWm0i+5
	 /RGf8rjKBDNc+ZSeQLOQ/8Yi9Vdb5yBlpn9U8l/Zb4YuuwlLigeOo3EyjLWhMi0gY8
	 PVJ8XDGGtpwv20rh7AlZBD7iYlHQ9GpqXXpzeTxsw1yvEXd4ylMa+79ig4QZTqxUbh
	 7aHJjplizCB8E0L0NAgbNaf+WxVC9T86Ul8O5NyYMDErphpgHd5PEhI8yaTBkUfZiI
	 SINQrOJBgRBrMa9412RBpZ/9IRGXrs+OomBu9BVUVJewCztUvqct6JMJ/0xQbJ+Z0A
	 34735Hu5TWwZw==
Content-Type: multipart/mixed; boundary="===============5141152035541028834=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <714f119d120fb9ba4aa7e82af621edb7bc97813a760c9dd2cb5363c55b7365a9@mail.kernel.org>
In-Reply-To: <20260928150121.1712559-2-tjmercier@google.com>
References: <20260928150121.1712559-2-tjmercier@google.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
From: bot+bpf-ci@kernel.org
To: tjmercier@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,tjmercier@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 15:46:08 +0000 (UTC)

--===============5141152035541028834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 53c99fe4f176..5db11a21ce98 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -828,8 +861,12 @@ static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
>
>  	if (l) {
> -		if (mark)
> -			bpf_lru_node_set_ref(&l->lru_node);
> +		if (mark) {
> +			struct htab_elem_lru *l_lru =
> +				container_of(l, struct htab_elem_lru, elem);
> +
> +			bpf_lru_node_set_ref(&l_lru->lru_node);
> +		}
>  		return htab_elem_value(l, map->key_size);
>  	}
>

[ ... ]

> @@ -1310,16 +1349,19 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>
>  static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
>  {
> +	struct htab_elem_lru *l = container_of(elem, struct htab_elem_lru, elem);
> +
>  	check_and_cancel_fields(htab, elem);
>  	bpf_map_dec_elem_count(&htab->map);
> -	bpf_lru_push_free(&htab->lru, &elem->lru_node);
> +	bpf_lru_push_free(&htab->lru, &l->lru_node);
>  }
>

[ ... ]

> @@ -1500,15 +1543,18 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  		goto err;
>
>  	if (l_old) {
> -		bpf_lru_node_set_ref(&l_old->lru_node);
> +		struct htab_elem_lru *l_old_lru =
> +			container_of(l_old, struct htab_elem_lru, elem);
> +
> +		bpf_lru_node_set_ref(&l_old_lru->lru_node);
>
>  		/* per-cpu hash map can update value in-place */
>  		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),

[ ... ]

> @@ -2505,7 +2551,10 @@ static void *htab_lru_percpu_map_lookup_elem(struct bpf_map *map, void *key)
>  	struct htab_elem *l = __htab_map_lookup_elem(map, key);
>
>  	if (l) {
> -		bpf_lru_node_set_ref(&l->lru_node);
> +		struct htab_elem_lru *l_lru =
> +			container_of(l, struct htab_elem_lru, elem);
> +
> +		bpf_lru_node_set_ref(&l_lru->lru_node);
>  		return this_cpu_ptr(htab_elem_get_ptr(l, map->key_size));
>  	}
>
> @@ -2521,7 +2570,10 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
>
>  	l = __htab_map_lookup_elem(map, key);
>  	if (l) {
> -		bpf_lru_node_set_ref(&l->lru_node);
> +		struct htab_elem_lru *l_lru =
> +			container_of(l, struct htab_elem_lru, elem);
> +
> +		bpf_lru_node_set_ref(&l_lru->lru_node);
>  		return per_cpu_ptr(htab_elem_get_ptr(l, map->key_size), cpu);
>  	}
>

This isn't a bug, but would a small helper keep these call sites to one
line, matching the pcpu accessors this patch adds? Each site now repeats
the same container_of(l, struct htab_elem_lru, elem) boilerplate followed
by bpf_lru_node_set_ref(). The patch adds htab_elem_get_ptr_to_pptr() and
htab_elem_set_ptr_to_pptr() for the pcpu variant, but open-codes the
container_of for the LRU variant at every site.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36441357391
--===============5141152035541028834==--
