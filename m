Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281813B0AF8
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765642; cv=none; b=Y2hTsLuzXRAxlAIR7NtjQWwoCptdA7G/Ua9RiPdawQBzn/D24Cq4AjPQNGUwzJUjBJ8l/8GsGGh3AsF/yjUVRKALoJX9cR7gke3sDQ+GsZw2IR5MZPUBMWZueZQPeMyK0GidzB+UbZ5mAwiZbp/qE37kleXX0aZX9aEvMpCd1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765642; c=relaxed/simple;
	bh=bsoOC/eAEqaV0u/t9DEJ1FJ9TQSSXQr0Mcx2lGISkjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=owlGz/cVMyftNlCykZ/AS4m4t4wJtfTJWq4qR3UDk5JQks22kGituSYnbAZNVgPtBMzAS14Iyv5t/dfXFD2i1f1dKQTK5TrOOPDbz7BPSu1vIkANeDcT5sSuVga5XrPJpm0P1QTwIRusVXwUf94cN/wWwHxxcIb97H1uWH2L7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8LslShA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8LslShA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738711F00A3A;
	Mon,  7 Sep 2026 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788765640;
	bh=MaHCOlYfej3zFraAGkaG+c8QlTLlBfG7AD5ZWCB/n80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8LslShAlrAfLSLiDC3KQxWy4XXwLFh7Ea33tBvr3IQLtZZiZn6uKHxEWf6NTuzNA
	 v3tqPzSA8OL7l2dgGRwh2X0R6Qw0EdLMvzzFv7e+8CearOaW+rQkQ1heNXNGd4pxIb
	 GgKFVz12V9Fb3XvF7kf48CDWDT31vCXmiC5Qwa1on027N2XNgm3+ptnQb7t/OW0RQy
	 F8GarJU6I7/iI1BqdgpoMRlQzq64xO2OPc25Mlo9Yf77hi4uhNQldGbuyfmCXznfaU
	 P5t9DajO7akmSjOlAInLbb19sHB5leAIGDe9h/x12lG276/2/ky+6uWMNK6l2PanpR
	 /L82qDu/1DXDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <0f1e2b5408aef7baaacf7306dff5f6d4fb91e441.1788764121.git.zhuhui@kylinos.cn>
References: <cover.1788764121.git.zhuhui@kylinos.cn>
 <0f1e2b5408aef7baaacf7306dff5f6d4fb91e441.1788764121.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:20:39 +0000
Message-Id: <20260907072040.738711F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kfuncs `bpf_mem_cgroup_memory_events` and `bpf_mem_cgroup_vm_e=
vents` fail to properly bounds-check their enum `event` parameters for nega=
tive values, leading to out-of-bounds array reads.
--

commit 43c46156245f91f265307f6d4888bcb12e5294d0
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfunc

Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
proactive reclaim pass on a given memory cgroup, similar to a write
to memory.reclaim but without retrying until the target is reached.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..74ccac30c0117 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
[ ... ]
> @@ -171,22 +239,44 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)

[Severity: High]
This isn't a bug introduced by this patch, but does this function fail to
validate negative values passed to the event parameter?

The BPF verifier does not validate that enum parameters remain within valid
constant ranges and allows negative scalar values since they are treated as
integers.=20

Because enums are signed integers in C by default, negative values can bypa=
ss
the bounds check using a signed comparison:

mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {
	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
		return (unsigned long)-1;
	return atomic_long_read(&memcg->memory_events[event]);
}

If a BPF program passes a negative event value, could it bypass the >=3D ch=
eck
and trigger an out-of-bounds read in the memory_events array?

This same issue seems to apply to bpf_mem_cgroup_vm_events() which calls
memcg_vm_event_item_valid():

mm/memcontrol.c:memcg_vm_event_item_valid() {
	if (idx >=3D NR_VM_EVENT_ITEMS)
		return false;
    ...
}

Which is then used as an array index:

mm/memcontrol.c:memcg_events_index() {
	return mem_cgroup_events_index[idx];
}

Could negative values here also lead to out-of-bounds memory reads, potenti=
ally
resulting in information leaks or kernel panics?

>  BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
> -
>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788764121.gi=
t.zhuhui@kylinos.cn?part=3D1
