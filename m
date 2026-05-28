Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FF40245F
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992781; cv=none; b=WqkNlL1+kObCL72MzKgKg3pysvVtA8Tp3FYJemeERSr8YcQ2aXoFyO2jfqwIYF83c3Am3GXXChAmzjlcrBFR4KK/9X7Zs0tAcjfuOBTBtvZv7Zfkij9BDVl3ziIrtfcSj9NOy8ASQbdwNgvWF79ekWpdAY/eKhbbH1OWKs9ICNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992781; c=relaxed/simple;
	bh=QnZNGKivAqotYnG9nRwbcte6zZ0REN+coluNKavMuFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rG/R9v7dB9w9PHe2NM6+cduGR79Zqf8jpAcNFBwkSjD2kWNDrHGrMXPj+yvm9gAGmLvP7SY21bNe9ADIV7qPzybHt8+ztosJA3UvNBNxdwqPmdkFTxVHTuBolK0RQH83Er3hi9O0uWCr0Nu+HqX3vqsRr/1I10pjUaYaW9hgVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzBGSXaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzBGSXaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DED1F000E9;
	Thu, 28 May 2026 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992776;
	bh=LMoAWzVvKmSOH8AtD2Ld8HBpR9soRo7JHdGxQZkym0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzBGSXaRQvzEseImwnCAj+ishbKv1yL6tuqBYZTjr9I87jM2q/cOrI+WFBHOF8Nzt
	 ncojfKn19vIKG4cGUgmqd9VYKFYVY6+64uOFZjCD9nujbcVH+2zU+09mwFxzkcv1FV
	 EJc9LhfO0/Cy9ucKpEgDmYCxwAHDtdnfe1IwXZQQYr6EnZfePTF/wdTLxS3+wdSO7/
	 nI4uR801FpbGaSu+wX9iEbTljg3P3mn2LFpM+Nz0N85LcIQrgUdskixRbeAc7C7g9Q
	 f6c6tdI3AoOwQNqyGg/FvkEHxob+5yJCkHuOEaWp6gwIBitfwp6fcpbpjJ9PV3dkC6
	 J/OvhVvdEIvsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 02/11] rhashtable: Add selftest for
 rhashtable_next_key()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-rhash-v5-2-7205191b6c57@meta.com>
References: <20260528-rhash-v5-2-7205191b6c57@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:26:16 +0000
Message-Id: <20260528182616.65DED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest strictly enforces that exactly 'n' elements are vis=
ited, which violates the rhashtable_next_key() API contract and leads to sp=
urious test failures if concurrent rehashing occurs.
--

commit 764349a8abc231043942a78a0c94a8a3422ff178
Author: Mykyta Yatsenko <yatsenko@meta.com>

rhashtable: Add selftest for rhashtable_next_key()

This commit adds a selftest for rhashtable_next_key() to verify that walking
with a NULL prev_key visits all elements, and that providing a non-existing
prev_key returns ERR_PTR(-ENOENT).

> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> index 0b33559a910b0..c7a0817b0be59 100644
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c
[ ... ]
> @@ -679,6 +679,76 @@ static int threadfunc(void *data)
>  	return err;
>  }
> =20
> +static int __init test_rhashtable_next_key(void)
> +{
> +	struct rhashtable_params params =3D test_rht_params;
> +	struct test_obj_val key_missing =3D { .id =3D 99999, .tid =3D 0 };
> +	struct test_obj_val *prev_key =3D NULL;
> +	struct rhashtable ht;
> +	struct test_obj *objs, *cur;
> +	int i, count =3D 0, err;
> +	int visited_keys[8] =3D { 0 };
> +	const int n =3D ARRAY_SIZE(visited_keys);
> +
> +	err =3D rhashtable_init(&ht, &params);
> +	if (err)
> +		return err;
> +
> +	objs =3D kcalloc(n, sizeof(*objs), GFP_KERNEL);
> +	if (!objs) {
> +		rhashtable_destroy(&ht);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < n; i++) {
> +		objs[i].value.id =3D i;
> +		err =3D rhashtable_insert_fast(&ht, &objs[i].node, params);
> +		if (err)
> +			goto out;
> +	}
> +
> +	rcu_read_lock();
> +
> +	/* NULL prev_key: walk from the beginning, expect all n elements. */
> +	while ((cur =3D rhashtable_next_key(&ht, prev_key, params))) {
> +		if (IS_ERR(cur)) {
> +			err =3D -EINVAL;
> +			goto unlock;
> +		}
> +		count++;
> +		prev_key =3D &cur->value;
> +		visited_keys[cur->value.id] =3D 1;
> +		if (count > n)
> +			break;
> +	}
> +
> +	if (count !=3D n) {
> +		err =3D -EINVAL;
> +		goto unlock;
> +	}
> +
> +	for (i =3D 0; i < n; i++) {
> +		if (!visited_keys[i]) {
> +			err =3D -EINVAL;
> +			goto unlock;
> +		}
> +	}

[Severity: Medium]
Will this strict check cause spurious test failures during concurrent rehas=
hing?

The rhashtable_next_key() API documentation explicitly warns that its walk =
is
highly unstable during concurrent rehashing, stating that callers must
tolerate skipped and duplicated elements.

This test uses test_rht_params, which inherits its nelem_hint from the
user-provided size module parameter. If the test is executed with a small
initial size (e.g., size=3D4), inserting 8 elements will cross the 75%
threshold and trigger a background rehash by scheduling ht->run_work.

Because the test iterates over the keys immediately without waiting for this
background work to finish (e.g., via flush_work(&ht.run_work) or by locally
overriding nelem_hint to avoid resizing), the traversal can run concurrently
with the rehash. This could cause rhashtable_next_key() to legitimately
return duplicates or skip elements, causing the test to spuriously fail.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-rhash-v5-0=
-7205191b6c57@meta.com?part=3D2
