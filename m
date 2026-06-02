Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BC3E958F
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405429; cv=none; b=k9BLC4oP+QWsLaoiCwD1z82xMzTrjWYzMmD8umz81/AHNiFJOr/5XLXeRkucIUMB33+NiLvj0Tj3and3n5p9OUEKQUU/o596NCul6gv5MOE8VWXLolUaAdVjyaAcj0IsyiBR7Gd/WRHFqHRt16GLn/bV0Es7TzTAcnHIve0vM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405429; c=relaxed/simple;
	bh=7A4fZQx0aF/J8ZiO4w5oZwZY/WHVX7IeMpF2Uvg7m20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YN58PjfGUqP3wWJTgfBsgNSpu/iSVmzVAzCj/9Xp12h42Z7g4qZIZ7YpsLfKFw9QSsHAxihbH93Lp/NMqj9LC0rBY2Re/CQPaxDZQrJsGTkKPp6UcJeMPef/zNXxAH69+MJcOV+rrVdb1IGrjssNrdgI26niYX86pqbAeIXhtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HcVj9Xki; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HcVj9Xki"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec49f7e35eso326000466b.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780405427; x=1781010227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qcfi42iIquMiKz4IUa3Xe6ZkcXakXKvJ4psdLxPT3Cc=;
        b=HcVj9XkiS47kvXQ1v3kBUPN4KBKRp4BpUU54RZax8FbQGFDijCO/lCDI6TE0Z78cjn
         PkBfiu/AXWFi5wOLh5kJGXwrBa9tQPxY7esA6qudqZBHLzWkCSyXQ3Dq4hnRt8Q7j9uj
         6pY6YdzKPJl7duzbdNjaHEw4dBzhZOuy3sRzxTL0esAz6BH7ChCBmfSCMMGZyDBilo86
         l/7Muv6OSXjzsFRdZ4QADc56r2tk+/kAkupNXZ5e6mGPDCP2IsDuaXPCWYUjZBYo9eZk
         7DAIraopSaqgIvWOEogblCMksFjYZmoUzSDstCBIYhsThZNrNhwoadayzvLUI432KVAi
         NVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405427; x=1781010227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qcfi42iIquMiKz4IUa3Xe6ZkcXakXKvJ4psdLxPT3Cc=;
        b=gSrHRtu+2f8zP4jtbes0ST4W3WK3q7nYkYufCGmSA0mueF/q+S4ecHB/X5J/T/Ka+Z
         oCJ15WBSNXZHAOs6B/aYxXnAWU6RoKATXpCBQJGcFRLmgldeiSU8euG5M7AxoTPMXVzT
         7hiGRoYJb7HG1XOdvANOOuGkfqNq0tyCFdAplb38piUqKyP0XVnYlLUqBk1oL3YKzA+l
         mYJ2u6MhonfVM+/ZUCBfxSSMCrOaJQPx6U0ToIFgq6i0ktpsWM/2HPrySxKOEaQSFJvY
         WSI5i/+F4zzY42bpD0MxB3FIDAdIxfj3hd05OKoh7+4qgKFaje3TuZQBrVjiwD37s0H+
         97mA==
X-Gm-Message-State: AOJu0YwDKI+ArbvxyuOH4Ej8VuFon1Sy64qEKFqE1J1AIKwKK7l6II7U
	ytqilnkPF6wTg2Whb+KvK5GXFRyXLJPZcpd/VZuH8fQ+mUhyjbnBWlwPAeJgGlXP4tg=
X-Gm-Gg: Acq92OEE5ZvowJ//0Tk/Q0eAKsx35qdFqG3Vy0nCeuR9KD5FTojScdJ7bMatRPGzTng
	qZRoI+rDmWOeBFJADTeE7fk6j5wnwpgthBrHGQvf6rclCnXrtV8qu6xQQcDSsrF7hNVUpYa61iD
	YEJyoT2Y3zhqqpLQZZ3vHebiwIg5uerui7RCUC4IgSSjB1PzoKK3SMXuHtXuFoqP13SrQ4ovj8o
	+NFHT9wfmX909dOCPrAd3mW2WWryDgYqqvWRiSUYJYRY1saLY6IrpFmeAkELEv+01EemkN/NHnX
	EswO/nbqcyNs6/KGp2c41fYddr3U425KOEIadO2gHRMf0z2qxTOuhW57WA+JFqJHx1VS21HRdBm
	KMvNWWsumZpN9uH2sUJ1HixwJ+z9mlEayZuxnDOKAdJNaA9D9pD5pXDy4Eu1PijdXUmoIMPj1lF
	wntvu0Bw7n1Y/8M4eqlMktwg==
X-Received: by 2002:a17:907:da6:b0:bee:b5f2:6385 with SMTP id a640c23a62f3a-beeb5f274b6mr310434366b.11.1780405426568;
        Tue, 02 Jun 2026 06:03:46 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e15:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bef89493f1dsm79315566b.59.2026.06.02.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:03:45 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 02 Jun 2026 10:02:57 -0300
Subject: [PATCH bpf-next RESEND v12 08/11] selftests/bpf: Allow test_progs
 to link with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260602-selftests-bpf_misconfig-v12-8-27f898b3ba26@suse.com>
References: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
In-Reply-To: <20260602-selftests-bpf_misconfig-v12-0-27f898b3ba26@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1780405395; l=3578;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=7A4fZQx0aF/J8ZiO4w5oZwZY/WHVX7IeMpF2Uvg7m20=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBG1tN2EHmzMbhlbqbAZoP4pxTRHSDvZe6y2rsZ4MnYO4yU0yK25T54cnpL45Vvl7K+m3C/O/Nk
 i3a3CYjMjywY=
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
index 7739799c2566..bc845022a7ef 100644
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

