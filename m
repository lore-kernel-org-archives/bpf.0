Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567E36B076
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167463; cv=none; b=sLMFrIOSMFQMDMajDWCu/EEo6Vyai5/CpiodSt5uo6aUPdwPopXbRvxmd4MrZQ/NMvYdNgiNyX3wIZWzxnA/aYLm9zbBIz0HfE0hqZhpH4c1dP51CRwejfbuMwC9dVu0YyAtt56SdHFI0Ftt3HU9pfV9u5ltlSygZnd34r094gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167463; c=relaxed/simple;
	bh=9HELMpqCt/y3v6IUP1S7Pqa4RFgPwrMJSOa+ysR78VY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcZJbAlxSFrjOydYIfSFjeIV2TsVMxSVzKOLcn1QYwXz7ny0xbroGv/ychRFZyja2vAsZ+WJHcWFlmiQHHPLtHak8B/wQNg6JIE4dDmru4Lfd5r9+d9AWpcUhsl4ZBtGt4QgkSBIEIOcsT1In9m5ZacNIaYwbz/MpLdzhBiXJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMwXaxhg; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMwXaxhg"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30c591fb1cbso125106eec.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782167460; x=1782772260; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/sSLAyQBB0ORo4zFV8ubNZ09Kp6OqMCTr7MLDPfNDVA=;
        b=AMwXaxhgT9awindLVqM+JjpS82HFRPMNCWyPO0w+c0Umxg5DxvgVI49vKoE5x9eRao
         2Nvux9k7hmRvdi5v6ec/4ki1DBTRxh81zQ0L1r7dhP9TarNTaP1bYEBOQI+AGBLKeZkw
         cCjlKVCmphpFHjfWTYoTqcJWQrzv/5QtbtDDPPYnFcvFACJGmOHKSbz7WZXXsZLbYThJ
         9HD9SKKrhVw0u3NZiVOnb72deZRxoFCQy7xJdaJ3nQu8wvBAWWyUB+/uemHHyl63Gjzw
         RU2DfxB8TFG7lpAv6Vvonsj4gm1SIEze1R4u8bbgENLWhBnwaAj8Rr4+59p0/hAbE5zH
         67+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167460; x=1782772260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sSLAyQBB0ORo4zFV8ubNZ09Kp6OqMCTr7MLDPfNDVA=;
        b=AVu32Fy4V/FQPoxJIJfwNQoL47G01g8LTq825MUAQggD0IGbxAH+TAdBMInAOOA4he
         rD8NP/Hr7rDn1viHEs+u4mwAd9Ff3xV5WnWTGzk2Qw/HnQgMcHNS8CXIDrxypcCWGRMm
         V8LyIfL0ElMPk0n15FtR9bONUpQSqqh+YUwHoeARE39TnXA7EwB9gnn4HmJ8WCkXAfSJ
         pAxU0pRa/XrK7Gq8aBL5N6DzlQVEzXIFhLQ6fEempzbm6DNT/8QLeUn0m7Rq7JLjJB+W
         Xu502eN2thqPfFxqVHWsrb6BFy4CDX+vYI0eyq/G9oGKih7584KPBO+TbuyhUPoR5KJh
         5TPA==
X-Forwarded-Encrypted: i=1; AHgh+RpnAUZU6aX+Bzhm6qzSKXgOlEtE63l83a9eXo0+B3I6TfEyq2+x1Dm1h3hP9rZud+d+vso=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLu6434k+saoJMLvwHmF/mW7sNmiAgsukh4ehncohY90L/Z7o
	WhzNJqhdyBEMdd9hOEwW5HkWmUoEohpFEWioLzfxAUmWb47VJdk4QMFX
X-Gm-Gg: AfdE7cltjrvYZsWu65B+lx5v4+1QjF+EMEws4G0e7+15zlPIlzAE49GqbCfFF5PAHfU
	HFOyZYegI1LNUge3cWkC+pW1XC58PM8NcIdpJjVnlPYXK8owy9DDKvclkjFawERugjFCJWCD9WK
	dh8M0yEof4Wa2bzOstfQiPiME1ku8guFGrRst+6vXph4I60VtcoWI1PgyLYFRAG3H0mWZKU9Frn
	YgQaP6YCIOiG+/GrG8sC7fJcQmaIm+wf2XFYh5iwkuOiML/Uze0pMTJBoI+KNfXtbaRbYW8Qz31
	+kOLkcZ5UrcnL5OJPhUAcuJ8i5rPpiRQZ5bBLhdpWEFVqs4XSCoahheokt3SW6RO6QOOalXyDRP
	IDyZzUonCqZzbWjuav+nV3ldXTAxOcKoHEY7a18UEXTv8Iog7cFAv7T0twQIRIBtKtyMdRMAdtD
	J+ABWG56sh6WZux8NeqPKrQWAw4BTGjBF6fG9jtU00Koz97naJo1BYoxIx4VWxXbyL1hbhRg==
X-Received: by 2002:a05:7300:5b89:b0:307:393a:8f1d with SMTP id 5a478bee46e88-30c07056474mr11226290eec.14.1782167460233;
        Mon, 22 Jun 2026 15:31:00 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba635d8sm13152237eec.10.2026.06.22.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:30:59 -0700 (PDT)
Message-ID: <170c35441f167931b1a651e5bf07f671bc429368.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Cover refcount acquire
 node offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Viktor Malik	
 <vmalik@redhat.com>, Leon Hwang <leon.hwang@linux.dev>, Dave Marchevsky	
 <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 15:30:57 -0700
In-Reply-To: <5c0605718efd58ae3b8c44f70637ad1bd5ebb76e.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
	 <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
	 <5c0605718efd58ae3b8c44f70637ad1bd5ebb76e.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 02:25 +0000, Yiyang Chen wrote:
> Add regression coverage for bpf_refcount_acquire() on graph-node-derived
> pointers.
>=20
> The rejected cases pass popped list and rbtree node pointers directly to
> bpf_refcount_acquire(), which must fail because those pointers carry
> non-zero fixed offsets.
>=20
> Do not add a positive container_of() case here. Existing refcounted_kptr
> coverage already exercises valid base-pointer acquisitions, and this patc=
h
> only checks the rejected offset forms.

This paragraph is completely unnecessary.

> Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")

I don't think the fixes tag applies to the test.

> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  .../bpf/progs/refcounted_kptr_fail.c          | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 7247a20c0..77cda5ca2 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -13,12 +13,22 @@ struct node_acquire {
>  	struct bpf_refcount refcount;
>  };
> =20
> +struct node_refcounted {
> +	long key;
> +	struct bpf_rb_node rb;
> +	struct bpf_list_node list;
> +	struct bpf_refcount refcount;
> +};
> +
>  extern void bpf_rcu_read_lock(void) __ksym;
>  extern void bpf_rcu_read_unlock(void) __ksym;
> =20
>  #define private(name) SEC(".data." #name) __hidden __attribute__((aligne=
d(8)))
>  private(A) struct bpf_spin_lock glock;
>  private(A) struct bpf_rb_root groot __contains(node_acquire, node);
> +private(B) struct bpf_spin_lock lock;
> +private(B) struct bpf_rb_root root __contains(node_refcounted, rb);
> +private(B) struct bpf_list_head head __contains(node_refcounted, list);
> =20
>  static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
>  {
> @@ -31,6 +41,17 @@ static bool less(struct bpf_rb_node *a, const struct b=
pf_rb_node *b)
>  	return node_a->key < node_b->key;
>  }
> =20
> +static bool less_refcounted(struct bpf_rb_node *a, const struct bpf_rb_n=
ode *b)
> +{
> +	struct node_refcounted *node_a;
> +	struct node_refcounted *node_b;
> +
> +	node_a =3D container_of(a, struct node_refcounted, rb);
> +	node_b =3D container_of(b, struct node_refcounted, rb);
> +
> +	return node_a->key < node_b->key;
> +}
> +
>  SEC("?tc")
>  __failure __msg("Unreleased reference id=3D4 alloc_insn=3D{{[0-9]+}}")
>  long rbtree_refcounted_node_ref_escapes(void *ctx)
> @@ -93,6 +114,62 @@ long rbtree_refcounted_node_ref_escapes_owning_input(=
void *ctx)
>  	return 0;
>  }
> =20
> +SEC("?tc")
> +__failure __msg("dereference of modified ptr_ ptr R1")
> +long refcount_acquire_list_node_offset(void *ctx)
> +{
> +	struct node_refcounted *node, *base, *ref;
> +	struct bpf_list_node *list_node;
> +
> +	node =3D bpf_obj_new(typeof(*node));
> +	if (!node)
> +		return 1;
> +
> +	bpf_spin_lock(&lock);
> +	bpf_list_push_front(&head, &node->list);
> +	list_node =3D bpf_list_pop_front(&head);
> +	bpf_spin_unlock(&lock);
> +	if (!list_node)
> +		return 2;
> +
> +	base =3D container_of(list_node, struct node_refcounted, list);
> +	ref =3D bpf_refcount_acquire(list_node);
> +	if (ref)
> +		bpf_obj_drop(ref);
> +	bpf_obj_drop(base);
> +	return 0;
> +}
> +
> +SEC("?tc")
> +__failure __msg("dereference of modified ptr_ ptr R1")
> +long refcount_acquire_rbtree_node_offset(void *ctx)

Why is this test necessary? Does it exercise any paths that the
previous one does not check?

> +{
> +	struct node_refcounted *node, *base, *ref;
> +	struct bpf_rb_node *rb_node;
> +
> +	node =3D bpf_obj_new(typeof(*node));
> +	if (!node)
> +		return 1;
> +
> +	node->key =3D 1;
> +
> +	bpf_spin_lock(&lock);
> +	bpf_rbtree_add(&root, &node->rb, less_refcounted);
> +	rb_node =3D bpf_rbtree_first(&root);
> +	if (rb_node)
> +		rb_node =3D bpf_rbtree_remove(&root, rb_node);
> +	bpf_spin_unlock(&lock);
> +	if (!rb_node)
> +		return 2;
> +
> +	base =3D container_of(rb_node, struct node_refcounted, rb);
> +	ref =3D bpf_refcount_acquire(rb_node);
> +	if (ref)
> +		bpf_obj_drop(ref);
> +	bpf_obj_drop(base);
> +	return 0;
> +}
> +
>  SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>  __failure __msg("function calls are not allowed while holding a lock")
>  int BPF_PROG(rbtree_fail_sleepable_lock_across_rcu,
