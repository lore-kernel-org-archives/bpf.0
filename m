Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7F492502
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941653; cv=none; b=OTpziXX4/qtM2rPwIXK9kW6CGbPTEjBBI4QyoC4U5wv3WrCtk9l+NPwwdZ2EZSeFVSpEGG1mP9jx8GtxUYPWwyw77gnb5qdVJLUXChsb8PNwzTJYn2gIQwIIi4k73I4C0D4qaxkoBvm3YZHaYwEjTFi1wYPXM5PorLyf0c9wCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941653; c=relaxed/simple;
	bh=Z6+6qgrMqZOCEMWz+sTwHAtgnCEcJSTRNv4x54Ln7Mw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aWj1ikFbS6CQiR6eAoCarZb1hUi24lX9jHezijns8cZdPx5/ioJNrR3HFRZuJ4ymjd/menEp/ranrG3Cdwlyn25fdRXD/I+qAJvQc8RM/aW1HZXyjiLKnaNvM3hKqiCwWaOFL/kPQo4UdhtAjI5TIt2+1XDQmx36XLeJwLeitCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8J7+C+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8J7+C+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825171F000FF;
	Fri,  2 Oct 2026 11:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941652;
	bh=a8jsXOU57WsctLY+exm8hpe3Ga9w88LNQXzCjlucEkY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=e8J7+C+ms8UfK3uH63hnrQrD+UKpqR9frNWzQbiQfMiN2WzfjZvj1FBj3hyIQLeI2
	 kKK3bS111l4oChYuE6aRXQ7Z4eueQ7IYj9jFhvYNA29TctOBMhZz3edCcqlrnorLLj
	 6MeOtOUyoKfym0uoH/N/M0P8njy37Iqx8oJkaga/IMrmH1LV7pZEvCgKtL5c958vCO
	 ajzWB6l9a2LOrEfUpnfI78lX2XA3Ff2ABNulpRVirFfACUBM7hxBM7omzx2QtATGja
	 f570rq2lHk9FVSKSFvOe/TsrwQOQYZX4uVz/zbn4IiQIs62CrnqXTdrs0SYrquWy+w
	 1RGFMmc6yE0jQ==
Content-Type: multipart/mixed; boundary="===============1869927124965567504=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <37316db148babaad61725459f9303c428f4af2e98842478e4d6bd1be08e34a0e@mail.kernel.org>
In-Reply-To: <20261002105218.6171-6-emil@etsalapatis.com>
References: <20261002105218.6171-6-emil@etsalapatis.com>
Subject: Re: [RESEND PATCH bpf-next v6 5/7] bpf: Directly store kfunc desc index in instruction off field
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 11:47:31 +0000 (UTC)

--===============1869927124965567504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Directly store kfunc desc index in instruction off field

TL;DR: Commit message only: it says the JITs are modified, but no arch JIT
changes; only the generic lookup helpers use the new insn->off index. Possibly
a leftover sentence; suggests rewording.

> bpf: Directly store kfunc desc index in instruction off field
>
> Currently, the verifier sort the kfunc desc table twice: Once during
> kfunc collection by function ID, useful during verification, and
> once by immediate address, useful during JIT bytecode lowering
> time. The latter sort can be removed by storing in the instruction
> the kfunc desc array index the desc is in and using that instead.
> Modify the JITs to follow the same convention.
>
> This change simplifies the subsequent patch that adds per-call site
> function specialization.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

The changelog says "Modify the JITs to follow the same convention.", but
the patch only touches include/linux/bpf.h, include/linux/bpf_verifier.h,
kernel/bpf/fixups.c and kernel/bpf/verifier.c.  No arch JIT is modified.

The arch JITs (x86 do_jit, x86_32 emit_kfunc_call, arm64 build_insn, riscv
bpf_jit_emit_insn, s390 bpf_jit_insn, loongarch, powerpc
prepare_for_kfunc_call) are unchanged.  They pick up the new insn->off
meaning only through the generic helpers bpf_jit_find_kfunc_model() and
bpf_jit_get_func_addr() -> bpf_get_kfunc_addr(), which this patch rewrites
to index tab->descs[insn->off].

Is that sentence left over from an earlier version of the patch?  Could it
be reworded to say that the generic JIT lookup helpers
(bpf_jit_find_kfunc_model() and bpf_get_kfunc_addr()) now use the stored
index?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36999828295
--===============1869927124965567504==--
