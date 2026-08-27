Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93410F2;
	Thu, 27 Aug 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809796; cv=none; b=PNShLCjVz+V/zcldn8YEbbLr4X00adpBS2ihpLrBSRIXSV0BD66ZZGd1b4MJfaw2TZ/nENSRYLzE6WwwPpM11KZA22jTOiPljFLfHfrQXoXcSOU2vyGR75xXvx3vUZOVbjino3tqa6RjBjyUhukNl7vIe8mu2C1ZHMdH4B0tAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809796; c=relaxed/simple;
	bh=Z0WoQFfQ6flKBGDHLSAeSX33Ew58x+pi4jdxuilyIlI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TYXGGySfl326/z8uCQWjt3q63+xxbJHucYLDsHGjOOl0eSYLb9H5+6TS+b/xtQ9YlA67ay7VlmD5L9wdJOSpicucfFjwZQu5QTbLFp7QI+P1jfJ9TJCbHvEM/T12Jw0yq682dnaymmfudxQS8Jm4HG2RJN1/rdV2lYH7Ug6OL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6woMtHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6woMtHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2821F000E9;
	Thu, 27 Aug 2026 05:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787809794;
	bh=/DNH7/Wwtrh+SJ6YbpOxxbEnDSPFOQlBwUSdg4shbCk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S6woMtHrVtcWRWX8dubiQ+1NWVxuwj7S2PpKGTFYCu+UPr6tAwwbVy4owMgeXGfUj
	 3dOwEJl+6b0zwBqfvmROx1f/U7fhAcl7mDiUp6uRbIDGLpsjZdjafIxH6epccF8G5H
	 FDSffRlfLS0kHmK3/OJ1HFgp2HL87SLkkwTudp6o3B2hJXS0Web3RFXPhZLIZ1yTJE
	 6ZAergNmIg6wUtl7AHI5yQ7rWrB6e0mpeI4Od4KEbcZQo64c4/rNBT9V7914sRurqX
	 /Ar2YWftQMqbuLzeZeKlhrYhQ11x/lEC0ataYpQP99lMYPdNUD8J00Vdc806t1aRcU
	 LrTTuSms4/ClA==
Content-Type: multipart/mixed; boundary="===============1588356556942625386=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <43efa71e1fcb4cee5edd4d2ed696f13b902159fd0ef31a75f90803cb79284eb1@mail.kernel.org>
In-Reply-To: <20260827051859.45511-1-blbllhy@gmail.com>
References: <20260827051859.45511-1-blbllhy@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
From: bot+bpf-ci@kernel.org
To: blbllhy@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org
Cc: ameryhung@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,wangfushuai@baidu.com,bestswngs@gmail.com,mattbobrowski@google.com,kees@kernel.org,menglong8.dong@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,AutonomousCodeSecurity@microsoft.com,xmei5@asu.edu,tgopinath@linux.microsoft.com,kys@microsoft.com,blbllhy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 05:49:53 +0000 (UTC)

--===============1588356556942625386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..7228520aa2b6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
>  		ctx.map = info->map;
>  		if (selem) {
>  			sk_storage = rcu_dereference(selem->local_storage);
> +			if (!sk_storage)
> +				return 0;
                                   ^
Should this return SEQ_SKIP instead of 0?

Returning 0 tells bpf_seq_read() that the object was shown, but it was
actually skipped. In kernel/bpf/bpf_iter.c bpf_seq_read():

	err = seq->op->show(seq, p);
	if (err > 0) {
		/* object is skipped, decrease seq_num, so next
		 * valid object can reuse the same seq_num.
		 */
		bpf_iter_dec_seq_num(seq);
		seq->count = offs;
	} else if (err < 0 || seq_has_overflowed(seq)) {

With return 0, bpf_iter_dec_seq_num() is not called, so the skipped
element consumes a seq_num that no BPF program invocation ever observes.

If the skipped element is the first one returned by
bpf_sk_storage_map_seq_start(), seq_num 0 is consumed with no program
run, the next valid element is shown with ctx->meta->seq_num == 1, and
iterator programs that emit a header on `ctx->meta->seq_num == 0`
silently lose their header. Examples that would break:

tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c:
	if (ctx->meta->seq_num == 0)
		BPF_SEQ_PRINTF(seq, "      id   refcnt  ...\n");

tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c:
	if (ctx->meta->seq_num == 0)
		BPF_SEQ_PRINTF(seq, "  sl  local_address ...\n");

For later elements the observable effect is a gap in the seq_num
sequence.

The other socket iterators handle this exact situation (object found
stale after handed to ->show()) by returning SEQ_SKIP:

net/ipv4/tcp_ipv4.c bpf_iter_tcp_seq_show():
	if (unlikely(sk_unhashed(sk))) {
		ret = SEQ_SKIP;
		goto unlock;
	}

net/ipv4/udp.c bpf_iter_udp_seq_show():
	if (unlikely(sk_unhashed(sk))) {
		ret = SEQ_SKIP;
		goto unlock;
	}

net/unix/af_unix.c bpf_iter_unix_seq_show():
	ret = SEQ_SKIP;

Returning SEQ_SKIP is safe for the first object too: seq_num is u64
and bpf_iter_dec_seq_num()/bpf_iter_inc_seq_num() in
kernel/bpf/bpf_iter.c wrap back to 0 before the next ->show().

---

A subsystem pattern flags the following as potentially concerning:

>  			sk_storage = rcu_dereference(selem->local_storage);
> +			if (!sk_storage)
> +				return 0;
>  			ctx.sk = sk_storage->owner;
>  			ctx.value = SDATA(selem)->data;

The fix adds a single check-based abort path for a race that has no
exclusion mechanism, and the instructions that follow the abort point
still consume the contested selem.

Looking at bpf_selem_unlink_nofail() in kernel/bpf/bpf_local_storage.c,
it tears the selem down in this order:

1. b->lock: hlist_del_init_rcu(&selem->map_node);
   bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
2. RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
3. local_storage->lock: hlist_del_init_rcu(&selem->snode);
4. RCU_INIT_POINTER(selem->local_storage, NULL);    <- new check sees this

A concurrent iterator that re-reads selem->local_storage between steps
1 and 4 still sees a non-NULL pointer and proceeds to:

	ctx.sk = sk_storage->owner;
	/* owner is deliberately NOT cleared in the destroy path:
	 * "Okay to skip clearing owner_storage and storage->owner
	 * in destroy() since the owner is going away" - so ctx.sk
	 * can be a sock already inside __sk_destruct() */

	ctx.value = SDATA(selem)->data;
	/* bpf_obj_free_fields() has already released the value's
	 * special fields (kptr/timer/etc.) at step 1 */

So the NULL check closes the specific general-protection fault in the
report (sk_storage == NULL, offset 0x88 == offsetof(struct
bpf_local_storage, owner), matching the KASAN address
0xdffffc0000000011) but does not make the iteration race-safe; it
narrows the window rather than closing it.

Worth confirming with the local-storage maintainers whether the
iterator needs to observe selem->state / SDATA(selem)->smap (or take
the same exclusion bpf_selem_unlink_nofail uses) rather than only
local_storage?

The residual window is not introduced by this patch - the same two
lines executed unconditionally before it, so relative to the parent
commit the change is a strict improvement. Practical impact of the
residual window is also limited: ctx.sk is registered
PTR_TO_BTF_ID_OR_NULL so programs must NULL-check it, and ctx.value is
PTR_TO_BUF, so a BPF program cannot dereference a released kptr read
out of it without a kfunc.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33042447773
--===============1588356556942625386==--
