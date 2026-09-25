Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC2472090
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324912; cv=none; b=G1vjghLBU1Dcgz7ZQCSGpDdTiWpexy6T01O113KlbJpHFjywGixDfIXwMMsz85ZodhbfE2NY0+ITRC4omib7/11/6IBFZJyxou9MEcHe+TSFanERlEznwVdHnF837pRNwDlNbmgNvGjefY/6zUG/ljnN7rBJp013E3yrGTJeXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324912; c=relaxed/simple;
	bh=KHNLBWYb3Agw7rp5Zo4AMw6jvTmqV7B0MMc5VXWKygI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxzBwlmYulZhzuKdM0zTLIpAkyHWkNP0Qs6g1Tl0sXnoPTLdD4E+IwV4wT3XEzdMBobiF2GIcacJmn8PPQxHOlDEHqXk9zQY79PgoZOUPogoP/C7qerycvqPNEqnxOaJhkW4InzM+dl83ZZCDmGVQV56J3gdriiTfdTd/tCdfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/GszPIW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/GszPIW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so4204045e9.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790324910; x=1790929710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQ3tW+/KlCuB42+pkQvUxoLmJ9H4mJ7fHt/ahNQpmBg=;
        b=M/GszPIWVOb0+RWzayv0yw5Fw8faIoE+QFtoOcU135DMY8ojUnMYVyoSCXYjDc7yBw
         YhcJ/AuIW9ALjQu8ZhUu4bB7JD9K/wxyYPjPu/nOVx+8xJ7oJ9JFE1ees5/xT38g19MS
         g+t8j6H1TuB3tTm8J/+f7rM3ryttrs9Cjq9TffZ4lyrHmylOBotQqUv/RGOOnbBMqlKr
         qVS22DQAf0ngXPhYyWao5AU11SJFY3EKP87+NScgP+XUPFccPZz9lD/rGnQGylx2/L+N
         XArYUHfleAOLVieH0X/VOgTJ2iWiQNvmXatlkvHgBevOz5tawNvvUVrPD7v8QzoOyBWJ
         HZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790324910; x=1790929710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nQ3tW+/KlCuB42+pkQvUxoLmJ9H4mJ7fHt/ahNQpmBg=;
        b=0Pf7Yr0UHVCba1iLXLnC5VzWxG3wdHuJpWC0v07wcxfrgRAWEZjK+WeYUPMeQ/yvD6
         PUF2ZuuN0vIybLPMqZh/nQRhLevJaCwoeXtNfAczH/CbAviOQHKNKhbpg/EyexshF/Sm
         l3jq0Qp4tcJBBu2FiCXGo5Il2IjKxeC3yJTBTN0n3GnjaU0LaxGCvp7zP+tHxKPdAWe0
         uhhVWzLHDlBe/6q7D5wDUKiNcFpuHaW5/EvuzvJWoZbm06b8pYUumpBcDZRsDb9/6E6i
         wn52i+llF4CW/T/BLtNAXDqTTC0SmeIkV6AAl/5oGaGJ7tIMaPesiWC3AP2nBzBpu9XQ
         /lEQ==
X-Gm-Message-State: AFuF++lHtig7sF647O5eBYgzZDanvgtGtHaXkaysL6K51lAyE1PhUSQT
	0oTjokaSX30uy/4KoFPkhvizcOpm0AxbGomLkikPe06XVkK/2UGS6H61WEMj
X-Gm-Gg: AYBFou1KM6w7huNz4u+19Efqp122emXdwv5ElX75BUfBZO0gNucNTD6iS5pblL0Rbtx
	qUXzr0BI/NkygnQmmLfMJ3IJzYVlSwXyx6nerVlsUj6Ayg5PjQFah4it9W77O1SGYisYkZeZM3G
	jD4lNd1+vMh5Pa98mosJEFnjQ4HFMhXDv7UVZykDGCv93OwFNQ90175JBlZfP1oZiL/HX37f4f+
	5sc4NmZohX/oRtjiTjEa3N0g59ou1Pp5jbbjUgIJ+UrSvmrvzPe21fu3bSh3kiZklkJUKafpezL
	mya5HBceJRNflNoq++keCRFp5PrmMF+NK7Mz9VdJnL8lxHfw/VSey4Kc2SYA2hJ80AGdewakFom
	DgZW5mc/f70F/GLSfheFqqdqMS9PIor3twcRWw46vtH2/SsjIOSguRZu76jNmRt6kCXokDZZX8h
	VZbbRvF2WPLC+y3bNgEZ8W05j4zsHt195KurFzrg1D6cFapzqq1Gv7+DT+Ru6cbjJs2GvoToUWw
	gyVhUdW4SJwdIUousKlbtTVxtXKrq3DylUNdE+XOLoSH+LARs5oyy8ZD29ooy9rhy9uk87uxQsA
	FEyD6JY1zqw+rEf8cB+C
X-Received: by 2002:a05:600c:4f88:b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49fe66be085mr81937735e9.1.1790324909517;
        Fri, 25 Sep 2026 01:28:29 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a36189bsm5142896f8f.21.2026.09.25.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:28:29 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test helper read of a narrow stack spill
Date: Fri, 25 Sep 2026 10:28:14 +0200
Message-Id: <20260925082814.1554771-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925082814.1554771-1-sunhao.th@gmail.com>
References: <20260925082814.1554771-1-sunhao.th@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spill a 32-bit scalar into an 8-byte stack slot, leaving the other half
of the slot uninitialized. With CAP_BPF but without CAP_PERFMON the
verifier rejects the helper's read.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 04989d08be44..4d1374885f6d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1363,6 +1363,30 @@ __naked void stack_noperfmon_reject_atomic_on_narrow_spill(void)
 	::: __clobber_all);
 }
 
+SEC("socket")
+__description("stack_noperfmon: reject helper read of narrow spill")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv __msg_unpriv("invalid read from stack R2 off -8+4 size 8")
+__naked void stack_noperfmon_reject_helper_read_of_narrow_spill(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u32 *)(r10 - 8) = r1;"
+	"r1 = %[map_ringbuf] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r3 = 8;"
+	"r4 = 0;"
+	"call %[bpf_ringbuf_output];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ringbuf_output),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
 SEC("raw_tp")
 __success
 __naked void var_off_write_over_scalar_spill(void)
-- 
2.34.1

