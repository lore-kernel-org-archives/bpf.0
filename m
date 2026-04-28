Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6C39D6EC
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419946; cv=none; b=N13uIcNDmQR54xYqYNAvuFppU+PGgJoACKrQeIM9rk9o6ahKdPm/B68tyX2eyWapRX85JZwMjHRE+XAzklL5gtJK8r5lTrykybXjZS3iFmECiM8rGbUBCcsvnser35Od4rDpHZsEzXAICGjeKq2j67/EsiSCDJSIixmmdTwy5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419946; c=relaxed/simple;
	bh=L9HuTY0g8gIAf5yOwBttXUIxYT88+W0S1PATCxy+7ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0MPG7c/pVLFsVEOvXdEw144AQtP8PfIZNOHFL9rrN4Haj99npagwUrn45q8FmkHW4WbjD+lWKRmYix+UWNrlgo87jiAXPbhry81nxgLxQ1SirbAQgwpHvQT5wbMQ96B4WNA6A0D+lp0yCDfgBsNI1wFDBvZh1EMqd1dbxEDoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cStilqlg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cStilqlg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso91673725e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777419943; x=1778024743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiBkOsP3D37NyL+KOe67WxRClt62TKa7PSBgpnWneMk=;
        b=cStilqlgUK+LQKPN2ofjIXLwoVL6oWxgMBYA5ymzztaio6qtaAlx1OQ1ubxCUr30hL
         zhnZbIeTvl3puG6YnP+eRCG3otbw9bff8DuGyk1atuwFX3EUx8VlZRXcKNYQ7bjr2cs+
         ThpH+4vMFRB5OJ84l62lEvzUloJSp5rhYgGzyA9OhzYEHEECGvDwl7eHIf1zSqazG8Je
         YIrWxaYlNbOrlY2mjXwJ6R26pMtnifb4SZeSdtnY7fXHrHnJBzpgdt9vI4IeFdelGg0h
         mNtD/sV5C/hoA+xYQcwlaDnGvHgjyz9rUN9FbWLniN71DXXzpILdmVXc08HAak8o9Z0l
         mPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419943; x=1778024743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NiBkOsP3D37NyL+KOe67WxRClt62TKa7PSBgpnWneMk=;
        b=WH4wv1jf8DZvQI+cSiQ6f9OEHJ5Iy5S4kBF6KvrHYqX0j6AU6keF8tq5KcyHRKF1UD
         bGDueidSDePgIIyKzl8JsoBmSNHKEhTX4YqzjQAu8rRj1iuCCuMAiSGi0Gh0llP721Pm
         HKbyXYJGnJGAAWJu7nG8j8E40KiIgxM/ZCDAh42YST/L5k1lZN8OWQsCfMJ04D9SD8cE
         PpYrrp0StUddDPaXq+32d+E/lyglEUFaCoMG0Hw2l3EEeBb8SKLgTzySsPr8cyudg7cJ
         IOSNGWqwTptuxH59d3vM5JJbZH40dQGu3oZb3jtzJGOWF2Rf2w3ii1ivtkek+1n9mygD
         hyAw==
X-Gm-Message-State: AOJu0Yxvt65IGryBg47r43JNgC69zsjrtyzt7xLjELNw9tcQjOxYsGXr
	V5RNwNyRVwRUvk5tZpiGBMdYmj2zr+F+ZSLE/EEqx77rHDoDv/+iNoD6TFYyHM3MSBY=
X-Gm-Gg: AeBDievY0vIkY4dYA/RFKB6oKFnuSwvj2WNpXPkga2pykS6qERKJ1lst3BDaHR60g8e
	bnCzK4m3NdaZw9cUc/AN1tq8r+FJyDnuEKd+/PpljQnuUC8OOuEymxOO/yMaNREYP7khjCDP70h
	6Z4y+oX1w+TFBYXmtsQBtQsv/7xMJcQtE+wSkSxHW5Qh87EBPLQD066mX9ufJSQ1dbqqsZoehb+
	/x89aBxbeEOCzFS0O3xAubKRdOL33GM/EQdNc1ks7lg6h1Ig3xPuRcVSP/WObjro0tR5T5krTMU
	5x5LQ3T5GiR68UgLMggB9QCbVljQGxfnmzblznLlHpy3ixpE09G/gylTKq8U73NSClrW6Ac+Nv7
	NSeVGVI3ojPIacrBsBYRQVD1w2qzJ9IhahDDkA0fbCPJevZ7kUDzdCCZ/EVbYgTL2vkUheRdiCQ
	uDeG+jP+Hi2Yr+0GEVYeTgjtFX
X-Received: by 2002:a05:600c:1382:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-48a77b232femr77940045e9.25.1777419942911;
        Tue, 28 Apr 2026 16:45:42 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6bbace7sm247108e0c.5.2026.04.28.16.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:45:41 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 28 Apr 2026 20:45:07 -0300
Subject: [PATCH bpf-next v8 06/11] selftests/bpf: Tolerate test file
 compilation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-selftests-bpf_misconfig-v8-6-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1777419912; l=2530;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=L9HuTY0g8gIAf5yOwBttXUIxYT88+W0S1PATCxy+7ig=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKrl4FW9lTL2fKXCoxAttbRH4v2StF8TjG5J7aB7amC9XyO8MvqrLBBGkS6a2KmtCFalKLmK1Rd
 b52LNnLz0Lgo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal in permissive mode: remove the
output object on failure and print a SKIP-TEST marker to stderr. Guard the
BTFIDS post-processing step so it is skipped when the object file is
absent. The linker step will later ignore absent objects, allowing the
remaining tests to build and run.

Use plain printf and $(Q) instead of $(call msg,...) in the BTFIDS block:
the msg macro expands to @printf, which is a make-recipe construct and is
invalid as a shell command inside an if-then-fi body; $(Q) restores echo
suppression at the recipe level where it is meaningful.

Note on bisectability: this change is gated entirely behind PERMISSIVE, so
default builds (BPF_STRICT_BUILD!=0) compile and run identically at every
commit. In PERMISSIVE mode, this commit alone is incomplete: the linker
still rejects missing objects and the runtime still aborts on NULL function
pointers; those issues are addressed by the two commits that follow in this
series.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 608e6dff0392..f0545ee6b32a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -717,11 +717,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) $(if $(PERMISSIVE),|| \
+		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2))
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
-		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
+		$(Q)if [ -f $$@ ]; then						\
+		printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"; \
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
+		fi)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\

-- 
2.54.0

