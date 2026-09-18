Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22D3644DE
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712279; cv=none; b=Y95ncf53VK+sqtNjc3k7m9HXyrDtJKMCnzz8A+hJiprJ0s7y/HNxJBtRqmVFFeDnvY79lWSnF8RB/1FbjcFyJa45bcwFCl1Ix3LYLrOml70JKr5DiL6p7m9klxyJBlNhoZ2eJVkexRnmdETWiKZFEdXiIJMv6fsK7kkOQBovznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712279; c=relaxed/simple;
	bh=DMuJI9v9abLaILVUUf+DduOW2qjYOzCiPf3ToxLmeXE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ALYET/nppGQvecw+P8QNW07KztxoH8NlCsmwkrdd4zJmd4aUWp/erWUIbYhsx0EBosO15aQdQMwCr5yS01b+flZ89wyh+moe8ZjZx6ND0ebhsnga4O4X96X3vQEuCdWbudde3A/mMmTSDgALbvoN9NIGJq988UVGH7FxAYDPOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYkBec7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYkBec7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5551F00893;
	Fri, 18 Sep 2026 06:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712278;
	bh=Gdtj2PkafDQxdcBic+tW9a3MtINaFaGmKDHjc8yLZHg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PYkBec7d9YzKNsZ18KywmLAovW/geEX6zI3QNhvcZOJUhwn8Vuarzct1cAgdCQYLy
	 nMfJz/YE9oHS+yH7PrUA89ic+pOXbNUeoADGJzkAFQd/PgM9Dd3+yq1yUtj7JQzezZ
	 4KVAQmuWKWyD58bQk+D95+NqVCmGdkKwVElCdS6rS0f3SqBTVF73FaKhnIaHRzu+WY
	 6ZeTVJeIXRApCz1g6hTklNCm6Oofd9NcXDxS/F0SKH17N0dSCjySxqRqYSTVm8w6yY
	 DLZzyDL39X9CO8SEYzxPNufI0fXrIQMHNfSlCU6+vTC5ytqXdLSZxrqOHD1uNk3iQY
	 fmgPufgF4/C+Q==
Content-Type: multipart/mixed; boundary="===============7321388171919339807=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <96fcfe18cbaae7243faf5405bb0784441e46bde3eb601aedf3788119f5412621@mail.kernel.org>
In-Reply-To: <20260918052906.12226-5-memxor@gmail.com>
References: <20260918052906.12226-5-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] selftests/bpf: Cover helper memory access permissions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 06:17:57 +0000 (UTC)

--===============7321388171919339807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Check that fixed-size and sized helper in/out buffers require both read
> and write permission. Cover bpf_check_mtu() and bpf_fib_lookup(), including
> read/write buffers as positive controls.
>
> Keep rejecting read-only buffers for bpf_check_mtu(), and verify that a
> write-only map remains a valid destination for bpf_get_current_comm(),
> whose output is annotated MEM_UNINIT.

Does the first sentence accurately describe the test coverage added?

For the fixed-size buffer case using bpf_check_mtu() (arg3 =
ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED), verifier_mtu.c adds
all three test variants:

- map_mtu_wo (write-only map) -> expects "read from map forbidden"
- map_mtu_ro (read-only map) -> expects "write into map forbidden"
- map_mtu_rw (read-write map) -> __success

This covers both the read permission requirement and the write permission
requirement for fixed-size buffers.

For the sized buffer case using bpf_fib_lookup() (arg2 = ARG_PTR_TO_MEM |
MEM_WRITE with arg3 = ARG_MEM_SIZE), verifier_helper_access_var_len.c only
adds:

- map_fib_wo (write-only map with BPF_F_WRONLY_PROG) -> expects "read from
  map forbidden"
- map_fib_rw (plain array) -> __success

There is no map_fib_ro test with a read-only map (BPF_F_RDONLY_PROG)
expecting "write into map forbidden" to mirror tc_readonly_mtu, so the
write-permission half of the claim is not exercised on the sized path even
though check_mem_size_reg() runs the same BPF_READ-then-BPF_WRITE pair as
check_mem_reg():

  if (access_type & BPF_READ)
          err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
                                        BPF_READ, zero_size_allowed, meta, NULL);
  if (!err && access_type & BPF_WRITE)
          err = check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_reg),
                                        BPF_WRITE, zero_size_allowed, meta, NULL);

Could you either add a BPF_F_RDONLY_PROG fib map test expecting "write into
map forbidden" (mirroring tc_readonly_mtu), or narrow the first sentence to
say the read-permission requirement is what is newly covered for the sized
case (the later paragraph already scopes read-only rejection to
bpf_check_mtu() only)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35311871659
--===============7321388171919339807==--
