Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183E3ADBB4;
	Thu, 16 Jul 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188322; cv=none; b=HGb+jBZBaQi7dl9Ewe9DYIkKMxamINDhhm3sB7yPZk1/qk6E5oyDXiai6IoqkCT8BKHM6o1IqrNaRBR4DZ0OCpdqyWYCNovm+QH62Q8H3uNajIyWRk26akMGqf1Rm31obswKL70mhNNadV/91S4b7IW6vtgB8ehJ3LUMkElJXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188322; c=relaxed/simple;
	bh=KMdENao6bsuzOHvaCM1iOOpBS7g+cu2arpkSzIMQIts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NL2z+jU1Yk0IuYVMLSL+Gcdt7x9dHFqvWX+684jdZoVlpvwUhu1mCZNFykEMxMLcMTufBJKr0ZnV5diLF2SQsZ5N90rexwH+hFbZ8v6iBTfhjFibGI3CJ7/FWx+fLGB6ryPpyPYE9hJ5g0qzkLzsVJbE7PoIWjU+Akph3ohBp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2d4O1mV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2d4O1mV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977211F000E9;
	Thu, 16 Jul 2026 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188310;
	bh=iVpt+hTdXRr4Os4s4lc7gHEYSJh+NwOMWjHuKRC8z2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k2d4O1mVI/GvrOYKJjFNghBetNfDaX4fwpcx9HfDdFS/d1HxUh+eYM+TWz2eC61cm
	 9qXhjxNJSgzipDaOReWmBomQwyrGuTazubkr+eJAOrXKCRxN6W8cBK49YMlKOmPyCd
	 iqN69Jk/oRGS6Ybfg2HtN/cDR3hMZTP8r39SL1d4X6rWgJyD55g7t6hTa11dfT3E20
	 dXwVYz1u5cI366NUZLxOqAqdCtq2TFMyGRh5MLMXIb9r/mzXuYKYip2UmDyy2J/CL3
	 768jXv3n2unnxHG+F/lYn4Q9OFW1xctr0pcKuoZ/sRpJKYvNK5e0jpRvWBtavIPWAa
	 Jw0TPLb/fWK6A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 16 Jul 2026 10:51:35 +0300
Subject: [PATCH bpf-next v3 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vzalloc()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-execmem-x86-rox-bpf-v0-v3-1-4e76158c01c5@kernel.org>
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

bpf_dispatcher->rw_image is a temporary writable buffer that
arch_prepare_bpf_dispatcher() fills and then copies into
bpf_dispatcher->image using bpf_arch_text_copy().

The rel32 offsets emitted by emit_bpf_dispatcher() are calculated against
->image, so ->rw_image does not need to live in the module address range.

Allocate ->rw_image with vzalloc() to avoid permissions dance when
EXECMEM_BPF will be backed by ROX caches.

Using vzalloc() rather than vmalloc() ensures that the memory that
bpf_dispatcher_update() unconditionally copies into the executable buffer
is zeroed, which is not ideal but still better than random memory returned
by the existing bpf_jit_alloc_exec() or plain vmalloc().

Switching from bpf_jit_alloc_exec() to vzalloc() also saves a bit of
space in the more scarce module address space.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/bpf/dispatcher.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/dispatcher.c b/kernel/bpf/dispatcher.c
index ea2d60dc1fee..79f0c222c583 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero, false);
 		if (!d->image)
 			goto out;
-		d->rw_image = bpf_jit_alloc_exec(PAGE_SIZE);
+		/* d->rw_image doesn't need to be in module memory range, so we
+		 * can use vzalloc.
+		 */
+		d->rw_image = vzalloc(PAGE_SIZE);
 		if (!d->rw_image) {
 			bpf_prog_pack_free(d->image, PAGE_SIZE);
 			d->image = NULL;

-- 
2.53.0

