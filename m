Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C804B0CBF
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469126; cv=none; b=Uq+bKF4IIQt2BcJ3CvQk9jSOigKPglbNRt1QGmwcKsZP1H/j+IlNCdifmkvQTnOy6iXPmjBHFzVhzen8oMPOnfQGzUa3lUpr0/xfCS+6r9S2PKfr3QsWNcC0oJ1YE7LofAdAV3Ek/3PyYvF2RHLWlqBQwaFA72akIMCkI3uUeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469126; c=relaxed/simple;
	bh=Vvb/tqJrTTRdpELGVE34xYJ67YoYXjxkM6psRNWEaQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo9Yx9MpH2DCwUE+UCdeo/6y29rJhcsdT2PiGikiDDDb3L6jb7DK5xKc7MzdB4ifewEZ8L8OQToAPNCY9qvAlxsqYBSgWqVoH730CvltcoD84zrVVS/Gq2hgCGPOwihCkEG/MUajjA2cEcizSI2l4K/yxkyyekQS512GPoY9cZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DibLemzA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DibLemzA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so379556a12.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469111; x=1789073911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thKo5O4TnVALFfejPvX7IR0MvTqhhL07OjRtqeg9Flw=;
        b=DibLemzAaUKAxf7ttCTDHlilSNcLrKo4jAGdBoJV8uK74c9zvQKultS5otnvctsIU9
         r0txmbcXDoRssP6nFfzzMqTOn88Kxw0hdPl5SrU4IJG/G5LRWILzDbWDqsELGsV+APsR
         Rc78IuNoYc9e3s9VvnpTEBm5L8I9Q/GPSffMGrLM/ZjbdImbm8/90hO7yDn4aKTGAx7E
         nAdTGozunJ3lxQAhomnW2EWW2up5bbzSzd+ymlamApDu6/xk5fHVCeu7HK+8hhcbirUT
         zr4vB96go/Pd7mKGD/O+kyagsKOu2J4dic5bXEl3Y/UUEcvvTXD1RedjPQDEh1bDdfbw
         tFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469111; x=1789073911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=thKo5O4TnVALFfejPvX7IR0MvTqhhL07OjRtqeg9Flw=;
        b=BKEBgasOYoLwv2Z5yXkoR/i1NB3dbZFbrpmEJ/nem+wSKp8CyhFIHHFf6TSfcLGU8i
         b0dUL4oVCpxAdi3XZa6ln3MarUmyxEK+nd/yDfwrj2bujwAnFJOebT6TSQMuM/oBR3dB
         SHX5i7WejvdlITjO4hc79aTTmULH5z10/wdx5OfMs4XXK4lGw3zLgagAMEbUuDJyMR1e
         v2VZU/Jnxp7T2PONAtH9A8QjOjL4utTKeXmcPPXO2KUotI8tJws7jZVNCH9/TGNFlQzG
         73mjYXw9bm7bUjUcppcD/SqBEGmkFXPDAJhd6yeKqx5pegQComzj6DpzQpX+uQEdm6My
         1R0w==
X-Gm-Message-State: AFuF++kpvV9g3+oAY3rZ9MfFVf1F6EW+CRB896/R51/nJSomMh0KwapZ
	YMQM3eQaTco09DkF+XAqCfzS69UVzULiIzu56WbrhBGXqCFjCzeCGpM3JGaFxg==
X-Gm-Gg: AYBFou2NabVdBg/tomaEFartyja3Hfenms3R56D+skdB8fwpoOzP/DOlcxyYnE2WqcI
	6lTr+Fpv7psbOU7dXp6t4topZ++/88LgEei3IhbgacNr2TdJTLqwzHVDanwnfeG9gFHpJ8yQ/FF
	ABszaji5nO0Ut+pbaw4hZCKb+Z/4RsGG4sII0rtv5m7fLgdYv4CMhpvYGQRhEV89atmy2gNuXkK
	ERSc8YtWxWb9QHytcVhVOTcOqSeaail9P24lpTx/LDHfHI+WoO5LKWEziMFfcr7LUEK35L3bUV3
	uuuljz/g2KpykKG4mkxqP4B/LymIBNda+66iiL68XzU8PVu1dLnTs76WVziP6SIuF5z+MRMiAkD
	DLmeNX1yVEstpoYL5d/tOwrlH5r+c+XWv9Mv8oJryco/BQDEjoYaBZYgRlfelzRzxBubCatk9Ys
	+WKPvjuBnQ8aNT4F//vvPCruYGvahvUT78hMs3NAp5z68G2AaS3m09etlTtkH++ZFbHUofk4of7
	VAOOWbD5jRYsHUeI9N8QLKNPrPXxuzu8mA+5MlPqSNtlw==
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr2088612a91.23.1788469111434;
        Thu, 03 Sep 2026 13:58:31 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333959d5f69sm1383588eec.0.2026.09.03.13.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:58:30 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 2/2] selftests/bpf: bpf_fastcall patterns entered by a jump
Date: Thu,  3 Sep 2026 13:58:20 -0700
Message-ID: <20260903205820.1743087-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903205820.1743087-1-eddyz87@gmail.com>
References: <20260903205820.1743087-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check bpf_fastcall pattern detection when the pattern is entered at an
instruction other than the first spill:
- a jump to the first spill allows the rewrite;
- conditional/unconditional a jump to the call or to the fill does not
  allow the rewrite.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_bpf_fastcall.c         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 328cf630210a..a73b837553fb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -621,6 +621,116 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 	: __clobber_all);
 }
 
+/* A jump to the first spill executes the whole pattern, rewrite is safe. */
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("subprog 0 (jump_to_first_spill) main {{.*}} stack 0")
+__xlated("2: if r0 == 0x2a goto pc+0")
+__xlated("3: r0 = ")
+__xlated("4: r0 = &(void __percpu *)(r0)")
+__success
+__naked void jump_to_first_spill(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 1;"
+	"if r0 == 42 goto l0_%=;"
+"l0_%=:"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+/* A jump to the call skips the spill, the pattern must be kept. */
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("subprog 0 (jump_to_call) main {{.*}} stack 8")
+__xlated("2: if r0 == 0x2a goto pc+1")
+__xlated("3: *(u64 *)(r10 -8) = r1")
+__xlated("...")
+__xlated("7: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void jump_to_call(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 1;"
+	"if r0 == 42 goto l0_%=;"
+	"*(u64 *)(r10 - 8) = r1;"
+"l0_%=:"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+/* A jump to the fill skips the spill, the pattern must be kept. */
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("subprog 0 (jump_to_fill) main {{.*}} stack 8")
+__xlated("2: if r0 == 0x2a goto pc+4")
+__xlated("3: *(u64 *)(r10 -8) = r1")
+__xlated("...")
+__xlated("7: r1 = *(u64 *)(r10 -8)")
+__success
+__naked void jump_to_fill(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 1;"
+	"if r0 == 42 goto l0_%=;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+"l0_%=:"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
+/* Same as above, but the fill is entered by an unconditional jump. */
+SEC("raw_tp")
+__arch_x86_64
+__log_level(4)
+__msg("subprog 0 (unconditional_jump_to_fill) main {{.*}} stack 8")
+__xlated("3: *(u64 *)(r10 -8) = r1")
+__xlated("...")
+__xlated("7: r1 = *(u64 *)(r10 -8)")
+__xlated("8: exit")
+__xlated("9: goto pc-3")
+__success
+__naked void unconditional_jump_to_fill(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 1;"
+	"if r0 == 42 goto l1_%=;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+"l0_%=:"
+	"r1 = *(u64 *)(r10 - 8);"
+	"exit;"
+"l1_%=:"
+	"goto l0_%=;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_get_smp_processor_id)
+	: __clobber_all);
+}
+
 SEC("raw_tp")
 __arch_x86_64
 __log_level(4)
-- 
2.55.0

