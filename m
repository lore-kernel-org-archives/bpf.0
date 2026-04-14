Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD772F28FF
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188996; cv=none; b=Idre373/qDTSG4W7TMSrPgg4mfkF58dP1wFLoI+Ga3z/LV6ItQaZ+SeTY72q6mcu1/F59lhbJiTSfLzF7YDwR6JSe3USe4xCXpgrbcDjAmexPw2YwoJMuXNttiZLbWB3VdEa/VD6auUpPy+rKJqhGiLYwI2ZzWkU1iMR85l6zJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188996; c=relaxed/simple;
	bh=/ipNYoEtNezkjmauz1647+Y4p9Z6Ou68v01/uu70WvY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pvFR1tfcP7FCITJrouu7v4/tO4NUGpy2XFwoiGCym8E8UZkbW0/x0Y+Vlf/ReS+Groi+nl+87rLGLrAaEjMfmWUecL33Pb0aKZYsB2kaURRniC9e/oOE7qHoyasiXsnDCvqJgEs2DaVSkrJTnZRX99L8t0bwqICp1sD4Rs3PfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eOiu9VoC; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eOiu9VoC"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c55e3858cso2838229c88.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776188994; x=1776793794; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le7mStrPwRmrLkvcnTE12jPXoWLyTUtf8ynm8jV4bw8=;
        b=eOiu9VoC4NYqvMoM7SkqctnG+g0ZWiOpx8wNEL4GKZC0V4bClt9dzJu0l8/iMSKeb3
         9TlJlnbxc8ys30YRtK421LAQ6MB1sK6T31FfoRaKlhC+SIt5M92wtskrVJt7bDdclfx9
         NvIszCt+iO/t/VerUCB6+b3yLJhtBTXme7pBXii0TYxqnk40UnERm/V4tjPUVqLyTCSm
         RKFMqrr0RSYQALWOr8AhqXrmq8wySplLFkOBFtCl756OPb4qSsuL9jirifKgPvejI43A
         GwINB7YgvMFO7IYvKQTXJOT2/KdQKcBjqBUDYzuDtm2qS2rwQRnx6mfKN28Xvc6xpXAP
         NPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188994; x=1776793794;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le7mStrPwRmrLkvcnTE12jPXoWLyTUtf8ynm8jV4bw8=;
        b=JCmTM9Ae3ZF9zs8ufGu1Cz1+0+c2TCAVeFou8TpM9NGc45/+e41kTnX53hZQCd1Are
         Ri8JnIX/z1rLZ+7mi5QL2itlh1xGO4z95ha/P0WEyos/QVTn8lBmDTqfhdXzMvJmxM6/
         HzJtW/l125obph/OpMVjS2kLUM3+8/bfpVz4XIypfPX0FSsCQh4BetgwIJXKVE4/i5hQ
         JB3OUUPrR25q8Fb5WSiz421e1yQ6fGFsu8R48TU0xNI1q8wm232N8l5+QdgOYbUneLyh
         8y9wH1/ETIE4sdHH+3OUWvf4zH+D/K5jS4TGm6T9jYuYhwYki1sH5ST2BsBGSUK1xmdh
         6sng==
X-Forwarded-Encrypted: i=1; AFNElJ+vP2UGTiFdYRfMCyp78LOl9EAA3+R5f5wIoYA54hjnsUDxTb+enuHEokLWnxHTr+O8Hto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwYB/4Bsm+UzhZqKHASHOq97jMAfzdT47Et2l1FY1P/jnqWRxX
	ycx4hoezOEVcdvMv5pK8VEnhu2qQyuFRX4NWwpQHk9wjqk3LUqiMjWS7zb3y67pcHrE=
X-Gm-Gg: AeBDieus3cUJx9Gor76iRPCMmW7mJvOCZ0IXzTfDi8rVgfplWuuJ4PPzE6/7Dy0s0an
	AKwXxVYdkhBE1LgAC91FUqYLwgKUq4LUlatH8bK4v6DBDTbheJsghzaMCV9X08MJuBc91tYjR5Z
	qrcCwuo45LjdSCzfjHIPOrbLYB9vmwLI1aC8UR/Gm1JnijkVB0aoMR5drxup3YlZ4506EnxNO1Q
	X2QVT/5wcnu+zGDagXhAMPVPSYeWOVgBIhdAC+uuH958M1NRZgoWPFndRQ2K+EIkNiK3AWWNyBz
	nRIuZks9TZBCgBsxTh2ag3RgN+ItcP2Tptw5E81M1o+n+5KpnA/B7Uuc57c68bHbEn+ZvhR95y1
	rHqA70yYJMkj6vGPIy2aQx6KAFWCEV2MOrqjtGJiIdQD9oA1Z6WGwu5HoFRk/H4D9oqoFM09w/8
	9yYzpwbUOXyKlnrHw=
X-Received: by 2002:a05:7022:6088:b0:11b:f056:a19b with SMTP id a92af1059eb24-12c34eedbbamr11388789c88.18.1776188993529;
        Tue, 14 Apr 2026 10:49:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cfa6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80b1ab811sm12812458eec.17.2026.04.14.10.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 13:49:51 -0400
Message-Id: <DHT2G66ICGQ6.QY3NGX24ZE12@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for
 resizable hashtab
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-8-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-8-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
> bpf_iter and bpftool map dump work with resizable hash maps.
>
> Use rhashtable_walk_enter_from() with a saved last_key to resume
> iteration across read() calls without linear skip from the
> beginning on each seq_start.
>
> Also implement rhtab_map_seq_show_elem() for bpftool map dump
> in non-iterator mode.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/hashtab.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 94 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index a79d434dc626..492c6a9154b6 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3008,6 +3008,19 @@ static int rhtab_map_get_next_key(struct bpf_map *=
map, void *key, void *next_key
> =20
>  static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, stru=
ct seq_file *m)
>  {
> +	void *value;
> +
> +	/* Guarantee that hashtab value is not freed */
> +	guard(rcu)();
> +
> +	value =3D rhtab_map_lookup_elem(map, key);
> +	if (!value)
> +		return;
> +
> +	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
> +	seq_puts(m, ": ");
> +	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
> +	seq_putc(m, '\n');
>  }
> =20
>  static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t call=
back_fn,
> @@ -3201,36 +3214,113 @@ struct bpf_iter_seq_rhash_map_info {
>  	struct bpf_map *map;
>  	struct bpf_rhtab *rhtab;
>  	struct rhashtable_iter iter;
> -	u32 skip_elems;
> +	void *last_key;

Nit: Could we avoid adding skip_elems to this in the first place since
it's never used?

>  	bool iter_active;
>  };
> =20

Question: Would it make sense/be worth annotating the seq functions with=20
__acquires/__releases(RCU)?

>  static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>  {
> -	return NULL;
> +	struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> +	struct rhtab_elem *elem;
> +	void *key =3D *pos > 0 ? info->last_key : NULL;
> +
> +	scoped_guard(rcu) {
> +		rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
> +					   key, info->rhtab->params);
> +		rhashtable_walk_start(&info->iter);
> +	}
> +	info->iter_active =3D true;
> +
> +	elem =3D rhtab_iter_next(&info->iter);
> +	if (!elem)
> +		return NULL;
> +	/*
> +	 * if *pos is not 0, previously iteration failed on this elem,
> +	 * so we are restarting it. That's why no need to increment *pos.
> +	 */
> +	if (*pos =3D=3D 0)
> +		++*pos;
> +	return elem;
>  }
> =20
>  static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_=
t *pos)
>  {
> -	return NULL;
> +	struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> +	struct rhtab_elem *elem =3D v;
> +
> +	/* Save current key for O(1) resume in next seq_start */
> +	memcpy(info->last_key, elem->data, info->map->key_size);
> +
> +	++*pos;
> +
> +	return rhtab_iter_next(&info->iter);
> +}
> +
> +static int __bpf_rhash_map_seq_show(struct seq_file *seq,
> +				    struct rhtab_elem *elem)
> +{
> +	struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> +	struct bpf_iter__bpf_map_elem ctx =3D {};
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +	int ret =3D 0;
> +
> +	meta.seq =3D seq;
> +	prog =3D bpf_iter_get_info(&meta, elem =3D=3D NULL);
> +	if (prog) {
> +		ctx.meta =3D &meta;
> +		ctx.map =3D info->map;
> +		if (elem) {
> +			ctx.key =3D elem->data;
> +			ctx.value =3D rhtab_elem_value(elem, info->map->key_size);
> +		}
> +		ret =3D bpf_iter_run_prog(prog, &ctx);
> +	}
> +
> +	return ret;
>  }
> =20
>  static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
>  {
> -	return 0;
> +	return __bpf_rhash_map_seq_show(seq, v);
>  }
> =20
>  static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
>  {
> +	struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> +
> +	if (!v)
> +		(void)__bpf_rhash_map_seq_show(seq, NULL);
> +
> +	if (info->iter_active) {
> +		rhashtable_walk_stop(&info->iter);
> +		rhashtable_walk_exit(&info->iter);
> +		info->iter_active =3D false;
> +	}
>  }
> =20
>  static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_=
info *aux)
>  {
> +	struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
> +	struct bpf_map *map =3D aux->map;
> +
> +	info->last_key =3D kmalloc(map->key_size, GFP_USER);
> +	if (!info->last_key)
> +		return -ENOMEM;
> +
> +	bpf_map_inc_with_uref(map);
> +	info->map =3D map;
> +	info->rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	info->iter_active =3D false;
>  	return 0;
>  }
> =20
>  static void bpf_iter_fini_rhash_map(void *priv_data)
>  {
> +	struct bpf_iter_seq_rhash_map_info *info =3D priv_data;
> +
> +	kfree(info->last_key);
> +	bpf_map_put_with_uref(info->map);
>  }
> =20
>  static const struct seq_operations bpf_rhash_map_seq_ops =3D {

