Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDB29BD8C
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786588349; cv=none; b=QBVxB//2eMRvCUr7gqBDIiP79V5I+StFGU4IqeFhSMx0Tu8jlf0/DqNPYZYR/Xg7r6NrFXQMZtqwjQYmrR7yi06VyLmCGXng0U1tMzIiKNBzd9m4CbfOQT2WB9GoPNGV/9fbV3/l4ltWbCTHVkwvgWddf+2MudDXZVVkBphZtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786588349; c=relaxed/simple;
	bh=036Im8OT7vtFN+Z+XmJ1SUKckGDPPAoqQODBJMhZKl0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C+r+B4w8cSyydGLsQXSX5gkIqnoBbcbhaGLZwjPACKs+9AMVCk5W26NVgz1xRAw2uYzMiRI9AU5ElO3ubrEc9b1Eha1jUI7OxEODoJmQZpmNBHUbwAbRPl2ohBhSWC6+Y+Zo2pwEAhF7lTucETc1qXyVH/fUK2TKg9qqnZkDnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXYZVrav; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXYZVrav"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fe3f552f0so81097f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786588346; x=1787193146; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OO/kWqWey78xSCQX80s8SUkYWYReSxkVRzCtMWpZ454=;
        b=RXYZVravDJOPK/ZIqrp36IUhDHoBEIy/GHMAGPMggL8JiV9UTvTNbLVe7qVanhXMh8
         FeI7DjDNceCnxIKcipDGBkuBCt5PHgnJGMo/sXSPGKqaAgIspEMS5tsh5jBz6K69QkMJ
         XUmCefVz+i8A6HwJgWyIMkVNBGxN9i6MsDrEMOKxRiBiFcZIaBDJ/TwFlDgFC2mrhg51
         vQ15vvpffdqQv3g9p0Hf9g5VxnQUwzvEhmEi5udgQsZHwkH8K4WJnG1KJs2g3WXMjzdt
         6UXrJGyEYFSWV/eATE8HNRPnfUc2U19kIIzSxbQdbjyrg5JiWakyY0dYTV4e/65JyThl
         Cblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786588346; x=1787193146;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OO/kWqWey78xSCQX80s8SUkYWYReSxkVRzCtMWpZ454=;
        b=PzA0s+J2H9rBtHR8Li2g5v83fMVuaj9+RuHbgxqNjVn1C0jFqCNDNT4Hp0qramiBLR
         xANOQgml8aUT3xHETogb7ttss/4YQlwpeGTBbH93aVA2YWVZkg6z1TT9U0llwBBIyFO3
         XQ/2TGjZpYtY3iUkwNI5XiihtlOn+H7bY0Pg/qYnagBhgCMXBuebnNCu1y2GF8C7iGQR
         hwwPKSV/Vzch7brxbSjKg/N9AVFshRGFoY3KBJtPu//IRGPKtX1Wg0hIk5/zkjfpsHAl
         WYdgJZZcPbB38UmWhiqxZhAv/YscEvx20ua1VWVbYwIC0RWR8/ORtWbd2Pp0zJn70GMs
         MQtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzTWw0SjFDTIv3OJ40efudsNBvDt0vSZ/YiF5UUYEHiT6Q53es9sx0APay+eM7o/H9Rp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuEBdoXSTiqeEleYeHpFIQlaidMaiNf8jGoEopac8Ok5uRGp0
	8hYW8Y1Vi2lJYZbfc6R3eA1lwubcfi/Ig7IqAN/lD0MM9mht+pXI/6zQ
X-Gm-Gg: AR+sD10Jag/TuAlmbsSzmSFJwX24vN6/aSDl8DDEnZrNgvA9ugmva1mCI8f/zpm1zuT
	YFzQCVjW5qh2/nzIlN9RI4fDj/J24AItx3iP1myh0YdqqFxUOu2S9b7gfilOPsC6uVjocbMwPXc
	59NFhupx71HRumLQRUkX3PWyPcnLtvIC7SYfXszdbhC3ew1/puYMrWMWArb4DpoI3t9/kgBAWfY
	hdCz2d7o+3sy7N4wfUiOBcX5iRKHbcMVKRPaegV2LMXLQlYM9jCEOdsZL12gy0HlXBV/o6wAq6u
	sJiUp4cT5RfdFoS99SMd9S6OmHs1lPkM1wEgssJ7mbSS3krpWvBQKyBEdBKpcUcUTF6lwWjczdY
	xj57H4QyJbWhvcEK1W0RwnA89V1cI+Ug0Qc2ATS6kN8XLN5HebBJ8QjhM5fKJhgiSEroGzS22d8
	jJaWapUE1syGwgdhyjASAvFdXCrwKErganvyL/XIG5hnprukw03e+jQ4Tqk0A+ClQRlkL/JBZ6r
	36Okl1ElynZ6gmnOpADoVhQF1Lwl1uZRroXKqu2Ma1qAoUQ7iiiERSKL3y00fvM7kr0i6AWPPWT
	wHTDWlT+lyQ4Mg7FWHp2uaHaEYo=
X-Received: by 2002:adf:fd4f:0:b0:481:474a:99f6 with SMTP id ffacd0b85a97d-4815a01c4e9mr2226008f8f.19.1786588345450;
        Wed, 12 Aug 2026 19:32:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569c2bsm2320892f8f.12.2026.08.12.19.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 19:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 04:32:24 +0200
Message-Id: <DKNGPMSHGC89.1WT6CHDFCPRJR@gmail.com>
Cc: <greg@kroah.com>, <sashiko-bot@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Viktor Malik" <vmalik@redhat.com>, "Justin Suess"
 <utilityemal77@gmail.com>, "Kaitao Cheng" <chengkaitao@kylinos.cn>, "Leon
 Hwang" <leon.hwang@linux.dev>, "Yiyang Chen"
 <chenyy23@mails.tsinghua.edu.cn>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Test untrusted
 allocated-object pointers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803112218.3361213-1-dingning04@gmail.com>
 <20260803112218.3361213-5-dingning04@gmail.com>
In-Reply-To: <20260803112218.3361213-5-dingning04@gmail.com>

On Mon Aug 3, 2026 at 1:22 PM CEST, Ning Ding wrote:
> The verifier previously allowed pointers used after RCU protection ended
> to reach bpf_refcount_acquire() and, for one object layout, a direct writ=
e.
> If the object was freed and reused, these operations could access stale
> memory.
>
> Add tests that keep BPF_PROBE_MEM reads accepted but reject reference
> acquisition and direct writes after RCU protection ends. Cover both teste=
d
> object layouts.
>
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.o=
rg
> Assisted-by: Codex:gpt-5
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---
>  .../selftests/bpf/progs/refcounted_kptr.c     | 100 ++++++++++++++++++
>  .../bpf/progs/refcounted_kptr_fail.c          |  27 +++++
>  2 files changed, 127 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
> index fd35093285c0d..b70be8b52ff80 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -893,6 +893,106 @@ long refcount_acquire_rcu_map_kptr_null_checked(voi=
d *ctx)
>  	return 0;
>  }
>
> +SEC("?tc")
> +__success
> +long map_kptr_read_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *n;
> +	int idx =3D 0;
> +
> +	mapval =3D bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	n =3D mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	return n->key;

Here, n->key won't read untrusted pointer, since tc progs have RCU protecti=
on,
so I don't think the pointer becomes untrusted.

> +}
> +
> +SEC("?tc")
> +__failure __msg("is neither owning or non-owning ref")
> +long refcount_acquire_graph_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n, *m;
> +	int idx =3D 0;
> +
> +	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	n =3D mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	m =3D bpf_refcount_acquire(n);
> +	if (m)
> +		bpf_obj_drop(m);
> +
> +	return 0;
> +}

I don't think you ran these tests, they have unexpected success, mostly bec=
ause
tc has RCU read protection already, so n passed to refcount acquire is not
untrusted.

> +
> +SEC("?tc")
> +__failure __msg("only read is supported")
> +long graph_map_kptr_write_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n;
> +	int idx =3D 0;
> +
> +	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n =3D mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	n->key =3D 1;
> +	return 0;
> +}
> +

Same for write here, it succeeds...

> +SEC("?tc")
> +__success
> +long graph_map_kptr_read_after_spin_unlock(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n;
> +	int idx =3D 0;
> +
> +	mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	n =3D mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	bpf_spin_lock(&lock);
> +	bpf_spin_unlock(&lock);
> +
> +	return n->key;
> +}
> +

Similar case.

>  static long __stash_map_empty_xchg(struct node_data *n, int idx)
>  {
>  	struct map_value *mapval =3D bpf_map_lookup_elem(&stashed_nodes, &idx);
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index acd3e81a39168..3408f68ad444d 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -127,6 +127,33 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(vo=
id *ctx)
>  	return 0;
>  }
>
> +SEC("?tc")
> +__failure __msg("is neither owning or non-owning ref")
> +long refcount_acquire_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *n, *m;
> +	int idx =3D 0;
> +
> +	mapval =3D bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n =3D mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	m =3D bpf_refcount_acquire(n);
> +	if (m)
> +		bpf_obj_drop(m);
> +
> +	return 0;
> +}

This also passes.

> +
>  SEC("?tc")
>  __failure __msg("Unreleased reference id=3D3 alloc_insn=3D{{[0-9]+}}")
>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)

Please respin and only send patches after you have tested them properly.

The right fix might be to use fentry.s for these tests to trigger untrusted
marking of pointers. The fixes themselves do make sense.

For the next version, target bpf-next and drop Cc: stable.

pw-bot: cr
