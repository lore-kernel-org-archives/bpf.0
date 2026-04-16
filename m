Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F63E7164
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367895; cv=none; b=oS+1ZRLwMCTw93lxqIgwlDNx/UbLTdn4XNl77Zj3+wb/V8kXK2q4GgoEoVB+a71kOHjODWWPlfc2Hn472PJj2g4dobfO+38OglP6Az0gQ7iPyQnWgSPvyrEa8IHy4X19eWW15a6VIcM3dWLhW92isMQVbDHjHUaLoKrCVAjLquY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367895; c=relaxed/simple;
	bh=5U8TIbN/mzwNj1zjJeSGJwHzlD5O57QgUuewKq4KEws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbhDYi9N+VY3pz7iOyMcHYSj8N65u8V+jvg+gZWW90g7V1k3HhqG0+bRQghJ3R3PUDJ2ZT819eVMBtYVwF+CfkvdEetFZqGu6aNnyOJf6n4YqwP6XaUXtMGio1e+67kJm+oZHmjqwKV3ewtYVepVneeL5yFMnTAHZphWHYwNTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mn2s994n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mn2s994n"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso9696875e9.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367889; x=1776972689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXKDU/OMVkefnHkZO//qI2CUfyjPw6Bi2G+7mqZsuYM=;
        b=Mn2s994n9ktSonoNdoYZT1QLOccsn6jW7AlU/e9bXOvQU7dsb0Dxr814i8iVrpF2zw
         oVF5qTcr+N6gEkMRAq0u9L26O8i2xWWmVRLF7GixEBa1SFvEgxe6K4aPkMq+RMuc7Ruw
         poPsKAx6db/JfcWxqTaJVrpURRWjElH0wxPiE8om88YY1hQ9e9f8ayeToYf7gXLBP8bS
         xcCk0eqLx36QUr2YLYx77bGbwSdO/FwqYb85z8UhwEL83dGrTqGbGneW8HdgsQOAF7ej
         tMJh24ATyvCOPmy3YBjGcL24NKjzpUrFUIvgfsbqyDqKuExjsXjyU/iBEV2PRRKnsuQH
         +F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367889; x=1776972689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VXKDU/OMVkefnHkZO//qI2CUfyjPw6Bi2G+7mqZsuYM=;
        b=i7JJh8rk5Ue2Gvk3suhjbYg9EPIgUiVOD7mE5EWx7ipAU/p7r+a00XH5BmglRwzP/T
         Kw2Luuu4xzP45KjgJvokzWO3het7vOOgVf9f0+pQHNCdHNbIGxompqxTijr1g6OaLnLs
         NDHoPWIS9gZ6pMJMNZp7zF+z+HIoCDLqwoOj/YrVrTpq1mVYjPaF+JVbHCf27mDKnPHQ
         jpnekVHC4+JaCA2l/oVdWyCgLN6Wfn4osBPAmt6lOh0EKS1jISDrCiQnnnzjTpS6yb3d
         J2uXhxZuXFOetKBbFumMH2I/Ldlp3mw4clIBfQ0XcwTg5w8xxnR7iz5rfcgIhqVUIfCu
         JDRw==
X-Gm-Message-State: AOJu0Yxwpp6wzss0F8vZZd9w9Ei1c10xE/QjQuVbYIjAD62hVOfC1Y/P
	x2zU3yi+tIM4H2N5aakoFMZxZq5N80zzM35q2SIOmkjnwG6pzI5LM64+2iD6U15qRUo=
X-Gm-Gg: AeBDiesKIPV1h67lLaVoUNB93qd8NM7j69+/YrPcD7Tn7sp/Zks3Atz1XRwI2w1gDFY
	jNZNIyPHXG9HSplx6wITjUX4ElFeqZrfmsjSZN2Yd5u8Eps3Jph+m5mUh90uxkEGwe6dOLp8UJh
	98VWU+e2L8AslCGoGTTUi2XM8xwD8zXzbP7Si+HkJn3OcfPSvtqbj1sO9iuFuxF80U8iRpF1PHz
	OW0b3yfhfEm+hc0KojA2Ji91olNHjzzmB4p1ABni9z2Esie/tAa4Uo8szY7hw97PuK4EjLO42vp
	ztoJ1rL/Dpfms1Gs1HHZEN9pmMvFl4/YkfmUSH055C3uUSRGnDwClKo70VZOEE5dXu8hG6jUer5
	ItrciUS9nNakomixDKMmXWnLhYnXQEwq5UOp7RE5W+uPb/A235LV6blovZrufd9YiOEGW6biif0
	TfdCutcZFr+hKQicqzOaG8bNg=
X-Received: by 2002:a7b:cb10:0:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-488fa8ec417mr5190175e9.10.1776367889102;
        Thu, 16 Apr 2026 12:31:29 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f6615d5sm10798290eec.24.2026.04.16.12.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:28 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:57 -0300
Subject: [PATCH bpf-next v7 08/11] selftests/bpf: Allow test_progs to link
 with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-8-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
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
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=2156;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=5U8TIbN/mzwNj1zjJeSGJwHzlD5O57QgUuewKq4KEws=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QONTkF/ZR6INLgA6jIuOfO+7ACHpfnck930ufRHZ8hvwjxS8M6MclxSL84x2+0W8DdhP3yinoQg
 fJwg3i3v+Swo=
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
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5ad50d3ff2f8..a5597e8431a0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -758,14 +758,15 @@ endif
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
-$(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
+$(OUTPUT)/$(TRUNNER_BINARY): $(if $(PERMISSIVE),,$(TRUNNER_TEST_OBJS))	\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(TRUNNER_LIB_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
-			     | $(TRUNNER_BINARY)-extras
+			     | $(TRUNNER_BINARY)-extras			\
+			     $(if $(PERMISSIVE),$(TRUNNER_TEST_OBJS))
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS))) $$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.53.0

