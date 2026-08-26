Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CC39CCE9
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769243; cv=none; b=pUnN8QvYYg9g5ccTIYATHxWbraEsK/WdycRO6W3KEPgHqRPC2TUlPHptCK3zl9azJI5eE3WB947tVC+IkL0y256+46/RCgkeSO3kLRQ2RCzi78/0KDHR0iwLF3U9F/GeI5yAJhgpnACdA7dk9SB2yri7agdPLf9mQAiNNoPYikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769243; c=relaxed/simple;
	bh=NYlqUZ0RBZPZ7Kzcev9XkXEdR3a4V7Tmxo75dTXj7qM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iYg+HdiB8UhHa4Bgeu1+k0IB0M/KipoOml9xN298sSe+buJO/PARpCezlKhpq3ak6/Jw0Zcp9VNe6ph0XfbWVr3ljkx1XnRHQV9jNPcWKbQtMQ7Zaxh4uW/TKzqMfCK8Q77MH3CnA0YDl0NujHib6IvtjBJf/2/FqJ3z8k//8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duXdfCjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duXdfCjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5BE1F00A3A;
	Wed, 26 Aug 2026 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769232;
	bh=sCzwGoui6I3+s0x8wNGFjUOlnd2VAfqgTGUgoWgVXyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=duXdfCjbKhUifvXP4105EAIfZPevYKAFB9fb4S5DnqhM2WJVtDuggTo+VhIi+nMDN
	 XLX2/nBb4jfC5hWkOk99wifIeULto7gft9Rrn+x1vayL+7IPkRgiYQ1F6yH3jbylND
	 25mNL7zBTX1Xtu9p18Q6pvtlzV3S5aq0czte9DWh4M9ziJQQAtCrWC7uJpx/iVP2hH
	 LgwdMQZAygPKFJQPQ/19qGwDh4z5+Hbc5+Pbhl6ZFo7VYtYcMs33J+ihwka6xFq/2s
	 srgM+JGRiQz5ON/OxtGfoxkQZvpa0b7J1HBsFxEyJVzIPe+THNRlyrEe107QIn7G68
	 VVMhBRriaotYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] libbpf: Support declarative dynamic
 load via BTF decl_tag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260826181825.1826541-5-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-5-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:33:51 +0000
Message-Id: <20260826183352.4D5BE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Applying __load_dynamic to programs requiring BTF target resolutio=
n causes object opening to unconditionally fail.
- [Medium] prog_has_dynload_tag() aborts object loading and falsely blames =
an unrelated program if any invalid use of __load_dynamic exists in the BTF.
- [Medium] The __load_dynamic BTF tag is silently ignored for programs with=
 unrecognized or custom ELF section names.
- [Low] Multi-line comment for __load_dynamic in bpf_helpers.h violates the=
 strict BPF subsystem comment style.
--

commit 2d3fcf27d117a0a3d873c0c1212bb77a4447fc91
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

libbpf: Support declarative dynamic load via BTF decl_tag

This commit adds a loadtype:dynamic BTF decl_tag, exposed as __load_dynamic
in bpf_helpers.h, letting a program declare itself dynamically-loaded in
its source instead of requiring an imperative call. The tag is checked
in the existing per-program loop in bpf_object_init_progs().

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9d160b5b9c0ee..52978f0e04539 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -218,6 +218,11 @@ enum libbpf_tristate {
>  #define __arg_untrusted __attribute((btf_decl_tag("arg:untrusted")))
>  #define __arg_arena __attribute((btf_decl_tag("arg:arena")))
> =20
> +/* Mark a BPF program to be loaded dynamically instead of autoloaded,
> + * equivalent to bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYN=
AMIC).
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment style violate the BPF
subsystem rules? The BPF subsystem coding style guide requires multi-line
comments to have the opening `/*` on its own line.

> +#define __load_dynamic __attribute__((btf_decl_tag("loadtype:dynamic")))
> +
>  #ifndef ___bpf_concat
>  #define ___bpf_concat(a, b) a ## b
>  #endif
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1d00c47841b..5d58dbf25234f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
[ ... ]
> @@ -7156,6 +7158,50 @@ static int bpf_prog_assign_exc_cb(struct bpf_objec=
t *obj, struct bpf_program *pr
>  	return 0;
>  }
> =20
> +#define DYNLOAD_DECL_TAG "loadtype:dynamic"
> +
> +/*
> + * Check whether a BPF program is annotated with the DYNLOAD_DECL_TAG BTF
> + * decl tag, requesting that it be loaded dynamically after the object l=
oad.
> + *
> + * Returns 1 if the tag is present, 0 if it is not, negative error other=
wise.
> + */
> +static int prog_has_dynload_tag(struct bpf_object *obj, struct bpf_progr=
am *prog)
> +{
> +	int i, n;
> +
> +	if (!obj->btf)
> +		return 0;
> +
> +	n =3D btf__type_cnt(obj->btf);
> +	for (i =3D 1; i < n; i++) {
> +		const struct btf_type *tag_t, *fn_t;
> +
> +		tag_t =3D btf__type_by_id(obj->btf, i);
> +		if (!btf_is_decl_tag(tag_t) || btf_decl_tag(tag_t)->component_idx !=3D=
 -1)
> +			continue;
> +		if (strcmp(btf__str_by_offset(obj->btf, tag_t->name_off),
> +			   DYNLOAD_DECL_TAG) !=3D 0)
> +			continue;
> +
> +		/* a decl tag's type field points at the entity it decorates */
> +		fn_t =3D btf__type_by_id(obj->btf, tag_t->type);
> +		if (!btf_is_func(fn_t) || btf_func_linkage(fn_t) !=3D BTF_FUNC_GLOBAL)=
 {
> +			pr_warn("prog '%s': " DYNLOAD_DECL_TAG
> +				" decl tag must be applied to a global function\n",
> +				prog->name);
> +			return -EINVAL;
> +		}
> +
> +		if (strcmp(btf__str_by_offset(obj->btf, fn_t->name_off), prog->name) !=
=3D 0)
> +			continue;   /* tag belongs to a different program */

[Severity: Medium]
Will prog_has_dynload_tag() abort object initialization and falsely blame t=
he
current program if an invalid use of the __load_dynamic tag exists elsewhere
in the BTF?

Because the function linkage check is performed before verifying if the tag
actually belongs to the current program being processed, it appears the fir=
st
program processed will trigger the failure.

> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
[ ... ]
> @@ -8467,6 +8516,22 @@ static int bpf_object_init_progs(struct bpf_object=
 *obj, const struct bpf_object
>  				return err;
>  			}
>  		}

[Severity: Medium]
Is the __load_dynamic BTF tag silently ignored for programs with unrecogniz=
ed
or custom ELF section names?

Looking slightly earlier in bpf_object_init_progs(), there is a check:

		prog->sec_def =3D find_sec_def(prog->sec_name);
		if (!prog->sec_def) {
			/* couldn't guess, but user might manually specify */
			pr_debug("prog '%s': unrecognized ELF section name '%s'\n",
				prog->name, prog->sec_name);
			continue;
		}

Because the tag parsing added here is placed after this continue statement,
it seems the declarative dynamic load feature will be bypassed for programs
with custom section names.

> +
> +		if (prog_is_subprog(obj, prog))
> +			continue;
> +
> +		err =3D prog_has_dynload_tag(obj, prog);
> +		if (err < 0)
> +			return err;
> +		if (err > 0) {
> +			err =3D bpf_program__set_load_type(prog, BPF_PROG_LOAD_TYPE_DYNAMIC);
> +			if (err) {
> +				pr_warn("prog '%s': failed to apply " DYNLOAD_DECL_TAG
> +					" decl tag: %s\n",
> +					prog->name, errstr(err));
> +				return err;
> +			}
> +		}
>  	}
> =20
>  	return 0;

[Severity: High]
Does applying __load_dynamic to programs requiring BTF target resolution ca=
use
object opening to unconditionally fail?

When bpf_object_init_progs() calls bpf_program__set_load_type(), which rout=
es
through bpf_program__set_dynamicload(), it hits this check:

		long flags =3D prog->sec_def ?
			(long)prog->sec_def->cookie : SEC_ATTACH_BTF;
		if ((flags & SEC_ATTACH_BTF) && !prog->attach_btf_id)
			return libbpf_err(-EINVAL);

Since the declarative tag is processed during early object initialization, =
long
before attach_btf_id is resolved by libbpf or can be set by the user,
attach_btf_id is always zero here. Doesn't this cause the object open phase=
 to
unconditionally abort with -EINVAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826181825.1826=
541-1-andrey.grodzovsky@crowdstrike.com?part=3D4
