Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110547B42F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251929; cv=none; b=XP4j/y2vn2GFBiFb2s5//ObM8a7DNtoJKdq5RQ5BA6b/kn2WWkr0K+3pexpEgTn6q+SaG+MwA5KzL0ND/ewh8rs928MibhwYILLEYSOMFtPUoE3BCphOCWzrJ+C8Jhk5oOqwvHldrvg/okmykISrpJVqd5sq5EQJB3yS6xkMG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251929; c=relaxed/simple;
	bh=PQMoAbnxGWndeN/x44uc1d7mta90ruGldAXmNsCodAQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MLhQ1+2PsZAmUTO7RazjoojL2Mw0H/cq1gO8hViVpcvhDVNjAM1pXs5alQ1XsDU0Va/PFmJTz0GnROlVRTobvAxibiN4Y9H27LyJCLgobWfYkCs8zZb280AD6GdqoX8zPzFSz+/cLIEZ0SMklGpI3J0Auq536auKtNZ5N0xw/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBB0jAqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBB0jAqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC28E1F000FF;
	Thu, 24 Sep 2026 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251928;
	bh=s3wNkNew4sops6hiv9XIXSHbqBbkGV3jEzycT8cdYwU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VBB0jAqM7+FPA+4VtYEwPNZ+MhCwWqppow1IIQbfXDBobpraztH8giOgVo9QgIqV6
	 6hua2EodsDx82n3nnHbSW9hB4cf6NVZFb4f259c7DnwDarOfOpRapl0lDZG+rCWegX
	 L5c/8OxYrN1jmLmRLPZoaww8X+AtFjexmdVv60xXwFNDMlU4ZeakkuAqzswquaveWU
	 8t4MeQvqOcgdUoB3h1uK2P4n13YaJin+vKr+0O/e4FoEzJjxmWNbP+068Gr11q6Agx
	 0Nk26qZ2aVZ83oO9KCZZvazd+6E+dKn+TPFM485IzQZSob1VkyfeUFX6BXBHrPtW2c
	 gauyAsEu7UXsw==
Content-Type: multipart/mixed; boundary="===============7895224760147842889=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <38ff2c3a1b304f9efba470d52d890935e7d651d48eb9ebd15a6e05dcebb65ddf@mail.kernel.org>
In-Reply-To: <20260924111428.75957-3-alan.maguire@oracle.com>
References: <20260924111428.75957-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 02/11] libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,qmo@kernel.org
Cc: jolsa@kernel.org,daniel@iogearbox.net,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,bpf@vger.kernel.org,nsc@kernel.org,puranjay@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 12:12:05 +0000 (UTC)

--===============7895224760147842889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
>
> Add support for new kinds to libbpf.  BTF_KIND_LOC_PARAM and
> BTF_KIND_LOC_PROTO are dedup-able so add support for their
> deduplication, whereas since BTF_KIND_LOCSEC contains a unique
> offset it is not.  LOC_PARAM is considered a primary type
> since it contains no external references; LOC_PROTO is a
> reference type consisting of LOC_PARAM references so they
> are handled in the primary and reference dedup phases
> respectively.
>
> For BTF field iteration, BTF_KIND_LOCSEC needs 2 m_offs[] values
> for the associated KIND_FUNC and KIND_LOC_PROTO type ids in
> each LOCSEC entry.
>
> Add APIs to add location param, location prototypes and location
> sections and btf_is_* tests, data accessors for each.
>
> For BTF distillation we add location info to split BTF.

This isn't a bug, but could the changelog explain the adding_to_base
change? The same hunk changes how btf_add_distilled_types() decides
whether it is filling the distilled base:

Old test: dist->pipe.dst->start_id == 1
New test: dist->pipe.dst->base_btf == NULL

btf__distill_base() calls btf_add_distilled_types() twice. The first pass
writes into btf__new_empty(). The second writes into
btf__new_empty_split(new_base), whose start_id is btf__type_cnt(new_base).

The old test breaks when the split BTF references only base types that go to
split BTF. Examples are a base void * PTR, or a LOC_PROTO whose params are
all LOC_PARAMs. The distilled base then holds only void, so new_split->
start_id is 1. The second pass then looks like a base pass and skips
ARRAY/PTR/FUNC_PROTO/etc. with the adding_to_base continue. Those types are
never added to the new split BTF, and btf_update_distilled_type_ids() leaves
references to them pointing at ids from the original base.

The new kinds make this easier to hit, because a LOC_PROTO -> LOC_PARAM
chain pulls in no INT or named types. The changelog also does not mention
that base BTF_KIND_FUNC is now accepted as a distilled reference.

Would it be better as a separate fix with a Fixes: tag against the commit
that added btf__distill_base()?

[ ... ]

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c

[ ... ]

> @@ -3344,6 +3400,243 @@ int btf__add_decl_attr(struct btf *btf, const char *value, int ref_type_id,
>  	return btf_add_decl_tag(btf, value, ref_type_id, component_idx, 1);
>  }
>
> +/*
> + * Append new BTF_KIND_LOC_PARAM with specified size and flags.  Values are
> + * added via btf__add_loc_param_value().
> + *
> + * - *byte_sz* - size of the type, in bytes (1 through 16);
> + * - *flags* - combination of enum btf_loc_param_flags values
> + *
> + * Returns:
> + *   -  >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */

[ ... ]

> +/*
> + * Append a BTF_KIND_LOC_PARAM id/0 to BTF_KIND_LOC_PROTO.
> + *
> + * Returns:
> + *   - 0 on success;
> + *   - <0, on error.
> +
> + */

[ ... ]

> +/*
> + * Append new BTF_KIND_LOCSEC type with:
> + *   - *name* - non-empty/non-NULL name;
> + *
> + * Location section is initially empty. Location info can be added with
> + * btf__add_locsec_loc() calls, after btf__add_locsec() succeeds.
> + *
> + * Returns:
> + *   - >0, type ID of newly added BTF type;
> + *   - <0, on error.
> + */
> +
> +int btf__add_locsec(struct btf *btf, const char *name)

[ ... ]

> +int btf__add_locsec_loc(struct btf *btf, __u32 func, __u32 loc_proto,
> +			__u32 offset)

This isn't a bug, but could btf__add_locsec_loc() get a short doc comment
like btf__add_datasec_var_info() has? Its parameters (func, loc_proto and
offset) and the return convention (0/<0) are not documented where the
sibling functions document theirs.

Also, the comment block for btf__add_loc_proto_param() has an empty line
with no leading ' *' before its closing ' */'. The btf__add_locsec()
comment is separated from the function by a blank line, which no other
btf__add_*() comment in the file does. Could those stray blank lines be
dropped?

[ ... ]

> @@ -5997,7 +6393,7 @@ static int btf_add_distilled_type_ids(struct btf_distill *dist, __u32 i)
>
>  static int btf_add_distilled_types(struct btf_distill *dist)
>  {
> -	bool adding_to_base = dist->pipe.dst->start_id == 1;
> +	bool adding_to_base = dist->pipe.dst->base_btf == NULL;
>  	int id = btf__type_cnt(dist->pipe.dst);
>  	struct btf_type *t;
>  	int i, err = 0;

[ ... ]

> @@ -6065,8 +6461,12 @@ static int btf_add_distilled_types(struct btf_distill *dist)
>  		case BTF_KIND_CONST:
>  		case BTF_KIND_RESTRICT:
>  		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_FUNC:
>  		case BTF_KIND_FUNC_PROTO:
>  		case BTF_KIND_TYPE_TAG:
> +		case BTF_KIND_LOC_PARAM:
> +		case BTF_KIND_LOC_PROTO:
> +		case BTF_KIND_LOCSEC:
>  			/* All other types are added to split BTF. */
>  			if (adding_to_base)
>  				continue;

This isn't a bug, but can a base LOCSEC ever get a non-zero id_map entry
here? Looking at btf_add_distilled_type_ids():

tools/lib/bpf/btf.c:btf_add_distilled_type_ids() {
	switch (btf_kind(t)) {
	case BTF_KIND_CONST:
	case BTF_KIND_RESTRICT:
	case BTF_KIND_VOLATILE:
	case BTF_KIND_FUNC:
	case BTF_KIND_FUNC_PROTO:
	case BTF_KIND_TYPE_TAG:
	case BTF_KIND_LOC_PARAM:
	case BTF_KIND_LOC_PROTO:
		dist->id_map[*id] = *id;
		break;
	default:
		pr_debug("unexpected reference to base type %u kind %u\n", *id,
			 btf_kind(t));
		return -EINVAL;
	}
}

BTF_KIND_LOCSEC is not listed there. For a LOCSEC it falls to the default
branch, which prints "unexpected reference to base type" and returns
-EINVAL.

btf_add_distilled_types() only visits base ids with a non-zero map entry
(checking !dist->id_map[i] early). No BTF type refers to a LOCSEC by id
anyway, just as nothing refers to a DATASEC.

So the new BTF_KIND_LOCSEC label in btf_add_distilled_types() can never
run. The other kinds this patch adds (FUNC, LOC_PARAM, LOC_PROTO) were
added to both switches together, and the comparable DATASEC/VAR kinds
appear in neither. Could the BTF_KIND_LOCSEC label be dropped so the two
distill switches list the same kinds?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35993586374
--===============7895224760147842889==--
