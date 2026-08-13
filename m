Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8449482B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637441; cv=none; b=nMtBAv1Xm82PrCv0NVrpINfdj3N6/fCSUwrkN/ULYd1JE0fbYOjPYevzYst10JJAfkP6f6oUcB5rUqzBYvRrs24b6IMEVW0aslw3cU3jt2LrX90UIgMQcgTMk6BBJ4i0ZJtk7Swn67pKzQiPOFV7gp0RSzqUcYfOxuTKLYC1hpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637441; c=relaxed/simple;
	bh=oIydu894oYSkVVwPTgrzMr1umayJkjNkS48ZFdZpH0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p+FTubIciqz21x91KlyH2M6FtrQvTLV0wRK+in2RSRVOOtwfErDTjprbZRj5kf8OVAg9QEgNGkFlt8IzUAznoXrDFURmeQKHUj3hlgIYc+fN5lbRaKW2QC5+g5zDCdsToTXskqjrKVaXz3308uauhmWHHLh6DbdV4XCfcuLshMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G21w6J/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G21w6J/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC871F000E9;
	Thu, 13 Aug 2026 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637434;
	bh=Yku3MK4rVzcDnKtkmUJHlW7NmKoLDavMS/cKZkBAyjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G21w6J/EGN9efkbhwWLCir8I9WSXmu86KTWFmmHkv7bb2ldpWcUxVKLLqx2EKU9X3
	 WjT4FD4ercY0qIdtJ7TUnqNDkxAcB2axV8Btc8dd4UytlamrTm4tZztNxBex7ws0P6
	 Xcx2EpxIB4PPxCeHFmiCp/ZVItQd58SB5yBxwHgOBUBUEo8Zpb4jipQsioaPTEBfig
	 VhemQZTJBY8KJ13U20Ua84m9snfLkslGKh7KGtqHSolNXJM0IRJFbPMoYagVhGiQyL
	 y2yIsu/0dfSo0SSCXadNE4BG0DOxLPvNfLv5JF/zXmJenpkKaWZuxpLW93qJGCr7tH
	 dCuFRe5U37Oxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: fix percpu map update indexing with sparse
 CPU IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813155131.1022745-3-sh_def@163.com>
References: <20260813155131.1022745-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:10:31 +0000
Message-Id: <20260813161032.2CC871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BPF_F_CPU map flag validation is vulnerable to out-of-bounds m=
emory access (read/write) when the `cpu_possible_mask` is sparse. The valid=
ation incorrectly checks against `num_possible_cpus()` instead of verifying=
 if the CPU ID is actually a valid possible CPU.
--

--- Patch [1]: [PATCH bpf v2] bpf: fix percpu map update indexing with spar=
se CPU IDs ---
commit 5d6a274a595d67867bb26dbd708c1d7e75d30170
Author: Hui Su <sh_def@163.com>

bpf: fix percpu map update indexing with sparse CPU IDs

This patch fixes an issue where percpu map updates incorrectly advance
the user value pointer using the physical CPU ID instead of a dense index.
This resolves out-of-bounds reads from the user buffer on systems with
sparse possible CPU masks.

Link: https://lore.kernel.org/lkml/20260813120250.796934-4-sh_def@163.com/

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178cd..cc3f8c25a28b5 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -405,7 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void=
 *key, void *value,

[ ... ]

> @@ -437,9 +437,10 @@ int bpf_percpu_array_update(struct bpf_map *map, voi=
d *key, void *value,
>  	}

[Severity: High]
This is a pre-existing issue, but since this patch focuses on sparse CPU
topologies, is the BPF_F_CPU flag validation also vulnerable to sparse
CPU masks?

Looking at bpf_map_check_op_flags() in include/linux/bpf.h, the validation
checks:

    if ((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())
        return -ERANGE;

Because num_possible_cpus() is a population count rather than a check
against cpu_possible_mask or nr_cpu_ids, could an invalid or impossible
physical CPU ID that is strictly less than num_possible_cpus() pass this
check?

If such a CPU ID passes validation, it appears it would be used immediately
above the modified code in bpf_percpu_array_update():

    if (map_flags & BPF_F_CPU) {
        cpu =3D map_flags >> 32;
        ptr =3D per_cpu_ptr(pptr, cpu);
        copy_map_value(map, ptr, value);

Can this cause per_cpu_ptr() to return an unmapped raw percpu offset
since __per_cpu_offset[cpu] would be 0 for an impossible CPU, resulting
in a page fault and kernel panic when dereferenced by copy_map_value()?

Should the validation in bpf_map_check_op_flags() be updated to use
cpu_possible(cpu) or check against nr_cpu_ids instead?

>  	for_each_possible_cpu(cpu) {
>  		ptr =3D per_cpu_ptr(pptr, cpu);
> -		val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
> +		val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + off;
>  		copy_map_value(map, ptr, val);
>  		bpf_obj_cancel_fields(map, ptr);
> +		off +=3D size;
>  	}
>  unlock:
>  	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813155131.1022=
745-3-sh_def@163.com?part=3D1
