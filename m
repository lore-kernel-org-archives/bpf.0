Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC42D7398
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536150; cv=none; b=jEsE6ph1PSZWkJ1njDvQY9TWBatbS4SPYlgL3P8NkUpJRokDBbnQ0hlAKy7MX0LRej7oRBlbXuLwV19Qfc2wJnncPVte5n7VQt1Rb7Z9SX+/dulV290c3ts53TvhUlE1dHvoJ1dSsUOm+DLfE2J4cfYiW01Cy8pDILmTsGsUDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536150; c=relaxed/simple;
	bh=Dp9L7YKBd5hM867/AOWStMAMAlSqYqDWDF8e4LUUWcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A252H44m4wndi4QB9bg1sem/mJhxs+gYAD32NLWTHilmW0Vn+fXk/P77AUMUqJRKNugWIFGU88jWIfNdbxuroMJ2OD8E5ToBe4A0fXM8DMndfosa0O+5Mq7IBU9LvElLdbCo9Dkn8A5+5CFhiMBq6tBoAw6/Bi6kQtV+oydzsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDN0pLdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDN0pLdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE9F1F000FF;
	Wed, 16 Sep 2026 05:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789536149;
	bh=1NOXKbxmLlXyJtKGoeVAAsq0i3mbf7rO7JPYUIHmne0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDN0pLdVq6oZIO7NahmNhdYJNd2gCY15e0jxM6qjG+cjLxJHgGnNn8S0na1iMnBCA
	 BKNirGFSHkeqju+gHeI6TCSxkIALjXSaNzlb/j4aF3kIfuGc77LH6/pqlEjI2hENv/
	 m2TOvAn3JNK8jbESau9/6hAb+XIyP5Yv73hbw+XC5W5W86SBemN4UsoXzMMf5vdXZr
	 +FXjuIG6UPnO87TREkXDMgBpxFNO0TIsqW3jzUotxVCgK9e00S3Yw5R5dGqWVJ8rhO
	 33IoBkUnmfstqrUoi9iiPiSOGSyV9O/Bf7QsHus4cazYjTPeLsBdLdEdZoHCPjtjyd
	 DE5rtCZMEmbmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 09/11] bpf: Track whether dynptr type is known
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916050830.8774-10-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-10-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:22:28 +0000
Message-Id: <20260916052228.CFE9F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing type_unknown check in stacksafe() allows unsafe pruni=
ng
--

commit 8f00e7cb51fcf9e4513f3c3e9be943021ba739cf
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Track whether dynptr type is known

This commit adds a type_unknown field to struct bpf_reg_state's dynptr
state to distinguish locally created dynptrs from global subprog arguments.
It updates the verifier to set this flag, preparing for proper invalidation
of unknown dynptrs in subsequent commits.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d5b4ab0bacd35..76aa724de1bcb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -71,6 +71,7 @@ struct bpf_reg_state {
>  		/* For dynptr stack slots */
>  		struct {
>  			enum bpf_dynptr_type type;
> +			bool type_unknown;

[Severity: High]
Does this new field also need to be checked in stacksafe() when comparing
states?

Looking at stacksafe() in kernel/bpf/states.c, the STACK_DYNPTR case compar=
es
type, first_slot, id, and parent_id, but it omits the new type_unknown fiel=
d:

kernel/bpf/states.c:stacksafe() {
    ...
		case STACK_DYNPTR:
			old_reg =3D &old->stack[spi].spilled_ptr;
			cur_reg =3D &cur->stack[spi].spilled_ptr;
			if (old_reg->dynptr.type !=3D cur_reg->dynptr.type ||
			    old_reg->dynptr.first_slot !=3D cur_reg->dynptr.first_slot ||
			    !check_ids(old_reg->id, cur_reg->id, idmap) ||
			    !check_ids(old_reg->parent_id, cur_reg->parent_id, idmap))
				return false;
			break;
    ...
}

If a BPF program conditionally spills a locally created dynptr
(type_unknown=3Dfalse) or an unknown argument dynptr (type_unknown=3Dtrue) =
to
the same stack slot, could the verifier incorrectly treat the states as
equivalent and prune the unknown dynptr path? This might allow bypassing
the packet pointer invalidation logic when writing to unknown dynptrs,
potentially leading to a use-after-free of packet pointers.

>  			/* A dynptr is 16 bytes so it takes up 2 stack slots.
>  			 * We need to track which slot is the first slot
>  			 * to protect against cases where the user may try to

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916050830.8774=
-1-emil@etsalapatis.com?part=3D9
