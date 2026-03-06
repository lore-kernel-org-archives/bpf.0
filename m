Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F52D1F40
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758404; cv=pass; b=At6PMqiYCPq7K4n4G3j6E3RBTjNXuZUq7L8gO4UwG/CLU8i78+yD3ml020gae31soBJc0hKjynMF18q5+nTAgpzN8pCNKXzU5ycP3sclxPajHm+j92G2H3liZ139AenDrMUZ75NtAQBVZHhvSWVfezZqQYwtnM6rOEpurCFQSr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758404; c=relaxed/simple;
	bh=c8V1J5yjvc0E+ktwKWw3nGtIB24t7mazAmUfzyLEZhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKTfRMKZ/XUT2Xdqj4vbfJo9SXZSf8WlTJPChdI58TFBxL29yzv4UN/FHbO0EP+z/8OVvMW5RKxl5ByNon+MUTWnp07LERCtZM1MoUI5Cl2+qtw2MdhOFxB6MSUfhFlTd0doZ5BQdt9qRXre9M7Tqfo6wiDG53rlqVugXzRaOCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhnMLgir; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhnMLgir"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b9b1900bso3659067f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:53:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772758402; cv=none;
        d=google.com; s=arc-20240605;
        b=iJbks0W2yI+dCzIyCdHy1OLKyI3DxFvC7RE0bohZTaiSUFxE3uSR69yIEsLdTUGlF3
         G7MO2mJOnnJQTLjrhunDM1276Q6N1Yt8LYH90viDtqTot50D3TlqGwUqqhdAY2TVJw5t
         79jBje0R9rpN+o1J1rNEqM/9ioiE7jNqQdbEUXTwnb/drzwdEbWHCGOd2QLaQvLN7bdO
         GaU6sGnMWywqINnPqoZgt+hiOQmUa9NOwfqntprrUXUMHNeqO19JYDRPFJn9gldUpqrt
         GgaV1Zr9RD6eLG0jvfNfgC/M0pw94FhRsEly619avqcf2MfrWQA58yDii4kME8CrU+6a
         P9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o934O9rol7PMl2M/zW//XmCJcGxtE1M+wZq60dJEZ0c=;
        fh=+y4yg9PmZ4KCFft74mVk2kLZrVNXUNNyuP+dzlO34gw=;
        b=gBxTe9s4VpAtx/T1JwAIgiYepcyjcLygKiZOE3CZo4cQ2dWwdoDmrVGNxIQmvl8RT6
         t9iP2ZdQPttLPHxHECCT96b8aaR53uZzDPD4OdHzoAQv8anXlINdoFfpH1FKRRyo9oY0
         uow4SoxW53JL4fypnnoqQaguij0sNshsPItY7wmUZZePArkd3yYSxhY92Sx7LcbubpZa
         VQI/H+d3/yMmdZ3KZgv69V2tuerCbaPN1p2yldcUhDCdHQUo1JuiI295lKw/hR+lrQMR
         SDOUUPlKD0JGFcaVQ2gxni+p1JwhK6IX920lmAzC5J43XWJjQipVE4vgY7ak6bLuLxn5
         5sSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772758402; x=1773363202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o934O9rol7PMl2M/zW//XmCJcGxtE1M+wZq60dJEZ0c=;
        b=LhnMLgirs2W1Qx8Aw60lRZxSdag9vVITyaKqcVs9CxC8nZW6mwgyhSO5PpI3NbYue6
         CTfp2SZA2i+bzKJSAK5eVnOYAcJNLDNrI4H8wXlM38Vdy0ymoMgiGk3f6A4ea8NLlQOx
         V721KIvaqrhl+49orEsOTw0ktC+UogDvk+e/o+cEFsriVgaITjL+dEFR7nQ4OeO56f6t
         WCU4Oew12Waopwivvdeo7yOvnbl4r9KXWG2KAvaWb0ME0/ZrbKaS0Sxgk8TCByRHxbYT
         C+WLnyfuwkWVs4zZvhonsoOePefe4720V2UqjJscs+YU8UN6r7QObeUHFRBvCwbA7Bjc
         4/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758402; x=1773363202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o934O9rol7PMl2M/zW//XmCJcGxtE1M+wZq60dJEZ0c=;
        b=CFdvblewoKb0IiqFMUHpJp4Q1Hv/U62D/lUEii2GCKh57Pvh8mk3hoUR6AmjMLcjUN
         HxkWt6ff74PYYDX1ak7iyd8o/vL3l/sJ9DPmCguJiIVQ554lX6zT2FZqM22mwaakroo+
         80RFTNDYHBqzSYLRiJuu1yjRXb37d3BHcNt3FPai3R3vF4r4BEAnfoOzS9DpC7BL5iO/
         Q26oXRkUrJ1AByFJ2s/l3Gklf2soeU7i8EEsJ5j82m80IcnhOvmcviJ81bxPJifUatd+
         O6Ss4jGUv/6AbRuOIM/7rlOw85ZusKcac+D5/4/SyNgjDYZdPu5zkFBTMaw1kwtJRZRb
         E4rA==
X-Forwarded-Encrypted: i=1; AJvYcCV2wQO9ecqjsQZteXS41q51tXFkU3QM9VnydA2RU4V7W8d7ziDC1EzSg00gDgKzMTNW71U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fKNE74+L2IVBYGxmZ1w2oM6yl2eeKh60t55BYBWOjXGWJ8wg
	TBl3LE7IFKnM51+mJI6w6o15wMb4mJ5pEm8wXkJWw7h1n1dHsmUKr0NfOH92cvQ8sqVRc3JM52Z
	iayJ6T4ZDrAGxD9NnwoDzffze0V8wux0=
X-Gm-Gg: ATEYQzxgCPl/nRko2x5YjVtDrf94HXAodLXOYzxHN2Ys97iGAr9n6XF29uLQCPb6CEF
	3QUdNtpj9aYrVejnQQbTAOJKxmgMo0Q5LPx86tv81sXnjd835NoG2MYjmzhRb4VcWUzwOvKhJKy
	2ichX95IvaFzPqo8EkQ9oAaUIQUHkkz2ISoQDfNtQB7C3M3CsMz0cQRMsErFlAA4txPX0bmu/6v
	SPLie0/K7MAz17BlsFRYauEtdnNzaobiZSNDPnrZr25ZwJjny2grt00Mlz/afplkZt4LTaBF8e5
	5JJ1xlPAR6J9Z7CGJMfJHoW1r4ihlVohApaHEj6jly1SvsCf6bBX77tARMM=
X-Received: by 2002:a05:6000:40de:b0:439:bcab:4055 with SMTP id
 ffacd0b85a97d-439da8861c8mr411453f8f.34.1772758401671; Thu, 05 Mar 2026
 16:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304143459.78059-1-pilgrimtao@gmail.com> <20260304143459.78059-5-pilgrimtao@gmail.com>
In-Reply-To: <20260304143459.78059-5-pilgrimtao@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 01:52:44 +0100
X-Gm-Features: AaiRm52vZtUosq_3K0fu1C6I0zix5fPyFM2ZByOTfexcRK594utQEYtYZQyFAZk
Message-ID: <CAP01T77tQO8Gwg+XAB5Sq9nHJjorOPQN1ZZUSsof_tMbog5aFg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] selftests/bpf: Add test cases for bpf_list_del/add/is_edge/empty
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 15:51, Chengkaitao <pilgrimtao@gmail.com> wrote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Extend the refcounted_kptr test: add a node to both an rbtree and a
> list, retrieve the node from the rbtree to obtain the node pointer,
> then add a new node after the first in the list, and finally use
> bpf_list_del to remove both nodes.
>
> The test asserts that the list is non-empty after insert, asserts the
> first and last nodes after bpf_list_add, and asserts that the list is
> empty after removing both nodes.
>
> To verify the validity of bpf_list_del/add, the test also expects the
> verifier to reject calls to bpf_list_del/add made without holding the
> spin_lock.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

No reply to or feedback addressed from
https://lore.kernel.org/all/87342fzjq0.fsf@gmail.com.
Please don't respin without acting on it, or explaining why you chose
to skip it.

>  .../testing/selftests/bpf/bpf_experimental.h  |  39 ++++
>  .../selftests/bpf/progs/refcounted_kptr.c     | 182 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 4b7210c318dd..d5f42ed69166 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -99,6 +99,45 @@ extern struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head) __ks
>   */
>  extern struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head) __ksym;
>
> +/* Description
> + *     Remove 'node' from the BPF linked list with head 'head'.
> + *     The node must be in the list. Caller receives ownership of the
> + *     removed node and must release it with bpf_obj_drop.
> + * Returns
> + *     Pointer to the removed bpf_list_node, or NULL if 'node' is NULL
> + *     or not in the list.
> + */
> +extern struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
> +                                         struct bpf_list_node *node) __ksym;
> +
> +/* Description
> + *     Insert 'new' after 'prev' in the BPF linked list with head 'head'.
> + *     The bpf_spin_lock protecting the list must be held. 'prev' must already
> + *     be in that list; 'new' must not be in any list. The 'meta' and 'off'
> + *     parameters are rewritten by the verifier, no need for BPF programs to
> + *     set them.
> + * Returns
> + *     0 on success, -EINVAL if head is NULL, prev is not in the list with head,
> + *     or new is already in a list.
> + */
> +extern int bpf_list_add_impl(struct bpf_list_head *head, struct bpf_list_node *new,
> +                            struct bpf_list_node *prev, void *meta, __u64 off) __ksym;
> +
> +/* Convenience macro to wrap over bpf_list_add_impl */
> +#define bpf_list_add(head, new, prev) bpf_list_add_impl(head, new, prev, NULL, 0)
> +
> +/* Description
> + *     Return true if 'node' is the first (when 'is_first' is true) or the last
> + *     (when 'is_first' is false) node in the list with head 'head'.
> + */
> +extern bool bpf_list_node_is_edge(struct bpf_list_head *head,
> +                                 struct bpf_list_node *node, bool is_first) __ksym;
> +
> +/* Description
> + *     Return true if the list with head 'head' has no entries.
> + */
> +extern bool bpf_list_empty(struct bpf_list_head *head) __ksym;
> +

Except the macro, the rest can come from vmlinux.h.

>  /* Description
>   *     Remove 'node' from rbtree with root 'root'
>   * Returns
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index 1aca85d86aeb..aca201f9fb56 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -367,6 +367,188 @@ long insert_rbtree_and_stash__del_tree_##rem_tree(void *ctx)              \
>  INSERT_STASH_READ(true, "insert_stash_read: remove from tree");
>  INSERT_STASH_READ(false, "insert_stash_read: don't remove from tree");
>
> +/* Insert one node in tree and list, remove it from tree, add a second node
> + * after it with bpf_list_add, check bpf_list_node_is_edge/empty, then
> + * remove both nodes from list via bpf_list_del.
> + */

Incorrect comment style.

> +[...]
>
