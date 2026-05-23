Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDEE349CCA
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524437; cv=none; b=Q8MXjZV0IHIXXdgXQj6jsu8R0REFlM7vUlaauT2kjdaIdOIOIMg7Nn+L5Lbv7VQ2LRSlMqLiLaENG+dnHlhOLZc87TZfMH2HHd2tGq86yO/KGEzqUrvb009uloz2JxLBQDQ85GNY4z9cp0ytW+q9YOMXwQZBXrEuDBrKF/RmpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524437; c=relaxed/simple;
	bh=kodOdkozDv+0FKdHF4BJpnNgYRnX8RDb7FE2/UeuiL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lFCUcmnFLMV5OvIQQNf5PAgwyvyWjyaxqHAHT1oBD2VJphkVD+w7EFRgFv9bhxZKvMsNmRfm8HoopUNm1KjZ7+4cG63WG9xKA98WqHgNnwApFCOM+Z1Q+ysinuxb4M2EFBB0WysDkY8PFnK90Kp0/jGLbGW/rUKyorOfp+hav1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwoy2Fji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwoy2Fji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F931F00A3A;
	Sat, 23 May 2026 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779524436;
	bh=1KzlPdzU/aWmDY/40p39bjH5TO6zgQuwsMcU6h4IKdA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hwoy2FjinTFsD1ZNESa+ahPShOZ8wApciRUCeFhQVEUZkPHqO09WAXBsV1W0Vm77h
	 cXmImUY0pZYPgDANtZBLzniYFcfmUGGJRzmGAjdBZehP+YGAbl7RoFParWSysKjArp
	 6klstWQDnHNrH41aGhJCggXEU0nFXAB2o/SHvRqOeLRVwMbPBrSPLgvxpnDFkwZfT7
	 P0T1cwzVgHhWhp+fV7leF1OAqMq/xL0nF3WzORhod5rF+TV1ceIiMi8RQYjF8LHYAR
	 XOrCPv6D1gqwUDPNASGIi0/7K1NsOFekFUE/yTov8OjSGFCspJffWJF37L7Wj3XBFG
	 HDde8qBVeM4TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Add nelems overflow check in
 btf_find_field_one()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Anand" <anand.himanshu17@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523074736.222994-1-anand.himanshu17@gmail.com>
References: <20260523074736.222994-1-anand.himanshu17@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 08:20:35 +0000
Message-Id: <20260523082035.D2F931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch leaves a critical 32-bit integer overflow in `btf_re=
peat_fields()` unprotected, leading to a stack buffer overflow.
--

commit d1acecf46d6faa37ff66d19a08184489e682b397
Author: Himanshu Anand <anand.himanshu17@gmail.com>

bpf: Add nelems overflow check in btf_find_field_one()

This commit adds an overflow check when multiplying nested array element
counts in btf_find_field_one(). This aims to make the logic consistent with
__btf_resolve_size() and guards against future validation ordering changes.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d785812076..b767a9fcf095d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3765,7 +3765,8 @@ static int btf_find_field_one(const struct btf *btf,
>  	 */
>  	for (i =3D 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++=
) {
>  		array =3D btf_array(var_type);
> -		nelems *=3D array->nelems;
> +		if (check_mul_overflow(nelems, array->nelems, &nelems))
> +			return -E2BIG;
>  		var_type =3D btf_type_by_id(btf, array->type);
>  	}
>  	if (i =3D=3D MAX_RESOLVE_DEPTH)

[Severity: Critical]
This isn't a bug introduced by this patch, but does the bounds check in
btf_repeat_fields() further down in this function still have a 32-bit
integer overflow?

The commit message mentions that btf_array_resolve() prevents the total
array size from overflowing u32, meaning sz * nelems <=3D U32_MAX. However,
could a crafted BTF union with 11 struct members (field_cnt =3D 11) and an
element size of 8 bypass the validation if nelems is 390451573?

The array size check would pass since 390451573 * 8 =3D 3123612584 <=3D U32=
_MAX.

When btf_repeat_fields() is called at the end of this function:

    if (nelems > 1) {
        ret =3D btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
        ...
    }

Is the multiplication field_cnt * (repeat_cnt + 1) inside
btf_repeat_fields() evaluated as a 32-bit operation? If so,
11 * 390451573 =3D 4294967303, which wraps around to 7.

Since 7 <=3D 11, wouldn't this bypass the bounds check and lead to an
out-of-bounds memcpy on the stack-allocated info_arr[BTF_FIELDS_MAX],
potentially overwriting kernel stack memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523074736.2229=
94-1-anand.himanshu17@gmail.com?part=3D1
