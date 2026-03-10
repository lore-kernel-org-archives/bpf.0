Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E13E8C7E
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173481; cv=pass; b=J7kZnHg0BU+5+3wihAhLxbHC5asNeiZuQV4hFWBZ+pW4QU61HSFjd5wCwLU4ioBzA3ECWrkRtWjqr87vRyvvOwNpwY68epLK/KqJjZbeQu+/wfsNga8S78JBT5gaBB2hspFNqp5dDh/3GLIfsWdCEx6WzN2veBzlm1tc+UkC5Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173481; c=relaxed/simple;
	bh=VcbIZ/WmA7ETF97AV4CjkC1KQDUJSW8FrZRfP+0Kr5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Foe5MGfi6p00/nqI1Sxcu1BFp0MZX/VyQoIpe2/Giwgu33INu1pQ7Rxqw/hz5wuPc8h+lVmjOMqEzgD9v4rvSKu3zMmMFHrcyF5qHebVjgbRo7JVBHWv7Qc1TgsrqwaZ71W8ihmixvFxIj/Ha3EORJamyl/F7pmUXxWXia3dT/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5jsQ1Zg; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5jsQ1Zg"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b790af67so224295f8f.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773173478; cv=none;
        d=google.com; s=arc-20240605;
        b=AygVC6qrhAdZPy6dlpVDiKJw3kJehtOVz8BiwTLGuoLAD92qNYbdDNG9zqlo1SF8Wv
         rmVevpN/yhqhlgwnZfWHSRLefmoEw9dKU015a+3TM3VVwbEKFvb2JQZnGaJAjbgkD/mr
         /s5bfDNRXUsuF2Fx32NMOYyt1gReZaA4Y2F9LKNi7pYBdl+Jk2fhzoZRGgxLzNCtKLR3
         7FTXqpot1FdOqiM3qZc1pK7pednb+YfilKU1Q55hZjqdgRXBl+AwbpwsIHu43X/D6n6G
         9pbIXvPh8zm/JWOn7R8gyiU/rtwsEFf7MBNck0BUevxNfbZxrUhvEIf3bVHYYYWd1zQC
         31Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T3umR3Cr9WiTS9b+qrsYcPDG6mxvuCgn4bszgUuEQ+E=;
        fh=zZhpvCn4d50wDCGtwbWbknQi5aATDnyl+7r4CHIhjuo=;
        b=C2YkQA/G/4DoW+JfIjRTkqHWhnxBd7W4ry9s7/s45KPArK7EfluE2jmuP4XWD+8CJh
         DnZ5nzFgLxUxeW/sedZGoURo8csc+AWhlPEfe5W3uMTcbopzxuCw/T6Xb1kcBzUUC6mP
         8ICqmIt60AVNBQKh3qkZI4r/Cxyn3EbIzL6+BnT7zpKK1GKxZsIPE6R069NNkNQcbMjl
         O8o5Su+tAQd23n9YR6A4SHJU1AGKI52wZ+fgIH2vdkFC6mpULqdWkUysvz+obXjmcrZ/
         IgfFhiKLE38DeXkGmrcbEa+GzVMXnlj9q+zAtrM8nwRsVAoSVVPluBFRyFIDVVvOSGvd
         ADAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173478; x=1773778278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T3umR3Cr9WiTS9b+qrsYcPDG6mxvuCgn4bszgUuEQ+E=;
        b=i5jsQ1Zg61Tx7lePkczxOQRbEYo7tGlcBq8ut93ipLGKUjdwZv1koSbOe1DGGmTRAp
         o5LanPg+yOaxI+xgLW4b+w39wVo6AyN84GGwsMDdxFk7VFNkGYAUWhsDvsf+YlruGiik
         5icwM1xTIC/svhzRhU8uqaGXIJl0vG5JNwBEKoM+j2MWefRCY/GfI27QIaKkavT4uwH+
         o0tbFA268F8cLdfKpPictpJyRsg9zVgzpe0Sd3p05h5J1o24gTlPtBZLQ75ryf2xMebp
         BiZm5E4PBa1fH172eiU0pNrFyUxuswz3fFsmGN+wHWxySCjUvuJABQgqO4C+YWerhoh9
         d/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173478; x=1773778278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3umR3Cr9WiTS9b+qrsYcPDG6mxvuCgn4bszgUuEQ+E=;
        b=bMFh86kGPeMf81tOEPBUOu/X/kkXL84UlN9oeRrhgGuAunxddN3k6TbBUGFzY/LF5M
         bZaPHwuhfFmKRrZFzgT8uVHoJF3/+b7jCSyqVw3Qnytzj2aa9tpCprw/tuSdOyP56PZQ
         cYqVPTd3ADuFjm0eHuRv4/BOFN2TkXNjE8xNASku33HHTMbEwOiw2gFWsGKPeYpark73
         UoAH7J+yvcHMO4XGcagl6xXHI0+U3rq1d4CQLrT7bzorqLFSW4Tt95MfT/PMpD6uT5OS
         9k6hUKDgaZ785x2+NTwqZmonlJUFlBV0sONYu2T/et6dr7pDiZPn70rxV/hGiksGgIRY
         ZFMg==
X-Forwarded-Encrypted: i=1; AJvYcCUHUVkT78G23y9pu7FE2DbRsOwVqm7cXu5n+uObU03osnfVPfdCrPMShgRnYg/xgLlYmVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgWr4wIPKeqERmLKroh2K0Ax7Bo5Mfbz8nX6iJ/wcieqOCwcRI
	eE4fbqgpL2Q9Qi/Wy0GGKJ7X+9y1Uz1QG8r9t9LhSa0PUM7cydTSKNM4I65DqL0osL8mXlMqH0E
	0pUNRx/ZNd6RLKcCN88JQYNjMQJ9H99M=
X-Gm-Gg: ATEYQzxPSPtUoqMfc5FxTA9FaUdA6qdUZlBlTgllRFXhZI5OsEmQDh504DqdMiTPiTI
	feRLzA2MxfzHPQkuo8DCXKoypBH05RBjqSpvmBWB1RgSl4ILqI6mlprSffKYsVN3P9LrnZ/9Z9k
	KLtGrpN1JrVSpaYt9/D8D+GwwEpPWs4iKuc/coG9um6/JaOjHZxt/OphAd/UW7pIg7ap7b3Tt/K
	2WqzLhMoLY8RxOPlOsGvuee8x93XC+39OzVIi7O42L0/m1tVJ+loLrabTArUozQxqI03VFlFJ7V
	HvtDd6lJDPOhrFq9pq+JgdnOUmovix+ynlvYG71qJoRIFsU1wUqbl5Cs6NFsmv4LjKGTsec=
X-Received: by 2002:a05:6000:2584:b0:439:d084:9e48 with SMTP id
 ffacd0b85a97d-439eff12b5fmr8927182f8f.5.1773173477509; Tue, 10 Mar 2026
 13:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308134614.29711-1-pilgrimtao@gmail.com> <20260308134614.29711-2-pilgrimtao@gmail.com>
 <8f97dbb5-de94-4ac0-8b3c-e0ce890fffc3@linux.dev>
In-Reply-To: <8f97dbb5-de94-4ac0-8b3c-e0ce890fffc3@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 21:10:41 +0100
X-Gm-Features: AaiRm51DzLYNqWfe42hlK1YZj_mIKI1_ZQ9yMcurPyOpM09KQOLqEoROpBYmAQE
Message-ID: <CAP01T76Nxy28ZAMi86Ez-WcCpiHKe2EBz4Y2j1XJjrRs=Qp-CA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/5] bpf: Introduce the bpf_list_del kfunc.
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 07:34, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> On 8/3/26 21:46, Chengkaitao wrote:
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >
> > If a user holds ownership of a node in the middle of a list, they
> > can directly remove it from the list without strictly adhering to
> > deletion rules from the head or tail.
> >
> > We have added an additional parameter bpf_list_head *head to
> > bpf_list_del, as the verifier requires the head parameter to
> > check whether the lock is being held.
> >
> > This is typically paired with bpf_refcount. After calling
> > bpf_list_del, it is generally necessary to drop the reference to
> > the list node twice to prevent reference count leaks.
> >
> > Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> > ---
> >  kernel/bpf/helpers.c  | 30 +++++++++++++++++++++++-------
> >  kernel/bpf/verifier.c |  6 +++++-
> >  2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6eb6c82ed2ee..01b74c4ac00d 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2426,20 +2426,23 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
> >       return __bpf_list_add(n, head, true, meta ? meta->record : NULL, off);
> >  }
> >
> > -static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
> > +static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
> > +                                         struct list_head *n)
> >  {
> > -     struct list_head *n, *h = (void *)head;
> > +     struct list_head *h = (void *)head;
> >       struct bpf_list_node_kern *node;
> >
> >       /* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
> >        * called on its fields, so init here
> >        */
> > -     if (unlikely(!h->next))
> > +     if (unlikely(!h->next)) {
> >               INIT_LIST_HEAD(h);
> > -     if (list_empty(h))
> > +             return NULL;
> > +     }
> > +
> > +     if (n == h)
> >               return NULL;

Couldn't you keep the list_empty(h) check after INIT_LIST_HEAD(h) as before?
And we don't need n == h either. You could add a comment that n will
never match h.
The verifier should ensure it, since it distinguishes the head and node types.

Let's say the head is uninit. Then list_empty(h) will catch that case.
Otherwise n might be NULL.

After list_empty(h) says false, we definitely have non-null n.
We just need to check list membership using the owner check, and then
we're good.
It will be a less noisy diff.

> >
> > -     n = tail ? h->prev : h->next;
> >       node = container_of(n, struct bpf_list_node_kern, list_head);
> >       if (WARN_ON_ONCE(READ_ONCE(node->owner) != head))
> >               return NULL;
>
> This refactoring is worth, because the "struct list_head *n" seems
> better than "bool tail".
>
> But, such refactoring should be a preparatory patch. Importantly,
> refactoring should not introduce functional changes.
>

I think it's fine. Let's address this and avoid too many respins now.
It isn't a lot of code anyway. You could mention in the commit log
that you chose to refactor __bpf_list_del though.



> Thanks,
> Leon
>
> > @@ -2451,12 +2454,24 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
> >
> >  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
> >  {
> > -     return __bpf_list_del(head, false);
> > +     struct list_head *h = (void *)head;
> > +
> > +     return __bpf_list_del(head, h->next);
> >  }
> >
> >  __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
> >  {
> > -     return __bpf_list_del(head, true);
> > +     struct list_head *h = (void *)head;
> > +
> > +     return __bpf_list_del(head, h->prev);
> > +}
> > +
> > +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> > +                                            struct bpf_list_node *node)
> > +{
> > +     struct bpf_list_node_kern *kn = (void *)node;
> > +
> > +     return __bpf_list_del(head, &kn->list_head);
> >  }
> >
> >  __bpf_kfunc struct bpf_list_node *bpf_list_front(struct bpf_list_head *head)
> > @@ -4545,6 +4560,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front_impl)
> >  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
> >  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 67c09b43a497..c9557d3fb8dd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12461,6 +12461,7 @@ enum special_kfunc_type {
> >       KF_bpf_list_push_back_impl,
> >       KF_bpf_list_pop_front,
> >       KF_bpf_list_pop_back,
> > +     KF_bpf_list_del,
> >       KF_bpf_list_front,
> >       KF_bpf_list_back,
> >       KF_bpf_cast_to_kern_ctx,
> > @@ -12521,6 +12522,7 @@ BTF_ID(func, bpf_list_push_front_impl)
> >  BTF_ID(func, bpf_list_push_back_impl)
> >  BTF_ID(func, bpf_list_pop_front)
> >  BTF_ID(func, bpf_list_pop_back)
> > +BTF_ID(func, bpf_list_del)
> >  BTF_ID(func, bpf_list_front)
> >  BTF_ID(func, bpf_list_back)
> >  BTF_ID(func, bpf_cast_to_kern_ctx)
> > @@ -12996,6 +12998,7 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
> >              btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> >              btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
> >              btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
> > +            btf_id == special_kfunc_list[KF_bpf_list_del] ||
> >              btf_id == special_kfunc_list[KF_bpf_list_front] ||
> >              btf_id == special_kfunc_list[KF_bpf_list_back];
> >  }
> > @@ -13118,7 +13121,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
> >       switch (node_field_type) {
> >       case BPF_LIST_NODE:
> >               ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
> > -                    kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
> > +                    kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
> > +                    kfunc_btf_id == special_kfunc_list[KF_bpf_list_del]);
> >               break;
> >       case BPF_RB_NODE:
> >               ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
>
>
