Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88141F5821
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784320; cv=none; b=UY+VlSPEjxCA9FFADVa99mNk6pJn6TecxfZJbOzTpX6EkEIW1QNfaZwoILTp51kVOke2afgd6XfnHjvUEO7PYGAJEO8CHXoJLq1eS0nwtLoETYnCRofLHAq7vOfNX1xpAmHn7doTm2NoyUOpyIfO75fRdD3mfMVPTXtyW+jcvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784320; c=relaxed/simple;
	bh=ln1W4Vzfg2cpoB9QJdktCSL/E1Y5UG09bjhlyXHBRu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tf3vJFXbnmpGVq85p89HggiB04x9jXNRRMNMqA8iu80BpG+ftVapH+2Pcu5Zdhu1nzTev3z4g84l6zhaqcp9tGUpTeIwesMh0EbVjHP7cgJOYuU7lgBtdFlvXjWy3KF5MimOJ5MMnBclcTVaxBXeWuOIFkKvA7rdbBmusPbvTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy59eaYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy59eaYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261291F000E9;
	Thu, 23 Jul 2026 05:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784784319;
	bh=IROi/Vo/8PDNn4209biMa9aA8uv1QhbOSWVG6t4HVs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qy59eaYVOF88PMjI5QPXLvdN5WCilUNmVzouVvj3FdyNngBw4wm3ksRqZHF0c6oB2
	 Yldbu/dQoMqN5cNAtzsKJ35sehp66yLn0uWDbfPJHIMlMRnyBJuMQWysvGuzfJQtwO
	 UkmBtqP1ApW51tvzNh7CHiOKLKp47tup64ZTHBdgVSW5ypc1A1592F8lz73OXrnMG4
	 cXprNXTeqgYBNjy5MNfdcDVXioZfWi8QG/d+NUkHP07lxkfdG1v+0UKN2C3eek5HHb
	 ygQ9TTGY6PgcpB0/dKA2RVX0+QhdEZZd3QY1xHunDr5YgGvAH8jnMD1Yw+JsBcvRyf
	 rUbYmdPYuoyRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 02/18] bpf: Unify const map ptr argument
 checking for helpers and kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-3-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:25:18 +0000
Message-Id: <20260723052519.261291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] NULL pointer dereference in `process_map_ptr_arg` when a BPF fun=
ction accepts multiple map arguments.
- [Low] Incorrect and misleading register numbers in `process_map_ptr_arg` =
verifier error message.
--

--- Patch [2]: [PATCH bpf-next v1 02/18] bpf: Unify const map ptr argument =
checking for helpers and kfuncs ---
commit e4d2232623c3b71f4ec65054cb7cebf7737a4120
Author: Amery Hung <ameryhung@gmail.com>

bpf: Unify const map ptr argument checking for helpers and kfuncs

This commit factors out the map pointer argument checking logic for both
helpers and kfuncs into a single process_map_ptr_arg() function. It uses
the bound map's btf_record to derive the object name (timer, workqueue,
or bpf_task_work) for diagnostic messages.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e8c76abbf76a2..bff51aff25579 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -8274,6 +8274,50 @@ static int get_constant_map_key(struct bpf_verifie=
r_env *env,
> =20
>  static bool can_elide_value_nullness(const struct bpf_map *map);
> =20
> +/* Record the bpf_map argument of a helper or kfunc call in meta->map.
> + *
> + * When meta->map is already set from an earlier argument (a timer, work=
queue or
> + * task_work object that is bound to a map), reject a map pointer that d=
oes not
> + * match it. That object sits in the register right before the map argum=
ent, and
> + * its type is taken from the bound map's record for the diagnostic.
> + */
> +static int process_map_ptr_arg(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg,
> +			       argno_t argno, struct bpf_call_arg_meta *meta)
> +{
> +	int map_regno =3D reg_from_argno(argno);
[ ... ]
> +	if (meta->map.ptr &&
> +	    (meta->map.ptr !=3D reg->map_ptr || meta->map.uid !=3D reg->map_uid=
)) {
> +		struct btf_record *rec =3D meta->map.ptr->record;
> +		const char *obj_name =3D "workqueue";
> +
> +		if (rec->timer_off >=3D 0)

[Severity: Medium]
Will this cause a NULL pointer dereference in the verifier if a kfunc
accepts multiple map pointers?

If a custom kfunc or future helper takes two map pointers, such as=20
void *a__map and void *b__map, process_map_ptr_arg() will process the
second map and see meta->map.ptr already set by the first.

If the first map was a standard map without special fields, its record
pointer is NULL, causing rec->timer_off to crash.

Should we check if rec is NULL before accessing its fields?

> +			obj_name =3D "timer";
> +		else if (rec->task_work_off >=3D 0)
> +			obj_name =3D "bpf_task_work";
> +
> +		verbose(env, "%s pointer in R%d map_uid=3D%d doesn't match map pointer=
 in R%d map_uid=3D%d\n",
> +			obj_name, map_regno - 1, meta->map.uid, map_regno, reg->map_uid);

[Severity: Low]
Can the hardcoded map_regno - 1 produce confusing or negative register
numbers in the verifier error message?

If the map argument is passed on the stack (e.g. more than 5 arguments),
reg_from_argno() returns -1, making the printed registers -2 and -1.

Additionally, if a future kfunc separates the object and map arguments,
map_regno - 1 will point to the wrong register.

Could we retrieve the exact register or stack slot number for the
bound object dynamically instead of assuming strict adjacency?

> +		return -EINVAL;
> +	}
> +
> +	meta->map.ptr =3D reg->map_ptr;
> +	meta->map.uid =3D reg->map_uid;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D2
