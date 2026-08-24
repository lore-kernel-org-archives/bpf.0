Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889F3EDE4A
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561229; cv=none; b=jiNS69b7pwxhd1cjKHtYAXjRdgaFjM0kanpCpMfI187VrT93LfjgxSpZPud+OVXLUFMDmAnxXVWWhZBPBbjKvWwanpp9+liL5VdMUkNdr/xUsdpe+gUlY5BqSuTfCaejNxSIQNoNfr1eipmOJax9YIhzGqspJ3A3f6UmekKe6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561229; c=relaxed/simple;
	bh=ugNuF1GpWakRFH4BRru2hwSseBhLHIa+Lni01iRWSKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3XZFVxFwu6S+f/onw8zCjX8atHGKy9Jk/ZUt+Eu4YDk96b1pkzsaChtdwqtico6Vv4SP9o5olEXiKgM9OXMqXt1NqPgQ3ruMYtSztCti2Vt6rCBXQaAX3JZe9dBOAZxRJ8yIoxUlnc8yzzDb5UYoQwK6rtz+EowvVw1/MS/ev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8tRUbwV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8tRUbwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174E21F000E9;
	Mon, 24 Aug 2026 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561224;
	bh=8av29sOfpJe/i7/mHjr+hwf62vtKRtDF+GDMnhufRbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D8tRUbwViCDDDU/VoCNG2v6hAT0jzBVq6C+J+HLtU3dAuTKFvneb6QnI+Kd2O8V+S
	 AEIB1rpIInEl/Be3v0i1enWqxyY3UTvQWa7eiI6WlDNp5dBd90o9W25EuUUAgcxwRj
	 mfWLH4To1ECsxuDAkn30AmDTiLsFCUGjmyhO5PxVFfLYqpWkbyLUrjGg66BOVZ3Zke
	 f40xBibCHUck58lB198z5NMIGQmAAR4/5tv3XvKMj1kxSYffpigBqvWVEJbgydGhRY
	 7niu0q7MOv92aa77ykeK0QWLsTfpKKhjGScPlAyw+kVxWJXZdDirzV9WIH4LBjTGu8
	 hiu3AJPy2+5vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix queue/stack map u32 index overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824083327.1708560-2-chenyuan_fl@163.com>
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com>
 <20260824083327.1708560-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:47:03 +0000
Message-Id: <20260824084704.174E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kfuncs using enum parameters as array indices lack bounds checking=
 for negative values.
--

--- Patch [1]: [PATCH bpf v4 1/2] bpf: Fix queue/stack map u32 index overfl=
ow ---
commit b3cc6df8f8f6a83f377bada50a4de0c2ebde4779
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf: Fix queue/stack map u32 index overflow

This commit fixes an integer overflow in queue/stack maps by restoring a
bounds check in queue_stack_map_alloc_check(). It rejects max_entries and
value_size combinations that would reach or exceed U32_MAX bytes.

[ ... ]

While reviewing BPF bounds checking, I noticed a pre-existing issue in
mm/bpf_memcontrol.c:

> mm/bpf_memcontrol.c
>=20
> __bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *mem=
cg,
> 						   enum vm_event_item event)
> {
> 	if (unlikely(!memcg_vm_event_item_valid(event)))
> 		return (unsigned long)-1;

[Severity: High]
This is a pre-existing issue, but since enums are represented as signed
integers in C, could a BPF program bypass this bounds check by passing a
negative enum value?

It appears that a negative event value could evade the upper bounds check
and lead to an out-of-bounds read when the event is used as an array index.

>=20
> 	return memcg_events(memcg, event);
> }
>=20
> ...
>=20
> __bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup =
*memcg,
> 						       enum memcg_memory_event event)
> {
> 	if (unlikely(event >=3D MEMCG_NR_MEMORY_EVENTS))
> 		return (unsigned long)-1;

[Severity: High]
This isn't a bug introduced by this patch, but does this signed comparison
handle negative event values?

Similar to the above, a negative event value would pass this check and
subsequently be used as a negative index for the memory_events array.
Does this result in an out-of-bounds memory read?

>=20
> 	return atomic_long_read(&memcg->memory_events[event]);
> }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824083327.1708=
560-1-chenyuan_fl@163.com?part=3D1
