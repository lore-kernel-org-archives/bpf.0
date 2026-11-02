Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606755;
	b=BrkoGEjQUcLVVOp+s4llYLH6FxuI6ptCG5kRWqw1bXTUuybvuig7kRhqKOrPmvyTW/K0
	 1yr3jiAh/ReCDeBKXH78ME0ao6J5yTY/MfSWCFsmzCiEgKehVQfORnTG/D67D7clkNsnV
	 tyeIG++bkTS702G2mAHLNwk6c1YPiSuwJMx5KaDOb8Ea3urf+zZg0/FfS7d0/bVGrhSkz
	 6zRAhVruFSPrnFMvhPKP+bg2ZkV0LtnlbH8Rp2B9u2KueIVqMAIb5LhAZUm2AKvZXtO/f
	 GGzX9KrcKfqJQZsBR9Xv3qFeVb5SJ3OZW8qh07KOYXt5QkwSyHo7Eb4EJfzEWkhk2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=GX1t9pMXs769JkYcNPsWNbN+V/MYmi7Av1eem4JHDLU=;
	b=zXWjiWFiZ+glNUKabScNeecle41VZy4HH8dgk1ewcYQS9mCwVoWgHctkFntGyFtlSTO7
	 LRFqRv1ppraY7s9cCgJnHxVjPQxvoYSTDoEeUJZeftL7gJCnNrN5AHP5sWk71QCCpyNv1
	 JqVk+SSKEGMC0Z9OZhWN5nGMs5flPBNu62y2ySEU5Mbq0xAiL3zc/CR6hUVkdWgjscGNn
	 7vQ/Jlnl8hHaF9L/K54hreYeAtkYxk+6B7VhuZPpO36Mw7gNDoQmIWOGk3pzz9k4zS5oa
	 Ge6YukEr6xqHMiItupg8Sppw9rqzeNH/9uVGcAheUBZdyFk8ZLbqqQJuJ6epRJ+Tgpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=AtHMd82K;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB7606A331
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2EB7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=AtHMd82K
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so2100079a91.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 00:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793606753; x=1794211553; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GX1t9pMXs769JkYcNPsWNbN+V/MYmi7Av1eem4JHDLU=;
        b=AtHMd82KQtTlxZKQvyocgi/7KzwrbxwY6eHIW+a5RTeXBq6IeIl7tv62TdvAZUHdQZ
         3jJDbdV+7D6/2x2Ih7VXjOgsSTP4ePWEO/AN+6bb10THadEWzXQIimRdTV6Npyv7/V0F
         1o2aj6OuU35EnmDLUhqgTKx/iBwgU6NyzTsvCx+myZ+w2+9T3KuVTDZT4yn1+yQHyaCg
         rviyfPVnppkn7Q3bsudVcdnJGbmVvg4u7MwEB3JuCGul5MyBd6w05eK+SQpLZ9BSnfRJ
         FrNawPIAoZLb0cXePjXnH/wMmjGnT+lr3xiAjkhc3pRx0yaE7VIsLo2Y37LHnJyHC39D
         dJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606753; x=1794211553;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GX1t9pMXs769JkYcNPsWNbN+V/MYmi7Av1eem4JHDLU=;
        b=kT40C8feZLyis3/Beg5MoK40QdR8L1Nt6fUUQTktF1AG4IlrOjc5wSNXrrDj2s28kP
         aT3LBu7OatkSvmekKUuSI4XmLWbaMYABNI6zLS6PFL2xUSquRmzxraAecInAia8oFwHK
         bdgCoJ0BLKMlT+/cm4HYvUpHZ1jWQKVdQFpzTUylWN6XIbwgXCwYKpRe16bgcm2mwIVi
         iBtCKbZTyXOW9Rf2wWt/L7PhUnnhnoj4yr9BKpJWFt4PPu1otK5iGbi7cZOEMZPyA+7i
         juGsWF9kay0lEBq7/hKEe/ovd71rAOBs3DiYQwO937W9DsoCvy8GlEE3JOllEFjiKUdv
         efRw==
X-Forwarded-Encrypted: i=1; AKwUvByYafsBtDRUqNgu6g4sIbpPJK3/Ho1JQO1a1WNsE2lvPFmjj3P0ASXM4ErC1pYPRekmulE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vSgJChVMaXjk2CzrJ7uGTAbVJqgeDhRfM1aM9al87Z/fHr7Js
	VstCJd8kK3OvrE6hATTk4PKSaYpe4EBS7WhW6+yof1v62w/05qGAGwwizpdwwPKVG9Q=
X-Gm-Gg: AYBFou0E9/cGVyvNQ0bEvBf/3F10dtk9lFPsYR2Wstc20dGfIRaQ8WKpd6SeZUnfBSB
	b3rQzmzco6iXZT5A5mIbMbIzdwk5ZoCpElaNEYeSgGQtbBjENvJvzaA6xuv3x0jzm6YawZtbjDj
	GQz7TKh19BHD3GhKK1tJHm2rqj9HqbCvmrfaXhtRyUQCQnAekgDHO4C7lSU0ufZFJS9f/0QDInv
	WWShKUP5hAycyIu+vkEyFKdaHqZnW8nM8IG9XEQt7Z8WtR89MpZlvalzvDCC7oIzT9Z3PJ5BA+L
	B0VOwPC7Fkqb98esdOjKhsHsVwahcAT7Nz6Ryfw5qNKrPVom/Tf7HldnJbofzKTfym8t9MwTXjB
	YngHM+fYGIJAvy3YfWO2AOixcfCdKe4uwMu9VyxOqTOsuMjbC8H3XUHTLh8R4srzMz8bhIfbklP
	mDkgII7/b3az2M1XO21I6+DIJEot7bDaxtS3ywTAdycQwczzdk3w+HdY+ft7roB+mqwXeIVkQ0V
	0216hEcX185zFST1l0ZXAHaDClyfhjYeYr/gSXve13qQutPPN5n2gGzn7mQNGj8Xemh7LCjSalZ
	H1XjJoefr8RAJYtdAt/Nc1vh/EEW0aBWbz0IozfoGH7x7e/yl1I0omxeiIlIziJwhEIVOJRZz66
	7CKk=
X-Received: by 2002:a17:90b:448c:b0:3ac:a7ee:6766 with SMTP id 98e67ed59e1d1-3ae8980ed36mr7796437a91.36.1793606752945;
        Mon, 02 Nov 2026 00:05:52 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm6501183a91.1.2026.11.02.00.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 00:05:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 08:05:51 +0000
Message-Id: <DMKKJ2IWG6RV.2ZCAR6J19F5XF@etsalapatis.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: libarena: Cache the
 rbtree's leftmost node and count
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
X-Mailer: aerc 0.21.0
References: <20261028060046.549097-1-changwoo@igalia.com>
 <20261028060046.549097-3-changwoo@igalia.com>
In-Reply-To: <20261028060046.549097-3-changwoo@igalia.com>

On Wed Oct 28, 2026 at 6:00 AM UTC, Changwoo Min wrote:
> A run queue built on the tree needs lockless peeks at its head and
> length, like scx_bpf_dsq_peek() and scx_bpf_dsq_nr_queued() for
> sched_ext DSQs.
>
> Keep the leftmost node and the node count in struct rbtree. An insert
> changes the head only when it links left of it, and removing the head
> hands it to its in-order successor. rb_least() and rb_pop() use the
> cached head. rb_first(), rb_first_key() and rb_nr_nodes() read them
> without the lock. The head pointer, published with release ordering,
> decides emptiness, and the key is read through it. Both fields sit on
> their own cache line.
>
> Add rb_init() for a tree embedded in another object, such as a queue
> that keeps its lock next to the tree, and rb_fini() to empty it, since
> rb_destroy() also frees the tree's memory.
>
> Add selftests for the head and count across inserts, removals and
> updates, and for an embedded tree.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../bpf/libarena/include/libarena/rbtree.h    |  53 +++++
>  .../bpf/libarena/selftests/test_rbtree.bpf.c  | 209 ++++++++++++++++++
>  .../selftests/bpf/libarena/src/rbtree.bpf.c   | 122 ++++++++--
>  3 files changed, 365 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> index 00e63b12d82e..a8dd8c2e7596 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> @@ -4,6 +4,9 @@
> =20
>  #define RB_MAXLVL_PRINT (16)
> =20
> +/* Cache line size assumed for keeping the lockless fields apart. */
> +#define RB_CACHELINE_SIZE (64)
> +
>  struct rbnode;
> =20
>  struct rbnode {
> @@ -56,14 +59,34 @@ enum rbtree_insert_mode {
>  };
> =20
>  struct rbtree {
> +	/* Writer fields, on a cache line of their own. */
>  	struct rbnode __arena *root;
>  	enum rbtree_alloc alloc;
>  	enum rbtree_insert_mode insert;
> +
> +	/*
> +	 * The leftmost node and the node count on their own cache line.
> +	 * The writer keeps them current, and readers may read them without
> +	 * the writer's lock (see rb_first() and friends).
> +	 */
> +	struct {
> +		struct rbnode __arena *first;
> +		uint64_t nr;
> +	} __attribute__((aligned(RB_CACHELINE_SIZE)));
>  };
> =20
>  #ifdef __BPF__
>  struct rbtree __arena *rb_create(enum rbtree_alloc alloc, enum rbtree_in=
sert_mode insert);
> =20
> +/*
> + * Initialize and finalize a tree embedded in another arena object.
> + * rb_fini() frees the nodes of an RB_ALLOC tree and fails with -EBUSY o=
n a
> + * non-empty RB_NOALLOC tree. It leaves the tree's memory to its owner.
> + */
> +int rb_init(struct rbtree __arena *rbtree, enum rbtree_alloc alloc,
> +	    enum rbtree_insert_mode insert);
> +int rb_fini(struct rbtree __arena *rbtree);

Unless we are constantly creating/destroying trees, I don't think this is n=
ecessary
- allocations are in the 100ns range. Is there a reason to require being ab=
le to embed
the tree into other data structures?

> +
>  int rb_destroy(struct rbtree __arena *rbtree);
>  int rb_insert(struct rbtree __arena *rbtree, u64 key, u64 value);
>  int rb_remove(struct rbtree __arena *rbtree, u64 key);
> @@ -80,4 +103,34 @@ void rb_node_free(struct rbnode __arena *rbnode);
> =20
>  int rb_integrity_check(struct rbtree __arena *rbtree);
> =20
> +/*
> + * Lockless reads of the head and the node count. They need not be calle=
d
> + * under the writer's lock, so they are advisory: the tree may change be=
fore
> + * the caller acts on the result. The node rb_first() returns may have
> + * left the tree, or been freed in an RB_ALLOC tree, by the time the
> + * caller reads it. The count is a separate read and need not agree
> + * with the head.
> + */

Can we somehow communicate in the function name that it has nonstandard sem=
antics?
Also sorry if we've discussed this before, but what is the exact use of get=
ting
the node address back speculatively if we cannot guarantee the validity of =
the
pointer at all? Doesn't rb_first_key cover the case where we locklessly pee=
k
the key?

> +static __always_inline struct rbnode __arena *rb_first(struct rbtree __a=
rena *rbtree)
> +{
> +	return READ_ONCE(rbtree->first);
> +}
> +
> +/* -ENOENT if the tree is empty, 0 with the leftmost key in @key otherwi=
se. */
> +static __always_inline int rb_first_key(struct rbtree __arena *rbtree, u=
64 *key)
> +{
> +	struct rbnode __arena *first =3D READ_ONCE(rbtree->first);
> +
> +	if (!first)
> +		return -ENOENT;
> +
> +	*key =3D READ_ONCE(first->key);
> +	return 0;
> +}
> +
> +static __always_inline u64 rb_nr_nodes(struct rbtree __arena *rbtree)
> +{
> +	return READ_ONCE(rbtree->nr);
> +}
> +
>  #endif /* __BPF__ */
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> index 1e2a0fac1e4f..57c4395c046a 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> @@ -285,6 +285,215 @@ __weak int test_rbtree_duplicate_fifo(void)
>  	return rb_destroy(rbtree);
>  }
> =20
> +/*
> + * Check the lockless head and count against a walk to the leftmost node=
,
> + * which does not use the cached head.
> + */
> +__weak int rbtree_check_first(struct rbtree __arena *rbtree, u64 nr)
> +{
> +	struct rbnode __arena *least =3D rbtree->root;
> +	u64 key;
> +
> +	while (least && least->left && can_loop)
> +		least =3D least->left;
> +
> +	if (rb_first(rbtree) !=3D least)
> +		return 1;
> +
> +	if (rb_nr_nodes(rbtree) !=3D nr)
> +		return 2;
> +
> +	if (!least)
> +		return rb_first_key(rbtree, &key) =3D=3D -ENOENT ? 0 : 3;
> +
> +	if (rb_first_key(rbtree, &key) || key !=3D least->key)
> +		return 4;
> +
> +	return 0;
> +}
> +
> +#define FIRST_NR_NODES	64
> +
> +static struct rbnode __arena *first_nodes[FIRST_NR_NODES];
> +
> +SEC("syscall")
> +__weak int test_rbtree_first(void)
> +{
> +	struct rbtree __arena *rbtree;
> +	struct rbnode __arena *node;
> +	u64 seed =3D 12345, nr =3D 0;
> +	int ret, i;
> +
> +	rbtree =3D rb_create(RB_NOALLOC, RB_DUPLICATE);
> +	if (!rbtree)
> +		return 1;
> +
> +	ret =3D rbtree_check_first(rbtree, 0);
> +	if (ret)
> +		return 10 + ret;
> +
> +	/* Pseudo-random keys with repeats, so the head moves and gets ties. */
> +	for (i =3D 0; i < FIRST_NR_NODES && can_loop; i++) {
> +		seed =3D seed * 6364136223846793005ULL + 1442695040888963407ULL;
> +		node =3D rb_node_alloc((seed >> 33) % 32, i);
> +		if (!node)
> +			return 2;
> +
> +		first_nodes[i] =3D node;
> +
> +		ret =3D rb_insert_node(rbtree, node);
> +		if (ret)
> +			return 3;
> +
> +		ret =3D rbtree_check_first(rbtree, ++nr);
> +		if (ret)
> +			return 20 + ret;
> +	}
> +
> +	/* Remove every other node in insertion order, head or not. */
> +	for (i =3D 0; i < FIRST_NR_NODES && can_loop; i +=3D 2) {
> +		ret =3D rb_remove_node(rbtree, first_nodes[i]);
> +		if (ret)
> +			return 4;
> +
> +		rb_node_free(first_nodes[i]);
> +
> +		ret =3D rbtree_check_first(rbtree, --nr);
> +		if (ret)
> +			return 30 + ret;
> +	}
> +
> +	/* Remove the head of the remaining half, emptying the tree. */
> +	for (i =3D 0; i < FIRST_NR_NODES / 2 && can_loop; i++) {
> +		node =3D rb_first(rbtree);
> +		if (!node)
> +			return 5;
> +
> +		ret =3D rb_remove_node(rbtree, node);
> +		if (ret)
> +			return 6;
> +
> +		rb_node_free(node);
> +
> +		ret =3D rbtree_check_first(rbtree, --nr);
> +		if (ret)
> +			return 40 + ret;
> +	}
> +
> +	return rb_destroy(rbtree);
> +}
> +
> +SEC("syscall")
> +__weak int test_rbtree_first_update(void)
> +{
> +	struct rbtree __arena *rbtree;
> +	struct rbnode __arena *node;
> +	int ret;
> +
> +	rbtree =3D rb_create(RB_ALLOC, RB_UPDATE);
> +	if (!rbtree)
> +		return 1;
> +
> +	if (rb_insert(rbtree, 5, 1))
> +		return 2;
> +
> +	if (rb_insert(rbtree, 5, 2))
> +		return 3;
> +
> +	node =3D rb_first(rbtree);
> +	if (!node || node->key !=3D 5 || node->value !=3D 2)
> +		return 4;
> +
> +	ret =3D rbtree_check_first(rbtree, 1);
> +	if (ret)
> +		return 10 + ret;
> +
> +	if (rb_insert(rbtree, 3, 3))
> +		return 5;
> +
> +	ret =3D rbtree_check_first(rbtree, 2);
> +	if (ret)
> +		return 20 + ret;
> +
> +	if (rb_remove(rbtree, 3) || rb_remove(rbtree, 5))
> +		return 6;
> +
> +	ret =3D rbtree_check_first(rbtree, 0);
> +	if (ret)
> +		return 30 + ret;
> +
> +	return rb_destroy(rbtree);
> +}
> +
> +struct rb_embed {
> +	u64 pad;
> +	struct rbtree tree;
> +};
> +
> +SEC("syscall")
> +__weak int test_rbtree_embedded(void)
> +{
> +	struct rb_embed __arena *embed;
> +	struct rbtree __arena *rbtree;
> +	struct rbnode __arena *node;
> +	int ret, i;
> +
> +	embed =3D arena_malloc(sizeof(*embed));
> +	if (!embed)
> +		return 1;
> +
> +	rbtree =3D &embed->tree;
> +
> +	/* Poison the fields rb_init() must set. */
> +	WRITE_ONCE(rbtree->root, (struct rbnode __arena *)~0ULL);
> +	WRITE_ONCE(rbtree->first, (struct rbnode __arena *)~0ULL);
> +	WRITE_ONCE(rbtree->nr, ~0ULL);
> +
> +	if (rb_init(rbtree, RB_NOALLOC, RB_DUPLICATE))
> +		return 2;
> +
> +	ret =3D rbtree_check_first(rbtree, 0);
> +	if (ret)
> +		return 10 + ret;
> +
> +	for (i =3D 0; i < 4 && can_loop; i++) {
> +		node =3D rb_node_alloc(4 - i, i);
> +		if (!node)
> +			return 3;
> +
> +		if (rb_insert_node(rbtree, node))
> +			return 4;
> +
> +		ret =3D rbtree_check_first(rbtree, i + 1);
> +		if (ret)
> +			return 20 + ret;
> +	}
> +
> +	if (rb_fini(rbtree) !=3D -EBUSY)
> +		return 7;
> +
> +	for (i =3D 0; i < 4 && can_loop; i++) {
> +		node =3D rb_first(rbtree);
> +		if (!node || node->key !=3D i + 1)
> +			return 5;
> +
> +		if (rb_remove_node(rbtree, node))
> +			return 6;
> +
> +		rb_node_free(node);
> +
> +		ret =3D rbtree_check_first(rbtree, 3 - i);
> +		if (ret)
> +			return 30 + ret;
> +	}
> +
> +	if (rb_fini(rbtree))
> +		return 8;
> +
> +	arena_free(embed);
> +	return 0;
> +}
> +
>  static inline int
>  clean_up_noalloc_tree(struct rbtree __arena *rbtree)
>  {
> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> index e6c9430f734b..2622c78302af 100644
> --- a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> @@ -15,14 +15,12 @@ static int rbnode_replace(struct rbtree __arena *rbtr=
ee,
>  			  struct rbnode __arena *existing,
>  			  struct rbnode __arena *replacement);
> =20
> -struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
> -				 enum rbtree_insert_mode insert)
> +__weak
> +int rb_init(struct rbtree __arena *rbtree, enum rbtree_alloc alloc,
> +	    enum rbtree_insert_mode insert)
>  {
> -	struct rbtree __arena *rbtree;
> -
> -	rbtree =3D arena_malloc(sizeof(*rbtree));
>  	if (unlikely(!rbtree))
> -		return NULL;
> +		return -EINVAL;
> =20
>  	/*
>  	 * RB_UPDATE overwrites existing values in the nodes, but RB_NOALLOC
> @@ -32,19 +30,51 @@ struct rbtree __arena *rb_create(enum rbtree_alloc al=
loc,
>  	 */
>  	if (alloc =3D=3D RB_NOALLOC && insert =3D=3D RB_UPDATE) {
>  		arena_stderr("WARNING: Cannot combine RB_NOALLOC and RB_UPDATE");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(rbtree->root, NULL);
> +	WRITE_ONCE(rbtree->alloc, alloc);
> +	WRITE_ONCE(rbtree->insert, insert);
> +	WRITE_ONCE(rbtree->first, NULL);
> +	WRITE_ONCE(rbtree->nr, 0);
> +
> +	return 0;
> +}
> +
> +/*
> + * arena_malloc() aligns a block to its power-of-two size, so the tree's
> + * lockless fields get a cache line of their own.
> + */
> +struct rbtree __arena *rb_create(enum rbtree_alloc alloc,
> +				 enum rbtree_insert_mode insert)
> +{
> +	struct rbtree __arena *rbtree;
> +
> +	rbtree =3D arena_malloc(sizeof(*rbtree));
> +	if (unlikely(!rbtree))
> +		return NULL;
> +
> +	if (rb_init(rbtree, alloc, insert)) {
>  		arena_free(rbtree);
>  		return NULL;
>  	}
> =20
> -	rbtree->alloc =3D alloc;
> -	rbtree->insert =3D insert;
> -	rbtree->root =3D NULL;
> -
>  	return rbtree;
>  }
> =20
> +static __always_inline void rb_set_first(struct rbtree __arena *rbtree,
> +					 struct rbnode __arena *node)
> +{
> +	/*
> +	 * Publish the new leftmost node with release ordering, so a lockless
> +	 * reader that sees it also sees the node's fields.
> +	 */
> +	smp_store_release(&rbtree->first, node);
> +}
> +
>  __weak
> -int rb_destroy(struct rbtree __arena *rbtree)
> +int rb_fini(struct rbtree __arena *rbtree)
>  {
>  	int ret =3D 0;
> =20
> @@ -63,11 +93,11 @@ int rb_destroy(struct rbtree __arena *rbtree)
>  		 * the now freed nodes. Throw an error instead.
>  		 */
>  		if (rbtree->root) {
> -			arena_stderr("WARNING: Destroying RB_NOALLOC tree with > 0 nodes");
> +			arena_stderr("WARNING: Finalizing RB_NOALLOC tree with > 0 nodes");
>  			return -EBUSY;
>  		}
> =20
> -		goto out;
> +		return 0;
>  	}
> =20
>  	while (rbtree->root && can_loop) {
> @@ -76,11 +106,22 @@ int rb_destroy(struct rbtree __arena *rbtree)
>  			break;
>  	}
> =20
> -out:
> -	arena_free(rbtree);
>  	return ret;
>  }
> =20
> +__weak
> +int rb_destroy(struct rbtree __arena *rbtree)
> +{
> +	int ret;
> +
> +	ret =3D rb_fini(rbtree);
> +	if (ret)
> +		return ret;
> +
> +	arena_free(rbtree);
> +	return 0;
> +}
> +
>  static inline int rbnode_dir(struct rbnode __arena *node)
>  {
>  	/* Arbitrarily choose a direction for the root. */
> @@ -255,6 +296,8 @@ int rb_node_insert(struct rbtree __arena *rbtree,
> =20
>  	if (!parent) {
>  		rbtree->root =3D node;
> +		rb_set_first(rbtree, node);
> +		WRITE_ONCE(rbtree->nr, 1);
>  		return 0;
>  	}
> =20
> @@ -273,6 +316,10 @@ int rb_node_insert(struct rbtree __arena *rbtree,
>  			if (ret)
>  				return ret;
> =20
> +			/* Same key and place, so only the head's identity changes. */
> +			if (rbtree->first =3D=3D parent)
> +				rb_set_first(rbtree, node);
> +
>  			if (rbtree->alloc =3D=3D RB_ALLOC)
>  				rb_node_free(parent);
> =20
> @@ -290,6 +337,14 @@ int rb_node_insert(struct rbtree __arena *rbtree,
>  	else
>  		parent->right =3D node;
> =20
> +	/*
> +	 * The node is the new head only if it went left of the old one. The
> +	 * rotations below never change which node is leftmost.
> +	 */
> +	if (parent =3D=3D rbtree->first && parent->left =3D=3D node)
> +		rb_set_first(rbtree, node);
> +	WRITE_ONCE(rbtree->nr, rbtree->nr + 1);
> +
>  	while (can_loop) {
>  		parent =3D node->parent;
>  		if (!parent)
> @@ -410,7 +465,7 @@ __weak int rb_least(struct rbtree __arena *rbtree, u6=
4 *key, u64 *value)
>  	if (!rbtree->root)
>  		return -ENOENT;
> =20
> -	least =3D rbnode_least(rbtree->root);
> +	least =3D rbtree->first;
>  	if (key)
>  		*key =3D least->key;
>  	if (value)
> @@ -578,8 +633,8 @@ static inline bool rbnode_has_red_children(struct rbn=
ode __arena *node)
>  }
> =20
>  static
> -int rb_node_remove(struct rbtree __arena *rbtree,
> -		   struct rbnode __arena *node)
> +int rbnode_remove(struct rbtree __arena *rbtree,
> +		  struct rbnode __arena *node)
>  {
>  	struct rbnode __arena *parent, *sibling, *close_nephew, *distant_nephew=
;
>  	bool free =3D (rbtree->alloc =3D=3D RB_ALLOC);
> @@ -765,6 +820,35 @@ int rb_node_remove(struct rbtree __arena *rbtree,
>  	return 0;
>  }
> =20
> +/*
> + * Remove @node and keep the head and the node count current. The head h=
as no
> + * left child, so if it is the node going away, its successor is the lef=
tmost
> + * node of its right subtree, or else its parent. Take it before the tre=
e
> + * changes; the removal and its fixups preserve the in-order sequence.
> + */
> +static __always_inline

We don't need the __always_inline for static functions, they are there to h=
elp
with verifier limits but upstream libarena tracks bpf-next which can verify
pretty much anything. I'll re-add those as needed when importing to Github
in the compat branch.

> +int rb_node_remove(struct rbtree __arena *rbtree,
> +		   struct rbnode __arena *node)
> +{
> +	struct rbnode __arena *next =3D NULL;
> +	bool was_first;
> +	int ret;
> +
> +	was_first =3D node =3D=3D rbtree->first;
> +	if (was_first)
> +		next =3D node->right ? rbnode_least(node->right) : node->parent;
> +
> +	ret =3D rbnode_remove(rbtree, node);
> +	if (ret)
> +		return ret;
> +
> +	if (was_first)
> +		rb_set_first(rbtree, next);
> +	WRITE_ONCE(rbtree->nr, rbtree->nr - 1);
> +
> +	return 0;
> +}
> +
>  __weak
>  int rb_remove_node(struct rbtree __arena *rbtree,
>  		   struct rbnode __arena *node)
> @@ -813,7 +897,7 @@ int rb_pop(struct rbtree __arena *rbtree, u64 *key, u=
64 *value)
>  	if (rbtree->alloc !=3D RB_ALLOC)
>  		return -EINVAL;
> =20
> -	node =3D rbnode_least(rbtree->root);
> +	node =3D rbtree->first;
>  	if (unlikely(!node))
>  		return -ENOENT;
> =20

