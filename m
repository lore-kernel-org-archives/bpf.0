Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2046E01A;
	Tue, 18 Aug 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062046; cv=none; b=MPMm8z7ZimYmde+8j7KD1fxmNwbh0UTwlUbr4DNeev30ZCdzxVNomDEMbwoeTCClAUvMgigiFY8yRiyZxh4//c3wXosvYiLWrzd77yeueRgo2pbThbrAnsiRqTu8crLhGXnPOlMywFTH1bQOi+/hS7mKgxImrEZHZgfnzlT3wyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062046; c=relaxed/simple;
	bh=dukS9we1zfBE/bi3Cep9OXodE2ksoGA1ZCmmQe2dLk4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rK6bnGSb42zqHtq/ETmQfD8KaK+I+tKFx91XhT8MNoXP9M2hDqt4P71xshYN1uiwhyklfhJjiF+/zsaMQupnGgqDp0MDz0LloL0ZBRqTjLYyjnFM8HX7radA3NkXUgn3uz6HlQc1QBQn+UX9PLyIVK9Ib0Q3rGl18nk/iwxDJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM8deTdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM8deTdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32B71F00A3A;
	Tue, 18 Aug 2026 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787062044;
	bh=RkiZEuVoOaLw2cPfbZU3c3W1s+jX+eTd2R4YVQanf7U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XM8deTdP1ST5bAnV2mCZXvq3QQTv2G0GzY479fdy6toYeeUQGqxlLM5GKjudj80nQ
	 lJOoYXNp6SybTTMxkNSDwE4BC+4v83CbANyZdhnXiJKnZO/o0DclkZ/suF4vXNvudu
	 25kMcO3+JbM+m/HW7PWBUpBl+jE8rj4LkJNDxA680LBMfijw8Xgk0aydz9TbH9O/vB
	 XjwpzFYP09G1dRaXQib4d289oGUgpjCG+TIUykuexC90ev0O04d3Z8p6uHu+wLOARi
	 A6KJu4ynhYFsYFUdmepVDeuAXlrZwgnKPXAMKcTx8HFWDOrqmdLHlDJNexIY9SyHFh
	 P9x1sP1exGuwA==
Content-Type: multipart/mixed; boundary="===============2716527946889949584=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9b5c48df2b9e1f49191a459c822608751240e2243ae0cebb96bae0939037aadc@mail.kernel.org>
In-Reply-To: <20260818130510.3110054-1-rppt@kernel.org>
References: <20260818130510.3110054-1-rppt@kernel.org>
Subject: Re: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
From: bot+bpf-ci@kernel.org
To: rppt@kernel.org,ast@kernel.org,andrii@kernel.org,bp@alien8.de,daniel@iogearbox.net,dave.hansen@linux.intel.com,eddyz87@gmail.com,mingo@redhat.com,memxor@gmail.com,song@kernel.org,tglx@kernel.org
Cc: emil@etsalapatis.com,hpa@zytor.com,jolsa@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,rppt@kernel.org,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,x86@kernel.org,olsajiri@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 14:07:23 +0000 (UTC)

--===============2716527946889949584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     x86/bpf: make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
>
>     Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
>     number of trampolines [1].
>
>     The slowdown caused by extra protection changes in execmem_alloc_rw() and
>     execmem_free().
>
>     With ROX caches enabled, all execmem allocations except EXECMEM_MODULE_DATA
>     are ROX after the allocation. execmem_alloc_rw() temporarily sets them to
>     W+NX and execmem_free() resets them back to ROX.
>
>     The only user of bpf_jit_alloc_exec_rw() is x86::arch_bpf_trampoline_size()
>     that only needs a temporary writable buffer in the modules address space.
>
>     On x86 executable memory and module data are constrained to the same
>     address range, so x86::arch_bpf_trampoline_size() can directly use
>     execmem_alloc(EXECMEM_MODULE_DATA)
>
>     Replace the call to bpf_jit_alloc_exec_rw() with a call to
>     execmem_alloc(EXECMEM_MODULE_DATA) in x86::arch_bpf_trampoline_size() and
>     drop bpf_jit_alloc_exec_rw() helper.
>
>     Reported-by: Jiri Olsa <olsajiri@gmail.com>
>     Link: https://lore.kernel.org/all/an8r7EODLIL-bZM3@krava
>     Fixes: f0334294a428 ("bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable")
             ^^^^^^^^^^^^

The Fixes tag references commit f0334294a428, which does not exist in
this repository. Should this be:

  Fixes: 5bf02dbf39fa ("bpf, x86: Make sure allocation in arch_bpf_trampoline_size() is writable")

That commit introduced bpf_jit_alloc_exec_rw() and the performance issue
being addressed here.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32142507111
--===============2716527946889949584==--
