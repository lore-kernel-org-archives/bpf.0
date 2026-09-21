Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C923EAB0
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962864; cv=none; b=Jt60/KqKembK971C8aRiRvJbJd7Qy3EK8OKuaDiM8hSjynenwyCEyD0BbpZ4g1vR+0IhE5TWno8UoF0THx8lCSEJK14hmIorCc6Dl5ubU6Zo9o3RYXDkIJSxYrCZUpH+si5jz/OGUEMAApknAeY9bXNCiDg3ZYOg/QAD2i64xvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962864; c=relaxed/simple;
	bh=s0xaNnHSJ8kD30l8tLTAHS7Ni7SKH2In6TZChByfMHA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VLwARhjj9vJY8/xueH6UqlVlpbaVYglpAYarCMrak4Swj0MnoPAgcvmK7tBRXEW4AmUUhruUQF/90tfP7YFiNyN5tQZSo3laR42AJ7lRmIVdX6dnS54dooMvb7t+X+EtJdbNQcgwGzDz5XiA41RKrMuvfYUt09JEX8eMCQP+YkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5BngK9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5BngK9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18151F00893;
	Mon, 21 Sep 2026 03:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962863;
	bh=VZ6GQTZ4b5OGksfIUTosZ1gygotcEXbXIuxprD5hQ28=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Z5BngK9cibD+u/wzLICrOxREvEmIuxtBY3GIw5mXi3gdefbcSN1HqlijV4DijKGBr
	 0sW9JV8LAxPXUOMKTgjgVjn7dGyMsPGUTLTo4DJ2ADKygwoohLnfKxT+0g1J+5JY75
	 2yB/ofabu0YqwuMQbEyKIhJ0kBH80ySLfmcJZlgEHHDtjLgmH7MPTYiaoLawQyazfe
	 o01qrtmCZF5BKQr8tUuyNP9D/lbjbaDDI9WXt3o+cmo+9UtKaCEhkE6mR9ekg/Noz2
	 +t1sBU9/SyCDxBqAMcbWtedlZQRHkbJDYyZwREE0ym4MQa9z7XxMDtYlJg7LCWzcjs
	 s2HvRlW/4LrbQ==
Content-Type: multipart/mixed; boundary="===============4346478871995847115=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c3186426c2dd775f4263ca826d4c8b4c7e2676264ac4802762f66b42be0a53c9@mail.kernel.org>
In-Reply-To: <20260921023843.411943-4-memxor@gmail.com>
References: <20260921023843.411943-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 03/11] bpf: Check __uninit kfunc output buffers as write-only
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 03:54:21 +0000 (UTC)

--===============4346478871995847115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check __uninit kfunc output buffers as write-only
>
> Generic kfunc memory arguments are checked for both read and write access,
> including __uninit outputs. An output pointing into a write-only map value
> is therefore rejected, and a stack output must already hold readable
> contents even though the kfunc only writes it.
> Mark generic buffers in generated kfunc prototypes with MEM_WRITE, and keep
> MEM_UNINIT when a struct pointer resolves to generic memory. Check __uninit
> buffers as write-only while ordinary kfunc buffers retain read/write
> access. Helper access selection is unchanged. Definite initialization of
> stack outputs after the call is addressed separately.
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

The changelog states two problems: (1) '__uninit output pointing into a
write-only map value is rejected' and (2) 'a stack output must already
hold readable contents even though the kfunc only writes it'. Does this
patch actually fix (2)?

With access_type == BPF_WRITE, check_helper_mem_access() calls
check_stack_range_initialized() with clobber = true, but the acceptance
test for uninitialized bytes is independent of clobber:

    if ((*stype == STACK_ZERO) ||
        (*stype == STACK_INVALID && env->allow_uninit_stack)) {
            if (clobber)
                    *stype = STACK_MISC;
            goto mark;
    }

So a genuinely uninitialized stack buffer passed to a __uninit kfunc
argument is still rejected with 'invalid read from stack' unless
env->allow_uninit_stack (requires CAP_PERFMON).

The verifier's raw-mode escape hatch cannot help either: at this commit
meta->arg_raw_mem is only recorded for helpers (in check_func_arg, 'if
(!meta->btf && arg_type_is_raw_mem(arg_type))'), so raw_mode is always
false for a kfunc argument.

Additionally, switching to BPF_WRITE makes clobber true, which also makes
allow_poison true. STACK_POISON bytes therefore pass the argument check,
but the poison branch does not convert them to STACK_MISC, and nothing
initializes them after the kfunc call. Since bpf_kfunc_stack_access_bytes()
reports a __uninit argument as a write, stack liveness kills the program's
own initialization of the buffer, so those bytes end up poisoned.

The net effect is that a generic __uninit kfunc output still cannot be read
back after the call; the failure merely moves from the call site to the
subsequent load.

Both gaps appear to be closed later in the series (de26ebd0567d3 adds
mark_raw_stack() to check_kfunc_call() and drops the '!meta->btf' guard,
and 06eb5f8a1b1b4 changes the STACK_INVALID test to include uninit).

Could the commit message be more precise about what is actually fixed at
this step versus what remains work-in-progress? The existing caveat
('Definite initialization of stack outputs after the call is addressed
separately') covers post-call marking, not the pre-call requirement that
the buffer already be readable.

This looks like a bug fix for kfunc argument checking. Should this include:

  Fixes: ab7fff217fd1 ("bpf: Check helper and kfunc arguments in one path")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35555832550
--===============4346478871995847115==--
