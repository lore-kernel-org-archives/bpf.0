Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9CE573
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781910124; cv=none; b=FJ+Ve834zlQIeuPs0NUCF8nOTQ37/2x9RTBMRyUst02urQ+l8+jrSQ+DxPHZVkcng5f/8PX+fg1u9yCsvGsnVQY8gCpNP1UktTqRjfnJ8xJzulOKDcZi4EW2MzjSXZD+R8aE+X9QutxN4pVAwqLC826fk6tnlxSJG9xFFRYF0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781910124; c=relaxed/simple;
	bh=NOHcuQMEfw4Tgjyp21C/Ttwwu8Sgc+99YJ1On0yK9qQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3QMAyc49AgMupORwVnl5vQfkFV7O4OWPB7nmM0EvnGjhdJA4ujiidWRob2Wai4uRoialydWXmGrAh8JvUFotXPCIl2LBT8qDskFjqdY9tCSTKqt85YgLTIckTtFujoTVmFk48myBXCH+4eRf8YL5upj0/phLK4EcjM1eRqMtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Ge8+LD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Ge8+LD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E7F1F000E9;
	Fri, 19 Jun 2026 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781910123;
	bh=zkGV/t/5czmoFTD7E90wFFtOakS6UcD7fiS+PoFsrHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2Ge8+LD1v/l9que4PoHkRwaKGflWEQZUlECyFwzjos3vlddjqaRGSUOde1XKdajB
	 XY0yo5DNMLzBNC437cMdGEVxO6Stg2rEyzEZP/QwVD3z4Fi+wftHsRR5pAhq1KWssT
	 8LKbAOXQEJkk4SaC7R0WQECSbHbVrsYoHtOco055hhCbqm3yxiat3vKH25pGdDDNWJ
	 0ioHV/9nVG1+LppCa+FE9rO2KP42y/EudK22qQ2o1IDJ176Jir8ovv5JFuNujtrHxP
	 lW0mvlf5PmoBhCqAUPKSTG7fzK3G+ATzOVJIylsaltC95qami7TgsYhHxlL4YN7vGN
	 ykFXftnx6SL3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] resolve_btfids: preserve tag and parameter names
 when processing implicit args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aelin Reidel" <aelin@mainlining.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
References: <20260620-resolve-btfids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 23:02:03 +0000
Message-Id: <20260619230203.70E7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing memory allocation check for `tmp_tag_name` leads to unde=
fined behavior on OOM.
- [Medium] `strdup()` on potentially NULL `param_name` introduces a new cra=
sh vector on malformed BTF.
--

commit 6cb93b6d37df26aabf2d6e25d7969724248ceefb
Author: Aelin Reidel <aelin@mainlining.org>

resolve_btfids: preserve tag and parameter names when processing implicit a=
rgs

This commit updates process_kfunc_with_implicit_args() to duplicate
tag and parameter strings before modifying the BTF object. This prevents
btf__add_* operations from dereferencing stale pointers if the internal
BTF storage is grown and reallocated during processing.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f8a91fa7584f4..94b89e9c942ee 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -1163,18 +1164,22 @@ static int process_kfunc_with_implicit_args(struc=
t btf2btf_context *ctx, struct
>  		if (strcmp(tag_name, "bpf_kfunc") =3D=3D 0)
>  			continue;
> =20
> +		tmp_tag_name =3D strdup(tag_name);
>  		idx =3D btf_decl_tag(t)->component_idx;
> =20
>  		if (btf_kflag(t))
> -			err =3D btf__add_decl_attr(btf, tag_name, new_func_id, idx);
> +			err =3D btf__add_decl_attr(btf, tmp_tag_name, new_func_id, idx);
>  		else
> -			err =3D btf__add_decl_tag(btf, tag_name, new_func_id, idx);
> +			err =3D btf__add_decl_tag(btf, tmp_tag_name, new_func_id, idx);
> =20
>  		if (err < 0) {
>  			pr_err("ERROR: resolve_btfids: failed to add decl tag %s for %s\n",
> -			       tag_name, tmp_name);
> +			       tmp_tag_name, tmp_name);

[Severity: Medium]
What happens if strdup() fails and tmp_tag_name is NULL?

If tmp_tag_name is NULL, btf__add_decl_tag() or btf__add_decl_attr() will
fail and return -EINVAL. The error path then blindly passes the NULL
tmp_tag_name to pr_err() using the %s format specifier.

Could this cause a segmentation fault in libc instead of exiting with a
clean error?

> +			free(tmp_tag_name);
>  			return -EINVAL;
>  		}
> +
> +		free(tmp_tag_name);
>  	}
> =20
>  add_new_proto:
> @@ -1193,12 +1198,17 @@ static int process_kfunc_with_implicit_args(struc=
t btf2btf_context *ctx, struct
>  		if (is_kf_implicit_arg(btf, &params[i]))
>  			break;
>  		param_name =3D btf__name_by_offset(btf, params[i].name_off);
> -		err =3D btf__add_func_param(btf, param_name, params[i].type);
> +		tmp_param_name =3D strdup(param_name);

[Severity: Medium]
Can param_name be NULL here if the BTF input is malformed and the string
offset is out of bounds?

If btf__name_by_offset() returns NULL, wouldn't strdup() dereference the
NULL pointer and crash?

Prior to this patch, the potentially NULL pointer was safely passed
directly to btf__add_func_param(), which handles NULL by defaulting to an
anonymous parameter.

> +		if (!tmp_param_name)
> +			return -ENOMEM;
> +		err =3D btf__add_func_param(btf, tmp_param_name, params[i].type);
>  		if (err < 0) {
>  			pr_err("ERROR: resolve_btfids: failed to add param %s for %s\n",
> -			       param_name, kfunc->name);
> +			       tmp_param_name, kfunc->name);
> +			free(tmp_param_name);
>  			return err;
>  		}
> +		free(tmp_param_name);
>  		t =3D (struct btf_type *)btf__type_by_id(btf, proto_id);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-resolve-bt=
fids-implicit-args-use-after-free-v2-1-4132e1f639f0@mainlining.org?part=3D1
