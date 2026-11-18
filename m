Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019064;
	b=jZdQY1DKNX2Bq5ECYPVlAwzjRUH853mb/7YThOEurGs3ebeGwiVdCiK9G17gS2uELA3s
	 J9iTLaXno2hmY9Zj82TpFr/UdK426A+wdBmT6KhG91ukEgYDuhtMrVuyS87rbn5X+AYmW
	 COODNfWyLdAT7nMrbUe+7UqgqJnmyx9vsDQLClIm2s/FsakTJWi3AslPTAJohjT3ZNP5s
	 2sMd8ZZUwyDAN7l9Em/mnp5Im1X5P3129NMYnsKHQctymIjpUasvp3TJpKMmHZOgpmxhG
	 LXO24UrnIQ7OtSGkqZkmmuiNyV9WET1rfcM826WOHT7Q7KLeLuH5nRfPaSLSOA+vw0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019064;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=TOpAIDRHfeGWsCvBntmW2ZzFHVIXKzXNq/Dq3Yc2xZc=;
	b=4evPIOTZO6ywnABzO5RAu2qcSmC+USBgYk3irZieAtjUHcXS1x8FavLXuHftUhVhabZB
	 /dtMPjc23Inv+F2HTVgv++bHfPjoGXVc7rvcQ1qC0DvaqCX5k8HjkHMuegKcAb+ADUlZf
	 EVQQzbxs0Hbwnikdad73A9iXAVCF1h3tSAfkDmFo8lOZJK9L1WZ6R44/M3u+XinwaCyCi
	 J87UPRCkLVgD4oWpwkmH9p5a9a2KqsyR+ur/b1Q54n2qrHOBqzWOkh1pIPhFA9uGxD8It
	 SXNQH6SmEVWZbRL9lgkc5niL6owiFARKoKWAv8Tzr3dnpxeQ+pJpp+c15dfG9MrNxCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566F960A260A;
	Wed, 18 Nov 2026 16:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 566F960A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795019064; x=1826555064;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=f4l4UEm/mrbUezxJAL9dfH/maMLZVctdQGXwsByoKX0=;
  b=azc/gaRz8bn5070tLzpttephpEFFo/rZ9zLTp4dlsHBMe16l86QCsP0/
   zUFfa82RdZoKJmN68HJmAL7DZHDOeeztXjPmWuALNAwxRYonZYm/9ouqZ
   3LvxIcCk8UF2YIYf1oy8dfaXKbbigDBO4Z1dHJDOQ4Wv+urv9Yzh/+oJe
   L5JDzP5Jkb2VenkU02EbPRro02vOP83/DygDxYIl8tPBI8JW1kzgSgNMZ
   WhD2M01Gdzo0u7tyVoWFbOfX22lU66KnUZDZMLYQLopjdRzImPwBCGd+/
   /lmHMsHKnVXtmEV9OZb5OSNxIFu2UJxs/OLGyTd6gclUSqkneXtrUrAq7
   Q==;
X-CSE-ConnectionGUID: joeyww/ZSe6RT4uGfq4Akg==
X-CSE-MsgGUID: cQTHJTYtSiiUbAKl8zsw9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 18:24:15 +0200
X-CSE-ConnectionGUID: b2M2PZVoTS6e+msyh/iLpA==
X-CSE-MsgGUID: x5y30ScKTtai8TFDxLfczw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 18 Nov 2026 18:32:35 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 18 Nov 2026 18:24:13 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 18 Nov 2026 18:24:01 +0200
Subject: [PATCH v7 5/6] riscv: hwprobe: update the vDSO data after the
 boot-time speed probes
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-lrsc-only-v7-5-602dcf4c1921@mobileye.com>
References: <20261118-lrsc-only-v7-0-602dcf4c1921@mobileye.com>
In-Reply-To: <20261118-lrsc-only-v7-0-602dcf4c1921@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Chao-ying Fu <chao-ying.fu@globalfoundries.com>, 
 Conor Dooley <conor.dooley@microchip.com>, torvalds@linux-foundation.org, 
 olof@lixom.net, aleksa.paunovic@htecgroup.com, arikalo@gmail.com, 
 Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Andrew Jones <ajones@ventanamicro.com>, Boqun Feng <boqun@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Vladimir.Kondratiev@mobileye.com, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Nam Cao <namcao@linutronix.de>, rust-for-linux@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

init_hwprobe_vdso_data() fills the vDSO copy of the hwprobe answers at
arch_initcall_sync. The misaligned access speed probes run later, at
fs_initcall_sync, so the vDSO keeps RISCV_HWPROBE_MISALIGNED_*_UNKNOWN
for RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF and _VECTOR_PERF, and
every hwprobe() call that the vDSO answers itself, which is the common
"all CPUs" case, returns UNKNOWN where the syscall would return the
measured value.

This was handled by filling the vDSO data lazily on the first syscall,
which commit 7e14e42edfaa ("Revert "riscv: hwprobe: Fix stale vDSO
data for late-initialized keys at boot"") removed once the probes
became synchronous; the ordering between the two initcalls was left
as it was.

Split the filling out of the initcall into
riscv_hwprobe_update_vdso_data() and call it again at the end of
check_unaligned_access_all_cpus(). That still runs before
rootfs_initcall() enables usermode helpers, so no userspace can read
the vDSO data before it is complete.

Fixes: 7e14e42edfaa ("Revert "riscv: hwprobe: Fix stale vDSO data for late-initialized keys at boot"")
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/include/asm/hwprobe.h           |  6 ++++++
 arch/riscv/kernel/sys_hwprobe.c            | 16 +++++++++++-----
 arch/riscv/kernel/unaligned_access_speed.c |  8 +++++---
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 9b04377c0f98..1cc83cecbc05 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -43,4 +43,10 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
 	return pair->value == other_pair->value;
 }
 
+#ifdef CONFIG_MMU
+void riscv_hwprobe_update_vdso_data(void);
+#else
+static inline void riscv_hwprobe_update_vdso_data(void) {}
+#endif
+
 #endif
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 52c4c2085d0a..2c64a13c5155 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -534,17 +534,18 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
 
 #ifdef CONFIG_MMU
 
-static int __init init_hwprobe_vdso_data(void)
+/*
+ * Fill the vDSO data with the answers for the "all CPUs" case, to save a
+ * syscall in the common case. Called once the ISA is known, and again by
+ * the boot-time probes whose results feed some of the keys.
+ */
+void __init riscv_hwprobe_update_vdso_data(void)
 {
 	struct vdso_arch_data *avd = vdso_k_arch_data;
 	u64 id_bitsmash = 0;
 	struct riscv_hwprobe pair;
 	int key;
 
-	/*
-	 * Initialize vDSO data with the answers for the "all CPUs" case, to
-	 * save a syscall in the common case.
-	 */
 	for (key = 0; key <= RISCV_HWPROBE_MAX_KEY; key++) {
 		pair.key = key;
 		hwprobe_one_pair(&pair, cpu_online_mask);
@@ -568,6 +569,11 @@ static int __init init_hwprobe_vdso_data(void)
 	 * vDSO should defer to the kernel for exotic cpu masks.
 	 */
 	avd->homogeneous_cpus = id_bitsmash != 0 && id_bitsmash != -1;
+}
+
+static int __init init_hwprobe_vdso_data(void)
+{
+	riscv_hwprobe_update_vdso_data();
 	return 0;
 }
 
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 67f1a0371659..3a6f85e3f94c 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -393,13 +393,15 @@ static int __init check_unaligned_access_all_cpus(void)
 	modify_unaligned_access_branches(cpu_online_mask);
 	cpus_read_unlock();
 
+	/* The vDSO was filled before the probes ran; give it the results. */
+	riscv_hwprobe_update_vdso_data();
+
 	return 0;
 }
 
 /*
  * Run after clocksource_done_booting() so measure_cycles() uses a stable
- * clocksource, but before rootfs_initcall() enables usermode helpers. Those
- * helpers can reach hwprobe and populate the vDSO cache, so async hwprobe
- * probes must be registered first.
+ * clocksource, but before rootfs_initcall() enables usermode helpers, which
+ * can reach hwprobe and must see the results in the vDSO data.
  */
 fs_initcall_sync(check_unaligned_access_all_cpus);

-- 
2.43.0

