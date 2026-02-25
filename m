Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A598271471;
	Wed, 25 Feb 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028926; cv=none; b=NKkjR/gi7t5ICwngDrHA/9hlfjNOKOHk87pMMAqc7uGzSHdmIsNWyHA0PDI1G6880bWPIsYTAEnK1AKrsrvVZzAX90BgzETrwcmw5JZ8LQ16iudP98gg/MojaR3M6oJvAb0jvsx1uPEWkhOY8+bWyJB4ZXzU1EpiuFRTya5qMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028926; c=relaxed/simple;
	bh=AVYgVW1Oq7gO4+QnysxWAvg1evILwwV159VO5F9DPlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPue4mMScrVf54IqdVcIcMpMlObdjWUL5lZ8yseVb4wcPRSjMp3Lj3SaVUxvQriVgCXSd6vB8wmAYX/0Lfl70AhQP94/37iUsrjdREPZJ3LwGD+Z87wsYWHT+QbZKBr7C41m0qx9i1/LhFaTcIhLwVk5RuRXbsP3SfEyoiMQ4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=jqzKkcfA; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="jqzKkcfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772028920;
	bh=3pvUGRlmdavixZVPrxVrN1vvUZK1c752LzmogmPwc5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=jqzKkcfA3DDlHLUnJa+rsVfgKwRWcWMIR+jNPkgZDGwI9gSirlrQQ/zPXIIXtDN5g
	 dD4e2EC151/Y1DlDITpF8vA/a57l6i3NNBykcsmjcEYRbL+J0EhF6RBlSTyb5CFJnH
	 Sm0dftzPng42oJUDVLnnFO8rgTbtXRBmxkBwI4WA=
Received: from stargazer (unknown [IPv6:2409:8a4c:e11:4510:818c:b334:624:49f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E718C1A4370;
	Wed, 25 Feb 2026 09:15:10 -0500 (EST)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Zixing Liu <liushuyu@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	George Guo <guodongtai@kylinos.cn>,
	Chenghao Duan <duanchenghao@kylinos.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] LoongArch: Fix calling smp_processor_id() in preemptible code
Date: Wed, 25 Feb 2026 22:14:02 +0800
Message-ID: <20260225141404.178823-2-xry111@xry111.site>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the warning recently exploited by commit 4ab17e762b34 ("LoongArch:
BPF: Use BPF prog pack allocator"):

    BUG: using smp_processor_id() in preemptible [00000000] code: systemd/1
    caller is larch_insn_text_copy+0x40/0xf0

Simply changing it to raw_smp_processor_id() is not enough: if preempt
and CPU hotplug happens after raw_smp_processor_id() but before
stop_machine(), the CPU where raw_smp_processor_id() has run may be
offline when stop_machine() and no CPU will run copy_to_kernel_nofault()
in text_copy_cb().  Thus guard the larch_insn_text_copy() calls with
cpus_read_lock() and change stop_machine() to stop_machine_cpuslocked()
to prevent this.

Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modification support")
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---

P.S. I've considered moving the locks inside larch_insn_text_copy() but
doing so seems not an easy hack.  In bpf_arch_text_poke() obviously the
memcpy() call must be guarded by text_mutex, so we have to leave the
acquire of text_mutex out of larch_insn_text_copy.  But in the entire
kernel the acquire of mutexes is always after cpus_read_lock(), so we
cannot put cpus_read_lock() into larch_insn_text_copy() while leaving
the text_mutex acquire out (or we risk a deadlock due to inconsistent
lock acquire order).  So I'd just submit this as-is to fix the bug and
leave the posssible refactor for others.

 arch/loongarch/kernel/inst.c | 4 ++--
 arch/loongarch/net/bpf_jit.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index bf037f0c6b26..db236e2b34a7 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -263,14 +263,14 @@ int larch_insn_text_copy(void *dst, void *src, size_t len)
 		.dst = dst,
 		.src = src,
 		.len = len,
-		.cpu = smp_processor_id(),
+		.cpu = raw_smp_processor_id(),
 	};
 
 	start = round_down((size_t)dst, PAGE_SIZE);
 	end   = round_up((size_t)dst + len, PAGE_SIZE);
 
 	set_memory_rw(start, (end - start) / PAGE_SIZE);
-	ret = stop_machine(text_copy_cb, &copy, cpu_online_mask);
+	ret = stop_machine_cpuslocked(text_copy_cb, &copy, cpu_online_mask);
 	set_memory_rox(start, (end - start) / PAGE_SIZE);
 
 	return ret;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3bd89f55960d..e8e0ad34928c 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1379,9 +1379,11 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	int ret;
 
+	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	ret = larch_insn_text_copy(dst, src, len);
 	mutex_unlock(&text_mutex);
+	cpus_read_unlock();
 
 	return ret ? ERR_PTR(-EINVAL) : dst;
 }
@@ -1429,10 +1431,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	if (ret)
 		return ret;
 
+	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
 		ret = larch_insn_text_copy(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES);
 	mutex_unlock(&text_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -1450,10 +1454,12 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
 	for (i = 0; i < (len / sizeof(u32)); i++)
 		inst[i] = INSN_BREAK;
 
+	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	if (larch_insn_text_copy(dst, inst, len))
 		ret = -EINVAL;
 	mutex_unlock(&text_mutex);
+	cpus_read_unlock();
 
 	kvfree(inst);
 
-- 
2.53.0

