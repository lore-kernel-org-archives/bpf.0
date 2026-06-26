Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62D3B841D;
	Fri, 26 Jun 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499387; cv=none; b=IYh5HeIuNLQyAqk681IOH9liS2pDnwunYhNwJUIq9LPU7FCDokRAlviQBnYN1N0Lcd+vduJzP8kIFRUvUY9lWwXHafwqmVwH/yrwDb7kfOHXyVDpSEgn8ql/XTeMaIn26msodcpQaDcpahr9TYhFIjiLM3u0hCauXf+3XvfQXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499387; c=relaxed/simple;
	bh=cB+w1xbrhEH0srTeL9FdXnkV+/63Mq1/05qX5h7HK20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpzmTGaY2JbO3xqyWWj1E7jGpRkReZJhWfgyazem+qfbfq/ME76Haf2I6GUY/VDGxQADObWWdH6LUSAihuiCQnQERNnyz3V8hr/DBZKbSi2YA/ugU02GIWdSuPAywOUaRoknC6qEnQEQxC2nza2VLqXMcVFRqPZDUSbDxcin8no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRCtsysa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRCtsysa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16351F00AC4;
	Fri, 26 Jun 2026 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499386;
	bh=FQ+idOrSfmfaBYxqrv6dRiEtL+QN7+DgeChXvpxaPgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PRCtsysa4pvFEALm0Xo+j1hZXQdxuDHNxxPuHbvd1L81k2U4AlImhD+NAIJsiXag7
	 csRGTeXjls0EB3qL9ldgYZsyLOU4H0y0KKHdCEZuZlLr97rmc85hIAeGUT38R5Nhw6
	 I1D8gv3W3UA933byGbwY9PDZQhi+tsUBls+C8NpzOje7WNe+gd9An5FzwdJqoZIIDa
	 Oh3RhZqmbrgmSJD4THy503uNTf6mIyle9zOnWnaQq/ABzhYOPYGZM/RxR7rB2i1bXq
	 Aew3bTaqo3r0P3Oe8R1r6YzWk14z78z7pHtmimwLA7+BLv6zD9j04bJShuGIycahme
	 naVHYdwPx55lw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 26 Jun 2026 21:42:30 +0300
Subject: [PATCH bpf-next 3/5] bpf: alloc_prog_pack(): skip ROX management
 for already ROX memory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-execmem-x86-rox-bpf-v0-v1-3-45a0b0ed4fe9@kernel.org>
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

execmem_alloc() can return ROX memory that is already filled with
architecture defined trapping instructions.

In preparation for enabling this mode for BPF on x86, make sure that there
is no redundant management of the ROX memory.

There is no need to fill allocated memory with trapping instructions, to
request permissions reset on free and to set ROX permissions as this all
is handled by execmem_alloc().

Add bpf_jit_mem_is_rox() wrapper for execmem_is_rox(), use it to check if
execmem_alloc() returns ROX memory and skip the redundant steps in that
case.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/bpf/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2188f6b5a9e2..9666b6cca797 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -904,6 +904,11 @@ static LIST_HEAD(pack_list);
 
 #define BPF_PROG_CHUNK_COUNT (BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE)
 
+static bool bpf_jit_mem_is_rox(void)
+{
+	return execmem_is_rox(EXECMEM_BPF);
+}
+
 static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_prog_pack *pack;
@@ -915,14 +920,16 @@ static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_ins
 	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
 	if (!pack->ptr)
 		goto out;
-	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
 
-	set_vm_flush_reset_perms(pack->ptr);
-	err = set_memory_rox((unsigned long)pack->ptr,
-			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
-	if (err)
-		goto out;
+	if (!bpf_jit_mem_is_rox()) {
+		bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
+		set_vm_flush_reset_perms(pack->ptr);
+		err = set_memory_rox((unsigned long)pack->ptr,
+				     BPF_PROG_PACK_SIZE / PAGE_SIZE);
+		if (err)
+			goto out;
+	}
 	list_add_tail(&pack->list, &pack_list);
 	return pack;
 
@@ -943,7 +950,7 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 	if (size > BPF_PROG_PACK_SIZE) {
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
-		if (ptr) {
+		if (ptr && !bpf_jit_mem_is_rox()) {
 			int err;
 
 			bpf_fill_ill_insns(ptr, size);

-- 
2.53.0

