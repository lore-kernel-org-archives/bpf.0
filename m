Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE90409613;
	Tue,  1 Sep 2026 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248250; cv=none; b=GvYmgCDfkH35x8G1e8SGvSopkTRijRDUvLcZWLhexKp+U8V/dkiJDr7dJ9KN4Df5UeSrCucdiXyT5PUvbuyIHFpzyMwdtUc3NbZ2sHICWadD2uwXovy7UlmNYqhpqxyGivALNILAK+zHRNGIv8yZistc6MZNsAJ2QWlXJFyOqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248250; c=relaxed/simple;
	bh=YWhrTAzO18o0k0suaGfyHOgQG9gE9tNjI+kecFq43Y0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ooGf7fZXSDIgff01LivnF8Qua3atPZtEA3VoVGO8LHg41GcdVAuUgKv74xjosIo3J6tY+KvpKrLmTTLgGPcZuzKugy4z29O3fYOI/cWDgpNfp39ynDUl/XK94Xn9XHvE8xX8YIKjrJZXbDVLGfje8o+fuddEvQ9NFbL/IfHS/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQtHKsnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQtHKsnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0531E1F00A3E;
	Tue,  1 Sep 2026 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788248248;
	bh=5InVR3DIcYRXXZ5wturlq13dwqbAyrV8dms03I7kggk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bQtHKsnhXfXDB1Vba6gPfI/Pz2xAt8l+9kRaRNZrwV/wiMpx6Vi2KnPDSmV+E4qCd
	 jdewStYfoy25+JLY8tyYpxEw6blWALivvbwkMv3FLO6zHQeUbOHALYs3ZSwVimAPt5
	 2s6P795aL2zay9ALXYSvzipOkPmldElQQzXiLlVPwuQNiMo4k8p8LMJWwarpWFbsDw
	 O9Jkc+ZPpvQy6UXbxaFTuET6NO039dvKkW/ClUhSkrDG2Cb0bO0hGevWxQIm3G4/eX
	 s7yiKXYSBJVvG87PGS6jzEkoztCBavJJV5AQI/hhohHmGVNb0FHeXpO1yu4Q6Zf2QV
	 +MlizTOrNP9Rw==
Content-Type: multipart/mixed; boundary="===============6084755435345711036=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b691397e6e629330bea6bbb1f83af78a68e2a39a54af48f401f3f24f3078d879@mail.kernel.org>
In-Reply-To: <20260901062845.1379760-2-chenyuan_fl@163.com>
References: <20260901062845.1379760-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Cancel special fields in resizable hashtab on recycle
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mykyta.yatsenko5@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,gnq25@mails.tsinghua.edu.cn,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 07:37:27 +0000 (UTC)

--===============6084755435345711036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446ca..aaedda3730f37 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3022,10 +3013,12 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
>  	 * BPF_F_LOCK, matching arraymap semantics.
>  	 *
>  	 * copy_map_value() skips special-field offsets, so old timers/
> -	 * kptrs/etc. still sit in the slot. Cancel them after the copy
> -	 * to match arraymap's update semantics.
> +	 * kptrs/etc. still sit in the slot. Cancel the NMI-safe ones after
> +	 * the copy to match arraymap's update semantics; referenced kptrs
> +	 * stay attached and are destroyed by rhtab_mem_dtor().
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));

This isn't a bug, but could the second argument use old_val here? It
already holds rhtab_elem_value(elem, map->key_size) from the top of the
function and is used by copy_map_value_locked() two lines above.

> @@ -3066,7 +3059,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
>
>  	memcpy(elem->data, key, map->key_size);
>  	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
> -	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
> +	/*
> +	 * No explicit special-field initialization, matching the hash map's
> +	 * non-prealloc path: fresh elements come zeroed from the bpf mem
> +	 * allocator, and recycled elements had their timer/workqueue/task_work
> +	 * slots reset by bpf_obj_cancel_fields() on delete. kptr slots are
> +	 * left untouched so a recycled element keeps owning its reference
> +	 * until rhtab_mem_dtor() releases it.
> +	 */

A subsystem pattern flags this as potentially concerning: the
copy_map_value() call on a field-capable map type is no longer followed
by check_and_init_map_value().

Looking at the non-prealloc hash map path in alloc_htab_elem(), it
appears this pattern has never called check_and_init_map_value() for
fresh elements, and the bpf mem allocator does return zeroed memory. For
recycled elements, the kptr slot staying intact is the intended behavior
since rhtab_mem_dtor() handles final cleanup.

Could you confirm this removal is safe for all special field types that
BPF_MAP_TYPE_RHASH supports?

This isn't a bug, but does the seven-line comment block add clarity over
the briefer explanations already present in rhtab_delete_elem() and
rhtab_map_update_existing()? The same rationale appears three times
within about 110 lines.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33478386254
--===============6084755435345711036==--
