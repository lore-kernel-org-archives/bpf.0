Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019062;
	b=QYRhaLeGAdOLvS7wFKChSB3Lg+Gy6ppg3Os9pUcBXcDDexsXlRF5KqD4H9B8Uas7NH4r
	 ZGYEudMOpkEtIXiSkF7eoLbyDvz4ITIj/MuSuaEA45WO09C4hgzhJ0xXhwBF7MOzsq5jv
	 OiwFEcMoEb4GEikwyZittsnvwE7DAmauKLfKfYajazagu9Y8YjvY80GJRehrWxdMyG8Zk
	 OhEo5mYqLFwJFjNSFvwl1TWNO04S+x4lz+S9AmfknbH6rv/tHVMddxg833+TzTiiAJCc1
	 zPRb6R/yThXWDb9j6e57MiJxgdxcZwdi3rS6K36+z/K2D+HNqAR6KN1Nd3VEPaL2Q2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019062;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Hc+GRQf85ac47RtK8OhCLnptL/mAmCv9Je5+UXZVi14=;
	b=ntB5jeLTD9/zB5D0VFnDGh8C3puj7Z0OjAIhKx+2Di/Ya9Fa+u3kAGqtReahkMQttkun
	 R2mOgGFSYX8DpIifXOduosrNwUUIrHjvI8K5OZQ3D0+aeYlxM4cTB9ij/7XU2X4WYHE0d
	 h3mtIlJUUvqvjkd3hEGXtrVHoAcrViWmiFnB0KOk78Mg+FRArR5CYOQCHz+WOdu/lL+wJ
	 etdN8klwLwEwyMQeUnv1CijWj9OFQofkMrgB1YldLEPRYM54W8lSG/pnNErZ5M9M2/NaS
	 uga2Gbg/Zlw3SleNtkCL0jo6cz5/oFfkY+JoELugMbAjLnS33lacahVyw8kNNajJOcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C1606A331;
	Wed, 18 Nov 2026 16:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70C1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795019061; x=1826555061;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Y2NXF97jr/EMfkddUR0y1/iyEyI2iou2lHNRhWG3x9A=;
  b=fXKb9ZETq50qYrA1FkWEuwVIfeL2pswvIG+CTWT+97ZQvsRn2y2LIZUu
   PTnJTHM4c1ObCxQigQV+NzhcCpbFHyZ0EUI/knt0YmmlhyU01C5uS9GNm
   9WfobxJfBUIx7Hzk2YTFY13KQot8Kpp7asgqMifJ8vqsIXsRikRvtWRqy
   pvGx5jR7Mw+MrXFxb5TBOZlP8jKQ8YvZKrBOebVutIiUfSaGt2WnbIO9s
   cPDsL9v9j2j8i4xqjl2lIlwiaFx3LykH12pIwsnORQ/Sq7LUnD2iY4ecl
   sfXdPj4rMGEiz0afNJPSXida6LxfByalKJPXF1Zs4iT+eVEcZAkXr+Ugy
   A==;
X-CSE-ConnectionGUID: hvdSMKaJR56I2tA7APiISg==
X-CSE-MsgGUID: 2iwMGUxQRsi1E5zz/LHXQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 18:24:12 +0200
X-CSE-ConnectionGUID: knD40QT9QMWt1KzuzQos8Q==
X-CSE-MsgGUID: eHI3YtK0SuKlMyZPPZY9ow==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 18 Nov 2026 18:32:25 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 18 Nov 2026 18:24:11 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 18 Nov 2026 18:23:59 +0200
Subject: [PATCH v7 3/6] riscv: report the A extension when Zaamo and Zalrsc
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
Message-Id: <20261118-lrsc-only-v7-3-602dcf4c1921@mobileye.com>
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

