Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE78125A9
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757414; cv=pass; b=jY3hWA/HXSdO1jJcEBMDRKynpApz+euZoKPdSC+ZGEx109JsioVLhvNM7MPQbfTGcOXR3NKmdu43VlG7iZjHYfJvTFhulaubOPLO7rHStdEtkF+utlCMD/ghabP8ihD9jtrXMwjINdqK1u+L3VpW6bYqZA1klKCzKH2yHVUCD+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757414; c=relaxed/simple;
	bh=RbZw6MhqPnT2RbFj1WddPQWGkVpMd4AG3XDQjFCI2NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoODoiP0adwjdbhXl0dxgJPDJipyMO3uYarQHmlole8bCFU7D80EW7kaOcl2FZaw/3AO0QEcM1uwr10gKatCwpJp45HWnepkPwgcJjFLHWSTTjkl75eGuuhXl6R+qpWMfq7v2f6dfu9Yu8QLHDTWtScPtWEjMEwW4v6HA9pSfwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/4U/fY+; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/4U/fY+"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so179874f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:36:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772757411; cv=none;
        d=google.com; s=arc-20240605;
        b=ItE4LvkqGT0mYVnLiHdY6391+TmW5JL4pDHwLuuBxDNpnwGzWFxBoNOzKvWXDyXgc0
         fko9ukchc4K9T8c5/6KTPK/cWMRg+u/P0bmVoObw1JSFhRh8/i56OcM0vxDAy4jtBqn6
         3sL/c02w1wcSa8WJx+Ho+VDlbJZlP2ya9j8CjnRRKynAnETAAgFS51bhzU8Mg2NMr48m
         oXl7xoX3pKVpQ+R2swYzUaG90aEsTlygxXlOjDlV7kk4vRMRJVEYzMlFLRMUwOXUOkio
         zKeNQfnC+h6CaGHz1lutUYtXyX1uRGgmtLOxWqrVzkn5dec4596kK7GvrQBHlRoT4xkF
         fkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RTSe32IZkDPz+w+ci/R6QctvR4dtcR+PwGTbrsp0C94=;
        fh=f3zwoe1BfAjkcJkB2257xjPBIuy6z38ThQmAcDVSi+M=;
        b=UJ8bMTE7dbLfeSPqgIGqkOzE2k5Zc1KFuy0Bm/PGQ4C25H2+WS3Ovh5pxcfD6i/J/k
         kxDRMjWLI8GQ7vy3zq+AKNlwIPNOyDpP0SucHvM3GbmvbETtl++fKJ3bSCGIYexSJJKw
         YTloWh5YssVIc6SsT9rzuzrJc37/GKEdTtQ8P3Zus1/HEstLItfCBaTK6bNy5ajhR8po
         d9bAU0LybbIEgN76/IoJnX8ln9thYjL3DMWQFdTUAwWu9oCyMbf9I0jLgIODf5wS5VRN
         9184MYKzb8DhJtOOAVmxsIGKdRJn64C4tYPntPDYuPfB5wrI/YHp8ntJHLwFiIYxzlnK
         RHzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757411; x=1773362211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTSe32IZkDPz+w+ci/R6QctvR4dtcR+PwGTbrsp0C94=;
        b=e/4U/fY+lF8eLRxeo0PojkQhhM2rExLvHAN2Swhrxbewxcs+KqBVpwe5hg3MFoNc89
         K9RywTaRHIshAnyVnm3kkXNgTnDuPjJl7VfjTLAY+/ZJs1jPifkSuvuLMRTWJrn9dhyM
         pVE88qy0BnWWUZYbi2/NGmORDrLGoFbh29CTVyMUVx72IKJrhz+T2FXJYC4qPx+R6TL0
         p+poNTVztvzvCk1Unf4yMkGc5wuw7rcxX8LN9kh+8I0F7ejnJZj4ZwPDCvnNQprDgMK9
         L1psfINkSY4gYkvLP8i5kKyMB7Mpyx1AJRSBli2aPjk1+3GaNxsF2i0qWbOgGhnv9fmY
         iuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757411; x=1773362211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTSe32IZkDPz+w+ci/R6QctvR4dtcR+PwGTbrsp0C94=;
        b=jBg3TjEi2UVeaXhNaSpHELIHpGwojD0nFeLMzOrEK9kZvhEfHgClRBhnMVRo7R6UYR
         0d2kRnlu+cu5E7itixbZeDOpgijsx7fUBRP2xOwixjj0E8+L9wcRsNN9endSTiQ406EY
         5uYkKeeizsyNPeMCv22L7eJTdUpqzHJKDTDXYvyPS1n8p+pszxCiY5eiwvy1tRLGvMws
         1OGOH4INpk8erBLuhmi1eDfQvVaoRHVfgm1VET6tqb8EVh5BS7tJDRgwUJQGEaKkPfnn
         RGFsJPMK1wiZhd8D57U9BYjnUw1FeWRunDNufd03U4Taj3tl8/S5c+s1Qb849CSVgrvy
         gnIw==
X-Forwarded-Encrypted: i=1; AJvYcCWnvfLDEqqb91frWxKfg/DrxUxByoVYj0fz4DMxD1POniqxZS8D0mVpLLiyL74dNGIDcx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYh5+1iB4+u/mV7JdBkr/n+PUBx4y/Fb2DBeO4fZjRxLarpWq
	VQt+IYAsEP7B7x+7cWiDxrFl40Q2reHgz3PD62AnOaaTBre6a3D+w6RfUvHihS+x6Z9/SG1OAfo
	AOt3cKte4zFS/a2SSg2wf1kZ9cC2phZg=
X-Gm-Gg: ATEYQzxr8i1E9W8/dzAkf5psxlt1qkT4+Wl8ydoG1c+1nuQZWydBXkQsfEJrgBVZxGD
	6+116D6PVhWVB+0ZEzzrab+7OG/QKAvwEgBaaFs6uYvfh8zWeAmcsZpXP+XKfrZhgWGXQbphPZG
	53jcx/bAK1RwUnHIGUp0oORdzr5FyD7ne54kcsx6vxkBpVXwhQ1hJTtMAAAfh70GYhn4Hzpr0ML
	VVN4gZ7BTmyPcSLgDGJCM3qbcOAy+ClSmj6Fa+OB/kWTDsHdaHzbLUIrfq1qWZSW/P/5Sy9FLtZ
	sRw5beh9t5iiGOoo2eMh/HtR+KZtntxdlqSCIe7CoNlz17qmb3vgIJnAbyeuVyhsxyAXCg==
X-Received: by 2002:a05:6000:4310:b0:439:cd26:ce0c with SMTP id
 ffacd0b85a97d-439da35fa66mr428103f8f.17.1772757410967; Thu, 05 Mar 2026
 16:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304143459.78059-1-pilgrimtao@gmail.com> <20260304143459.78059-3-pilgrimtao@gmail.com>
In-Reply-To: <20260304143459.78059-3-pilgrimtao@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 01:36:14 +0100
X-Gm-Features: AaiRm50wuqcWBX3i79eyR-zjLLwAkDsOm5FDWp7tn3eAvbjTDBPzPOp4oStvcGA
Message-ID: <CAP01T75A31a6w_j6kT-Sui9Rq1MT0kMo2zt4bYpV9HJyQ8JmMQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] bpf: Add bpf_list_add_impl to insert node after a
 given list node
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 15:55, Chengkaitao <pilgrimtao@gmail.com> wrote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Add a new kfunc bpf_list_add_impl(head, new, prev, meta, off) that
> inserts 'new' after 'prev' in the BPF linked list. Both must be in
> the same list; 'prev' must already be in the list. The new node must
> be an owning reference (e.g. from bpf_obj_new); the kfunc consumes
> that reference and the node becomes non-owning once inserted.
>
> We have added an additional parameter bpf_list_head *head to
> bpf_list_add_impl, as the verifier requires the head parameter to
> check whether the lock is being held.
>
> Returns 0 on success, -EINVAL if 'prev' is not in a list or 'new'
> is already in a list (or duplicate insertion). On failure, the
> kernel drops the passed-in node.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 34 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 17 +++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cc1a096a1f64..740b53024283 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2505,6 +2505,39 @@ __bpf_kfunc struct bpf_list_node *bpf_list_back(struct bpf_list_head *head)
>         return (struct bpf_list_node *)h->prev;
>  }
>
> +__bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
> +                                 struct bpf_list_node *new,
> +                                 struct bpf_list_node *prev,
> +                                 void *meta__ign, u64 off)

I have pretty much the same comment here, there is a lot of
duplication between this and __bpf_list_add.
We can write list_add_tail in terms of __list_add, and then unify all of this.

> +{
> +       struct bpf_list_node_kern *kn = (void *)new, *kp = (void *)prev;
> +       struct btf_struct_meta *meta = meta__ign;
> +       struct list_head *n = &kn->list_head, *p = &kp->list_head;
> +       struct list_head *h = (void *)head;
> +
> +       /* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> +        * called on its fields, so init here
> +        */
> +       if (unlikely(!h->next)) {
> +               INIT_LIST_HEAD(h);
> +               goto fail;

Not clear to me why we should fail here; why can't we continue adding
after initializing the list head?
E.g. __bpf_list_add isn't doing it.

> +       }
> +
> +       if (WARN_ON_ONCE(READ_ONCE(kp->owner) != head))
> +               goto fail;
> +
> +       if (cmpxchg(&kn->owner, NULL, BPF_PTR_POISON))
> +               goto fail;
> +
> +       list_add(n, p);
> +       WRITE_ONCE(kn->owner, head);
> +       return 0;
> +
> +fail:
> +       __bpf_obj_drop_impl((void *)n - off, meta ? meta->record : NULL, false);
> +       return -EINVAL;
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>                                                   struct bpf_rb_node *node)
>  {
> @@ -4574,6 +4607,7 @@ BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_list_add_impl)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c9557d3fb8dd..e458cf3b1dd1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12464,6 +12464,7 @@ enum special_kfunc_type {
>         KF_bpf_list_del,
>         KF_bpf_list_front,
>         KF_bpf_list_back,
> +       KF_bpf_list_add_impl,
>         KF_bpf_cast_to_kern_ctx,
>         KF_bpf_rdonly_cast,
>         KF_bpf_rcu_read_lock,
> @@ -12525,6 +12526,7 @@ BTF_ID(func, bpf_list_pop_back)
>  BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
> +BTF_ID(func, bpf_list_add_impl)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rcu_read_lock)
> @@ -13000,7 +13002,8 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>                btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
>                btf_id == special_kfunc_list[KF_bpf_list_del] ||
>                btf_id == special_kfunc_list[KF_bpf_list_front] ||
> -              btf_id == special_kfunc_list[KF_bpf_list_back];
> +              btf_id == special_kfunc_list[KF_bpf_list_back] ||
> +              btf_id == special_kfunc_list[KF_bpf_list_add_impl];
>  }
>
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
> @@ -13122,7 +13125,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>         case BPF_LIST_NODE:
>                 ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>                        kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> -                      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
> +                      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> +                      kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
>                 break;
>         case BPF_RB_NODE:
>                 ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> @@ -14264,6 +14268,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>
>         if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>             meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> +           meta.func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>             meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>                 release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
>                 insn_aux->insert_off = regs[BPF_REG_2].off;
> @@ -23230,13 +23235,17 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                 *cnt = 3;
>         } else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>                    desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> +                  desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
>                    desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>                 struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
>                 int struct_meta_reg = BPF_REG_3;
>                 int node_offset_reg = BPF_REG_4;
>
> -               /* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
> -               if (desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
> +               /* list/rbtree_add_impl have an extra arg (prev/less),
> +                * so args-to-fixup are in different regs.
> +                */
> +               if (desc->func_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +                   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>                         struct_meta_reg = BPF_REG_4;
>                         node_offset_reg = BPF_REG_5;
>                 }
> --
> 2.50.1 (Apple Git-155)
>
>
