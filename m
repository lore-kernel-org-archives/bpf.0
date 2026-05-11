Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3923F40D
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535922; cv=pass; b=CixmJpKNHh6CDikg6FqJZufbvFzQ2p4OxUV3eBNMfV9sxNHjHpRNK3hPDTh5WbnJeeQLHsj8ESWzQuDCqy+L8rkcyj04uSMBPYtCRjwWLJbqooFO6KjjeDnVrpXAKsfFt0dTTR07I5ZEM9sIiR7vQAwSxYhAQ669/CqHU7Tj2lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535922; c=relaxed/simple;
	bh=1jxVlMTuyh+V6ULjH/E1BVkWLBDoxONf7vVMF3j55cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfHtLnljMmGtWIakWoFHuwSX1EqBMMboPH2J8RCiATn+5QmBswHNgHwM0viVQlQAjb7SIcOD8HsIgGAGbCbIvd4aT9/Wp+Xb9KewH/TNNyHEL9hAghBVDmkQ3TnqpIlEASRPNZ6IQcegbfdXKOKNORxImG/+uWESufRx2xp/bgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5NWgCDW; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5NWgCDW"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d75312379so3696112f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778535919; cv=none;
        d=google.com; s=arc-20240605;
        b=TZU7Mm1HhqQRfFTWOBz+35vrr7JFEqyjX/1P9vMoO2yuWpeh5jXhTjTsud+LKT1THo
         S3vohOOABvLjfARaygv9MOe6a7zILIYEMJbZG9z2gu2kmOJ7h8uSzFTpgVgmKfaXFwWi
         bLXw+VeLXf81dp3pqlgaN3lOhx8ZoV7TMVMRYnkN2eAp1XnfbKBT9tT4KMuADig23stj
         7olzSptd9oo/A5UNN/M13/7MojjBZcYiuKJVoJpXg+IcsTq9+G23SFfUbuIb1tW34RTO
         sdTJwpOhsQPUeN8NRZeVjnrN5yLr6CWIhkFXfoFOon3dhTuY90Qnmis0i5kQxCPqLGEn
         aM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DCb8mLBaUUyi/AdLKnWPEWx/s5sJ5fwujB6Wz/0osO8=;
        fh=HdXO09gQO1OWXU1ZlS1aiQuPQahYB8lTYXm9RHFaI9A=;
        b=OoJ1PO610N/rihyMZ6Oe3XBUAAF3CZzxE/EJLRJyMrzbLYaHZpfLYwCqBB1RDngQue
         uL8m1rB9GfwByo0B27QTranB9ij3xJNFgtTbE14Iuoq0tCPFBrc+cABG5ObM6DF28ish
         5Zry3hyktG4jO59yc4qwd/58+lRyGrIxMHth3f0vqDa0Bm/DEP8jnzLvAS2FXoDCtwya
         TdxubWyiq0f/tH1rLF4avFMw14gXXj4NjuTA3AGW3OFgkG1yDRt9EoDlnA8/JaScf6OS
         n53O5BzdugOKoh9Ql+p78kXQbyQPyuuhi8+TO09gMQz7YPFoFbzUVQXwlE5K76KVTNJR
         Y02w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778535919; x=1779140719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCb8mLBaUUyi/AdLKnWPEWx/s5sJ5fwujB6Wz/0osO8=;
        b=o5NWgCDWutnJJKXTjUgw+4b9ni0HmZ7FNeKnm8uex8qRCqgVMqBznga4AojmXvzvCL
         lVPzHyIp0YHT+9DZn4QdIxdosenDnJCAqvqsaWWnADA+dVaGehET0fBc6kLelDADohUy
         k/O6itEJH4Fvmmed8m6Mr9KgOwZJFIiZRpwc1JUlGGP6HxMZi6psipAvdnizKW2Cdl4N
         H91eRFRd1yiMMyarhi89q5lxJMvt6UQMX6njQ1hEBnkfNuxjiWYOoiFOFKxsCIoZJYUo
         /pMxOvbU6P5NgHYx4JDnSapkf/NaJV/px1pVudxRhEaF9DUkhNhWxEm5s1QYAlAUdXUQ
         lYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535919; x=1779140719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCb8mLBaUUyi/AdLKnWPEWx/s5sJ5fwujB6Wz/0osO8=;
        b=BxGSee3rwxyAOZeJE+JliI17+ZMLavo96i6kW3vilnpb429kXlRUggdYF1ICNZtw6n
         qCzgahidte5ODiB6dv/IWL+Zp/9AJsEh2FSb1Zf17HVllLiKD1mu0KBcOSee5enppoWV
         s5BWxoHFLR9TOhyeyhiadunjb1xt2Mnqzg8FkfaGgEGKo6/wDfTiWVXIa31Xo8AZ6zAl
         1rJWAMdQtowO5ynOoa8W7W4LKh9lf3/hxcUJTN3ld5SX0PNjRrCMe4PK48PzIv+Bai/T
         wC+egVmKFsVjWEn1xNujdkdgNOxdmDMcTBI/epMKajwo5p0Q/jNBS2LzX6zj4BGZGOKU
         ry4A==
X-Forwarded-Encrypted: i=1; AFNElJ/nBKzMXLXOmxctK+1V1dR/s/LCtWOnAiuKrx7g48CPCtQPsy0xL6pH57POAWK+H33ZMQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJmA/z15ggXnoAzqOsc9fldfm3QHjOXI47a3d3tUMR0clfzV7
	/p7VR7Kx8JgYX5rIT21UeC+UdYSffLA4XTvea/DlWMLiOddeFdKyFuT08RdI3nFbGJgSUgpPr/I
	nInFlEhl5svb3FOTtnJ6jX8ej+OK/CSU=
X-Gm-Gg: Acq92OFOYjtxNwd5ulkK1ljz+Mov8aM/5QLlUy78kg/vjpuPSGDgiqB+vPrabDDwPdl
	j0znKX5LEnRKBxBw4yetS/kunh6hMV0urefzkvZOggfz3pc4qLA+YTMQ0uvvn8/OxE711MwfFcF
	omTsEytlib0E+hUQ+pQZ7wYJQhWkWnGY4jeecY2FrUuanO6hukR6TTYfwgOpBcAuLxGtIlGSq/G
	IdADjfjs9IvQ5VPrCazDcnfr9mHdOtYBA2ke/Ye8YSUID9qZnWilC8b+k9kKN2EU9VvHEJgLrad
	SpHpoh1EyUXir/I34DB7zf7GXpAbJ9XjEFwXNXgHl0vmd+mGCIClpz9JkBpaVO8wvcn/q694sh3
	LChPyqNXs9VSjVXdoVjKpc5c6iXq1Ho2trAIZ1XXckLVJignPL/oqT+Wfmw==
X-Received: by 2002:a05:600c:4f53:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48e8e217cf4mr16970785e9.14.1778535919376; Mon, 11 May 2026
 14:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-6-tj@kernel.org>
In-Reply-To: <20260427105109.2554518-6-tj@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 11 May 2026 23:44:43 +0200
X-Gm-Features: AVHnY4JM0cTM4CzCxr9EHkQqFmjxgyQr8U4LgfIjjLOFUJriEF0ECdKTclqEquA
Message-ID: <CAP01T75ATTaXSXcCV396R0YhKN37R7-cjxMtZCdtW038u=agTA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] bpf: Add bpf_prog_for_each_used_map()
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>
> Wrap the prog->aux->used_maps[] walk and its used_maps_mutex behind a
> helper. Existing in-tree callers open-code the same lock + iterate pattern
> (e.g. bpf_check_tail_call in core.c, the verifier and syscall paths); a
> sched_ext follow-up needs the same loop and would otherwise reach into
> bpf_prog_aux directly.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/bpf.h |  3 +++
>  kernel/bpf/core.c   | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f4e4360b81f6..587e5ff387bf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2338,6 +2338,9 @@ static inline bool map_type_contains_progs(struct bpf_map *map)
>
>  bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp);
>  int bpf_prog_calc_tag(struct bpf_prog *fp);
> +int bpf_prog_for_each_used_map(struct bpf_prog *prog,
> +                              int (*cb)(struct bpf_map *map, void *data),
> +                              void *data);
>
>  const struct bpf_func_proto *bpf_get_trace_printk_proto(void);
>  const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 066b86e7233c..aa590a817176 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2510,6 +2510,35 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
>         return ret;
>  }
>
> +/**
> + * bpf_prog_for_each_used_map - Invoke @cb for each map @prog references
> + * @prog: BPF program whose used_maps to walk
> + * @cb: callback invoked once per map; non-zero return stops iteration
> + * @data: opaque argument passed to @cb
> + *
> + * Holds prog->aux->used_maps_mutex across the walk.
> + *
> + * Return 0 if iteration completed, otherwise the first non-zero @cb return.
> + */
> +int bpf_prog_for_each_used_map(struct bpf_prog *prog,
> +                              int (*cb)(struct bpf_map *map, void *data),
> +                              void *data)
> +{
> +       struct bpf_prog_aux *aux = prog->aux;
> +       int ret = 0;
> +       u32 i;
> +
> +       mutex_lock(&aux->used_maps_mutex);
> +       for (i = 0; i < aux->used_map_cnt; i++) {
> +               ret = cb(aux->used_maps[i], data);
> +               if (ret)
> +                       break;
> +       }
> +       mutex_unlock(&aux->used_maps_mutex);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(bpf_prog_for_each_used_map);
> +

Since each program only has one arena, and you use this to determine
whether the program's arena has a flag, why not just add a
bpf_prog_arena() accessor and check the result's flag directly? You
can do prog->aux->arena inside it to return the bpf_map pointer.

>  static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
>  {
>         bool select_interpreter = false;
> --
> 2.53.0
>
