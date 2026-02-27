Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843E32AAA7;
	Fri, 27 Feb 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179467; cv=none; b=HtSa9hDzUakmSZGqZFQWUIoFFRpp6NF6yt+u/oY1lLoGZFGT7G4XXBB8z93tml1gK1x+Lvbr1jI+55A8fP70V2HvXsJj+rujQ1frmqVH30gv/zy24MolKQugizrtyjjjL6bKllD4s/WOWbNzOTcaguMUwVRty06vRUpU6HtT374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179467; c=relaxed/simple;
	bh=nXFHV3cR8GxbsgsKMu/kZAx/DtO5IgAoFy/fvYHBuJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/0VNmixKuoGSiRwwbj9NJ1t66luM02lsVs8D9WWw75K/r9/YALEePGQ+gWWIO8YTvYBR2Pjh4e9MkY3OX9bGrJOyEjvaH5PIZYpAvsVZh4jXOKx5zazGRuxOLWAd8wzp/7NWrGs0P1BhgmOZWH9Dg+enzcIalivbxKG2Nu/lrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=kCM09yw3; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="kCM09yw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772179456;
	bh=nk+cafLP4mV0qNkYoAZlk+EQK8C5KbyOru1aOnmjWE4=;
	h=From:To:Cc:Subject:Date:From;
	b=kCM09yw3iEjKLaAOFWoWgTPCq7gOFlzqk6QKgsQQ3tWLHHNHNQQ98TS303rtnWrke
	 kKWowDBNjLi0kUoxG4VAOU7VqFXN1r7qDCx5za6BEG+TPIA5U309eJhbt8RovPNCyU
	 Qgu+DDguq1uw2qfTc6MeyhXkmTVl8jKhum3gecls=
Received: from stargazer (unknown [IPv6:2409:8a4c:e11:4510:818c:b334:624:49f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 70E3F1A41C4;
	Fri, 27 Feb 2026 03:04:09 -0500 (EST)
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
Subject: [PATCH v2] LoongArch: Fix calling smp_processor_id() in preemptible code
Date: Fri, 27 Feb 2026 16:03:51 +0800
Message-ID: <20260227080351.663693-1-xry111@xry111.site>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the warning:

    BUG: using smp_processor_id() in preemptible [00000000] code: sys
temd/1
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

Change since [v1]:
- Add lockdep_assert_cpus_held() with a comment to prevent people from
  calling larch_insn_text_copy() w/o acquiring the cpus lock in the
  future.

[v1]:https://lore.kernel.org/20260225141404.178823-2-xry111@xry111.site

 arch/loongarch/kernel/inst.c | 10 ++++++++--
 arch/loongarch/net/bpf_jit.c |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index bf037f0c6b26..7545ae3c796e 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -263,14 +263,20 @@ int larch_insn_text_copy(void *dst, void *src, size_t len)
 		.dst = dst,
 		.src = src,
 		.len = len,
-		.cpu = smp_processor_id(),
+		.cpu = raw_smp_processor_id(),
 	};
 
+	/*
+	 * Ensure copy.cpu won't be hot removed before stop_machine.  If
+	 * it's removed nobody will really update the text.
+	 */
+	lockdep_assert_cpus_held();
+
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

