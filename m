Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8B369D61
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616808; cv=none; b=sRxKgzqGMTB9OQT/JtO5UHjVL6BfdEiDrvaeYY33tDv+h6po6ODwQIWeP3CpG2khHeSYmehwsnrVbd5DDUFbCkRyuVNkk0G9J0rLeoLwpD0bN9WIOIRH6Ytp8p06gPxBWGDeAtLqcERiqyMU2oU2c311BVd2LiBYlscG/UpEPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616808; c=relaxed/simple;
	bh=Bbw3125noQcKzXj68QNL7lQydGCUEGyaBhuBDMMw5dY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UUg/6VYRRdLsM7wQ7RwLVpOYEwBBe8n6MFHR0HhNLm/zm4EC35rHcn1Yeop6Chw39PO6Np8a4nVT9DWzD7GlPp2B/NPgOfrOu8yr96Wvyg8USY4Cy1AiUbTshpsAXqDRFoFHuHQKioc2xHRHlATu62XO1WlRMFWOpEyhFzctYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAA2IeC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAA2IeC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD71F000E9;
	Thu, 13 Aug 2026 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616806;
	bh=aWtH1aoyTKEi0FSHPXCVrhA7bbfIW6Ty0OhRjC+QCh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAA2IeC0m6egG8pmgHMOW6jcYa2P7hOMb40nvo9i9dEc8wREgunNUi3HNIBX4Zcjl
	 YZMykVEvj+yDZFIPGTKo4sDGLzWIt9mPfE+pG54EWtWu5sHOAcglpFQ3a9pTLVKv2H
	 porsclfaH6iDK4k8Bqt/+xZHXU6YN4QnQlGtne3pUhJa2nSGQHm7YLyhLcxcOAl4Gy
	 3ybZ1UQYDW6UfaYY09AMaJqRD1wJyPSG0p6S8bYbRhiJqXQTrknINwDBk3PcqmfSM8
	 IGVbv2rW3qvkEQeyjzqDNZfJ/JBFpUI/YBvHfjc7jQ5JI+FykPlIz/88f05CXRjB27
	 eZG8jX71NO5Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: fix BPF_F_CPU validation for sparse CPU IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813101229.680523-3-sh_def@163.com>
References: <20260813101229.680523-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 10:26:46 +0000
Message-Id: <20260813102646.92AD71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Bulk updates of per-CPU maps (without BPF_F_CPU or BPF_F_ALL_CPUS =
flags) read out-of-bounds from the userspace-provided value buffer on syste=
ms with sparse CPU possible masks.
--

--- Patch [1]: [PATCH bpf] bpf: fix BPF_F_CPU validation for sparse CPU IDs=
 ---
commit 821903ca90d43b9f0e29ab7849f998f149e58245
Author: Hui Su <sh_def@163.com>

bpf: fix BPF_F_CPU validation for sparse CPU IDs

BPF_F_CPU stores the target CPU ID in the upper 32 bits of the map
operation flags. bpf_map_check_op_flags() currently compares that ID
with num_possible_cpus(), which is the number of possible CPUs rather
than a bound on CPU IDs.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4a10c9878cf8..3d9a632d7d33d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4201,7 +4201,8 @@ static inline int bpf_map_check_op_flags(struct bpf=
_map *map, u64 flags, u64 all
>  			return -EINVAL;
> =20
>  		cpu =3D flags >> 32;
> -		if ((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())
> +		if ((flags & BPF_F_CPU) &&
> +		    (cpu >=3D nr_cpu_ids || !cpu_possible(cpu)))
>  			return -ERANGE;
>  	}

[Severity: High]
This is a pre-existing issue, but does the bulk update path (without BPF_F_=
CPU
or BPF_F_ALL_CPUS) have an out-of-bounds read on sparse CPU masks?

When a per-CPU map is updated from userspace, the user buffer is copied int=
o a
kernel buffer allocated densely based on num_possible_cpus():

kernel/bpf/syscall.c:bpf_map_value_size() {
    ...
    return round_up(map->value_size, 8) * num_possible_cpus();
    ...
}

However, during bulk update, the source pointer is calculated sparsely using
the cpu index:

kernel/bpf/arraymap.c:bpf_percpu_array_update() {
    ...
    for_each_possible_cpu(cpu) {
        ...
        val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
        copy_map_value(map, ptr, val);
    ...
}

If the possible CPUs are sparse (e.g., 0, 2, 3), num_possible_cpus() is 3,
making the allocated buffer size * 3 bytes long. But in the loop, cpu can
reach 3, resulting in value + size * 3, which points past the end of the
allocated buffer.

Can this lead to an out-of-bounds read that copies leaked kernel heap data
into the BPF map? This pattern also appears in hashtab.c:pcpu_copy_value()
and local_storage.c:bpf_percpu_cgroup_storage_update().

Note that lookup operations (like bpf_percpu_array_copy) seem to use dense
indexing (off +=3D size), which suggests a mismatch between how values are
read and written in bulk.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813101229.6805=
23-3-sh_def@163.com?part=3D1
