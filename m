Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749273A875D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429458; cv=none; b=lTVrRISXwnMdFq/HMfA0qw4zWji/3vsW1X8wXLU9xD2jMK5vwMyiCledNXYTDbxvosPF6DpPaDiXzuYyA0BmxJSyELi8tcWd4UScpxmCN3VfrspFCBkTUzPmBx7GpQzPpBezAfCW279yc0dNW5MrzwJB33HVBnL4p8+0RDumOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429458; c=relaxed/simple;
	bh=THTO3f6tYPhZQddgqGI16d/UpY8Z7CFiTb+sHQvTnSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNLUWiuexRc0ieRDG7SY15c5b/8/7wY5i7J1eg10bDGqecIM5o7kfHdZu4Ru3+JU8golHn2oAc3r5vyJpb0aZn3YKFKnZJTiUFCU5Ds5GMuVRwPMjIwnframWiF6JTMr6gFhG96VRtWM8RHJMW2K7wzH92EgujiSpSL4rgMfiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGOvfAsn; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGOvfAsn"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ffff11265so194985e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429454; x=1791034254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6wfD9Kh63r+1oPu+xfURlwcqdKMI/8fklfFl1dQPUo=;
        b=aGOvfAsnnKqx5GETyA1RzyrGqvhDjUH+oJ7w5iWseNiy6V2eTs+WiAGGZL8KH/9cyR
         nNm/e0gHlC6h83cVv72p40g63iSiieScXF3qWPpkMD7sNrYtckvzb/pZw40CLzsSlDNs
         O6vSm8nng4u4nD+OIK9vdXCEIJn4kAnnUytVXPHYb0EXcsbRSNBjzQD+lQc2Ee7Lju6O
         Y7ClsSWTKpXXp4UlU7Soe6hjuE5gYocpuoKfyLQ+7tmjtfoKeRAdWsdnl8LdOkXusBzK
         fx0lCErMovCnJZVKO1G8VbZQIZXcVHewrH8CBhGn8aJR7KEXPLEqbDOZzxClqDfBt7yO
         0lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429454; x=1791034254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S6wfD9Kh63r+1oPu+xfURlwcqdKMI/8fklfFl1dQPUo=;
        b=cToV+ZLE5SdLiTd2hincoQyzdlMcp8z8UTqeAwufRZfnh0MLFgdmwVU+kXzdsjVieS
         NYun7U26QGpkhSw58luKcvQ/wssjhp3nplg4QijU5xl2Yih+uKO8qvAZAoNYzMsHyLtA
         Z7XSbVk4EiuAADHFuz5B45T241MLuSr5ymof6JhFSY7+I723mGhEB3NK0Q2r1OUi+ZC9
         cTNC9k4iW6JrtkxHek2He2+fIz6WstO0pe79ter4OoOEhJCVqTn/2LHuBEueGfjeF16r
         z/hD7sIKPTJlcuyP0PhLBtNcBzeR6bile3CrfohyE3X3+gh/nmwcSUBIh5HYECqyn94o
         P1xA==
X-Gm-Message-State: AFuF++mXDuQnkY4WOjxyzzbWpATxIGQMuHAapfHbfYtlTArM5MdUltke
	kbdTtY87x+wW6RqTlyudHCNImvu+BggEayy9IPcNnXBC/eR4UjlWtb4rX67mGzGF
X-Gm-Gg: AYBFou39ZWln0lb7uTwxP6HqDhbVp0z3Slmrk+zPBxglAuhmpbxMiTNny9v76l8L50x
	k/sNjKv2vTnaV38EqRu6Zd2EGStc1Gs2sB9HOnD2xf+6IVw50LlTOddaHqs+YPnaJ0FAQsnVdTG
	C0R+csQDTGNQeEI58VSEE0ZSUaden7THG+cgk9CU70ZBWnx5ELdyReePLI4263M3sq9k81amhgi
	BEitNVnJLkyXT+2udZdxqgi2CxNLnaRs71LYBcOOngLldxcRjBVFKxh2aV6/Yc22gkm6Ho1/ZFE
	WtL+iBKz/xpLGegNXPsIPlW6oYMlFobeBaNoxID0Pl2EHy6hRAzKVOwPcHSgOIGztg3SIXQbnCC
	ftxReiZQEKS93YzpQL2U7c3EeErpl87aZ627iWBKVVtCadxFTQPXf7GB9sM30tBi9arfIcSu5xK
	orWUYsg7NfQ27Q/ga2Sxb+ByF8XFQ9jbpO486b5ajBABK6ClBuGfUCiBaneIk8UXWO6s513rHa3
	K5e0vD3TpepAuINW4pP+FtrpOzAPuWD0VRCzd22JRgYmEWgSsECak2N5x7FYXx89RP/ugTYVkG1
	rz6y/qRK6yvp4/x61YC1AQREdtCyvVLI6eql+pqHyKFKoK5s
X-Received: by 2002:a05:600c:354e:b0:49e:6e7c:d895 with SMTP id 5b1f17b1804b1-49fe66ef3f5mr153550735e9.26.1790429454482;
        Sat, 26 Sep 2026 06:30:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06d4394sm138690175e9.15.2026.09.26.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:30:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Test Program Structure diagnostic context
Date: Sat, 26 Sep 2026 15:30:45 +0200
Message-ID: <20260926133048.2962553-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926133048.2962553-1-memxor@gmail.com>
References: <20260926133048.2962553-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=memxor@gmail.com; h=from:subject; bh=THTO3f6tYPhZQddgqGI16d/UpY8Z7CFiTb+sHQvTnSI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv7iSdyfSyL353hU3vv2Sniq8XFutWWX+WagWLd34n3v vNHF/N1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCL8dQz/rHo9BG9pvJqt/2C5 9Qwe2XAvoyTGk3M3rWYXTl9SXGr5leGf3sddjQznwoovpof8e+WX9TZ+mSw385WM39kywdN3Rcx hAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise each corrected Program Structure report. Place a
missing-table gotox after another instruction so its attribution
differs from the subprogram start.

Add malformed subprogram layouts for a branch crossing a subprogram
boundary and a subprogram that falls through its end. Both cases carry
BTF line records and assert that their structured reports include the
corresponding source function and file.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Link: https://lore.kernel.org/r/20260924170646.2366016-8-memxor@gmail.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_cfg.c        | 40 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +
 2 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index 6379dfc9389b..b429fa7a08f5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -56,6 +56,46 @@ __naked void out_of_range_jump2(void)
 "	::: __clobber_all);
 }
 
+static __naked __noinline __used int cross_subprog_target(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("jump across subprogram boundary")
+__failure __msg("jump out of range from insn 1")
+__msg("jump_across_subprog_boundary @ verifier_cfg.c")
+__naked void jump_across_subprog_boundary(void)
+{
+	asm volatile ("					\
+	call cross_subprog_target;			\
+	goto +1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __used int fallthrough_subprog(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("subprogram fallthrough")
+__failure __msg("last insn is not an exit or jmp")
+__msg("fallthrough_subprog @ verifier_cfg.c")
+__naked void subprog_fallthrough(void)
+{
+	asm volatile ("					\
+	call fallthrough_subprog;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("socket")
 __description("invalid DW LDSX instruction in diagnostics")
 __failure __msg("BUG_ldx_99")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index f5a9878c7b8d..dc7baa0f2458 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -101,9 +101,11 @@ __naked void jump_table_terminal_gotox_subprog(void)
  */
 SEC("socket")
 __failure __msg("no jump tables found for subprog starting at 0")
+__msg(">>> 1 | (0d) gotox r0")
 __naked void jump_table_no_jump_table(void)
 {
 	asm volatile ("						\
+	r0 = 0;							\
 	.8byte %[gotox_r0];					\
 	r0 = 1;							\
 	exit;							\
-- 
2.53.0

