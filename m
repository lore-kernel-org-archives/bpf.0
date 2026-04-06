Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E839479B
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499761; cv=none; b=iQn0XZ2Xdt3vOe1dbzuetZjbq6rMqgsoci8mkV36xFu+KUvoTLrHRfjXgEJq+6gI9lu2ITLv9J11XgjrahtEPYrqPXGwIhY0yWZ66WIqtgsuCAECZpFrf62UTimtIRPC79CzsMY2WTtpJZeXi83jIrRbQ7BQHrOKU8zwHMlTeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499761; c=relaxed/simple;
	bh=AEn3z1mU2fpCck8UIIjXl5+FxsZFquBJDrd1WRW0HDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwAjnRY+IjU1FIOPkj7bAl+tri7mge01TFdTt+sHjy9MbKkcb4XDQB2uzxr6XGxaRsMHwLmZ1YWyO5vRR4excS87OXpGyu9SK9bF9AP1XFixSico2GEM3B4pig0JTXqvdopyvRowtD3zNOM+3+YnDAe+GQ6nlK8jWzQuxhEHtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yk5O4e/T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yk5O4e/T"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so19725995e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775499756; x=1776104556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvAeDkBxqfN6WYXzL4jwsf1x31D4pD7nsRyWJL/PC4M=;
        b=Yk5O4e/TcP4UHg4r9fqardAFgS32wulK9Ba/8ErLnZR3DJm3jXicA3l2CnBubYt0HF
         fgPLFKwFdZT+KGgqeVdNdme9xJ88cmiWjTN8YOYco0Ntoow0NvhtgP+q20hwwMbhoJix
         yd3VYmRfhjDkHlPBz8rbM6CoeMMXoyFd94QW/a1YaV3ZreBZqb5n4Ms9qRCYro4oGDJJ
         0NZvSzrXBylVWnAIt3JostYy225fB/r6cz4YVl/EmGfwnEO+xLlTMpi7QTcwOhjeAoLU
         5jCPv+a4hXEhjFkiJIUDWXnKZMUhn/oLmLsrivTGh/+GCAPzAwELO8z7teCD8J2nawxi
         1Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499756; x=1776104556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvAeDkBxqfN6WYXzL4jwsf1x31D4pD7nsRyWJL/PC4M=;
        b=nlPAqjAPJDdwvWwq7/BA/ATCB4GTOslDo7CtjcoovgBc2KT7KQb4HYEj3qvRIJ/aYK
         Elbq3Pj/G3mgfo70QoUVl/06rDARKn3eDNkZ7uTIL9EknhX01V0ZhCET93NxJetXZ2nC
         v2cOvmcUIDMonGV5VTEj2ti/4ZW/FnkcBA3TatAtrHQC8WfuS/deyAeY1ny8fLRJtevb
         Nmeva8U0yIdmQ9M0oSflmNnRc1wn9weZYtAAkXOxo03EzBu4yRHHZ3nHjVwsId834HQO
         9oae07UCjqfHMXZ+UsKDA7p+fDXCfDXUB9ePMPK/L/1LReQozvQaDRJ+G6FFauM7JmKJ
         jWBQ==
X-Gm-Message-State: AOJu0YzqAWD5rmxeWyQ5zSfKCDG9pvG2s8/X9MG29rNbJaZckesWnj5T
	uys1ItaQvoT7juiI9v1/S3zTidocmgDNUdP9oWlJjhdfY3TY3jsZoRmWtPNt7y/3oBQ=
X-Gm-Gg: AeBDieu7bUQoRUNLOyuEBRhQSV+GZ2MHPDVSpZ6+EQMwLBLpt6wbPcFi6Zj7kU3ey+w
	t/ZMLcH4pRB+lHOrIg0d6JEXpi+V5r0366PwfwJU5XhOfX2GRopox8ZgNE0soNz1hz6oMmCGosH
	n0rI5Sff+f2M5LYGcLbALgWiR7PxjNwdTyrhdSVNZ82iFHlyT/84D+/630yRRwcTiLUEG6n05ce
	mKKsjhE1OzWAAuWt6ZheH+qKY19DvwpxToONhDGgbxjBV0nERf4ACA7jbB0uTigLVW4h83kdY0/
	39BtIR1rWreBHgFVbabaSKCPuMYFm/pQZe+ZsdlGdAPmgwjEJeyThlWFFyi33VV0tDImBTwF6ol
	BkV4tkSXA+ldonR1WK0R5LpWfEQ/iCjcTBrzn1RYsGnuPQaq6+SJ3nvvI+HhjqT6QeQzjHyIMvp
	2G0AhaRS6y2arAtMedBCrpZ2o=
X-Received: by 2002:a05:600c:6305:b0:488:80b6:873a with SMTP id 5b1f17b1804b1-488997a4679mr190079425e9.21.1775499756358;
        Mon, 06 Apr 2026 11:22:36 -0700 (PDT)
Received: from localhost ([2804:7f0:b767:120d:a4df:3777:2c55:2b95])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba80290sm17348275e0c.3.2026.04.06.11.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:22:35 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Apr 2026 15:22:17 -0300
Subject: [PATCH v4 05/10] selftests/bpf: Tolerate test file compilation
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260406-selftests-bpf_misconfig-v4-5-9914f50efdf7@suse.com>
References: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
In-Reply-To: <20260406-selftests-bpf_misconfig-v4-0-9914f50efdf7@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775499736; l=2101;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=AEn3z1mU2fpCck8UIIjXl5+FxsZFquBJDrd1WRW0HDk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBGQdeW+jOhSS10zVM6eVqN9J9HSgNEoIUL7UQZAhjF5JdjlnXJ+GxuPnnJgJafk3RlAsBnZGvu
 ywAuIQ2YlbAs=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal: remove the output object on
failure and print a SKIP-TEST marker to stderr. Guard the BTFIDS
post-processing step so it is skipped when the object file is absent.
The linker step will later ignore absent objects, allowing the remaining
tests to build and run.

Use plain printf and $(Q) instead of $(call msg,...) in the BTFIDS block:
the msg macro expands to @printf which is a make-recipe construct and is
invalid as a shell command inside an if-then-fi body; $(Q) restores
echo suppression at the recipe level where it is meaningful.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 72f576a8236a..e67f9c4cb5d7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -688,11 +688,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) || \
+		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2)
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
2.53.0

