Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20463241C8C
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980147; cv=none; b=MdUrRyjp6iXoTuB/xJTLr+9aQuCa7PhMcDw4zKK7sQdCmu9feBk+MZVIiRN/O/g4uCYfh0nkn0hNkW5d5WWvzBlGHdIcPQinbf4VNIt6Nk4wsW7o+25q8tnjJ3TobWOoZOY1zKWB0wc5TJAXEVcZBAyM64aya9bDAKQnZYj8iXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980147; c=relaxed/simple;
	bh=9yS1UvlUrfI9KheCLuEuSRoWZobPi0nd+1A15hyorw8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=tGMJswXO0IMWCPFhsq7fJg+M69orwuEJznWDwWcVfh9MXAlhbU1eC8PhsFmztQUZtUdzcFQWxoL07SDLqlVxJZ9UVTmwqO2FVBEttqe3zkJ9E1z50/msqaJ0rMGj4VRiUDR1xQSnLha5yC8dxMjbCuh9MGFNZ7W0iW6toiTY93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Rr165AVC; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Rr165AVC"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-96925a563b5so296293241.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783980145; x=1784584945; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D6Y7Xe1SbiMFbOzf01pbOyxaH8rw40mxymdbfU2kNyQ=;
        b=Rr165AVCAlPQhbOjF6rODbV+KA0nvTKClCB5A+8Jm/FOWMDNmxNZTUrJFUsCC/BWKA
         Q1M7bkgFZQ1WVEwdVoditivmKWIJVi2x8HNNLLqOn77YjvKCRtQUXfSGakonD7nVwTCK
         TgzwgDVpNFdeBVTHX2MItOM3pcByyEnuR6/wdEuOLOrhJG1Qkel45QQmDcrb7eSm2JSl
         cZSPYx22oHo/3qkicc8jcNZPdVqw6AkYCirqRFr2YK735EUkEZf6pyLjbhHtUX1qrz74
         KigTkNqbydSbdjg46Lcj8D+pkE5CR8wDes7U8yL54aIsYW/aY3xAYm+vFY6ix3hO4Pch
         q+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980145; x=1784584945;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6Y7Xe1SbiMFbOzf01pbOyxaH8rw40mxymdbfU2kNyQ=;
        b=ABBPbNxLZW/VsKZ4eqI3RIBdWWhzzMPmW4fvRHzrPhCoR7Nfh3QlT4OEreIuG7jwBt
         qkDKQHa+h1OGt4AluA/6s0zewBm8b2rOTAU/mckZSVUqOHykhIcex49+8vM480dNDRmX
         swJ6uta1na9gYtpxNR4Z1Vfxt00/O2mlG/wjunDqf5d7soFkktRFNhjsXKsh3rmksiFL
         VDi9cRMTJ+dgLzuXpNdUlpw4eboF8GTSbG+DCMZmHzBRl5yXOMCesqlPlQKQ56o3WwPg
         InmDQ6jGyREWnYMIQrqiGQO9N7qSdqNGnw+zUzpbcOPDlC0wXOPmfYXu0IXyS3xsPV2A
         fpsg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9OAh2iTFDMLJ5/2sadQ4sQ1xjVLcgmPhp//6AHCX9a4PdboWyJpH9OjPmKaVgOsA2vMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGKI0qX1PGgYCatL5NQ0E/h6dkvz09Ed/pXeM+Pcn+wUwRHO/F
	AziHD6fq0oKfTZQppmLJoSWdWNru4ebUzHNh3ZJ2YEZiSwFU9aG4h3I5LUfhNiX8InZyLtGHfZH
	hUBnrv98=
X-Gm-Gg: AfdE7cnsCneZTb1zlmNDJAtK5XhM3nnHhHaWU/oegDbs0B5jGwQEjVz13XQuzHKdGHn
	Mak7Z2/Tt3FWu+TiByBen5e8WhsKvZbpWp2RKgteLpw/1Nn+F/4PBNWk9Q1Trt/Sl/HVBN4sErB
	z2tmDhY9kQsG7OPxr6hw0ltv8V9wciwP+OsbBD7TAREnvYvcuj9UtB5HV+8M8lDwE8+jrM0fzlF
	wXqihKO8YtTyOY6dDJd5sbsG57rKBjtiN48A/iLfNi5oXHnbj+76CzBHU7l6lySE7WbS59iLz5q
	RTeNUUoJ7f/9EvsLO/AUGUN7HXfnB6ElREgmyXtkkfOjqWW8Q74xNXeByn3VwCtXfIrDL8jEprA
	LY54T39QgtkWs7IDCKSlZHPEvG1YYk1RwKmiBwq8V0eEMWZ4pn0/qbk5M8QU8RjT83FLKD6zkt6
	74uzhQ8EgMUlS5Vmai7PtR2hlxqVYlTPse/bIoGVORCA==
X-Received: by 2002:a05:690e:dc6:b0:666:5727:4d70 with SMTP id 956f58d0204a3-667d978ecb3mr7088216d50.13.1783979764886;
        Mon, 13 Jul 2026 14:56:04 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6678775d59bsm14750206d50.4.2026.07.13.14.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:56:02 -0400
Message-Id: <DJXS1OUUJXX5.15RH1OEET2EB7@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Add prog_list_init_item(),
 prog_list_replace_item(), and prog_list_id()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-7-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-7-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Add three helpers to abstract operations on a bpf_prog_list entry.
>
> Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
> which returns either pl->prog or pl->link->link.prog. This will not work
> when struct_ops is attached to a cgroup because the attachment is backed
> by a struct_ops map instead of a BPF prog.
>
> The same applies to __cgroup_bpf_query(). Instead of always copying a
> prog id to userspace, struct_ops cgroup attachment will need to copy the
> struct_ops map id.
>
> Refactor bpf_prog_array_item initialization into prog_list_init_item()
> and prog_list_replace_item(), and refactor id lookup into prog_list_id().
> These helpers will be extended to support pl->link->map in a later patch.
>
> This is a no-op change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Followup on prog_list_prog() since I hadn't realized it was moved to the
helpers in this patchset: Maybe we can just make it not return NULL
since it's impossible instead of adding error handling to minimize
churn.

>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b100c04cb9c8..b43f0bff184c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_pr=
og_list *pl)
>  	return NULL;
>  }
> =20
> +static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_pro=
g_array_item *item)
> +{
> +	item->prog =3D prog_list_prog(pl);
> +	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
> +}
> +
> +static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_=
prog_array_item *item)
> +{
> +	WRITE_ONCE(item->prog, pl->link->link.prog);
> +}
> +
> +static u32 prog_list_id(struct bpf_prog_list *pl)
> +{
> +	return prog_list_prog(pl)->aux->id;
> +}
> +
>  /* count number of elements in the list.
>   * it's slow but the list cannot be long
>   */
> @@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *cgr=
p,
>  				item =3D &progs->items[fstart];
>  				fstart++;
>  			}
> -			item->prog =3D prog_list_prog(pl);
> -			bpf_cgroup_storages_assign(item->cgroup_storage,
> -						   pl->storage);
> +			prog_list_init_item(pl, item);
>  			cnt++;
>  		}
> =20
> @@ -1015,7 +1029,7 @@ static void replace_effective_prog(struct cgroup *c=
grp,
>  				desc->bpf.effective[atype],
>  				lockdep_is_held(&cgroup_mutex));
>  		item =3D &progs->items[pos];
> -		WRITE_ONCE(item->prog, pl->link->link.prog);
> +		prog_list_replace_item(pl, item);
>  	}
>  }
> =20
> @@ -1318,15 +1332,13 @@ static int __cgroup_bpf_query(struct cgroup *cgrp=
, const union bpf_attr *attr,
>  		} else {
>  			struct hlist_head *progs;
>  			struct bpf_prog_list *pl;
> -			struct bpf_prog *prog;
>  			u32 id;
> =20
>  			progs =3D &cgrp->bpf.progs[atype];
>  			cnt =3D min_t(int, prog_list_length(progs, NULL), total_cnt);
>  			i =3D 0;
>  			hlist_for_each_entry(pl, progs, node) {
> -				prog =3D prog_list_prog(pl);
> -				id =3D prog->aux->id;
> +				id =3D prog_list_id(pl);
>  				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>  					return -EFAULT;
>  				if (++i =3D=3D cnt)

