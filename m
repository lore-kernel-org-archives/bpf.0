Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB8611E
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637205; cv=none; b=J8vpJ8nUx3yad9qNjmPeI0jSxysjyoT24EP7JeaoGYrzOAGxg/mXMQlm1r0t/ZZhma2BzyZoceTYvjzxBGlz8a7jc5nwIOUHJ97RFBv4bbH+JiP3n9DEYIh96FPFqbBPlEb1CsyK1chdcfiIEcRtilniKAHxdCYMxO7LRFHfRwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637205; c=relaxed/simple;
	bh=1YFcWlz/r9VE3Q0VDgk6jiIND8p5d7gSNbT8wjCMQgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCbsgddYh9NEoQysOvIxVwZBm2JT+AfGGkij9N8S8B0b6SNh6IclpjwPfi3QoCudvNvHA8mwLwwPLaW+drBzNhQDVbyKcLqNroNzXdvuMm+rx42IIc4nShpx2IMlzjv2s2XXcUwqQaY1SBGbYBsStwZpE2cqA0ydkJK7CyRqHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCXhjOVI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCXhjOVI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483a2338616so43862325e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772637202; x=1773242002; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n86dk0KwrsBwI7hT/iQAYW05mvoxAxmaULpJGzCbTNY=;
        b=QCXhjOVIh7s8I/9kGA8YJ1DgR7Iq3Ll8YQS3L1OUHV8sLBQ+2AZqJQJ0JjpqtxBrik
         E9hivaYG0ItIHUWaNLhhxL7Ol5dzTbw+4Kkb5uj3ZT1rHE3hlw973tT5w9SEtBhKG+8U
         fBrV9GidBwkPufxjlulijV/XBKn55uhdyaPyxjvOqyfw6Eym4/IGYB4v+NXJSfJos7Y+
         u28W3D5bFuQezg752ucZoWhv6RjEYgTum1VyyQSdtFMENkMKRJUL5odzp/ARkrRN7ck7
         me70WezJZy94BGm3JiOCEQiFJh42G5mnkvSI5jukDgBI19yWtXCiCFaaUFwBBm56Q+i7
         DLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637202; x=1773242002;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n86dk0KwrsBwI7hT/iQAYW05mvoxAxmaULpJGzCbTNY=;
        b=pw09A6r1iaX6EFYE8363CYxPhGIP0QY9XEaV5ZTnEsmEBWVTrBlIBkShKBBa0tH6sE
         JWUbQhM1d2oU5d5rIy+3oPrWJvfsohw+LW40Vmv8x3+NI5wQo7A+2Ddi6RW0rq7xvFY9
         0XFfIubEo79Tr5HPhKLCNHrYP226RD8v+UroOFTOWiQK7Opf6BLIqy6A/Sf0xkNzdpmD
         ZAkP7RW3UDJ6qTiw9dU8iWq2187ZQodTjMVJX/uvB+wfMYTfIUY7VAenct/psmL4dSb8
         fI+9HX6YbOdIu8g5lUdA3CQXY5YfRKOpBPHnGZJ0jUdcDp3KYpXuTOVlWey3GRTAxBlq
         jjCA==
X-Gm-Message-State: AOJu0Yz+2EeWzfKZ3d7007RvEpw/hHLKTbo6Uv8srfu8Xgan1iVTGGlp
	5PNjPBIu3ABLHRwBNXlatZeCr9cvl+qvOMKyAPwtj4OmagQgs56y4Z4Q
X-Gm-Gg: ATEYQzyL8xYWz6WyCVl088LkmupZaYuRmtlbo8wjskdMoWETiytgXHhOfPqEfnFc14A
	PZ1v72hCo4sSBF0r9hlmzrOuftzvODaU6jI0kNTMX3JxruWZHrOcFnHOiVzifcrnnbMxQEUOj5k
	mrDFxdSobycYCYIhM5Atwg1sptJlxrKncl6RlhokJLBXScJjjP80Y77lAgB6QmVrLTUXKLLxV5a
	nY5kquJMasKeYJTC1527yQvS1M+rqhNTE7XZTacop3F3zZlPAywTuyhsjLMvZASZ41rn8Al7TBr
	vtpFsqnG7fBuQsqvZzrvZkBxj8oo8A/UIP6XwsD5OHA8AWrPku9g0eyN3vzh4kEM36o04bAjXGc
	cQT25J8WxgNrumJcMzH64e0oS36HJBF6rfGVh5hBOMsVTYjvT2ZbRNg7Gi1rgmzl7V7qopXLMe5
	6uYGrVD+mqH/RuIMNVQS5ubHtoyvSHKuB0wxcivg==
X-Received: by 2002:a05:600c:4452:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-485197f6ae3mr46162695e9.0.1772637202157;
        Wed, 04 Mar 2026 07:13:22 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188080edsm57073725e9.10.2026.03.04.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:13:21 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Chengkaitao <pilgrimtao@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] bpf: add bpf_list_is_first/last/empty kfuncs
In-Reply-To: <20260304031606.43884-6-pilgrimtao@gmail.com>
References: <20260304031606.43884-1-pilgrimtao@gmail.com>
 <20260304031606.43884-6-pilgrimtao@gmail.com>
Date: Wed, 04 Mar 2026 15:13:21 +0000
Message-ID: <875x7bzkz2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chengkaitao <pilgrimtao@gmail.com> writes:

> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Add three kfuncs for BPF linked list queries:
> - bpf_list_is_first(head, node): true if node is the first in the list.
> - bpf_list_is_last(head, node): true if node is the last in the list.
> - bpf_list_empty(head): true if the list has no entries.
>
> In previous versions, to implement the above functionality, it was
> necessary to first call bpf_list_pop_front/back to retrieve the first
> or last node before checking whether the passed-in node was the first
> or last one. After the check, the node had to be pushed back into the
> list using bpf_list_push_front/back, which was very inefficient.
>
> Now, with the bpf_list_is_first/last/empty kfuncs, we can directly
> check whether a node is the first, last, or whether the list is empty,
> without having to first retrieve the node.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/helpers.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c | 15 +++++++++++++--
>  2 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 188840057c7d..2b9f30a36c63 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2521,6 +2521,44 @@ __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
>  	return -EINVAL;
>  }
>  
> +__bpf_kfunc bool bpf_list_is_first(struct bpf_list_head *head, struct bpf_list_node *node)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
> +
> +	if (unlikely(!h->next) || list_empty(h))
> +		return false;
Do we need this block?
It sounds like a problem if we end up in the situation where
node->owner points to the uninitialized head - the list is corrupted.
> +
> +	if (READ_ONCE(n->owner) != head)
> +		return false;
> +
> +	return h->next == &n->list_head;
Can we reuse list_is_first() here for simplicity?
> +}
> +
> +__bpf_kfunc bool bpf_list_is_last(struct bpf_list_head *head, struct bpf_list_node *node)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +	struct bpf_list_node_kern *n = (struct bpf_list_node_kern *)node;
> +
> +	if (unlikely(!h->next) || list_empty(h))
> +		return false;
> +
> +	if (READ_ONCE(n->owner) != head)
> +		return false;
> +
> +	return h->prev == &n->list_head;
Here maybe list_is_last() going to work as well?
> +}
> +
> +__bpf_kfunc bool bpf_list_empty(struct bpf_list_head *head)
> +{
> +	struct list_head *h = (struct list_head *)head;
> +
> +	if (unlikely(!h->next))
> +		return true;
> +
> +	return list_empty(h);
> +}
> +
>  __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>  						  struct bpf_rb_node *node)
>  {
> @@ -4591,6 +4629,9 @@ BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_list_add_impl)
> +BTF_ID_FLAGS(func, bpf_list_is_first)
> +BTF_ID_FLAGS(func, bpf_list_is_last)
> +BTF_ID_FLAGS(func, bpf_list_empty)
>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 197b972e79a2..e97c7e11bf65 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12465,6 +12465,9 @@ enum special_kfunc_type {
>  	KF_bpf_list_front,
>  	KF_bpf_list_back,
>  	KF_bpf_list_add_impl,
> +	KF_bpf_list_is_first,
> +	KF_bpf_list_is_last,
> +	KF_bpf_list_empty,
>  	KF_bpf_cast_to_kern_ctx,
>  	KF_bpf_rdonly_cast,
>  	KF_bpf_rcu_read_lock,
> @@ -12527,6 +12530,9 @@ BTF_ID(func, bpf_list_del)
>  BTF_ID(func, bpf_list_front)
>  BTF_ID(func, bpf_list_back)
>  BTF_ID(func, bpf_list_add_impl)
> +BTF_ID(func, bpf_list_is_first)
> +BTF_ID(func, bpf_list_is_last)
> +BTF_ID(func, bpf_list_empty)
>  BTF_ID(func, bpf_cast_to_kern_ctx)
>  BTF_ID(func, bpf_rdonly_cast)
>  BTF_ID(func, bpf_rcu_read_lock)
> @@ -13003,7 +13009,10 @@ static bool is_bpf_list_api_kfunc(u32 btf_id)
>  	       btf_id == special_kfunc_list[KF_bpf_list_del] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
>  	       btf_id == special_kfunc_list[KF_bpf_list_back] ||
> -	       btf_id == special_kfunc_list[KF_bpf_list_add_impl];
> +	       btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_is_last] ||
> +	       btf_id == special_kfunc_list[KF_bpf_list_empty];
>  }
>  
>  static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
> @@ -13126,7 +13135,9 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>  		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_del] ||
> -		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl]);
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_add_impl] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_first] ||
> +		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_is_last]);
>  		break;
>  	case BPF_RB_NODE:
>  		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> -- 
> 2.50.1 (Apple Git-155)
