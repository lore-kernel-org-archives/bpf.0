Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A738C2D6
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286799; cv=none; b=Y1xKm92AqdoUzqyZIfYni4mv5jf27D0VUtQyjb3p2PMN9DSMZT12D0oA57bEQmWz1hQxTEWVSS/i2RE2rySOigVy0XdPQOA9mJ0MMatJSlEHCZW+JmcU7/yOVQzDHzSIRQJQ7+16rxHWele0YWnYycMex9RYH/InKgKxwY/ZYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286799; c=relaxed/simple;
	bh=sd6o23TXTQBmDe9CNsrT1vAQRg7+CRHUQ5cNo1CDVZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpi7P+Cyyp6G7jlY2h/Vi26d1Wkqm0cGR7fkj1gdMDQvf9q9ejBbloH30vxPCTPUSAs94pvOLeOLI0jn1TkTRxPao+kDZAZb6SMBU0jJYGNQSttkGwveDxtzIRFV+CG5pEZz+UjnFPCHZcVZdQ8ofitQo/RVyu3mguGOEoxVJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YEZknZHP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YEZknZHP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso73850235e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286796; x=1776891596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+LZLrUSOhq9xIydX+pHIEZAmNfKMNGZSAqdkfa11Ks=;
        b=YEZknZHP9aKPxjBFdRAVs3+YLbAsxo+p+/iUXZR+fmfnc5uCJNOCP3gs1ehyDV9PdL
         Ry6A96FB8ZpHN08SBhoofaPV54RSbyhvuSNwgSPX/Q/XCCJzyz4TpS+w68gS3cblVuY/
         1stdb48ePH4G3nmSmmik1WPKqT1E9GOG2SLLdqVbakeLlx9Slgc9Z6Fqj1CcZLjbF0HE
         oDADoL6SG5HR5N3OlHHle8vYXbd3vg+oB5VlI7x8Gkw9cUKTqzzaVWa4bYxcSrloJIpw
         1ogabcCL2ZMzmA5Co9lHHpRddnSTCaJIzq6l4KP2g1UoP7sBo/sCNERJ6pjVH072XeBY
         idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286796; x=1776891596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+LZLrUSOhq9xIydX+pHIEZAmNfKMNGZSAqdkfa11Ks=;
        b=OAgGQAPLdX15M9/XsLgDJBRMfP46O7hv52h/5AdboIPkIUP84bEVFhLiaUC/xnMEpb
         9zbB82KIpcakTi0T6fa4WvCo1GvQj6Q9fQ9Y+HyG30iSumE/6rgH0psTp4jlyrTfHvRu
         MFLv3KfwD0yBspH/he7aQ1AH/4mls2xdoPK95SUg5qoks+qX4CLgoL9yXxbvprNIilxA
         Q10NQ93amvjH0KKpzHib33Tx8wMa/Cwq1lG8U2T1B+LbX3PHhsDBo4luxzRS5NDwJQaN
         CGKOto4SVytnA/CEdHloRMoPu6/PfsmxGAGqVitK1Ir/CpzRWOMwVODmek0o+LywNlyY
         T2PA==
X-Gm-Message-State: AOJu0YxoyTjSlUJOg+9S5FjRIAXsp3H7lAP2x3k7dAr0pE/QOx/zcq9H
	+W0aYwWr4/qU8vu7DYq1B2L1CnAO70rKCgjgqszSQsJmXCLawPsWZa+6ni+lBYg2EIw=
X-Gm-Gg: AeBDieti9RxNCwImgeBldOOqXYGGafx0f5itVBo0jhGMV0+0X5x0sLmGgOBctXefYuF
	+rWDyJeAWEogin6h3t6fTNxT/2/qVv4aU+G+wX0uHJILylt/yNOX7LqI9oVNyo6xXHazqwqSOyM
	jK7unv1cQisRsUjW8hYSGMsmcHrVE3+tLteZQtOrFTJozUPriE1qvAZv6tAFj0WIARCM/kzUnlu
	ZD77ZPCwlnEU6sW2uBGYohqxCVp7R4jH/vsfKl8ljasMpQaxHhMS2/OnyY2JV8YSOm1MZq6P99O
	hYk3/RdQdGTrVezc1RI6lMCr05yyiJr6cqDgQr3KPQWKrQqi11RMmeJdrxhH4i7O59j5ONpfDp2
	QuxVGjrcp0qO6IRv3NWCYiCtxief5ycUshP3tIByLI5iQt1ikgC29v0ftC+fukAQq7n4nOnFijY
	X8dIiKSS9SgWXOWGD0Sr36bQ==
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id 5b1f17b1804b1-488d68c2bffmr298755645e9.21.1776286795661;
        Wed, 15 Apr 2026 13:59:55 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:e41:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65f9bcsm5108876eec.22.2026.04.15.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:59:54 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 15 Apr 2026 17:59:25 -0300
Subject: [PATCH bpf-next v5 07/11] selftests/bpf: Allow test_progs to link
 with a partial object set
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-selftests-bpf_misconfig-v5-7-03d0a52a898a@suse.com>
References: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
In-Reply-To: <20260415-selftests-bpf_misconfig-v5-0-03d0a52a898a@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776286765; l=2150;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=sd6o23TXTQBmDe9CNsrT1vAQRg7+CRHUQ5cNo1CDVZ8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKF6hcje9wxrjG1OyZ3oiDzcAPEvRA/9gmflkFbNKl71F/Dnahqeq7yL0Mv6YwaWV6nV/2kL6t7
 4cQZwZlwgbQM=
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
index ee7bbfcd661b..128ea61fd986 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -754,14 +754,14 @@ endif
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
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$(if $(PERMISSIVE),$$(wildcard $(TRUNNER_TEST_OBJS)),$(TRUNNER_TEST_OBJS)) $$^) $$(LDLIBS) $$(LLVM_LDLIBS) $$(LDFLAGS) $$(LLVM_LDFLAGS) -o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
 

-- 
2.53.0

