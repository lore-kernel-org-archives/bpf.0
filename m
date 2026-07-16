Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAB377ABF;
	Thu, 16 Jul 2026 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188326; cv=none; b=OwHQ4qC1WnElb0Nq96PMsBX5QMcHqqrqNagaH5B4zfpzIJ//2bNSejXkqV4X9j3TnekNw+Y1GAkUHoPqYtmAq4wtEtAuU9ny+1U83B3GOXv1NfYLu9Zf6E3GCmpsap1ZHhoicr9sbABRTg7fdMCeUZjIIJg5rJN7Ma7ahZGim9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188326; c=relaxed/simple;
	bh=lmOTQ1n6pV1wNm2gFyUMrAEiIjEvHHmVFcF+U3WmfnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=joBeAXlw1EboLouFiXdSCuMGPve0/VRFI/77eDn3EKjorvgrxypmyaTmnlBKiZgW1sr54rr4F1J2zqv1Dj1SnIOY3taqtK5Ob+u3gW0BG4ksff02jLImB6ZkqFlWrbaS1VvKDiQd5fAx8vKogfe+Xc8hiwZ61XTyK/BmfaJ0VoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO6Kp4zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO6Kp4zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FD41F00A3A;
	Thu, 16 Jul 2026 07:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188315;
	bh=CtebRvbxm5uNw/fy+A0iTGr4pHE+6vUMv+Jp05j6/1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lO6Kp4zz8sQhjtJaEIernumceStD+SNT3wTl5uYLcBUMeEdvJeeMQp3hin8tt6t2C
	 DyrvnbR2jRnyi4N/0DifuPrNIBwKVSMDQTlRTkC9XFKtFCraS9U8HGkr5R6kVErao5
	 ExAVwUR3TAB/3XHPe9fFVf/K+DsI4yMR0xz5SYBCa3wgaKzbUPaBC4xNkjO2PoHXZl
	 SN6erM3bmgI7MGVSWueqaALOK5xdzERhHrdYAccTGXwtJtvlzCPokbWqtH7nDTddzn
	 1o2WgeMwAsoFQYcbAbd8z7AKryhOCw19Sn2/OxXPCTCzgV3fHwfr3iwc8UX6wLMCTh
	 2t//Rym0utpYQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 16 Jul 2026 10:51:36 +0300
Subject: [PATCH bpf-next v3 2/5] bpf: drop __weak from bpf_jit_alloc_exec()
 and bpf_jit_free_exec()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-execmem-x86-rox-bpf-v0-v3-2-4e76158c01c5@kernel.org>
References: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
In-Reply-To: <20260716-execmem-x86-rox-bpf-v0-v3-0-4e76158c01c5@kernel.org>
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

