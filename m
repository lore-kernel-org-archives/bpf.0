Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129036CDF2
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471489; cv=none; b=Y2TT3EQzXKt8D+oUw6gR23XOETDHdyBv4W9/GuQkC7/Kot7vItIPjL/FH5u3HQSG8q26FuK2gJnBIlZH8ilDXl05JjcBQIjDDHjzZf/iGfnSTW+xbG6xqBNytt9qD6e0cO+t/FRAXZGBo0+NyqMNgArca3rkJqGGuEP3wuSi0Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471489; c=relaxed/simple;
	bh=Vivb5/Aj5UCagN5b8iBhZ5IQ9uRNCKj4gbYqbicq7IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS5e+NECmb/gEvKhn2G5ul5dpyF1i9lOS45XmQLutHUKlvn+1EXnc9Da87jGvoosVJ+A+IEkb2fe2vuZvIiqrMKs5cu4Fm0xnSPdAV3KiRaTBB8aRMCbUCHrVuzQOwwiwg+R7+wzNEJDL3HwgDUleqAz9kp5vHvmEWcGL0NOT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9k1+vTm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9k1+vTm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso46009a12.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783471488; x=1784076288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uxoyVq5r2C9QxbYlGP0MyNTadEqaiRl4vJm9Qjg46k=;
        b=V9k1+vTm187taACiAnlXw+kQkRnfmVPgpvzR3sY0WZ9uxIyKIZ3pqw/SzlXaOBPkGu
         0uQuMTzGWNazGEhT6cYx3s5wcdsHONemb8sjUBRFku1h/dDKXg5RDwMWGwxHJIJ98WR3
         /cO5140MRB8FsZuwFXRY+UEMbiZHEP7SxHAuAcrlJoAFnOSV92KxRuCKyjPxBcpQGesv
         xbxQOaHrdoak6Tk62y3b60yOKZw/6N3SeAreDOcweEXKiWVwjVbRvVHUSLNy9M/3+i3S
         LbrBxPOm+FCJm34m+DA4g5nXwANqv73NUZk9IU1a+2ofKFCIsDEW8GvndjSw0FmWSM2t
         hdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783471488; x=1784076288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uxoyVq5r2C9QxbYlGP0MyNTadEqaiRl4vJm9Qjg46k=;
        b=gEEUVx7sMQ2XvcJYJjuvzswX+dW2E9fuFT6lv8/8tYNMiyttlGr54Y6m01xcvUddAf
         i3IyVVBNn1Od9FMsyo0H1+DkM4MtrIdcbq1FghE4XqtV/5ZlwXzPMXQaO5vd65ylCovO
         eahGZ7wRxV/IwWd9ywB6cD++Hbhu0mSIKQtC3nDsv97Icrqzmq3EWdo0OLXvx7QLyicA
         6rKP2ObB73tFPs5RRJmlN93CZ7MQVpKHfRWx9VusNhf5Ie+nJSYdRNOxGHcXlQqthtir
         AK7sO/QK1giQnxKFsoyC+I/Ri0Xx2ECFtg/UqW1+WMmXbHYJhW4heUoT0cBlq/OfiYMe
         EEmg==
X-Gm-Message-State: AOJu0Yx4OTzjaO1J4q3/uuIffgSG6ntMUYeuZFUSrFpSL73SXK2rUZH9
	SuuIxMT112PNfYdmDOoQDcEnghjxRT9Ixw5WAyymcWqEJOuVzuMt187V1g0ia8dJ
X-Gm-Gg: AfdE7clNcMK93yG1B4XTnEaOmODKw8RqzSxzd0w1l/l3v2Q/uu3j4YQAWn3A1Gc6RjZ
	gcd8OHMt2BIcE7N63dJxJhNipxatZpiEO+UFyPNHf5bCY3ta4GyN23y+v5m1Gb2273BpZiRld76
	ctn3+0Ajy53TqBeJ8q3NCIUTV0wncgO2QlkqRgItnolVqq1UtcgRZIVo/0i7C5og61psq5Yms1k
	vPkVjE76iQ/GlrCPalISkfaFnGmj3iM//AYvgKdX3URKI/Evr5/onBzo+2DuBRhGbhtH94Aq56u
	V+Ki2Jxtwx56fEJmkRrbipycGKh2PuLQjy6cM3+p5Oiy9VGxaZ91Jcwtts7xvq/EUca1tt50kd2
	XliRDVUCshlqX8Z4fHyBv+F5cQLvIytq9FQaqoePottsDVIXPODCO/Jfb4UcvTVl2IKy8vz/SaI
	qktEvcIRFuXiUYGoeHfKuwV0XE7axwx8Dj/+bQFTcuZd2X6+zfgie2uOkOLymgMgL7YgPs
X-Received: by 2002:a05:6a20:12cf:b0:3bf:b3d5:ce1b with SMTP id adf61e73a8af0-3c0bcbe76c4mr29845637.12.1783471487634;
        Tue, 07 Jul 2026 17:44:47 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:84e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117483e0a2sm12371054eec.12.2026.07.07.17.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:44:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: test cases for missing spill types
Date: Tue,  7 Jul 2026 17:44:29 -0700
Message-ID: <20260707-missing-spillable-types-v1-2-44a92121dc41@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
References: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A few selftests checking that the verifier represents spills for the
following pointer types w/o losing precision:
- PTR_TO_INSN
- PTR_TO_TP_BUFFER
- CONST_PTR_TO_DYNPTR

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 25 +++++++++++++
 .../selftests/bpf/progs/verifier_spill_fill.c      | 42 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index f88aa4cdb279..5b18c9a27717 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -384,6 +384,31 @@ jt0_%=:								\
 	: __clobber_all);
 }
 
+/* check valid spill/fill, ptr to insn */
+SEC("socket")
+__success
+__naked void spill_fill_ptr_to_insn(void)
+{
+	asm volatile (
+	".pushsection .jumptables,\"\",@progbits;"
+	"jt0_%=:"
+	".quad ret0_%= - socket;"
+	".size jt0_%=, 8;"
+	".global jt0_%=;"
+	".popsection;"
+	"r0 = jt0_%= ll;"
+	"r0 = *(u64 *)(r0 + 0);"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r0 = *(u64 *)(r10 - 8);"
+	".8byte %[gotox_r0];"
+	"ret0_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0, 0))
+	: __clobber_all);
+}
+
 #endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc*/
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 72c691333703..8b166c42c4e0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1403,4 +1403,46 @@ __naked void partial_fill_from_cleaned_pointer_spill(void)
 		      ::: __clobber_all);
 }
 
+/* check valid spill/fill, ptr to tp buffer */
+SEC("raw_tracepoint.w")
+__success
+__naked void spill_fill_ptr_to_tp_buffer(void)
+{
+	asm volatile (
+	"r6 = *(u64*)(r1 + 0);"	/* r6 is the writable tracepoint buffer */
+	"*(u64*)(r10 - 8) = r6;"
+	"r7 = *(u64*)(r10 - 8);"
+	"r0 = 0;"
+	"*(u64*)(r7 + 0) = r0;"	/* should be able to write through the buffer */
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__noinline int spill_fill_dynptr_subprog(struct bpf_dynptr *dptr)
+{
+	long *p;
+
+	asm volatile ("*(u64 *)(r10 - 8) = %[dptr];" /* spill the CONST_PTR_TO_DYNPTR argument */
+		      "%[dptr] = *(u64 *)(r10 - 8);"
+		      : [dptr] "+r"(dptr) :: "memory");
+	p = bpf_dynptr_data(dptr, 0, sizeof(*p));
+	if (!p)
+		return 0;
+	return 0;
+}
+
+static char dptr_mem_buf[16];
+
+/* check valid spill/fill, const ptr to dynptr */
+SEC("socket")
+__success
+int spill_fill_const_ptr_to_dynptr(void)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem(dptr_mem_buf, sizeof(dptr_mem_buf), 0, &ptr);
+	return spill_fill_dynptr_subprog(&ptr);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.55.0
