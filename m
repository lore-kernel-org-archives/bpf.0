Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611542;
	b=uTQfAIOU3wkjTmCU6WkSjicFYm4BaXZBOcDLIIz1KyIJ+Yn0mOEYQ+TeIcKOOZfAtCQU
	 GFJfLEWKtmmhRy/L6y8HMw5WHsritoa7kDxDTflOpTZCV2xvwXK4+OGwcBtOvbK6udk3H
	 57C8vxx3REbJzGesKjAkMVVWRTilcI7Sx+ySQUqR+RY8/2XcXpdJaZvjKZVHROzXudv2Z
	 fx821IhybioZwmDjfhlvARK+Gh27FDQjjUOAORSktmPw6wgy8DQUm/vc+sfeV/ADvqaWC
	 Wcim0LQHD0uhjj2zELShUJXCzgc/cK0wSx5yDjPOUZLZkQ6rB3KJKIfqFJ3fcy5f1bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611542;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=xJwwZxgVTy+Fn1GJyiLjqxXksuABHvOxqUmKTKjNtxU=;
	b=If9mVwDUxQCgncdz5mTLVboBOMcvmctASf7HWokic/+N9SJmJtavL2Fk7y8Vu4gyh6Qk
	 XhgVns5ma0oa99nc77D6pzHOkgSmUfAjNzfrpT+w/U1c1RdUZ2gxSmwWiCNUzTsfZDP3O
	 13zS3XQCW9IDAsgJpEwS5KfYo0jC8EuDAFVvSBLK9UtLKIPVg/WndjJhaYKzepXHjzrlG
	 /f+fEa73R3Jr7hwFUHU7Rif10SHdgeAXe0TgzqCiLbsGFnPphWIau1elH7bG+pHbFbG7N
	 fcVoiB1vOhwUKUSaEKMa0ScS4TzqNt04w9Tr6bJVjrlmMfqhj+wsN+unKYJrH31SzrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azBFn2lg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77260A2624
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azBFn2lg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044B1F00A24;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611541;
	bh=xJwwZxgVTy+Fn1GJyiLjqxXksuABHvOxqUmKTKjNtxU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=azBFn2lgFNbtBWx+QudPl5skPPp+Gj9ALlTXMirQI29SYUcXRFdhmrBM02FKz+jEU
	 OMkAJXqtERRt+66EXkLh/YwWJqfrqM+cpTdAwsPDkll8IWnZlA4j5/7aAaFiJ6ILWZ
	 aoG9QCGWSWe7Ctd89EzeN3/GNemecUa9bQYb0WjrN492amQii910rncptzlX//6Jfe
	 bGeQ3cwv1uyQaJ/1fsKdpWKIDCwhNdXw/1loNyq8KhK1Xw72sLGkeLWAQW3jChQHtW
	 8DDW8YN5bZsyMtAftIoqPFQC34wDtH40fKVRzbJ2N5OBleTuAWi8pfXBjVoMhnqiZ8
	 A8A4QFP1847eA==
Content-Type: multipart/mixed; boundary="===============8461552364154120016=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d39f998a1f56c15bfa3daee1e191cf77b532be16a0df25edb0053b5eaff35916@mail.kernel.org>
In-Reply-To: <20261102085122.916-1-gubin@cmss.chinamobile.com>
References: <20261102085122.916-1-gubin@cmss.chinamobile.com>
Subject: Re: [PATCH] libbpf: fix missing minus sign in btf_dump struct zero-check
From: bot+bpf-ci@kernel.org
To: gubin@cmss.chinamobile.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 09:25:41 +0000 (UTC)

--===============8461552364154120016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: fix missing minus sign in btf_dump struct zero-check

TL;DR:
- With the fix, btf_dump's nested struct zero-scan may read past the caller's
  data_sz buffer (possible out-of-bounds read)
- Commit message inaccurate about return values and omits the behaviour change

> libbpf: fix missing minus sign in btf_dump struct zero-check
>
> btf_dump_type_data_check_zero() returns -ENODATA when a datum is all
> zero (nothing to dump). In the BTF_KIND_STRUCT case the per-member
> result is compared with ENODATA (no minus sign), unlike every other
> branch which uses -ENODATA. The function only ever returns -ENODATA,
> so the comparison `err != ENODATA` is always true and the loop bails
> out on the first all-zero member: a struct that still has non-zero
> members is reported as empty and skipped by the dumper.
>
> Use -ENODATA so non-zero members are handled correctly.
>
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

The commit message says "The function only ever returns -ENODATA", but is
that accurate?

btf_dump_type_data_check_zero() returns 0 when the data is non-zero,
-ENODATA when it is all zero, and it also propagates errors such as -EINVAL
and -E2BIG from btf_dump_base_type_check_zero(),
btf_dump_get_bitfield_value() and btf_dump_get_enum_value().

What makes the comparison always true is that the function never returns the
positive value ENODATA.  Could this be reworded, for example "it returns
-ENODATA, never the positive ENODATA, so the comparison is always true"?

The message also doesn't say what changes after this patch: the zero scan
now visits all members instead of only the first one, so nested structs and
unions whose leading members are zero are now dumped when a later member is
non-zero.  Could that be mentioned?

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 53c6624161d7..fb8fd8b28a7d 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c

[ ... ]

> @@ -2468,7 +2468,7 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
>  			bit_sz = btf_member_bitfield_size(t, i);
>  			err = btf_dump_type_data_check_zero(d, mtype, m->type, data + moffset / 8,
>  							    moffset % 8, bit_sz);
> -			if (err != ENODATA)
> +			if (err != -ENODATA)
>  				return err;
                                ^^^^

With the sign fixed, the STRUCT/UNION branch of
btf_dump_type_data_check_zero() now walks every member of a nested aggregate
until it finds a non-zero one.  Before, it returned after the first member,
so the scan never went past it.

Can this scan read past d->typed_dump->data_end?

btf_dump_base_type_check_zero() does an unconditional
memcmp(data, bytecmp, nr_bytes), and btf_dump_get_enum_value() dereferences
data with no bounds check either.

In the normal dump path a member is checked first, since
btf_dump_dump_type_data() calls btf_dump_type_data_check_overflow() for base
types and returns -E2BIG before check_zero runs.  That doesn't cover the
aggregate itself, because check_overflow() only checks INT, FLOAT, PTR and
ENUM kinds.

The library explicitly supports a data_sz smaller than the type size (see the
comment in btf_dump_type_data_check_overflow() and the TEST_BTF_DUMP_DATA_OVER
selftests), and commit 5714ca8cba5e fixed an OOB read of a similar kind in
this file.

Concretely, take:

    struct outer { int pad; struct inner { int a; int b; } in; };

and call btf_dump__dump_type_data() with data_sz = 8, so data_end = data + 8:

  1. btf_dump_dump_type_data(outer, depth 0) calls check_overflow(), which
     has no bounds check for a struct, and check_zero(), which returns 0 at
     depth 0.

  2. btf_dump_struct_data() raises depth to 1.  For member 'in' (data + 4),
     check_overflow() again does no check for a struct, then
     check_zero(inner) runs.

  3. Member 'a' (data + 4..8) is in range and zero, so it returns -ENODATA.
     With the old 'err != ENODATA' the function returned -ENODATA here and
     the struct was skipped with no further reads.  With '-ENODATA' the loop
     continues.

  4. Member 'b' is at data + 8..12, past data_end.
     btf_dump_base_type_check_zero() calls memcmp(data + 8, bytecmp, 4) and
     reads 4 bytes past the caller's buffer.

The over-read is bounded only by the size of the nested aggregate, so a
nested struct with a large array member can read much further.

The reads past data_end only happen when the leading members are zero.  If
the out-of-range bytes happen to be non-zero, the struct is dumped and the
later btf_dump_dump_type_data() call returns -E2BIG for that member.  If they
are zero, the struct is silently skipped and the dump reports success.

The BTF_KIND_ARRAY branch of the same function has a similar unbounded scan,
but it is not changed by this patch, whereas the struct/union scan past the
first member is newly reachable.

Should the zero scan be bounded by d->typed_dump->data_end in the
struct/array branches, or should check_overflow() run on each member before
the check_zero() recursion?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41417286408
--===============8461552364154120016==--
