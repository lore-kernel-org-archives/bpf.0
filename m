Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB718331A44
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635561; cv=none; b=aQUTx+74dGdDM6ZSXv0XIvlOwfpGSjWNl0llWABSaOa9oK9OIRcAYEDmQpd7r9BS8mrt48Rk5hCcK6+zAuc0TdWBmw20hUWvBah2zMpzkxd99XJFLWFH0kF5EPSi9mvMBx/dOeB8tfSk7bb/fgcsS/6hFvcQsIDiKdJg+9tOeJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635561; c=relaxed/simple;
	bh=xRAnsk63hEPHzAYY/5s1W+Y7VqNWc6G6rnpC5TQG6+c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nDqvvvK3N2xKN6+JuQBGy/5YdwEqhr6vOBw4lY6TrLkJ2g3TLJ/r4xsdqoe2q/I8JOc1/P6T7YcW5Rqv95Iklws4gn6NmdJdDmoZDRn3xbO25cdr5zvX4Gd3NiIq2TJyIzJdRwd/NlcfWu04TzNiP8yT9Ut1A47MocM2xlTWswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vPHFnLJg; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vPHFnLJg"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137ec563a95so5582809c88.0
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781635559; x=1782240359; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NLIEWJdLWivuk8iq8yhitx8CxAOZpJDc0aqqsb3250=;
        b=vPHFnLJgZbn3SXz9pTeix6doV7dtQ3y/1bNMUZSffyr16W/L+rx0OwNIi+lwgIe1Yd
         sAw6I1WjhHUNaPD9ep9W+AXzw3LsqSitXrYqCSAU8aczRXwx3guRjMjg8RTvWXtfBfkV
         Awb3KF3iy8mjZHzd4Jt6+Y7gqiK5jCnifAetw9gG32KUmNU9pOsulzN7BkWGWljtyacb
         yZolZJp0BSwKoiCynFNTgjFijPISBW0YXl9so9bJZioTG/d3QGy9rip6qTyXfCXAZyNa
         OGrDdmQbkt9o16CRVrWAN/V8yk0tK5BPClI0eMEp9qiFBYGKrl6hGF2KpQdMAXjvIHbv
         mj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781635559; x=1782240359;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NLIEWJdLWivuk8iq8yhitx8CxAOZpJDc0aqqsb3250=;
        b=c4nfF8EmcPEZjAcwKDxsZAyIM9VOM/+fP3ih2dBL+ORAu+3hkeVGRwkSBXVsPeev87
         uS37VUBBFxB5bfLMFC7iiomVaUEbutOyBPYjEQjd7IIokfY8PnW4qBcemvVeIs/r18Pe
         FTlJO1zcTs4aH4Q2XkWsjG2KqmqbNSRM0wW4Tpsu+Kgq99SHfQAnRomCitQY9Yo7VVzO
         yzLIBHdYBJ3MeHVhhjuwkP31nQ2ywymIGYGAFeV2hwheTC7pYcbAVIxjgkxivzDZXXQ+
         2LIW5Z4tdYaDoZyDlmkRlLnurqT0o9X0LPWv64hiFmYYQ+yiI1+QxiMgjhMnZyfk/fdm
         Vhag==
X-Forwarded-Encrypted: i=1; AFNElJ+9L7WkxM681fGnhfOqRCN9KMfV8J6AIRa4yZ4bkHePYk3yy3BOYu5o8QDO75UDwvF3/9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1cC61525xpXaT9KgI7VhLhxTvd3wNyoslOGNfSd1SMC9+6zw
	n8y2Ej6LfcY1ADauBtz/hg/Ck7ZQv+pR+IZWhYvntZXxkl8ZUvpNlEUeYn3zOjK12No=
X-Gm-Gg: Acq92OG6PHgwN54Eh6GA1tFMHHYkYV7F4m/W/UmN4cm/ZUh+wg2+b8vF5EfPOWUMNkN
	wt5xFBgaB4wTCaIqGP0F7pPmRqczWP1ieITU7ttmvIxHSPJmVzd1UQw1nmVI1Zeo7krdtkfMQwR
	C6mNBvNL/aqFrKnC9MDsdD/W6ElCXRo0hiIzhO0Spbj3Y/SaVAOZWez5sQ0PhHJiac07Zs0zmW+
	6QS/ciHL/cUwypHviFfa5rLrn0tSOm7QfzwBYmCWCIfx8ePNHUDDVG2EysddqDhAU15w8aMdyOl
	+zY07I05MtenouZ6wXSoz7Sttz4/AcfU406JTDaFMODJHQkvAG4IrJ0In9EvyN5aSOUvXQnTo3X
	H62lS5cILoTtnpsKN5+fCwfrGa/BkrfXiB898rqf2ZhtY7Ap/zPdDPb67nNvFW8i4Pew8jV8PTM
	LxDAUm
X-Received: by 2002:a05:7022:f92:b0:135:f5ed:868 with SMTP id a92af1059eb24-1398f6c9a68mr109659c88.17.1781635558681;
        Tue, 16 Jun 2026 11:45:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b910c51sm14191480c88.4.2026.06.16.11.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 11:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 14:45:56 -0400
Message-Id: <DJAP3FDYA9GP.O5139CT1RYW3@etsalapatis.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 05/14] resolve_btfids: Index BTF ID symbols
 by address
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-6-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-6-ihor.solodrai@linux.dev>

On Mon Jun 1, 2026 at 6:17 PM EDT, Ihor Solodrai wrote:
> Keep an address-sorted index of parsed .BTF_ids symbols so code that
> the original BTF_ID symbol name can be recovered from an entry
> address.
>
> Use the index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
> directly and match each entry back to the requested kfunc.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Some notes on clarity below.

> ---
>  tools/bpf/resolve_btfids/main.c | 103 +++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 23 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index f8a91fa7584f..43512af13148 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -119,6 +119,11 @@ struct btf_id {
>  	Elf64_Addr	 addr[ADDR_CNT];
>  };
> =20
> +struct addr_sym {
> +	Elf64_Addr	 addr;
> +	const char	*name;
> +};
> +
>  struct object {
>  	const char *path;
>  	const char *btf_path;
> @@ -150,6 +155,10 @@ struct object {
>  	int nr_structs;
>  	int nr_unions;
>  	int nr_typedefs;
> +
> +	struct addr_sym *addr_syms;
> +	int nr_addr_syms;
> +	int max_addr_syms;
>  };
> =20
>  #define KF_IMPLICIT_ARGS (1 << 16)
> @@ -480,6 +489,49 @@ static int elf_collect(struct object *obj)
>  	return 0;
>  }
> =20
> +static int push_addr_sym(struct object *obj, Elf64_Addr addr, const char=
 *name)
> +{
> +	struct addr_sym *arr =3D obj->addr_syms;
> +	int cap =3D obj->max_addr_syms;
> +
> +	if (obj->nr_addr_syms + 1 > cap) {
> +		cap =3D max(cap + 256, cap * 2);
> +		arr =3D realloc(arr, sizeof(*arr) * cap);
> +		if (!arr)
> +			return -ENOMEM;
> +		obj->max_addr_syms =3D cap;
> +		obj->addr_syms =3D arr;
> +	}
> +
> +	obj->addr_syms[obj->nr_addr_syms].addr =3D addr;
> +	obj->addr_syms[obj->nr_addr_syms].name =3D name;
> +	obj->nr_addr_syms++;
> +
> +	return 0;
> +}
> +
> +static int cmp_addr_sym(const void *a, const void *b)
> +{
> +	Elf64_Addr aa =3D ((const struct addr_sym *)a)->addr;
> +	Elf64_Addr ab =3D ((const struct addr_sym *)b)->addr;
> +
> +	if (aa < ab)
> +		return -1;
> +	if (aa > ab)
> +		return 1;
> +	return 0;
> +}
> +
> +static const char *find_name_by_addr(struct object *obj, Elf64_Addr addr=
)
> +{
> +	struct addr_sym key =3D { .addr =3D addr };
> +	struct addr_sym *res;
> +
> +	res =3D bsearch(&key, obj->addr_syms, obj->nr_addr_syms,
> +		      sizeof(*obj->addr_syms), cmp_addr_sym);
> +	return res ? res->name : NULL;
> +}
> +
>  static int symbols_collect(struct object *obj)
>  {
>  	Elf_Scn *scn =3D NULL;
> @@ -573,8 +625,14 @@ static int symbols_collect(struct object *obj)
>  			return -1;
>  		}
>  		id->addr[id->addr_cnt++] =3D sym.st_value;
> +
> +		if (push_addr_sym(obj, sym.st_value, id->name))
> +			return -1;
>  	}
> =20
> +	qsort(obj->addr_syms, obj->nr_addr_syms, sizeof(*obj->addr_syms),
> +	      cmp_addr_sym);
> +
>  	return 0;
>  }
> =20
> @@ -946,43 +1004,41 @@ static int collect_decl_tags(struct btf2btf_contex=
t *ctx)
>  }
> =20
>  /*
> - * To find the kfunc flags having its struct btf_id (with ELF addresses)
> - * we need to find the address that is in range of a set8.
> - * If a set8 is found, then the flags are located at addr + 4 bytes.
> + * To find kfunc flags, scan BTF_SET8_KFUNCS entries and use the entry
> + * address to recover the corresponding BTF_ID symbol name.
>   * Return 0 (no flags!) if not found.
>   */
>  static u32 find_kfunc_flags(struct object *obj, struct btf_id *kfunc_id)
>  {
>  	const u32 *elf_data_ptr =3D obj->efile.idlist->d_buf;
> -	u64 set_lower_addr, set_upper_addr, addr;
>  	struct btf_id *set_id;
>  	struct rb_node *next;
> -	u32 flags;
> -	u64 idx;
> +	u64 idx, set_addr;
> +	u32 set_flags;
> =20
>  	for (next =3D rb_first(&obj->sets); next; next =3D rb_next(next)) {
>  		set_id =3D rb_entry(next, struct btf_id, rb_node);
>  		if (set_id->kind !=3D BTF_ID_KIND_SET8 || set_id->addr_cnt !=3D 1)
>  			continue;
> =20
> -		set_lower_addr =3D set_id->addr[0];
> -		set_upper_addr =3D set_lower_addr + set_id->cnt * sizeof(u64);
> +		set_addr =3D set_id->addr[0];
> +		idx =3D (set_addr - obj->efile.idlist_addr) / sizeof(u32) + 1;

Is the +1 because the set8-global flags are in &((char *)btf_id_set8)[4]?
If that's the case, can you add a comment that you're checking the
set-global flags to decide whether to skip all of it?

> +		set_flags =3D elf_data_ptr[idx];
> +		if (!(set_flags & BTF_SET8_KFUNCS))
> +			continue;
> =20
> -		for (u32 i =3D 0; i < kfunc_id->addr_cnt; i++) {
> -			addr =3D kfunc_id->addr[i];
> -			/*
> -			 * Lower bound is exclusive to skip the 8-byte header of the set.
> -			 * Upper bound is inclusive to capture the last entry at offset 8*cnt=
.
> -			 */
> -			if (set_lower_addr < addr && addr <=3D set_upper_addr) {
> -				pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
> -					 kfunc_id->name, set_id->name);
> -				idx =3D addr - obj->efile.idlist_addr;
> -				idx =3D idx / sizeof(u32) + 1;
> -				flags =3D elf_data_ptr[idx];
> -
> -				return flags;
> -			}
> +		for (u32 i =3D 0; i < set_id->cnt; i++) {
> +			Elf64_Addr addr =3D set_addr + sizeof(u64) * (i + 1);

Same here, can you point out that the +1 is to skip the set header?

> +			const char *name =3D find_name_by_addr(obj, addr);
> +
> +			if (!name || strcmp(name, kfunc_id->name) !=3D 0)
> +				continue;
> +
> +			pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
> +				 kfunc_id->name, set_id->name);
> +
> +			idx =3D (addr - obj->efile.idlist_addr) / sizeof(u32) + 1;

This seems to be the same calculation as we do for the whole set8 flag,
but AFAICT the context is different and here we're indexing into the pair.=
=20
Can you add a comment for this?

> +			return elf_data_ptr[idx];
>  		}
>  	}
> =20
> @@ -1575,6 +1631,7 @@ int main(int argc, const char **argv)
>  	btf_id__free_all(&obj.typedefs);
>  	btf_id__free_all(&obj.funcs);
>  	btf_id__free_all(&obj.sets);
> +	free(obj.addr_syms);
>  	if (obj.efile.elf) {
>  		elf_end(obj.efile.elf);
>  		close(obj.efile.fd);

