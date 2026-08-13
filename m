Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829423C503;
	Thu, 13 Aug 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626230; cv=none; b=Z/kOPkeYVkE62xQTB1GPUPPHPjp7rpRDxroKD2VyL0j4tBcen4Eafu0Qtz6Ilb9jBAgVo9iPxMm0TX7tn5DmLQt6IENs4FwMhCg2h+0G8xRT8GRBaAOScITOIKkjvl1k9bqor9Z9UbFiqG31f+7JQlzZ3wfQqBNSd4/40JkeKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626230; c=relaxed/simple;
	bh=6ORYWnM2SBD4IBFf6qQI+ewTnNn7bui1JvzQZH0Qs/s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IyDvUFI4aaXuEKiRB8I4z1dAtBebYAuMwYsgTYU2WvCSIcJfvhL0RyFf/iKtIIdfXFbSl6D14uBomW60BNPngHbzvnRzuy8O5Bf8EE3tdACsPkHFT+U5XOyHLCw1qn36cmCY1TxVcvzgp+DTaldfl9oav12e7NMoMPWjWWyOzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsXy12n8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsXy12n8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE5C1F000E9;
	Thu, 13 Aug 2026 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786626228;
	bh=P0OGuaH0JVdoC2cGMG7GW3KuyxiLcFMMXqedj2+YFBw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TsXy12n8nUyA7bafCg+2/K/8fgg0bRiW0RH1RI9fAvDm1rQpO34WvpJK46XBZFusO
	 iB8kipfTGs1/A3zc69eEnZOPN4Z5SJKAIebmHuVayK6iQMfrBkNhTYLoDsPdFzKYMn
	 m8ABr/lJP7WLVwyKWYREcDUevG/krnD8qnF8QbS5+ziU80SHnTVen9I4nMYqu0CaG8
	 ZLRCpe1yEFYZsAeYzxdu13pk/G0Qdu8KmTqWSaCKlKdHahlBmFJXjH/sj+IteQYLbW
	 84++D6zIf3vmjwq4pw5jdYoHzwUPXgYbredIe3T43ttE70wynAU4r6l30IpuZp7Hoc
	 wQIeJGDu4yn4A==
Content-Type: multipart/mixed; boundary="===============6269391384148361866=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <97e15f09784afbb9da860fcfca52669fae313b681f6d15e729033cbbd30379c2@mail.kernel.org>
In-Reply-To: <20260813-bpf-next-038-mixed-atomic-v1-v1-2-e79aadb46a8a@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-038-mixed-atomic-v1-v1-2-e79aadb46a8a@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover mixed arena and map-value atomics
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,chenyy23@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 13:03:47 +0000 (UTC)

--===============6269391384148361866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> index b241bbcf54a8a..2e43da188194b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -25,6 +25,15 @@ struct {
>  	__ulong(map_extra, ARENA_VM_START); /* start of mmap() region */
>  } arena SEC(".maps");
>
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} atomic_map SEC(".maps");
> +
> +static __u64 arena_atomic_target SEC(".addr_space.1");
                  ^^^^^^^^^^^^^^^^^^^^

Does this arena global permanently consume one of the arena's two pages
and break the existing allocation tests in this file?

The arena is declared with max_entries = 2 (two pages). When libbpf loads
the object, it places .addr_space.1 globals at the end of the arena:

  obj->arena_data_off = bpf_map_mmap_sz(arena_map) -
                        roundup(arena_data_sz, PAGE_SIZE)
                      = 2*4096 - 4096 = 4096

Then it copies the globals with:

  memcpy(map->mmaped + obj->arena_data_off, obj->arena_data,
         obj->arena_data_sz)

That user-space write faults page 1. In arena_vm_fault(), the kernel calls:

  range_tree_clear(&arena->rt, vmf->pgoff, 1)

marking page 1 as allocated and unavailable to bpf_arena_alloc_pages().

This happens during bpf_object__load() for every subtest since test_loader
reopens and reloads the object each time. So every subtest now has 1 free
page instead of 2.

Looking at the existing tests that should fail:

  basic_alloc1_nosleep() / basic_alloc1(): second
  bpf_arena_alloc_pages(&arena, NULL, 1, ...) returns NULL -> return 2

  basic_alloc2_nosleep() / basic_alloc2():
  bpf_arena_alloc_pages(&arena, NULL, 2, ...) cannot find 2 contiguous
  free pages -> return 1

  basic_alloc3_nosleep() / basic_alloc3(): allocates
  ar->map.max_entries (== 2) pages -> NULL -> return 1

  basic_reserve1_nosleep() / basic_reserve1():
  bpf_arena_reserve_pages() on the second page hits is_range_tree_set()
  == -ESRCH -> arena_reserve_pages() returns -EBUSY -> return 2

  free_scalar_below_arena(): second alloc returns NULL -> return 2

All nine of these are annotated __success __retval(0) but would now
return non-zero.

verifier_arena_globals1.c is the existing precedent: it sizes the arena
large and reserves a dedicated 16-page region for globals, and its
check_reserve1() asserts that bpf_arena_reserve_pages() over the globals
region fails because libbpf already mapped them in.

The new test doesn't need an arena global at all. The idiomatic way to get
a PTR_TO_ARENA in a __naked test is to call bpf_arena_alloc_pages() and
use addr_space_cast(), as verifier_ldsx.c and compute_live_registers.c do.
That links the arena to the program without adding arena data.

Alternatively, could the arena's max_entries be grown and the page-count
expectations of the existing tests updated?

> +
>  SEC("socket")
>  __success __retval(0)
>  int basic_alloc1_nosleep(void *ctx)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31699396501
--===============6269391384148361866==--
