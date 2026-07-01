Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289F4A2E36
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909034; cv=none; b=nev1x25Lnl9bp/EPBRT3E9iU7u4e8SCDM1Vd2ymPOwb7o7GYQdJostgTlDItiEPpDgIH9kLdqiOBUq1WNuaFAuG8rmbGJbQubKVGWJVH8zMqoIbGxl7SV7Q6GFdDl30Y7Tjoywv8srl3s4zqzHKAexAf3X3cJzy357T8IvoeToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909034; c=relaxed/simple;
	bh=ZjWVD0tSQ1mhVm/q0JGy6VGtAnh9yMg+FOzzJVCwjsQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oiHtFsYFKuV/jcIyM7D3DIWFKLQC497Zm5ELuEupBDnkojMlWueOcR3hlNOmeTdfXKxYtZvJNGwjBJg6ziQ0NzNtC86XyiL78UzyvXp2CoK+EAUwgOh9xa7d7rwHy2vcthLaQEUGh3sVDeCv/BGG/ANFOJ238PB5auYxdm0jzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RlorFXYE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RlorFXYE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7cfa17fedso4352295ad.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782909030; x=1783513830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5IzwYzPDTeWx7tKr7hSDF5l+BLDO1MD+S8kZpieZcM=;
        b=RlorFXYER/EHRQzx3IGHWl9SwBRtuttV2zpJ9Tcfo7IRhAgnNN9+2vgTLLwD/sjfBv
         ctaKxML9I4FKtKJ1xiIOscGW5tbEsHuv6l33+AQ3MxuQDepCM3WJx51gyHK2jeQPCmaX
         9DKQL6uSp5Y+YYHGX2Ka5GpD28m8hdu73bxL2oW4m2qjWka9MGRRJMUwAnRx2zs6OSpK
         a0LpqgRsrvusiW7c5F5E4GhF5CabXRsr6ONN0w4ZmQil88dYcuUTkdBfLIgiixOmQH6n
         1fghPFQyOkhhTd1zEef7Zl0dnZVtDt1TU6Mw38mhMnJtWESzAYSBPeIc9oYjE/6JY0C6
         awMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909030; x=1783513830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5IzwYzPDTeWx7tKr7hSDF5l+BLDO1MD+S8kZpieZcM=;
        b=IC0MoP0U8tM7bqQtUCJcDzg9y+c+dq04UQ+74UNRIJVMKZ+pQiQpdm+JE3jrxHU6t4
         pQdUnqOoOzM++wTJ3WYbeic6WT7C+FVbIDPIDld4lT0LMJPnDMMdXEEkPga1Kf2Tveez
         qlm4iH99G9KuXk2YgGwTDyp6wfj4dWe+Abd5WdTx0hqahWV+e0VjdHQ7x6cjSxja/v+9
         U297ApAQjCmd4kKc+zkwDGmMuWgTdnUljEwd64PTbkYosor5R+2T4Gfc8tdwPlFJv8YC
         FJg21aaIQ+lWKlF56bdPsEBj6W7AfHtKqnRKwK4zLNpCYbkGunV0076yALmosKz5YGBy
         EK8A==
X-Forwarded-Encrypted: i=1; AHgh+RpEKJDsFTnCZ5FMkee0eKiDskIwoWrRA9xvzOwfjOaUgua/tHNmHbNaqfHbrXaYDKgUrac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04NhWpgOgB9ip/8Sv1Y+vrBh7Y2hrlTrzTRwf47lMU0regTis
	fuVG6l2x2P+z6RKjqrGTCp6kicU6+xYj2TcqWy8Tb8lqecYEeQ4YL0OQKzx+qLMtjxs=
X-Gm-Gg: AfdE7cmRgEYlAgk7FSyw/mBbAvhUMWEm7FyYS0IGPlRZQYLzS7EG+PO+YedXMg8WH45
	c1Ml6/9jzBQkm/xQtRAeseaXUT/P9LJAi9j2auGAe1J/EqWbqMDGOzRqiekdZa7t8zEudmjBVcf
	zirMTlFzdYiRbTmWnARDRDF3wLm/sNL+8vAb97QAq5yvOM+XSsTO5nYwzDpClnePewFBeDF5slS
	XvOdvZ35bjnNgN7oLtuD/TdV1DvmNciOJw76agz0VnvjDJWXfCBn+7/29ro9pePYOuGc3Uld1K8
	oA8OwIhugPGIKUU4ls4unY3oAnApBsEZRna3pkkgrV9tQvkSSK30wjfu+tj2xfoq/BxXKa4pDtr
	j5nXPhhV46CRcNO0Z7mxRV+BRFGUTelnakXuapQBtJttsJNi8EXPwg8CpSnndkfD79owwLU7V6P
	Xopa5blOltKEds65F8LKCp7GKbhhjjGRuFrDcTxjia9bv21JyTA/R+eAA1
X-Received: by 2002:a17:902:d549:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2ca7e682ad6mr16606255ad.8.1782909030457;
        Wed, 01 Jul 2026 05:30:30 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca4bae1e2asm25166825ad.73.2026.07.01.05.30.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:30:29 -0700 (PDT)
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
Subject: [PATCH v6 0/3] riscv: fix PIO helpers and add optimized percpu ops
Date: Wed,  1 Jul 2026 20:29:45 +0800
Message-Id: <20260701122948.57584-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
- Drop the extra PCI_IO_ADDR() helper; directly guard the RISC-V ins*/outs*
  helpers with CONFIG_HAS_IOPORT.
- Add the missing <asm/cmpxchg.h> include to arch/riscv/include/asm/percpu.h
  so cmpxchg_relaxed() and system_has_cmpxchg128() are visible.
- Clean up the two 8/16-bit LR/SC fallback asm blocks to use consistent
  old/new/field variable names.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |   8 +
 arch/riscv/include/asm/percpu.h      | 288 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 317 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

