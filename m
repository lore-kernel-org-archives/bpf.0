Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECD38AC90;
	Thu, 16 Jul 2026 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188312; cv=none; b=p+xRUyqFGCiZRj4eD8RAwIiSfEt0wWz8y21mTj4hNpNU0G2FjWURJEwQCh9mBVFYOlf3/uqoW2UQBeLbMHTFrzxNbeZVlmHMpWX+SuEXO+H9AIRj1p3Wh7jwbSnN+3yazF1BjzuTo6o1jn/o5coufULz7j8EQASO0HKiCMW2agA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188312; c=relaxed/simple;
	bh=5Fd4+eK9E6eGfW7e6mF7U9Cj3d2x2DrKQzkF77OObNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q6YkRVKFQMgxlu2tlFN3mhH9TdEhwJNFy4kv7WMYFZgKj9UFNLsouJ9ohYbe2dtqI6qyWmspdHRHoxma/adWVEy6uFnXHn6MZ3wbBYveS0GGKp4zqkMZg4ZYX6orbIGkLKVppySS4NGEKIEOhfoNLm5ZIndmgcAIFWYkBUulqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUXd1JVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUXd1JVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538CF1F00A3D;
	Thu, 16 Jul 2026 07:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188305;
	bh=K0q4iQ8vXEaQKfG3l11G3u2R60hLYqiFlU6seI3ml1I=;
	h=From:Subject:Date:To:Cc;
	b=fUXd1JVqXFDPnj8QOBtPJtiP6A2yMszY4qJW4W1rOlQj5xVB2ON2hyS0+UiksxXGa
	 fknB4ezYhROdKZOAQbIB+xikYYPQthHda565MBVgXEk3mkzvFciHpJHi2Gpa5LVoT4
	 1grvWMUELOhnAnjCM2y1FDOoOB9/ya41UrjTB4qFiRlx3OSmiYtwEJlZZZXcitOLNF
	 tN6AOWoma3gTbL7oWAQKemS7CKfOEENgZOjSu5d77tBqyUHlKa6NbjbJGUmpaE9ZEg
	 PsErQkijdfiasDmy56G7M+9/ITlKhGleL06OsrFFEVtJcks8O6qU6oHm952U4PATnu
	 WckbAAe5evdaA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH bpf-next v3 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for BPF
 allocations
Date: Thu, 16 Jul 2026 10:51:34 +0300
Message-Id: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIaNWGoC/4WOwY7CIBRFf8Ww9jmALaOu/A/jAsrDMlpqHpVgT
 P/dUjOZuDCzvO+de3IfLCJ5jGy3eDDC5KPvwxTWywVrWh1OCN5OmUkuFVdSAWZsOuwgbxRQn8F
 cHSQOppKV0BY33Do2la+EzudZfGCFCZgHdnx94s38YDMUb2GNjgiGdGjacvqlvzodB6RCtD4OP
 d3nlUnMzv8GJQEcqlpzw9FWDrf7M1LAy6qn07wjyT/PtxAfPXLyGGe3tbLrWoh3zziOT0+brxt
 DAQAA
X-Change-ID: 20260626-execmem-x86-rox-bpf-v0-b4241ade80df
To: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Song Liu <song@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 "H. Peter Anvin" <hpa@zytor.com>, Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
X-Mailer: b4 0.16-dev

Hi,

BPF allocations of executable memory on x86 are essentially read-only. Most
paths that call bpf_jit_alloc_exec() immediately make it ROX with
set_memory_rox().

The code generation, at least on x86, uses separately allocated writable
buffers and then updates the actual text memory with text_poke().

These patches do several small adjustments to how BPF allocates executable
memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.

---
v3 changes:
* replace vmalloc() with vzalloc() in bpf_dispatcher_change_prog()
* rebase on the current bpf-next

v2: https://patch.msgid.link/20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org
* rebase on the current bpf-next

v1: https://patch.msgid.link/20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org

---

---
Mike Rapoport (Microsoft) (5):
      bpf: dispatcher: allocate bpf_dispatcher->rw_image with vzalloc()
      bpf: drop __weak from bpf_jit_alloc_exec() and bpf_jit_free_exec()
      bpf: alloc_prog_pack(): skip ROX management for already ROX memory
      bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable
      x86/bpf: enable EXECMEM_ROX_CACHE for BPF allocations

 arch/x86/mm/init.c          |  4 ++--
 arch/x86/net/bpf_jit_comp.c |  5 ++---
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           | 30 +++++++++++++++++++++---------
 kernel/bpf/dispatcher.c     |  5 ++++-
 5 files changed, 30 insertions(+), 15 deletions(-)
---
base-commit: d1f4b56417a3dc1a0600f960b14f46bd25eda89d
change-id: 20260626-execmem-x86-rox-bpf-v0-b4241ade80df

--
Sincerely yours,
Mike.

