Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEEC10F05
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F92084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="lPjZbeZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfCZSHD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:07:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38570 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732323AbfCZSG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so13942278wmf.3
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WODGgNlfRn0knXdqsfcqM64/Cy/uhyb81Y1sQXXXC18=;
        b=lPjZbeZ8VatjEKqhPKXWYG9JHf00LIlIilyXKHhJPcb0spu5Z7P++Jm0QKrFBf1DPG
         387yZ1/EPWTtwNuizEg9O/40N6ASjW5Nl9jFXRIEkpSWft1gmyeyOTY1bUwsXC9GZtYj
         Keoczi9o7Or5igLVnOFBN8gWWmIGSWhVaSKq2XRKxhgnlHj5fgMHltXqAOaXNYkqhMCl
         uBt2zcyY6wQc/wRm7aoiZWLBWQsWAPMSRAKf4YJmjxDFk/KPwo9Y/Cz+ufBNGhYvKMIG
         YjQOQH5+CluwHNetzPfS5xvjMkEew7M/NCqnLGFcFSTXi/r9jcaE42JqIHTCJO/i9RJu
         g5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WODGgNlfRn0knXdqsfcqM64/Cy/uhyb81Y1sQXXXC18=;
        b=CtvMAsgF6mOlxsv6GO13hmU8dQOzg0Re5DFWpaonZ5kKINQ24WqFpVVdjCQdivREc+
         6I8PGbF6bfc2RYo7QbMSVCs5mIYP5YjBeyirMTr6lbzrASTp0k4uVcvynQZkSK8iy9sJ
         E1XIgAztFpzoSBEmuRQDrRyVVgTPJW8UVO7bnU5ReP6zqNL6hZqW/ic7XDoYFilTOgrQ
         1G+8hYPNTr8t3leIKEQFT6Bff9Lq8G97KDToF2uxyBuo5Bu/7WlAh8dnJeM6EBjFzpIC
         U4EKrZMEf0AI+LImV0ZhlKeyouM0uWOirIaWW1nESoMTfcC+AXx0YSjtgfUF760IJgN2
         nfaQ==
X-Gm-Message-State: APjAAAXPPminWm+oNYaPYeV6jyKa+qX9LZ4yCAO8EEDDCIHr1HbJ6wgg
        vhXt4kNq2dkd5aG9dvRawW8G9A==
X-Google-Smtp-Source: APXvYqx9MiGNy82BzgezRbBmQ/es15vp3hHTFNLv0Jv2PdqqSDye2P/xc9G0/2zmJ1s+yP6KUrOlmA==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr15598321wme.54.1553623614878;
        Tue, 26 Mar 2019 11:06:54 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:53 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 15/16] selftests: bpf: new field "xlated_insns" for insn scan test after verification
Date:   Tue, 26 Mar 2019 18:05:38 +0000
Message-Id: <1553623539-15474-16-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instruction scan is needed to test the new zero extension insertion pass.

This patch introduces the new "xlated_insns" field. Once it is set,
instructions from "xlated_insns" will be compared with the instruction
sequences returned by prog query syscall after verification.

Failure will be reported if there is mismatch, meaning transformations
haven't happened as expected.

One thing to note is we want to always run such tests but the test host do
NOT necessarily has this optimization enabled.

So, we need to set sysctl variable "bpf_jit_32bit_opt" to true manually
before running such tests and restore its value back.

Also, we disable JIT blinding which could cause trouble when matching
instructions.

We only run insn scan tests under privileged mode.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 220 ++++++++++++++++++++++++++--
 1 file changed, 210 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 19b5d03..aeb2566 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -65,7 +65,8 @@ static int skips;
 
 struct bpf_test {
 	const char *descr;
-	struct bpf_insn	insns[MAX_INSNS];
+	struct bpf_insn insns[MAX_INSNS];
+	struct bpf_insn xlated_insns[MAX_INSNS];
 	int fixup_map_hash_8b[MAX_FIXUPS];
 	int fixup_map_hash_48b[MAX_FIXUPS];
 	int fixup_map_hash_16b[MAX_FIXUPS];
@@ -257,14 +258,33 @@ static struct bpf_test tests[] = {
 #undef FILL_ARRAY
 };
 
-static int probe_filter_length(const struct bpf_insn *fp)
+static int probe_filter_length_bidir(const struct bpf_insn *fp, bool reverse)
 {
 	int len;
 
-	for (len = MAX_INSNS - 1; len > 0; --len)
-		if (fp[len].code != 0 || fp[len].imm != 0)
+	if (reverse) {
+		for (len = MAX_INSNS - 1; len > 0; --len)
+			if (fp[len].code != 0 || fp[len].imm != 0)
+				break;
+		return len + 1;
+	}
+
+	for (len = 0; len < MAX_INSNS; len++)
+		if (fp[len].code == 0 && fp[len].imm == 0)
 			break;
-	return len + 1;
+
+	return len;
+}
+
+static int probe_filter_length(const struct bpf_insn *fp)
+{
+	return probe_filter_length_bidir(fp, true);
+}
+
+static int probe_xlated_filter_length(const struct bpf_insn *fp)
+{
+	/* Translated insn array is very likely to be empty. */
+	return probe_filter_length_bidir(fp, false);
 }
 
 static bool skip_unsupported_map(enum bpf_map_type map_type)
@@ -698,13 +718,130 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	return 0;
 }
 
+static inline __u64 ptr_to_u64(const void *ptr)
+{
+	return (__u64)(unsigned long)ptr;
+}
+
+static int read_bpf_procfs(const char *name)
+{
+	char path[64], *endptr, *line = NULL;
+	size_t len = 0;
+	FILE *fd;
+	int res;
+
+	snprintf(path, sizeof(path), "/proc/sys/net/core/%s", name);
+
+	fd = fopen(path, "r");
+	if (!fd)
+		return -1;
+
+	res = getline(&line, &len, fd);
+	fclose(fd);
+	if (res < 0)
+		return -1;
+
+	errno = 0;
+	res = strtol(line, &endptr, 10);
+	if (errno || *line == '\0' || *endptr != '\n')
+		res = -1;
+	free(line);
+
+	return res;
+}
+
+static int write_bpf_procfs(const char *name, const char value)
+{
+	char path[64];
+	FILE *fd;
+	int res;
+
+	snprintf(path, sizeof(path), "/proc/sys/net/core/%s", name);
+
+	fd = fopen(path, "w");
+	if (!fd)
+		return -1;
+
+	res = fwrite(&value, 1, 1, fd);
+	fclose(fd);
+	if (res != 1)
+		return -1;
+
+	return 0;
+}
+
+static int check_xlated_insn(int fd_prog, struct bpf_test *test, int xlated_len)
+{
+	struct bpf_insn *xlated_insn_buf;
+	__u32 len, *member_len, buf_size;
+	struct bpf_prog_info info;
+	__u64 *member_ptr;
+	int err, idx;
+
+	len = sizeof(info);
+	memset(&info, 0, sizeof(info));
+	member_len = &info.xlated_prog_len;
+	member_ptr = &info.xlated_prog_insns;
+	err = bpf_obj_get_info_by_fd(fd_prog, &info, &len);
+	if (err) {
+		printf("FAIL\nFailed to get prog info '%s'!\n",
+		       strerror(errno));
+		return -1;
+	}
+	if (!*member_len) {
+		printf("FAIL\nNo xlated insn returned!\n");
+		return -1;
+	}
+	buf_size = *member_len;
+	xlated_insn_buf = malloc(buf_size);
+	if (!xlated_insn_buf) {
+		printf("FAIL\nFailed to alloc xlated insn buffer!\n");
+		return -1;
+	}
+
+	memset(&info, 0, sizeof(info));
+	*member_ptr = ptr_to_u64(xlated_insn_buf);
+	*member_len = buf_size;
+	err = bpf_obj_get_info_by_fd(fd_prog, &info, &len);
+	if (err) {
+		printf("FAIL\nFailed to get prog info '%s'!\n",
+		       strerror(errno));
+		return -1;
+	}
+	if (*member_len > buf_size) {
+		printf("FAIL\nToo many xlated insns returned!\n");
+		return -1;
+	}
+	for (idx = 0; idx < xlated_len; idx++) {
+		struct bpf_insn expect_insn = test->xlated_insns[idx];
+		struct bpf_insn got_insn = xlated_insn_buf[idx];
+		bool match_fail;
+
+		/* Verifier will rewrite call imm/offset, just compare code. */
+		if (expect_insn.code == (BPF_JMP | BPF_CALL))
+			match_fail = got_insn.code != expect_insn.code;
+		else /* Full match. */
+			match_fail = memcmp(&got_insn, &expect_insn,
+					    sizeof(struct bpf_insn));
+
+		if (match_fail) {
+			printf("FAIL\nFailed to match xlated insns[%d]\n", idx);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static void do_test_single(struct bpf_test *test, bool unpriv,
 			   int *passes, int *errors)
 {
-	int fd_prog, expected_ret, alignment_prevented_execution;
-	int prog_len, prog_type = test->prog_type;
+	int fd_prog = -1, expected_ret, alignment_prevented_execution;
+	int original_jit_blind = 0, original_jit_32bit_opt = 0;
+	int xlated_len, prog_len, prog_type = test->prog_type;
 	struct bpf_insn *prog = test->insns;
 	int run_errs, run_successes;
+	bool has_xlated_insn_test;
 	int map_fds[MAX_NR_MAPS];
 	const char *expected_err;
 	int fixup_skips;
@@ -724,6 +861,45 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (fixup_skips != skips)
 		return;
 	prog_len = probe_filter_length(prog);
+	xlated_len = probe_xlated_filter_length(test->xlated_insns);
+	expected_ret = unpriv && test->result_unpriv != UNDEF ?
+		       test->result_unpriv : test->result;
+	has_xlated_insn_test = expected_ret == ACCEPT && xlated_len;
+	if (!unpriv) {
+		/* Disable 32-bit optimization for all the other tests. The
+		 * inserted shifts could break some test assumption, for
+		 * example, those hard coded map fixup insn indexes.
+		 */
+		char opt_enable = '0';
+
+		original_jit_32bit_opt = read_bpf_procfs("bpf_jit_32bit_opt");
+		if (original_jit_32bit_opt < 0) {
+			printf("FAIL\nRead jit 32bit opt proc info\n");
+			goto fail;
+		}
+		/* Disable JIT blinding and enable 32-bit optimization when
+		 * there is translated insn match test.
+		 */
+		if (has_xlated_insn_test) {
+			original_jit_blind = read_bpf_procfs("bpf_jit_harden");
+			if (original_jit_blind < 0) {
+				printf("FAIL\nRead jit blinding proc info\n");
+				goto fail;
+			}
+			err = write_bpf_procfs("bpf_jit_harden", '0');
+			if (err < 0) {
+				printf("FAIL\nDisable jit blinding\n");
+				goto fail;
+			}
+
+			opt_enable = '1';
+		}
+		err = write_bpf_procfs("bpf_jit_32bit_opt", opt_enable);
+		if (err < 0) {
+			printf("FAIL\nSetting jit 32-bit opt enablement\n");
+			goto fail;
+		}
+	}
 
 	pflags = 0;
 	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
@@ -738,8 +914,6 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		goto close_fds;
 	}
 
-	expected_ret = unpriv && test->result_unpriv != UNDEF ?
-		       test->result_unpriv : test->result;
 	expected_err = unpriv && test->errstr_unpriv ?
 		       test->errstr_unpriv : test->errstr;
 
@@ -756,6 +930,31 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		    (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS))
 			alignment_prevented_execution = 1;
 #endif
+
+		if (!unpriv) {
+			/* Restore 32-bit optimization variable . */
+			err = write_bpf_procfs("bpf_jit_32bit_opt",
+					       '0' + original_jit_32bit_opt);
+			if (err < 0) {
+				printf("FAIL\nRestore jit 32-bit opt\n");
+				goto fail;
+			}
+			if (has_xlated_insn_test) {
+				char c = '0' + original_jit_blind;
+
+				/* Restore JIT blinding variable . */
+				err = write_bpf_procfs("bpf_jit_harden", c);
+				if (err < 0) {
+					printf("FAIL\nRestore jit blinding\n");
+					goto fail;
+				}
+				/* Do xlated insn comparisons. */
+				err = check_xlated_insn(fd_prog, test,
+							xlated_len);
+				if (err < 0)
+					goto fail;
+			}
+		}
 	} else {
 		if (fd_prog >= 0) {
 			printf("FAIL\nUnexpected success to load!\n");
@@ -836,8 +1035,9 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	sched_yield();
 	return;
 fail_log:
-	(*errors)++;
 	printf("%s", bpf_vlog);
+fail:
+	(*errors)++;
 	goto close_fds;
 }
 
-- 
2.7.4

