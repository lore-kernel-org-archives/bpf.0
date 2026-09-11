Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9353E49F1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093980; cv=none; b=j40zEalx2C9HcjYCSM8U2OoYGFFgZnfr7ucR87xcDJeZ7Dn118PKY5VR6ZN73m2HNVFNa9OdYpgLki1B8xxAn85oRGwOgFgPeBKiL9YCsRKUnTnHjStJRvDdavMNgKlvzCrBrY/XqA6lYAb0PTckL0A9sKHL5onaMZ+qDV3CuSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093980; c=relaxed/simple;
	bh=GCG+M+Z2GVbvKaDlkDne9vX4QECj1yus6QpTZvmQ5JM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JHtiFnpz67xxIwj2xn+ie3YB/L/b+pzrm/W4i6+a+aySLykd79peU2zj1zyEF36/fT8Kx+vgUaextlu0qHSeiCaRG7M4eh/p0HUnW9EoWXaDL485qZeFx4GbS3kHSltJvs3N/0C/KEv24m1DPYuUrEtPtjorJzkxrn1vcN/Eg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuwVMP+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuwVMP+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962EF1F00893;
	Fri, 11 Sep 2026 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093978;
	bh=mYOmW4+YN+PMEqLWfkk1hRSvxfFFBtKoufRruxmK0jY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CuwVMP+jXn5VWgHBitNwKIjJ6d4giWV5I5i8c85fF0CEp1cdkntmFR3OTcCrHmu84
	 42vpxGe1G0xBqVnxIGCParJmzH+/TWx0H5DRwKg+7xaE19DfdqIYz+35L9Mobpm7a0
	 xYcj6srLbNvS2Y8sqzQ3JhPflJOrVgIEC8XnMrjCNa9UB6j6GBVBs0OY6gugHsuRck
	 UUgyWfao3240Hlg2OOQjz48B/lzLwhJu0X2lA7aEeWG4Z6zWhRu+44527aIvNiaYfS
	 Y3igtRPSxl0ELCwrD/CSj13s3CxYwCvCLbKWutSWina+EDaDyPR0x2MSGLdvHDWuDJ
	 hSKB2Izn2GbpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 1/2] mm/bpf: Add bpf_proactive_reclaim
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>
References: <cover.1789091855.git.zhuhui@kylinos.cn>
 <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 02:32:58 +0000
Message-Id: <20260911023258.962EF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Missing newline (\n) in pr_warn() format strings.

Pre-existing issues:
- [High] Missing negative bounds checks for enum array indices in `bpf_mem_=
cgroup_memory_events()` and `bpf_mem_cgroup_vm_events()`.
--

commit 21e3edc4898900dd57bbb4035bb4acd286a2047b
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfunc

This commit introduces a sleepable kfunc bpf_proactive_reclaim() to allow
BPF programs to trigger proactive memory reclaim on a memory cgroup. The
kfunc caps the reclaim target at MEMCG_CHARGE_BATCH and is limited to
BPF_PROG_TYPE_SYSCALL programs to avoid filesystem lock deadlocks.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..d8827bc388efc 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
[ ... ]
> @@ -159,6 +161,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct m=
em_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
> =20

[Severity: High]
This is a pre-existing issue, but while reviewing this file I noticed that
the existing bpf_mem_cgroup_memory_events() and bpf_mem_cgroup_vm_events()
kfuncs do not properly check for negative enum indices.

Since the BPF verifier treats enums as signed integers and does not validate
enum ranges, can a BPF program pass a negative event enum value? The
existing bounds check in bpf_mem_cgroup_memory_events() is:

        if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
                return (unsigned long)-1;

A negative event value bypasses this upper-bound check due to signed integer
comparison, which leads to an arbitrary out-of-bounds kernel memory read
when the negative index is accessed here:

        return atomic_long_read(&memcg->memory_events[event]);

Similarly, memcg_vm_event_item_valid() permits negative values for
bpf_mem_cgroup_vm_events(), leading to an out-of-bounds read in
mem_cgroup_events_index[idx]. Does this require a check for negative values,
or perhaps casting the event argument to an unsigned type before comparison?

> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
[ ... ]
> @@ -174,19 +244,35 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_S=
LEEPABLE)
[ ... ]
>  static int __init bpf_memcontrol_init(void)
>  {
>  	int err;
> =20
>  	err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
>  					&bpf_memcontrol_kfunc_set);
> -	if (err)
> +	if (err) {
>  		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
> +		return err;
> +	}
> +
> +	err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&bpf_memcontrol_reclaim_kfunc_set);
> +	if (err)
> +		pr_warn("error registering bpf reclaim kfuncs: %d", err);

[Severity: Low]
Does this pr_warn() call need a trailing newline (\n) in the format string?

Without it, subsequent log messages might be incorrectly appended to the
same line in dmesg.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789091855.gi=
t.zhuhui@kylinos.cn?part=3D1
