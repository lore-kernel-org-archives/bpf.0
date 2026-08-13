Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54783EC808
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624003; cv=none; b=PnxOiFKKtSJa14jn4NfXE+Qgh+HvgwjHreC2Q3RAk8IfJW3eRCx4IjctrZ267ELXUr9G9seN+OATfWc5gVxF3chDy/unP9KlIDJ9AIkre9syX8dhynizM57WHGbOkHGE7WVl8NtXkb4OK28GoQbuxpgcQdi8xPTHbosV7VhaWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624003; c=relaxed/simple;
	bh=3JbHfK9FcR++nuagWKIwUnHsIS96JweeRo0eJxgVkoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjMJJcoIC8IFrin6MusYEcgBv4HZosSvZdnuergbIUBVl1mCBM6IfA1vWJtX15lnBbUiJgiENTMSWqDwhpVN2hfBxzRNfSaHQbWS7BrPIDL7lrzrreQEc49KHaQEtfcFE1sTBzZSRrvpAfcE2ZaFQlqLgKvEluvm1qs+RZdurag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhrOMi3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhrOMi3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972071F00A3D;
	Thu, 13 Aug 2026 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786624001;
	bh=gKB1IrcLZ1rG1gE2jNCMbPmtKXVLXpkM19NAZsgqrus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AhrOMi3nqqNz1NkQ32X3u2efIs6nd8jrXdsF9CGOxQrcIkVYAZTjanfNs2dCi9DML
	 Wkjn+j/nO3y7HticSz1vxQ4NjGcSEJXJJs8pboelzWqY7xlCpAMDEX0wAO0+bzRH7G
	 wf0YeiXgPFa+a4M6iszyEhK2w3FilyrE9k4LwgtXYFSlPl6ItrG7/3V6jo3C9BkPpt
	 jmglsGM+F6TEoA8CVLPb/xmT0l+LQwoPLuE0m11Pb/O6h/SHpMW4japP0NhyG/XY40
	 dh9FxZXhsPdLLcUfLF+jfKvF8D9UtnZ37GB4yzZ4rxX+nzsP0KZZKEHSjdjK6V/2if
	 wikNqLUp/+3Xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: fix percpu map update indexing with sparse CPU
 IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813120250.796934-4-sh_def@163.com>
References: <20260813120250.796934-4-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 12:26:41 +0000
Message-Id: <20260813122641.972071F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds memory corruption due to flawed CPU ID validation fo=
r BPF_F_CPU flag in percpu map updates
- [Medium] Uninitialized kernel memory is leaked to userspace during per-CP=
U map lookups for maps containing BTF records
--

--- Patch [1]: [PATCH bpf] bpf: fix percpu map update indexing with sparse =
CPU IDs ---
commit b07c9975556416a89c7747b25d4ce94bbf581021
Author: Hui Su <sh_def@163.com>

bpf: fix percpu map update indexing with sparse CPU IDs

This commit fixes an issue where per-CPU map update paths calculated source
offsets using logical CPU IDs rather than advancing the offset for each
possible CPU. This resolves out-of-bounds reads and incorrect values on
systems with sparse CPU topologies.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178cd..cc3f8c25a28b5 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
[ ... ]
> @@ -437,9 +437,10 @@ int bpf_percpu_array_update(struct bpf_map *map, voi=
d *key, void *value,
>  	}

[Severity: High]
This is a pre-existing issue, but does the BPF_F_CPU flag path have a
bounds checking issue with sparse CPU topologies?

Looking at bpf_map_check_op_flags() in include/linux/bpf.h, it validates
the CPU ID against num_possible_cpus():

include/linux/bpf.h:bpf_map_check_op_flags() {
        ...
        cpu =3D flags >> 32;
        if ((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())
                return -ERANGE;
        ...
}

If a system has sparse CPU topologies, can a user pass a CPU ID that is
less than num_possible_cpus() but not in the cpu_possible_mask? If so,
this would allow an impossible CPU ID to be passed to per_cpu_ptr() just
above this loop in bpf_percpu_array_update(), returning an invalid
pointer that copy_map_value() then writes to.

>  	for_each_possible_cpu(cpu) {
>  		ptr =3D per_cpu_ptr(pptr, cpu);
> -		val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
> +		val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + off;
>  		copy_map_value(map, ptr, val);

[Severity: Medium]
This is a pre-existing issue, but can per-CPU map lookups leak uninitialized
kernel memory to userspace when the map contains BTF records?

When looking up a per-CPU map, the lookup buffer is allocated via kvmalloc()
without __GFP_ZERO:

kernel/bpf/syscall.c:map_lookup_elem() {
        ...
        err =3D -ENOMEM;
        value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
        if (!value)
                goto free_key;
        ...
}

For each CPU, bpf_obj_memcpy() (which bypasses bpf_long_memcpy when BTF
records are present) copies exactly map->value_size bytes. If map->value_si=
ze
is not a multiple of 8, it leaves the alignment padding uninitialized. When
this entire buffer is subsequently copied to userspace via copy_to_user(),
will it leak the uninitialized padding bytes?

>  		bpf_obj_cancel_fields(map, ptr);
> +		off +=3D size;
>  	}
>  unlock:
>  	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813120250.7969=
34-4-sh_def@163.com?part=3D1
