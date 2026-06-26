Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F739E178;
	Fri, 26 Jun 2026 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499372; cv=none; b=qoEC2j42GBxoXwRJ1BC1WgZB07FgQgXdkrkwc+RhZzq24o3sKSfBXYu1Ks2bwDfjqd/oa5BK/1Yg5d0UijzJStMwFqxcG3+xEIouLIMwxN/w/vhiuVRwTnMLsy0LpvwTsQLuKZ4s+XtZcPeSLW+Bf6t53wgrKQzEk2k2ZidSPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499372; c=relaxed/simple;
	bh=JWkHXBU1mGQA67u8M4Mwz/J4RihtcFSzCuxqy2udFrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UdNahyVMdXZLFYiszHyh+SpJjksnI5jEJ5ZT/GEV0Zsp9LJ9jyEZQQCdCTmcNq9wj2rzbCeBPLS+h/bkYYWP7VrDCelFWwWf4F1tZLUlN22aLi2zU32kIjl3kZh3je9VIQNIGSQiWfP6IX1TyIp1aEnkNBFaOnp/sqzNQQM7znA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu9xT4ka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu9xT4ka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C41F000E9;
	Fri, 26 Jun 2026 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499370;
	bh=Y2jYIpiU9rHOLzJ6rW8B0ETQwBbPjC7JNbAxl7OPdmE=;
	h=From:Subject:Date:To:Cc;
	b=iu9xT4kadHsyufbrbYtuebTagku+x829Man2uLem9CDItWHYLdu2+CBpNOOWsjmMH
	 vgmY4deQPM1CSNRG+XuUl2dHqroQst0AJC18t429ShljAo/UNSsLF3BLTav4mluHZ7
	 0AJ/ZLbFnpw00YcoizpjkWwh+SM68m3ULrj8a+k4fwFHJ1C9iVHkUSjnS/TMOdNfj4
	 YDrvQ8OKafuhafvioyQbVB1txpJIEKG8W31nlGY0B/KQBRn8e4eGsFfKtpK52cLeAR
	 lvJYLr7cBGzmEKHeC9w00gqeG+9M6pzcSeq0dSdFstHn0vG9un35DxQEjYvGoxJct3
	 9IvhmsHkHXfjQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH bpf-next 0/5] bpf, x86: enable EXECMEM_ROX_CACHE for BPF
 allocations
Date: Fri, 26 Jun 2026 21:42:27 +0300
Message-Id: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPIPmoC/zWMQQrDIBRErxL+up8aCRJ6ldKFmrGxEBPUBiHk7
 tWWLmfmzTsoIXokunUHRew++TXU0F86srMOT7CfaiYppBJKKkaBXbBwGRXHtbDZHO+CzSCHXk8
 YxeSonrcI58tXfKfGBJRMj9+S3uYFm5u3sUYnsIk62LlVf/q66JQR6Tw/EP1P9KYAAAA=
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
X-Mailer: b4 0.15.2

Hi,

BPF allocations of executable memory on x86 are essentially read-only. Most
paths that call bpf_jit_alloc_exec() immediately make it ROX with
set_memory_rox().

The code generation, at least on x86, uses separately allocated writable
buffers and then updates the actual text memory with text_poke().

These patches do several small adjustments to how BPF allocates executable
memory and enable EXECMEM_ROX_CACHE for BPF allocations on x86.

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
base-commit: 53435562a725962e4de0c29653223129ba11643a
change-id: 20260626-execmem-x86-rox-bpf-v0-b4241ade80df

Best regards,
--  
Sincerely yours,
Mike.

