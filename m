Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019064;
	b=4MkZNRY+tA6h+s+4tH2Y0BxNoWvn9QzhDapm/T5B83XjWkxB43T4QZ2WJdnuchkgeFq4
	 iNpE0yb1c28/CulCzYje8+kxOH3aJNBGNxyn19tHusfJIqUwzkVuPpp6OmpTGnKRp+okL
	 vqCMa6sQ60KZkU8t+7iXnyey/7GrcRTh0fdHVAjrBbSw5fUYl4BQk4Q4bD7rpQhY1Axmu
	 pIUjRkFtZrUe3wM6IOUxJMl3Wq8VrT5F+DYkuSEftZEtmOd2eDbQ4EevWFDDNAXQNHy/R
	 JtqDcmUXfNHxZbs3EDD+TuybqpO0MJEm2HWRudwQmwrj4mEZSK082vrs5g0a4J1kndg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019064;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=XRX0jpStSD9AjtNIhJ/nMEWdEVORdoezlteZPGTomLc=;
	b=bdemjdEIaU/cgJNbn2InUOhNkCA/4jvXirKqyYCXi6F6gFf+e3xbneeW626sRTh3KXCY
	 0bdynSxJYRmjRlOH3SPtGjENgqBASwfBEgTnUGC8tFq6p4yO+re7KJsxRe7BsmBSmucEd
	 S3v/buebxpCyc+cWsJieqYRC/Rp7xDP1WmE22TA9D9UU3xFtqCPyhdiTIvo15wvc4oB6y
	 0EPeo9Aoxz/ZNhVpwnbr/BsF9UnOiLrq9Bvsc4JRt4s9oL0iSLLmxJ/OW90ZyJZ5VD5MZ
	 Lwmu71hS0hnCWbr3fFvtH3qAbO5jINmewj79SG9V8xP5PbKar95GNqXwFEESk6wfGsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A2606A336;
	Wed, 18 Nov 2026 16:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93A2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795019063; x=1826555063;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SKXT6RSUFkwioTiiM3a3wYtu411WIrfRehlIIhPMF7Y=;
  b=NyBKZdqGKR7BLzdvUgGcyLKJmiHDYYBT+0VI1o/ChHxbZc7U0PXcc4ti
   OHqv6FKGBCF5cjmRLCpIsbDxeNWbuJvJmYyzV0MtHfbOTRKbjGTgo7s04
   vBhfLpg/Fa+tiXRI3u51ByWynUDg1VqSdFqBK6NyIjjoawbOrDcSsl+zF
   IGiiDdQST9boo1FrsaG8UX1jhhY9aesWtMZfkN/xRd59XRgnz+xix6jPe
   PJFxDoOPkrCkANRXgCfJz/W/GDYTzKQwblCPF8c3uBSwfisHGjYb4OXRe
   1x59c2x0Cw8MqjW2EdRRVdLghlD7XPAzIjf3mKFItCvAJFiLEcKTwBpPK
   g==;
X-CSE-ConnectionGUID: nDk3mj84QFyg03/Gd69Mxw==
X-CSE-MsgGUID: ufPUs/TPQrWiKDhYzW9gJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 18:24:11 +0200
X-CSE-ConnectionGUID: cEi3bevQQXOjuOQLygAE3Q==
X-CSE-MsgGUID: UX+rdF26TEGwJ/SWFbwsCg==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 18 Nov 2026 18:32:26 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 18 Nov 2026 18:24:10 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 18 Nov 2026 18:23:58 +0200
Subject: [PATCH v7 2/6] riscv: accept the atomic extensions this kernel was
 built with
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
Message-Id: <20261118-lrsc-only-v7-2-602dcf4c1921@mobileye.com>
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

riscv_early_of_processor_hartid() rejects a hart unless its
riscv,isa-extensions property contains "a". A hart that lists "zaamo"
and "zalrsc" instead of "a" is rejected, and so is one that lists only
"zalrsc", even when the kernel was built to use only LR/SC.

Accept "a" as before. Without it, require "zalrsc", which every kernel
uses for cmpxchg, and "zaamo" when RISCV_ISA_ZAAMO is enabled. The
default build therefore needs "a", or "zaamo" together with "zalrsc";
a kernel built without Zaamo needs only "zalrsc".

The legacy "riscv,isa" fallback keeps its rv{32,64}ima check.

Once such a hart can boot, hwprobe must stop telling userspace that
the base behaviour is IMA regardless of the hardware: report
RISCV_HWPROBE_BASE_BEHAVIOR_IMA only when every selected hart has A.
A hart with Zalrsc alone still shows what it has through
RISCV_HWPROBE_EXT_ZALRSC in RISCV_HWPROBE_KEY_IMA_EXT_0.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 Documentation/arch/riscv/hwprobe.rst |  4 +++-
 arch/riscv/kernel/cpu.c              | 23 ++++++++++++++++++++---
 arch/riscv/kernel/sys_hwprobe.c      | 23 ++++++++++++++++++-----
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index bb1e0cbab36f..63d7ef028bf8 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -61,7 +61,9 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`: Support for rv32ima or
     rv64ima, as defined by version 2.2 of the user ISA and version 1.10 of the
     privileged ISA, with the following known exceptions (more exceptions may be
-    added, but only if it can be demonstrated that the user ABI is not broken):
+    added, but only if it can be demonstrated that the user ABI is not broken).
+    This bit is clear on a hart that implements Zalrsc without Zaamo; such a
+    hart lists its atomic support in :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`.
 
     * The ``fence.i`` instruction cannot be directly executed by userspace
       programs (it may still be executed in userspace via a
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3dbc8cc557dd..9ba0d49c87bc 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -82,12 +82,29 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
 		return -ENODEV;
 
 	if (of_property_match_string(node, "riscv,isa-extensions", "i") < 0 ||
-	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0 ||
-	    of_property_match_string(node, "riscv,isa-extensions", "a") < 0) {
-		pr_warn("CPU with hartid=%lu does not support ima", *hart);
+	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0) {
+		pr_warn("CPU with hartid=%lu does not support im", *hart);
 		return -ENODEV;
 	}
 
+	/*
+	 * Require the atomic extensions this kernel was built with. "a"
+	 * covers both; otherwise LR/SC is always needed and AMO is needed
+	 * when the kernel uses it.
+	 */
+	if (of_property_match_string(node, "riscv,isa-extensions", "a") < 0) {
+		if (of_property_match_string(node, "riscv,isa-extensions", "zalrsc") < 0) {
+			pr_warn("CPU with hartid=%lu does not support zalrsc", *hart);
+			return -ENODEV;
+		}
+
+		if (IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) &&
+		    of_property_match_string(node, "riscv,isa-extensions", "zaamo") < 0) {
+			pr_warn("CPU with hartid=%lu does not support zaamo", *hart);
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 
 old_interface:
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 7818e1d32622..52c4c2085d0a 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -213,6 +213,18 @@ static void hwprobe_isa_ext1(struct riscv_hwprobe *pair,
 	pair->value &= ~missing;
 }
 
+static bool hwprobe_all_cpus_have(const struct cpumask *cpus, unsigned long ext)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		if (!__riscv_isa_extension_available(hart_isa[cpu].isa, ext))
+			return false;
+	}
+
+	return true;
+}
+
 static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
 {
 	struct riscv_hwprobe pair;
@@ -306,13 +318,14 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 		hwprobe_arch_id(pair, cpus);
 		break;
 	/*
-	 * The kernel already assumes that the base single-letter ISA
-	 * extensions are supported on all harts, and only supports the
-	 * IMA base, so just cheat a bit here and tell that to
-	 * userspace.
+	 * The kernel requires I and M on every hart, so IMA holds when
+	 * every selected hart has A as well. A hart that lists only
+	 * Zalrsc boots on a kernel built without Zaamo, but it has no
+	 * AMO instructions and must not be reported as IMA.
 	 */
 	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
-		pair->value = RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
+		if (hwprobe_all_cpus_have(cpus, RISCV_ISA_EXT_A))
+			pair->value = RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
 		break;
 
 	case RISCV_HWPROBE_KEY_IMA_EXT_0:

-- 
2.43.0

