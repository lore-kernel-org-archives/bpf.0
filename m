Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5301624C5;
	Sat, 11 Jul 2026 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763048; cv=none; b=L/YQHkCdLcbhKHQJ0wn1yFrlVzdoWTpODsmmM4a/n1BdQ9hxMIqoM7E318xoS6y2Eu3XsycUwpx/lN6dGIsdVi5d9ATHoGaTFgemHQKwWP+bd74In7UjDx83n9O0jeQSk8MbOERqzy2Do3Pej1U6iapGdo9d7+aWGJ9kyngFdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763048; c=relaxed/simple;
	bh=U3QF8xCoBOtWz++BXFIp6VmAPipUOZ9XLsaR/RyX4/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TeQ1Zt16TBs6+U4Rx2n78x9Wj4FL79uoDQbRJj6WEDp4Agz6401yAKvZFm9vN0vaMMGAd/GYeWR1GxA9ELcgdcQkKaBoRkg8tZ0qsbROjqEltEd8BsR5qQDcbMAl6sXi13t/ZpoAibdIrUGu/m0olnEHek0ZAPEMYMpvPYnLRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9arrJNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9arrJNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B001F000E9;
	Sat, 11 Jul 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763047;
	bh=XQlDdlWTPqRP/3iZpMLcH8vuhCfZuv+8TzteFEjBCdY=;
	h=From:Subject:Date:To:Cc;
	b=S9arrJNxl6nEAXGLwuRmnNvVzf+uHcqVioLh9b20utMJ0qUSDOTkJh7D1MEXoBANz
	 tFWNwP+alYfeSPRwzghMdj4bBAr8ieMPlX3LRCC/JsH18hBruBYB6Mvgx1iQbvJJeV
	 CEF9/09k8W+aiMEz/DGRF1zRgtZ/Ux5Np7N8K4ri1XeK95GGslaQp4U3JJZebJRcyZ
	 4X1nf74Dub6yv7xRCtZDb1J5QiH8q4Cp2Q/iPaxOGk3zDX0bVAStzV2bcHKV8gi2Dc
	 K6GgxEPtp/ac7tY72YawdMU79opbSeqc/+I7nCoXZM9UL5RjJUqRWmGcMVPxRUNYk2
	 f6DXvTaI3KxYg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH bpf-next v2 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for BPF
 allocations
Date: Sat, 11 Jul 2026 12:43:44 +0300
Message-Id: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAQUmoC/4WOyw6CMBBFf4XM2jGlqQ268j8Miz4GqEpLWiQ1h
 H8XMHHr8s49c3JnSBQdJbgUM0SaXHLBr4EfCjCd8i2hs2sGzrhkkkukTKanHnMlMYaMemhwYqg
 FF6WyVDHbwPo8RGpc3sU32BhPeYT626SXvpMZN+/GapUIdVTedNvpR69V59IY4nufN5W77N+Sq
 USG4qSYZmRFQ+frg6Kn5zHEFuplWT55IXjj9AAAAA==
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
v2 changes:
* rebased on the current bpf-next

v1: https://patch.msgid.link/20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org

---
Mike Rapoport (Microsoft) (5):
      bpf: dispatcher: allocate bpf_dispatcher->rw_image with vmalloc()
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
base-commit: 520d7d7942025a58a0c79a61b905a556cf3cb524
change-id: 20260626-execmem-x86-rox-bpf-v0-b4241ade80df

--
Sincerely yours,
Mike.

