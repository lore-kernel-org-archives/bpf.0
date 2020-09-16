Return-Path: <SRS0=xxat=CZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDEFC433E2
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 20:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB2C21974
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600288569;
	bh=wHzKitDVJSgvk67KOzyNP8vKB+YLxZljYC9QDlZVGcE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=H4rmG5kL7LTbgbfOkPhHhxejd9hLpTOAzhCBXwXYjxdlrMPkVGd1eX14h7/UVUwA/
	 aYwwAC1tWTW9M4cWBRgRx0kDwBvcXZgmUUJXRGnoUbEc3sLTADWp3Uib9rIMnBKRJD
	 EDRBGCdmCz2/ohC8ef/ywMJuHEInlB1vkd5T9An4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIPUfV convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 16 Sep 2020 16:35:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42877 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbgIPRKo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Sep 2020 13:10:44 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-D-DZJao1OIiChtMGd9S-Pg-1; Wed, 16 Sep 2020 07:24:22 -0400
X-MC-Unique: D-DZJao1OIiChtMGd9S-Pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B7AF8030AC;
        Wed, 16 Sep 2020 11:24:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-114-172.ams2.redhat.com [10.36.114.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D9B25DE46;
        Wed, 16 Sep 2020 11:24:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix stat probe in d_path test
Date:   Wed, 16 Sep 2020 13:24:16 +0200
Message-Id: <20200916112416.2321204-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some kernels builds might inline vfs_getattr call within fstat
syscall code path, so fentry/vfs_getattr trampoline is not called.

Alexei suggested [1] we should use security_inode_getattr instead,
because it's less likely to get inlined.

Adding security_inode_getattr to the d_path allowed list and
switching the stat trampoline to security_inode_getattr.

Adding flags that indicate trampolines were called and failing
the test if any of them got missed, so it's easier to identify
the issue next time.

[1] https://lore.kernel.org/bpf/CAADnVQJ0FchoPqNWm+dEppyij-MOvvEG_trEfyrHdabtcEuZGg@mail.gmail.com/
Fixes: e4d1af4b16f8 ("selftests/bpf: Add test for d_path helper")
Signed-off-by: Jiri Olsa <jolsa@redhat.com>
---
 kernel/trace/bpf_trace.c                        | 1 +
 tools/testing/selftests/bpf/prog_tests/d_path.c | 6 ++++++
 tools/testing/selftests/bpf/progs/test_d_path.c | 9 ++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b2a5380eb187..1001c053ebb3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1122,6 +1122,7 @@ BTF_ID(func, vfs_truncate)
 BTF_ID(func, vfs_fallocate)
 BTF_ID(func, dentry_open)
 BTF_ID(func, vfs_getattr)
+BTF_ID(func, security_inode_getattr)
 BTF_ID(func, filp_close)
 BTF_SET_END(btf_allowlist_d_path)
 
diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
index fc12e0d445ff..f507f1a6fa3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/d_path.c
+++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
@@ -120,6 +120,12 @@ void test_d_path(void)
 	if (err < 0)
 		goto cleanup;
 
+	if (CHECK(!bss->called_stat || !bss->called_close,
+		  "check",
+		  "failed to call trampolines called_stat %d, bss->called_close %d\n",
+		   bss->called_stat, bss->called_close))
+		goto cleanup;
+
 	for (int i = 0; i < MAX_FILES; i++) {
 		CHECK(strncmp(src.paths[i], bss->paths_stat[i], MAX_PATH_LEN),
 		      "check",
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
index 61f007855649..84e1f883f97b 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -15,7 +15,10 @@ char paths_close[MAX_FILES][MAX_PATH_LEN] = {};
 int rets_stat[MAX_FILES] = {};
 int rets_close[MAX_FILES] = {};
 
-SEC("fentry/vfs_getattr")
+int called_stat = 0;
+int called_close = 0;
+
+SEC("fentry/security_inode_getattr")
 int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
 	     __u32 request_mask, unsigned int query_flags)
 {
@@ -23,6 +26,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
 	__u32 cnt = cnt_stat;
 	int ret;
 
+	called_stat = 1;
+
 	if (pid != my_pid)
 		return 0;
 
@@ -42,6 +47,8 @@ int BPF_PROG(prog_close, struct file *file, void *id)
 	__u32 cnt = cnt_close;
 	int ret;
 
+	called_close = 1;
+
 	if (pid != my_pid)
 		return 0;
 
-- 
2.26.2

