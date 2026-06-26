Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709839E178;
	Fri, 26 Jun 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499377; cv=none; b=uzbkzLuOcfmuqw7Z/9++PwfhIxZq7kxzvOP2nGDpv1rohJxRC1fvx/qE7boWRIR2gEdEJyGcoIkVvFLeYOP85YWVcf8CGo1Nevitm9cRKoNrgRTLyZ8iQxsiM0jXHz2dIGwNFy3N5wg+fPDYVFJZUi1W7pjk3Mi796yFOZh3ZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499377; c=relaxed/simple;
	bh=CS1DIDAnhfK7tLLsNkqV12v0RV3C5CtdsDybbxq5WUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7GqEDvDxuXPNjoMpAt6c4wa4chejyarNtN+qd7WVAtyz0nbRlt3KyakcjOOeuQ7UAKcgTNqAX1p5IdwM+IYctSZuwgEKN2uNV3JE8JQDkeJI6ekHLOioAN4K1KQFbf8TCbhZd/1BA6rtpX4hU560bsZphJXshH82Wp0DgY6QWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGQr1lj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGQr1lj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4051B1F00A3A;
	Fri, 26 Jun 2026 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499376;
	bh=HW4mOqYidO8DrjxLJx5hkm3Ir+iw5YbKcUZUovLZTeE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mGQr1lj2XO0Rb7PqiXofI8h5nCrrDo1sYTRJvuKGIp43o9ZFe5WnhDIuE3o+RTOgL
	 CiEl52clo2cLS5OZA46IHcJOckQ4m8SDODo7Y363hXZySSslzruf44b0ItKJtgLCjI
	 6Uzxr4D5ft/QL//OKfR9NjBULcbP7SiOaBLvNCe1aSNlBdhmzL9Vf7Zpc3u8Oc9Cy0
	 e1XL4UsZVZQLXB0hSE5hVp3NL1yxxAQolxQMmgoEFoWKCqcYckTWhcexMOOzrzHYuU
	 xqfT/8yKPIKspIv454tTtZo4gAVDE5rSbcAtfulJLz5Fkeopv3ZNTIb4Gwq9ve3YDU
	 Fd7DZKvhGuxww==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Fri, 26 Jun 2026 21:42:28 +0300
Subject: [PATCH bpf-next 1/5] bpf: dispatcher: allocate
 bpf_dispatcher->rw_image with vmalloc()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-execmem-x86-rox-bpf-v0-v1-1-45a0b0ed4fe9@kernel.org>
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
index b77db7413f8c..a7a6a375cdd3 100644
--- a/kernel/bpf/dispatcher.c
+++ b/kernel/bpf/dispatcher.c
@@ -148,7 +148,10 @@ void bpf_dispatcher_change_prog(struct bpf_dispatcher *d, struct bpf_prog *from,
 		d->image = bpf_prog_pack_alloc(PAGE_SIZE, bpf_jit_fill_hole_with_zero);
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

