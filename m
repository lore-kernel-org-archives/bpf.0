Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA97394780
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118969; cv=none; b=AQaAYDzPifoRPpxPF0n1p7E2tDQze9Q2oAAZUToKGw0Fv52/W7VJ49Dh4DQku5pEMq98QNs+/a9bjXL72ltxjZ+hS0KcV1TlKi3fa6n5u+c3as8m3HQE6IDQYJSgNT4MM1Eb4E2uX/rl3O2dZ2Qr4PZdjyFsLjz6ml2z7UnVHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118969; c=relaxed/simple;
	bh=fV1T/5OnOelwEg7/hQD+o6NPUKNarA6zh3PABvSixFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BZAdlUJYwgTAflmZrvmm5Zsu0G58MdRBs4naIxfcKlwcXkm/y+Ld28MZtYKXFoRCS0qg9PVxzSOAF6Cgq3097MgmZ4fTLvlE3hRezX5Vj/ym+t+dw4se6ts4qu18+FRttwfHMv9RjAaIop9AeOgT7xQXW04R2DlsjaKogc8RT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=i2rKsraC; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="i2rKsraC"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2790122a91.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776118964; x=1776723764; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrF6bvEPCq2dzocj6dA7YHnnHGU4vDg6/SVLnb/EIEM=;
        b=i2rKsraChUsrL1CBJvwvUmmm1Uhx/vGt7AwVU0JIcpDaWcK0Xc87Ta1FumJ9xGT1V+
         +YNnoddPMSFZ/cbk5EsEttXbNlCxarhfevoa5WCtcUOqa5pd30E43EFZFRN13xTz95bN
         K7X32lWG1cZ8oWQNSgq7ScL6wuxBf1uHYTMI+JHTqRPFxpLVZ/r6DZ3HLuviMY0cDuaW
         qcdtnlLF8K1gDo4oFhLpwB155fVvfsZNrw89Sd1VI/uONXmjskCOyaq6KKDVEmR6kgHY
         1zFWTYwH8AtvSqZjwxsjlR/zgM8xuXR7kV1eZf6EOh3Fs6FSImYEt+xqcHWIRf/5zmYu
         O14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118964; x=1776723764;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrF6bvEPCq2dzocj6dA7YHnnHGU4vDg6/SVLnb/EIEM=;
        b=ey4UMrAhWcsOecC036Wz4zs/0WpV1PowiW7D7VkNOHk2RS7ZxnKzXuU89aj7NEqty+
         AaVOcZ7CSmd3eJX+AfIpg1NAgih97OyD98hBVXKSTjZqxuwWgyq7SA0pGnTEYiSuOfZU
         eqDDE8xA6YR0JjIubl99p3LtBVtRh2ZcEtr1WoTciqg1mN1cI/JIQq9dHWbGoWnp9Pjx
         Ao+Jt5gdVb2Gvt2g2yrFxEki5oDy+nwuYfmHlY9fT6nJponlFfEgl7qgyP1Xb62Okfzx
         IFOowCndgT1XnEESExYeMV2OEGc1MXWaL8oLU7DXOS8sWZPX32d2KUnQyAwbk49+cWX/
         nUzw==
X-Forwarded-Encrypted: i=1; AFNElJ8aXT3zy8k2EILtFdgnlMIypw+kSmeShvSUJTtolE3KD9547zUGsbUK3O+osZc32MJhbmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ05DU9IdkE4MyB2j3nYwqVotbIBV2QRcQStMdYw5EkB/7VUio
	Hk8ZeBGWvNbgUJS7NBCb0IFY0s/HzELIUWiLCe6RBfoEnFtF73RSRakT2Ely9OaapUo=
X-Gm-Gg: AeBDievm4smrMns5mIIKPKlNNaypdaCwwyEyZhmK9ZTRQNLCUquAZtZDSMiHIZnKpFy
	aaVYURA8+ssDG04lmb5kBrLeBd63sJJ7GOwvqdrf1b8fNSS8p68sFy2FtcVRk7d/Y+o7pmEd1Lt
	oOFRvlPVTZ7w99kGnxb2c5eN2H9dqmbyLdBON8IR5FFNSWjrGtc0rp/8W0D4z+8Dc7y7gc15q3o
	7xWqqXKE0zDBrd9GialYOVJKFc9L7+MNISo+sTqroMGjGUnchlaUwhjDVIWmCgDdfXWWki2whtu
	k+yDOS5zSwCrKJjI0MTI7iSR0A5Mxpk8FIJksYXahcoqH4YgQiyKG+zs8T64t2GDS+k8ieKUEeJ
	9RxwFdLLETcdInKEi8E6RPSCVGi3FRgDDDvEwyyzPfIvL6SkHcmUm1JeuEYuvjF/aRFgowx3ey2
	OZ+qOB3rT5w1rBwrCnSw==
X-Received: by 2002:a17:90b:4d0e:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35e4254fa24mr14343358a91.2.1776118963531;
        Mon, 13 Apr 2026 15:22:43 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb268dc63sm5953185a91.14.2026.04.13.15.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 15:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 18:22:42 -0400
Message-Id: <DHSDMJ8CY09A.30D3JJMR1B945@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 04/18] rhashtable: Add
 rhashtable_walk_enter_from()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <kafai@meta.com>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-4-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-4-3b3675da1f6e@meta.com>

On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> BPF resizable hashmap needs efficient iteration resume for
> get_next_key and seq_file iterators. rhashtable_walk_enter()
> always starts from bucket 0, forcing linear skip of already-seen
> elements.
>
> Add rhashtable_walk_enter_from() that looks up the key's bucket
> and positions the walker there, so walk_next returns the successor
> directly. If a resize moved the key to the future table, the
> walker is migrated to that table.
>
> Refactor __rhashtable_lookup into __rhashtable_lookup_one to reuse
> the single-table lookup in both the two-table search and the new
> enter_from positioning.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Provided tests are updated:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/linux/rhashtable.h |  31 ++++++++++--
>  lib/rhashtable.c           |  53 ++++++++++++++++++++
>  lib/test_rhashtable.c      | 120 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 199 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index 133ccb39137a..2c7a343ac592 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -253,6 +253,11 @@ static inline void rhashtable_walk_start(struct rhas=
htable_iter *iter)
>  	(void)rhashtable_walk_start_check(iter);
>  }
> =20
> +void rhashtable_walk_enter_from(struct rhashtable *ht,
> +				struct rhashtable_iter *iter,
> +				const void *key,
> +				const struct rhashtable_params params);
> +
>  void *rhashtable_walk_next(struct rhashtable_iter *iter);
>  void *rhashtable_walk_peek(struct rhashtable_iter *iter);
>  void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases_share=
d(RCU);
> @@ -613,8 +618,8 @@ static inline int rhashtable_compare(struct rhashtabl=
e_compare_arg *arg,
>  }
> =20
>  /* Internal function, do not use. */
> -static __always_inline struct rhash_head *__rhashtable_lookup(
> -	struct rhashtable *ht, const void *key,
> +static __always_inline struct rhash_head *__rhashtable_lookup_one(
> +	struct rhashtable *ht, struct bucket_table *tbl, const void *key,
>  	const struct rhashtable_params params,
>  	const enum rht_lookup_freq freq)
>  	__must_hold_shared(RCU)
> @@ -624,13 +629,10 @@ static __always_inline struct rhash_head *__rhashta=
ble_lookup(
>  		.key =3D key,
>  	};
>  	struct rhash_lock_head __rcu *const *bkt;
> -	struct bucket_table *tbl;
>  	struct rhash_head *he;
>  	unsigned int hash;
> =20
>  	BUILD_BUG_ON(!__builtin_constant_p(freq));
> -	tbl =3D rht_dereference_rcu(ht->tbl, ht);
> -restart:
>  	hash =3D rht_key_hashfn(ht, tbl, key, params);
>  	bkt =3D rht_bucket(tbl, hash);
>  	do {
> @@ -646,6 +648,25 @@ static __always_inline struct rhash_head *__rhashtab=
le_lookup(
>  		 */
>  	} while (he !=3D RHT_NULLS_MARKER(bkt));
> =20
> +	return NULL;
> +}
> +
> +/* Internal function, do not use. */
> +static __always_inline struct rhash_head *__rhashtable_lookup(
> +	struct rhashtable *ht, const void *key,
> +	const struct rhashtable_params params,
> +	const enum rht_lookup_freq freq)
> +	__must_hold_shared(RCU)
> +{
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	tbl =3D rht_dereference_rcu(ht->tbl, ht);
> +restart:
> +	he =3D __rhashtable_lookup_one(ht, tbl, key, params, freq);
> +	if (he)
> +		return he;
> +
>  	/* Ensure we see any new tables. */
>  	smp_rmb();
> =20
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 6074ed5f66f3..2fc277207dcc 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -692,6 +692,59 @@ void rhashtable_walk_enter(struct rhashtable *ht, st=
ruct rhashtable_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(rhashtable_walk_enter);
> =20
> +/**
> + * rhashtable_walk_enter_from - Initialise a walk starting at a key's bu=
cket
> + * @ht:		Table to walk over
> + * @iter:	Hash table iterator
> + * @key:	Key whose bucket to start from
> + * @params:	Hash table parameters
> + *
> + * Like rhashtable_walk_enter(), but positions the iterator at the bucke=
t
> + * containing @key. If a resize is in progress and @key has been migrate=
d
> + * to the future table, the walker is moved to that table.
> + *
> + * Same constraints as rhashtable_walk_enter() apply.
> + */
> +void rhashtable_walk_enter_from(struct rhashtable *ht,
> +				struct rhashtable_iter *iter,
> +				const void *key,
> +				const struct rhashtable_params params)
> +				__must_hold(RCU)
> +{
> +	struct bucket_table *tbl;
> +	struct rhash_head *he;
> +
> +	rhashtable_walk_enter(ht, iter);
> +
> +	if (!key)
> +		return;
> +
> +	tbl =3D rht_dereference_rcu(ht->tbl, ht);
> +	he =3D __rhashtable_lookup_one(ht, tbl, key, params,
> +				     RHT_LOOKUP_NORMAL);
> +	if (!he) {
> +		smp_rmb();
> +		tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
> +		if (!tbl)
> +			return;
> +
> +		he =3D __rhashtable_lookup_one(ht, tbl, key, params,
> +					     RHT_LOOKUP_NORMAL);
> +		if (!he)
> +			return;
> +
> +		spin_lock(&ht->lock);
> +		list_del(&iter->walker.list);
> +		iter->walker.tbl =3D tbl;
> +		list_add(&iter->walker.list, &tbl->walkers);
> +		spin_unlock(&ht->lock);
> +	}
> +
> +	iter->slot =3D rht_key_hashfn(ht, tbl, key, params);
> +	iter->p =3D he;
> +}
> +EXPORT_SYMBOL_GPL(rhashtable_walk_enter_from);
> +
>  /**
>   * rhashtable_walk_exit - Free an iterator
>   * @iter:	Hash table Iterator
> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> index 0b33559a910b..0084157a96b4 100644
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c
> @@ -23,6 +23,7 @@
>  #include <linux/random.h>
>  #include <linux/vmalloc.h>
>  #include <linux/wait.h>
> +#include <linux/cleanup.h>
> =20
>  #define MAX_ENTRIES	1000000
>  #define TEST_INSERT_FAIL INT_MAX
> @@ -679,6 +680,122 @@ static int threadfunc(void *data)
>  	return err;
>  }
> =20
> +static int __init test_walk_enter_from(void)
> +{
> +	struct rhashtable ht;
> +	struct test_obj objs[4];
> +	struct rhashtable_iter iter;
> +	struct test_obj *obj;
> +	int err, i;
> +
> +	err =3D rhashtable_init(&ht, &test_rht_params);
> +	if (err)
> +		return err;
> +
> +	/* Insert 4 elements with keys 0, 2, 4, 6 */
> +	for (i =3D 0; i < 4; i++) {
> +		objs[i].value.id =3D i * 2;
> +		objs[i].value.tid =3D 0;
> +		err =3D rhashtable_insert_fast(&ht, &objs[i].node,
> +					     test_rht_params);
> +		if (err) {
> +			pr_warn("walk_enter_from: insert %d failed: %d\n",
> +				i, err);
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * Test 1: walk_enter_from positions at key, walk_next returns
> +	 * the successor (not the key itself).
> +	 */
> +	for (i =3D 0; i < 4; i++) {
> +		struct test_obj_val key =3D { .id =3D i * 2 };
> +
> +		scoped_guard(rcu) {
> +			rhashtable_walk_enter_from(&ht, &iter, &key,
> +						   test_rht_params);
> +			rhashtable_walk_start(&iter);
> +		}
> +
> +		obj =3D rhashtable_walk_next(&iter);
> +		while (IS_ERR(obj) && PTR_ERR(obj) =3D=3D -EAGAIN)
> +			obj =3D rhashtable_walk_next(&iter);
> +
> +		/* Successor must not be the key itself */
> +		if (obj && obj->value.id =3D=3D i * 2) {
> +			pr_warn("walk_enter_from: returned key %d instead of successor\n",
> +				i * 2);
> +			err =3D -EINVAL;
> +			rhashtable_walk_stop(&iter);
> +			rhashtable_walk_exit(&iter);
> +			goto out;
> +		}
> +
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +	}
> +
> +	/* Test 2: walk_enter_from with non-existent key starts from bucket */
> +	{
> +		struct test_obj_val key =3D { .id =3D 99 };
> +
> +		scoped_guard(rcu) {
> +			rhashtable_walk_enter_from(&ht, &iter, &key,
> +						   test_rht_params);
> +			rhashtable_walk_start(&iter);
> +		}
> +
> +		obj =3D rhashtable_walk_next(&iter);
> +		while (IS_ERR(obj) && PTR_ERR(obj) =3D=3D -EAGAIN)
> +			obj =3D rhashtable_walk_next(&iter);
> +
> +		/* Should still return some element (iteration from bucket start) */
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +	}
> +
> +	/* Test 3: verify walk_enter_from + walk_next can iterate remaining ele=
ments */
> +	{
> +		struct test_obj_val key =3D { .id =3D 0 };
> +		int count =3D 0;
> +
> +		scoped_guard(rcu) {
> +			rhashtable_walk_enter_from(&ht, &iter, &key,
> +						   test_rht_params);
> +			rhashtable_walk_start(&iter);
> +		}
> +
> +		while ((obj =3D rhashtable_walk_next(&iter))) {
> +			if (IS_ERR(obj)) {
> +				if (PTR_ERR(obj) =3D=3D -EAGAIN)
> +					continue;
> +				break;
> +			}
> +			count++;
> +		}
> +
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +
> +		/*
> +		 * Should see at least some elements after key 0.
> +		 * Exact count depends on hash distribution.
> +		 */
> +		if (count =3D=3D 0) {
> +			pr_warn("walk_enter_from: no elements found after key 0\n");
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	pr_info("walk_enter_from: all tests passed\n");
> +	err =3D 0;
> +out:
> +	rhashtable_destroy(&ht);
> +	return err;
> +}
> +
>  static int __init test_rht_init(void)
>  {
>  	unsigned int entries;
> @@ -738,6 +855,9 @@ static int __init test_rht_init(void)
> =20
>  	test_insert_duplicates_run();
> =20
> +	pr_info("Testing walk_enter_from: %s\n",
> +		test_walk_enter_from() =3D=3D 0 ? "pass" : "FAIL");
> +
>  	if (!tcount)
>  		return 0;
> =20

