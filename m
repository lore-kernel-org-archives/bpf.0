Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DB2C1586
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685205; cv=none; b=lr8MZunfs9K1lqA74Oq6HoE8vX9sQfY3N03X9h2skREg+HQJ7tJR6Cjru3WJ85NuZZ9HcvUGPBIP1E8acF4LFTAzYRHFQWvXmBo4Pzx8U7EaxtwD69VxkXM2vqpYJ6TvZACohX2SbmOYMqZ3WbzTSUklZWC0Zy33Xd/WqhhmPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685205; c=relaxed/simple;
	bh=W5naZxfXxhf5enOkefsTuo0sW6DusYmYBDBB34JtNt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=POKneRQewgsOrrNJFBZdJ+UJmRbdcUVq4uU/1pc1XfasJQ8DXLU8E7szilvzkpsP90MTEGbvieXJdZOFz/ofL/c3R/It+ViF6O0TCSvuNGUdf4qcp+68tkFw1hzRoetzvrF6QQ3PDuhX5vKyeQmG/5MG5LLDuWHh5VAnrmjtaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTPY6aa5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTPY6aa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55DF1F00893;
	Fri,  5 Jun 2026 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780685204;
	bh=apjPVqHijF4dPHk+b5j/OLvBWDF2eRR2iLGpFrTmTTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FTPY6aa5q3zcOSCh+cLmoMqZbvrFVruAqmAoir28VueAfjxyGdaVr5nZuvdAUm3P8
	 EO0uNHdgv5hmhGLfLxglUJAlajZt+qGNByYal6bMK340PR4hkp/P3nMzKOl5lHr12T
	 B5rl/wgh/qkTnne6b9NxPW63GUa7ZiYl+BU06wfeFSZwnirQhA2VUrVgOz9UaRSAfD
	 VzxbOTncUtsXQvbKSyTE0yTITDU9A/OwdGnXyz2L68NMidEQglkrrBfdbP76IpsTt+
	 C47tNVNrjnd/JBXATmwOBARF7i7QFYjoN7+BvQnckedh23nj9WOrH3CWzCeZe5Yr5Z
	 eQavPMYUdNG8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/5] bpf: Check acquire_reference() error
 for "__ref" struct_ops arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605183551.969144-3-ameryhung@gmail.com>
References: <20260605183551.969144-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:46:43 +0000
Message-Id: <20260605184643.C55DF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct return on `acquire_reference()` failure in `do_check_common=
()` bypasses cleanup and leaks `env->cur_state`.
--

commit 255de8a669b1a40ba719e137d38c8f3f04ff00ca
Author: Amery Hung <ameryhung@gmail.com>

bpf: Check acquire_reference() error for "__ref" struct_ops arguments

This commit adds an error check for acquire_reference() when handling
struct_ops program arguments tagged with "__ref". It stores the error
return value and aborts verification if acquire_reference_state() fails to
allocate memory.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a741bf4479318..5a69af5690891 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18363,9 +18363,15 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
> =20
>  	/* Acquire references for struct_ops program arguments tagged with "__r=
ef" */
>  	if (!subprog && env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> -		for (i =3D 0; i < aux->ctx_arg_info_size; i++)
> -			aux->ctx_arg_info[i].ref_id =3D aux->ctx_arg_info[i].refcounted ?
> -						      acquire_reference(env, 0, 0) : 0;
> +		for (i =3D 0; i < aux->ctx_arg_info_size; i++) {
> +			int id;
> +
> +			id =3D aux->ctx_arg_info[i].refcounted ? acquire_reference(env, 0, 0)=
 : 0;
> +			if (id < 0)
> +				return id;

[Severity: High]
Does this direct return bypass the cleanup path and leak env->cur_state?

Earlier in do_check_common(), env->cur_state is allocated via kzalloc_obj().
Other error paths in this function set the return variable and jump to the
out label to call free_states(env) for proper cleanup.

Should this be updated to set ret =3D id and goto out instead of returning
directly?

> +
> +			aux->ctx_arg_info[i].ref_id =3D id;
> +		}
>  	}
> =20
>  	ret =3D do_check(env);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605183551.9691=
44-1-ameryhung@gmail.com?part=3D2
