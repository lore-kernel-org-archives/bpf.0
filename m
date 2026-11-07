Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063000;
	b=abOMACnJjcSmfXGPzbjX6YUjnBQSO9VnDB2r9AmNV/vV6VUnsV303JYGEa3RXtY/0eUa
	 hEMC7Ve5j3PC4NnQwD/e3Lrt7PNSDT1/8MSSlfvSmAlUMiJ90HpP7jLRNOeeYFWihQVQz
	 2Gc7fij2V7UrFw97/2xubi+JflfKSelYEi7e4gRL3WMb6Z4kMTQ2JdqoEb8yDdfw9jJOR
	 WyhLAXxrDhBcK6yMXrbH56xo2SMlRZYyuwdRTghs+7+abIEbQFTJu/9qIaOM8Dt4oL9f7
	 DKJ9zQkFDJRiKAjMkkbBE495KTtW3xNjdyu8+KBGG1jYwYVRudhPu3+6Re9rn4y3fyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063000;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WuMnn9MTDjSA06vLFW9SC+VwJuL0y+R4oCYeZYKUpdM=;
	b=b9fOCEdm29/xz0Q6ggavIkQgdsPRZ0RL7XoHZnYu3wXGJlFNPaRXs0X5qjDJ8s4Oa9Cs
	 3ZVBcTVQVfh75wENNwqJD3rmjwGrO3R6NXhP7TCehRWykjXV0XmgTqZJoTHIM/vG1zL+m
	 uTwxsyriT4WMmniDHG8haKTEh0ACTrOHU6UKlqXGi9/zNhuVJBZxdhJM1Nws5IbsczHnp
	 lxbDqQwtY6J/BtsIHjSoOEXb6wIcfuY4QlX3qcnb/nOvvfIW2OiQd744TXCsxdN8iqLAW
	 SEB4bAG1yphn81TkTqDPYjn09mx4Z8+TLFF8ld1XcEDOl8j+jJvqnbjSHWSRxlhzfQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ap1Ht96P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C4606D810;
	Sat,  7 Nov 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ap1Ht96P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314781F008A4;
	Sat,  7 Nov 2026 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062999;
	bh=WuMnn9MTDjSA06vLFW9SC+VwJuL0y+R4oCYeZYKUpdM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ap1Ht96PoZhMMH2OnnhfM//OSqLg7C/GqN04YCWPaZWG8kD2KVot+wQvwxMxCXNL8
	 2nz3nAI1+kO7pcWWcCkoRzuHCvHbaCXnH0JPf3GwRxvAUfZNAw7x6lUB8nY4shmtoV
	 CbBH/l+2F+ERb+gLMEGOPJITT67HjiwH7g2mAGibJn1g7bCfoFgR+HXyQWWwjM2iIi
	 bpe9GZMffcMbLUKEIAX9wDmD53vSMYmkk/8aL7G2BtfKZP8QkA9GpndWmUPBtdzHEk
	 j06BZYtE3+2J7C1AYubnqHCVxWhzHjYMRn6qnF1ZfQ6mJv/sIxIBJ4Q5w271usHINA
	 jZxI/ldSvKt9Q==
Content-Type: multipart/mixed; boundary="===============9163831857622064988=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f55c7b6bd45c263bc9551f742b10ebafa6573bb3a4460ef146d6518db847caba@mail.kernel.org>
In-Reply-To: <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
References: <LO2P302MB0197FAF0305A94F7575CA700BC752@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
Subject: Re: [PATCH bpf] bpf: Reject writable map iterators on read-only and frozen maps
From: bot+bpf-ci@kernel.org
To: adethyasrinivasan@outlook.com,yonghong.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,adethyasrinivasan@outlook.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 14:49:59 +0000 (UTC)

--===============9163831857622064988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject writable map iterators on read-only and frozen maps

TL;DR:
- Rejecting all frozen maps for writable iterators may change uapi behaviour;
  BPF_F_RDONLY_PROG alone seems to close the hole
- Frozen check is racy: map_freeze() after attach still lets the iterator
  write
- Fixes tags look wrong

>     bpf: Reject writable map iterators on read-only and frozen maps
>
>     The bpf_map_elem and bpf_sk_storage_map iterators pass the live element
>     value (ctx->value) to the iterator program as a writable buffer
>     (PTR_TO_BUF | PTR_MAYBE_NULL) for all non-percpu map types. Since
>     commit 8d0358f6e8b3 ("bpf: Keep iterator programs off special map
>     fields"), bpf_iter_map_check_value_write() checks on Linux 7.4.0-rc1
>     whether a writable iterator program (prog->aux->max_rdwr_write > 0)
>     overlaps special BTF fields in map->record, but does not check whether
>     the target map has BPF_F_RDONLY_PROG set or has been frozen via
>     BPF_MAP_FREEZE (map->frozen).
>
>     As a result, a writable bpf_map_elem iterator can be attached to a
>     frozen BPF_F_RDONLY_PROG map (such as a .rodata BPF_MAP_TYPE_ARRAY or
>     BPF_MAP_TYPE_HASH) and triggered via read(iter_fd) to mutate its elements
>     in place after dependent BPF programs have already been verified.
>
>     Why this breaks verifier soundness:
>     1. Constant folding (check_map_load / const_fold.c): When
>        bpf_map_is_rdonly(map) is true ((map->map_flags & BPF_F_RDONLY_PROG)
>        && READ_ONCE(map->frozen) && !bpf_map_write_active(map)), the verifier
>        folds direct loads from single-entry array maps into compile-time
>        scalar constants (__mark_reg_known). Overwriting the frozen element
>        via a bpf_map_elem iterator causes the runtime value to diverge from
>        the verifier's folded constant, bypassing bounds checks on pointer
>        arithmetic (PTR_TO_MAP_VALUE += scalar) in already-loaded programs
>        and enabling out-of-bounds map reads and writes.
>     2. Indirect subprogram calls (find_subprog / callx): Function pointer
>        tables in frozen BPF_F_RDONLY_PROG maps are resolved to live kernel
>        JIT addresses at load time. Mutating the frozen slot via a
>        bpf_map_elem iterator redirects indirect callx targets at runtime
>        (or crashes the kernel at an arbitrary RIP such as RIP = 0x0).
>
>     Threat model evaluation (Documentation/process/threat-model.rst):
>     Triggering this issue requires attaching a tracing iterator program
>     (BPF_PROG_TYPE_TRACING / BPF_TRACE_ITER), which requires CAP_BPF and
>     CAP_PERFMON (or CAP_SYS_ADMIN, or a delegated BPF token). In deployments
>     where CAP_BPF + CAP_PERFMON or a BPF token is granted without full root /
>     CAP_SYS_ADMIN, the BPF verifier is the boundary preventing out-of-bounds
>     kernel memory access and arbitrary kernel RIP control.
>
>     In bpf_iter_map_check_value_write(), return 0 early when
>     !prog->aux->max_rdwr_write so read-only iterators (such as bpftool map
>     dump) remain permitted, and reject maps with
>     (map->map_flags & BPF_F_RDONLY_PROG) or READ_ONCE(map->frozen) with
>     -EACCES before checking map->record.
>
>     Fixes: 8d0358f6e8b3 ("bpf: Keep iterator programs off special map fields")
>     Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
>     Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
>     Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
>     Signed-off-by: Adethya Srinivasan <adethyasrinivasan@outlook.com>
>

The Fixes: tag 8d0358f6e8b3 ("bpf: Keep iterator programs off special map
fields") only added bpf_iter_map_check_value_write() as a check for special
BTF fields.  It did not introduce the writable value buffer.

That buffer (PTR_TO_RDWR_BUF_OR_NULL for the value ctx arg) came from
a5cbe05a6673 ("bpf: Implement bpf iterator for map elements") for array and
hash maps, and from 5ce6e77c7edf for sk storage.  The d3cc2ab546ad and
d6c4503cc296 tags are also indirect, since those commits did not expose a
writable value to programs.

Should the tags be:

  Fixes: a5cbe05a6673 ("bpf: Implement bpf iterator for map elements")
  Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")

with the 8d0358f6e8b3, d3cc2ab546ad and d6c4503cc296 tags dropped?

> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c

[ ... ]

> @@ -109,7 +109,13 @@ int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
>  	const struct btf_field *field;
>  	u32 i;
>  
> -	if (IS_ERR_OR_NULL(rec) || !prog->aux->max_rdwr_write)
> +	if (!prog->aux->max_rdwr_write)
> +		return 0;
> +
> +	if ((map->map_flags & BPF_F_RDONLY_PROG) || READ_ONCE(map->frozen))
> +		return -EACCES;
> +
> +	if (IS_ERR_OR_NULL(rec))
>  		return 0;
>  
>  	for (i = 0; i < rec->cnt; i++) {

Is rejecting every frozen map intended here?  The READ_ONCE(map->frozen) test
changes uapi behaviour, since frozen alone has never made a map read-only for
BPF programs.  include/uapi/linux/bpf.h says for BPF_MAP_FREEZE:

    Write operations from eBPF programs are still possible for a frozen map.

check_map_access_type() takes write permission from bpf_map_flags_to_cap(),
which only looks at BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG.  Both soundness
problems described in the commit message go through bpf_map_is_rdonly():

    return (map->map_flags & BPF_F_RDONLY_PROG) &&
           READ_ONCE(map->frozen) &&
           !bpf_map_write_active(map);

That requires BPF_F_RDONLY_PROG, so the map_flags test alone closes the hole.

For example, an array or hash map created without BPF_F_RDONLY_PROG and then
frozen accepted a bpf_map_elem iterator that stores into ctx->value before this
patch.  Now BPF_LINK_CREATE fails with -EACCES via:

    bpf_iter_attach_map() -> bpf_iter_map_check_prog() ->
        bpf_iter_map_check_value_write()

while any other tracing or XDP program can still write the same frozen map.

If the intent is to keep frozen maps from being written through iterators, the
check is only sampled at attach and link update, without map->freeze_mutex, and
attach does not raise map->writecnt.  So map_freeze() run after the link is
created still succeeds:

    mutex_lock(&map->freeze_mutex);
    if (bpf_map_write_active(map)) {
        err = -EBUSY;
    ...
    WRITE_ONCE(map->frozen, true);

and the existing link keeps writing the frozen map on every read(iter_fd).
bpf_map_mmap() handles this by taking freeze_mutex and calling
bpf_map_write_active_inc() for writable mappings.

For the sk_storage iterator, bpf_local_storage_map_alloc_check() only allows
BPF_F_NO_PREALLOC | BPF_F_CLONE, so such a map never has BPF_F_RDONLY_PROG and
bpf_map_is_rdonly() is never true for it.  The only change for that iterator is
the frozen-only rejection.

Should the check be limited to BPF_F_RDONLY_PROG, matching
check_map_access_type() and bpf_map_is_rdonly()?  If rejecting frozen maps is
intended, would it need the same freeze_mutex / writecnt handshake that
bpf_map_mmap() uses, along with a rationale in the changelog?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42382469691
--===============9163831857622064988==--
