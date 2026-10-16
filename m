Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B226299
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792111152; cv=none; b=iIGY91HKpkmpSeesCAk9Auw31bflbcK0O6/vtmiRAjDNDXEJL4O80eoiuyFjFuY/YB7a3kWf5Se1wzZbpMjM2S0025+PKpkjgplV5Q6Y48EUMUlL/aDRaKJph3B9Yew8lbtOBYtEb8mKCJqTdWZEdeKlhUMK9xAI4JiFPHVo/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792111152; c=relaxed/simple;
	bh=kNU+gTfXnBSkZb4pwRNNzld4Kr5uJFWio2koLy2jfW4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AsmBjDbDPUVWFInpHfTsJJlVp2hjVL1Un/EbDKgsPMFqCA6/Fh1oYpRiIc7XIOHyGpj7jXBhQ1585HitVG4e8azsINrm1JcfslXDDk/5ejKhyywUfb3rSlFglP6tkZYu6lcTLRRIPAe+jlk1Q9Y3XKzH9asnEdZEVCnIYq2QG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN39ypMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN39ypMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041EC1F000C4;
	Fri, 16 Oct 2026 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792111150;
	bh=Q2x4JciZ+vOU+AbdWCZUGkcXM4xILaeiPxnKuCZ3ArM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BN39ypMbP5qldk56VlVngsmSVKRgXaus04F6EdKU1Xkie8YZvQ98WNpRC79U2zU3y
	 1O8Ad6tLMH/Z8vX0J1kZ+XG/OyZKFlsdo9M+zQ55l1mjrkrmboMY9WtdW/rkktKQWC
	 lzjQcmYcP+Mc1/7U9aqphH+s9tUNAJJ+BfYESHQIPN9fMp6+uNP3y4pa669cAWAozg
	 mkULGpoiLL0LDypxwLbgZhXCbV33rl/T9D4vo5mIfdTOEpAAjiOw9WRhJEXQvmXDsj
	 ruAL8xJrkIokBgMvPsZJULFm2m7/z2ka28SvFq4pwmvcQipukbr/LNpbI2IhmgrL8c
	 mkB2s9PKwmwXA==
Content-Type: multipart/mixed; boundary="===============0743669683247930264=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec5b341e8c10307ac92670b90d16d0e6997611a1fd3c217c9d6972ee6632deae@mail.kernel.org>
In-Reply-To: <20261016000012.2232059-4-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 3/8] bpftool: Apply __bpf_core_pai per record on BTF dump
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org
Cc: bpf@vger.kernel.org,alan.maguire@oracle.com,cupertino.miranda@oracle.com,david.faust@oracle.com,irogers@google.com,jose.marchesi@oracle.com,vineet.gupta@linux.dev,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 00:39:08 +0000 (UTC)

--===============0743669683247930264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Apply __bpf_core_pai per record on BTF dump

TL;DR: Tagging every struct with __bpf_core_pai may make GCC-BPF programs'
narrow ctx accesses (e.g. skb->mark) be rejected by the verifier at this
patch; later patches fix it, so bisection may regress. Fold fix in or reorder?

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> @@ -1121,6 +1121,24 @@ static struct btf *btf_c_detached_copy(const struct btf *src)
>  	return copy;
>  }
>
> +static int btf_c_annotate_records(struct btf *btf)
> +{
> +	__u32 i, cnt = btf__type_cnt(btf);
> +	int err;
> +
> +	for (i = 1; i < cnt; i++) {
> +		const struct btf_type *t = btf__type_by_id(btf, i);
> +
> +		if (!btf_is_composite(t))
> +			continue;
> +		err = btf__add_decl_attr(btf, "__bpf_core_pai", i, -1);

Can this tag on every struct and union break GCC-BPF programs that access
verifier-rewritten context types through vmlinux.h?

The tagged types include __sk_buff, xdp_md, bpf_sock, bpf_sock_ops,
sk_msg_md and similar UAPI context types.  In dump_btf_c(), __bpf_core_pai
now expands to preserve_access_index whenever:

    !defined(BPF_NO_PRESERVE_ACCESS_INDEX) &&
    __has_attribute(preserve_access_index)

GCC-BPF ignored the old "#pragma clang attribute push", but it does have the
attribute, so with this patch it emits CO-RE relocated accesses for these
types for the first time.

check_ctx_access() in kernel/bpf/verifier.c calls

    __check_ptr_off_reg(env, reg, argno, fixed_off_ok)

with fixed_off_ok = !env->ops->convert_ctx_access, so a ctx pointer with an
adjusted offset is rejected.  libbpf can only patch an LDX whose offset
equals the original field offset (relo_core.c reports "unexpected insn
(LDX/ST/STX) value" otherwise).

A narrow access such as ((__u8 *)&skb->mark)[1] therefore cannot become a
single "ldxb [r1 + 9]" any more.  It turns into pointer arithmetic on the
ctx register, which the verifier then rejects.  The same GCC program built
before this patch uses a constant offset that the verifier accepts.

Clang is unaffected, since the old pragma already behaved this way.  The
in-tree GCC selftest flavor passes -DBPF_NO_PRESERVE_ACCESS_INDEX (see
tools/testing/selftests/bpf/Makefile), so it does not exercise this.

Later patches in this series address it:

  59158e0d2295 ("bpftool: Skip __bpf_core_pai on verifier-rewritten context
  types") removes the attribute from these 13 types and their nested
  anonymous records.

  d7ea54ed605e ("bpftool: Emit __bpf_core_pso on verifier-rewritten context
  types") adds preserve_static_offset to them.

  57ae13c435b8 ("selftests/bpf: Cover context and socket accesses through
  vmlinux.h") adds tests for the narrow skb->mark load.

If the series is applied in order, this patch is a bisection point where
GCC-BPF ctx accesses regress.  Should the exclusion be folded into this
patch, or should the patch order be changed?

> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38828475934
--===============0743669683247930264==--
