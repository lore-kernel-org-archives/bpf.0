Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606829;
	b=FknHyga0dZTkWlHtLk4LDp7WOLEIM7KoK5OolqDNqFjEO2Qm+iuqlYp4IFZ8GjuSPsMZ
	 1k9XQBJQ1TXRucQFmNH2xa1Zy9Lx5g8t2EkQS5qVdmSRn2ERhmsbZI3wYv63FITomeL8s
	 LJzk3sTA5ocBGHcUA0CcL9/oWaZoucqj448Ux4RGYE4+I2G+rY3S/ldl8yoZFr+QGZp21
	 Sh/S946w61HXuEnGb7oDg6Ad5LULjMbaCevchKTG6XCU9bSMVST6VFe+t7t+2hytJd1DD
	 7x5x3e6pLP80lyuPKEH1PIHyfX8U5TAjYDEvUpBMkqSLnBmsja1b82gD9LhCk5itebg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ZFKEz2Iu0aOPt9Nq3i/pKYGCNKHVigLA2BmD6KDbRRo=;
	b=mPk1mU6z5Dr/GU/9G+XNvCmYFsKtj/AYuXCl5BUUbsz5a7W4z2PLY+v8SBLC0DySEIh0
	 Ma9ZKUzn0Q3cXrNjJct7fF20EAz/S7a9KjngAvImu0/eWXATb55ZDwPCag5ckIzJRvoWW
	 C2Kb5wXS+7ivJjo9mLmxa+91qYSjE9PByLzS+I8Xx8m6MxK72RSUOTyqzYMRGu5XLVblj
	 FpbRapla5x7zXQTd8wdq6tOdPvMDqoGE2g8db22LOJ+dFf7HWqr6TK3VYt/Aq4MHcgtca
	 y+HTZLMbrocIxprN8zBY/hUh+H7cMj5vPTo9ojHEC4+KMsYWbdar5oPxVpIZZjLa7MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=oYOQJQwo;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80F606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD80F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=oYOQJQwo
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e96502e447so24922015ad.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793606828; x=1794211628; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFKEz2Iu0aOPt9Nq3i/pKYGCNKHVigLA2BmD6KDbRRo=;
        b=oYOQJQwoCDvsXxt2wNBL0Qu4ZX7aOeuq5MtfITPE1td7BT+iegjg9OjLdxBT/HisCV
         q8rqC54AX7s6PfNUe1eERfL9dfJrtAP1S+7wTT6DSc2DdMkhjAJbYesWgoQABQMkl1iH
         TsA80djQxuoZchaxQNp2eToC+qtWu9DHtFvlmY4ILdtFH5d2zEYJoijiIwC2Co7/iFXF
         jXV2HvbJZqC5kATgAWvJhsutbCGf258UBq9uA65fdjIIf+b1wMhtGBnptXqV+fYuFZqy
         xc/emEngGzDn7fHG2e1nzK8/7uxztaoTiGmxEvZeckvFcsJTRs96+2sb2WM58mZhfQol
         cZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606828; x=1794211628;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFKEz2Iu0aOPt9Nq3i/pKYGCNKHVigLA2BmD6KDbRRo=;
        b=vVtvZiupU+KKY0Dj9MAHB9fPW+N/iTNR6ixOsQhc8544u5BbD79hsJwjzQe76xnjeg
         0XkwjQCD65wPfcjB4R0LN0Eceev0cUsB0GcTDukTS6OLKTgYf/iT3K/D8H+OxWmMY1YP
         yBiV6dYAuDhVpshuEu05faejwFfUWKi/zGcgodTMgvpRFq8GfXgTd7TmZUwD5q2g6tzh
         6S3rCXPTJNeQAxJrx7yIZeCBs+lf0FqpbBH7gLlEEZOyn/fnR39BXy5rOLq23Yot+aqt
         MtabNRzPWVZqQpqtb5PLhc1Z1HispHXer2DGVLmWXK17V75DfnZhVu6qqGgaVo2DZJtz
         g+kg==
X-Forwarded-Encrypted: i=1; AKwUvBxa+1MzR+hsSKcP/kES0T012kS3Xa48Q+7IZCu/cF4r8gkSIHB2irL/jCzrLv8/vu/3dyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OQkvTRXZvA0g58wayoNsHrIIG334Mcv88/MLaWzT43mzKHvke
	FfUcC17rWAKyMOGc4VxmeluYBRQq9LaoDJr0KmbFRH4Jkkk+qakh0Bg1jmv+fGXeVXY=
X-Gm-Gg: AYBFou3tOoMay1Zb5+EDoC102h2KDYA7yn93mJHRV/DrhZbPHLjGbJX7/L3xZBrig/b
	fggsKh6FRK1EnpISHB/bjDe22g/gX5mXyuZVwOcsyYZdTBAvauzBLrI+WA8228zdmsWzSQ/wJZi
	MzYW8eFreqMuV+4XwDdbxXm5MqCxWdgRQRZWcyVkAKurTbCUNTem3Wyt/kgkmZteofuzR87lNP8
	MHG8sMFx5t4v/6i02hRmiq7BpqpM7uVheOso6XVWeOKRTh1sUAi6MOPjuNQKKUl/aFUWty566Ki
	7B9zWUYxSGSxSTCc9lvMQ5yyYdohutYjazGSaBHkUt0Y60vOBWtb+nMOQepzO1EprfdAbXppAL2
	9Lm6IMZ+Exu5xAa5iKQI6k2C66en/sm8YnJtawPabcHM0gMP4J/Zgbzuanyhdaf7sy8Ua1cxKFr
	hezQvXAKvdcjdRfLEpz9jStNBrg4IeStGOplQ/tklb0nEG6tAQ7sgQw9A/Sh5ZmA6XYt49V4zp5
	slRB/Sa6UMsMONcGZwwIwljzqX8mXaU1zmE/R8xT32Bb6ZQAGvVaptEwCsIPso7lCzdTGovNvu+
	QW99FCD0YO3F282z4F0vc0op0+GMH16cKmJKkrhDtP7856LgnVQJxmcjN/2o9tzE5SkNuriFinP
	kQd68
X-Received: by 2002:a17:902:eccb:b0:2e5:d2b1:c70b with SMTP id d9443c01a7336-2eb36536d3amr90256725ad.60.1793606827873;
        Mon, 02 Nov 2026 00:07:07 -0800 (PST)
Received: from localhost (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39265090sm23623165ad.41.2026.11.02.00.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 00:07:07 -0800 (PST)
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
Date: Mon, 02 Nov 2026 08:07:06 +0000
Message-Id: <DMKKK0ZLYSKU.3UZ614ZC9DH05@etsalapatis.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <david.dai@linux.dev>, "Gavin
 Guo" <gavinguo@igalia.com>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: libarena: Add rb_next()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Changwoo Min" <changwoo@igalia.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0
References: <20261028060046.549097-1-changwoo@igalia.com>
 <20261028060046.549097-4-changwoo@igalia.com>
In-Reply-To: <20261028060046.549097-4-changwoo@igalia.com>

On Wed Oct 28, 2026 at 6:00 AM UTC, Changwoo Min wrote:
> Add rb_next(), the in-order successor through parent pointers.
>
> Add a selftest that walks a tree with repeated keys and checks the walk
> against the order in which the head leaves the tree.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../bpf/libarena/include/libarena/rbtree.h    | 23 ++++++++
>  .../bpf/libarena/selftests/test_rbtree.bpf.c  | 54 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> index a8dd8c2e7596..956b4a24b52a 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/rbtree.h
> @@ -103,6 +103,29 @@ void rb_node_free(struct rbnode __arena *rbnode);
> =20
>  int rb_integrity_check(struct rbtree __arena *rbtree);
> =20
> +/*
> + * Return the in-order successor of @node, or NULL if @node is the last =
one.
> + * Walking from rb_first() with it visits the tree in key order, equal k=
eys in
> + * insertion order. Call it under the writer's lock.
> + */

Let's move this to the main *.bpf.c file, with the rest of the traversal fu=
nctions.

> +static __always_inline struct rbnode __arena *rb_next(struct rbnode __ar=
ena *node)
> +{
> +	struct rbnode __arena *parent;
> +
> +	if (node->right) {
> +		node =3D node->right;
> +		while (node->left && can_loop)
> +			node =3D node->left;
> +		return node;
> +	}
> +
> +	/* Climb until we leave a left subtree; its parent comes next. */
> +	while ((parent =3D node->parent) && node =3D=3D parent->right && can_lo=
op)
> +		node =3D parent;
> +
> +	return parent;
> +}
> +
>  /*
>   * Lockless reads of the head and the node count. They need not be calle=
d
>   * under the writer's lock, so they are advisory: the tree may change be=
fore
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> index 57c4395c046a..784cc9edea17 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> @@ -425,6 +425,60 @@ __weak int test_rbtree_first_update(void)
>  	return rb_destroy(rbtree);
>  }
> =20
> +#define NEXT_NR_NODES	64
> +
> +static struct rbnode __arena *next_nodes[NEXT_NR_NODES];
> +
> +SEC("syscall")
> +__weak int test_rbtree_next(void)
> +{
> +	struct rbtree __arena *rbtree;
> +	struct rbnode __arena *node;
> +	u64 seed =3D 0xcafe;
> +	int i;
> +
> +	rbtree =3D rb_create(RB_NOALLOC, RB_DUPLICATE);
> +	if (!rbtree)
> +		return 1;
> +
> +	/* Pseudo-random keys with repeats, so the walk crosses equal keys. */
> +	for (i =3D 0; i < NEXT_NR_NODES && can_loop; i++) {
> +		/* LCG using Knuth's MMIX constants for determinism. */
> +		seed =3D seed * 6364136223846793005ULL + 1442695040888963407ULL;
> +		node =3D rb_node_alloc((seed >> 33) % 16, i);
> +		if (!node)
> +			return 2;
> +
> +		if (rb_insert_node(rbtree, node))
> +			return 3;
> +	}
> +
> +	node =3D rb_first(rbtree);
> +	for (i =3D 0; i < NEXT_NR_NODES && can_loop; i++) {
> +		if (!node)
> +			return 4;
> +
> +		next_nodes[i] =3D node;
> +		node =3D rb_next(node);
> +	}
> +
> +	if (node)
> +		return 5;
> +
> +	for (i =3D 0; i < NEXT_NR_NODES && can_loop; i++) {
> +		node =3D rb_first(rbtree);
> +		if (node !=3D next_nodes[i])
> +			return 6;
> +
> +		if (rb_remove_node(rbtree, node))
> +			return 7;
> +
> +		rb_node_free(node);
> +	}
> +
> +	return rb_destroy(rbtree);
> +}
> +
>  struct rb_embed {
>  	u64 pad;
>  	struct rbtree tree;

