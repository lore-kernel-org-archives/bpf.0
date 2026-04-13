Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649839C002
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121368; cv=none; b=FJf4ypZPXBxTJBtFOrwaVZzBwd3OUTK8eE2hhsVv7QTTQ5Xx/WnJCJufzkwdEZ3l97LpCpbsMUKyeg0nyIdgdoVBug9fFGbyS6/Giflomzh7i6X7h63RUd5LJIdavlke09Qj9tvUGvX3IjCU6ku2g9Dgf6yaHpC5fDN+EPPNlds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121368; c=relaxed/simple;
	bh=ztthlAM17TntFydkMoxIl78XY2lj4H+iR5d6M2V2Xik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xsxe61lmdqGB9Yzv3YMNHWrf6jj/vwG9bfCAKHdMItVzx69aIMoI252RztsfWFc8mc56C5UNGwNFpP2r66+7R71bkP+ShXrpv1gYl0q1Qo9UIAUA+zVl70sc9qR9jCPZqotFJ5H5CDUdLAooeZ0EOocjDWZO+oWyidRMusN/H4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=chfbgGTR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="chfbgGTR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f206f2b54so932620b3a.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776121366; x=1776726166; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl1SN0yZTTXMYjIYI71yLZFPsYiD6fBQFJB/kKyUGIw=;
        b=chfbgGTR3VEGPihK33AcivnJOlpGefPihyhdEPnEAAN2Sz+mjMcoi5JaOlKrUHhFOF
         cgcsaLX9pORxJr23NhD+bI+Q0nTP5JxhDbfoGkz6eGgmvrk+o6opLKbC0C42qPbldhE0
         olrg05uQoSASekE/jXN6sVtGr1qUw35YnbtjhWLBfev5UoiQgmzF8kUgM/HIBOcyH8cw
         OQte02G40MAzbKbGgjIga1/paGarSYNCdYocjPy0EP5mrQ52BbDVjmPFhua/qbYJEZtK
         2ubs0nqkHjuRFToBID4jqr1vW4MDdsnwMHIELIlJ/efPs/SSl2YRAHsoQ4Fck+n4JVid
         uytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776121366; x=1776726166;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cl1SN0yZTTXMYjIYI71yLZFPsYiD6fBQFJB/kKyUGIw=;
        b=mds/97lqjAj3dQopM3qjV4HgvxPCJDi8tn01SD8N+nhcazhMkcWT9fPC+LMcHNOGoM
         TjDCu6jahxcV+JjlVQtdnbPraBb4qiLMskR67fYSr7OmWJ2N9oLeWwnz6gX2+EdNgNNj
         YIbRHgf2Flgk7RsN6kKfnZrz3hGmTv7b53K3dAMb3i89dnpiQG6j4ZInj0kL9ECmLYpQ
         ZyOrnqt3Es+Nw7/rSJxF5dNTm6Nsf40bX4ngStpFKSIdX39v5RUcyulenoIh4XCrkfH2
         It69T3fmrKCIAIwCtgq9ZxVOvYIi0ZjSB+Zq1LP4+PetXJdL8kQBYpdDtlgp230mrhwf
         yyJA==
X-Forwarded-Encrypted: i=1; AFNElJ+DlYC1rdVOVMSx51no+EBts2LRqrdGHLiQkeSR4M913au9lx7XBf8rXh/LF5oJDbG3yYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPH1uHEupf6dz1I8a+cc9CxqfsuL98At8YNcj8iyCVvRRmhVva
	xL3Burso08YQ9JxgtW+0r2NnqI+vyAY9aaxqsFOU4ao0wMr2jotVumqHshbFvPbnO3A=
X-Gm-Gg: AeBDiet9eME8kHj02jR/d1eBlLnQqL8XL0Fti+mw+C4jIxmniNURTvyhA/CSgsEcKR8
	VJa0ZQkPmCCSsa8DfE1xuBGn333QaAPo1ewpsCesZfQKETdW/ni1HPUg8icm5x7VnpxZGYAloey
	kbVu1kHHHcp8rRat9p8tIgFBmSL0T2aiEBQRYAXObMF1YZT/psWD0ybN5Uz4B5dKmptMM//OOXu
	AjgQ3H/LyzXbuE35O8+zcU8ubKf6iJPgS1yypDCi+9Y3PDTS/9z+5rQG3RZOXjQPf82SKm0XWfX
	mJ71kUrhBW+LgZ/AV6fgrlDFQRF24KtgcJ/KrOPa8LKjs6M7/FhNyODcn8G3c42e+WuQt049Jni
	e7DUT7isCBeJpAwO4pojeBXq9M0prIy5k5OKN66uWmn6kvYYgnUeRRJABUrkFVrEhll9s4IUjrz
	P4mS5fhGZe9lGNPPztNA==
X-Received: by 2002:a05:6a00:94f5:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-82f44dcfb5dmr4481289b3a.34.1776121366111;
        Mon, 13 Apr 2026 16:02:46 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50d40bsm12092243b3a.58.2026.04.13.16.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 16:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 19:02:44 -0400
Message-Id: <DHSEH6V3WK9P.AI7TUT5Y4UQX@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 06/18] bpf: Implement
 bpf_each_rhash_elem() using walk API
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-6-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-6-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> rhashtable walk API takes spin_lock(&ht->lock) in start/stop,
> making it unsafe in NMI and hard IRQ contexts. Guard with
> !in_task() rather than open-coding raw RCU
> iteration that would need to handle resize races manually.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 7eee450a321e..e79c194e2779 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3013,7 +3013,40 @@ static void rhtab_map_seq_show_elem(struct bpf_map=
 *map, void *key, struct seq_f
>  static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t call=
back_fn,
>  				void *callback_ctx, u64 flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhashtable_iter iter;
> +	struct rhtab_elem *elem;
> +	int num_elems =3D 0;
> +	u64 ret =3D 0;
> +
> +	if (flags !=3D 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * The rhashtable walk API uses spin_lock(&ht->lock) in rhashtable_walk=
_start/stop,
> +	 * which is not safe in NMI or soft/hard IRQ context.
> +	 */
> +	if (!in_task())
> +		return -EOPNOTSUPP;

Use in_nmi()/in_hardirq()/in_softirq() instead?

> +
> +	rhashtable_walk_enter(&rhtab->ht, &iter);
> +	rhashtable_walk_start(&iter);
> +
> +	for (elem =3D rhtab_iter_next(&iter); elem;
> +	     elem =3D rhtab_iter_next(&iter)) {
> +		num_elems++;
> +		ret =3D callback_fn((u64)(long)map,
> +				  (u64)(long)elem->data,
> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
> +				  (u64)(long)callback_ctx, 0);

AFAICT this callback is impossible to be sleepable which is why we're
able to call it under RCU, can we note this here in a comment?

> +		if (ret)
> +			break;
> +	}
> +
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
> +
> +	return num_elems;
>  }
> =20
>  static u64 rhtab_map_mem_usage(const struct bpf_map *map)

