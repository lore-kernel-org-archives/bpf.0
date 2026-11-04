Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757598;
	b=mlWqARMGBMB2n1xBGzTv3Awf1knw+TNCTS32QmiMaJsWicNTqILj4fDCLSbSp4o8ih/k
	 aFWyFzaPvsTMQ+TEUs/TdRpLm2dLs4SK8SdKzGLEX8P8f08ZgPbE/WZC+zkiMCWktV1CW
	 kXW9g1fkwcSVCwRovNGVd3KmlitUy38m95iEShKUbqU+av1a4f3lGQpP+gDT37CJ26uwH
	 fkX3yzPx207H0aaPJouRI/ZbSGDIC9eZ7Menoo+1uYYKVnmusKycT5g6I0L4RFrtSyFDs
	 8AgEvwi2D+hszLhbMGh0wbm/oayAxo8j8OX619/ieydVmI3xW9pNLWL9Koz/NLwBUIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757598;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DziIWny+EryIIzxpECVnaqZQBxEibksCkS5nexBxXMk=;
	b=rYeIc59tmYVtTeOznBC6XIFjC+lVLokoiRum24G0xROzQjkKAecy0EuSOZicnlSNcZ1f
	 zN5dHkBDTDiGrb1BapTkLgKm2koLWDhaylX6DvERtVkkjXwyI41QfWUgs4twBaC/UF/9R
	 Uhd1b+f/2MCdc0zOkNcW7B0FFgLjjiKBBm5uTyvH8PWpw9crRU2uyPwOJJ6mmDRy4yPWO
	 ldy7Izf64P19uGBtr1a6+Jm+PI5V9A4B1hauailZRsu1KzM5MfP0szFxrAScU5PIBYn66
	 T7p7mKQ1kJyu6EgITJJek8fOAsErB8xxg4hluPRQ3XatcjT7+ZOPHVIBF8S+0Pqw3WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YH/Z3pC3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3E606A330
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YH/Z3pC3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FF51F00A02;
	Wed,  4 Nov 2026 01:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757597;
	bh=DziIWny+EryIIzxpECVnaqZQBxEibksCkS5nexBxXMk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YH/Z3pC3N0CeZinqJHPALB9Yqv2AJtipMZJxQz07rk3jUb9eyDPNLJmR7wUtRmyX8
	 locacySK5WhPVbE4hXopG6iFF3HaaSq1KislMLs4rETRqY2XbP0sSppLmydOpX/Y/5
	 hO3ZQPYf5xlmKLjSJcwBo6V6QpLHykAs5bF5ZhvN4QyJ6xZhR0z1KCSqv4NkWF7ARl
	 hmMkyWWj/LguM8GFQZtibITWwN4YS4+WZUy7L/N6E5puD7tkfxjxwWeFOL+MhSimy+
	 cqBue2OB3OJ+gCbEfcDHQRsR6aIYoGV8x8WoxyQrIcaF+WAqBT6srvedxqiaJ4n8HB
	 TlswFH9VD0zsw==
Content-Type: multipart/mixed; boundary="===============3815707460850906486=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f4144b15c814d1c4ed9be5e4e4f4f8f5746bb7638ad8234210e5dd2524b1e151@mail.kernel.org>
In-Reply-To: <20261104012401.1354861-7-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are stored in arena
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 01:59:57 +0000 (UTC)

--===============3815707460850906486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Relocate pointers that are stored in arena

TL;DR:
- libbpf arena relocation may not bounds-check r_offset, so a crafted object
  could crash or corrupt memory at load
- a second arena relocation section may leak the array and let the count
  overrun it

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +/* The arena is mapped. The address of a variable is the same for the program and for user space. */
> +static void relocate_arena_ptrs(struct bpf_object *obj, const struct bpf_map *arena)
> +{
> +	void *data = arena->mmaped + obj->arena_data_off;
> +	struct arena_ptr *p = obj->arena_ptrs;
> +	__u64 val;
> +	size_t i;
> +
> +	for (i = 0; i < obj->arena_ptr_cnt; i++, p++) {
> +		memcpy(&val, data + p->off, sizeof(val));
> +		val += (__u64)(unsigned long)data + p->targ_off;
> +		memcpy(data + p->off, &val, sizeof(val));
> +	}
> +}

[ ... ]

> +static int bpf_object__collect_arena_relos(struct bpf_object *obj,
> +					   Elf64_Shdr *shdr, Elf_Data *data)
> +{

[ ... ]

> +	ptrs = libbpf_reallocarray(NULL, nrels, sizeof(*ptrs));
> +	if (!ptrs)
> +		return -ENOMEM;
> +	obj->arena_ptrs = ptrs;

[ ... ]

> +		ptrs->off = rel->r_offset;
> +		ptrs->targ_off = sym->st_value;
> +		if (sym->st_shndx == obj->efile.arena_bss_shndx)
> +			ptrs->targ_off += obj->arena_bss_off;
> +		obj->arena_ptr_cnt++;
> +	}
> +	return 0;
> +}

Can rel->r_offset point past the end of the arena data here?  It is stored
in ptrs->off without being compared against the size of the .addr_space.1
data.

At load, relocate_arena_ptrs() reads and writes 8 bytes at data + p->off:

    memcpy(&val, data + p->off, sizeof(val));
    ...
    memcpy(data + p->off, &val, sizeof(val));

When FEAT_LDIMM64_FULL_RANGE_OFF is supported, arena_data_off is
mmap_sz - roundup(arena_data_sz, page), so an r_offset larger than
roundup(arena_data_sz, page) - 8 lands beyond the arena mapping.  A crafted
object would open fine and then crash or corrupt memory in
bpf_object__load().

The sibling collectors reject such offsets, for example
bpf_object__collect_rodata_relos():

    rel->r_offset >= scn_data->d_size ||
    scn_data->d_size - rel->r_offset < sizeof(__u64)

Should this function do a similar check and return -LIBBPF_ERRNO__FORMAT?

Also, obj->arena_ptrs is overwritten on every call while obj->arena_ptr_cnt
keeps accumulating.  If a malformed object has two SHT_REL sections whose
sh_info refers to the arena section, the first array is leaked and
arena_ptr_cnt can exceed the size of the second array:

    obj->arena_ptrs = ptrs;
    ...
    obj->arena_ptr_cnt++;

relocate_arena_ptrs() would then read past the heap allocation and use
garbage off values as write targets.  Should a second call be rejected when
obj->arena_ptrs is already set?

No later commit in the series touches tools/lib/bpf, so neither case is
addressed later.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41755299448
--===============3815707460850906486==--
