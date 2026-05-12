Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59A3EDE77
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617101; cv=none; b=klL9ijWImYrubnmopHxEpm7wBE54QtDp02ukq4VxWtHTLrMILnG6NYp0Ke2g0FZARGbL1vkZBYHMtwqb/8sPWACbhuLPgT0qURorOYpEIx3sFFpftfupKgrAcryaIUJCUBE1FiSHjOD64R3JastklYCphslsc/okjWkLSbV5Rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617101; c=relaxed/simple;
	bh=FdzUaWtB7DJGo7A0teer6F4CuuRRF9f1BvY5dWqTEts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KYqLZGoIUc0yYkBFww2vK02BToptIB+pgCouXtQB+r/OJ3SifQCi+9LUSLaoUGd+/jOBxWwPZbL35zd7q/KsAeFYm6ywieccInFfVuxiB8MlHCNTEHdXDTKcFpFq4XzYSLkOlNJBT8nowwKEtUW0iOanai2Njf0MyMC+0Q140qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=oYaGFuNJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="oYaGFuNJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bcd3ac3307so14990235ad.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778617098; x=1779221898; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOZp60aNx3BLaBpH0eS9pNdcvV8d8co+xU6K2uUnQ8Q=;
        b=oYaGFuNJdS2tmezY4AQMQ23SyPFWWgjYiUGf8JoGqs2Wl9/9asmI7DlhLYrQmhB1MH
         TvqB1hLvwsFR1jafbI6XZ2KXHU7ogOm8s+KQ7oTW8vpwThmwj/kKccWig/zMhG/9a2i8
         evBBd0LsWxX65T+7gdPiWdlFrqoVdlU6gXIBIMDXylTIvUErS/m4ogaFSFJgyUFaLSEd
         vI4U6zTul2ks7EoBtqaD2HOKlC6rjbof1WwstCbqSirpl2DCVRbb6P/i0xhJ/BM7ejV1
         /+b8LhJ0V3c6hIDPyygn901++v4zRbVgbU0yXRrNsNnuUDMtGizeZkfEbhk+gt/2CLqc
         CSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617098; x=1779221898;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOZp60aNx3BLaBpH0eS9pNdcvV8d8co+xU6K2uUnQ8Q=;
        b=R2b4V/ae1qZBe4jl9Vz1c3q6EMg/TcHqYmALV54B+pqYY5q786B6IYGyZ28HTB4z+c
         hvx/qUyJ+jef8B75DG+Sfp1KkdXrC0yl4uMzdXCxJRWMC4QQDdf50KiMBvejh+GyX3Pq
         IfKe7RfhuU+dOIV5XLko5lFw5n8mvul74ptp88nIi5/Qm76Fhz+EMT/C3BKJD9KdHvq1
         u7m8DyPgM+eEWi992s73X6A/fBWWvoNDyNMf/lOWQWCTAFQcl0FL0kW5epOXjXfcKoQx
         DNwepFP6jA2Rdn+mEMkm3s/6sYpuZr1z7MYzJOySsBsu81sHkRiw/85+vWz65TrSMteB
         gGbA==
X-Forwarded-Encrypted: i=1; AFNElJ8aqORzM4QIXn5GCEaMAHfnrE6d0uI9yYEXqM4IwydX58zdpi+d++/CKE7rGg6gRIaITI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTSQLnPAxYpTdzoStCa3qfQ1TpaVEMA8Fa/4AS0ViBi6AJNF1
	5E+WsvhzGDzfvGoLL9MHKAZnCJ+6MOHZStIr7YpKI7ggxsgoR8Qxqh7d5bHpBiTxy/k=
X-Gm-Gg: Acq92OHwjR1+Ib4E+CKdGeKn5konJX/8+R/whQpS5AxlUYhqttqG1LGkvnUDSUurkM7
	12rc5rtlovTe6l3RA8oveAiXTG0s07Ha+a4S5p61LUaawjfn+x0ePRK7qkPlounJ7lpYrrtpO/x
	giJzDPZrPyZ1q3hZ2zS5vgsHs4v9k3csU6dqnsWCjWCsq4S+VWFrLxXRWZVD7cQmUSZLXspKEV7
	cR8K0SiI1hx0XHEdHT2aIi7fGwWL80hGg+Dy0S/6vHMxc1cY3Jy5liN24zmnPMawfH/eHa+lhZ3
	9+gPDoONei6WvYHlQ0EwPCPGC/eyF6Vm9sm5qTMR/1KJafF4iLehPdMuWceHV8OP8tRjd/Z3Tih
	9gbKE86ZywW8CIcFEVkYb8muZ3vfLgG6bg4CoE5OvKm9kgjeqbmy2cSCBseo5Ffxl+BkOCjqB8L
	x0QdEHDgm/VMqx/hvGkDWBxTkR
X-Received: by 2002:a17:903:3dc7:b0:2bc:b366:4731 with SMTP id d9443c01a7336-2bd275e3d35mr4111185ad.31.1778617098263;
        Tue, 12 May 2026 13:18:18 -0700 (PDT)
Received: from localhost ([2605:8d80:5c41:3a03:a42f:82d3:5b99:68bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4050dsm136912235ad.31.2026.05.12.13.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 16:18:16 -0400
Message-Id: <DIGZ521R07O0.21CT010M1703B@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>,
 <mattbobrowski@google.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [RESEND PATCH bpf-next 1/2] selftests/bpf: libarena: Add rbtree
 data structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260511214100.9487-2-emil@etsalapatis.com>
 <5c0b69fc93d31fa42e47ee102dfd9b88fbcc8c7d0431e617c02a0e5f27025d36@mail.kernel.org>
In-Reply-To: <5c0b69fc93d31fa42e47ee102dfd9b88fbcc8c7d0431e617c02a0e5f27025d36@mail.kernel.org>

On Mon May 11, 2026 at 6:24 PM EDT, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bp=
f.c b/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
>> new file mode 100644
>> index 000000000000..17d46c4af332
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
>> @@ -0,0 +1,974 @@
>
> [ ... ]
>
>> +SEC("syscall")
>> +__weak int test_rbtree_find_nonexistent(void)
>> +{
>> +	u64 key =3D 0xdeadbeef;
>> +	u64 value =3D 0;
>> +	int ret;
>> +
>> +	rbtree_t *rbtree;
>> +
>> +	rbtree =3D rb_create(RB_ALLOC, RB_DEFAULT);
>> +	if (!rbtree)
>> +		return 1;
>> +
>> +	/* Should return -EINVAL */
>> +	ret =3D rb_find(rbtree, key, &value);
>> +	if (!ret)
>> +		return 2;
>> +
>> +	return rb_destroy(rbtree);
>> +}
>
> The comment says rb_find should return -EINVAL when looking for a
> non-existent key in an empty tree, but looking at rb_find in
> rbtree.bpf.c:
>
> int rb_find(rbtree_t *rbtree, u64 key, u64 *value)
> {
>     rbnode_t *node;
>
>     if (unlikely(!rbtree))
>         return -EINVAL;
>
>     if (unlikely(!value))
>         return -EINVAL;
>
>     node =3D rbnode_find(rbtree->root, key, RBN_FIND_DFL);
>     if (!node || node->key !=3D key)
>         return -ENOENT;
>         ^^^^
>
> rb_find returns -EINVAL only when rbtree or value is NULL. For a valid
> rbtree with no matching node, rbnode_find returns NULL and rb_find
> returns -ENOENT. Should the comment say "Should return -ENOENT" instead?
>

Ack.

> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> new file mode 100644
>> index 000000000000..2ce2dfe5a223
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> @@ -0,0 +1,1032 @@
>
> [ ... ]
>
>> +static
>> +rbnode_t *rbnode_find(rbnode_t *subtree, u64 key, enum rbnode_find_mode=
 mode)
>> +{
>> +	rbnode_t *node =3D subtree;
>> +	int dir;
>> +
>> +	if (!subtree)
>> +		return NULL;
>> +
>> +	while (can_loop) {
>> +		/*
>> +		 * If we are not looking for the least upper bound,
>> +		 * we have found the only key. Otherwise keep going
>> +		 * until we find the "leftmost" instance of the key.
>> +		 */
>> +		if (mode =3D=3D RBN_FIND_DFL && node->key =3D=3D key)
>> +			break;
>> +
>> +		dir =3D (key <=3D node->key) ? 0 : 1;
>> +
>> +		if (!node->child[dir])
>> +			break;
>> +
>> +		/*
>> +		 * For least upper bound lookups, ensure that we
>> +		 * stop searching once we find the rightmost key.
>> +		 */
>> +		if (node->key =3D=3D key && node->child[dir]->key !=3D key)
>> +			break;
>> +
>> +		node =3D node->child[dir];
>> +	}
>> +
>> +	return node;
>> +}
>
> [ ... ]
>
>> +static
>> +int rb_node_insert(rbtree_t *rbtree __arg_arena, rbnode_t *node __arg_a=
rena)
>> +{
>> +	rbnode_t *grandparent, *parent =3D rbtree->root;
>> +	enum rbnode_find_mode mode;
>> +	u64 key =3D node->key;
>> +	rbnode_t *uncle;
>> +	int dir;
>> +	int ret;
>> +
>> +	if (unlikely(!rbtree))
>> +		return -EINVAL;
>> +
>> +	if (!parent) {
>> +		rbtree->root =3D node;
>> +		return 0;
>> +	}
>> +
>> +	mode =3D RBN_FIND_DFL;
>> +	/* Always find the first node with the key when allowing duplicates. *=
/
>> +	if (rbtree->insert =3D=3D RB_DUPLICATE)
>> +		mode =3D RBN_FIND_LUB;
>> +	parent =3D rbnode_find(parent, key, mode);
>> +
>> +	if (key =3D=3D parent->key && rbtree->insert !=3D RB_DUPLICATE) {
>> +		if (rbtree->insert =3D=3D RB_UPDATE) {
>> +			/*
>> +			 * Replace the old node with the new one.
>> +			 * Free up the old node.
>> +			 */
>> +			ret =3D rbnode_replace(rbtree, parent, node);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (rbtree->alloc =3D=3D RB_ALLOC)
>> +				rb_node_free(rbtree, parent);
>> +
>> +			return 0;
>> +		}
>> +
>> +		/* Otherwise it's RB_DEFAULT. */
>> +		return -EALREADY;
>> +	}
>> +
>> +	node->parent =3D parent;
>> +	/* Also works if key =3D=3D parent->key. */
>> +	if (key <=3D parent->key)
>> +		parent->left =3D node;
>> +	else
>> +		parent->right =3D node;
>
> Can this overwrite an existing left subtree in RB_DUPLICATE mode?
>
> When rbnode_find is called with RBN_FIND_LUB mode, it has a third break
> condition that stops the search when it finds a node with a matching key
> whose next-direction child has a different key:
>
> rbnode_find() {
>     ...
>     if (node->key =3D=3D key && node->child[dir]->key !=3D key)
>         break;
>     ...
> }
>
> With key =3D=3D node->key, dir is computed as (key <=3D node->key) ? 0 : =
1 =3D 0.
> The search stops at a matching node that has a non-NULL left child with a
> smaller key.
>
> Back in rb_node_insert, the code skips the RB_DEFAULT check when
> rbtree->insert =3D=3D RB_DUPLICATE, and falls through to:
>
>     node->parent =3D parent;
>     /* Also works if key =3D=3D parent->key. */
>     if (key <=3D parent->key)
>         parent->left =3D node;
>
> Since key =3D=3D parent->key, the condition is true and parent->left is
> overwritten with the new node. But parent->left already points to an
> existing subtree (the smaller node that triggered the third break
> condition). That existing left child is overwritten, orphaning its entire
> subtree.
>
> Reproduction:
>   1) rb_insert(rbtree, 5, v1) in RB_DUPLICATE mode -> tree: {5}
>   2) rb_insert(rbtree, 3, v2)                       -> tree: {5->left =3D=
 3}
>   3) rb_insert(rbtree, 5, v3)
>
> In step 3, rbnode_find returns the root node 5 via the third break
> condition (because child 3 has key !=3D 5). Then rb_node_insert sets
> parent->left =3D new_node, overwriting the pointer to node 3. Node 3 is n=
ow
> orphaned and leaked.
>
> The comment claims "Also works if key =3D=3D parent->key", but this only =
holds
> when rbnode_find returns a node with an empty left slot, as in the typica=
l
> duplicate-chain case where all keys are identical. As soon as a duplicate
> insertion meets a matching node that has a pre-existing smaller left chil=
d,
> the assignment corrupts the tree.
>
> The tree integrity check in rb_integrity_check walks only nodes reachable
> from the root, so it does not detect orphaned nodes. The existing test
> test_rbtree_duplicate uses a single key value for all insertions, so it
> never exercises the interleaved case where a smaller key exists between
> duplicates.
>

This is accurate. This is a bug introduced when refactoring the
least_upper_bound() and find() internal methods that were almost
identical. Will fix in the next iteration.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/256994=
61713

