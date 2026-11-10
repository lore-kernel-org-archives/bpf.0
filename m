Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316987;
	b=qnHrHA8VszadEl+t+T/IZB5x09eP1jpUsZBi6DFngWOBeeQ1Yj7oUA+8b3g+92t7bYve
	 Cqr3mPehesMBMCSBS+gs1gi1J34cWlSlQ7DUSZ+vNntXCI/XZwEUrjX/TDKFPRSCVtloM
	 Hj99aXaRIaNDMTXJLxBLpm+iZMqMApVM4qV1PsCQCggeV7aSzG23jVGFlh+2Rfuua+gJH
	 aq/Hk87OgfyDw57q10QTcpDeZgxggbggQK6Mf5iLvVtavweXYcboTk+cEqUnYAgQou51z
	 MbQEI2zBtdwVpGNnWFdHrNmXM3Dh93kOC+qodAwbFsFD/yxN68GrV0AGHZt4Bsp8M9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316987;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Hc+GRQf85ac47RtK8OhCLnptL/mAmCv9Je5+UXZVi14=;
	b=c5UVRKNHTN5ENJKOZEdptXzevkS5FzRZKyUqzKIdvjBxL9W2UvpVuzE09qL7xP12ely8
	 VQsuqdyug4Pt0tt2G+KN5HaObF/VwNgPIBW1j6ufLuR/rZsyDgh0FJA9JlTuzLYP529yO
	 M5J/Dl1DeBGpqFNQXmZbcFPFt57cZRbtycaQlfjkO3tgbCTAxMp272jmmDD8RMnfQXWy7
	 twdps/9KOwRvoSw4pNI+DSiD7De8Tyf6xT/yAPwxgJWsw2WFM1XRt07AgF2RR82jnVFon
	 bzwZUOFSzBdtpC5kbIxBP+96peY7UBZVs92uQinZsaJH8Xrrigq77eZ2kFSSrnuKRcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBFD60707B0;
	Tue, 10 Nov 2026 13:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBFD60707B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794316985; x=1825852985;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y2NXF97jr/EMfkddUR0y1/iyEyI2iou2lHNRhWG3x9A=;
  b=BVbxL2/4M4eomU1Sjeq9WL+zmkVEEkacHNFPzH2u6lgH8X4jER64I6Cz
   9nwciDSv07ijGu6Cc5+ILWU2B19wqgTYtgbltaVkUuY8o3vMnyb99VYvZ
   sk5LsJb2CQQaGDanwpRCYFwbsV/m5d3GYO1STL12+f9l0p1PH32fA/fbw
   m717eSw7Ae8J0PoCHGPNFuF0VDC1OmIVysB2eOKpRdrXAVPbidWWJ8rN6
   8XkWyR8DVhEy3hhVARJQNphLv1Og2fpdVp4S67xjm94vMdl2Du7kHJRfS
   MyufEeL+ZdEz3YuozxEqRh6BmdNRiClvVqk3xgmgZ+XQx/6osEO/XEA2h
   g==;
X-CSE-ConnectionGUID: REa7wYvdRtuMLxsABJvMYA==
X-CSE-MsgGUID: LOBt8zMxR7enOPw+ALv2zw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:22:57 +0200
X-CSE-ConnectionGUID: 5lgapuKbStevd/1P3rB5Nw==
X-CSE-MsgGUID: bPrAPu2RSmS2u6zv5LYdbw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 10 Nov 2026 15:30:59 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:22:55 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Tue, 10 Nov 2026 15:21:01 +0200
Subject: [PATCH v6 4/6] riscv: report the A extension when Zaamo and Zalrsc
 are both present
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
Message-Id: <20261110-lrsc-only-v6-4-bafc3cc0fcae@mobileye.com>
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

A hart may describe its atomics as "a", or as "zaamo" and "zalrsc".
The two are the same thing: the A extension is defined as Zaamo plus
Zalrsc. The kernel already expands "a" into both sub-extensions, but
not the other way round, so a hart that lists the sub-extensions ends
up without RISCV_ISA_EXT_A. /proc/cpuinfo then shows rv64imfdc... and
the A bit is missing from ELF hwcap, although the hardware is the
same as one that lists "a".

Set A in the source ISA bitmap when both Zaamo and Zalrsc are there,
before the bitmap is resolved, so that hwcap and cpuinfo do not depend
on how the firmware spelled it. This covers the "riscv,isa" string and
ACPI as well as "riscv,isa-extensions".

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/kernel/cpufeature.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7329792978cc..45684e129be1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -682,6 +682,15 @@ static void __init riscv_resolve_isa(unsigned long *source_isa,
 	int max_loop_count = riscv_isa_ext_count, ret;
 	unsigned int bit;
 
+	/*
+	 * "a" is exactly Zaamo plus Zalrsc. A hart that lists both has A,
+	 * however the firmware spelled it, so report it the same way in
+	 * ELF hwcap and /proc/cpuinfo.
+	 */
+	if (test_bit(RISCV_ISA_EXT_ZAAMO, source_isa) &&
+	    test_bit(RISCV_ISA_EXT_ZALRSC, source_isa))
+		set_bit(RISCV_ISA_EXT_A, source_isa);
+
 	do {
 		loop = false;
 		if (max_loop_count-- < 0) {

-- 
2.43.0

