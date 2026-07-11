Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3235B631;
	Sat, 11 Jul 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763061; cv=none; b=hO92STMg1sLnvob7kbEErorpeIVeotJ9f7h9hWg8YdIdztn+XyTiRikcl/MrHEeGn3+oSXf8c2idPLZbAjItonmDCVAfOVByqpbpSxhjuPqTcfpLTeQRq5YlzsfrWZMIYsiFBq58htjsj25nwtf9l1yB2Cwqht3C1EkQwLKQcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763061; c=relaxed/simple;
	bh=lmOTQ1n6pV1wNm2gFyUMrAEiIjEvHHmVFcF+U3WmfnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gH+GYlRSM1VtcfZRoUG2/P0nBax+JXZO/W2KVnZ+cPuJDGdesuG8aCv9DJfYNtHyoB6OFyPe9OysRt3A6A/u589VeErne19rlMb8HKRFhaX93a8kwrf4B4AW+VtmVDyyGhEx+QUpvlMxo4DkqezbaKg2BJpS+8oF7nkdFRZfAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onn8EiJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onn8EiJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB91F000E9;
	Sat, 11 Jul 2026 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763060;
	bh=CtebRvbxm5uNw/fy+A0iTGr4pHE+6vUMv+Jp05j6/1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Onn8EiJu41rfBsZxpkNYrymyRqil3LrcDll1npf4bsqGzbIfYkgAoNvnw9kQUvc8L
	 rZC8kmIhfTBzLDCrBMhoZZvlXAsVONypbjgC8rtSkEj5TyEWTJCNoCE7YbY/eIqGh5
	 +GLX1AOdTDXfTk/24Q0Wt9VqcIL3biiWE9tirJlezQOa0oygxL+5bDYXVaF3sNqY/c
	 siPfYVnkt5UT3YenW+rDLpzUFfhqkFiioyBV6LclZ5y72IQTake35t9rhtuCwexMYv
	 Fo0Vjclt/NA/YbXRsswBIjbEJYX4/MNkQ24ZF2hJagPmNmjhOaRIUKDFGRQ/WAXxrl
	 jRpxItKUHngpQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 11 Jul 2026 12:43:46 +0300
Subject: [PATCH bpf-next v2 2/5] bpf: drop __weak from bpf_jit_alloc_exec()
 and bpf_jit_free_exec()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-execmem-x86-rox-bpf-v0-v2-2-bfd956d35119@kernel.org>
References: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
In-Reply-To: <20260711-execmem-x86-rox-bpf-v0-v2-0-bfd956d35119@kernel.org>
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

bpf_jit_alloc_exec() and bpf_jit_free_exec() are wrappers for the
corresponding execmem APIs.

Architectures define the properties of the memory range needed by BPF in
their initialization of execmem and don't need to override neither of
them.

Drop the __weak qualifier from bpf_jit_alloc_exec() and
bpf_jit_free_exec().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/bpf/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..fc75625dc951 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1116,12 +1116,12 @@ void bpf_jit_uncharge_modmem(u32 size)
 	atomic_long_sub(size, &bpf_jit_current);
 }
 
-void *__weak bpf_jit_alloc_exec(unsigned long size)
+void *bpf_jit_alloc_exec(unsigned long size)
 {
 	return execmem_alloc(EXECMEM_BPF, size);
 }
 
-void __weak bpf_jit_free_exec(void *addr)
+void bpf_jit_free_exec(void *addr)
 {
 	execmem_free(addr);
 }

-- 
2.53.0

