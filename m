Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781339099C
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879689; cv=none; b=qbDvfJaiwLiqCQjeQm6GC9NYun2PfftQUCUv9NfwF4f/sr/PL2f7dHqYVVtPY43OKsQLEswfQ63uoHQq4GdRVK3f0vdko7HZjME/wO0UJRcswgHs0/yG4xWKoVjKKc+m5BXJEJUGWOl2iQT+/2UrSwf3n+wW9Os1KFUtPfJxfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879689; c=relaxed/simple;
	bh=gO5DreLGELuIHJ2EGB/NVadqslhCqv0Ejh6yoHHsM/k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzkOUDJcKytJhQnpzGnylDa5pf0xDrihWl//umqRkCkDMcRIsTIa3qZVQVqLrFH95DdwzdeP7ju5nlkyl4ztwJ49/Dt04QuY+wZAmrKR4cgDvd0CvOiGicoNN20YtGROcg2Rb/dBLztriwQuTdrBRW/eEm2I/fKW4lPLKZx/ZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Oyl86Yjx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Oyl86Yjx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9b19bbaefso1383845ad.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782879686; x=1783484486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/qkNHfsDn8w5YxyUx5hOgj0iL6zLAhryV4C1f/Kz/4=;
        b=Oyl86YjxaYgBbHoZTl86a6lGwlaBf0NngzM+t3xBDNycAG9aXTewJuKlnulxHaVBxe
         hgAzeKbxo5KRZGjf6EvsaWZi/xg7bXk3RBkfMxq/s2zFu4snWzrga6eDk4dpZiSk+KV8
         89hUsHTBaLhpfHWWyGY1inek/fFKwmIPC9boa5Uaum49ewQthJRqR5cMFZUTtZjBPkHB
         D1Fwg1Q6ZZUWL2PqMSxtrF2lhRGBz/VtHqqosGYmfCFv+TW/6UkJQ9VPmSC4HT+/7cb5
         FzCHWK1eAU5sIc68TgE46NtXcAUp0fklvwfiELMtwJjodO5fnWpNoZ2s0K/pfUjD1sMZ
         HbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879686; x=1783484486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/qkNHfsDn8w5YxyUx5hOgj0iL6zLAhryV4C1f/Kz/4=;
        b=awEO0G+5YlhEJ/PzvaABxJJ1cSpgifEcd/k1v/h2Jtel4npQ0Nx8JlfoKEmoC5s39D
         +yD60VgpwT9mZnYhHhyz27cW8v5YOgONdS1aAViGaPRbBDIOIEfTYCN5f81/SUq08uKc
         411lv7H/XL4RXojW6u+yFiKmtE+MlhL7SLAqzIClrbieQkqSwzT5gZb2W4IcMgJKNtFY
         rEa7cQCOlqkwX8ZdGRSq+kFwryeByaB1xs2mJWDfjemF3/m0mYTXum+yhFztyKak0OV0
         00s13CBNGCsn4y+pqdsHLRMDVGD5q1ggK3ZqgfaJ0enJZDghl+wrvCmEc6bGLA4yW3xy
         /o3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoFAy7CTXaGncW5/fbSjbuuCTn03W9uvPl1qhiOy69kFAKr57k9P3sb31sTd0wF39DVFKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dmJaAQxOydDmp2A4689F4BcrxYMkaWKPUsAv5XUhILXmzZDf
	YigvgJuExp9cW5MJBSziHRLjuZlEFky2ky+BPQyaBgbFbX4F9eDIPfL169nViIjcfCg=
X-Gm-Gg: AfdE7cnJl/9Zs8QfTFtDC8I0G1ZPclHvZiUAGuF8Cv2XGlzm/ZIegCZ38ikisLc8iqB
	lYjED/J663exU+VcS8vJBYuqYFYCwMLQU2I0SNEWYSyd6VGLTDUi4otmo/NUPQqgsgK8SeCVLSd
	CyCLOLe7pEmQqV/NRScW/s39PNfQJtL/Uuf/ulxuqFVXF7+H88t7q9aRJChjD0qgc8DB8CzD8lS
	3Io5FoweCkXj2qW5pc68z93HseEgGAVIVLYfDiYwAqNE5jt4KwjKfUCD5yM8OYGxsrmbbX8A+Wh
	ovE4dg8L9/g++HSri3cYe/jTsMVGhYiUw1gZnyg6oHorTfj+Y5/WHR6IYCdMoXlwlPgdfd6Etqj
	av5Er0brmnWCbfAWoPhF2n89Hf35UBCkjE1MFYN8l8u6dqJg7fw+SfUt1u5kA5kHeXfehkGDHW+
	yjMfULqIMjROVOojjV+WWk03teVfQP+oRbt+8hnHXu11ASoWAFgIPdYtgM
X-Received: by 2002:a17:902:e952:b0:2c9:de53:f84f with SMTP id d9443c01a7336-2ca7e75031amr1396745ad.19.1782879685487;
        Tue, 30 Jun 2026 21:21:25 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c73a9csm24450865ad.21.2026.06.30.21.21.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:21:25 -0700 (PDT)
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
Subject: [PATCH v5 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Date: Wed,  1 Jul 2026 12:20:39 +0800
Message-Id: <7988df83f6341ea045ebd7294af2e8907dbd5ee7.1782877663.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <cover.1782877663.git.cuiyunhui@bytedance.com>
References: <cover.1782877663.git.cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V implements its own string I/O helpers so port I/O can use the
architecture-specific ordering rules.  These helpers build an I/O address
from PCI_IOBASE and the port number before calling the raw accessors.

When port I/O is not supported, exposing the port-string helpers is both
unnecessary and can make clang diagnose null-pointer arithmetic from the
PCI_IOBASE based address expression.  Keep the MMIO string helpers
available as before, but only provide the port I/O variants when
CONFIG_HAS_IOPORT is enabled.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/io.h | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d34..6f5d70313c83e 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -56,6 +56,8 @@
 #define __io_pbw()	RISCV_FENCE(iow, o)
 #define __io_paw()	RISCV_FENCE(o, io)
 
+#define PCI_IO_ADDR(addr)	((void __iomem *)((unsigned long)PCI_IOBASE + (addr)))
+
 /*
  * Accesses from a single hart to a single I/O address must be ordered.  This
  * allows us to use the raw read macros, but we still need to fence before and
@@ -102,12 +104,14 @@ __io_reads_ins(reads, u32, l, __io_br(), __io_ar(addr))
 #define readsw(addr, buffer, count) __readsw(addr, buffer, count)
 #define readsl(addr, buffer, count) __readsl(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
-#define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
-#define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
-#define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
+#define insb(addr, buffer, count) __insb(PCI_IO_ADDR(addr), buffer, count)
+#define insw(addr, buffer, count) __insw(PCI_IO_ADDR(addr), buffer, count)
+#define insl(addr, buffer, count) __insl(PCI_IO_ADDR(addr), buffer, count)
+#endif
 
 __io_writes_outs(writes,  u8, b, __io_bw(), __io_aw())
 __io_writes_outs(writes, u16, w, __io_bw(), __io_aw())
@@ -116,25 +120,31 @@ __io_writes_outs(writes, u32, l, __io_bw(), __io_aw())
 #define writesw(addr, buffer, count) __writesw(addr, buffer, count)
 #define writesl(addr, buffer, count) __writesl(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_writes_outs(outs,  u8, b, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u16, w, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u32, l, __io_pbw(), __io_paw())
-#define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
-#define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
-#define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
+#define outsb(addr, buffer, count) __outsb(PCI_IO_ADDR(addr), buffer, count)
+#define outsw(addr, buffer, count) __outsw(PCI_IO_ADDR(addr), buffer, count)
+#define outsl(addr, buffer, count) __outsl(PCI_IO_ADDR(addr), buffer, count)
+#endif
 
 #ifdef CONFIG_64BIT
 __io_reads_ins(reads, u64, q, __io_br(), __io_ar(addr))
 #define readsq(addr, buffer, count) __readsq(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_reads_ins(ins, u64, q, __io_pbr(), __io_par(addr))
-#define insq(addr, buffer, count) __insq(PCI_IOBASE + (addr), buffer, count)
+#define insq(addr, buffer, count) __insq(PCI_IO_ADDR(addr), buffer, count)
+#endif
 
 __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
 #define writesq(addr, buffer, count) __writesq(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
-#define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
+#define outsq(addr, buffer, count) __outsq(PCI_IO_ADDR(addr), buffer, count)
+#endif
 #endif
 
 #include <asm-generic/io.h>
-- 
2.39.5

