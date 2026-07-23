Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4E270EC3
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784790206; cv=none; b=sWniBApJxD3Ocj4S5Aj0Gd+ZvitI7MBckpeZL0MlBfhq5fnDBGrczcFci+90+QWjUEUV7UK86ND0qZ0anlcG1iorjifiJJcEASKQNHNt4mpYOG3TROCEsOnkcSZTktiLufMepy7h9izHSeUvUVruhMJUgGPpvixW6Gg/UEfHZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784790206; c=relaxed/simple;
	bh=9cI9fuqc2Pki0/GfzxwDYS0Eos1a01vN9iDVjhxr3ZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i6BB5w2CoDDvsdnae3FHMMPrhmC0v2Cldp54/8glvqImWtAR5XEEB6ehUGATZzWirMxl80LEbz9k/VwDvFukFt/eG+/HA6gW3v9/7AFQ2lIlJCly+Ynj29kYe+xxnHI2cUuLi9c3NVM9y4Tpwxw2b3YVmK+JdhymjHCIDZ/4SdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnI22mSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnI22mSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389781F000E9;
	Thu, 23 Jul 2026 07:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784790204;
	bh=bi4CvtAzmUwk4wgjHAj2B14yDpGjbG7jsfKjXdjtcKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnI22mSMjlaQ5sI0J/apocVmE9SOGTMs4G1Oj+pvdZyZC14blmA/x7NzPn7A4VtR1
	 H2O0K7A+S0UdR4tmlKVZPHZG3D9y23AbPxmJXKnWYCT1RiZnrQqBtwV2pnArmqjlos
	 +nAUmdwMY9G0ReRHjS9CIR6s9XCrJ3JxU0a6jxyx5e9aFCxyOT0M/p3+H2fXc7wTg6
	 zt5mZfeFzA/l2JkwPzDyOvP/F6McDzuTkGyOdtadz3G+laMm62HwFp+gycQAszheWr
	 1R7j9nUy7aIysmRfiQO4T+9d78qDQzmfdV5ssPN4j9GuJWfpZobUElGu656gr/UOoy
	 eFPPQc57JLfjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: bounds-check struct_ops member offset before
 writing shadow pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naveed Khan" <naveed@digiscrypt.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <178478913040.2.14225985431891987705@digiscrypt.com>
References: <178478913040.2.14225985431891987705@digiscrypt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:03:23 +0000
Message-Id: <20260723070324.389781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The new multi-line comment introduced in the patch violates the BPF=
 subsystem comment style guidelines.

Pre-existing issues:
- [High] Integer overflows in bounds checks during BTF and ELF parsing allo=
w heap out-of-bounds reads.
- [High] Incomplete Fix: Missing bounds check in `bpf_map__init_kern_struct=
_ops` allows heap out-of-bounds read leaking memory to the kernel.
--

--- Patch [1]: [PATCH] libbpf: bounds-check struct_ops member offset before=
 writing shadow pointer ---
commit edbb05326b1be4436b6fa2f85e4c2b2097d884b7
Author: Naveed Khan <naveed@digiscrypt.com>

libbpf: bounds-check struct_ops member offset before writing shadow pointer

This commit adds a bounds check in bpf_object__collect_st_ops_relos() to
ensure that writing the shadow pointer for a struct_ops member doesn't
overflow the map's value size. It prevents a controlled heap out-of-bounds
write that can occur when parsing malformed BTF data.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1368752aa13c3..1aa2a1d098927 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10529,6 +10529,17 @@ static int bpf_object__collect_st_ops_relos(stru=
ct bpf_object *obj,
>  			return -EINVAL;
>  		}
> =20
> +		/* the shadow pointer stored below is sizeof(struct bpf_program *)
> +		 * bytes wide, so the whole write must fit within st_ops->data,
> +		 * which is only map->def.value_size bytes long. A malformed BTF
> +		 * can place a member near the end of the value and overflow it.
> +		 */

[Severity: Low]
Is this multi-line comment using the correct BPF subsystem style?

The guidelines indicate that multi-line comments must have the opening /* on
its own line, with the comment text starting on the next line.

> +		if (moff + sizeof(struct bpf_program *) > map->def.value_size) {
> +			pr_warn("struct_ops reloc %s: member %s at moff %u overflows map valu=
e size %u\n",
> +				map->name, name, moff, map->def.value_size);
> +			return -EINVAL;
> +		}
> +
>  		prog =3D find_prog_by_sec_insn(obj, shdr_idx, insn_idx);

[Severity: High]
This is a pre-existing issue, but since this patch fixes a missing bounds
check for struct_ops offsets, could a similar missing bounds check exist in
bpf_map__init_kern_struct_ops()?

tools/lib/bpf/libbpf.c:bpf_map__init_kern_struct_ops() {
    ...
		moff =3D member->offset / 8;
		mdata =3D data + moff;
		msize =3D btf__resolve_size(btf, member->type);
    ...
		memcpy(kern_mdata, mdata, msize);
    ...
}

If a malformed BTF provides a struct_ops member with a large offset, could
this result in an out-of-bounds heap read from mdata that is then copied
into the kernel-bound buffer kern_mdata?


[Severity: High]
This is also a pre-existing issue, but can the 32-bit arithmetic used in
the bounds checks for BTF and ELF parsing overflow?

tools/lib/bpf/libbpf.c:init_struct_ops_maps() {
    ...
		if (vsi->offset + type->size > data->d_size) {
			pr_warn("struct_ops init: var %s is beyond the end of DATASEC %s\n",
				var_name, sec_name);
			return -EINVAL;
		}
    ...
}

Since vsi->offset and type->size are 32-bit integers, could a maliciously
crafted large vsi->offset (e.g., 0xFFFFFFF0) cause the addition to wrap
around and bypass the check against the 64-bit data->d_size, leading to an
out-of-bounds read during the subsequent operations?

A similar 32-bit overflow appears to exist in create_jt_map() when parsing
the .jumptables section:

tools/lib/bpf/libbpf.c:create_jt_map() {
    ...
	if (sym_off + jt_size > obj->jumptables_data_sz) {
		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access=
 %d\n",
			obj->jumptables_data_sz, sym_off + jt_size);
		err =3D -EINVAL;
		goto err_close;
	}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178478913040.2.1422=
5985431891987705@digiscrypt.com?part=3D1
