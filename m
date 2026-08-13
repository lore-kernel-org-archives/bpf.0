Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256CD48EBC5
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638577; cv=none; b=XATNMWPmWiNBNZxMgInrNr24tpnoakD6k6PLuuN61KUZcY0hlxCDqn9PWQ16ZlCvc2YiA71gbMeFUY2v7pjRtp113W91PXoINtSrMt7/tu9OFVT85cjFLjQw3DM9q31jvQNeVSpVzplFmvb8LatcOJ+YLvshl/WVkv74e0YWsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638577; c=relaxed/simple;
	bh=IDT5NZ9C1Lu//rmHleMgcANKAlBE4fkCI6NBOcNcjFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RzlddY9cIe89NRza0hFRD1WyBkoxxtAByzZZEvRBXIKSGNE2ueYb3g3o94KxybGjMrY7SedS0jYhg2BtVJMGy+LNUiEi9DSqAyUQACOz0QiYPXd4SJm0qDTrDoQH28pjJB2ZBR8cZsKL7OawtAK6vJkNp0plIvqqXimol1dkNOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eijyH8I+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eijyH8I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823CA1F00A3A;
	Thu, 13 Aug 2026 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638575;
	bh=zespKEhgS8MicJpiR3MJ038HGLI2xLnFbHvSNX6aFwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eijyH8I+UTlCo9E2MG1/J1lS+po9il0BcXIxPPlRmCmOwtf6g1ylAzaSitnnHZ0/v
	 htUx6DQ3zplhs1ltLPUDpduwXLcd2vnJGI0fpKIncaO4x4rmvW6eNhhQ1zLHPq9KCg
	 lgJBYh35Lws8VSveDSrYAwpRiP7fOq6MExTu6/RMHshKHPCHwkFMmO/mVlVR4iWNrm
	 0ArpdhV8uDwqRF7TNYgCC3Z6m2Qv67Jp+EDnzATVa7/R8SVCK2pRzZHyw5/F9uCWEz
	 czI6y8FtnmIGhM1xhsuLsT8KW82CSpLekGb/rNZfejhCJr5F65BJl7zw+9IPA9rQoM
	 gBDt5LyKYVgKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: fix BPF_F_CPU validation for sparse CPU IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813160858.1042834-3-sh_def@163.com>
References: <20260813160858.1042834-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:29:35 +0000
Message-Id: <20260813162935.823CA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Updating a per-CPU map without BPF_F_CPU or BPF_F_ALL_CPUS reads o=
ut-of-bounds from the user-provided buffer when CPU IDs are sparse, leading=
 to a kernel memory leak into the map.
- [High] The BPF helper bpf_map_lookup_percpu_elem() lacks a check for impo=
ssible CPU IDs, allowing BPF programs to trigger a kernel panic.
--

--- Patch [1]: [PATCH bpf v2] bpf: fix BPF_F_CPU validation for sparse CPU =
IDs ---
commit a52d0045a4c161f0602130ac0b1b17e4a87469ee
Author: Hui Su <sh_def@163.com>

bpf: fix BPF_F_CPU validation for sparse CPU IDs

This commit updates BPF_F_CPU validation to check the CPU ID against
nr_cpu_ids and cpu_possible() instead of num_possible_cpus(). This fixes an
issue on systems with sparse CPU IDs where valid CPUs were rejected and
invalid CPUs could trigger an out-of-bounds access.

Link: https://lore.kernel.org/lkml/20260813101229.680523-3-sh_def@163.com/

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f4e8d372253ac..0ac809800a855 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -4200,7 +4200,7 @@ static inline int bpf_map_check_op_flags(struct bpf=
_map *map, u64 flags, u64 all
>  			return -EINVAL;
> =20
>  		cpu =3D flags >> 32;
> -		if ((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())
> +		if ((flags & BPF_F_CPU) && (cpu >=3D nr_cpu_ids || !cpu_possible(cpu)))

[Severity: High]
This is a pre-existing issue, but while looking at this fix for sparse
CPU IDs, is there an out-of-bounds read in the per-CPU map update paths?

In kernel/bpf/syscall.c:bpf_map_value_size(), the buffer is sized using
num_possible_cpus():

    return round_up(map->value_size, 8) * num_possible_cpus();

But in kernel/bpf/arraymap.c:bpf_percpu_array_update(), the read offset
uses the physical CPU ID:

    val =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
    copy_map_value(map, ptr, val);

If there is a hole in the CPU mask, a physical CPU ID can be greater than
or equal to num_possible_cpus(). Does this allow the copy to read past
the end of the allocated buffer and leak memory into the map? Similar
logic exists in kernel/bpf/hashtab.c:pcpu_copy_value() and
kernel/bpf/local_storage.c:bpf_percpu_cgroup_storage_update().

[Severity: High]
This isn't a bug introduced by this patch, but does the BPF helper
bpf_map_lookup_percpu_elem() also need this cpu_possible() check?

In kernel/bpf/arraymap.c:percpu_array_map_lookup_percpu_elem() (and
similar hash and LRU functions), there is only a check for nr_cpu_ids:

    if (cpu >=3D nr_cpu_ids)
        return NULL;

If a BPF program passes an impossible CPU ID that falls within a device
tree hole, could per_cpu_ptr() use an unmapped or uninitialized
__per_cpu_offset, leading to a kernel panic when the BPF program
dereferences it?

>  			return -ERANGE;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813160858.1042=
834-3-sh_def@163.com?part=3D1
