Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70FC433E0
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0648D20748
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/mD7emO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgEVENY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 May 2020 00:13:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727855AbgEVENY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVaBHuBZiPMio5n6+cHf34Z5EOFYq+BTGPO3x/dfqR8=;
        b=W/mD7emORxK1XJ3DIaibR3fZjzIMsgtWshaIBolwVAUeRF93WbAjKCZhkuEypsznlY/3Ku
        9wSlXwm9ZY34MHNPZlgHayNLry4EIYY11+IjQ4lxGaUNwK+xwk3eYUln6tK8ykh3jJCS+o
        Wn03+jBa/BN9QWfQt38BAe5Ws6TVM9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-WPlgWLLTNqiScosK6isK7Q-1; Fri, 22 May 2020 00:13:20 -0400
X-MC-Unique: WPlgWLLTNqiScosK6isK7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABBD835B8B;
        Fri, 22 May 2020 04:13:19 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBF65D9C9;
        Fri, 22 May 2020 04:13:18 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 3/8] selftests/bpf: install btf .c files
Date:   Fri, 22 May 2020 07:13:05 +0300
Message-Id: <20200522041310.233185-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some .c files used by test_progs to check btf and they are missing
from installation after commit 74b5a5968fe8 ("selftests/bpf: Replace
test_progs and test_maps w/ general rule").

Take them back.

Reuse BTF_C_FILES for TRUNNER_EXTRA_FILES.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
test_maps w/ general rule")

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f0b7d41ed6dd..19091dbc8ca4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,6 +46,9 @@ TEST_GEN_FILES =
 TEST_FILES = test_lwt_ip_encap.o \
 	test_tc_edt.o
 
+BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
+TEST_FILES += $(BTF_C_FILES)
+
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect.sh \
@@ -362,8 +365,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 flow_dissector_load.h
-TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
-		       $(wildcard progs/btf_dump_test_case_*.c)
+TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(BTF_C_FILES)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 TRUNNER_BPF_LDFLAGS := -mattr=+alu32
-- 
2.26.2

