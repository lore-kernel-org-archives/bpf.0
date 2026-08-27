Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18C24EA90
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787799381; cv=pass; b=Kzvu8RyjpLvDATtybajhKdMa9Ykfi/dYPvwd8E/LI49TFDKzsIDQKZ2TbDDXeA++8Ew4g4wufmjwSfcDcuoAbDe6AoWVXRG/JElpWSesgxMjcoaJQBZtZllzhVJDgolx1+OFcmA8hTIn22Z9voxgtCsxzY6WuPY3MlRYCu29dL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787799381; c=relaxed/simple;
	bh=ZBhdSdl5+abIXlYKkjPbRcE9Y6VKqGLQ1FdukDJLIWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnjzOfzzgFHad+WCl3oioYtfMfBJ8JrBuQBZvsz+AAjKcoWJaI+kvB0VEAkfA4aKExVJodVgapvRLaQuDg61lF5U2ZzRt+TlGH1IzqpPij9Pw5AyQ019mjLjxV54l2xnqWEG+eouaIpk7lP3YyQuwnB0mjlDmiAMmbtiopsgTAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clepdlZW; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clepdlZW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1742249a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787799376; cv=none;
        d=google.com; s=arc-20260327;
        b=pXbWsnFPCvQjbm12R3mnIoAEjuumIVVPdDhb+VFY0xcwLhSByZ7O92FmZgSn0TJMr+
         4sGxcCJNEm7uBf4SsWP23jgTn26fDV7Xjk6KV0kXCGaNDl6yUrNbIgHX00nFSSvuzLIM
         xJyV48iEgS4xYDyTFz9fnrhOW10LjelUJjy4TwjNRxLHknt2V7EqFYh8MJ+JW680/ob2
         m4uvlcs2rwV51s5p1hetbYvRtvUEflaqXjuVf3J2D7alAcN3n6TLhHlMGW06bfYbfBkc
         h/PBuHIUy9IVwwJ7DGf3Ro9t6zIgE60o+se8uFJhsAAkHgu7MYneFclx+j30uUV4sN6J
         d28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BmocDsS7jcJjPt0AiPmcdXHK/Zgi5+SmiQPLaVUgJ6o=;
        fh=aDHwORZafV5EghjaAGcsO4U8q640TEdYqiyZuljn03Q=;
        b=OWWi//GrmH9F5FeA+SztdqtR7NpugwkSfyPEw+5MiUwMQnfpGyc9mWob/E4W81wSyc
         +8l56wgy4hawxGbtQmhcM7MSiYPQNgvBpHgzMHhJQZ6t40QOLb3PZ4OGkBbItbpFDEiy
         fDYz/5jbZ4+theerpzbdtVpeki2FIUeiFM1l5b/sGat0QXnzWmQB6IxjEwSmiHlWHqED
         Jzs63dIHKhT46C4oux4gQN4D74QzhJHIfxB8GZasCY9lwl7xY55YCrWHQOAg/A+/Suzw
         RAY86TyJ26g886iYDvjiPGiVbQib33Si38QC/dmrJd+ZU8PbJeHCg65W+Wa1G0K8pFSO
         8/uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787799376; x=1788404176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BmocDsS7jcJjPt0AiPmcdXHK/Zgi5+SmiQPLaVUgJ6o=;
        b=clepdlZWFH6yUAK33IQV7uPiXXs4OCCXfwqckBMWAhY7krwit5hbgX9y6B1Lq7DAJG
         9FnxSvQbpU7VRrbAdjhUSeYtgvbZH27cp0M0TZ1kvK5E6T102Id+E1ZWY5ho69wntGqs
         8s0DNGiEmaaYS4yezCMAs4jqQuaMaA4q9adYWQo4x5xdHkrBmHGRxgQxqDFwsNqE79Fh
         TmWK+dDw+m6+tVcifnz6hmiWc0DYI/KAwxOGfpfkF28sJq+aJtgnBbl18XrEshwM3alB
         modW6vXChhKVN1Xe9b223j00DCy8zEKM0zvGErGXJWLAm/TS4WZQwIcQiXXWn07qENIr
         a7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787799376; x=1788404176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmocDsS7jcJjPt0AiPmcdXHK/Zgi5+SmiQPLaVUgJ6o=;
        b=AKpKjvhAldn+OuIos6i7y6UDKB8+1ASujNRl1t8BjjJElor/Wx1Rf6LtJHLbpuXf0P
         T91pSiN/unLlb+9wDuYjKgxlm1gD9cSmqntMQqO0PtXtL6zspT33VGwnOzExvWAibKKP
         jBOOusAH9IiKhHLRs8u6oIZ+kUTVmbA5RATPn0fdUBSi8YPMpRy4/6bvxAeP857pj8oW
         QJ1Opyc/iipRe+x2aykXwZ74lLtowZ8x+iaXzSKzZBe3nU4fTy0umv39fCHyGy4xfLdG
         rFb7s7FtKX4D5jqEjzexAwm9etyYtiEadeIKuKjJwIEdgm/CQQo48p1ZNQpVsMLt0s/S
         nz3A==
X-Gm-Message-State: AFuF++mpIczUuUaU1yd2Bdn1oIvlr8O+nlYxW490RQ2zjF00KwXuTNAW
	9dbCkzG/B5SU6F8S8EtivmGLcziY1yQZu01WsV6qPmyxgjspCGO+pGM1thUjNObQPU+dPdgioX4
	0u8prtHpzYEdjSyU69VQa59IYVO0x5wg=
X-Gm-Gg: AR+sD13U1n/Lof/8z9thJI3W9anrUb88lBPeAEZgbodIdGUToStdohkNdes9OEDS6fA
	kTZkYZPHE5dBTIRH7pCxijU0fmc5YmqV1pedS1RC2Bvy9+H0XDAWC9eWFARDT62mJWKJ+4oRHaf
	sKYyQfAD7Hr6cCDIuNxT9ga+fM3DGiBEdt/vaiQOsX23tz/2j0cx5MllF4ekI6dmaigVhqqI7kC
	CMN8NxqdLRirEYIrRwrnuLdQ1T0zOlO1bCag3HY6Hu4xYTQ8SjzKZ2JFAzipqNtYeLPLfeJ7jH7
	c/AIk2tVEi5l9BFiIeLcsr7WuKD8KZhg56lvIfATMcbrYY8EN1syPLaft5qJ6s3hEawlO0jxIPP
	wAcyTJuDIAfThZ6O7vFiuowUIvzfpDoJ36tiqIltC+8pG9WRP2l2isMLNzH99/nw=
X-Received: by 2002:a17:90b:2604:b0:38e:ad9d:1151 with SMTP id
 98e67ed59e1d1-3966d18ec9dmr24486491a91.4.1787799376080; Wed, 26 Aug 2026
 19:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824134016.2006188-1-chenyuan_fl@163.com> <20260824134016.2006188-3-chenyuan_fl@163.com>
In-Reply-To: <20260824134016.2006188-3-chenyuan_fl@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Aug 2026 19:56:04 -0700
X-Gm-Features: AcwNN1Xf4GjnowAicFWJ8kHVsUKvNkOD5IQBzS8D5CTI9OTkylntSJQVxRx7ZVA
Message-ID: <CAADnVQKPSWBzaEc7QBT39C_N_32Gu5_P5Cob9G0rxcDgiSQg6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf, arena: fix range_tree_set
 inconsistency on kmalloc_nolock failure
To: Yuan Chen <chenyuan_fl@163.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Yuan Chen <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:40=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> range_tree_set() pre-allocates the node needed for a brand-new range
> before calling range_tree_clear(), so an allocation failure returns
> -ENOMEM without having modified the tree (previously the overlapping
> nodes were already removed by range_tree_clear() before the allocation
> was attempted, permanently losing the cleared sub-ranges).
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  kernel/bpf/range_tree.c | 45 +++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 15b588377a76..54055b1fe541 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -199,6 +199,7 @@ int is_range_tree_set(struct range_tree *rt, u32 star=
t, u32 len)
>  int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  {
>         u32 last =3D start + len - 1;
> +       struct range_node *new_rn =3D NULL;
>         struct range_node *right;
>         struct range_node *left;
>         int err;
> @@ -208,20 +209,40 @@ int range_tree_set(struct range_tree *rt, u32 start=
, u32 len)
>         if (left && left->rn_start <=3D start && left->rn_last >=3D last)
>                 return 0;
>
> +       /*
> +        * A new node is needed only when the range has no adjacent free
> +        * range on either side.  This is known before clearing: any rang=
e
> +        * covering start - 1 or last + 1 survives the clear as an adjace=
nt
> +        * piece.

If this is true, why do a 2nd call to left =3D range_it_iter_first() ?


>  Allocate only in that case, before modifying the tree, so
> +        * a failure leaves the range tree unmodified
> +        */
> +       left =3D range_it_iter_first(rt, start - 1, start - 1);
> +       right =3D range_it_iter_first(rt, last + 1, last + 1);
> +       if (!left && !right) {
> +               new_rn =3D kmalloc_nolock(sizeof(struct range_node),
> +                                       __GFP_ACCOUNT, NUMA_NO_NODE);
> +               if (!new_rn)
> +                       return -ENOMEM;
> +       }
> +
>         /* Clear out everything in the range we want to set. */
>         err =3D range_tree_clear(rt, start, len);
>         if (err)
> -               return err;
> +               goto out_free_new;
>
>         /* Do we have a left-adjacent range ? */
>         left =3D range_it_iter_first(rt, start - 1, start - 1);

pw-bot: cr
