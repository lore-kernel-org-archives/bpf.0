Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AC35B631;
	Sat, 11 Jul 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763056; cv=none; b=Im4UtZIhxrBgAYmoNV3HOS3UGdTi1DGDYJWVzuAve3apDsOq6R7sOyOt4h2wxQ0NXD1P3s7KUj1H0LuIFjIg3zr4py1jW3CS4QwohPGR0DKNcQhOqmqagrrz7c+9+iIQn/vadxHurweleC0PysN68gF7gXvtvhtoBVbybUKqeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763056; c=relaxed/simple;
	bh=y+c5m4difJ9hu52AWtW2xLPtR3mDX1dJE7WtCANf5xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amLMae/9QpaxPhchQJ6OH2hqAln+sWzqb5cyMAtT9xk++i5qbR8CLmZdpXteTIlU8xvY94+ZyiyN+3eo5E6+IAOtvjYeyUrJfcyDRvjkXFSdVojHisk2LYPtUsfiMbmx2tbfcWecubUzBlzgBIjv5Sai/WZWTZX6nOgjRQlxhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb0tCfNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb0tCfNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA021F00A3A;
	Sat, 11 Jul 2026 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783763054;
	bh=Zv9skHA7Q7cWIm9Y+QOl1xh28sFLpy27C2RaWAQyrfc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xb0tCfNo5MNllb7EA+ydd7FSNRGPCscXrUAuSAvrnqkLfzOQw30pDaw89LOMsOC+G
	 RVScABvib+8mPLSAQ06wePi6m1NWrza+6JeVU86WPhvV2fVdyvqtEreCTs/uK3gJoj
	 CmJONAxOl7VKLVrqWpivCRLgo9bP0JuTpj2MRUKkLTxkWtaG4RikrLXc4MQ4WJXAiT
	 01m0HN+dVqeuCm/kMeCxrCNuP4WLNF1nICqFS2T0D+wIqPv2yvIA3zmKGGJXe42E9q
	 mxTzm6XXdV+oP6fT6Mcz+kE4F5owgvuEQfcRWFwTe8ciPt2c2ghmVLdootRrMkwKh8
	 fxT+dw7/hQ9MA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 11 Jul 2026 12:43:45 +0300
Subject: [PATCH bpf-next v2 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vmalloc()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-execmem-x86-rox-bpf-v0-v2-1-bfd956d35119@kernel.org>
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

bpf_dispatcher->rw_image is a temporary writable buffer that
arch_prepare_bpf_dispatcher() fills and then copies into
bpf_dispatcher->image using bpf_arch_text_copy().

The rel32 offsets emitted by emit_bpf_dispatcher() are calculated against
->image, so ->rw_image does not need to live in the module address range.

Allocate ->rw_image with vmalloc() to avoid permissions dance when
EXECMEM_BPF will be backed by ROX caches.

Also saves a bit of space in the more scarce module address space.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/bpf/dispatcher.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index ea2d60dc1fee..d85b3e8ad2e4 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
 		if (!d->image)
 			goto out;
-		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
+		/* d->rw_image doesn't need to be in module memory range, so we
+		 * can use vmalloc.
+		 */
+		d->rw_image = vmalloc(PAGE_SIZE);
 		if (!d->rw_image) {
 			bpf_prog_pack_free(d->image, PAGE_SIZE);
 			d->image = NULL;

-- 
2.53.0

