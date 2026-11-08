Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135960;
	b=y7+/ECkeiGCZlHrzmFKUBv1PMaLawOspBfEUNBe0fHVSqc+l4kd/bWEjz7jpZWETl3N4
	 Dj1heSpCW59hCvyHJ0rxAiTjeEK/s8NkWNF9UaDgNon0hrmMAlHF+0uTZ8TZf4IEImRy6
	 ULC206vlosSv/5clFKtcBWq5i2/iKHzzRGkpaSTzH8TDwtxYtZQgN6avqaZZjWkzGM9ML
	 HJplVfso5GCVkLxQlWBAlCWcAGPI2XhGE15B62Kj3zuOVTz0/R7gku+J4TsfRYzIETud4
	 VGK2NaEDLSFmz4FeQo0ZL05eo01g0W8NIaxQ9DQ7rFJQiIaBh2kPtSMomXuJvbPSlng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
	b=fadl3LbANsFs0mHzq+U6casEB9hfgKrBKnNvHEajwNriDK8f06yLxd65gqd2EQ5Ytlol
	 xvHI9i+GJmTgaPbsgl+k4Dn/m99K3q7Qpsddbzm/CorfVa+crpbCKIg+LM6hgp8cmj4AT
	 LifZ2QkJoCkwzMIYACKfhu4DPIxBpGShhUegwnC0znMGUWtK8G+PCvRCAgxCA/cjbsHfY
	 2xkDjDO97K7g3Vs0wXlMf0JuVzw7ArAjLpdD8WeRYXZttw7zI1qQ69mgk0H/dUbopH/hs
	 3wbIF7VujclkSy9BvehIEX9/08jHMis4iW+d+NsEez5P0YL4DCmE+z9Bjd81rav7GAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="bhi6t/Je";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43443606A333
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 11:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43443606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=bhi6t/Je
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso5969a12.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 03:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794135960; x=1794740760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=bhi6t/JeDBfQCUXNCuYRksQv2qWkciS/u1/5/yspUL/F73vw4nOHcnPeGYEcwCD3TZ
         Do5dJSxzQ+fWQqld0igPAKgZ0+NrQ1FfbPYZMXbHhC2VfnnNfMZTEp7WBbZWtOUVVOr7
         mkG6IOmpRzXEGivw2x0s2dsCoUxJ6Lh9u9uWdrhAL+vurQh3BOyLhhmuqDjEfQ1TSXTu
         9urqZCq/rBP4rr5tUicOBaeNqC7DGEqbbsRmy3lD2vtRs7uBKCvYEQ7uqH0JXUJODPRv
         NpyePZ0faGJyAcJm/l7ZELRLiQCQsWnyCWcLj7QEQ/5S0Jx8tjSBk0Lk7wb9LWRpVhC9
         ebTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794135960; x=1794740760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XnCYVNofTC0C6ktldCAu6GTGzm+Q8FA6+tvEuphsY/w=;
        b=ksDX6hj67RvYe8lEeZYEG9bG2SBeuHaMpND7gr4G79lJa+94FKSBzWrT97iJsxxLa5
         7aO+h2Rtdm/R7R1uolkfFYFM8aXjyXqPDHYuMmrsvR/jV0jKs2cbZ45moQzQfQuma+1c
         rgzxCFa0E165qKGDhUg3XUgfZskdCv/aM+fCxsjtsB/1o0BKrPHykpeUpbGMQE23zegQ
         C2gJDsTgJ+erENPljtnNn6zpdAbhcW3x4j0pSdhRzdmSibFduWiZ+zXK+kF1Ag3+hdjc
         LHND8XDD052pgRkf98qFTwSbdOQ0NDW8W9DMlVbwS3kqdpVzO01jg2J3Q9NxSweAaHjI
         tehA==
X-Forwarded-Encrypted: i=1; AL+hErEUfXkxh5fwM7c2yFEwr8q9PtJZr4/OZVu5gmb1j+MG3R8qKgOKy5+a6/y03AJx5DY3c9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0zwqTLvEYR0NyCzg+lxo2ycDQKXiDFw1wGQ1e45mtf3e12Ejz
	qyP+UQpOnzCgTOt+8LVfsCdj4hUPdWnE6k8XdlJmIuOY9R4fchVhVd2B9VcCj/zmQRI=
X-Gm-Gg: AYBFou37ddIn0f393Qq2zgnroawZwDq0+u0Qo+lVrluTb9hZ8Hu6d+8z1Lf+8HtKRZX
	EQWVfBz0nhQls5tXzZscSEfXZwZF/wuRFzSTDj4UhbbvjRkGNRq1ZAMQFC0AwjJgnkDYgy4pX3S
	wQphPy8xFQmNvDYEpydUcDr09zTtC2Hi+4t9LYkajJR9TvUfCa97uRsQEJJYRJMPxmzIW8jnKw8
	S6KnAZUNqmojilL095JX0QI2z3DPmkZmcq8nyyhC5RuW4mXSZ4Zn5ZsPYdxmsz7+hLi0a4vWf3U
	D4m42LsL94hdLs89LQf3VM1BI03b/GH5KJ+kTnJJ+bkFvvh9txjIigWct/AUePctR6vJrjCOHG+
	bTYZaXoI/KElQBOv/E/EkL6g2VVrsbOuoEvv23U+7f+TmP9YvMSc+PNcl++LjM4wQKQjoO5o+8G
	Djd479iqSZMMp+HH0DvGRJhuJvW71fHHPvgjIiH1ZS99Bsd4b335tlmU2TJ0sReLrWU+Mz6wQbR
	SNN22Y+covAfvfIYj7AwBIaSDVq9m9MTnDF9q5gx0YTTSWLo+jolZA294M2PFKIfG9RPx2wbeef
	gE2Bex6IokLtvCo/IqIfhVHlghL8DeaKnB6rZln6mzvHAnAggt/ruv5+mnLsb+o=
X-Received: by 2002:a17:90b:3b8b:b0:3b0:9317:5842 with SMTP id 98e67ed59e1d1-3b12d43f8c0mr1076560a91.48.1794135959430;
        Sun, 08 Nov 2026 03:05:59 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm2609818a91.6.2026.11.08.03.05.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 03:05:57 -0800 (PST)
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
	llvm@lists.linux.dev,
	dave@stgolabs.net,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	broonie@kernel.org,
	cuiyunhui@bytedance.com
Subject: [PATCH v9 3/3] riscv: select HAVE_CMPXCHG_LOCAL
Date: Sun,  8 Nov 2026 19:04:06 +0800
Message-Id: <20261108110406.97495-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261108110406.97495-1-cuiyunhui@bytedance.com>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that RISC-V provides this_cpu_cmpxchg(), select
HAVE_CMPXCHG_LOCAL so mm/vmstat.c and lib/percpu_counter.c can use
this_cpu_try_cmpxchg() instead of serializing per-CPU counter updates
with local_irq_save() and local_irq_restore().

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20260826010748.zphu3wh2hlm4t4o2@offworld
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bde1f1885038f..458ef01e926a4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -155,6 +155,7 @@ config RISCV
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_BUILDTIME_MCOUNT_SORT
+	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
-- 
2.39.5

