Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212747CA73;
	Wed,  5 Aug 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948244; cv=none; b=Mzx62wYHqRPNJclaQ2H214FVpE+BkNn9o9zT21kyp7nGIeBk7Ih0eIVN/rhGkMIQ5qH04hzBfg6MwcPkCH1GrZ1jznN2HYOWRKaVJr6fSs9EJ8Ibu6yLMwXuiWxtS7l9ITTSZ+NmqRqU1Sw/riDJpTL2hTPZzmTML3DBKaccboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948244; c=relaxed/simple;
	bh=GmWJEZ+0gVlUJ9SRG82lJe9z5tJ4AAZS010Du07niOk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=u+ChfrsIJ0RdHAqRw5MPudkV3hbI6EkC41nKRt6FenkoZihkmDxJCkqX+OlihEBBqAVFxiBicUjCsh0tuwoXP6ZiuOUHnFlJRo1ZTVHwka8+9oQLQddtTUXS+y45rv5mhyKTL7JZIaDE9MlbTEZUqbs1MDyqx66hWFbFqvD4OBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyrDt/SF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyrDt/SF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E3E1F000E9;
	Wed,  5 Aug 2026 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948243;
	bh=6+wCWb4EcCVR1wE3mlZNxaRuPHhY9LNWoJPfC30Vb7c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jyrDt/SFJjvaZ6njgDT8uhxLWSFAAVP3dyc1ajQeFphiwrmh7OlSyNPrTZcUh5rYU
	 /Jjf06tecSwHLcVg/lnCRHEl1c1ewhhVqmG/IjP1qobW0h6VZ+4ySrTkgQokJ99D0d
	 od45Vgo2gD8IOlp1Soj8L7VOat7VaX/bM8rfoOxVCJbleg9E5qTQd7qSYnaQBAH3jZ
	 WeEQOfjX8RPuTVRpOFR69oTFNAGVlY3DLiGeZWEipGyLPx0u2O/nwDJ41FGJZ3h+nS
	 FJH8JLEBmx/NQG8WXy3T0cscA5BABW/dreJ33uq8tT3oWtmPKHQdTF0hke4NtyKajo
	 nnTk3Jew0dSVQ==
Content-Type: multipart/mixed; boundary="===============7323960934204801019=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5a4179a9944f6e1e30be7a68a74d9c9f8c9c0eb986419fa2803ab99ce1362378@mail.kernel.org>
In-Reply-To: <20260805150810.34907-2-leon.hwang@linux.dev>
References: <20260805150810.34907-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix sleepable check for tracing/lsm prog
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,rhkrqnwk98@gmail.com,varunrmallya@gmail.com,leon.hwang@linux.dev,vmalik@redhat.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 16:44:01 +0000 (UTC)

--===============7323960934204801019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Similar issue could be applied to lsm prog, when the
> prog->aux->attach_btf_id is in the LSM allowing list but the attach_btf is
> a malicious bpf prog's btf.

Can this LSM scenario actually occur? Looking at the code,
prog->aux->attach_btf appears to be validated to be kernel BTF at program
load time in bpf_prog_load():

kernel/bpf/syscall.c:2991
	attach_btf = btf_get_by_fd(attr->attach_btf_obj_fd);
	...
	if (!btf_is_kernel(attach_btf)) {
		/* attaching through specifying bpf_prog's BTF
		 * objects directly might be supported eventually
		 */
		btf_put(attach_btf);
		err = -ENOTSUPP;

The only other assignment is the bpf_get_btf_vmlinux() fallback at
syscall.c:3007, so attach_btf is never a bpf prog's BTF.

The other path for non-kernel BTF reaching btf_id_allow_sleepable() is
the tgt_prog branch in bpf_check_attach_target():

kernel/bpf/verifier.c:19149
	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;

But can an LSM program have a tgt_prog? bpf_prog_load_check_attach()
appears to reject it at load:

kernel/bpf/syscall.c:2752
	if (dst_prog && prog_type != BPF_PROG_TYPE_TRACING &&
	    prog_type != BPF_PROG_TYPE_EXT)
		return -EINVAL;

And bpf_tracing_prog_attach() only accepts tgt_prog_fd for BPF_PROG_TYPE_EXT
(syscall.c:3673). So the BPF_PROG_TYPE_LSM arm of btf_id_allow_sleepable()
appears to be only ever reached with kernel BTF, making the 'malicious bpf
prog's btf' case unreachable.

> Fix it by disallowing sleepable tracing/lsm prog always when its target
> btf is not kernel's btf.
>
> Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
> Fixes: 1e6c62a88215 ("bpf: Introduce sleepable BPF programs")

Does the second Fixes: tag point at the commit that introduced the bug?
Looking at 1e6c62a88215 and up through 16d9c5660692, the tracing arm read:

	if (!check_non_sleepable_error_inject(btf_id) &&
	    within_error_injection_list(addr))

On the tgt_prog path, addr is JIT text (tgt_prog->bpf_func /
aux->func[subprog]->bpf_func, verifier.c:19409-19412), which is never on
the error-injection list. With CONFIG_FUNCTION_ERROR_INJECTION=n,
within_error_injection_list() is a stub returning false
(include/linux/error-injection.h:16).

The fmodret fallback also does not help, because
btf_kfunc_is_modify_return() checks __btf_kfunc_is_allowed(), which returns
false when btf->kfunc_set_tab is NULL (kernel/bpf/btf.c:9021), and
kfunc_set_tab is only populated for vmlinux/module BTF
(__register_btf_kfunc_id_set() calls btf_get_module_btf(), btf.c:9160).

So a sleepable tracing prog attaching to another BPF program was already
rejected before 16d9c5660692. Only the has_arch_syscall_prefix(tname) path
added by 16d9c5660692 opened the hole. Keeping the 1e6c62a88215 tag could
direct AUTOSEL and stable at trees back to 5.10 that do not contain the
bug.

Would Fixes: 16d9c5660692 alone be more accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31020655174
--===============7323960934204801019==--
