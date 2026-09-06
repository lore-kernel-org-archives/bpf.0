Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C043B8934
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715254; cv=none; b=Tz79r17lubUqasMHNnM6yo8+d/vqhzx8ryMbN6V97fbLLhrq4KxuSTwEwpV8M+TgiJcevbS8EW8cdF2BiD6Z8VNXIUWhebU8hplX66jpIpBTQ2HqJwnSwVfbqvsAc8dvT4Iahqci5ojt9xusZPBTmlDPt4yyoiRU7WFcXW0aVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715254; c=relaxed/simple;
	bh=g8QlHbaIA+F21fU5jaLfuUVZhyYEOG06j/37lqMsD10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rwELZs4C4yeKWzNJBM80TToHPlK9PEbexpiFNuUoq9oY+bgj5QBsvfJfT3QUb1p7jKINrkKgE3uMaIZYOa4z8uRknuEBBbZWH8OLVLYe9JAu7A6XK5rnU+OUND80l/vrEB0pOeaqMAPeKibVIrRhel5RGYhHSsWrUtectMQMSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnk5bvxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnk5bvxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1431F00A3A;
	Sun,  6 Sep 2026 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715250;
	bh=MeIbzytCAh3nKhtft5AJ0Tak/5YflWswAYQl8AWd2To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nnk5bvxRTBqyx9TQJ1FCd2dH1EJ+8At7IT4woGAqi4zjMzrkBnm2WbjQfHk/n6/NI
	 vCeLsbAq3RuLrqvNZIVvV28w2yZQameCA2jk+mv8xYudE9G9ysNal7+cklvQqOruxH
	 HwkjfRiGzQIvllAb7RWO+wgfVX2ggzo4BF5azL9ReXQaHpp87UL+hoLsUXmSvND6/+
	 up2Q7PFCkH9l8/OF21rQQ1vpH6XFFVJSJer9m2Qzs/kXSitZtBafTES/xSvUHZtNiO
	 bUAIGUCrxaLHh/njeQrJmK4uxbrAk87qMFMvmXSsUkQ40pXPeMr9/lq1SPAEw8pJkz
	 J7Oo00R+NOUGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpftool: Use batch lookups for bounded
 hash map dumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260906170819.1212661-2-hi@tychen.cc>
References: <20260906170819.1212661-1-hi@tychen.cc>
 <20260906170819.1212661-2-hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:20:49 +0000
Message-Id: <20260906172049.EE1431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments do not follow the mandatory BPF subsystem style.
--

commit a1cb333fccdbef3bcdfaf55fc0e0a282326e27a3
Author: Tianyi Chen <hi@tychen.cc>

bpftool: Use batch lookups for bounded hash map dumps

This patch updates bpftool to use BPF_MAP_LOOKUP_BATCH when dumping bounded
hash maps to reduce BPF syscalls. It restricts this optimization to maps
that fit within a 4 MiB memory budget and handles fallbacks.

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 684a8fb724146..1eccdc0d1e963 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
[ ... ]
> @@ -762,10 +757,108 @@ static int dump_map_elem(int fd, void *key, void *=
value,
[ ... ]
> +/* Return 1 to use individual lookups, but only before batch traversal s=
tarts. */
> +static int dump_map_batch(int fd, void *key, void *value,
> +			  struct bpf_map_info *info, struct btf *btf,
> +			  json_writer_t *wtr, unsigned int *num_elems)
> +{
> +	__u32 capacity, count, batch =3D 0, next_batch =3D 0, i;
> +	void *keys =3D NULL, *values =3D NULL, *buf;
> +	bool first =3D true, can_fallback =3D true;
> +	int err;
> +
> +	/* Hash lookup batches must accommodate a whole bucket. Restrict the
> +	 * optimization to maps whose worst-case bucket fits the memory budget,
> +	 * so a later ENOSPC never forces a restart after printing some entries.
> +	 * Division also bounds the allocation multiplications on 32-bit hosts.
> +	 */

[Severity: Low]
Should the opening /* be on its own line to follow the BPF subsystem
multi-line comment style?

> +	if (info->type !=3D BPF_MAP_TYPE_HASH || !info->max_entries ||
> +	    (__u64)info->key_size + info->value_size >
> +	    MAP_DUMP_BATCH_MAX_BYTES / info->max_entries)
> +		return 1;
[ ... ]
> +	while (true) {
> +		count =3D capacity;
> +		err =3D bpf_map_lookup_batch(fd, first ? NULL : &batch,
> +					   &next_batch, keys, values, &count, NULL);
> +		err =3D err ? errno : 0;
> +		/* Older kernels reject the command before updating count. Do not
> +		 * inspect the buffers on these errors, or fall back after progress.
> +		 */

[Severity: Low]
Does this comment also need the opening /* on its own line?

> +		if (can_fallback && (err =3D=3D EINVAL || err =3D=3D EOPNOTSUPP ||
> +				     err =3D=3D 524 /* ENOTSUPP */)) {
> +			err =3D 1;
> +			goto out;
> +		}
[ ... ]
> +		for (i =3D 0; i < count; i++) {
> +			/* Keep the alignment provided by individual lookups, including
> +			 * for BTF types whose map key/value size is not aligned.
> +			 */

[Severity: Low]
Here is a third instance. Should this opening /* be on its own line as well?

> +			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
> +			memcpy(value, values + (size_t)i * info->value_size, info->value_size=
);
> +			print_map_elem(key, value, info, btf, wtr);
> +			(*num_elems)++;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906170819.1212=
661-1-hi@tychen.cc?part=3D1
