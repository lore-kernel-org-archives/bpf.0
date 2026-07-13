Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2B3310784
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969342; cv=pass; b=P7tEQFvaM3wpOXxQQ8sEJP/1hn9p8caSIpOleCPdeOAlJ/uJvVekjjb3uiUzj0ojFmx6KLeTNOqWyLMA8CtApqF6XkKdrhQqd2Wo2y5Xf1KtHGVh/T4/5Yt1WrJcQaqNMJB9yNa4D+M2OxR11t6wJI8DoC+2o4GJaRAjg8W0tjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969342; c=relaxed/simple;
	bh=LMuqfZdWNwDdBh+LD9S3nyT7cT9j5t4BEatyJl8ieNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9F6XV5XnvliO/EId1i54dPgxNa2UNetMUryLmKJ3O+h+LRvGqSxEhYj6cUpwWdHSvf/XhxSlUAXfcXrvaNpxJK5+gmGRQDL8JdbxXYbnApyw86UXAnAh8z6+NkpeoOGDHpYBLIvfefwQYezi8zMGxPclLn9tyQZgndjQzlovgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=JMVm1WFp; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="JMVm1WFp"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8eeb4508f29so32290366d6.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 12:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783969340; cv=none;
        d=google.com; s=arc-20260327;
        b=nzqlkcmd+n7KdjRZ/EK6TqvlLSmlqpatgbgSDsYkxcwhT2E2/0RrAeBcvVUXSDcA79
         KFrDGKbh/SPCaBOSN3WPkSpk5gN3CGugNUX5BOw7ZYHJmJ3fPjIxV1LGIHRCE1pHOJeN
         VV8IUWuBojRHU7tcpCLHfmesTEQ/oZnNRff+cUHc3fTotyEVjRe+hM7MM4I/DHB/UYd/
         I9a4k/shhV97I3Tvs/xJAa0vhzZcehzfxhtbmE3gOEHR0jEWscf5sjJGA2NWzqyC7GWa
         X4W+XAeZGDTCFBDfLUD+79x8kKfWxoTf9rnJd0F2U1Gw1rd23Xt8qZNMa1iOW8bOzKpL
         Jlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ND4QVlZryHNvw3JTPiSudd8z751cUXLs/D6Kbqr80w8=;
        fh=s8QdQtxftUlaYHOX2Bpmks3+9l4ZxMUJEmvv2haRIg4=;
        b=ihZON9P6iW/5OuBbJR72PCnbTn8VTxwS+UZrRtMIIhlAaDrvwepjFFhrxesxvYFVdj
         j7ScgL6HhS5HMG51qNNniJRn+klZmn0lHVtAC6U03+b79NmsxwTTi+dHgPKBpKvyWev9
         eNmq1YC8if85uQOcnZaAWdTH8KiCbTjXnCWwZTi2chmTb9vR0QnMJlbzi5ejpxRvEtoW
         8BOJbdm70KT5n8J8nRxRVUR4Hdz7QHHIgUo3jQvv6p6eqtGTD7J2A6m6prPEGh6dQ0io
         9BVCHqjHqjfLu0/KidGygu6NFf8tkppGO724LWCUceBiak8OYYhMyusi3nEtaU1YU+ha
         P8gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783969340; x=1784574140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ND4QVlZryHNvw3JTPiSudd8z751cUXLs/D6Kbqr80w8=;
        b=JMVm1WFplqYsrXcPLs3AedRTScc0vYo7irVLJLwx7bJPljsuhiB4h9UYsNvfAsHr+b
         4tkw6+h5cJ6sQ6EjIWJFhqRoO4iwi2798JyZABNCWPsaODJp4x+QN7hxThCtkb8qf9Ea
         LLQB6XvtGzGzYrBVcTN7muBxPoQgKALcGeg2gIKV/7jFEzDcgkONjLIFMup6Q25A/zEi
         lzQXzcKBQRXpB4/wWU8uQbJwuKjzYZClkRD7qKgX90TT1YNVFG6knNUzAga7vL5hjcIm
         bSTlTffrAFfIUeqWqbyN78eN1D/V7mqsRl02l0Zox2fTkSfRjtH95P5sOGFqdwBJDKK0
         P0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969340; x=1784574140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ND4QVlZryHNvw3JTPiSudd8z751cUXLs/D6Kbqr80w8=;
        b=RC5QJNUtxd3a8GElJIKCaQYvF8Lpbh2juQ8drsPfaw97O5el2aDFSZruYrK+jhFo+Y
         GslkHDcybrtLtYM/CMp6KxVyUZ7t62YqAvI8+cbkhJV20PsYkCH2amqVi/Ymgy+Gyd74
         1lmkTwptvlbuf11EsgRAxXAy44KQ/2k0DIUA1FFnbQ/Vobe4AfAVPzLOMIV6uhdL17jw
         Nlsupgrd1nYOn4iDsRDv5MsiN2u/mnVGFomnRujP/5rQrYhTSMjzrmOFuQOf/wgnHDBc
         wmFu4S11u3YpgnCmh27WGlFXt3Dh83hoxos2xVWuuTaJrkus10zLd2KzAj+mqwT6KMrh
         0Vqg==
X-Gm-Message-State: AOJu0YxBumJT5NQxciS8UgiROGHfcfyohoPNH56MSlFQr1VHJFDEKfpK
	+/AFN3eSHAmJw+W/roIinPDptNiE/bD92H1q+R3X69pq4ppnR6X5Ejt0Yw9v6RAIWcEpS8g/ZbQ
	OGovIMHI1LTED6CNhTrdrRi5w6aZeC4k/nRU4C1OEhw==
X-Gm-Gg: AfdE7clBXQTJlNGtwg9fhgoztPSnI16nFqkAwNpGCrt0DrJLDSNkaNjXthX1Wn/cECA
	mOR7eSa5Hz7l3joYHLl7KGfqY7yZKrxJA6TUlLn3DtJZb1aAmfE5acbJwlz/33vwC/IvJYSo+ia
	mHxgS/ok0EKFKwJN392Mj149OxlApxl90paD20dAQNozSDrX94zSsimtoqg7aQVqhZl5fq68MtE
	Zv3l13WLCpUi1jK+8ik9B6fi1TcJgfcFPAgeRtOYIurdfBhIkJpj0f1VgfN7qFG8zxlfD8r
X-Received: by 2002:ad4:5f8d:0:b0:8fd:6de3:bba7 with SMTP id
 6a1803df08f44-904053d935dmr129372256d6.61.1783969339661; Mon, 13 Jul 2026
 12:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-2-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-2-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 13 Jul 2026 15:02:08 -0400
X-Gm-Features: AUfX_mxL4zz4204ui_yf_Z_RxH1muCe8ChhqbsvT5mXw7tis6KUbLq5ezLHCMTQ
Message-ID: <CABFh=a6kCQHztTXZpndBTRRo7FWAfZ1NtzZJm5a7qmY1gd_b4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/15] bpf: Remove __rcu tagging in st_link->map
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 2:59=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> st_link->map is always written under update_mutex. The paths that read
> st_link->map with rcu_read_lock() are not in the fast path, so they can
> simply take update_mutex instead. Remove the __rcu annotation and replace
> all RCU accessors with direct pointer reads under update_mutex. Use
> READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
> without holding update_mutex.
>
> It is a simplification change.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---


Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
>  kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 51b16e5f5534..d06b3d9bcc13 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
>
>  struct bpf_struct_ops_link {
>         struct bpf_link link;
> -       struct bpf_map __rcu *map;
> +       struct bpf_map *map;
>         wait_queue_head_t wait_hup;
>  };
>
> @@ -1257,8 +1257,7 @@ static void bpf_struct_ops_map_link_dealloc(struct =
bpf_link *link)
>         struct bpf_struct_ops_map *st_map;
>
>         st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> -       st_map =3D (struct bpf_struct_ops_map *)
> -               rcu_dereference_protected(st_link->map, true);
> +       st_map =3D (struct bpf_struct_ops_map *)st_link->map;
>         if (st_map) {
>                 st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, =
link);
>                 bpf_map_put(&st_map->map);
> @@ -1273,11 +1272,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(c=
onst struct bpf_link *link,
>         struct bpf_map *map;
>
>         st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> -       rcu_read_lock();
> -       map =3D rcu_dereference(st_link->map);
> +       mutex_lock(&update_mutex);
> +       map =3D st_link->map;
>         if (map)
>                 seq_printf(seq, "map_id:\t%d\n", map->id);
> -       rcu_read_unlock();
> +       mutex_unlock(&update_mutex);
>  }
>
>  static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link =
*link,
> @@ -1287,11 +1286,11 @@ static int bpf_struct_ops_map_link_fill_link_info=
(const struct bpf_link *link,
>         struct bpf_map *map;
>
>         st_link =3D container_of(link, struct bpf_struct_ops_link, link);
> -       rcu_read_lock();
> -       map =3D rcu_dereference(st_link->map);
> +       mutex_lock(&update_mutex);
> +       map =3D st_link->map;
>         if (map)
>                 info->struct_ops.map_id =3D map->id;
> -       rcu_read_unlock();
> +       mutex_unlock(&update_mutex);
>         return 0;
>  }
>
> @@ -1314,7 +1313,7 @@ static int bpf_struct_ops_map_link_update(struct bp=
f_link *link, struct bpf_map
>
>         mutex_lock(&update_mutex);
>
> -       old_map =3D rcu_dereference_protected(st_link->map, lockdep_is_he=
ld(&update_mutex));
> +       old_map =3D st_link->map;
>         if (!old_map) {
>                 err =3D -ENOLINK;
>                 goto err_out;
> @@ -1336,7 +1335,7 @@ static int bpf_struct_ops_map_link_update(struct bp=
f_link *link, struct bpf_map
>                 goto err_out;
>
>         bpf_map_inc(new_map);
> -       rcu_assign_pointer(st_link->map, new_map);
> +       WRITE_ONCE(st_link->map, new_map);
>         bpf_map_put(old_map);
>
>  err_out:
> @@ -1353,7 +1352,7 @@ static int bpf_struct_ops_map_link_detach(struct bp=
f_link *link)
>
>         mutex_lock(&update_mutex);
>
> -       map =3D rcu_dereference_protected(st_link->map, lockdep_is_held(&=
update_mutex));
> +       map =3D st_link->map;
>         if (!map) {
>                 mutex_unlock(&update_mutex);
>                 return 0;
> @@ -1362,7 +1361,7 @@ static int bpf_struct_ops_map_link_detach(struct bp=
f_link *link)
>
>         st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
>
> -       RCU_INIT_POINTER(st_link->map, NULL);
> +       WRITE_ONCE(st_link->map, NULL);
>         /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>          * bpf_map_inc() in bpf_struct_ops_map_link_update().
>          */
> @@ -1382,7 +1381,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct=
 file *file,
>
>         poll_wait(file, &st_link->wait_hup, pts);
>
> -       return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
> +       return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
>  }
>
>  static const struct bpf_link_ops bpf_struct_ops_map_lops =3D {
> @@ -1438,7 +1437,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr=
)
>                 link =3D NULL;
>                 goto err_out;
>         }
> -       RCU_INIT_POINTER(link->map, map);
> +       link->map =3D map;
>         mutex_unlock(&update_mutex);
>
>         return bpf_link_settle(&link_primer);
> --
> 2.52.0
>
>
