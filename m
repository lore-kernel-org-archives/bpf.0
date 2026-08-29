Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B637FF6A
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787987484; cv=none; b=EsJdbVeBsWJUYkVu8kDfURPsxyjHEMYwiyvweZUWlTt+XOFtnKr5R8JxxbrT6ssogpHsluqig50cUlY+a+kllpKkcYsj8HtW06CCRbkQ8VRFoJBZiHmMsvwjTKfXQ0y6FvAXHGHjaw1tNu/ggK/pgRDSScWHmg2FmNOksenktPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787987484; c=relaxed/simple;
	bh=r7SFC4K7QtKlt81zb67Q/FohXMEkxCXzJp0L5a03xD0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YiPG+NTqALi35yifSX21kIm6Zbg1glvONAgZt49nXjI1jzf6SZmW+Rt4iRXF+2A8d/8CTVchCT2rlRTvpk/zQSKtwuu+ecfQvkN81jno8xeFaislOOQu2GLoSCBUyQa0oq6zxXvJ7DytJBfz7hj+FdPSg/OCh3Md+Ig/YkqRadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyKxi1Ib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyKxi1Ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051391F00A3D;
	Sat, 29 Aug 2026 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787987483;
	bh=uWa0kkJaAlWrWASttmSQLhi+fx2j4qAdJhJD6mjkPmw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WyKxi1Ibe0+omj75kC2ljKMI+uYHWv+mpu13bkDWvgXy8i1xet8+1DBnsmy1tjq9V
	 1XYtvMloRYYDGQhno8vIHaMU1eGnCOdLAE34tbfLzgcnlPXF7wk4WL82cEmIwDMmJA
	 01XGgBi8M6084aAeyhkAwvwelETkCgg8WiwgFTVl/1XLGPSTbn1z/HRx/PJ59G2ell
	 oma/PT6ifhsQIHK8jtubjMto6v8XP7rOhmNUCjyDVuVPoP/d8Qa2tI2xlBOIOm2sSN
	 5ZVtfUat4KD9eENBch2D45MtnRGgXFszKWPGuQJ4rjdsWwH8RqH6jojQawNqNm4ZQL
	 M/K0SLT4+++ig==
Content-Type: multipart/mixed; boundary="===============0303665141218191537=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1348470d9638a1349a75ebe4a8830f3ac272c5a69329629bf3c876c2a675dafb@mail.kernel.org>
In-Reply-To: <20260829061539.1695015-1-yonghong.song@linux.dev>
References: <20260829061539.1695015-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Let a by-value struct nest arrays and structs freely
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 29 Aug 2026 07:11:23 +0000 (UTC)

--===============0303665141218191537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 90139f1b78d10..a377b1995b51f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11675,6 +11675,17 @@ static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct bt
>  		const struct btf_array *array;
>
>  		member_type = btf_type_skip_modifiers(btf, member->type, NULL);
> +		/*
> +		 * Every element of an array is laid out in the value being
> +		 * returned, so an array counts as its element type however many
> +		 * dimensions deep that is.
> +		 */

This isn't a bug, but since btf_struct_member_walk() is also used for
kfunc pointer arguments (get_kfunc_arg_type(), check_kfunc_args()) and
the bpf_percpu_obj_new() type argument (check_special_kfunc()), would it
read better to phrase this in terms of the aggregate's layout rather than
"the value being returned"?

> +		while (btf_type_is_array(member_type)) {
> +			array = btf_array(member_type);
> +			if (!array->nelems)
> +				return false;
> +			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
> +		}
>  		if (btf_type_is_struct(member_type)) {
>  			if (rec >= 3) {
>  				verbose(env, "max struct nesting depth exceeded\n");
> @@ -11684,12 +11695,6 @@ static bool btf_struct_member_walk(struct bpf_verifier_env *env, const struct bt
>  				return false;
>  			continue;
>  		}
> -		if (btf_type_is_array(member_type)) {
> -			array = btf_array(member_type);
> -			if (!array->nelems)
> -				return false;
> -			member_type = btf_type_skip_modifiers(btf, array->type, NULL);
> -		}
>  		if (!btf_member_kind_allowed(btf, member_type, member_kinds))
>  			return false;
>  	}

>     bpf: Let a by-value struct nest arrays and structs freely
>
>     Go through nested array types until it reaches a non-array type. Later
>     code will check such non-array type based on current logic. A
>     zero-length array is still rejected, at whichever dimension it appears.

This isn't a bug, but the changelog explains the array mechanics without
saying what this enables for users. Moving the unwrap ahead of the struct
test is what allows an array of structs (previously rejected the same way
a multi-dimensional array was).

Could the changelog mention both what this change allows (arrays of
structs, nested arrays) and why that matters?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33238287240
--===============0303665141218191537==--
