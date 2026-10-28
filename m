Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222557;
	b=fGo6JFS7vb0wDuSekwut97NEr9a+MAoc1OpOlnpt7Mc9/RyEBlqq9EawUhpUPZXXxK+X
	 +eX3D/IQg9Nb0q58U1kP5KIFsPpNN5x0xvB4wlEIYUYY3jhLf3Gr+bqSrcEhbEts3fRC1
	 +uKUBUUvSioHxXjhnnwBkcPuonThA/MqF0HopbKV7ZIkci2YGrqZcEkqEaotCiRPGG0il
	 bPkdtxb+GNcfqoMi+52YzUJTyf9VYBH7eHZ2xR451YIRNljWxz+cNDP5d1WSV4PP9VxUq
	 orykA5IdjWKYecui39aJcI8qBfVtX2qRNli9dv2w8a1L0OyFN9cTBBAQdoU6LfJ0BKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222557;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=zw5Rd3tHLsBi/Wx1LPdx2NJDSF078cu37LQJA05ujQk=;
	b=qr+hnGntxYcaVWRx9fOikn4nKEWUEzRvbaCX8Sd2IQ5gtxd4euAI+MOB6jSlIwNNXyLA
	 nDHJJ/fLSOb3S8J2VrrEhvL1NsFpzVdHjuVkSEXg8L/38DeoVZccUGKT2qTPs+lqRE+LF
	 whyzU5GVY8H16eVHYstffejWtq+wcYM+J10S5nM0zEZguy3JLwxEC08hTzCEnk0ekco+C
	 nmsqM8va1/SCOA1eF9LizBl7VDk8dQmoFPkDyoNmfHlQEve84MFCLyQHm4Lekr3rtTTtE
	 VdH0mGDe2VYZjBjWpbB7RWam/ho0uzux1aebfxJ0MTqWjKIJQg2eOLkqDiiVJn9COuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVwhf+Fg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0C606A31D;
	Wed, 28 Oct 2026 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVwhf+Fg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2946F1F01825;
	Wed, 28 Oct 2026 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793222556;
	bh=zw5Rd3tHLsBi/Wx1LPdx2NJDSF078cu37LQJA05ujQk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lVwhf+Fg4q2oYSltVlYMxotSqsNpExaiP4XmNrPCKdKKbUs5LVGjUxVbdVfCfHNfs
	 ufHJMab4k8e/KivbcqqqFpFz3mMvCi+IisNAEmyHGdzSp3D2KeUUBsjO9IFNqupvaU
	 6qzaxExxI29wEuC3smf/d6a6gMJ99fkD1othlCEqJfRbbI7Ab90T6KdiS8/N1YGUu3
	 ptlK0DqaBUAq7zr0GdRdCHllojy8QVPzccBgwA+HTPthf0DkwkzJ6dvUfoGTEfl8no
	 +FvP3wEOr7PK/YCkNhND1JdubnZ+4J/e9AJyt+/qvk9KTPwfXzb5qCTfSXBkZmYjN2
	 txoV7at/H2PfQ==
Content-Type: multipart/mixed; boundary="===============1452548001571172891=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e08eb87415801027d75170c930dc709beaea5f20f4afc92ff0affd434faaa9a0@mail.kernel.org>
In-Reply-To: <20261028204158.1021284-8-vineet.gupta@linux.dev>
References: <20261028204158.1021284-8-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v2 7/8] selftests/bpf: write the mixed arena/scalar ALU tests in asm
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jose.marchesi@oracle.com,david.faust@oss.qualcomm.com,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 21:22:36 +0000 (UTC)

--===============1452548001571172891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: write the mixed arena/scalar ALU tests in asm

TL;DR: Test comment only: the new verifier_arena.c comment claiming the r9
arena load is needed for addr_space_cast looks stale, since libbpf now binds
the arena via fd_array. Suggest dropping or rewording it.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
> index 21b66d51c61e..b84d8f1e0b39 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
> @@ -539,53 +539,58 @@ int arena_ptr_add_arena_ptr(void *ctx)
>  	return 0;
>  }
>
> +/*
> + * The r9 load is never read; it is there so libbpf records the arena map
> + * as used, which is what lets the verifier accept addr_space_cast at all.
> + */
>  SEC("syscall")
>  __failure __msg("same insn cannot be used with and without arena pointer")

Is this comment still accurate?  Commit cd7a395838cb ("libbpf: Bind the arena
of an object to every program in it") is already in the base of this series.
With it, bpf_object_load_prog() calls bpf_object__bind_arena(), which puts
the object's arena into a continuous fd_array when the kernel supports
fd_array_cnt:

    obj->fd_array[0] = map->fd;
    load_attr->fd_array = obj->fd_array;
    load_attr->fd_array_cnt = obj->fd_array_used;

The kernel binds that array before it looks at any insn:

    process_fd_array_continuous()
      add_fd_from_fd_array()
        __add_used_map()
          check_map_prog_compatibility()
            env->prog->aux->arena = (void *)map;

This happens for every program in verifier_arena.o, including these two,
whether or not an insn refers to the map.  The addr_space_cast check in
check_alu_op() (if (!env->prog->aux->arena)) and the prevent_zext/needs_zext
logic in adjust_reg_min_max_vals() only look at prog->aux->arena, so
removing the r9 load would not change what either test does with a kernel and
libbpf from this tree.

The comment also describes the mechanism differently from what happens.
libbpf only relocates the ld_imm64 to the map fd, and the verifier records
the map as used in add_used_map() during resolve_pseudo_ldimm64().

The log of the libbpf commit describes referring to the arena artificially,
as in asm volatile("" :: "r"(&arena)), as something that change makes
unnecessary.  The r9 load would only matter on a kernel that rejects
fd_array_cnt, or with the light skeleton loader, which test_loader does not
use.

The same four comment lines are repeated word for word above
mixed_arena_scalar_alu64_arena_first().  Could the comment be dropped
together with the r9 load, or be reworded to say the load is a fallback for
kernels where libbpf cannot bind the arena through fd_array_cnt?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40768193895
--===============1452548001571172891==--
