Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961673C4B89
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160605; cv=none; b=RMp9Q11bwbf+7VYaBU8wCx16aw7LyUAwm5OJhjzgHFtQWEGL/gfgsxbQAp6zyBAAL53D8P5KR4p3nw/wae54SxO8pOMcYIptHwo5b7PsETlnfKLkWP17XpB9XmiswkpAQ8u0KhwtfgKTzGlMEdBBgKX5dNle9+n6oK6bYZFG63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160605; c=relaxed/simple;
	bh=cdQv+fMfJ3iDt7AJoNvehg4/fOXMVvnhYq/SUXtsdYM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZXEX5cFzvUl1Y+UHyCnysobnpCDiOrVCrwkjnuTeKMgdy4yIoJUYt7CVVgFStCCsFG1O67mYARHXuuE3vLaE3SLWoB1KmVFDRlJnMqrw3D1pc/mqG7DSsfNwtCQziSTQIaOGyKxkuYa4mFkWv4SDKsqDh/mv9UGiN8krRn5+ieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=DIzovmB3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="DIzovmB3"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso861107a12.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787160603; x=1787765403; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=msqDnawpFarSgDa4emNb/wmup3kT5sdWHmWWYNSinBY=;
        b=DIzovmB3PoF+3IZQ6gmVh5R+lIu2DSiXQJwLh62/ToxP1Onclrt30axrlfL/oM9Ljn
         phV0Ae4HqnRyooga3wThHiVsd711BDeJNmq3WRvODPiDB9lotlOs3505Yi4VgOsC+f3S
         OYZvG9m8NkF2blxjGXKszXF7tC7dIS7naYjDPNd2TEtIijOXlOYb3JPceWegCou74nVD
         DpUjpC2U8gFZREm+PbjbVdumL/IzuP4ueh5QpTwZ/5fjK5k2iq/jEkxpD2OoCLfTEvnB
         x7tj7aIObvbtyi+0g4fQOT2pSLKW5+kRMrj2NdCVw9021wtNKoYt36JIhibIL057+st/
         dFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160603; x=1787765403;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msqDnawpFarSgDa4emNb/wmup3kT5sdWHmWWYNSinBY=;
        b=BEYjmHKRhh/GbSD+Rc2+93W2rF8UI6z98vEPrikeRIQwPpGRCFyXZLY5otsMIdz0lg
         GeJAH48Y/Ut9zzTSyFl4JRPFlh0M09F5drCdEx+97lfDrKRbFCMKRkjuqA0sOK5wyLKj
         dG9/RN7RlKm2OhYViXvl1LNpNXjriUZcNbg08UR646PPuWdxlegOLFd1a6r+PTJwQGSy
         3vLep+wIPuUOAlx/n5eKhgrq8mSREiVOCDK23OfwTYPnBR8QHtpcz/H2mxMNiObswVAc
         ZXFIaUZ55Y3YxW7K8dikfS4WuP9sq4cnRjtPyCMyEYYzUCMF6BJ0WgNF0qPAPGqjx64x
         5xiA==
X-Forwarded-Encrypted: i=1; AHgh+RrJbzk0N2OUx93X2X8RfprfYFqPyxD2q9FoV6gUo5g0H9Y5glAB4US7Ma7CMg7J8QoB+mU=@vger.kernel.org
X-Gm-Message-State: AFuF++mCSPjnofUaRvuyoO+b7qFqnZQKSD7xyUVnAHdc8DsmChuJELS6
	W9wWyVZQsWBKXaYmSVjPjjbEpiKrueUg8CgRJLoQye5yUsPIRUlIOgx0v/KeuqWudS4=
X-Gm-Gg: AR+sD10Y0VUolo/o7GOv4qAaE25OO7PAduSTF5qXsUHhMJGKL7CW5jSrKojF2IJ60Yz
	fmDxJVrwaa10gbmEdSzYxifk21x7fgNBmSERVHlp0GBaQK2GmN0l4D8Gcd5zNuaxE7kFR4pT7LN
	NtKUY1SOM8Y/g1E2sQi0HgIqi/43wfrJWn6vazhut6MBiY7hZBffbCYGsh7+MqOYAj/eSVeDr9q
	yPgwpVJUu4w9wVUS2sXGYUt73nqDjBNISA6YRr1ynMhz9lLp5XLPeE+nddwpL5IqAQ9q/Bk2Zxg
	GlKzsNagvyIiuK+/MQxa4vJ3zySgH+GL7CvX4Zz7JqypzfhYS+6iRdsW73681MLi/wzVjysMF95
	u13V+Wu/14o8jFB816K3WZsazx5Qk60z08zLk8jkQjOHkj5edMtdyzJD/ia3crgfP1ys1jb6ZY6
	NQOO3XP2PO/l00JTogXhPViTNmkwuhpwzOAjwgWifykNNlxCx1GKHP2akXz5BipmxeA4DeqAJNw
	Or8yTrMfMFheUsuVS4reb+EZaTa
X-Received: by 2002:a17:902:ef01:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2d5fd6fe255mr131620185ad.11.1787160602789;
        Wed, 19 Aug 2026 10:30:02 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb4dfe6dsm30017965ad.18.2026.08.19.10.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:30:00 -0400
Message-Id: <DKT3K5ONBQO6.16J47HLN6HS6@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
 <20260810134800.2875487-4-chenyuan_fl@163.com>
In-Reply-To: <20260810134800.2875487-4-chenyuan_fl@163.com>

On Mon Aug 10, 2026 at 9:48 AM EDT, chenyuan_fl wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> arena_free_pages() and arena_free_worker() now handle range_tree_set()
> errors. arena_free_pages() aborts the free on error, and
> arena_free_worker() moves range_tree_set() before PTE clearing so that a
> failed tree update leaves the PTEs intact instead of freeing pages that
> the arena free tree does not track.
>
> Also check the range_tree_set() return value in arena_alloc_pages()'s
> error path, which restores the unpopulated tail of a partially allocated
> range; log a warning instead of silently leaking the virtual range when
> the tree update fails.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The fact we can fail to free a page because of an allocation failure is
...not great. Especially considering the failure is silent (we can't
turn this into a warning ofc bc it would be triggerable by user error).
Imo this is very close to a silent memory leak, but the only mitigation
I can think of is some kind of retry, and going down that route would get
really messy really fast.

> ---
>  kernel/bpf/arena.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 555ee2531ef9..d57a0b617525 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -766,7 +766,9 @@ static long arena_alloc_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;
>  out:
> -	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
> +	if (range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped))
> +		pr_warn_ratelimited("bpf_arena: failed to restore free range %ld+%ld a=
fter partial alloc\n",
> +				    pgoff + mapped, page_cnt - mapped);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	if (mapped) {
>  		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
> @@ -881,7 +883,12 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
>  	if (ret)
>  		goto defer;
> =20
> -	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	ret =3D range_tree_set(&arena->rt, pgoff, page_cnt);
> +	if (ret) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		return;
> +	}
> =20
>  	init_llist_head(&free_pages);
>  	cdata.arena =3D arena;
> @@ -1004,11 +1011,18 @@ static void arena_free_worker(struct work_struct =
*work)
>  		kaddr =3D arena_vm_start + s->uaddr;
>  		pgoff =3D compute_pgoff(arena, s->uaddr);
> =20
> +		/*
> +		 * Mark the range as free before clearing PTEs so that
> +		 * if the range tree update fails we leave the PTEs
> +		 * intact, avoiding an unrecoverable state where pages
> +		 * are freed but the arena free tree does not track them.
> +		 */
> +		if (range_tree_set(&arena->rt, pgoff, page_cnt))
> +			continue;
> +
>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>  					     apply_range_clear_cb, &cdata);
> -
> -		range_tree_set(&arena->rt, pgoff, page_cnt);
>  	}
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> =20

