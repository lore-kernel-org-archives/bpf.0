Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3043E48B
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791126673; cv=none; b=Ek9d+e1Uf5BVPKxJIbSxk4rGUobzIIujarzuHDb49hpgt+6X9OnHIhBLwzgUtX468EnYQM89TRtKIIVKF/xUZ7GD8cfYeS6TmilJIq2Ty0Mf1Fk52/h1hAAKPmlU++JYqTPzP747Mz+Rzg2IEMKEAKuBc8g/XhUcp6/ZSRvsx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791126673; c=relaxed/simple;
	bh=QK63Ina5dZhu3wAkzfklwvOhvGjTlarQ9pIHqhNI1z4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L5fBNJQjLkN6UAj/U897pMTZ0Fe+paRt7wmRAr2pAMjPoZjBynJ3SDSqD7rXBe4iO4zOtg8Hwq8BUYdisbvQuuvXmSS0iLVN7UBlEM0ZpTFWsflj5ZUkScuHF1m8k6uw6y1+H9cXcyojGFQKHDQQCkRz9h+s6dt3nz1Uw2wWIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3S7DzZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3S7DzZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7FA1F00893;
	Sun,  4 Oct 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791126670;
	bh=s6bGCqdSAmxwTGWjrcl9mJOqneRhlEjVaW/YrMfx+oQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q3S7DzZzeFQGxM+lrHwjyXsfqM3td3LLNrgl5sg9bdlt/A7t5FHrzBOKDxOjX3+o3
	 09Y2QCla2FwlqizU5syjz4qVBiEjvF5u88A68nEjXeJ+XJizl+9KTT7JyqD76VQrpx
	 5h6ng0DTaFLGiKcodByA3FbC3XPkPjH0jaOVwjCap2Rz7+ElqQdV9o8gYesqRl/XAT
	 M10GXpEe0ZkKGJWsaucO4IV1tI/jLDkAqP2ibREO6S8FHI6kBFBEgRYwmOuRpNj6lE
	 Ufa09T3JJjZtxIdp1Pnbxzy65Lf/s4RAc0d/IFh5lpkX7WSq2EQZpRwIMN3t6T4nQ/
	 J3YChvgi3j3wg==
Content-Type: multipart/mixed; boundary="===============8496249574967172224=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21ddbc3ab287f38ec45db90b1ecfb87169a755e60138bc06bfd9bfa3eb708176@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-15-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-15-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 15/43] bpf: varying offset access support for PTR_TO_BTF_ID pointers
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 15:11:09 +0000 (UTC)

--===============8496249574967172224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: varying offset access support for PTR_TO_BTF_ID pointers

TL;DR: Variable-offset BTF access may now reach allocated objects for writes
too; if a union overlays an array with a special field (spin lock, kptr), the
verifier may allow direct stores to it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f71778a75f30..27a53204696f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6536,36 +6537,31 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
>  
> -	if (!tnum_is_const(reg->var_off)) {
> -		char tn_buf[48];
> -
> -		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +	if (check_add_overflow(reg_smin(reg), off, &min_off)) {
>  		verbose(env,
> -			"%s is ptr_%s invalid variable offset: off=%d, var_off=%s\n",
> -			reg_arg_name(env, argno), tname, off, tn_buf);
> +			"%s is ptr_%s access, offset computation overflows: register's minimal offset is %lld, instruction offset is %d\n",
> +			reg_arg_name(env, argno), tname, reg_smin(reg), off);

[ ... ]

> @@ -6575,6 +6571,18 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>  	}
>  
>  	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
> +		if (!tnum_is_const(reg->var_off)) {
> +			char tn_buf[48];
> +
> +			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +			verbose(env,
> +				"%s is ptr_%s invalid variable offset: off=%d, var_off=%s\n",
> +				reg_arg_name(env, argno), tname, off, tn_buf);
> +			return -EACCES;
> +		}
> +
> +		off += reg->var_off.value;
> +
>  		if (!btf_is_kernel(reg->btf)) {
>  			verifier_bug(env, "reg->btf must be kernel btf");
>  			return -EFAULT;

Can BPF_WRITE accesses to allocated objects now reach btf_struct_access()
with a non-constant var_off?

The old check at the top of check_ptr_to_btf_access() rejected every
non-constant var_off.  After this change the rejection only remains inside
the branch guarded by:

    if (env->ops->btf_struct_access && !type_is_alloc(reg->type) &&
        atype == BPF_WRITE)

For a PTR_TO_BTF_ID with MEM_ALLOC (type_is_ptr_alloc_obj()), that branch is
skipped, so the else path runs and the access goes on to btf_struct_access()
with a variable offset for both reads and writes.  The commit message only
talks about relaxing reads.

In btf_struct_access(), the special field check for allocated types is only
done at off = min_off:

    for (i = 0; i < rec->cnt; i++) {
            struct btf_field *field = &rec->fields[i];
            u32 offset = field->offset;
            if (off < offset + field->size && offset < off + size) {
                    bpf_log(log,
                            "direct access to %s is disallowed\n",
                            btf_field_type_name(field->type));
                    return -EACCES;
            }
    }

The code added under check_variable_offset: then only verifies that
[min_off, max_off + size) stays within one of the recorded arrays and that
reg->step is a multiple of the element size.  It does not look at the
btf_record fields again for offsets above min_off.

If a union overlays a scalar array with a bpf_spin_lock, a list or rbtree
node or head, a refcount, or a kptr (btf_find_struct_field() descends into
unions, so such a record is accepted), could an access at min_off pass the
overlap check above while a later offset in [min_off, max_off] lands on the
special field?  For a write, that would be a direct store into a field which
the constant offset check rejects.

Should check_ptr_to_btf_access() keep rejecting a non-constant var_off for
writes to allocated objects, or should the btf_record overlap check in
btf_struct_access() cover the whole [min_off, max_off + size) range?  If
writes are meant to be relaxed too, the commit message should say so.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============8496249574967172224==--
