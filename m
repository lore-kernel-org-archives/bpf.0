Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AA3CAE7B
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962068; cv=none; b=UKFeX/X0HcOBgxU9wvFHWm8u+ip+24QYCTr6yDPEkQEtZ8alzPY40dG43hvI0nDw1G2z31OhfrshdFkd1a/kKrsbYVd9n6XpDbHNo2aeZ6a80D4VHOADOLnwApwnxNC2h/v5oPRE6HCFJJ137vfXhgah1cqbrzEK++p2hONaP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962068; c=relaxed/simple;
	bh=6vd2WgAVEeop7ukkZoD7aM1VrCz8dUOAcyeyUNwokY4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzjtIOhO61Z0wP185MV/kHikR/6oLr4cKg2UdTnZtbwYYwDK2jyHZTzPX+kUNmULBntLKG3o5QEvntBuC+4sdcmTA4pKztJRhTI1NkBxOW1uSkB09rHZwsj3/QZPvuPSH4gO8XibzusbilpaemuaOQhVD8/X5uJmuDLiXtBtHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RJ3tag0/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RJ3tag0/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1486246b3a.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777962063; x=1778566863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUWhdkh+jSa+kjESo9b/CmN+H/tJl8wa3ioBeRpyc7Q=;
        b=RJ3tag0//hy9WXcGS/GTzeS9mf3NTmnMRRdvE84zM+cc8CumSeuZew1i/4iF/Owoit
         75lyYnvoGRn9bI30wrOBzbS+EmuqGslraahAn/m6J9jxj+pNKRrZeo8Gnhzo985Ah/d7
         JRULi9jSY3L3FAPH++Dh671UQs64IJvtsOR1OYVhNvDG0TIDMZNStFfLplYIqWu9QCIF
         1PR45chetHwWRU1yGhIZEBvw378E5yLaugtjXpMil16rfLKgX6Ze30iVV7wQxW5nZLSv
         W48aAxE8XNcinjxVt7sLuWU4cD3vR6MQwlcErZjkArKTDXLrLxTE8GcziUlYMvBvuJ65
         hGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777962063; x=1778566863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUWhdkh+jSa+kjESo9b/CmN+H/tJl8wa3ioBeRpyc7Q=;
        b=NvLE5tRXI6SDK3UapbSZkYxl7yZuayqVYcc2yUQ23wshMcyQF6HlE6ZrOMhuKTIYWX
         3P3oZSJP+7Q9b0D0eBS910hpC7RUzd0pE7y2sZNFXQyihO1C/SyvlOZBtoD5YAGnXT3T
         Oq3JeuK90MEsTU6BV/potBdh3RoCVY1SJI9eeBNOdUSR3L6yrvVd6BI39JX6XGnKlGrk
         +Jwn4YU4WTnU5cL8n4PuwRlgsPN0pljd2taEDSfaumgwMmwf9kmeDV7mUx68kQpKRKx8
         yCapLLY2Ae4i2rpu6p8PxGdL2AjYfnjt9+ob3cZ28QoZZtjj/fXYfwLDTruy3MMhDI6N
         ryqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KoI84eJYmiAZscn0RFNM/dHPERyH2Hbu0T0CFPnMQdv5Kpg/pGn4WQhp7gi3p0MhZXqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4TeJ95oEIry3R/hk9ZgTl05r6SiYA40S6BBaV41arZJ0EaIs
	rTnpmvh1DcOGThIf95ayjXdePnRhroKWq9Gq/w3jyUiJj2r/H+Y5nMLSECCfXUcErHo=
X-Gm-Gg: AeBDieu4uYuiTp2nmxAgiwab1fqbpSw9qXvfxYqQ3s4t0ET+h4vlJYoFi4mYofiux6Q
	GaotuRtMIDJp6ttgBeU+u61QU7C0EgcfCmT69CyAadsF3tMNmy0tblS5Ykk95y6YK9yQ6Z0PkB7
	DRpTFXA5PBuOB+QWxb2VyP98CVjup5DoWSfYFC0Q/+DrMPbNz1tfk0pXtfkGGdMzu5vYUgJHtx2
	sRJwAgnYq5S4AH+y66pSgk5nPn8e0U5iCcmePWMyKWT+47JoD0wNTAW+LyjG7bNC3QL7EEYsZGh
	D4XF0JoTXk9Ig8bITcC4ROcaSi2mSvGF8MURoFoEWe5GDnV62NcX54P/3f7ME8n5kSkgD7VcfT+
	GxPtorBK6/oNyvDuCfC2QptrmYoLGaoWSIS35u2wBkXJn2lsm3SoKMguq9Tzw2cJv10RlpbxiGP
	Q2Pzz1QrEgJy74p0GWcZC6Z2sy2+toIMvSXwtGrJGM5MiOGKyOGIrA7i1QDije4iHH
X-Received: by 2002:a05:6a00:4b55:b0:82c:d9d0:f482 with SMTP id d2e1a72fcca58-83924eb8dd2mr1858261b3a.46.1777962063135;
        Mon, 04 May 2026 23:21:03 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c10sm880738b3a.37.2026.05.04.23.20.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 23:21:02 -0700 (PDT)
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
Subject: [PATCH v4 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Date: Tue,  5 May 2026 14:20:24 +0800
Message-Id: <20260505062026.91724-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260505062026.91724-1-cuiyunhui@bytedance.com>
References: <20260505062026.91724-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V PIO helpers derive I/O addresses from PCI_IOBASE in ins*(),
outs*(), and ioport_map().

Under configurations where I/O port support is not available, these
expressions can still be formed during compilation and trigger
-Wnull-pointer-arithmetic warnings from clang.

Introduce a helper for the address calculation and guard the PIO-only
helpers with CONFIG_HAS_IOPORT so unsupported configurations do not
construct these PIO address expressions.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/io.h | 26 ++++++++++++++++++--------
 include/asm-generic/io.h    |  4 ++++
 2 files changed, 22 insertions(+), 8 deletions(-)

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
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index ca5a1ce6f0f89..d799e5ccc9437 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1205,8 +1205,12 @@ static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
 #define ioport_map ioport_map
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
+#ifdef CONFIG_HAS_IOPORT
 	port &= IO_SPACE_LIMIT;
 	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
+#else
+	return NULL;
+#endif
 }
 #define ARCH_HAS_GENERIC_IOPORT_MAP
 #endif
-- 
2.39.5

