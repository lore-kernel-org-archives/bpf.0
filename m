Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8830DEB0
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960933; cv=none; b=DQeNzMU6rQuLrjmzRn2nG3Of8CkLh+0NN+J6Nno7jMpWbSB8Wf5UdJvOjYU6eO3VhcvWSRqoVxmrg5cje6oR4tnbmPf6+JwXFB8UwxaAwzX/mWuUUlE8x8IV5/e5dKHaLey2CKYQLOxk4DYlBQ8KTZnZRCpD+0jHM6CzoXoswPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960933; c=relaxed/simple;
	bh=lmOaxI1RXCMjG8bFhu5Ke54uH3zrNAZJOEhH2v7clo0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eniQsG4UhKYNw3maC153A0Y5cYQCp5Xi7KzfTaCQBH9F8tIwzz70Q8uQl6L5PyX/1KaHv6kcn1A2iLjU8577GHSqpvdVKUAAxpkHV+BT4TgJow7D/ijrIlI1UBLsOZv89tru764YgZYiNzZkpJN4a1lTnnuXLcI2KPGzvOuyhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b7zUqmv9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b7zUqmv9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8478a25f268so836305b3a.2
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782960931; x=1783565731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDd9DofNJHdq9P/rugFQPHi9oXh/6OPbyalY3nUgBIk=;
        b=b7zUqmv9cIcRu+k8O0DU4dS4OHfQcb4G5qyDpORr3mJmvm7EZA2HffkmMXbdfhgsOC
         uP8kHRVNprPU6X1A1Z33//ewTftZcUuwg/PcdGaZdYdsc05OLl4wxaM9YiTfHyWdJXSQ
         jvSU2z81ouES6RPkmwA0Ats4vOdDh8GJ8e0JlPyNOnpVLt1JsM5Ld264Fo49v/O+KCcj
         X5VaY26wofdGh+cTvebtCpC4APVbpj5jFm86ltpBhDMtDwxoal18bS36TXvvA9soRDtm
         zSRgTkDZHrZaWMXUcpziDBAhastHeiRiwegxh/akqtbMqqYtHAzuzreOROmPYwjNXc62
         lKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960931; x=1783565731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDd9DofNJHdq9P/rugFQPHi9oXh/6OPbyalY3nUgBIk=;
        b=iSOjpw6OzBtgOzY9gSWKSABkSps3rnang73BMS66JymDkfUU5aSjfLoPplPTcjKpa6
         4nY5dyT/Zri/JTgOdbkOqwXlfL0CiohJ77oAUxtlb4alAV/RO4uMY3d/Zo0pC3yM+rUi
         OtxZud40uWRB+0uHB1Ixi9lP+b6gm7UXyumN8878fGcfSubJ88HZt9Cp2zUr9HGQKHZT
         eA6a/hicgIDrNXJ/Q+14hikFng6rett+CaJDjnDyoamcZt+jtarJWPV6cBj9A+cTJ4Pg
         dAcgVotD1esd/SqQ4Phet0i7RuxHqqvyl3G0pfMqZSuDUYGa4xdGl8UI4XmERvsFsgro
         PJFg==
X-Forwarded-Encrypted: i=1; AFNElJ9PAA1hXs/AQkG5WR3Vn4nUVFYKvYPN697jY7cCGiY7mOMdb0Oi+e1uBbWoq3Z/FyGR74o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIgnC8tFKcWgqQHxL04vH3gy27RiOknd4JBgS959FXEIwi5Tw
	eWtnKWJ/brok82mVVSNRbUsv6iAnL2u9RX+ImQO+N6L+iMAxu2FnMPf2A/Y0Ga/nWeM=
X-Gm-Gg: AfdE7cmCG96F/H9ZiXZCmaGrMWuq/9v58nxz9TrHxeVa+sNT6JlQ00ExHKkDOx8AxSH
	51k6YCw/01pQ8+o3/v+9e4O0rvr/g9GnpWSNYpWf53vnnCocq86ALaEij89yJGjxXPXTj/v2baH
	3T0agCcjeBBLB6FA8Pgz6YKHfcHUNd0VuNsRZZnnZpftsZO40Cp4ta0IQ1jauJjduzJ8h8ZnhQN
	zVp4ZfxgawIYPVyKQvTkU8cwuGwQLCn96yF83/tEoxdMrlMp+qGswEn9DSDCyxsDvQxPmxHXKGG
	uziH9v+6cotR6kvTSMWDmIZmROyO7blGNfmJ93lN4ntRgoyuNUW58A1vGOpZP35xJGn1E3hzOPe
	4tQu4H4KAmuAI+/Iz76MOZhRkKjpwFfq8oncRt+l4hIOlRqU4EKCbvU2lY1612CHQgSObrVM9z9
	qoQMB4wbnBFWK8eaI3RxROfkn304nrlVyPv+Be2N/FPNBKFA==
X-Received: by 2002:a05:6a21:a517:b0:3bf:6c07:b2f0 with SMTP id adf61e73a8af0-3bff4303b09mr3695006637.51.1782960930507;
        Wed, 01 Jul 2026 19:55:30 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm4358686eec.15.2026.07.01.19.55.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 19:55:30 -0700 (PDT)
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
Subject: [PATCH v7 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Date: Thu,  2 Jul 2026 10:54:41 +0800
Message-Id: <20260702025443.83389-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260702025443.83389-1-cuiyunhui@bytedance.com>
References: <20260702025443.83389-1-cuiyunhui@bytedance.com>
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

