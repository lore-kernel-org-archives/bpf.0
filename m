Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21B341AC7;
	Mon,  1 Jun 2026 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299744; cv=none; b=g/i2SiJeWAGA/bzTXUUTmlG0swFoaRqnl2xwSK0rbIZZ86zsHHEo0m4wHieQo0laJVbAqT/LuCVG4Li6xapt5mTVqfqjFfeDPcRVRjV4OkfBWjpRdbz9cQFslmzFe4HBPSiVlCAgWFKawd0SrT93NNVm0WiSNynh/DmM6YPCGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299744; c=relaxed/simple;
	bh=YfCh3F6oCC3O3jydmY42RC+v+CGx/2+nLHOzvuaEUkE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DW8Xl3+nD7IQj1J8rQo+xsBMlPFc4Pvt3G8SmqYk9CPRQp/hFg8F0C+esGitCiC+yxbr+T9NyiDNiZMcMwgGz5dAQZU8U1Rh/FThFc4etG2AedpE/LI7xJlKy5ZHjLFSG8FMowCfJwXIcaEEgWCSbxOF3ppmrtaXqnyK9c74zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo/O7j4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo/O7j4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A81F00893;
	Mon,  1 Jun 2026 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780299742;
	bh=clQGC2DogWMVQiChD3Y4Df9bQ5h+XUyENUObI7dDs30=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Vo/O7j4UbvIIRiS0Lon22/YatXzuBcuJYeXXNAm87xe11prjiLQI8nENXl3BKYcGS
	 NaJEUl1kcRPuLog7TIJNZtA4Nf9QSTuFWNhDLYcpYAWEDw/RDFaTPHAnDY7p7upHqk
	 f0dPnteaYr1olBEEjB2BfSG9riWyVDnZTQezTzjgva4V0Y1OEvXTq5dM42uM3FUXd4
	 ddOFZAD9ay9IzWJbJsdUoEzivPoZ8Cfi8OpfjHoHEaioDWSoQenqNogR9joFVPy9O7
	 pb7qLqp9If7Y6V/q7eEzCRX69ffhVPVXvIi2/tj7y7kFcm6lizNEzSkRCGyYuNs0Jn
	 TLru2h7z33drg==
Content-Type: multipart/mixed; boundary="===============3442698258420643995=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a6d10d44ee132d70b2b2633790663289af944fd8d3889440dfc55fea04c5a2e5@mail.kernel.org>
In-Reply-To: <20260601064611.807637-2-chenyuan_fl@163.com>
References: <20260601064611.807637-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,chenyuan_fl@163.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  1 Jun 2026 07:42:22 +0000 (UTC)

--===============3442698258420643995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix kfunc implicit arg inject type detection to prevent invalid pointer deref
>
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
>
> Root Cause
> ----------
>
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base
> BTF deduplication for modules to fail.  As a result, the module retained
> its own copy of struct bpf_prog_aux with a different BTF ID than
> vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue,
> the kernel must be robust against such inconsistencies: a BTF mismatch
> should result in a clean rejection, not a kernel crash or information
> disclosure.
>
> When the distilled base dedup fails and btf_types_are_same() cannot
> match the module's bpf_prog_aux type against vmlinux's,
> is_kfunc_arg_prog_aux() returned false and the code fell through
> silently without setting arg_prog.  The kfunc then received whatever
> value was in the argument register and dereferenced it as a
> bpf_prog_aux pointer, leading to:
>
>   BUG: kernel invalid pointer dereference, address: 00000000000009e2
>   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>   RDI: 0x000000000000046d (stale register value)
>
> In the observed crash the stale value was the process PID, causing a
> dereference within the unmapped NULL page.  However, an attacker able
> to control the register value -- for example by writing a BPF program
> that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
> could redirect the dereference to arbitrary kernel memory, turning
> this into an information disclosure.  The fix ensures the verifier
> either validates and injects the correct bpf_prog_aux pointer, or
> rejects the program outright -- no silent fallthrough that could
> be exploited.

This looks like a fix for a real bug, but it does not carry a Fixes:
tag.  Should it point at the change that introduced the implicit
prog_aux argument handling, is_kfunc_arg_prog_aux() and KF_ARG_PROG_AUX_ID?

That code appears to come from "bpf: Support __magic prog_aux arguments
for kfuncs" (Ihor Solodrai, lore message-id
20251029190113.3323406-5-ihor.solodrai@linux.dev).

The merged SHA could not be resolved from this repository, so the tag
would need to be filled in by hand, for example:

  Fixes: <sha> ("bpf: Support __magic prog_aux arguments for kfuncs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26740141551
--===============3442698258420643995==--
