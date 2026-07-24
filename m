Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6138C42F
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921119; cv=none; b=J2lkClpXo1lQEdEsym+hikeKQJ0KF3A/doYXfT6gz5znHiR9iWH4cgwbEvgSDZBWELxHHyFNmIMM2MCgiYgYK4J9bulhsC1Q6uDcToB/0E/FHl8g3L086qYc+OaCt2w6te+skNTqAEKJwky9dqrQGKJC98xCEAcMY9c/L8xsA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921119; c=relaxed/simple;
	bh=51SAqpKoIqECOMoQKApnOPeRy5EOO4JPFvCOAAqpymI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z+IgYqlfumOlHzcPYrn2psZZSeYtL6yE9sAmb+KanLQWglWdeO1xJwU/cQ7zmSmv99M8TLgLNSV5CbHlSIWVdvIYSmtGKmoFvPvbkVtxG/Yo5vsqjiocxyxgrpUb5qR02wLm8dZS4sZeYXeqL8vYoXUESof3WEBxYlnLAFcf40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms3q6b8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms3q6b8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C471F000E9;
	Fri, 24 Jul 2026 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784921117;
	bh=ugkDlVIGI/6JPR8RC9NPI7YeZ8tQae8lAyS4ZcCVfw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ms3q6b8mucm1P61DhOXdYNseamWEi1iOkIPOIG8GJ7CKbSXZFn8oRj2tGiSk1nWGH
	 DnjgciNRkPiVdoG7T6VXEogcTxPEN2446e42X+C3UGgJX80fM/LH0REgppQCYvcfBp
	 8dCLofvt8c6R/3ILy6eGyT/P22JGq2sjOVcYuVoXr9CIVl9u+7og7CswZyHkdt8oFO
	 VR4V4ZiYcMN441Ldrsixu5nFekPc6Wr+sod2Mu0IYjDEP5RuWUV7XEVe7Q1lXgjdqx
	 TbAWYONhpXKBj5NLxZgZwEkkf5dUmLtUuXssRyooTQ91YUudFAiLo9QlPWy54tp0i8
	 EmRmAWmOBOAMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/18] selftests/bpf: Add tests for helper
 and kfunc mem+size arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260724190813.1458271-7-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
 <20260724190813.1458271-7-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 19:25:16 +0000
Message-Id: <20260724192516.C8C471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect argument name formatting in verifier log for map pointers=
 passed on the stack in `process_map_ptr_arg()`.
--

--- Patch [6]: [PATCH bpf-next v2 06/18] selftests/bpf: Add tests for helpe=
r and kfunc mem+size arguments ---
commit 26d0efc0fe7fbd940204152f62931d959ef53578
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Add tests for helper and kfunc mem+size arguments

This commit adds tests to ensure that the return of a map-of-maps lookup
cannot be passed to a nullable memory buffer argument for helpers and kfunc=
s.
It verifies that both mapofmaps_value_as_kfunc_mem_buf and
mapofmaps_value_as_helper_mem_buf are properly rejected by the verifier.
This guarantees that helper and kfunc arguments are checked in the same way.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 52be0a118cce0..2e56f726c12a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -8286,6 +8267,44 @@ static int get_constant_map_key(struct bpf_verifie=
r_env *env,
> =20
>  static bool can_elide_value_nullness(const struct bpf_map *map);
> =20
> +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> +			       argno_t argno, struct bpf_call_arg_meta *meta)
> +{
[ ... ]
> +	if (meta->map.ptr &&
> +	    (meta->map.ptr !=3D reg->map_ptr || meta->map.uid !=3D reg->map_uid=
)) {
> +		argno_t obj_argno =3D argno_from_reg(reg_from_argno(argno) - 1);

[Severity: Low]
If the map argument is passed on the stack, does this incorrectly calculate
the preceding argument's argno? It appears that this can result in an inval=
id
internal representation for obj_argno.

> +		struct btf_record *rec =3D meta->map.ptr->record;
> +		const char *obj_name =3D "workqueue";
> +
> +		if (rec->timer_off >=3D 0)
> +			obj_name =3D "timer";
> +		else if (rec->task_work_off >=3D 0)
> +			obj_name =3D "bpf_task_work";
> +
> +		verbose(env, "%s pointer in %s map_uid=3D%d ",
> +			obj_name, reg_arg_name(env, obj_argno), meta->map.uid);

[Severity: Low]
Does this use the incorrectly computed obj_argno, causing reg_arg_name() to
print "R2" in the verifier log instead of the actual register or stack
location?

> +		verbose(env, "doesn't match map pointer in %s map_uid=3D%d\n",
> +			reg_arg_name(env, argno), reg->map_uid);
> +		return -EINVAL;
> +	}
> +
> +	meta->map.ptr =3D reg->map_ptr;
> +	meta->map.uid =3D reg->map_uid;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724190813.1458=
271-1-ameryhung@gmail.com?part=3D6
