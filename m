Return-Path: <SRS0=ch4g=U3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE41C4321A
	for <bpf@archiver.kernel.org>; Fri, 28 Jun 2019 23:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B41208CB
	for <bpf@archiver.kernel.org>; Fri, 28 Jun 2019 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOi62sK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfF1XKz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:10:55 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37791 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF1XKz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 19:10:55 -0400
Received: by mail-pl1-f202.google.com with SMTP id w14so4317331plp.4
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NgrRIARcyMWOir0ruPBISSB6ahNutZuUALDllPdbWtc=;
        b=nOi62sK3W7g/Z1kdRAEpN2WpY2rn/vUB+2aUGV76qht9s6DWtapkyO2YaBmeKtS7hh
         JQb63Go+5ZoglL7v08ZbPk59nzQWTA36HsJrA1NCDaYyyq+6ZUq707YGyAQD0n55BWTl
         U+nZBG5nA/EWKIj0nD73P83Gvf6cQpQA3sfPKck6dh5KCsrZeJEFBw4LvGXd7hzrzLdZ
         0tytf6emNHqur/94NXiS3iTX5wySniX1hK0EH5H4UB/23IlfYnqssVRgiuz+ikdopxqR
         ZpdBBrO98275SoXZv1Pb7OstAbuPStp08csWV+q/ri6JEXU3jzZkXPpKvwh0Dv0TljOV
         qMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NgrRIARcyMWOir0ruPBISSB6ahNutZuUALDllPdbWtc=;
        b=EQa/bK8iYFsQvVQAuuOV8+Se224q8lPk+jRxfzZYTIKwQUoAWFwMhhxGza8QRO75Lv
         Ua9BuIU4BgQ2sM2ixovJcE0Dj2uj1oL0JlxxYMhpssaTJeog5f8Pr+i0WYNBs3hbnjQT
         hCuAndgqirf+zW7vALxtRZ/lWu75fCEQwJRtUBNJ1XkWj3r38To3v7X9NeMII7TLgzZb
         8HSwT0Bb0taxD306hIG42zMsy1KGUVCMwIuFz5HfG37q8IPEqB6v9qgPja5BTqUBgOMC
         R6Em9UQGBwngeJanJkvlmYRDyQ+7UiL0rIhfGmRvnyzXCEdm7ju9VR6CW2phECZJk7WZ
         dlBA==
X-Gm-Message-State: APjAAAU+weWw77Yab4qmNiYqMdJGDHAx+XpxAbG2z0oXmEtEcVkT/dtO
        cOyihUcke8q4VgjSOOwB6mmLGDk=
X-Google-Smtp-Source: APXvYqxl7zrL/BNrQspBBaD6a+tszMiVgWXXfRGmbb1ELsvO2mUrZn/ykq8q8MKu44I0HU1kA9v/e4o=
X-Received: by 2002:a65:500d:: with SMTP id f13mr11361343pgo.151.1561763454299;
 Fri, 28 Jun 2019 16:10:54 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:10:49 -0700
In-Reply-To: <20190628231049.22149-1-sdf@google.com>
Message-Id: <20190628231049.22149-2-sdf@google.com>
Mime-Version: 1.0
References: <20190628231049.22149-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: add verifier tests for wide stores
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure that wide stores are allowed at proper (aligned) addresses.
Note that user_ip6 is naturally aligned on 8-byte boundary, so
correct addresses are user_ip6[0] and user_ip6[2]. msg_src_ip6 is,
however, aligned on a 4-byte bondary, so only msg_src_ip6[1]
can be wide-stored.

Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_verifier.c   | 17 ++++++--
 .../selftests/bpf/verifier/wide_store.c       | 40 +++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/wide_store.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c5514daf8865..b0773291012a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -105,6 +105,7 @@ struct bpf_test {
 			__u64 data64[TEST_DATA_LEN / 8];
 		};
 	} retvals[MAX_TEST_RUNS];
+	enum bpf_attach_type expected_attach_type;
 };
 
 /* Note we want this to be 64 bit aligned so that the end of our array is
@@ -850,6 +851,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int fd_prog, expected_ret, alignment_prevented_execution;
 	int prog_len, prog_type = test->prog_type;
 	struct bpf_insn *prog = test->insns;
+	struct bpf_load_program_attr attr;
 	int run_errs, run_successes;
 	int map_fds[MAX_NR_MAPS];
 	const char *expected_err;
@@ -881,8 +883,17 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		pflags |= BPF_F_STRICT_ALIGNMENT;
 	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
 		pflags |= BPF_F_ANY_ALIGNMENT;
-	fd_prog = bpf_verify_program(prog_type, prog, prog_len, pflags,
-				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 4);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = prog_type;
+	attr.expected_attach_type = test->expected_attach_type;
+	attr.insns = prog;
+	attr.insns_cnt = prog_len;
+	attr.license = "GPL";
+	attr.log_level = 4;
+	attr.prog_flags = pflags;
+
+	fd_prog = bpf_load_program_xattr(&attr, bpf_vlog, sizeof(bpf_vlog));
 	if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
 		printf("SKIP (unsupported program type %d)\n", prog_type);
 		skips++;
@@ -912,7 +923,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 			printf("FAIL\nUnexpected success to load!\n");
 			goto fail_log;
 		}
-		if (!strstr(bpf_vlog, expected_err)) {
+		if (!expected_err || !strstr(bpf_vlog, expected_err)) {
 			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
 			      expected_err, bpf_vlog);
 			goto fail_log;
diff --git a/tools/testing/selftests/bpf/verifier/wide_store.c b/tools/testing/selftests/bpf/verifier/wide_store.c
new file mode 100644
index 000000000000..c6385f45b114
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/wide_store.c
@@ -0,0 +1,40 @@
+#define BPF_SOCK_ADDR(field, off, res, err) \
+{ \
+	"wide store to bpf_sock_addr." #field "[" #off "]", \
+	.insns = { \
+	BPF_MOV64_IMM(BPF_REG_0, 1), \
+	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, \
+		    offsetof(struct bpf_sock_addr, field[off])), \
+	BPF_EXIT_INSN(), \
+	}, \
+	.result = res, \
+	.prog_type = BPF_PROG_TYPE_CGROUP_SOCK_ADDR, \
+	.expected_attach_type = BPF_CGROUP_UDP6_SENDMSG, \
+	.errstr = err, \
+}
+
+/* user_ip6[0] is u64 aligned */
+BPF_SOCK_ADDR(user_ip6, 0, ACCEPT,
+	      NULL),
+BPF_SOCK_ADDR(user_ip6, 1, REJECT,
+	      "invalid bpf_context access off=12 size=8"),
+BPF_SOCK_ADDR(user_ip6, 2, ACCEPT,
+	      NULL),
+BPF_SOCK_ADDR(user_ip6, 3, REJECT,
+	      "invalid bpf_context access off=20 size=8"),
+BPF_SOCK_ADDR(user_ip6, 4, REJECT,
+	      "invalid bpf_context access off=24 size=8"),
+
+/* msg_src_ip6[0] is _not_ u64 aligned */
+BPF_SOCK_ADDR(msg_src_ip6, 0, REJECT,
+	      "invalid bpf_context access off=44 size=8"),
+BPF_SOCK_ADDR(msg_src_ip6, 1, ACCEPT,
+	      NULL),
+BPF_SOCK_ADDR(msg_src_ip6, 2, REJECT,
+	      "invalid bpf_context access off=52 size=8"),
+BPF_SOCK_ADDR(msg_src_ip6, 3, REJECT,
+	      "invalid bpf_context access off=56 size=8"),
+BPF_SOCK_ADDR(msg_src_ip6, 4, REJECT,
+	      "invalid bpf_context access off=60 size=8"),
+
+#undef BPF_SOCK_ADDR
-- 
2.22.0.410.gd8fdbe21b5-goog

