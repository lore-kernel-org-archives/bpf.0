Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316982;
	b=uPSTIAkVLZbmUquDrEWGTpfjbHSXmiDnoqh3uQuGNtppaaGOyrjtPCrdmrWTHG0eVlmO
	 faHNDpmx2RTOLUSm4QFdnpuSKSMliBL6x/JKjk7TIm3ihEKb7dS22hIbJhN56Rv9cg35L
	 0aUUZmuE6Gw6xRiB3i+ayNbk1OJybxpLneYm/iq6X5xjmVlL0Djiw6ZHeBEhiLwIyFpIn
	 5VObIuWB8mWTRh4c+FZ2K/VmRvva+gh94LZhKwdbwkbuYTGreeA+Apl0rTs6hI6CRjgng
	 spvwhl82p7ee+BpzgPUcX3ojrRcH/k7IPZRIYdHDQcDDPUJYPQCbnB/MN1rrYPrnSRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316982;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=y2cdaINOWN6BB46Q7wwKG1TihseiJncktr/TfMMhw0g=;
	b=k2jabjiCepLJFiiC4sOfZiSmTvyuEKW8iam3StOCkfccbK3a67oR79rX3fiwyyaYcv/Y
	 NzZe8w9Q8WRBCIUSoz/RGtRnFa0+TCKUFJoBMk6g7ymtNfGhaLQ9MjDP2ABBMUPzGEaYq
	 VlWWULTI2O4ReL8bv2o5XXO4AXYeSK7at7hvSJJEbfs5XuYQDzU3vI/O2YfUfLGaeNmJr
	 ccHPvZ4a+UpuNx0ZDogfy3EMMsahP9urLZsZjWFGXTPkzrIgpe4ZFP4tihhbBEK2dRL+D
	 iCJ8T1vuwa73LdXjdlk5E1a636dvfFDx5nQAVR10dXHKfSaiLzbfk+cJdQsGQg4Nbuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A860707AF;
	Tue, 10 Nov 2026 13:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419A860707AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794316986; x=1825852986;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Iv6D6e7CRfaO746bD1hJJNYyxNaP1nv/4CHWfaTQ1+0=;
  b=Rz4my6uW4QPG75pjdXoRmyED/zqLaRQa6Ka0VRS7UPvCfMk+oTODrJs2
   uAWfHstIivZLK6rXpNhtGT0m7NkaWdfusnW9rp3eNZINvFiwWsfO9GQWo
   msacSw1r6pNr4ljHgywRetMZF7L69Iisbn8lBVAo86kxceTCyabOxDyz2
   X5UFTKYIPetG0gkxjf7clJkLdlarXQ4lmkpOdxolrN4AL6eKxHQ82q8Rp
   rlIqw9kNRfJkOEQqoiGKnh7fGxlCvvsNl7NzF+6ag8xJ0DMfXjmfV+07Y
   EE53sv62g3cqRXFME1nHEjpE9tkWHMl7I7CoZeA+Mtt64wxKp6q3UBEeZ
   Q==;
X-CSE-ConnectionGUID: K5U7yhEJQkKn19s3N8BCXg==
X-CSE-MsgGUID: bVOdbvznQCCogYHFmGefzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:23:02 +0200
X-CSE-ConnectionGUID: lg/nxsEvSIea7AHEBlpmmQ==
X-CSE-MsgGUID: BAkxBH2aRMW+u4xpuWpZ/g==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 10 Nov 2026 15:30:50 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:22:54 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 10 Nov 2026 15:21:00 +0200
Subject: [PATCH v6 3/6] riscv: accept the atomic extensions this kernel was
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
Message-Id: <20261110-lrsc-only-v6-3-bafc3cc0fcae@mobileye.com>
References: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
In-Reply-To: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
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
 Randy Dunlap <rdunlap@infradead.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir.Kondratiev@mobileye.com, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, 
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

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/kernel/cpu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

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

-- 
2.43.0

