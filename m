Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496B345738
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120296; cv=none; b=fobsnJoQxDKnoUrohZVUEX+DfxPKWu9eBYW74vk/HbIbrbm7n9GilcTJNGhI2pTiLaOu2DHNHwoG2PWdIgwGpFJnakOupnUcIDXPH4dAeOvevKM+xKbLpfu9OSQgyPZmI0SbPsNstAHxYPAmLlwl6od6yWgmy/MnKGU9J1purZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120296; c=relaxed/simple;
	bh=sYO45TBPeOXG9Lfy1dmOACCAsFQiCRAQKFHstoHplPk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Xh5v/I7f4oqvDPahrX9h0BoYprmEkaB9Vh3ZAnBo2rQSfhJERIXROk/yA7mNvKRl4LblNr1s+Cxp4CD2poWTKzBMozlpDkK25pRr/fop2e7MGmJ6fPrxNnEjBiSX22h+8CEJYFegSN1fi3gUAgslr7/qsHz+htfGBAD0r27kYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=sppxBptN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="sppxBptN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab077e3f32so23686435ad.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776120294; x=1776725094; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNz9pv96ZeJxoR+9XrSZqJLWGfb+DxOQb+FuKBsrBOM=;
        b=sppxBptNWq1R8VqtxQloJgeFHj9PMOOScO42Jb1TezTNOIf96TRwBFGlvxm/aPfIj6
         3irE6Olmro8M/AsTgKkWF4y20GA6clsj8RLoe7qWf3WVJkiVg4jyQFUdyUxO5WPL9Car
         H/Ntuc8WgYTSfZTc8i6KqdFElDQd+z/gJAqkIcI/N4SrokdhL3Ui8ynyRUS2ErxPtLxE
         RkHCkMQhLvtahmAeiP9vGF7vlKRc+udwLdHV0sNv0uDezSxefMqm18F8zj4aLO940isr
         617704QLe5/DgUNX3QPbnph6ZXiUQuXJrusQiP5skciVRa/+bX4VjM6eXxxSpTOqdsB+
         6M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776120294; x=1776725094;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNz9pv96ZeJxoR+9XrSZqJLWGfb+DxOQb+FuKBsrBOM=;
        b=fTwT0BG3smEdHzfDSbyNfBXg6oXtlD3U2lI8+k3loiq8GoCrityBr3S7ebFNLf2Ag8
         4yqpgoFqjVD+efhjOUuaNPUr3vNjBzwwmOrBbOLgNOR1bnTkjUWNbvOwZ6iy4227ahwa
         dBqHfN9TcZHif+iG9mmr974Cj12l9vYb1wU9lP1/D/22vSgNaQtUKiFL0iZvvoCyMGsU
         hFiTqpETzOpzZJ7B3OXlVpj1etv48bNgRi+mO/A9PFcNgMI9+CTE867KfjqeVNeD7sP/
         wd6m2NBVvFJyhKXHG7Unk+n8le9Va8A7mJ/iFPDnHDP8+uh2DqSBlTSCWKLvyZaRiyE+
         nEHw==
X-Forwarded-Encrypted: i=1; AFNElJ8OAKwQ+Og4cVfny2XQNZ1FUDK9IrSHd90Vavj3dDJBlM9dJc6O4I2VXNBgg51spD4W7x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLtqyT0XwXyeYIuw72yfTHVH1iF76tlO3UDqe83x3OkcTd/J1
	i1EQALxIqSIY1Lnuq6eGGPIrH1MZVycvV76QNfVwZghOo2YP/aqMbpfmhxUNIfJBdyo=
X-Gm-Gg: AeBDiesrEVXyGoQxqQMFPLKhmhwRa4YEDRRH4dSqN8fT9/Bvyn6nYRPKLop/DWRz5We
	GiSWaZcZ+OCetiH5LJKsUDl7AnTGDIjoCWT6Ix57b/t15mDWx4SlyI+w8SXwmSkUMJE/KBhN0V7
	VuiZwIX0u9ovv15akEAlV3U1eaij+MHv3j22bv+KHvYkyKJKU7BaUx36+0OzeEJJm/3CIY4TNyJ
	B1ActasLW6V2mY7Qo0kjIGFKRdo5Lvo3BISnpAfpKJnGg/G8U8OwOJxep0mC2s26TYKdyOIuHeo
	zoFMlJETEDVxyFQidcf5fcFi5t0PCCREF2OmYQ1ENhHfdUiAoBTBkSm2Pr5uaTYHArxvsaZMhVV
	G18E/lUN82iIjt98gogcLiNB+qZtlX9madfUovC/9Vu7zNGog5KhsXPlIjLVKNA/TGGleCqDxHm
	tM7xRQNAl/qp24m1NRvwEPy57sBqjo
X-Received: by 2002:a17:903:283:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b45c0d3361mr60908035ad.38.1776120293773;
        Mon, 13 Apr 2026 15:44:53 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm128844015ad.71.2026.04.13.15.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 15:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 18:44:52 -0400
Message-Id: <DHSE3ICYF886.1JAWWOKCDODDF@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 05/18] bpf: Implement get_next_key and
 free_internal_structs for resizable hashtab
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-5-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-5-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implement rhtab_map_get_next_key() and rhtab_map_free_internal_structs()
> of the BPF resizable hashtable. Both are only called from syscall, so
> it's safe to use rhashtable walk API that uses spinlocks internally.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index ea7314cc3703..7eee450a321e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2921,13 +2921,89 @@ static int rhtab_map_gen_lookup(struct bpf_map *m=
ap, struct bpf_insn *insn_buf)
>  	return insn - insn_buf;
>  }
> =20
> +/* Helper to get next element, handling -EAGAIN during resize */
> +static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
> +{
> +	struct rhtab_elem *elem;
> +
> +	while ((elem =3D rhashtable_walk_next(iter))) {
> +		if (IS_ERR(elem)) {
> +			if (PTR_ERR(elem) =3D=3D -EAGAIN)
> +				continue;
> +			return NULL;
> +		}
> +		return elem;
> +	}
> +
> +	return NULL;
> +}
> +
>  static void rhtab_map_free_internal_structs(struct bpf_map *map)
>  {
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhashtable_iter iter;
> +	struct rhtab_elem *elem;
> +
> +	if (!bpf_map_has_internal_structs(map))
> +		return;
> +
> +	/*
> +	 * An element can be processed twice if rhashtable resized concurrently=
.
> +	 * Special structs freeing handles duplicate cancel_and_free.
> +	 */
> +	rhashtable_walk_enter(&rhtab->ht, &iter);
> +	rhashtable_walk_start(&iter);
> +
> +	for (elem =3D rhtab_iter_next(&iter); elem; elem =3D rhtab_iter_next(&i=
ter))
> +		bpf_map_free_internal_structs(map, rhtab_elem_value(elem, map->key_siz=
e));
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
>  }
> =20
>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *=
next_key)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhashtable_iter iter;
> +	struct rhtab_elem *elem;
> +	bool key_found;
> +	int ret =3D -ENOENT;
> +
> +	/*
> +	 * Hold RCU across enter_from + walk_start to prevent the
> +	 * element cached by enter_from from being freed before
> +	 * walk_start re-acquires RCU.
> +	 */
> +	guard(rcu)();
> +	rhashtable_walk_enter_from(&rhtab->ht, &iter, key, rhtab->params);
> +	key_found =3D key && iter.p;
> +	rhashtable_walk_start(&iter);
> +
> +	elem =3D rhtab_iter_next(&iter);
> +	if (elem) {
> +		memcpy(next_key, elem->data, map->key_size);
> +		ret =3D 0;
> +	}
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
> +
> +	if (ret =3D=3D 0 || key_found)
> +		return ret;
> +
> +	/* Key was not found restart from the beginning */
> +	rhashtable_walk_enter(&rhtab->ht, &iter);
> +	rhashtable_walk_start(&iter);
> +
> +	elem =3D rhtab_iter_next(&iter);
> +	if (elem) {
> +		memcpy(next_key, elem->data, map->key_size);
> +		ret =3D 0;
> +	}
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
Nit: The two attempts are partly identical, can you try to
roll them together and use a goto to retry? Or do you think
this will be too messy?

Otherwise:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> +	return ret;
>  }
> =20
>  static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, stru=
ct seq_file *m)

