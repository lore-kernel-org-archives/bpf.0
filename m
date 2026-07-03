Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845493CC7EB
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081754; cv=none; b=hwDumA0UcIcePktIAX/5jUy9PtX5NvBIdFm0Ca6jpKLq8D28nVzGWIZYLPvT1pFetrws5ZZYmJfldm7OqlhcAMnbYaikmzT5MVjwvdLg4Xzkv6WmboWdBqjMwD6W0uQVwqCtL3YEyumVkJxNLmXQ33aupwisOt6o1uP/v0lwy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081754; c=relaxed/simple;
	bh=3enjAhj+bJCSQm1Q7LRQk1xR8OO/wkxTmZzaOgcPYa4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwOiG9uvTg6fjbVCh6Y0vGg/SVOLeNgrJCqellcExnOnYv9kBHjnibxhrk0O3FcYRYRCSswvo5TJfwxszTviyABYqPFfKLddxez2MMbYXANBB0CZyCw8hMOTEgyX1Uk3QWX+DbwDg0ZsjH5FXX1/qQAiD/etlHtV4DkFvosA8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WkmeyIv1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WkmeyIv1"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845e363246aso505248b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783081753; x=1783686553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+VxPGsXEB5teg9HEsa3LZ3vy1Qgi8wQBPtiYzVf6Qc=;
        b=WkmeyIv19WFtZsms5/dPudHOxsyiAC6KOMSXxcgjxTVxkbW+0rJg0HK7s8jcoywfLL
         riGhpZRz5fzR3YDBzKyUSctQzZzoUCJZ/A321WCDFnnlQwWT368rbpGaQnx1Z7xFw665
         8axCiTjh2DMi7xFneknJND9ngbwNNksLz5YoVsKWi7m3/enDRJ6KsQCxbbq8TYxXLaf+
         vWHZF3SHySIP2ICeTa+FstBF2lP4fnYl/9GQp91IxEwe/qO6EWFTPKXI+vZ/XltsiUWW
         cdLVVgDIfCVExdPczXctgvu65hPk23eNpnoM++vZZkJ4MFxT2r/ePTgBovJvkfONHi8p
         2hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081753; x=1783686553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+VxPGsXEB5teg9HEsa3LZ3vy1Qgi8wQBPtiYzVf6Qc=;
        b=R3YOoocmZYMtBjW0xj7djWVaKQa8RGUt4xCAy/YmQCh7du8eFkrheC/gNvSORx5GWF
         aPpuq+gjUVkIZaJHgHUADYAJvseTjdzUZEK3UhlYOhtc2dZ728PCdvw/pHD/chzDxdsD
         TsyNm6PJJG+b+zSUh1QJa967WFCJwUDFLrqwT3QPQDjobZbFKuKW8+UqkciiCPQga8WS
         71s6J/xF+lQbKyvHdTi/rYfhAxhEOO3ZQ5DRplrSEgbpiohTCG0BxouUu6GX7Y8TgPW4
         dFJV9/6jQ4DjrJig8VLQI++znkyhtp847A6iezko2AdSE4MGCU6UuX72+qHRIIN5jCET
         1LsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bTlDbH9q+yMBaWPtI7WW3im+pwUvuQT0pF6mLJfVCGhbOQNud9g2MY+kzustDvOAeAvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+UKBuDesBTFUMk8tv3eDc6seC4O5diXt5ViB1/IQBuQMDSxGH
	jYwudV0oByphJZ4xOVxRI8GsjvFbWITkMVTg5KslRSQUqaAQE0Xv5MQptpE6tUM1uak=
X-Gm-Gg: AfdE7ckRVfCMjA5YDkvspLJVSWSG/JNKpdxPIh6VNFhuC2euhytYcbOOBCNx4fCp7MI
	owmY9DIxDxm843FL6veUFr30L8mP0RFLfPtMl3XswooExXRckvBDAiC1ipHnLYxdV9IlKCW0Vq4
	HYV89ZOObVBFsAjnBc0x+wMeOlv0ASnQRxeQRdZGIg7MzIMl/eyaXqX7tmEcG4kfTervCFA/DJ7
	sm0cwJUgtXSE/UfOCuPlvefwdbnUepFVtlKdevJXyTvd1VjtjE3XAe/g1jmhHTb9Ov9Wqq9R1Ai
	ObXZplC41DBVfQr0CXfjb3V/cJltHL7chLVfk3OF2jfFRwwO1iY474K+5ZBAIjMSWKBKlZRKOqU
	KQ4joy9lpaz7TW7PhyIMPeLXW4fcibNnPTE0l3kC+rEF0WxvyFjb3R4cbR+QHw85mPWg4KvF0VL
	4lcChmzlFxvY9VWGzqUKA29gK0zOWjfB4YHLfSKTN4HAC926g84/U=
X-Received: by 2002:a05:6a21:514:b0:3bf:b960:6fc4 with SMTP id adf61e73a8af0-3bfed4701b4mr11795889637.30.1783081752569;
        Fri, 03 Jul 2026 05:29:12 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f3d74ccsm2705551a12.9.2026.07.03.05.28.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 05:29:11 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	conor.dooley@microchip.com,
	tglx@kernel.org,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v8 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Date: Fri,  3 Jul 2026 20:28:30 +0800
Message-Id: <20260703122832.15984-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260703122832.15984-1-cuiyunhui@bytedance.com>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When port I/O is not supported, exposing the port-string helpers is both
unnecessary and can make clang diagnose null-pointer arithmetic from the
PCI_IOBASE based address expression.  Keep the MMIO string helpers
available as before, but only provide the port I/O variants when
CONFIG_HAS_IOPORT is enabled.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d34..92d5f831f3495 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -102,12 +102,14 @@ __io_reads_ins(reads, u32, l, __io_br(), __io_ar(addr))
 #define readsw(addr, buffer, count) __readsw(addr, buffer, count)
 #define readsl(addr, buffer, count) __readsl(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
 #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
 #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
 #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
+#endif
 
 __io_writes_outs(writes,  u8, b, __io_bw(), __io_aw())
 __io_writes_outs(writes, u16, w, __io_bw(), __io_aw())
@@ -116,26 +118,32 @@ __io_writes_outs(writes, u32, l, __io_bw(), __io_aw())
 #define writesw(addr, buffer, count) __writesw(addr, buffer, count)
 #define writesl(addr, buffer, count) __writesl(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_writes_outs(outs,  u8, b, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u16, w, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u32, l, __io_pbw(), __io_paw())
 #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
 #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
 #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
+#endif
 
 #ifdef CONFIG_64BIT
 __io_reads_ins(reads, u64, q, __io_br(), __io_ar(addr))
 #define readsq(addr, buffer, count) __readsq(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_reads_ins(ins, u64, q, __io_pbr(), __io_par(addr))
 #define insq(addr, buffer, count) __insq(PCI_IOBASE + (addr), buffer, count)
+#endif
 
 __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
 #define writesq(addr, buffer, count) __writesq(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
 #endif
+#endif
 
 #include <asm-generic/io.h>
 
-- 
2.39.5

