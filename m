Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0438759C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491923; cv=none; b=BZC1mOtpP5pHNWuZBMl8zpUrvozr/59MxDMaFqO8VxsFa1p0Sj+lB7fBYK+PsAVosaSljOdVNSxa52PJXp9W3l7LBxtIsT3W6ivIn9bX1q9+mQE2/ts7KAh5VmNh0+582VWIdY+403u+nEcCiJsYgGxGjgks2uo6T8Eb5nbli7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491923; c=relaxed/simple;
	bh=THQvdXVv31TpQ7mxGEsKklR/hWrRMotZuvkB5HuFY5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/wDRaeoFmyevVydoyiZYM3Tgb0zAqtSHs6l9Yha3U3EWt+/S7S9YmWllceMQAkdYPLCjxjz+QlTucPJwCWY9sOCD26ZIhvX0FISOG5YCD6hOOQ7sT1LXq8clBHglHS05Rh1F6msKV+xL3voLsNt8DeGTzsIiT3yRQRrEukRxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VZPag/3y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VZPag/3y"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso30836835e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775491916; x=1776096716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhJemnsUkZv11ibw/3C7vkexNe+w6VJ9//yKII3jtCI=;
        b=VZPag/3yd6kdLJ0QhfxPNveoRj5yWqv1T7OaRlItdUg+vLGfRdXDjKLfC5ZV1NSxQQ
         XnGPX8ty5KpI/z/S4sDurZY0epb2AzxRgi2Q65oxSDozcvP53+DjJ0OCDwMqSdlYTNL0
         VtyWUIcJIjA18uYIBmVreqiwIJDh6vQE5WWzxX9RMJ9haEOmhFqESvjQZg0zaDFoPsqR
         tHlTDnHQS53YdnbRGv7d6LrqtuAKI6UhaWo0MZYy2QZhqokBvZ/syeCGT1mC2YsI8/za
         E43uqN+OLXGUANgRSEZL3IoP4BJ+itsq63MBmu6j6EN9FBENeH+/npHi9weyrDXu49HR
         yNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491916; x=1776096716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhJemnsUkZv11ibw/3C7vkexNe+w6VJ9//yKII3jtCI=;
        b=MH7NUsgyNwBQO1jp8f8q1gqsh22MnLlKqNxHbBzBREglpc0Xk2tUupN11VXGbrXL1a
         c762xtogAB2iel1kwR0L2e9ZJazX2g/I12f717O9PFwcEZq/NS7a9MiTETW5GRaek0+m
         w3owOEXuifgjVRMBmvGQ+WE5AsKej/I4/PxrY9h2le/oRCWwUjoPXuALrx0AVQaTlbYO
         cc4HEp8smwhaVuTOiMZ1KDhNRlYVjfj7l23tH4uN6E4aMJd9tlcs7gvj0LNLdyXsZx0J
         oiq4SGvWD8v04z3OFQM1VZiqwZiIx9egddzYEMc33pgXy7R0JVEzoWCY0NVXSF0H20LT
         Ho+g==
X-Gm-Message-State: AOJu0YxofGEQfF3EMTxM3at3MbZg6zhidqQAMC2hdrkPbkZ4HHpJpkyB
	Fm4MJpFEasWgDlI30afZ6WDIKg9z8UGqQAOOOcXHDj1VTMo33nPCdfTsF1sx03dfFZCddvwfJSM
	j2nZY
X-Gm-Gg: AeBDiesDLWx9R0GvB7xxQvMlNF5U+9HNS1Lo7pYPc7YJW/nJVJ49bZLWks32JxhbQUr
	5nVnzi+yTgtInOuE3Ictd5MjLf77Z4Wd2R+lhvOoxXJw9ZkC3GGXEGEXmQwxj3VIRjmr7KZ94A3
	Ubxruhe+NArfL1S8XTD9mAt20WBdmWE08ygEp1+ilOpPPQko4Qjw001ZPxYfFaM3UOxNfB6f2As
	5h6sgwtcIuDpcfVx/tTGTiyoBP5pZIP+19YDge79M+acByAVOu55JvyMU7gTp/wKTWwznWqsKlm
	vdUcu5DIVmzbTt68pBbu4QtxwZZFwsyDS/on7G+fDICaoi8dwhqWD7ERNOvwZUnivCsuv7ioCOT
	L8a1dBInjEe5ATYOoPgt1lqfw5estfp3WTGAmoUnRvcg36NlwhCs6eWoCzaFGFEiQbFnnV83dcz
	lLXdROiiSNYHgO
X-Received: by 2002:a05:600c:4512:b0:488:9324:3ab8 with SMTP id 5b1f17b1804b1-4889977604emr189339735e9.18.1775491915600;
        Mon, 06 Apr 2026 09:11:55 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6abbcsm13665264241.9.2026.04.06.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:11:54 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 13:11:29 -0300
Subject: [PATCH v3 07/11] selftests/bpf: Allow test_progs to link with a
 partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v3-7-587a1114263c@suse.com>
References: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v3-0-587a1114263c@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775491886; l=2109;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=THQvdXVv31TpQ7mxGEsKklR/hWrRMotZuvkB5HuFY5g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNnqnfZdGW7vaNVUnntgaLMuLsEhZuzIG++xaZXo9auz86OmMepb4i7aY3wF2d3bC6A5TkvYvxc
 EhZXeyhwnqAc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When individual test files are skipped due to compilation failures, their
.test.o files are absent. The linker step currently lists all expected
.test.o files as explicit prerequisites, so make considers any missing one
an error.

Move TRUNNER_TEST_OBJS to the order-only prerequisite list so that their
absence does not prevent linking. Use $(wildcard ...) in the filter
expression passed to the linker so that only the objects that were actually
built are linked in.

Place the wildcard expansion before $^ in the filter to preserve the
original link order: test objects must precede libbpf.a so that GNU ld,
which scans static archives left-to-right, pulls in archive members that
are referenced exclusively by test objects (e.g. ring_buffer__new from
ringbuf.c).

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e8e92ba9d5b4..bfdae212037b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -734,14 +734,14 @@ endif
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
-$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
-			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $(TRUNNER_BINARY)-extras			\
+			     $(TRUNNER_TEST_OBJS)
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$(wildcard $(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.53.0

