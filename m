Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135902;
	b=4knvzqGpDifBfQwduWfQ3fzBJ2Z8AVByc8g97WbxTBP3U4ualc/7xv2AG2zAPvfLEnHR
	 YV0YkVIxchiWjKz9f1oEns8V/1WJ31jPaMO4rwy+0nh3OfqGXUpKQkgXCTmRQkPqVzy3P
	 kyHHoqHlY5F99Ggo/2/HDi9nw/4litPekJXQAGT+TbMuTAOoMJf3l2Xc5Eh3+u26//6ug
	 auvGdd71jg1AAnKw8h/BVn46aDkZ/HL7atxS5r2VYMzGqpj0r9nJ7ARNWLwNyCW6cr2FQ
	 FVZNkbWefK4u1wioYewBmaW5DusdQZ7OBJELcImPyjiFL9JfiLWX66I7lyG52ZARjTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKnJ5ofY6xI7mGRCSoUHzG0stJCP5GNAGXYvslrLiuU=;
	b=E0HxIoV+bb0hv07ankIbZ6U4TFKKV/YdG1xelTrM8hnNfT4EKX3wDtTIZdnAP8Sj3jzk
	 g32+YnUTIIn7Dkii3ABlYzGJ13Nz6MoAP/gXqucJzsxRU+DkoS43ckkMoE2fVxZaB+oyT
	 MTOAOLwrjDYJZJaCCLqlcmBf68yyaCN7XeIO0sSlL2mKB1Qots4MdwOCeSIEyXBfpA6cx
	 UPB+hqh9ADEkfSOmmkRq+KxAsws5VOug7KpQl3uJ9dKXftDQjO42KOHKzEos0uUCKYrsy
	 jbhIQF4ToTuSL6ED2R8PEH4vTIIaTXdU0PufNYz6xz+FmKLb99Ks9NfFmvDMQSttq6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TYk0twXn;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85581606A322
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 11:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85581606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TYk0twXn
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc758830601so5112a12.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794135901; x=1794740701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKnJ5ofY6xI7mGRCSoUHzG0stJCP5GNAGXYvslrLiuU=;
        b=TYk0twXnCSyTPPkgKg6USfYbziaCIK3cHS/cA/JvC7apL4Vzd7htNNdmlrFNMyFOsJ
         QOMpQlBz4gBOtFwLMvHIRpiz5RzuMFoVUq14Hd/SRiz0BvaqyxGgn9JZwnTwKzwBhQxq
         1qudGUWe+mAvLfoRXLgzUFKVTa2DpG7f7E53yZSnbWVuSkJ6P3GfSG5hvrJiHbgTMS6k
         gTXX+UbRhDrdm1uWKkNLqnks842dBShSbnNgkzvAoKVekSirWF5q1z1nOWwx9IwzSnHJ
         ncNGS/ASQkMq/I24P+pGdNRr1SWDOfvc4rtbg3xyLWYAp7GR/HPESpjB+bRj9f+WIlU9
         LIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794135901; x=1794740701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KKnJ5ofY6xI7mGRCSoUHzG0stJCP5GNAGXYvslrLiuU=;
        b=bE8QG8+ne+oVER1m+i/uDvXYNbBixhOYSLIkjPDh/CKPuWBkXGoGXe2mQXHQClovpp
         5zkAThcge5iLYjTSOw6LE8LkpO085XRIenCEMUeYHtee1JdT8Yv/N8zeVCOC1SG2uAIp
         G0xS6VUkt3ruhPbEhjRc6CLJgYHY5Qh4T27puQamG5185Gyr3Z/+uYy/6aftN0zMiv5P
         LzW7jDoql4NH5wG82sn2HzLW/BPKdxc49OouKVZyU3qBTv45frVEwoXvj8Qy18WDYC5q
         OCjDl/Mil9E1VBbMLf4XSf955bZEpT6l0I+OIATmjh6CEpyCAEdjvxxjAENjkaUerO69
         HvUA==
X-Forwarded-Encrypted: i=1; AL+hErEnglOnTMsjQRHtDaeGwmZB1UqHD56XUVAv/E/9Ypnemx3OEOvU8NIsKB8floJcUeVP9gU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uLKbssxskVxvFMKyEnbxDbd+EMFYr+b5+AdSJG52QSQZsA3Gd
	RZmIZm5Zaialo+FtbZIs6tMNtakN7O1JIh9D2akRMXYUVaP+nKXAZU20OeCQyyUufpg=
X-Gm-Gg: AYBFou3NOW6ROB5zmYJ9oM9iq1tgwheEAesbDohmKYr1vLH34MLZ7c5uLyvrxuiU3wf
	kKFqD2OH8VcAl22NCr1d+41Qe13acQztcuNApYUOsqoi0bZoPUJLZWeDG6aQ+sc9Myh2aruS1Mh
	3Ztp02lpNFe0IiioPSciQcKkaEqjm1YkZ+iGVNDSB9198chQlmKvNO0nhNVQ1UEr7pFpwZHPnK/
	i0obVXONGoiKK+wOAwqlC+TbPZ5xHT7xQoEmEPvnUEkBWs3a+Ee+b/69SzXF4eCvH/Q2z23epgk
	1gbDvPGSI2XPrPeiBRKxvZehQNQinpoeuZlNSmrowE75FoeBGPgwbUuJuGdwqCPHP3MEJKv8Vc/
	hPvTKA6I50VCGEAehBxVbx/gTm8vJ8uF/crJF7CI5gjLfwV6FQu6c6u0y5I/dXzlU690qUs1rJF
	0bHCezgJ0MlCk0zRZhwa6iOKrUIW5ftmS4v3FZOfKLeHhq56Il70KNG/WBd7qwm9inZMHOhFjMt
	FPYXDme14BA94nGMnR7TM5Au5i7Mvc5QWSXulpJfhbwde9v+8DXg9w+OH80UEip2kUcJbRpWQZY
	54zmOYogpZGOS3RPjXAYxYCkg8uml2Fa2xglH5FzmYqPTSr2kJBO5mTsInUDv4g=
X-Received: by 2002:a17:90b:554f:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3b12d51f0b3mr872216a91.48.1794135900776;
        Sun, 08 Nov 2026 03:05:00 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm2609818a91.6.2026.11.08.03.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 03:04:59 -0800 (PST)
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
Subject: [PATCH v9 0/3] riscv: optimize percpu access
Date: Sun,  8 Nov 2026 19:04:03 +0800
Message-Id: <20261108110406.97495-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
operations use generic fallbacks that disable local interrupts. Per-CPU
addressing also derives the current offset from the CPU number and
__per_cpu_offset[].

Implement RISC-V-specific this_cpu operations using relaxed AMOs with
preemption disabled. Native-width read-modify-write operations use AMOs,
while 8-bit and 16-bit read-modify-write operations use Zabha when
available or a local 32-bit LR/SC sequence otherwise. Cache the current
per-CPU offset in thread_info, keep it valid across CPU bringup, hotplug
and context switches, and select HAVE_CMPXCHG_LOCAL so vmstat and percpu
counters can use the this_cpu_try_cmpxchg() fast path.

On a SiFive P550, Davidlohr Bueso measured about 15-20% lower
this_cpu_inc() cost in an ad-hoc microbenchmark.

Changes since v8:

- Drop the PIO helper patch, which has already been merged.
- Rename the first patch and update its changelog as suggested by
  Davidlohr Bueso.
- Use value-returning AMOs instead of rd=x0 for CPU-local operations.
- Remove unnecessary memory clobbers from the new relaxed AMO and LR/SC
  code.
- Use .option arch,+zabha for the Zabha inline asm, matching the
  existing RISC-V cmpxchg implementation.
- Isolate arch_cmpxchg_relaxed() behind typed always-inline helpers to
  avoid macro variable capture while preserving atomic instrumentation.
- Make the cmpxchg128 fallback use the already resolved per-CPU pointer,
  avoiding the same macro variable capture.
- Copy the cached per-CPU offset from prev to next during context switch,
  as suggested by Thomas Gleixner.
- Initialize secondary idle tasks in the common startup path, covering
  parallel bringup and CPU hotplug, and remove the duplicate initialization
  from smp_callin(), as reported by Sashiko.
- Select HAVE_CMPXCHG_LOCAL in a separate patch.

Yunhui Cui (3):
  riscv: implement this_cpu operations
  riscv: store percpu offset into thread_info
  riscv: select HAVE_CMPXCHG_LOCAL

 arch/riscv/Kconfig                   |   1 +
 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/percpu.h      | 574 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   9 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   2 +-
 arch/riscv/kernel/smpboot.c          |  10 +-
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 598 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.39.5

