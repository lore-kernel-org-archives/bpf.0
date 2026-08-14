Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82D29BDB5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748189; cv=none; b=L6qWgGhtTwS7TwklA7ytm0SLiuQT1MooG9F/blWvn9T8YukaHCIP0jFipYtPO4PG9X6AIhtjEWP+1/YGupOGiWvz5+cIoTPazU5IHUbBhKkkHzUjyLpQlidqoKQiHM+26PXD/vPD9PMt1KxFKqEV6vguNR10mW6TcYFw1qkOF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748189; c=relaxed/simple;
	bh=tedb55kDUNF4Zu60VCJOf9S46E/jTIxeFFYt7B7xD0g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r7LQQh7VWAgHCVot4q6RWxZsWdvpwRlrVrUAW8G7tWqi+O1dMjLwR48cGwxScXzMqBDNhJAyfGW955n4HpDngO5oBL5SvhsLtPYriuEbKvWY5Urwjeao8lkeAJev/sMGn5tK+p72u3qPOq++q7X0lxO18cUKuqZzGP+xkM4lGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEQgVcoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEQgVcoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC151F000E9;
	Fri, 14 Aug 2026 22:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748187;
	bh=tedb55kDUNF4Zu60VCJOf9S46E/jTIxeFFYt7B7xD0g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BEQgVcoMhdvW6+LbGSYak4OgXe/7n+sGFTscALEupNOs1W47Zkx1B16boXRhRpV1t
	 DG8GWy5NjLFjcaUWhw/vwQYw5osUzT7vvpIPNQsKsuRXM6Wbut4diMW7taXO+j9cAg
	 aG9Jy51htQXNChDLZNneZfi2R/1RjXAkBxhJDRC49hTq+q/iGYpblHqIY0bC/OGWCy
	 apxZPCRwcem0h3XuY4SU9B3RAs9vFBdWvudnXtc4p3/+nGEOe35XRcHYYqPICi/jb5
	 ehWHYfBBt93nuPLbwLF2m8PvYcKRTF2gzY9WK3t9zPdgu0PaEBQtW02UShB3Wzz56G
	 TL9dcL3Y5Y1jA==
Content-Type: multipart/mixed; boundary="===============0770557292099713232=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <51afcc2b1c0704ce7cec1e6ff7aa6423fee6b3afad0ceebc4a118828ea87586b@mail.kernel.org>
In-Reply-To: <20260814215301.709827-5-daniel@iogearbox.net>
References: <20260814215301.709827-5-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: Add tests for pointer type merge at a shared load
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,eddyz87@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 22:56:27 +0000 (UTC)

--===============0770557292099713232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
> index b91271d4caa4..ac8bba3e7d02 100644
> --- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
> +++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c

[ ... ]

> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=untrusted_ptr_sock")
> +__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=ringbuf_mem")
> +__retval(0)
> +int mixed_mem_untrusted_btf_id_type(void *ctx)

[ ... ]

> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("= *(u32 *)(r{{[0-9]}} +0){{.*}}=ptr_nameidata")
> +__msg("= *(u32 *)(r{{[0-9]}} +0){{.*}}=ringbuf_mem")
> +__retval(0)
> +int mixed_mem_btf_id_type(void *ctx)

[ ... ]

> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("r8 = *(u32 *)(r7 +0){{.*}}R7=ptr_nameidata")
> +__msg("r8 = *(u32 *)(r7 +0){{.*}}R7=rdonly_mem")
> +__retval(0)
> +int mixed_rdonly_mem_btf_id_type(void *ctx)

[ ... ]

> +SEC("socket")
> +__success
> +__log_level(2)
> +__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=ringbuf_mem")
> +__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=rdonly_untrusted_mem")
> +__retval(0)
> +int mixed_mem_mem_type(void *ctx)

[ ... ]

> +SEC("socket")
> +__failure
> +__msg("same insn cannot be used with different pointers")
> +int mixed_map_value_mem_type(void *ctx)

[ ... ]

> +SEC("socket")
> +__failure
> +__msg("same insn cannot be used with different pointers")
> +int mixed_stack_mem_type(void *ctx)

[ ... ]

A subsystem pattern flags this as potentially concerning: these six
tests cover only two of the four commits in the series. The three merge
shapes listed in dea41ba6e67d's changelog map 1:1 onto the
mixed_mem_untrusted_btf_id_type, mixed_mem_btf_id_type, and
mixed_rdonly_mem_btf_id_type tests, and the mixed_mem_mem_type,
mixed_map_value_mem_type, and mixed_stack_mem_type tests cover the new
PTR_TO_MEM mismatch rule from fbffa57329b8.

However, the other two commits appear untested:

bcfd0d6a160f changed check_ptr_to_btf_access() from checking
type_flag(reg->type) & PTR_UNTRUSTED to calling
bpf_may_fault_on_deref(), so a BPF_STX through a bare PTR_TO_BTF_ID is
now rejected with "only read is supported". The changelog documents a
reachable bpf_qdisc panic (next = sch->next_sched; next->limit = 1000;),
but no __failure / __msg("only read is supported") case is added here or
in progs/bpf_qdisc_*.c. Only verifier_global_ptr_args.c and
verifier_netfilter_ctx.c assert that message, and both do so for
PTR_UNTRUSTED pointers that the old check already caught, so the
newly-closed hole is untested.

bef47cf76444 states that PTR_TO_BTF_ID|PTR_UNTRUSTED|MEM_ALLOC|NON_OWN_REF
and PTR_TO_BTF_ID|PTR_UNTRUSTED|MEM_RCU were reachable and left as plain
loads (two Fixes: tags). The added tests only produce
ringbuf/rdonly/bare-BTF-ID types, all of which the old exact-match list
in bpf_convert_ctx_accesses() already handled or which the merge path
covers.

Would it make sense to add tests for the bcfd0d6a160f store-rejection path
and the bef47cf76444 MEM_ALLOC|NON_OWN_REF and MEM_RCU cases here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31845722500
--===============0770557292099713232==--
