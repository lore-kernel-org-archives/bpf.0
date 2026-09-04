Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153238B7A6
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551507; cv=none; b=RNEoGxyZkZVVmIrb1Aw5aN4hI9kvtdQ9s/SUyIjXOhJfyAvCJMEt2Njgtbgj44g0SEHo6VpALOWgjNYswiiPC2uD1dtk155SB/wrXXLvDcMpbXZCvOL99jWz014sTfRoWWzAs6dvU3qivQkXRnfMptIs/Dl9+YH5ctz49sz69Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551507; c=relaxed/simple;
	bh=w5NBvwVDK4jynWMDTkCIvGpfq2JarnNZCBIHvTxjTak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXUHT7aA988/NjtdjlX64DIIh+zl9dNyqRurIUygtGkQoKWKxXrzpAbULdAjtcBKu3E64EENr6nu6D7eoFQH6sj1FzB1rLw0fgGFqEwUMWDLt/7xuUDJcAYsFMp3S9Zwr+KPqnQRwthpDz/bOGOWGIb5ZZrnFkwrT/zgQhPj858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHR9Izx6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHR9Izx6"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso999452b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551500; x=1789156300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
        b=DHR9Izx6yDwbSX2kj+NfWQf4+9F+ftlbHin3rBXCRSgmaSmQtVfWHoqwFlXGp23kSL
         TA7aI6zF87Q3fubPyfjBm0AU/8pF18HXNVrXZhe2z5nNQiMR1ig155oLfrggOIo5ZXo9
         1h/XROsibTSqai/yza5aD3UHmZV9raTvRVKEgpz7o00hMQBCw3IevhqQK+BBBGnXtpYx
         WCmsIucckseIF0FwFwkjTAp6K/SJUvN/EBWjGE7v5S6dKRrRczGylIWE5HjgL21u6Y6q
         TRkdaGKn6dSnjFWvM7wAJitEE2LcxMaA9bPpSbNkR1tvsCb56G3LB18sJHP53Ok0Fay7
         eMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551500; x=1789156300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhQhsQ4UfwQumqLXBrbDqGkg/NZUYL46Pvxy1S1ZxCg=;
        b=EC/Rot2hbMGROBSyYfP9CeaUg32vkcApSdgGGMkncT+gW4+EzM7GM26KDDyQi7bgpL
         flV9nILFSeP/AVXWd8SV652a6CRcVoSEeFKVjNoP4hBzY4leQH1jV5ZO1jwkXpquxygi
         p0WRa8uhcCui/uK2WCA/Cltsgk+ZfWd8vgp7phitM855+n3gZzQUfi3Kvju64EC6wvls
         gwCI4E82zNbMNE7Ck/yDNYAcq6PH8c6eQBWg6IMKDZt5wI4OdN5Mz9zMVvKXhia0vSA3
         I6RxWet1d5LoFTyOWR9FhZJPExJLFpVtuSkFm1dFPFV+o+OBQUEllEYlTwIxcpvP3fOA
         8VLA==
X-Gm-Message-State: AFuF++myL5V2qJhtgjlq7pNGgPCgUO6jPD4HVtVbXeBeCNiuJ1e6xsT3
	+NROOsFkNgR2a5i6s9k/YG8dSKmx0E0702lLdKrtO2aWYffCXeFnTsY/ekfTpg==
X-Gm-Gg: AYBFou26jzx9eNbxvORnfdXkzDhJ1mqRMRcx2IAXU2grSIRMj1hzkOvBrvxkbWvRX0x
	ZmNu8VCLBDXdYJKaC/Lu2Pmowj6igsd10Lt6xLRD9YvB3dUrirDVAUL0Fhx0ZKGyk1A2cUZKOEr
	o4MBqnqrtk6K3JTHwc4qEdh65QtZ3tOZo1YLk30xa4Nm6f+AaIZXXqSOzfZ7S5CIt9Bpg+avAF9
	ZBtNGr/Y/kc18ko4hsXAAyhMxt/fKjhL3fqqqx2KmxZsLSS3OwWDtUGwHQrJxyiFxpZUi1muAKw
	zuYdRiHLGQgRQyc5kSnvWFl/p5jOKaDvZtO8NLx0ZYhEESZ0o7cmkYox2j1YA82mx8PQjh52Kwj
	QdZDcPBeTqq8oltIsRxl640AK/oRJxIpLRZVYw43zO7dpSul602cr6QEjUuoSTVsamSddc6Wu2Q
	GycAg9nkSeGuz8T5bj2LyHhoHin3xkZycTEWhn+j1jY+d+mPDE/irLmZatcoqj6Cbk7wwJ6J9QJ
	WGc42OpVxSTWdRkxMvjYvUSEuvI4Jm/8yhwl3wMbjt46ylKSR8lxSBpgLfTww3Vu6bDv9sc97fP
	Xkp4AjPzELvs9glRuQfjxAwSwhcBTuu0B8dBIE63ENvlraGFYIMKdDQb1DCuqq09xI48/ddL+ac
	=
X-Received: by 2002:a05:6a00:9286:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-8616a06be4amr11190015b3a.17.1788551500394;
        Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 5/7] bpf, riscv: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:30 +0000
Message-ID: <20260904195132.141068-6-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timed may_goto fixup now passes the resolved counter pointer through
BPF_REG_AX instead of a stack offset.

Copy the pointer directly into the first argument register rather than
adding it to the BPF frame pointer again.

Fixes: 6ef8ff20c30b ("bpf, riscv: Add support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/riscv/net/bpf_timed_may_goto.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
index 02c637d87420..8c03e272e0bf 100644
--- a/arch/riscv/net/bpf_timed_may_goto.S
+++ b/arch/riscv/net/bpf_timed_may_goto.S
@@ -6,12 +6,11 @@
 
 /*
  * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
- *	- input:  stack offset in BPF_REG_AX (t0)
+ *	- input:  count and timestamp pointer in BPF_REG_AX (t0)
  *	- output: updated count in BPF_REG_AX (t0)
  *
- * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
- * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
- * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
+ * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI.
+ * BPF R0-R5 (a5, a0-a4) are saved across the call.
  */
 
 SYM_FUNC_START(arch_bpf_timed_may_goto)
@@ -28,7 +27,11 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	REG_S	a3, 1*SZREG(sp)
 	REG_S	a4, 0*SZREG(sp)
 
-	add	a0, t0, s5
+	/*
+	 * BPF_REG_AX (t0) contains the count and timestamp pointer; pass it as
+	 * the first argument in a0.
+	 */
+	mv	a0, t0
 	call	bpf_check_timed_may_goto
 	mv	t0, a0
 
-- 
2.43.0
