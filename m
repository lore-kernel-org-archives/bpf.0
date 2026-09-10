Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EF49E158
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079596; cv=none; b=nshI9cds87q614MlsVe415uhFeVLNvWfQhBFkcaqR28EZU8vK6NXVVyxZxrOK/6v08pOZECNZf8IF+BaZKOhXGcoEeUXoiJcE5ufj9G5iiL27yGYdXbl9s47tdPTC/0UqktgIEatgswp9AmVZD9U1c3qFre2ds2sc/yFY6+AnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079596; c=relaxed/simple;
	bh=ohbNt0keE/l5AXReEzSB7OnNXINcm0e5SIC6pA8oDMk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SO2NtjKvGdsZ1vy+aEW92V9WN0Z5WotH5NkFGB1gpxHh/9Ad7fqHrzTGUheSzV+Guzp32IbM7XKm0x6Qn4FIUbD0V680ClDeW+0f+zL8xmjgPMa79VzzNfdHASFUSKxgx99sSCzkFq2HFRJx+QkiNlG02dgTVtWatb7qU4eaQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coe456ql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coe456ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019A91F00898;
	Thu, 10 Sep 2026 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079595;
	bh=lbEq+0Ks6niYaXm2PvrxygyV7lg5j03hZBbgmdPVUyg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Coe456qleOWXZZXjJfRkf8VStW/Es4AnPHqOc6cc7oGgvQcWLNvJXDZxTvi9Mg5GK
	 Ut79vCI+QfN8YQsvmPMYOXV2dsnBF6mxE89mowkWNHFPxMKc7o/F0CAYSCHt3LBN/T
	 o3K3zwBYdi2fVIMvxduz+kNb5ziV9DHHOuv2tet1hA23RsLKLvjZHFJDf49S+2+/9e
	 s0Z/EDIPEDQm106FpC8MKQJf8YfNQQk3K6J3Lx7m9RDj5iWri1wxirEen2LnwuzKlK
	 EbrpgLOcz75kMMubC9bEFcjy2/sN7CCP8i3U0PhR/Uufuqa7uJfmJeDOAomT/d/Lgq
	 mcxoZKjbySUDw==
Content-Type: multipart/mixed; boundary="===============2530980791761083885=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4bacecc6c3d12f14b4da1e2cb76ec752f78f3e0a4adb4aae366ce535c8cd6554@mail.kernel.org>
In-Reply-To: <20260910213510.49358-2-daniel@iogearbox.net>
References: <20260910213510.49358-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 2/4] bpf: Require CAP_PERFMON for kfuncs reading memory
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 22:33:14 +0000 (UTC)

--===============2530980791761083885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 1ccfa5df2ce00bdc57d58ab0b5aa22cdf8181454
> Author: Daniel Borkmann <daniel@iogearbox.net>
>
>     bpf: Require CAP_PERFMON for kfuncs reading memory
>
>     Mark fault-safe probe reading kfuncs as KF_PERFMON, similarly as we do for
>     the old-style BPF helper equivalents. bpf_rdonly_cast() is included in this
>     list as well as it returns PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED for an
>     unchecked object and is using fault-safe BPF_PROBE_MEM.
>
>     Note that only the void form of bpf_rdonly_cast() produced a register that
>     was readable without CAP_PERFMON. For a struct type id the kfunc returns
>     PTR_TO_BTF_ID | PTR_UNTRUSTED, whose dereference has always been gated in
>     check_ptr_to_btf_access(). The flag is not conditional on the type id, so
>     for the latter it only moves the rejection from the dereference to the call
>     itself, which is the better place to report it anyway.
>
>     The bpf_stream_vprintk() and bpf_stream_print_stack() kfuncs are marked
>     as well. The former ends up in the same bpf_bprintf_prepare() as the
>     bpf_snprintf() helper, where %pks, %pus and %pI4 read through a program-
>     supplied address and %pB resolves one into a symbol. The latter walks the
>     stack and prints each instruction pointer via %pS.
>
>     Lastly, bpf_get_kmem_cache() takes a raw scalar address that the verifier
>     does not constrain and dereferences the page/slab metadata for it. Field
>     reads on the returned pointer are still blocked (PTR_TO_BTF_ID | PTR_UNTRUSTED
>     -> check_ptr_to_btf_access() results in -EPERM without the CAP), but the
>     NULL/non-NULL result is observable.

This isn't a bug, but would it be worth a sentence on the bpf_str* and
bpf_iter_bits_new group too? The changelog gives detailed rationale for
bpf_rdonly_cast(), bpf_stream_vprintk(), bpf_stream_print_stack() and
bpf_get_kmem_cache(), but the 15 bpf_str* kfuncs, bpf_iter_bits_new(),
bpf_copy_from_user_str() and bpf_copy_from_user_task_str() are never named.

The bpf_str* family seems like it might be the widest exposure being closed
here, since __bpf_strncasecmp() reads an unchecked address with
__get_kernel_nofault() and returns a comparison result, and bpf_strchr() and
bpf_strnlen() return byte indices, forming a byte-granularity kernel-memory
read oracle that was reachable from a plain CAP_BPF program.

Also, would it help to note that only CAP_BPF-only non-tracing program types
actually change behaviour? is_perfmon_prog_type() already requires CAP_PERFMON
at load for KPROBE, TRACEPOINT, PERF_EVENT, RAW_TRACEPOINT, TRACING, LSM,
STRUCT_OPS and EXT, so tracing/LSM/sched_ext users are unaffected; the
newly-restricted set is networking, cgroup, socket-filter and syscall
programs (for example bpf_core_cast() calls into bpf_rdonly_cast() via
tools/lib/bpf/bpf_core_read.h, and the bpf_str* helpers are used on the
program's own rodata/map values).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34534885787
--===============2530980791761083885==--
