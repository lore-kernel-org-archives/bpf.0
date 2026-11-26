Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657484;
	b=d2bUkZBWyA2iQ0HBmjaK5LljUq5o8faOGOrHd6T6N4UATNTYeclErTn6VWbmcHW3ppcb
	 OMqElMiO9AjM8Xk1ZtRM0pEBahNENMC+e+j5aFxPi+dlKmg7hfCWV+MQE075S/AMe0Oem
	 Bzu1u9tavwPTTcsNAlNL+ShwxGQ1V/YwEUngY/Tw4QJGPA3HA8IEBk7k9BZpbkwIP/2tv
	 9MzYWgt00SYRRYboryPDOrX5n1EglRbuVsZLULlAq2+nfmgJCaoeZtl7ZDxqt/q10572L
	 oLJgZ4rWS1FQdF8R2k2l31WP1Pzop9yv9cT0CF2Ni/7I1ntvSCOi5u4s2pFkQTpwvYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657484;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=RXTTwRuZfj4iS0OA9NEWLOPlyuSgnregjQXzrq7V2OQ=;
	b=M4W5YGgcj2ViMuLkTDVTSTYEDvE0OnjEBQbpQ/v5enSbyRAZsI0KZbHNe+lY80E9XjbG
	 UauIoRXZkvGBaRTeQ7kuF8NTJicCVfhpfl514LNyrarwHVMgJgNIGmPAfIJMUH9EPl9Er
	 9NUJ9xNJg2b05hWiBLrNpsmMBiszGB3WAJejuwNSUZz0SE1KXMwCk0mKgw0qLSxqHXpmS
	 PNCNeYONQfGPVehM8w29r4zHPHpc1Uycwc1VuH84+lj6Mn6dAVTDWdBLvUNZf4MD85ylD
	 jzSsFdeVcS9+U/JKO8mDfZXdzg++azHBM71KuvzzKNwQIyTINuaJ+ANnyMRv7CjEEeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RB/hzgI4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E59606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RB/hzgI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF04C1F000D3;
	Thu, 26 Nov 2026 01:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657484;
	bh=RXTTwRuZfj4iS0OA9NEWLOPlyuSgnregjQXzrq7V2OQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RB/hzgI4+oGhu7E0KI6aCiVuv/I8Nj4kYcdwOg575v7EsUgmfiOHUBNsNiy7zkvZs
	 NTQzM9v0BJln0byiO+Y1e7sPWKjN0P5mg8UJS4pjiyGFUS3KJh25sajfa/izGWU1Kw
	 OQozddQlZyIKJDb3I1cMn5AU54ZjQpwO3LO0mC7GBq7I6Q1WlCZ8YF0BGZNcXTR1qY
	 GecNb0JcO1T/LXIIWRq06SDdd8wtTatIPdU76O6Hc8hm9NdaAFYJPNx0ytzdWMrLLo
	 o/tYOv8DZHPXlvRWRPGbFYL12OGTUJLojhFFFRJFBgQzrHqjvA1Y8TUhymf+7cbP/H
	 BNae50xziWkHA==
Content-Type: multipart/mixed; boundary="===============8688468922052142856=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <41db8655d68e95b55ae7c237ddbabf808910aff7a467827a85edd8e31aa039d5@mail.kernel.org>
In-Reply-To: <b887fe56f02f8578e41cf0009da7638fb6f8ec0c.1795627805.git.m202672221@hust.edu.cn>
References: <b887fe56f02f8578e41cf0009da7638fb6f8ec0c.1795627805.git.m202672221@hust.edu.cn>
Subject: Re: [PATCH] bpf: Require a bpf_spin_lock for bpf_list_head and rb_root
From: bot+bpf-ci@kernel.org
To: m202672221@hust.edu.cn,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: andrii@kernel.org,eddyz87@gmail.com,emxor@gmail.com,m202672221@hust.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 01:44:42 +0000 (UTC)

--===============8688468922052142856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Require a bpf_spin_lock for bpf_list_head and rb_root

TL;DR: Requiring bpf_spin_lock for list/rb roots may break existing programs
that use bpf_res_spin_lock, which now fail BTF or program load; fixing the
free path instead is suggested.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -4302,8 +4302,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>
>  	/* bpf_{list_head, rb_node} require bpf_spin_lock */
>  	if ((btf_record_has_field(rec, BPF_LIST_HEAD) ||
> -	     btf_record_has_field(rec, BPF_RB_ROOT)) &&
> -		 (rec->spin_lock_off < 0 && rec->res_spin_lock_off < 0)) {
> +	     btf_record_has_field(rec, BPF_RB_ROOT)) && rec->spin_lock_off < 0) {
>  		ret = -EINVAL;
>  		goto end;

Does this reject layouts that load and verify today?  The commit being
fixed says:

  The bpf_res_spin_lock can also be used to protect objects that require
  lock protection for their kfuncs, like BPF rbtree and linked list.

It also changed check_reg_allocation_locked() so the graph-root lock check
accepts res locks:

  -	s = find_lock_state(env->cur_state, REF_TYPE_LOCK, id, ptr);
  +	s = find_lock_state(env->cur_state, REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
  +			    id, ptr);

That verifier code is still present (now REF_TYPE_LOCK_MASK) and this
patch does not touch it.

With this patch, a struct with a direct bpf_rb_root or bpf_list_head
member plus a bpf_res_spin_lock makes btf_parse_fields() return -EINVAL,
and btf_parse_struct_metas() treats that as fatal, so BPF_BTF_LOAD fails.

For a global-data layout with both in the same .data.X section,
map_check_btf() leaves map->record as ERR_PTR(-EINVAL), and verification
then fails in process_spin_lock() ("has no valid bpf_res_spin_lock") or in
__process_kf_arg_ptr_to_graph_root() ("not found at offset").

Before this patch both layouts loaded and passed verification.  The only
defect was at teardown, where bpf_obj_free_fields() hit
WARN_ON_ONCE(rec->spin_lock_off < 0) and skipped the root.

The commit message says "Nothing in the tree relies on the relaxed form
yet".  That covers in-tree users only.  Out-of-tree programs, for example
sched_ext schedulers written for v6.15 and later, could use the
combination, although I have not confirmed any do.

Would teaching the free path to use rec->res_spin_lock_off be an
alternative?  That would address the release-time WARN without rejecting
programs that load today.

If the restriction is kept, the verifier's res-lock acceptance for graph
roots becomes unreachable and could be cleaned up in the same series.  Should the
commit message also say that a feature documented in 0de2046137f9 is being
withdrawn?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45736338787
--===============8688468922052142856==--
