Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1D345EAE
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787192428; cv=none; b=IH663NdZvH9F5gyJscvntjsVZGPIN69TzVS6qoeRLP2R/T+iKqAXZsBcubMeCufNwFZMkLWS1HKIm6jAQFRZQG0oBWYt/j+tyVlvLHfVHRis40eWAdH435UUYsJp07FQokk5Aj2ay3DLAUFFYAy7+MwrG1QsZoMtD1nylD9PKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787192428; c=relaxed/simple;
	bh=w7vSsl+j+ceETVkMr6UCaRTi5HL/x2+87xnZGAxVWhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB7d1+wE5mAQFQiEuWqgcneQT+/oqIfiojMBVoUc7hJvSAsfrazNX6hzDzAgBvYsBt0OAE9l+kgWebiWk25ad10tQP6xYGZDXDyHysk5zqqKCSH/xxZXok5W/IQXRcuVSP51Zv0NVlWJEwFp283Te5rJDlUoM7kjdUO4rJcH2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLr9JOqG; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLr9JOqG"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so6160145e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192425; x=1787797225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldbZsclDL+rBn43k0zoIvCSDotMjePyywOw8n/SAt1U=;
        b=pLr9JOqG9aNjop6rnIt3xlFfRBICebkoqyc4yZmexdhYdiHrTdwcOK32XMshlo9PDw
         89weZJccngNee4ta20/OgCk7cMWd5SroiCry8Cz7TankLEbb+kNtu0uk8bBOdqzrEqqD
         GHpNDTPUcpAAKjnnHlltWW0RDDdl0MsAZvym8QLkMzVXVe7kXlLd1ARQaF6j+cK7Txx4
         IGeWD/KaUUO/27yH4AXGRTwi8EtSNL1tklO5p6zVvZrc2j7XLiy5fj2WY0X+wqza7+iY
         jXuILglcJ600JTVX7Jsv9CK1fNgX6DmHl5uu03J99H78B53ptXaij2MRB2Se6ilomsDD
         Sw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192425; x=1787797225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ldbZsclDL+rBn43k0zoIvCSDotMjePyywOw8n/SAt1U=;
        b=TCMo21e1k8g6xXWlUDo3StaCUQeXfr1k8PvQsNk0Ou7y3Z63EoypG+IXILqElevPmo
         BQiSxMXpvQc7Vu//trxt7cgFi18Nu6s77TaJD235GaD/sJl6VWvIHtAbQu/66v0awEYu
         Y3why032igw6eR7L+iUZeHmJTMbA0rhAMe6ZNK1eMOdqV5xmg/4WDpp63UOl1AMixwrX
         G9vQibaBHiVBJ/+QCdGby2rjlveaY2oAB6wLY1LMIRQUkdrpcugDzI3od1jeCwEA6QNj
         6top8WVQr0Tg+hmqWr2gjxaTcldRgsR5qqQh4//qsfDr+oZd74VMq5Qwa5QPDhmEp3eG
         21JA==
X-Gm-Message-State: AOJu0YxtqpGs7gCK+K8HAShbQ9KyyBD0JtZy0R5L4SQyk6XSxdM6SDxu
	w2twxBMNLwF/p/eIHWB8ewKXm4RCFYnPvoQT2YWCEq9+ZYLxHNfbvRM73RbYCCoi
X-Gm-Gg: AR+sD12MwpMsCOGZSanxyiRKchzE8FuCb3Duc6i5q2JXvRMKUXJVI0zHZyyY+K2pV49
	NO6PJmG4zZeIviV5kyQmqS41hXCJLG2u/FcOpVZImyS92s7KiuJQZQLoYZ2/sctkn3iVIvuLJdL
	T4zMDAYquZYmcT9oJlVAJIKhpGCG4xT5/6L83oDNXuQZ+MU3DKI2hVf93NwrBXpcNFjEryaXriU
	7+tkGE7To7R3jKr0/4OCtLel2WLuK7ncD0ZpsAxOZLU0fJlWr6aAKf3oI0IxxdIFK998prW2tg7
	+dA5VXUzxRhS7d1zReUbzTS+fDsj7B1XCdr7qsoCi7+AV4XKVMeBbAuiSSvWbrK6OtL52Cf+M0i
	RFlsOYJgO/NkbrJR3OhCAowkioxNdjiUdO1sXDjoq4dGDfXj4gf9PfQ7uEixTl6sK/3KROBd84m
	faVlJKY3F5FYaUjYhwbI9NBGg4arouq73MDyyHEUSLVfblPem2VfTFuPpj89eH12frTHv9967Au
	Lhtc9Cdbwo/kXRIXrWOMUs82aNshCysx8rKULadHLnHbQQtqbxn6EGVip8XPtDfVYuwZsc835iy
	O1hDcB3wCu/7THpdY4Fuid0n9g4=
X-Received: by 2002:a05:600c:4e94:b0:499:78b3:7b36 with SMTP id 5b1f17b1804b1-499aa1b549cmr153560145e9.11.1787192425206;
        Wed, 19 Aug 2026 19:20:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa17fc80sm114839305e9.14.2026.08.19.19.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:20:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test invalid DW LDSX diagnostics
Date: Thu, 20 Aug 2026 04:20:19 +0200
Message-ID: <20260820022020.3450479-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820022020.3450479-1-memxor@gmail.com>
References: <20260820022020.3450479-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=memxor@gmail.com; h=from:subject; bh=w7vSsl+j+ceETVkMr6UCaRTi5HL/x2+87xnZGAxVWhw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIastRWtd9/v9zB8eZV2L2TdnutqiWA49P/PsM+4/j7RZ/ 1o14f3HjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzE9DPDX5m9e2TviH4wXv6g fJ578mpWU1tZVa2ury1aS9cyB/8UmcLwv/g613OZ/fx5ZxPSWha7HFTkemhdfD0zb9GX5Xtfljx bzA0A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

An invalid BPF_MEMSX | BPF_DW instruction can reach Program Structure
diagnostics before opcode validation when placed at the end of a subprogram.
Exercise this path and require the disassembler fallback so table bounds
regressions are caught.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_cfg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index c1f55e1d80a4..3c3bb03e8217 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
 SEC("socket")
@@ -55,6 +56,19 @@ __naked void out_of_range_jump2(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("invalid DW LDSX instruction in diagnostics")
+__failure __msg("BUG_ldx_99")
+__log_level(2)
+__naked void invalid_dw_ldsx(void)
+{
+	asm volatile ("					\
+	.8byte %[ldsx_dw];				\
+"	:
+	: __imm_insn(ldsx_dw, BPF_RAW_INSN(BPF_LDX | BPF_MEMSX | BPF_DW, BPF_REG_0, BPF_REG_0, 0, 0))
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("loop (back-edge)")
 __failure __msg("unreachable insn 1")
-- 
2.53.0

