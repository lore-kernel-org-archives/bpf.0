Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BD224F3
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104478; cv=none; b=fZ5zJuMR9LWoGwhzhv82f51jrFU4cqodMIPSbrBoip/v4wdryZLEIu1qqII5hcd5PzVK/AK6JH03owJK2ig26c5png5ajeSZOz38aX7UBDvt0775A+zfPpikdkVTts/FqHFt5ybVLPcL90zxMimeCZgFre43nA41xAdGbRTtTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104478; c=relaxed/simple;
	bh=hESPLYMxzIwvo9W4Q46txw7oO37GGgF2p8NhqHYBUFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQnCTYK3fER8Muc9xvr741qr5dByd5eWWgHTUunnvHcROkGoxywpDoBD4j4CpKqY91w/YB9sSfXp9q+ZqteFf2PlqNazOxwHYWcPqSdI2sAJHxfbKpeQiPJoKIUCOL0rHLN7Wt3STS91wuy4kdUxTO2dawkIDv2CjJolENFxoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuB6aOhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuB6aOhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B98C2BCB0;
	Wed,  6 May 2026 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104478;
	bh=hESPLYMxzIwvo9W4Q46txw7oO37GGgF2p8NhqHYBUFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SuB6aOhqp21pzCpZkn+EzsfjHyNef/4+HSgemCBMzFYePFMyaEpGf84QLMAkEK+TN
	 dBCY6CVnMSCnUJlJAje6rVy1rtg2Kevt0TNLbfhx7AqRco1Ug7Jv7xqP4EDslhTeh5
	 28Wzrc3CKC6Oe3N1MTYG1d6haEkWhO6WEpoK6JlKm6DFMyidN0w3LwJ7xECSSwfe0x
	 fzFc7oEhnWXJ0XOL7P8Rnvms4zANbRkZWY1zCw4EGMXqtDMM2XK0qgl5M2FFVjrBb7
	 56PczwhLBqjYkR/FmooKMxHNQUQW7zBN8FFwL7UumfC2FQPnQNl6MI7dBdt6ddG2D2
	 J0xKlV1lUNeiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
Reply-To: sashiko@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506142709.2298255-6-ameryhung@gmail.com>
References: <20260506142709.2298255-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:54:37 +0000
Message-Id: <20260506215438.45B98C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Dynptrs constructed from referenced objects are assigned a `pa=
rent_id` of 0, breaking cascading invalidation and leading to Use-After-Fre=
e.
--

commit 5c82adaba693d44fcc105cb9d8d86e76a67e2a64
Author: Amery Hung <ameryhung@gmail.com>

bpf: Refactor object relationship tracking and fix dynptr UAF bug

This commit refactors verifier object relationship tracking by replacing
the PTR_TO_MEM-specific dynptr_id with a general parent_id in bpf_reg_state.
It updates release_reference() to use a DFS approach for cascading
invalidation when parent objects are freed.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -11804,15 +11810,10 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>  				}
> =20
>  				dynptr_arg_type |=3D (unsigned int)get_dynptr_type_flag(parent_type);
>  			}
> =20
>  			ret =3D process_dynptr_func(env, reg, argno, insn_idx, dynptr_arg_typ=
e,
> -						  clone_ref_obj_id, &meta->dynptr);
> +						  meta->ref_obj_id ? meta->id : 0, &meta->dynptr);

Does this code assign 0 to the dynptr's parent_id instead of the actual
parent's ID?

For referenced objects acquired with PTR_MAYBE_NULL, the BPF program must
perform a NULL check before passing the pointer to the constructor. Upon a
successful NULL check, the verifier clears reg->id to 0 while preserving
reg->ref_obj_id.

Consequently, meta->id appears to be unconditionally 0 when the dynptr is
constructed here.

When the parent object is subsequently released, the DFS traversal in
release_reference() searches for descendants matching reg->parent_id =3D=3D=
 id.
Because the dynptr's parent_id was initialized to 0, does this cause the
dynptr to evade invalidation and remain fully active, leading to a
use-after-free regression?

Should this pass meta->ref_obj_id instead of meta->id?

>  			if (ret < 0)
>  				return ret;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506142709.2298=
255-1-ameryhung@gmail.com?part=3D5
