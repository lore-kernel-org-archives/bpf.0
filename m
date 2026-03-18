Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC199481B1
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842537; cv=none; b=czGOo4fi+CtNpbyCzPAf2sSxZzFHQuwJ8JfDmPRfO27cCmU1EcBDdWof8Nm0wayCEXJuprxCaKsXKICzTpKQ/0CnTn63lwxu4CoEHbR3Lz4CpZQyXOj8hHz+iBVCNT2SaED5bRPD6/8NhdAJjpmMRamf865BbpXJSLln6keVFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842537; c=relaxed/simple;
	bh=iz0ZAbwEawvgCtvmXc2W5cJSFXLskeT3GkIN2rECp4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o65mx/B8K3366KkE2Z8vQTVYjMx+D29nRiKRo0Tp9cj1H59pmEBNuk35HOBbOn6g450tXiJNGpQJVWm6pIby1xU6eoSKDrrAjIe9zD+NkZ1+LMFwv93r5rupwOaXmvqC09JpzNURxjXJ9Zx9eG5C6GlSRru0g3Dl4tnkGS5cTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpFMIWT1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpFMIWT1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b97b333673eso487712566b.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773842535; x=1774447335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7btX0GGFPxC/r84KvfOxADOP7miAAaMIh16jG6yz5E=;
        b=WpFMIWT1k38qR6GHxpwxq/QkJRCWQdeStmx6S8gQkQi9YECJp1eeoVQMsL0mwVmo6V
         BBZR32Fz5z1mqJ/JQ4NgMsbisoReSozuMeicFzV9lDlW0FxLpI0KvoS1T1+tC4j8HXRm
         56+KgGxw0/Jb2G9w3WckMyDS+yDrOPn9x9FeueRhYjyu2DHId1jDIteqXLOdp9t0op9I
         xQ+VWY6GavEyWyAGngANELLXKVR8Az3d8bmwUNwiKbnADvhnrLrLwwsRgXZvfGH2hqdr
         JMTx9kD+dU5y8ERTMjOAtv981LwEedMkopC3mINf9V2Hy36CIgR/YkroPCUPnesMaXWa
         ueKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773842535; x=1774447335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7btX0GGFPxC/r84KvfOxADOP7miAAaMIh16jG6yz5E=;
        b=SBp7GraIP1W/3X8Rn0XCL7pv7fzwr6aeJnTPyrxoTqGK18XN0KN9oGZzQSvIdnt0GN
         Mftzvj+Kap6A9ggKQBPdib0JUtdNar081608TtWu1RG68BANXGRP6TknPqVAI9/0H2UZ
         qjDppnzP3sKbL/0+ovs5PCWQvtW4S8v0mHDuMSPrxypuVmlZBMJCwqnSlkS5wJKaav4r
         EYTkKpRv4hrjZP05MBjSkt6OvSZsnVILxEJD6ITsRD5pAwFB3bWDMwuElyy5bZ9pRt6v
         jEddl0fXCIUfe+UcFBYbwsALIkV+pth2wOSXdb49N6aQOPi+mkS8op4UDX80uKiATSRh
         BoTw==
X-Gm-Message-State: AOJu0Yx7s//DMNAilWkF+Mz/UFIYqmKpgrXYDSQlhHPOYLgZ+5kZ1H1h
	fB3M255niNq3x4icI4L0SWk9RLFvyTAzskhFnZ254BosZhoUUZar672Z1A3PIIc=
X-Gm-Gg: ATEYQzyWFZS12+SEvqyklFaT2rY9wJNhHOrTpXIrCoCpahwt2hjadREJ/OPfs+QrNE6
	98OZsjqM9DthCKBQOKLLx0Hnx5wfEtgqe/f5MUyGl5idiHhwraSr4NNyuOwVd3kA/rYzrtgr6BX
	ngjKpSF6qhNV6REgYl3Q0vLDI373w7wnRI/mbFESEM6pELCy5rKjdX8rN54EA9rR8O7Xjf+oJoe
	SZ4UX8jkwJP94kIJK24pQScJTEZt8aHomG321m97N3T+J61DjPFq9OShh8bdynAFCWrQ6xdGV2Z
	QQheMSOPtw2XXUps1j1TDiHEiFEkvC70hXqdgcpuzKQKtLXVtfpSRoBtzRrJ4Hup3rjMM/PsFx5
	n0iovaMYZSMovzcmvKokz15V2LXvY+gIw6iA1r+2z5NtycXGtTKRYH9/LSFDJrevbnJrSJ8Ii+n
	ZwkHnUqpJQLvbKtg==
X-Received: by 2002:a17:906:8314:b0:b97:99e3:ecd7 with SMTP id a640c23a62f3a-b97f4909431mr169814566b.24.1773842534459;
        Wed, 18 Mar 2026 07:02:14 -0700 (PDT)
Received: from jacks ([197.38.173.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892244sm8683606f8f.22.2026.03.18.07.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:02:14 -0700 (PDT)
From: ibrahim zein <zeroxjacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	ibrahim zein <zeroxjacks@gmail.com>
Subject: [PATCH] bpf/btf: fix u32 subtraction overflow in btf_sec_info_cmp
Date: Wed, 18 Mar 2026 10:02:04 -0400
Message-ID: <20260318140205.1887113-1-zeroxjacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function btf_sec_info_cmp() uses direct subtraction
of u32 values cast to int, which can produce incorrect results due
to integer overflow when values exceed 0x7FFFFFFF.

Replace with explicit comparisons to guarantee correct behavior
across all u32 value ranges.

Reported-by: Ibrahim Zein <zeroxjacks@gmail.com>
Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
 btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/btf.c b/btf.c
index 4872d2a..5b3e1af 100644
--- a/btf.c
+++ b/btf.c
@@ -5548,7 +5548,11 @@ static int btf_sec_info_cmp(const void *a, const void *b)
 	const struct btf_sec_info *x = a;
 	const struct btf_sec_info *y = b;
 
-	return (int)(x->off - y->off) ? : (int)(x->len - y->len);
+	if (x->off != y->off)
+		return x->off < y->off ? -1 : 1;
+	if (x->len != y->len)
+		return x->len < y->len ? -1 : 1;
+	return 0;
 }
 
 static int btf_check_sec_info(struct btf_verifier_env *env,
-- 
2.51.0

