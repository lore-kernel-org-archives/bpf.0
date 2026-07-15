Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444231717D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101704; cv=none; b=fV4aSKnTIKbf8tvGGfsBS8h1D6R3emAa9qXxRdmuotAxx8fq2unBTYGwRfEjjeIg0uPQPgFwCMncDVdiz14+ZZYc4iaokEoK8xubinj9Ov9wHiGEFcm2L/Qkt6rP5FzYM06SSp2IfnH0zTJVjHV4V/aSZzodSZXxxQqXADpt1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101704; c=relaxed/simple;
	bh=R+5NUp9Szz8rsHGIF+fk7uJFcDv4Pm7B342YPWWN1cs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SNkNBQTsbeb9IHFeJvQwI88NhsJNd8zoXNxr7/VfP7Ks/0Xx3OS2k04vLwbZY9RbGaa/tS94u3grc/XXlIi/DOhpFKDl9XlYW9wndOOQjrWTaQuNj7YZtHQVxztr2E/vf9dHCu3P24Q9F54RJyc7mfHtc6RwTE6/jvCOAK43tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOh7yYu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOh7yYu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3771F000E9;
	Wed, 15 Jul 2026 07:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784101703;
	bh=rg64IYQjSZ9X0WOzkU0/eeMrKG39rm2hjmMztTmJTX8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eOh7yYu/YK44oQq47CvmqB6FvSx/5CSws/nETPv1Nxw9UEIV8snwFMpcks3wWs+s7
	 9qT9d09C/2qnJpw92mTmb3UiiTBqPFjG5smCJjGGxjld3g7Hpido55uJGMh5n8rMF3
	 43i9BIb3swxvzRPINw2dsjo2+mo/F2Ro77u5ss4ZKzbt8RX6JErwUC/gIZ5JY+ONw2
	 Q1d0bZ32hNPNp6tyzM23AbImWExspUO0D0nVa5aci6TeXZEUvLdPVq1Vw9bpW/IRi1
	 qsuwfg9RGNlG4mAQx7vy2pUe/HBaT2mrje13iYB8rLhUWFNWFx6THpz1118bJ7Zq+b
	 TlhgzuPHIhX3w==
Content-Type: multipart/mixed; boundary="===============4563141561048231257=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d24779bbd606775a1edd2cab18a8e82034425b4a38856813b3ac6a043a8eeaa@mail.kernel.org>
In-Reply-To: <20260715064047.1793790-3-ameryhung@gmail.com>
References: <20260715064047.1793790-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 07:48:23 +0000 (UTC)

--===============4563141561048231257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 898896816b1b94bb310b2829155d616641a4e0b3
> Author: Amery Hung <ameryhung@gmail.com>
>
>     bpf: Factor out raw_mode-related fields in bpf_call_arg_meta
>
>     To prepare for unifying the helper and kfunc call_arg_meta, group the
>     scattered MEM_UNINIT ("raw") memory argument fields (raw_mode, regno and
>     access_size) into a new struct arg_raw_mem_desc. The intention is to
>     make it clear about when these are set and used instead of fields with
>     overly generic names.
>
>     Identify the raw argument once, up front, in check_raw_mode_ok() (like
>     check_proto_release_reg() does for release_regno), recording its regno.
>     check_stack_range_initialized() now recognizes the raw buffer by matching
>     that regno, so the separate raw_mode flag is no longer needed, and the
>     per-argument "meta->raw_mode = arg_type & MEM_UNINIT" assignments in
>     check_func_arg() go away with it.
>
>     A raw memory argument can be tagged either ARG_PTR_TO_MEM | MEM_UNINIT or
>     ARG_PTR_TO_MAP_VALUE | MEM_UNINIT (the output buffer of bpf_map_pop_elem()
>     and bpf_map_peek_elem()). Either may be passed as a PTR_TO_STACK, which
>     reaches check_stack_range_initialized() through check_helper_mem_access(),
>     so both must be treated as raw. Extend arg_type_is_raw_mem() to match the
>     map value case as well; otherwise check_raw_mode_ok() would not record the
>     regno for it and an uninitialized stack buffer passed to those helpers
>     would be wrongly rejected for programs without CAP_PERFMON.
>
>     No functional change intended. This patch does not enable raw_mode
>     memory access for kfunc (i.e., uninit stack will not be allowed to be
>     passed to kfunc for unprivileged programs). Existing kfuncs with arguments
>     tagged with __uninit are either priviledged or dynptr kfuncs, which take
>     another path to make sure the access is checked by check_mem_access().
>
>     Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>     Signed-off-by: Amery Hung <ameryhung@gmail.com>

This looks like a bug fix for MEM_UNINIT handling with map value
arguments. The commit message explains that without the arg_type_is_raw_mem()
extension to match ARG_PTR_TO_MAP_VALUE | MEM_UNINIT, valid programs would be
wrongly rejected. Should this include:

  Fixes: 18752d73c1898 ("bpf: Improve check_raw_mode_ok test for MEM_UNINIT-tagged types")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29395575390
--===============4563141561048231257==--
