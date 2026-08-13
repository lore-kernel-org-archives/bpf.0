Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F4361976;
	Thu, 13 Aug 2026 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659038; cv=none; b=CjzPrTklJP+YOy06+kg69oC8aSxO+ujxwCWQ+IrmZ4fvprZOwnBbLUWMnxlA40wZKqbMxC5HtPC33BKvgnwlOhkKj0EmiyDX2WEDvhafFHkzKyPEkgTUJ7Cx1Y6oyJcMieLpOj/cxq951UZrww931o1Ki+gu8nx+MNdLzjG4tQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659038; c=relaxed/simple;
	bh=POXpIRD4wmUHvq5EVRhrrHK7dmS6cVVMl3iHwixvm9E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CmWiqufMSS5vFfS/QcYhKytnt4kWNS13/OL6grMyeEhCgw3L3okeRW8W99aPCPZ6IhXwBTHeI65uz+S3yogQnKDTMqH2QnlhdTjGMq1Igin6tsDUqSweTNVzRmij5b9VeKOanNZJ9IV+xlJC+S12XvvLMShFI0WAb9pjMBApJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJb6r5cU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJb6r5cU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3FF1F00A3A;
	Thu, 13 Aug 2026 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659036;
	bh=hkxTWcvChsvj61vzegcnkZFzyTe5mjr4qA5ydcOUnVw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VJb6r5cU0mo/3v5El5LCFZ9lSbzo3+KVvsMSboRjZ72wTWz1xHi2aOYMEUFoxnQUe
	 fh8ozXcly17ElnUpNSzfZxfrEpivWW7OaOBxDJyWPWuFrB+oA0Xr/wAKGUWsbP0wkp
	 UJFkyq72XHBvZxfGgYhI5ZlnUjKfi8Xv667Bc1hrQvK+7pjEA8Ptb9yFsQc7pZJ15e
	 pirHLwhIl8H06gH2pguWzuCYIUtUeI9vAU7kEMJMcBGcg/kn6/3X0shKmmej10QxQq
	 DpVHrug6Oyb6qa7evmrC8nR2iSLZi684H4Z0ROiuPnL5QsTkblzimhbeC7Jw6oDtOw
	 tpJ+4ngjEpbzA==
Content-Type: multipart/mixed; boundary="===============8004572713851048476=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <244c96861c2f5eedf2fec73ffb1dcff7c7eec570a426361b5fc93000f19850dd@mail.kernel.org>
In-Reply-To: <20260813211533.290256-5-dingning04@gmail.com>
References: <20260813211533.290256-5-dingning04@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: Test untrusted allocated-object pointers
From: bot+bpf-ci@kernel.org
To: dingning04@gmail.com,bpf@vger.kernel.org
Cc: memxor@gmail.com,greg@kroah.com,dingning04@gmail.com,sashiko-bot@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,chengkaitao@kylinos.cn,vmalik@redhat.com,utilityemal77@gmail.com,leon.hwang@linux.dev,chenyy23@mails.tsinghua.edu.cn,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 22:10:35 +0000 (UTC)

--===============8004572713851048476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> index fd35093285c0d..383c5b1b7111f 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> @@ -893,6 +893,106 @@ long refcount_acquire_rcu_map_kptr_null_checked(void *ctx)
>  	return 0;
>  }
>
> +SEC("?syscall")
> +__success
> +long map_kptr_read_after_rcu_unlock(void *ctx)

A reviewer noted in v3 that the tests use TC programs with implicit RCU
protection, causing pointers not to become untrusted as intended, and
specifically suggested: "The right fix might be to use fentry.s for these
tests to trigger untrusted marking of pointers."

v4 uses SEC("?syscall") instead. While syscall programs are sleepable and
may trigger untrusted marking, does this section annotation achieve the
same behavior Kumar recommended fentry.s for? The deviation from the
specific suggestion wasn't discussed in the v4 thread.

> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *n;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	return n->key;
> +}
> +
> +SEC("?syscall")
> +__failure __msg("is neither owning or non-owning ref")
> +long refcount_acquire_graph_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n, *m;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	m = bpf_refcount_acquire(n);
> +	if (m)
> +		bpf_obj_drop(m);
> +
> +	return 0;
> +}
> +
> +SEC("?syscall")
> +__failure __msg("only read is supported")
> +long graph_map_kptr_write_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	n->key = 1;
> +	return 0;
> +}

Does this test actually verify the fix? The "only read is supported"
rejection comes from the PTR_UNTRUSTED check in check_ptr_to_btf_access():

    if (atype != BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
            verbose(env, "only read is supported\n");
            return -EACCES;
    }

This check is unchanged in the pre-series tree and rejects writes through
any PTR_UNTRUSTED register for both object layouts. A kernel missing the
series fix would still fail this test with the same message, so the test
wouldn't catch a revert.

> +
> +SEC("?syscall")
> +__success
> +long graph_map_kptr_read_after_spin_unlock(void *ctx)
> +{
> +	struct map_value *mapval;
> +	struct node_data *n;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> +	if (!mapval)
> +		return 0;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 0;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	bpf_spin_lock(&lock);
> +	bpf_spin_unlock(&lock);
> +
> +	return n->key;
> +}

Is __success correct for this read? After bpf_rcu_read_unlock() in a
sleepable program, the pointer gains PTR_UNTRUSTED but keeps NON_OWN_REF
because the fix excludes PTR_UNTRUSTED from type_is_ptr_alloc_obj().

At the load, the type is PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED |
NON_OWN_REF. The bpf_convert_ctx_accesses() switch in
kernel/bpf/fixups.c lists these BPF_PROBE_MEM cases:

    case PTR_TO_BTF_ID | PTR_UNTRUSTED:
    case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:

but not the NON_OWN_REF variant, so the switch falls through and the load
stays a plain BPF_MEM access with no exception-table entry.

The object is freed via bpf_mem_free_rcu(), so in a sleepable syscall
program that has left the RCU critical section, a grace period can elapse
and the page can be returned to the allocator before the load executes,
causing an unprotected fault.

Pre-series, invalidate_non_owning_refs() at bpf_spin_unlock() killed this
register because type_is_non_owning_ref() was true. Now that
type_is_ptr_alloc_obj() excludes PTR_UNTRUSTED, type_is_non_owning_ref()
returns false and the stale register survives.

The sibling test map_kptr_read_after_rcu_unlock (node_refcount_only, no
graph node, hence no NON_OWN_REF) does match a BPF_PROBE_MEM case and gets
the probe rewrite. Should either fixups.c gain a NON_OWN_REF case and this
test document the probe path, or should NON_OWN_REF be stripped in
invalidate_rcu_protected_refs()?

> +
>  static long __stash_map_empty_xchg(struct node_data *n, int idx)
>  {
>  	struct map_value *mapval = bpf_map_lookup_elem(&stashed_nodes, &idx);
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index acd3e81a39168..0cc4cbd0c81b1 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -127,6 +127,33 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(void *ctx)
>  	return 0;
>  }
>
> +SEC("?syscall")
> +__failure __msg("is neither owning or non-owning ref")
> +long refcount_acquire_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *n, *m;
> +	int idx = 0;
> +
> +	mapval = bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n = mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	m = bpf_refcount_acquire(n);
> +	if (m)
> +		bpf_obj_drop(m);
> +
> +	return 0;
> +}
> +
>  SEC("?tc")
>  __failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)

The commit message states:

> The verifier previously allowed pointers used after RCU protection ended
> to reach bpf_refcount_acquire() and, for one object layout, a direct write.
> If the object was freed and reused, these operations could access stale
> memory.
>
> Add tests that keep BPF_PROBE_MEM reads accepted but reject reference
> acquisition and direct writes after RCU protection ends. Cover both tested
> object layouts.

Is the description fully accurate?

The "direct write" was never allowed for any object layout. The
PTR_UNTRUSTED check in check_ptr_to_btf_access() predates the series and
rejects writes through any PTR_UNTRUSTED register for both node_data and
node_refcount_only.

The claim "keep BPF_PROBE_MEM reads accepted ... Cover both tested object
layouts" is only true for node_refcount_only (map_kptr_read_after_rcu_unlock).
The node_data read (graph_map_kptr_read_after_spin_unlock) ends up with
PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED | NON_OWN_REF, a combination
missing from bpf_convert_ctx_accesses() in kernel/bpf/fixups.c, so it
stays a plain BPF_MEM load without probe rewrite.

The genuinely new coverage is the two bpf_refcount_acquire() tests. Would
it be more accurate to scope the description to those plus the
refcount-only read?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31745514567
--===============8004572713851048476==--
