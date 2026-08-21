Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1393F3264
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339592; cv=pass; b=hKfxre7XseVPo4lZ1lCYuP6v4N0+fbof0ibC7waFoAPGZOpJsoUhqO7Y1JKl7Ykrr8QlDnD42KHkca24hVhMA5kNj49RkMx8JFSPPa1CPOUzhpwZ3JnfnPqW1w6jWkzkgMhQLhNL/JXQfQJ8IzLZMz9y4n6LB+F4WW0gNJeMHGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339592; c=relaxed/simple;
	bh=CzeOt7+qb+DQwm8p/5NanUh9uiyWUQcNlya9kjf4w3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz9Iodz3Lajaq1FxK/VsqpaNrCdX24/pxzDoZ/h1YIE0DNr2NDPHf1alqEyUwuFMrqWm5eEits+eUwYcGmiWCUQvGHYytmsj1nwke3xOwICAY497P1R838gJXPXJAeOnAeS8fa9Ki+bPp4Lw9sL6vdU9vpvvk76hW0b41W3iJ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxDMiShr; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxDMiShr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1410779a12.3
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787339581; cv=none;
        d=google.com; s=arc-20260327;
        b=rkxptupSpenJPGyni9sDH5jM3M7TQikj6vU9xCKCpJlcjFSn6TvhTwk1zkX+xAWWJ3
         jWo7zvcpdB+O9fAzeYCbbSD6f3JkWnTArsBgGRYnrYgmDyS9VDCeMTeWte7ap/TPkpIG
         NlzCuUe/NmbIfl21giN1ZeS04ijXQ9XmhHTTsli0UXDRcKzbPVUEApAnN8onEKxrcXHl
         z3vtT7RraReALOav/QfVG6EEzo+EiwyTsQHx3hVmPtacyKGFZYX/nzGYUVHq11d94iAI
         3bh+t+sSz2mAcu1cpKHeGLtaBtPjRFk4aGr4cXdElTbjM3za1RFqAsE/mhXb6lgPT4qx
         +cDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4EP9kNnTd5rrVNF1QxPdX72MOJnRRML3UJBMc9GYEgA=;
        fh=I1j6DrdWD/Nx0AjI+hEI67DXmXdMWIZBKtkP0LDbBT4=;
        b=pPjfAmILwhJObuIZnD3X1KnW81/0APhy4GMHsW7QF3jScj7AzTiiIXBh0Pcintwj9u
         qsp+UrjXW01seXVRKoZGHGxw45hNlJxVuoLyD23dN5sdOCQxsHYlwhUg2tFayvKzm2IX
         cByfJkqzCHN5AILtBCY5dus7LxAH6vuygXThlfqkFUcGDEWsyLa2neOF7rc+YTF7GUQk
         cgz2+QakWJxH4addrBgBVIoBqcMps71e1xavj+y8v8DCeHAuXg9/NQBEDL/iE8BZLTE2
         SnQ6Mql1CQ7vwLtrQEJEz9F+jcIORNi57nrvnnOOKnT/CJpbQ9SJGpQltbP/xKiyd89N
         X28g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787339581; x=1787944381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4EP9kNnTd5rrVNF1QxPdX72MOJnRRML3UJBMc9GYEgA=;
        b=nxDMiShrfJ+XiDaRc41ckUc3kAWLDB3yfYPSwLlb/4eSZYqyKWclUB/faGoXIDE89c
         UGblaNmVSWgpZAgTQ7zNiQyIMCH5GYHkLz2zowYfih/89jPdUoOUX+Qf5NWhAI5vyDXk
         qbb/NLbbigmCoKifiWUWyP+PROFQEl64LQ1tUlY6l17sDcL/Kph0uqnV88++ZflMn3WZ
         43Ie54DBKy2qqbfwrdjaTaZXfBz6+zEPPnY2eVgPcnt33QTsS9MuAjOyvh+3eqKibopT
         dzS7cCo0+J7WH3NOuYfwfK7r/dcznsXutVdBdSsW+kJIwdbhvb02NnzBKLPT0kGerKoe
         O0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787339581; x=1787944381;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4EP9kNnTd5rrVNF1QxPdX72MOJnRRML3UJBMc9GYEgA=;
        b=EYkUxHEESBf5bw663XSkcTb2AHhDig/0PBlgFBfT0kj5DprbQ2f+baP8w9iObrdl+/
         0tjYnjT9Oq5Q3DGPXwspyQKDaCYqOtfk1WNz1O7tjE1horKmUU694UqBKvPuGa8GEoeS
         /PwEptre5nBzkajUybPX5x/M3+4WMbV44S/z5I1siSH1L9ut6fVe74zwgg6aoZ5/ikM3
         3XyfimIMHd8Cm0Kk3tHPen887vFFMCC+zeCLVa4/78dHhQcgtMhCm54aevJM1Rh3x5uU
         Djbqp7xZHarN3Jw7jh03/zA2ZVz32/LkZaWqvehT3F+sV3DzH6RA7AsI9ruw0/zX0VFA
         5EYw==
X-Forwarded-Encrypted: i=1; AHgh+RqG4yqBoFgFzm8d0cuEfDOXNNWHfFE2AM3TkvnZCcvBpH7dI0P2l7OX1ZXZTL9j6Dd+QvA=@vger.kernel.org
X-Gm-Message-State: AFuF++lBa5mpwjRYczRaMx/kraOgVpyw+0HeIm/dIaV+6VAezmwbp33K
	Ec+OKgFiEW2zUp/FA1U/vDpR/QimrDKajKPHyD8UYDO+RQqxQ+Am125eQByqbbX34u4J7lFdicX
	tSvhTOt6b4nT2vQt75/kJs1y8qzTl9ys=
X-Gm-Gg: AR+sD13Cog7PMjHlfB/km6VkHg0hYxw4/xRzIt8dNqVjoUYhgNCmz22zqOUWWY/2SMp
	Qft9X1AV7uEeLmFuAzNtxFA34ZTVKnQz+LP3hS22xWKdKdkH1kNrJiSfPzWki56cbfmgdqbfdFI
	okQ3w0rqPXSiV8m/nvCUoD2PpumU21qxzAOn7egS8v+BnLjjWHeb36joZzs/UVOwpTsJxBv0b+R
	GOSKbxQddNU66K6aNvZdIL7IilVphvliVhh/TnOcBupGVQzT9et4yj1dJuBZFgvSES9LJ2BStQp
	Dm8tzMAVDh0H64QgKsBopcUjKR5azn6Q7DxS7HfTgXRSp/pscGzPMU+tPj7Url8aBNly6Wov1qv
	hF39IpZJoPrrlAuUB3ktIp7uEPg==
X-Received: by 2002:a05:6a20:1605:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3cd3003dc4fmr18286503637.13.1787339581363; Fri, 21 Aug 2026
 12:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787205002.git.zhuhui@kylinos.cn> <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
In-Reply-To: <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 12:12:47 -0700
X-Gm-Features: AcwNN1VFlvzW-iYWjQEbCYx4cIALBao9hdQF0KejKmduy-QOpYTRcp_60ucoZjQ
Message-ID: <CAEf4Bza0KYB+OHpa89K16+ptUQuQDJKyxxNCyDPcgQaO1mtxjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:12=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Expose memcg proactive reclaim to sleepable BPF programs:
> unsigned long bpf_proactive_reclaim(memcg, size);
> unsigned long bpf_proactive_reclaim_swappiness(memcg, size, swappiness);
>
> They perform one reclaim pass on @memcg, like a write to memory.reclaim:
> swap is allowed, and the anon/file balance follows the cgroup's
> swappiness or an explicit override in [MIN_SWAPPINESS, MAX_SWAPPINESS]
> plus SWAPPINESS_ANON_ONLY. Both go through a shared helper,
> bpf_proactive_reclaim_pages(), which guards against reclaim recursion
> and calls try_to_free_mem_cgroup_pages() with GFP_KERNEL and
> MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE, the same parameters
> user_proactive_reclaim() uses, and unlike memory.reclaim they do not
> retry until @size is reached.
>
> Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
> current->reclaim_state on entry and NULLs it on exit, so a nested call
> from an in-flight reclaim would corrupt the outer reclaim state (e.g.
> MGLRU dereferences current->reclaim_state->mm_walk). Both kfuncs
> therefore refuse to reclaim when PF_MEMALLOC is set or
> current->reclaim_state is non-NULL. The latter check also closes the
> window in try_to_free_mem_cgroup_pages() where reclaim_state is already
> installed but PF_MEMALLOC is not: only a tracepoint call sits in
> between, and while a sleepable BPF program cannot attach to the
> tracepoint itself, it can attach to the generated trace iterator
> function (__traceiter_mm_vmscan_memcg_reclaim_begin) via fentry.
>
> The kfuncs take @size in bytes; the return value is normalized to bytes
> as well, matching the byte-based unit of bpf_mem_cgroup_usage() and
> bpf_mem_cgroup_page_state(), so callers can mix them without manual
> page/byte conversions.
>
> An out-of-range @swappiness is reported with (unsigned long)-1 instead
> of 0, following the convention of bpf_mem_cgroup_vm_events() and
> bpf_mem_cgroup_page_state(), as 0 cannot be told apart from a
> successful pass that reclaimed nothing.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>  mm/bpf_memcontrol.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..dc51868b3acf 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/memcontrol.h>
> +#include <linux/swap.h>
>  #include <linux/bpf.h>
>
>  __bpf_kfunc_start_defs();
> @@ -159,6 +160,120 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct =
mem_cgroup *memcg)
>         mem_cgroup_flush_stats(memcg);
>  }
>
> +/*
> + * Reclaim must not recurse. try_to_free_mem_cgroup_pages() unconditiona=
lly
> + * overwrites current->reclaim_state on entry and resets it to NULL on e=
xit.
> + * So invoking it from an in-flight reclaim would clobber the outer recl=
aim
> + * state and corrupt its accounting.
> + *
> + * The guards are PF_MEMALLOC and current->reclaim_state. Every reclaim
> + * entry point marks the current task with PF_MEMALLOC for the whole
> + * reclaim window: try_to_free_mem_cgroup_pages() and __perform_reclaim(=
)
> + * do so via memalloc_noreclaim_save(), and kswapd keeps it set for its
> + * entire lifetime. A hook inside the reclaim path (shrink_node,
> + * shrink_slab, ...) executes in the context of the reclaiming task, whe=
re
> + * current->flags already carries the flag. The page allocator, the memc=
g
> + * charging path and node_reclaim() rely on the same flag to avoid recla=
im
> + * recursion.
> + *
> + * reclaim_state is checked in addition because it is set slightly befor=
e
> + * PF_MEMALLOC in try_to_free_mem_cgroup_pages(), with only a tracepoint
> + * call in between. A sleepable BPF program cannot attach to the tracepo=
int
> + * itself, but it can attach to the generated trace iterator function
> + * (__traceiter_mm_vmscan_memcg_reclaim_begin) via fentry, so PF_MEMALLO=
C
> + * alone would leave that window open.
> + *
> + * Also, PF_MEMALLOC is set in some non-reclaim contexts (e.g. direct co=
mpaction
> + * and vmalloc), where the kfunc conservatively refuses to reclaim as we=
ll.
> + */
> +static bool bpf_in_reclaim_context(void)
> +{
> +       return (current->flags & PF_MEMALLOC) || current->reclaim_state;
> +}
> +
> +/*
> + * Shared implementation of the proactive reclaim kfuncs: performs one
> + * reclaim pass on @memcg with @nr_pages as the goal, allowing swap, and
> + * @swappiness as the anon/file balance override (NULL to follow the
> + * cgroup's own swappiness setting). Returns the reclaimed amount in
> + * bytes, keeping the byte-based unit of the kfuncs' @size argument.
> + */
> +static unsigned long
> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_p=
ages,
> +                           int *swappiness)
> +{
> +       unsigned long nr_reclaimed;
> +
> +       if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> +               return 0;
> +
> +       nr_reclaimed =3D try_to_free_mem_cgroup_pages(memcg, nr_pages, GF=
P_KERNEL,
> +                                                   MEMCG_RECLAIM_MAY_SWA=
P |
> +                                                   MEMCG_RECLAIM_PROACTI=
VE,
> +                                                   swappiness);
> +
> +       return nr_reclaimed * PAGE_SIZE;
> +}
> +
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * the memory.reclaim cgroup file: pages are reclaimed according to the
> + * cgroup's own swappiness setting and swap is allowed. Note that,
> + * unlike memory.reclaim, this does not retry until @size is reached;
> + * callers can invoke it again if needed.
> + *
> + * The reclaim runs with GFP_KERNEL, so this function must not be called
> + * from a context that holds a filesystem lock (e.g. an LSM hook invoked
> + * with inode_lock held): the reclaim path may enter filesystem shrinker=
s
> + * and deadlock trying to reacquire the lock. Contexts that set
> + * PF_MEMALLOC_NOFS/NOIO are handled by the gfp context inheritance.
> + *
> + * Return:
> + *   The amount of memory actually reclaimed, in bytes (rounded to full
> + *   pages), or 0 if @size is smaller than a page or the calling task is
> + *   already in a reclaim/freeing context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg=
,
> +                                               unsigned long size)
> +{
> +       return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE, NULL)=
;
> +}
> +
> +/**
> + * bpf_proactive_reclaim_swappiness - proactively reclaim memory from a
> + *                                    memory cgroup with an explicit
> + *                                    swappiness
> + * @memcg:      the target memory cgroup to reclaim from
> + * @size:       the amount of memory to reclaim, in bytes
> + * @swappiness: swappiness override for this reclaim pass
> + *
> + * Same as bpf_proactive_reclaim(), except that the anon/file reclaim
> + * balance is controlled by @swappiness instead of the cgroup's
> + * swappiness setting. Valid values are [MIN_SWAPPINESS, MAX_SWAPPINESS]
> + * and SWAPPINESS_ANON_ONLY, which restricts reclaim to anon folios.
> + *
> + * Return:
> + *   The amount of memory actually reclaimed, in bytes (rounded to full
> + *   pages), (unsigned long)-1 if @swappiness is out of range, or 0 if
> + *   @size is smaller than a page or the calling task is already in a
> + *   reclaim/freeing context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long
> +bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned long=
 size,
> +                                int swappiness)
> +{
> +       if (swappiness < MIN_SWAPPINESS || swappiness > SWAPPINESS_ANON_O=
NLY)
> +               return (unsigned long)-1;
> +
> +       return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE,
> +                                          &swappiness);
> +}

I haven't followed previous discussion, so I apologize if this was
discussed, but if not, isn't it a bit an overkill to have second
variant just to provide optional swappiness? Valid range of swappinees
seems to be non-negative [0, 200], that special ANON is 201, so why
can't we defined that <0 swappiness just means no swappiness was
provided and get away with just one kfunc?

> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> @@ -172,6 +287,9 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>
> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_proactive_reclaim_swappiness, KF_SLEEPABLE)
> +
>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
>
>  static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set =3D {
> --
> 2.53.0
>
