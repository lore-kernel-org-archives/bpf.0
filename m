Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E13191CA;
	Fri,  9 Oct 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548689; cv=none; b=YD9IxWA5/f17+VHzFvj5m/SN96FNTVNjKlA75GcpLOZKbOziwOVSEgyZHtVDYNqmkx4lBStvz5JvJo4uIAoaQVOiYu6dY2GpWqIJFZmPz1Vv8ZCN0Q0xa0JaOIXgd0UKxmKMRhitPO0UCl/YeqJeQJpIQO7as065ZeizulKq5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548689; c=relaxed/simple;
	bh=GNPXp5TSDaZ9s9VsGkE560mF5gLhNeE/YZvasMnLIaw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FjHducdCcqJMjP9hK2TmQ4Ga6KaxBgthiR4imgNr4Uk+I5eN0D1ZA8WY0rbZFi9Um83Q1RvZA2tn1swbi+y2myYjN3e5qam7KqF4hEv6EY9UBtIJX/AyjrDyPSk9J03iyok1bLwwPoi5OzJjUrcRdTecf24FZYeSjInM444DKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXLuaLwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXLuaLwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E661F0089A;
	Fri,  9 Oct 2026 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548674;
	bh=m3LbzxdD+Z4kbYiZ74k8kJPTl7r73rA79YalsrpkVWE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aXLuaLwV5KOkm5gUgjC0ymQY+5xPni58n1XF1GyvFuHr1L+LlfotLYPDphKMK6rI+
	 DwbtWmneE2q3O4XV5ZA2j4VojgZezJ8udIWcVGDDnADfwkHlHT0wZHS/2jQ8/i2CJZ
	 KDhl3/KBCBBenn/2w7N1GTm992At1WvUTJ3c8G1qDf6AEYkERKxKZ/Hp3d3mYPCOjd
	 Yzh5vM4PNMYkVppd6YxQrxiCiW6K0Rtlrq2LAXQDvtOkoHu9XX0fmwRFdqtzuCfIBY
	 v3+64g4MjHtVf5udANbtBfmD2u8Hs8Ces3d4fmuczYpV1g6QyoxVwiY/mWLrulRYEe
	 zYE7WQAoYPuXw==
Content-Type: multipart/mixed; boundary="===============3944681764367478333=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1be442d823b7401f5af5560c94af64d5a38280500169790a3d72073d196a075c@mail.kernel.org>
In-Reply-To: <20261009112324.1442319-3-alan.maguire@oracle.com>
References: <20261009112324.1442319-3-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 bpf-next 2/7] resolve_btfids: Populate BTF link section
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org
Cc: ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,nathan@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,arnaldo.melo@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:24:31 +0000 (UTC)

--===============3944681764367478333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Populate BTF link section

TL;DR: Nits only, no bugs found: patch_btf_link() duplicates much of
patch_btfids() and reopens vmlinux repeatedly, runs a full elf_collect() just
for class/encoding, and could use ensure_mem().

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 15e7be13061f..f737fac60fa2 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -267,6 +282,49 @@ static int __ensure_mem(void **data, u32 *cap, u32 cnt, size_t elem_sz)
>  #define ensure_mem(arr_ptr, cap_ptr, cnt) \
>  	__ensure_mem((void **)(arr_ptr), (cap_ptr), (cnt), sizeof(**(arr_ptr)))
>  
> +static int parse_btf_link(const struct option *opt, const char *arg, int unset)
> +{
> +	struct btf_links *links = opt->value;
> +	struct btf_link *link;
> +	char *separator;
> +
> +	if (unset)
> +		return -EINVAL;
> +	if (__ensure_mem((void **)&links->links, &links->cap, links->cnt + 1,
> +			 sizeof(*links->links)))
> +		return -ENOMEM;

this isn't a bug, but could parse_btf_link() use the ensure_mem() macro
defined right above it, the way the other callers in main.c do?

ensure_mem(&links->links, &links->cap, links->cnt + 1) would expand to the
same __ensure_mem() call.

[ ... ]

> @@ -1030,6 +1089,153 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
>  	return 0;
>  }
>  
> +static int patch_btf_link(struct object *obj, const struct btf_link *link)
> +{
> +	char section[128];

[ ... ]

> +	fd = open(obj->path, O_RDWR);
> +	if (fd < 0) {
> +		err = -errno;
> +		pr_err("FAILED to open %s: %s\n", obj->path, strerror(errno));
> +		goto out;
> +	}
> +	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
> +	if (!elf) {
> +		err = -EINVAL;
> +		pr_err("FAILED to create ELF descriptor for %s: %s\n",
> +		       obj->path, elf_errmsg(-1));
> +		goto out;
> +	}
> +	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
> +	if (elf_getshdrstrndx(elf, &shdrstrndx)) {
> +		pr_err("FAILED to get section name index from %s: %s\n",
> +		       obj->path, elf_errmsg(-1));
> +		goto out;
> +	}
> +	while ((scn = elf_nextscn(elf, scn))) {
> +		if (gelf_getshdr(scn, &sh) != &sh) {
> +			pr_err("FAILED to get section header from %s: %s\n",
> +			       obj->path, elf_errmsg(-1));
> +			goto out;
> +		}
> +		name = elf_strptr(elf, shdrstrndx, sh.sh_name);
> +		if (name && !strcmp(name, section))
> +			break;
> +	}
> +	if (!scn) {
> +		pr_err("FAILED: section %s not found in %s\n", section, obj->path);
> +		goto out;
> +	}
> +	data = elf_getdata(scn, NULL);
> +	if (sh.sh_type != SHT_PROGBITS || !data || !data->d_buf ||
> +	    data->d_size != module_name_len +
> +		BTF_SHA256_DIGEST_LENGTH + sizeof(u32)) {
> +		pr_err("FAILED: section %s is not a writable BTF link\n", section);
> +		goto out;
> +	}

this isn't a bug, but most of patch_btf_link() repeats what patch_btfids()
already does: the open(O_RDWR) / elf_begin(ELF_C_RDWR_MMAP) /
elf_getshdrstrndx() setup, the loop that looks up a section by name,
elf_getdata(), and the elf_flagdata(ELF_F_DIRTY) / elf_update(ELF_C_WRITE) /
elf_end() / close() teardown.

This also means the final pass opens and rewrites vmlinux once for
.BTF_ids and then again for each --btf_link.

Could patch_btfids() and patch_btf_link() share a helper that opens the ELF
and finds a section by name, or even use a single RDWR descriptor?

[ ... ]

> @@ -1916,12 +2125,30 @@ int main(int argc, const char **argv)

[ ... ]

>  	obj.path = argv[0];
>  
> -	if (btfids_path)
> -		return patch_btfids(btfids_path, obj.path);
> +	if (btfids_path) {
> +		err = patch_btfids(btfids_path, obj.path);
> +		if (err || !btf_links.cnt)
> +			goto out;
> +		if (elf_collect(&obj)) {
> +			err = -EINVAL;
> +			goto out;
> +		}

this isn't a bug, but the --btf_link path runs the whole elf_collect() pass
only to get EI_CLASS and EI_DATA for patch_btf_link().

elf_collect() opens a second descriptor and mmap of the target, walks every
section, and byte-swaps .BTF_ids in its private map.  patch_btf_link() then
opens the same file again with its own Elf handle.

Since patch_btf_link() already calls elf_begin(), could it read the class
and data encoding directly with gelf_getehdr() / gelf_getclass(), so that
this elf_collect() call and the new efile.elf_class field aren't needed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37924786344
--===============3944681764367478333==--
