Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326729405
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776483649; cv=none; b=AxXsYHDhSbZ0wdnuV6WoZwbnnOyiOFwv8ciLkAQu3wztPc2HnYfyx3h+WukAsYkvSmnsZUVX/wcVJLbDqRBrrumcNuWgrrkYq254zyi5fUh7JGOTjjkIwnqaW6vZRLZuqKXKf/TyeiPgW1XL6+czracnjZHK49oCr0ZcXo2dxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776483649; c=relaxed/simple;
	bh=KkCidAWwX+ChSn2iNHH+7vdsbH/sSbeqq/VFnAYUKus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H/kXLVOQ5QkbCLuMAqyHlbfnWt/e2PPmZXozQ4miPKaZ0XVUcJ3zGbMjMuIFCn5j3mFjnsZXUODe5/Xn0HuSS+sYBSWFgdet5ZbcfDw5svdUDP+JkIf2VwMRlrC3a3CvyXNYR4292VZQkj+Fe3G6qKfm5zdU42uXanjDP++HNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oy4Supo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oy4Supo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F212C19424;
	Sat, 18 Apr 2026 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776483649;
	bh=KkCidAWwX+ChSn2iNHH+7vdsbH/sSbeqq/VFnAYUKus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oy4Supo+iic2mvpBI6RZL6/zHXuBqL4/26bEnF+XmDO14799CBY6OClA8Gc6z+Fzk
	 A+bcH5i76LIB0VOnb4xONPqI0ZGU1wHtzzVN9ekUq61kHlMX0OICK2gRCCwuYmbY2H
	 3GXiGb/6nOhnaUh5pZwDQw5RSH8QbV1otLdzB19944FCkYMj21FuLEMug7+mw72RvU
	 j7GdsUeHIiHTEkbbTFt5WFmzYdBDM1SbG++dbYInSm0ga6GeLwym27XinWtR4efMc6
	 vbxocYcZeRz3rCCfamI2SaVyzu8Taqk/7U97kyVOSLZ/56jBwNDHDsLjaOP/lzy1Dg
	 fZ56vWzgEYSwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 19/28] libbpf: Add btf_type_is_traceable_func
 function
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-20-jolsa@kernel.org>
References: <20260417192502.194548-20-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 03:40:48 +0000
Message-Id: <20260418034049.4F212C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Unsafe BTF type resolution in `btf_type_is_traceable_func` lacks v=
alidation and bounds checking, leading to out-of-bounds read and segfault.
- [Medium] `btf_get_type_size` hardcodes `sizeof(void *)` for pointer sizes=
, breaking cross-architecture analysis.
- [Medium] Missing maximum resolution depth in type modifier loop allows De=
nial of Service via infinite loop.
--

commit 70d9630993310d9569ee7d038356f4a4ec3a18e9
Author: Jiri Olsa <jolsa@kernel.org>

libbpf: Add btf_type_is_traceable_func function

Adds the btf_type_is_traceable_func function to perform checks on functions
to prevent attachment on some functions. Exports it via libbpf_internal.h
for use by benchmark tests.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d5..65a9ac10053d5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -12425,6 +12425,80 @@ static int attach_uprobe_multi(const struct bpf_=
program *prog, long cookie, stru
>  	return ret;
>  }
> =20
> +#define MAX_BPF_FUNC_ARGS 12
> +
> +static bool btf_type_is_modifier(const struct btf_type *t)
> +{
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +	case BTF_KIND_TYPE_TAG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int btf_get_type_size(const struct btf *btf, __u32 type_id,
> +			     const struct btf_type **ret_type)
> +{
> +	const struct btf_type *t;
> +
> +	*ret_type =3D btf__type_by_id(btf, 0);
> +	if (!type_id)
> +		return 0;
> +	t =3D btf__type_by_id(btf, type_id);
> +	while (t && btf_type_is_modifier(t))
> +		t =3D btf__type_by_id(btf, t->type);

Does this loop need a maximum resolution depth limit?

If a malformed BTF object contains a circular modifier reference (e.g.,
typedef A -> const B -> typedef A), could this loop spin infinitely and
cause a hang?

> +	if (!t)
> +		return -EINVAL;
> +	*ret_type =3D t;
> +	if (btf_is_ptr(t))
> +		return sizeof(void *);

Does this correctly calculate the pointer size for cross-architecture
analysis?

Since libbpf is a user-space library that may process BTF blobs from
different architectures (like a 64-bit tool processing a 32-bit BPF
object), will hardcoding sizeof(void *) return the host's pointer size
instead of the target's pointer size?

Would using btf__pointer_size(btf) be more appropriate here?

> +	if (btf_is_int(t) || btf_is_any_enum(t) || btf_is_struct(t) || btf_is_u=
nion(t))
> +		return t->size;
> +	return -EINVAL;
> +}
> +
> +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_=
type *t)
> +{
> +	const struct btf_param *args;
> +	const struct btf_type *proto;
> +	__u32 i, nargs;
> +	int ret;
> +
> +	proto =3D btf_type_by_id(btf, t->type);

Could this cause an out-of-bounds read if t is not a function type?

Because the type and size fields share a union in struct btf_type, passing
a type like BTF_KIND_STRUCT causes its size to be misinterpreted as a type
ID. The internal btf_type_by_id() helper skips bounds checking.

If the interpreted ID exceeds the BTF type array bounds, it might read past
the end of the array and return a garbage pointer, which would then be
dereferenced in the next line.

Should this verify !btf_is_func(t) first, and use the bounds-checked public
API btf__type_by_id() along with a NULL check for proto?

> +	if (BTF_INFO_KIND(proto->info) !=3D BTF_KIND_FUNC_PROTO)
> +		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-20-jolsa@kernel.org?part=3D1
