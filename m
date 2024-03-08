Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AE52232B
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860137; cv=none; b=iNA1wRQYhczRK/YXfd6z0kUvupHcAmN/iijHqKS/sl3q19jNJkHEAfXh8bMOM4ONK2s7Etz9Gt/SPcvBvf/1kciHHfAGuSm4XMdlrT3RLIfUlgxqO1ap6J0+jTHH8LY6Q7m9E+0GzuZMXyen5Fmb73ip+PbJvHZq2s4r/zY/BRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860137; c=relaxed/simple;
	bh=sBdO3xF/zBU3R9udtj3XXU5fDcAg4JZkNvzAs/OGOCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdjBkrNuookU7M309T7YB9GdbFm1hADMmq+qXUTzwrS26MprVw+OwJQ44Eqe0z8ovx5mvMkOu84Q6H2oShYc3E9fukqg1PKj2qYarZo869DP/GDJJtqf7UEtoBXiXItv7O0ml7LbWVSeCqHF1lovsIXvL+/DdKvDCDd8g7aiYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahK7WWlQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahK7WWlQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca160163dso2574665ad.3
        for <bpf@vger.kernel.org>; Thu, 07 Mar 2024 17:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709860135; x=1710464935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY/F16mIRVOasuBIDKCOT+6tHBoD4McdBdkvkV719K0=;
        b=ahK7WWlQEKAGWh4dQ5q9VsuN/sD1HrwfJpH3SRbPve+70qALgHdYbYlz1hQlpBuqwJ
         FtdSpvl9Bb5WTBN+rnKxUlbrhk3iKQhihHsnj9aeDZRQtfKLB+WX4rezcSRa6l/ey97p
         f1Jh/3OlUIvEqdIMWOFDCYhf1iYGxleVFNJsDp64IlbxNrWKGR9e9WOjFPWsSwFHMzsN
         3t8gsqPyqDdSUsn9HsQqdg96aJIDxx10qhorWdpku4D3Y2zz3sewEk3iFUJ8ykmyqzxo
         97SOE1IGRIURxgy/M/id7GyEQpkXWWD7B1NQ7FdBw4Le469SFsEzPVIW1nMxMc5l/Jpi
         NRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709860135; x=1710464935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY/F16mIRVOasuBIDKCOT+6tHBoD4McdBdkvkV719K0=;
        b=eBZIK+5Q3x4sJ9Qv98ppLhFafxuQoKjAvi/wdBjZqnZpzOM1q2IB4ahRk0FTtJB75I
         R3VXNtIfC9Cr0T6DFi7hP1uG6Crh7uZEiYEv1jAw+hpQc1IGPXw+PRhWr/7nrOaNzaVf
         xWezjLv+H5V/8C13vP6h2ydZushSkWjGhw4WU7CsXD/55t2T4VkASWlCKtcPAL1YhIu0
         mMCeeYcr5ZQJyVGyoTk0q29H5JyFtPmeDO6lWcjSYx9FwXEzvxD9J9w3WLtjo0LrpGt8
         oOW8oUC/c/au1S0tWZ+awc2t8MCOh7J66kQGio5ZIgL4d0eNIAqwRlaev3cxECiAw9I+
         AWRw==
X-Gm-Message-State: AOJu0Yw0dpPQULtKmtsvq4DjIsAJSvVpndYUyf6893eBVoBqs0P0f0Nz
	Y34jJtEFZOiVEuKjHH3whC0E+PS4fxlDraidft+gKO4omSHZURhzRKclcuiU
X-Google-Smtp-Source: AGHT+IEWFfgDbiPyPpjCyTYluBMUWMicvAov1vS/S70/NNvOG0O9g/+u39VNVA1PkSDmuLHqgwejNA==
X-Received: by 2002:a17:902:eb4b:b0:1dd:6263:62d4 with SMTP id i11-20020a170902eb4b00b001dd626362d4mr1877271pli.3.1709860135228;
        Thu, 07 Mar 2024 17:08:55 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:428c])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709026e0f00b001dd4bc67910sm2241108plk.79.2024.03.07.17.08.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Mar 2024 17:08:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	torvalds@linux-foundation.org,
	brho@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 11/14] bpf: Add helper macro bpf_addr_space_cast()
Date: Thu,  7 Mar 2024 17:08:09 -0800
Message-Id: <20240308010812.89848-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce helper macro bpf_addr_space_cast() that emits:
rX = rX
instruction with off = BPF_ADDR_SPACE_CAST
and encodes dest and src address_space-s into imm32.

It's useful with older LLVM that doesn't emit this insn automatically.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index bc9a0832ae72..a5b9df38c162 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -343,6 +343,49 @@ l_true:												\
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
 #endif
 
+/* emit instruction:
+ * rX = rX .off = BPF_ADDR_SPACE_CAST .imm32 = (dst_as << 16) | src_as
+ */
+#ifndef bpf_addr_space_cast
+#define bpf_addr_space_cast(var, dst_as, src_as)\
+	asm volatile(".byte 0xBF;		\
+		     .ifc %[reg], r0;		\
+		     .byte 0x00;		\
+		     .endif;			\
+		     .ifc %[reg], r1;		\
+		     .byte 0x11;		\
+		     .endif;			\
+		     .ifc %[reg], r2;		\
+		     .byte 0x22;		\
+		     .endif;			\
+		     .ifc %[reg], r3;		\
+		     .byte 0x33;		\
+		     .endif;			\
+		     .ifc %[reg], r4;		\
+		     .byte 0x44;		\
+		     .endif;			\
+		     .ifc %[reg], r5;		\
+		     .byte 0x55;		\
+		     .endif;			\
+		     .ifc %[reg], r6;		\
+		     .byte 0x66;		\
+		     .endif;			\
+		     .ifc %[reg], r7;		\
+		     .byte 0x77;		\
+		     .endif;			\
+		     .ifc %[reg], r8;		\
+		     .byte 0x88;		\
+		     .endif;			\
+		     .ifc %[reg], r9;		\
+		     .byte 0x99;		\
+		     .endif;			\
+		     .short %[off];		\
+		     .long %[as]"		\
+		     : [reg]"+r"(var)		\
+		     : [off]"i"(BPF_ADDR_SPACE_CAST) \
+		     , [as]"i"((dst_as << 16) | src_as));
+#endif
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
-- 
2.43.0

