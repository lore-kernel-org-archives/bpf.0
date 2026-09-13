Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC436A34F
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314579; cv=none; b=Qv6Z+MdLVTPL15dwZhaOh1kijTykuUwyZeh5WmDiEq8hhIpDhl1C063iKpOorG5Tb3El8vnjNOQHkzz5InFCUf2vO+lHIP7LfhYy9IBWRuOlJH1mAT4sqhB5vpLrVtn99JhDdaSvjQLtEAmuQHb0rlQ8Su/LBZ5wUnpcUdo9u8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314579; c=relaxed/simple;
	bh=J6bzpvZ0JNFwLWko4uclV/Pf/NdpHCNfh0ipvwncSyQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oTf16XXsdcA1MqY2mN75mmMv3iYlF/ySr8Js5geuB3qjAz5+V3OpT4WeX1Z/4HsJksqNU45Qgon47cnyebikWLM793x39U2OpiDZ6d5lZIkkOGJQyNUwknG26Ags+uE64Y0rvFuvHSandCptwJXp+KzVt/dBCMBmSQ4ROX5ZwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQISB6fM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQISB6fM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F86C1F00893;
	Sun, 13 Sep 2026 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789314578;
	bh=JvoZFHUGJNr4bz/V7zEDIVexhKKDrN/Wcys77fwhwKo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IQISB6fML4TOmqgY+FKbHHTwq6+HGD/iAB791wvvqWXi272zj9o27LfGlUUA3J++k
	 4xCbRDJO9EAvsPyv0dtrEcI8ptlTfyB4tMAWijT40z/d7pUTWL7KD3NS3KsS0Nz/HP
	 7rC1ryf+567pZkej9/vyTZruU58b5jOz+VRXCJCLrsZXnUJdRILBRbRlN8yqgoGV0g
	 SNxlf8Afe42+39pZD1QXu9oESEQIbEuYgkAyV4SggcVv1BkksUk8i4tkUkMwnMgLpD
	 WuP1UJxpngzLtzSNY0xr+3aJheWKDql5Bk4pQvEbui3Oc04ZamUunz/BziCwxe2PHF
	 m/M/S32k2iiaQ==
Content-Type: multipart/mixed; boundary="===============1654512824995584148=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f95d9c4509fc5c271f068c46f82a36d7e55e6ee7f556309696a45792dabc759@mail.kernel.org>
In-Reply-To: <20260913145233.1446643-3-caomingpei@gmail.com>
References: <20260913145233.1446643-3-caomingpei@gmail.com>
Subject: Re: [PATCH bpf v2 2/3] bpftool: Keep struct_ops field offsets when skipping bitfields
From: bot+bpf-ci@kernel.org
To: caomingpei@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ameryhung@gmail.com,qmo@kernel.org,caomingpei@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 13 Sep 2026 15:49:37 +0000 (UTC)

--===============1654512824995584148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521..d93073d5e7e3 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -1044,62 +1044,79 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
>  }
>
>  static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
> -				   const struct btf_type *map_type, __u32 map_type_id)
> +				   const struct btf_type *map_type)
>  {
> +	enum st_ops_shadow_kind {
> +		ST_OPS_SHADOW_SCALAR,
> +		ST_OPS_SHADOW_FUNC_PTR,
> +		ST_OPS_SHADOW_OPAQUE,
> +	};
>  	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts, .indent_level = 3);
>  	const struct btf_type *member_type;
> -	__u32 offset, next_offset = 0;
> +	__u64 bitfield_end = 0, map_bits;
> +	__u32 bit_offset, bitfield_size;
> +	__u32 map_size, offset, next_offset = 0;
>  	const struct btf_member *m;
>  	struct btf_dump *d = NULL;
>  	const char *member_name;
>  	__u32 member_type_id;
> -	int i, err = 0, n;
> -	int size;
> +	int align, err = 0, i, max_align = 1, n, size;
> +	enum st_ops_shadow_kind shadow_kind;
>
>  	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
>  	if (!d)
>  		return -errno;
>
> +	map_size = map_type->size;
> +	map_bits = (__u64)map_size * 8;
>  	n = btf_vlen(map_type);
>  	for (i = 0, m = btf_members(map_type); i < n; i++, m++) {
> -		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
>  		member_name = btf__name_by_offset(btf, m->name_off);
> +		bit_offset = btf_member_bit_offset(map_type, i);
> +		bitfield_size = btf_member_bitfield_size(map_type, i);
> +		if (bitfield_size) {
> +			if ((__u64)bit_offset < bitfield_end ||
> +			    (__u64)bit_offset < (__u64)next_offset * 8 ||
> +			    bit_offset > map_bits ||
> +			    bitfield_size > map_bits - bit_offset) {
> +				p_err("Invalid bitfield layout for struct_ops member %s",
> +				      member_name);
> +				err = -EINVAL;
> +				goto out;
> +			}
> +			bitfield_end = (__u64)bit_offset + bitfield_size;
> +			continue;
> +		}
>
> -		offset = m->offset / 8;
> -		if (next_offset < offset)
> -			printf("\t\t\tchar __padding_%d[%u];\n", i, offset - next_offset);
> +		if (bit_offset % 8 || bit_offset < bitfield_end) {
> +			p_err("Invalid offset for struct_ops member %s", member_name);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		offset = bit_offset / 8;
> +		if (offset < next_offset || offset > map_size) {
> +			p_err("Invalid offset for struct_ops member %s", member_name);
> +			err = -EINVAL;
> +			goto out;
> +		}

This isn't a bug, but the two error blocks above print the same message
and take the same error path.

Would folding the four conditions into one guard (or differentiating the
messages) make it clearer which check failed during debugging?

>
>  		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
>  		switch (btf_kind(member_type)) {
>  		case BTF_KIND_INT:
>  		case BTF_KIND_FLOAT:
>  		case BTF_KIND_ENUM:
>  		case BTF_KIND_ENUM64:
> -			/* scalar type */
> -			printf("\t\t\t");
> -			opts.field_name = member_name;
> -			err = btf_dump__emit_type_decl(d, member_type_id, &opts);
> -			if (err) {
> -				p_err("Failed to emit type declaration for %s: %d", member_name, err);
> -				goto out;
> -			}
> -			printf(";\n");
> -
> +			shadow_kind = ST_OPS_SHADOW_SCALAR;
>  			size = btf__resolve_size(btf, member_type_id);
> -			if (size < 0) {
> -				p_err("Failed to resolve size of %s: %d\n", member_name, size);
> -				err = size;
> -				goto out;
> -			}
> -
> -			next_offset = offset + size;
> +			align = btf__align_of(btf, member_type_id);
>  			break;
>
>  		case BTF_KIND_PTR:
>  			if (resolve_func_ptr(btf, m->type, NULL)) {
> -				/* Function pointer */
> -				printf("\t\t\tstruct bpf_program *%s;\n", member_name);
> -
> -				next_offset = offset + sizeof(void *);
> +				shadow_kind = ST_OPS_SHADOW_FUNC_PTR;
> +				size = sizeof(void *);
> +				align = __alignof__(void *);
>  				break;
>  			}
>  			/* All pointer types are unsupported except for
> @@ -1108,34 +1125,64 @@ static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
>  			fallthrough;
>
>  		default:
> -			/* Unsupported types
> -			 *
> -			 * Types other than scalar types and function
> -			 * pointers are currently not supported in order to
> -			 * prevent conflicts in the generated code caused
> -			 * by multiple definitions. For instance, if the
> -			 * struct type FOO is used in a struct_ops map,
> -			 * bpftool has to generate definitions for FOO,
> -			 * which may result in conflicts if FOO is defined
> -			 * in different skeleton files.
> -			 */
> +			shadow_kind = ST_OPS_SHADOW_OPAQUE;
>  			size = btf__resolve_size(btf, member_type_id);
> -			if (size < 0) {
> -				p_err("Failed to resolve size of %s: %d\n", member_name, size);
> -				err = size;
> +			align = 1;
> +			break;
> +		}
> +
> +		if (size < 0 || align < 0) {
> +			err = size < 0 ? size : align;
> +			p_err("Failed to resolve layout of %s: %d", member_name, err);
> +			goto out;
> +		}
> +		if ((__u32)size > map_size - offset ||
> +		    (align > 1 && offset % align)) {
> +			p_err("Invalid layout for struct_ops member %s", member_name);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (next_offset < offset)
> +			printf("\t\t\tchar __padding_%d[%u];\n", i, offset - next_offset);
> +
> +		switch (shadow_kind) {
> +		case ST_OPS_SHADOW_SCALAR:
> +			printf("\t\t\t");
> +			opts.field_name = member_name;
> +			err = btf_dump__emit_type_decl(d, member_type_id, &opts);
> +			if (err) {
> +				p_err("Failed to emit type declaration for %s: %d",
> +				      member_name, err);
>  				goto out;
>  			}
> +			printf(";\n");
> +			break;
> +		case ST_OPS_SHADOW_FUNC_PTR:
> +			printf("\t\t\tstruct bpf_program *%s;\n", member_name);
> +			break;
> +		case ST_OPS_SHADOW_OPAQUE:
> +			/* Avoid emitting named types that might conflict with
> +			 * definitions from other skeletons.
> +			 */
>  			printf("\t\t\tchar __unsupported_%d[%d];\n", i, size);
> -
> -			next_offset = offset + size;
>  			break;
> +		default:
> +			__builtin_unreachable();
                           ^^^^
>  		}

This isn't a bug, but the emission switch covers all three values of the
st_ops_shadow_kind enum, and shadow_kind is assigned on every path of
the classifying switch above.

Since the default arm can't be reached and this is the only
__builtin_unreachable() in tools/bpf/, would dropping it (or using
unreachable() from linux/compiler.h) keep -Wswitch coverage intact?

[ ... ]

> @@ -1177,7 +1224,7 @@ static int gen_st_ops_shadow_type(const char *obj_name, struct btf *btf, const c
>
>  	printf("\t\tstruct %s__%s__%s {\n", obj_name, ident, type_name);
>
> -	err = walk_st_ops_shadow_vars(btf, ident, map_type, map_type_id);
> +	err = walk_st_ops_shadow_vars(btf, ident, map_type);
>  	if (err)
>  		return err;
>

The patch adds a new member-type mapping: bitfield storage becomes part
of __padding_* instead of __unsupported_*. The comment before
gen_st_ops_shadow_type() explains the member-type mappings:

In gen.c:gen_st_ops_shadow_type():
 /*
  * A shadow type includes not all members, only members of some types.
  * They are scalar types and function pointers. The function pointers are
  * translated to the pointer of the struct bpf_program. The scalar types
  * are translated to the original type without any modifiers.
  *
  * Unsupported types will be translated to a char array to occupy the same
  * space as the original field, being renamed as __unsupported_*.  The user
  * should treat these fields as opaque data.
  */

This isn't a bug, but now that bitfield members disappear into __padding_*
instead of appearing as __unsupported_*, would adding a line about that
keep the documented member mapping complete?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34765254213
--===============1654512824995584148==--
