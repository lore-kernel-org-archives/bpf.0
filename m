Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898A40FDB1
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553635; cv=none; b=r593bZCvisDio1qUPfvEs/5hVzszg83GFtOzi80B6TPYhQ0TUmVZ1AkXPHfixkJbmQ8GGIRXD+ZPP2hkShkDNtiNz+9InmqwSJFuQKFqRU+6nFHefWi0ZVqk662oy/fWLvNH1gzQ45E5f2MSs9ub51JoKEmQ1snwxIYhmfjeuTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553635; c=relaxed/simple;
	bh=I2jxLztduWlfcb809/jc6vkR7pIiCKbFQIGItdln2/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amCVZW6BsExC/ZgXS/yvKc8ltXM5s35KZKRN+CJzAt4lwLU/E7hD3AVunxBq/fer1vr/HdUfiLa9s1Pn+kmtF/s414fGoTuG0wkdb64LSUSTF8nYRTOc3ePCutg0FBlv9W3rG4Szby4ah4tAWK9S1jJUzwZ9tK0npBQJkRo+jjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U/6MQlw6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/6MQlw6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso7461005e9.3
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777553630; x=1778158430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+XbIgjuLQuX1ZjiX/bxTtSVSE3u4tQE56sxmhIL67k=;
        b=U/6MQlw6i3VPQIReT8bkpkgWOQiaApuJQQ30NrlDSP6FP/zKOCx3G5MKHavp99xZ78
         d/UnMFG0yq5QDHd9HUIuv+xzPXVMRFkCpdw91vAqlAjf0jlEMlbUAse7qB/dxv51FJNF
         sa8D20APeAJxVZcrAeaI8oyjNsDDAtZs/hiYhk4LWiLpMGMEb1EiqwZmMYGoUWgYemmR
         v7bnbytM3LAEQ9uhSju1npLzVqPYjyg+MswOx7TZtZnAa6iX3L9+Q4+eWvS1JDM7eKfa
         mVebM9xF12XpyZhKEBY39Ba0zusHQTtdGS7ZMCDDe1t5y5bfX76etASiT3ij2MZGSyl8
         HqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553630; x=1778158430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+XbIgjuLQuX1ZjiX/bxTtSVSE3u4tQE56sxmhIL67k=;
        b=iml6x58H4F4KULdi/rQWrpA7Ue5RASvyye1I5DPh+j1+/83n3/VJP/DCuyS6vb+4fb
         ln9F+8VoEqCSAvFAZc7tSN+vYql0EyOXdSfSAgjLPoPDkXr7H7xQVX4ltf7Tt7VZenyg
         O4CUzYO0o6mvMhi7sbvHtbUlfHFffMvf6UorTf1NlFarMl2VVvWipas6jqmStLWRpyE8
         Gj/OpxhO15PWMUXdp6yp+5L17VZU6ITyJXrtj9uCqp/eS/5FNkj6UPQVs2CuCK9ywNNz
         QSqsaUR/TndtICWsmFzv1aTPCgcXIzYPFfPkvgUuRS2gxh7Dby7rO6W8qTUCCSpO59aq
         eT0Q==
X-Gm-Message-State: AOJu0YzIcrUpFh7NczTqpVm69CgM9pxBp5bvVAf3Dmp4mooPRigXT4+d
	nJPtpR/Hu2tRS6RBrppCfTOHJGlGM+X4VYe3Kuy1oaq6n/LN1phfSv9NaN0ocq3Ccq0=
X-Gm-Gg: AeBDietjIsJJRBz4RGTcv+d40xU0vy0nscZo9YCrylGYNJBshAFZf07bUw3y0PqpMYN
	AFpg98hvdqe30XlHGoumqv4CqiS7nMoO49zj2B6vpkkwX0mjLLSzAehUIyLmc350rSn9+Y/r5bW
	2mSUUJoQhRUlb7ph72s7c32EGRrwcwhM56XfKKhi9iGbMYy/NWff79JHXWCWjrS2OSx+aUsuJ1I
	zFRJHmy1G0JekMtN5Z2tZf/d02LsOp4c1RPh6FqdJn8RDnLlZioaPXSPzt2xQLXL+L0gQx7f1uZ
	IQ5DUIMaN0Zpw5pnXi25QQVoMojtLs3AUy9XR/5Y/aIbMax8iikUJX7rU7/1SFxLY2tudDHmcHq
	Z7grEWLr9tKUbjgmb8AgJY1U9J6nYlwEK0eUy9dKj4OAhjEZypIbHg8HprkbLN5J+PUHwECqf4G
	h8BEsCIjCUd8R66gCs/8Ulx+WW
X-Received: by 2002:a05:600c:4688:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48a8444d7a9mr50732385e9.21.1777553629800;
        Thu, 30 Apr 2026 05:53:49 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c07058esm8543218eec.15.2026.04.30.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:53:48 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 09:53:20 -0300
Subject: [PATCH bpf-next v10 08/11] selftests/bpf: Allow test_progs to link
 with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v10-8-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-0-cd302a31af16@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777553600; l=3578;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=I2jxLztduWlfcb809/jc6vkR7pIiCKbFQIGItdln2/s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKqqdQsm33ueetLi82n66giduvjncuOEMLEwyV2vO+e5ZLsOaGwzTZasZ7Pb+J1KfYDzndi4FiJ
 5jpUI9g0qewY=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

When individual test files are skipped due to compilation failures, their
.test.o files are absent. The linker step currently lists all expected
.test.o files as explicit prerequisites, so make considers any missing one
an error.

In permissive mode, declare the test objects that already exist on disk
(via parse-time $(wildcard ...)) as normal prerequisites of the binary so
that modifications to a test source still trigger a relink, and keep the
full TRUNNER_TEST_OBJS list as order-only prerequisites so that initial
fresh builds still produce them and missing objects do not abort the link.
The recipe filter is split per mode: in permissive mode it combines a
recipe-time $(wildcard ...) (which catches objects freshly produced via
the order-only path on a fresh build) with $(filter-out
$(TRUNNER_TEST_OBJS),$^) (which keeps the non-test inputs from $^ but
drops the parse-time wildcard duplicates). This avoids passing the same
.test.o twice to the linker while still presenting test objects before
libbpf.a so that GNU ld, which scans static archives left-to-right, pulls
in archive members referenced exclusively by test objects (e.g.
ring_buffer__new from ringbuf.c). In default (strict) mode the recipe
remains the simple $(filter %.a %.o,$^) since TRUNNER_TEST_OBJS is part
of $^ exactly once.

Gate the partial-link behavior on $(if $(filter test_progs%,$1),...) so
it only applies to test_progs and its flavors. test_maps and similar
runners using strong cross-object references would link-fail with a
partial set and intentionally retain strict link semantics.

Note: adding a brand-new test_*.c file in permissive mode requires
removing the binary (or a clean rebuild) before the new test is linked
in, because the parse-time $(wildcard ...) is evaluated when the Makefile
is read and will not yet see the new .test.o. This is acceptable since
permissive mode targets tolerant CI builds rather than incremental
development.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9becc077eb23..a64e822dc540 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -773,14 +773,15 @@ endif
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
-$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
+$(OUTPUT)/$(TRUNNER_BINARY): $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS))	\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $(TRUNNER_BINARY)-extras			\
+			     $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS)))
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $(if $(filter test_progs%,$1),$(if $(PERMISSIVE),$$(filter %.a %.o,$$(wildcard $(TRUNNER_TEST_OBJS)) $$(filter-out $(TRUNNER_TEST_OBJS),$$^)),$$(filter %.a %.o,$$^)),$$(filter %.a %.o,$$^)) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.54.0

