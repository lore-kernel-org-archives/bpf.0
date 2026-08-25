Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BED3D75DE
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695192; cv=none; b=Fk1nNOWzio/3eCCzs8xgbWR13sUB0g5HwkPLNgsz9ZgWVE2y5jgayPilwUpdZO55YQmOHvVuxOfWzW7z53JjY92RVEoLPWpSNsRQtSe34LaeUj7ReUlPY2Eibo1b66msssQlzyipoZJmM9JXTHwsgusxy2cI6wnp9DkXnf0O/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695192; c=relaxed/simple;
	bh=Ie+1vRbE3FsgL3+m1fJyfg7Oh+2hUVrru7lMLER3pMI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QP5lNh8eER70hPKpWwEQkVvXjRy0rN971Jei9biKvpUnCZp88cqNdMwQBMqqnapZXb/a4BFmEcN7s/ibp4kgex1gniMk/AeNkyj7Gw0nvkQmc2cLgXYT2usaBm+920UY8M1FeG9NdLVzk72K560b9NfDem6qzmSFiZ0UhAASifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHbisUZf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHbisUZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F55C1F000E9;
	Tue, 25 Aug 2026 21:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787695190;
	bh=iBFe3a/aAwZJ86p8Gr6st6LRNKUUbujnhHrY9FkOfGE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UHbisUZfebJkOUbkNqhIg8qHGvM1uv/dOJcrox7r6iikGDemtPR+ldulkgkTqT+Sa
	 hjrhvecQvWZNcjbzmUm58u/aTYi2GZb0xWhGHvKovIpASbdSD5GQyY79mOeQaTQL1I
	 5BsnP4Z5o1OCRObhASKnXhp/Pr8gkNSaK4cdDEQXFhE8Sudp0ybBuTq4NyiHNuwPP1
	 rFDli7tj45CZb7vWf7psT95tbJ54NYps+w/g4pmulvJR/+44hGxHYXCe6VjF7IgwtC
	 OiwS+nzHlwYSMUlmtV3+tBg5RdHcNZpIAXzAQMpkonIKqskC9mj7/h10M5Ghi2YVGr
	 GW6j/Laqc3LqA==
Content-Type: multipart/mixed; boundary="===============7380886397669498530=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bc4461d9d023911ce4c56de3c9cc73e93f1a4091511aa7bb77dc279a4b855239@mail.kernel.org>
In-Reply-To: <20260825205432.1322845-1-yonghong.song@linux.dev>
References: <20260825205432.1322845-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 04/10] bpf: Let the by-value struct walk take the kinds of member it accepts
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Aug 2026 21:59:50 +0000 (UTC)

--===============7380886397669498530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let the by-value struct walk take the kinds of member it accepts
>
>     Use btf_struct_is_composed_of() instead of btf_type_is_scalar_struct() in
>     btf.c so in the future, non scalar member (e.g. arena pointer) can be
>     supported as well. There is no functional change.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This isn't a bug, but the changelog only describes the one-line call swap
in btf.c, while two other parts of the diff are what the "no functional
change" claim rests on.

The first is a new enumeration in a global header:

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> +/* Kinds of member a by-value struct or union may be composed of. */
> +enum btf_member_kind {
> +	BTF_MEMBER_SCALAR	= BIT(0), /* an int or an enum, or an array of them */
> +	BTF_MEMBER_ARENA_PTR	= BIT(1), /* a pointer carrying the "arena" type tag */
> +};

The second is the array-member branch of the walk losing its trailing
continue and falling through into the shared kind check:

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>  			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
> -			if (!btf_type_is_scalar(member_type))
> -				return false;
> -			continue;
>  		}
> -		if (!btf_type_is_scalar(member_type))
> +		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
>  			return false;

Equivalence here holds because btf_member_kind_allowed() collapses to
btf_type_is_scalar() when the mask is BTF_MEMBER_SCALAR alone, and because
the shared check is the last statement of the for_each_member() body, so no
member is skipped or checked twice.

Would it help to mention the new enum btf_member_kind in bpf_verifier.h and
this array-branch fall-through in the changelog, since those are what the
"no functional change" claim rests on?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32899532405
--===============7380886397669498530==--
