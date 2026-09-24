Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E92480DFF
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255663; cv=none; b=RpSiwHnShPP6AA1lneHhO1+GQOJQzGp0Y+Mplfp8oWOldTzqeOh5Sn/OAgwaGuHZhQAGGVqd08L7etttmy23eu9HzD9Hge34Ern1snEJ0kNVU0q5Rc/c+Nrk0UCDLol81Q9frmkT6kSyGzIVYnI/FiNCC10Kn+BifLaYev3Hm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255663; c=relaxed/simple;
	bh=VHHnAvsUiXyMLywhj/CdP4Gc0HCGDFaSO8mlgs/s+2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlDhTqiNCXe3QutWlaW/bn/IyR/KLxdWSPBmtO1yu4OWEpe6UImjFr5NHOZo112JV/GqhTyafPEwe6112n8r9N+r8R25vlodrA/81HVETL5vU32c1hha2eOdK6EX2eL873zCNz1ENGgiFVxfjlut1zLkn0zP7MXhai9rcWfARd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nawamyuu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nawamyuu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so11662825e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790255659; x=1790860459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bq6oXmBjhmxYtZCGZMo9VNKB50nfTEO3RpL1ByCTTS8=;
        b=Nawamyuuxp6R/ZCGhoyynPFu478UGgjbsee/zrkM4aiErpxBg8oHVk+Pfm8QerQ9a7
         pgLFOc8I00L3bR3pB/cioBnQK7DJAqGRwPGO8c7zmXOXZu9dgSMZhRWpAUxAMmDByH8o
         EhkhM5etZM9EobqS+tZtlI1OOkUt9QWqQsO7FGll/r6gF2/hO6urJuBWeF98/0DjsL/D
         X+x6aUYC7d68i8ELBZQdxdpozWXBTV7Mc+Ac4mchPwrTWhL5XkxJoBpyELfZMra2ux6c
         BBNEaSa5zlWyg/tcmL+qXd9dWrbwhN/LqRkcfguKilp77A8pjRAleW8qq5ovGopxPUIJ
         B7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255659; x=1790860459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bq6oXmBjhmxYtZCGZMo9VNKB50nfTEO3RpL1ByCTTS8=;
        b=tD9ZPEB7BrjqkZ8tnCDn8P7CTZVsTXxnFQ4mQnFYvYCnWXQMwog4F3Vgykp2TSG2iI
         8OMB7biLmm8NaeaMI0pl4x+xaWJjag+/4F4d4UYtTGshz21H0xgN49dL8WCF65jvB5A/
         HiPzEl1Y12R5B1sxbxR4ZZ+jfA2+WRmDddgcW4tL1yjdmaBFyG9Y83XbT1fg2mBWqyky
         GYk47pUe2ZaNyvJHNbjDsOuUWDhtMSVi1CfWQPAjWmAvd8EcOSUpYmx2l0WnXpgDtGpj
         XIJLDj5Yef6HlnrARwoAX+BsGljWCpoLy7xtRgLt90uIK3+ZNletxyNjkRfXrWT+W+Pz
         N2MA==
X-Gm-Message-State: AFuF++lm/JN7sCCEM+Pa4fWq+a8x1hytokmb2b8gQ0E14HQweJKz4lai
	Dy/3c7n7SZw8X+x+inFhn358QrqphgwQm09krEwIV86QHE+0w3wSVZYSmrZM
X-Gm-Gg: AYBFou09ZOYCfmOFk/QoWuSC4irH6n/Hcy3VknGiwiK704jLJBUQdMvQeKod1P8VQYb
	O7IVCHmEtvSCh/S2H2Hl9qFLRA8GI+M2ref8AJYM0ujKldZ0OWstRQzHcXvRHuRJlLTjJafgyMY
	RThXdWezDKKc1kLjb/mGYg2anHjWpi3a4yc5LRXm2ApzzMViEh5osr6JFJgxmsEUPIa3ypn7rad
	ZQnfcDMlr09KqqwT72HJwxUwrCTan6cFkFsNxOQuXSNO7zQhGXQklQmYHtUPs1sGnz+tkrat59d
	KpwFocmRapSXQGSNaeu0tyOvZLdCz/iXSh5pBXND0o4SOS67DYzzItS3rc03kF7O4NY6gHSSwwE
	aqycx7qahvcOkkX/PxzfqLkEHNiitvy79DlIND0v/XeebCSfSOSVBa3p4Z+ofsMxyEWuBiK+NoW
	6azf0hs9SFAByDuJDolHt7SQlgg52qmEgU+yxyUdm5T9bW8ESwTkTMnn/cRXr0j+XWv8WxRvtxq
	F2BclqAi8JSy44HUsm0Yl62RiKH0G9thCbT949fpVrwtHYS7lNqYhWyS1al5Gtgoly3WjC5hn4O
	ZSW4v6G+OQ==
X-Received: by 2002:a05:600c:4f10:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49fe66d09c5mr48279855e9.13.1790255659417;
        Thu, 24 Sep 2026 06:14:19 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c104a6sm123986495e9.0.2026.09.24.06.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:14:18 -0700 (PDT)
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
Subject: [PATCH 2/2] selftests/bpf: Test non-fetch atomic on a narrow stack spill
Date: Thu, 24 Sep 2026 15:13:42 +0200
Message-Id: <20260924131342.934290-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924131342.934290-1-sunhao.th@gmail.com>
References: <20260924131342.934290-1-sunhao.th@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spill a 32-bit scalar into an 8-byte stack slot, leaving the other half
of the slot uninitialized, and apply a non-fetch 64-bit atomic add to the
slot. With CAP_BPF but without CAP_PERFMON the verifier rejects it.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39a1766dae3f..d9a4164b6685 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1344,6 +1344,23 @@ __naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("stack_noperfmon: reject non-fetch atomic on narrow spill")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+4 size 8")
+__naked void stack_noperfmon_reject_atomic_on_narrow_spill(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u32 *)(r10 - 8) = r1;"
+	/* A non-fetch atomic reads all 8 bytes of the slot. */
+	"lock *(u64 *)(r10 - 8) += r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 SEC("raw_tp")
 __success
 __naked void var_off_write_over_scalar_spill(void)
-- 
2.34.1

