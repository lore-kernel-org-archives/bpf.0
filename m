Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB413B841D;
	Fri, 26 Jun 2026 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499382; cv=none; b=Jw4XQgWEu+LOERenraZVSEQBV6ZnuWRN4K016PKiqUdTV5DXa0bBIDpIIlUV3LvStPJXE9YUUcm1hG+lQNDG//PjvA6hNJxh8GR5ZQAnD1lSAX0r4e9ciNM78+yQ/RxMGgL+vm+HNNywpgBLizaUSlLrjKzomtMa4W8oo7XcP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499382; c=relaxed/simple;
	bh=dLPl8HHzyB7kwUw9K4Mm349f5Js20B0KVkFY6+xrz3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=min6tyYqhL8eN7Hn3+8IxuGHd/BSAFhP6Di+46uaE7BemqavlSRW4WK7inauclkq4ejMaPBPdzE7mcKGxdCdynJtfzjbbGDRfNrO5U1ZtgyTm24IrEysrKs0kciOBJW8OECctdjJJtdyAlypWWMyL8YOCtwCjNd85zAFR4/idLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwHrm8rR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwHrm8rR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793481F000E9;
	Fri, 26 Jun 2026 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499381;
	bh=zwji2C9UpS5iv01GUsXzghQglk6tb9Yq1OcD3azZbTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KwHrm8rR6QXHn11peBBisxO//UgK3tluva0ZaF7GCLF7XqBXFeYnuAn8ZQfk1yYgA
	 csZJ9ncBlz5bbi31L/UY1muMWPXomjM1l17ctQhaEHEiyhH8m3RFrlp+v7dnqdjUIr
	 j+ri4Fouv9sxfVeXQKlUpVjmU9PSPy+SULRP3MsRGZcONb/djz0fnkHAIfX/SMdyl1
	 sHZItl2mB+rKVXZL1dUs1wI4/Y4Q2gezyQGH4JjxwjExYcgsG3vKIIYtrNxFuejtw8
	 DxELmdxG1JswdCBKBdSMfn/8TmdifAcQF68+9Vl1HGEZ696oV2rfRb6ubhlr3ttHda
	 MIiOiik/+ZdCA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 26 Jun 2026 21:42:29 +0300
Subject: [PATCH bpf-next 2/5] bpf: drop __weak from bpf_jit_alloc_exec()
 and bpf_jit_free_exec()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-execmem-x86-rox-bpf-v0-v1-2-45a0b0ed4fe9@kernel.org>
References: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
In-Reply-To: <20260626-execmem-x86-rox-bpf-v0-v1-0-45a0b0ed4fe9@kernel.org>
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
index 649cce41e13f..2188f6b5a9e2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1060,12 +1060,12 @@ void bpf_jit_uncharge_modmem(u32 size)
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

