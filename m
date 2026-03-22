Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700C37C926
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143987; cv=none; b=T6DMdZ7sUJcvkj2uHoILZBwX9zrdFEaJBWzzcownU6SE/+hsNJDcD/fRK4Gc72keU/XpPSBA7+1axrzYC+aMSnS8Orv2znPAhTrMmx0ho99BV2LJhS0abH9RVW1sl8EGpFyauaDhMHV6bLqcdwcZtZrN/x7HbOWdcDzYY4itz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143987; c=relaxed/simple;
	bh=jPwmEm3SqqyenRy92iZpQRjfJuisk08VLbzKctwYVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UA4E80tWoORhAM3HYYhnFJT4kr+830bvuJWkRDy+AH/85UWjSx4T1gSshCbXWvEuy6/nHacvUi2xTWYUZqxUG7J4+j0ADMFWMmshEzG2ffzQq4hJlFN6jbO6VMNGSJ+credujZUbXhOG/jGmTYs+l/6BRAyneu3CyWOP+r6qWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlWHfY6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlWHfY6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774143984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15KtbOSZZwPvaDkTFOfNSBs8+xeaxRwo/zCVjX7fmi8=;
	b=HlWHfY6aeN5JwvUnWjhJu5ctHzQVhTsm69PdbConbEFKqznZ5DcTcpUr+aCoPRbkv+DX7/
	931xznMB2vw4Z6PXEIiKZWHArkVtjJ6Qz0iKSNvjLQroZBxbB6X4vHQhzGTs+mWF8AJDRE
	ENdWYbSwFdDBt85ZMbzkDOckA7lA0xw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-idsQIo93NDiI8WZvZibClA-1; Sat,
 21 Mar 2026 21:46:22 -0400
X-MC-Unique: idsQIo93NDiI8WZvZibClA-1
X-Mimecast-MFC-AGG-ID: idsQIo93NDiI8WZvZibClA_1774143980
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C6F819560A1;
	Sun, 22 Mar 2026 01:46:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5E00300019F;
	Sun, 22 Mar 2026 01:46:07 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 08/13] kexec_file: Factor out routine to find a symbol in ELF
Date: Sun, 22 Mar 2026 09:43:57 +0800
Message-ID: <20260322014402.8815-9-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The routine to search a symbol in ELF can be shared, so split it out.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philipp Rudo <prudo@redhat.com>
To: kexec@lists.infradead.org
---
 kernel/kexec_file.c     | 61 +++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_internal.h |  1 +
 2 files changed, 62 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index aca265034b4ed..15857a56e6278 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -902,6 +902,51 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	return ret;
 }
 
+#if defined(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) || defined(CONFIG_KEXEC_BPF)
+const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name)
+{
+	const Elf_Shdr *sechdrs;
+	const Elf_Sym *syms;
+	const char *strtab;
+	int i, k;
+
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+
+		if (sechdrs[i].sh_link >= ehdr->e_shnum)
+			/* Invalid strtab section number */
+			continue;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
+
+		/* Go through symbols for a match */
+		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
+			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+				continue;
+
+			if (strcmp(strtab + syms[k].st_name, name) != 0)
+				continue;
+
+			if (syms[k].st_shndx == SHN_UNDEF ||
+			    syms[k].st_shndx >= ehdr->e_shnum) {
+				pr_debug("Symbol: %s has bad section index %d.\n",
+						name, syms[k].st_shndx);
+				return NULL;
+			}
+
+			/* Found the symbol we are looking for */
+			return &syms[k];
+		}
+	}
+
+	return NULL;
+}
+
+#endif
+
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 /*
  * kexec_purgatory_find_symbol - find a symbol in the purgatory
@@ -1221,6 +1266,22 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 	return ret;
 }
 
+/*
+ * kexec_purgatory_find_symbol - find a symbol in the purgatory
+ * @pi:		Purgatory to search in.
+ * @name:	Name of the symbol.
+ *
+ * Return: pointer to symbol in read-only symtab on success, NULL on error.
+ */
+static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
+						  const char *name)
+{
+	if (!pi->ehdr)
+		return NULL;
+
+	return elf_find_symbol(pi->ehdr, name);
+}
+
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 731ff02110b3c..224f09188db23 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -40,6 +40,7 @@ void kimage_file_post_load_cleanup(struct kimage *image);
 extern char kexec_purgatory[];
 extern size_t kexec_purgatory_size;
 extern int decompose_kexec_image(struct kimage *image, int extended_fd);
+extern const Elf_Sym *elf_find_symbol(const Elf_Ehdr *ehdr, const char *name);
 #else /* CONFIG_KEXEC_FILE */
 static inline void kimage_file_post_load_cleanup(struct kimage *image) { }
 #endif /* CONFIG_KEXEC_FILE */
-- 
2.49.0

