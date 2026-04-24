Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E434B693
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061736; cv=none; b=IoXOE/ATTrAscf3CMkj+HZdTF2lM/5NuhsQ/XFdP/R3ao9W8BVrloVaU7Y4cPcIEKMd4BkzCQnJN05dVJveVgZR4Ia/Td0c1KApDXNbVFyiWQnJIPSbi6N+AR5q5MeoyUMIJyFCvnj/ydC/9dpQIOi2Fl6fnGdexNlnlncwrVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061736; c=relaxed/simple;
	bh=bbneQzRHxK03QeL4sOXKd6dTAwMPlUkAVo3DKccR4iY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oW+Wuae1pDcagvE+qgGy0aZypyOtWqN0pWcoHJHJUgGJzo2y7cyYMo2iAi+lKosIfy08z73edxfa+8abxJi9cNlnph6lCjCN9UVSfyuQL0c/eM74BZzb9Y9fGwwRW2Dr93HSU9/2K10gapyDOEzpptab663pcBOh+/77jegairU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si2tmRQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si2tmRQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1BCC19425;
	Fri, 24 Apr 2026 20:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777061736;
	bh=bbneQzRHxK03QeL4sOXKd6dTAwMPlUkAVo3DKccR4iY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Si2tmRQM2am7RB+PAFHcSS8Z9D0ROy81npottoKgwMiEljqWJYXmX7vwps6iyRnhe
	 zNUfREerb+zMjLMqrls6BT6pYeHhQ+UkFoa0MCo83VTEXaroPo0H8TJmJNoNbEjE3H
	 jrdCFOZtYm4yZiWBqi7TwyrsVFbGWDiq/qMPSRf8MYI5DELnkE4kJfDsc112eW1pgg
	 vzi8fdQrg0ptAziMhdyrHxQQCmu9Ly+vFd5teV6xAHSXj26qb2VQK27y3Ai0UuiTkg
	 uZJwEFbife6lslYznAhLMdi69rvpzMeQPPgXqr7Xn31prNM4586ftvsGdq21aSBFbw
	 mncRqrc54PWdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 02/10] rhashtable: Add
 rhashtable_walk_enter_from()
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-2-d0fa0ce4379b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 20:15:35 +0000
Message-Id: <20260424201535.EA1BCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] `rhashtable_walk_enter_from()` ignores `future_tbl` during resizes=
, causing stateless iterators to infinite loop.
- [High] `rhashtable_walk_enter_from()` fails to initialize `iter->list` fo=
r `rhltable`s, causing an uninitialized memory read and breaking iteration.
- [Medium] In `test_walk_enter_from()`, an error path jumps to `out` withou=
t setting the `err` variable, causing a silent test failure.
--

commit 63530ac8c42e3a9716786a83ad797edaae556017
Author: Mykyta Yatsenko <yatsenko@meta.com>

rhashtable: Add rhashtable_walk_enter_from()

This commit introduces rhashtable_walk_enter_from() to allow efficient
iteration resume by positioning the walker at the bucket containing the
given key. It also refactors the internal lookup functions and adds
test cases.

> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c

[ ... ]

> @@ -692,6 +692,47 @@ void rhashtable_walk_enter(struct rhashtable *ht, st=
ruct rhashtable_iter *iter)
>  }
>  EXPORT_SYMBOL_GPL(rhashtable_walk_enter);
> =20
> +/**
> + * rhashtable_walk_enter_from - Initialise a walk starting at a key's bu=
cket
[ ... ]
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
> +	tbl =3D iter->walker.tbl;
> +	if (!tbl)
> +		return;
> +
> +	he =3D __rhashtable_lookup_one(ht, tbl, key, params,
> +				     RHT_LOOKUP_NORMAL);
> +	if (!he)
> +		return;

What happens if the table is currently resizing and the key has already been
moved to the future table?

If __rhashtable_lookup_one() fails to find the key in the current table, it
leaves the iterator positioned at bucket 0.

For stateless iterators like BPF's get_next_key, could this cause an
infinite loop where it constantly resets to the beginning of the old table
until the resize completes?

> +
> +	iter->slot =3D rht_key_hashfn(ht, tbl, key, params);
> +	iter->p =3D he;

Does this leave iter->list uninitialized for rhlist tables?

rhashtable_walk_enter() does not initialize iter->list. When
rhashtable_walk_start_check() is called for an rhlist table, it validates
the element using:

lib/rhashtable.c:rhashtable_walk_start_check() {
    ...
    } else if (iter->p && rhlist) {
        ...
                if (list =3D=3D iter->list) {
                    iter->p =3D p;
                    iter->skip =3D skip;
                    goto found;
                }
    ...
}

Will this uninitialized read of iter->list cause the validation to fail
and silently fall back to the beginning of the bucket?

> +}
> +EXPORT_SYMBOL_GPL(rhashtable_walk_enter_from);

[ ... ]

> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c

[ ... ]

> @@ -679,6 +680,133 @@ static int threadfunc(void *data)
>  	return err;
>  }
> =20
> +static int __init test_walk_enter_from(void)
> +{

[ ... ]

> +		/* Count the number of elements after this one */
> +		do {
> +			obj =3D rhashtable_walk_next(&iter);
> +			count++;
> +		} while (obj && (!IS_ERR(obj) || (PTR_ERR(obj) =3D=3D -EAGAIN)));
> +
> +		rhashtable_walk_stop(&iter);
> +		rhashtable_walk_exit(&iter);
> +		if (count > 4) {
> +			pr_warn("walk_enter_from: walked %d elements instead of max 4\n", cou=
nt);
> +			goto out;
> +		}

Does this error path need to set the err variable?

Right now it jumps to out and returns 0, which might cause the test suite
to silently miss the failure.

> +		/*
> +		 * Collect the lengths of every walked path,
> +		 * we should have each length walked one time
> +		 */
> +		len_freq[count - 1]++;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-rhash-v3-0=
-d0fa0ce4379b@meta.com?part=3D2
