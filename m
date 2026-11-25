Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579694;
	b=PLO+R7n4cZDSc7DiFWvmFcbeor/RtT3LPBw7Cg66fRBNSibKiSpiWlJVPJX3LKCuH1S3
	 W+5aMRTBh541f3vw/olYiMSr6ozHT3dyGTugASpVdbFlfh70yb1u2hynrB3hsnfQfX+zg
	 ciiykTfqmtUP888xPtWdOC0tMqYPvDikpzalP4lxEzF9/TzsDhnu21UI14WBG5SDuIm9E
	 jUrYNJ0bt28FEKuVZTtkzlDY8e/0F7Aoa7arfdnQcNKCN/XDiObBxORpoo05TwxrJoePn
	 kOZ0hal6xFr6ZvbDXCkcGtYEbG2VSIFlmSvTLZbirOxib2R8Ds6J8nV40TnDSC76Y7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579694;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wyOGzBK3mhYNrUWoI6k0Xzn1cppLZ500pAgeUUvgV3E=;
	b=bf/GJXidb+8WVJZuV69LrUqbfooVHFJra96aKbpm1LRSsa3DEeorsqgFTJqF45g4x4bG
	 eOdO/Oc4/2ME4gngkOdQBwthBAuX2YrSRjb1I61K2JY51x/c0VxlAXJtydN7FOLcRm5SX
	 by3P2Ty7PPsCWULyoIWqC7sekfajRVqY9hyxaFa6R/WrSsQ760XbUjz9uRWFfRzFdvfNZ
	 YU80b2yvZ5eG0oaskCOEZSE2Txh85JFzduOstf1q4fmqWjMq03RDsfMkLbKQSELont4Zk
	 JnxPrmdHvv2GxyBT5qOkdBFZOpcBViU4UCCJ5ht0XXDsTRYXG0Q/Z6tLIjb+g2xhnBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXuFpq3h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DA606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXuFpq3h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300EE1F000CF;
	Wed, 25 Nov 2026 04:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579693;
	bh=wyOGzBK3mhYNrUWoI6k0Xzn1cppLZ500pAgeUUvgV3E=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jXuFpq3h4wnQZUGtcQ8t/0pwYm/EUWVwfmGeq9c1mkB4EK5W2DhKFbbCKIjUdP7KH
	 EqCuiT9y3iXL2EvBRP5EWgJR6lgJoXyNXD/ax2V9KR5wDCiZgc1cQs3KVjDAoo0Sh4
	 1BRRjDMn4Y6zSOZHLaUMrKLNNr0ZkjIr8g+GqcGk5Ei6NtmtI2z9BwERenZe5AiGXh
	 6iMtRr3icJuHaXffBtJ5bWNRwso0Cu39l82w5x4icvSeHAiV9yFy1IMTJDJMWpatml
	 gmbBd0EYovhXHMzlC94LutW/Mm1vaDVMRYhtf/TqODTnGAWdvGuBli38CgamyMpGy5
	 TpPsx2QHuK4/A==
Content-Type: multipart/mixed; boundary="===============7540535719443747160=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <24fcf940572c2fc5199103ec6c93e7a4b3789d2122217f3d7a797f52e5d3fd8a@mail.kernel.org>
In-Reply-To: <20261125032938.670542-26-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-26-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 25/47] bpf: Give syscall programs without CAP_PERFMON the base helpers only
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:08:12 +0000 (UTC)

--===============7540535719443747160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Give syscall programs without CAP_PERFMON the base helpers only

TL;DR: Possible privilege escalation: a syscall program with CAP_PERFMON may
call bpf_sys_bpf() from a bpf_wq callback, which runs in a kworker with full
capabilities. The fix doesn't seem to cover this.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6747,10 +6747,12 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
>  static const struct bpf_func_proto *
>  syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> +	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
> +		return bpf_base_func_proto(func_id, prog);
> +
>  	switch (func_id) {
>  	case BPF_FUNC_sys_bpf:
> -		return !bpf_token_capable(prog->aux->token, CAP_PERFMON)
> -		       ? NULL : &bpf_sys_bpf_proto;
> +		return &bpf_sys_bpf_proto;

This isn't a bug introduced here, but the fix doesn't seem to cover the
CAP_PERFMON case of the problem the commit message describes.

The message says the loader helpers use current, which is a different task
in a callback, and that a bpf_wq callback runs in a kworker with all
capabilities.  It then concludes "Loader programs are not affected,
bpf_sys_bpf() needs CAP_PERFMON already."

The CAP_PERFMON check runs once, at load time, against the loading task.
bpf_sys_bpf() then calls __sys_bpf(), whose permission checks run against
current when the helper executes:

  BPF_CALL_3(bpf_sys_bpf, int, cmd, union bpf_attr *, attr, u32, attr_size)
  {
  	...
  	return __sys_bpf(cmd, KERNEL_BPFPTR(attr), attr_size,
  			 KERNEL_BPFPTR(NULL), 0);
  }

In a bpf_wq callback current is a kworker with init_cred.  The bpf_wq
kfuncs (bpf_wq_init/bpf_wq_set_callback/bpf_wq_start) are in
common_btf_ids, registered for BPF_PROG_TYPE_UNSPEC, and have no
KF_PERFMON flag.  is_async_cb_sleepable() returns true for bpf_wq
callbacks, so check_helper_call() accepts the might_sleep
bpf_sys_bpf_proto there.  Only timer callbacks reject it (see
progs/verifier_async_cb_context.c).

Can a task with CAP_BPF and CAP_PERFMON, but without CAP_SYS_ADMIN or
CAP_NET_ADMIN, load a syscall program whose bpf_wq callback calls
bpf_sys_bpf()?  The command would then run with full capabilities.  For
example, bpf_map_get_fd_by_id() checks capable(CAP_SYS_ADMIN), so
BPF_MAP_GET_FD_BY_ID followed by BPF_MAP_UPDATE_ELEM could modify any BPF
map in the system, and BPF_PROG_LOAD would pass the CAP_NET_ADMIN and
CAP_SYS_ADMIN checks.  That is more than CAP_PERFMON grants.

I found no later commit in the series that changes bpf_sys_bpf, the
availability of the bpf_wq kfuncs, or the async callback helper rules.

Should the loader-only helpers (at least bpf_sys_bpf, and also
bpf_sys_close, which acts on current->files) be rejected in async
callbacks?  Alternatively, should they be refused at run time when current
is not the task that runs the program through BPF_PROG_TEST_RUN, as the
comment in bpf_sys_close() already assumes
(sys_bpf->prog_test_run->bpf_prog->bpf_sys_close)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============7540535719443747160==--
