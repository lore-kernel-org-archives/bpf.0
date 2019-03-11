Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FAAC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2D2175B
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GNWMt/GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfCKT4l (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbfCKT4k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Mar 2019 15:56:40 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2BJtY46023066
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2019 12:56:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=v4CFG6GAoKDdVvUtX74CjwljSMlGo1gNsqjCsZJtPw0=;
 b=GNWMt/GRivKvcoHrAkpdNXepLT74rOM4jQ+aCYotqtuPmsyWuyILJLFXWFD+2v8l2t89
 V1cxzwZEM7wXyYfRJ0hJH/t3bfMIFLGWyB15II1OkDlgWzMT3AN5bSb1VLpf2+aGzYJG
 35w50IQIWuqHI/Qy6utDOyVOk/hVCox5/vU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2r5x1xr1ej-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2019 12:56:39 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 12:56:39 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 399CB62E1B7E; Mon, 11 Mar 2019 12:56:38 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v8 perf,bpf 10/15] perf-top: add option --no-bpf-event
Date:   Mon, 11 Mar 2019 12:55:50 -0700
Message-ID: <20190311195555.889995-11-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311195555.889995-1-songliubraving@fb.com>
References: <20190311195555.889995-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf events should be tracked by default for perf-top. This patch makes it
on by default, and adds option to disable bpf events.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-top.c | 3 +++
 tools/perf/util/top.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 27d8d42e0a4d..ccdf5689452f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1492,6 +1492,7 @@ int cmd_top(int argc, const char **argv)
 		    "Display raw encoding of assembly instructions (default)"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
+	OPT_BOOLEAN(0, "no-bpf-event", &top.no_bpf_event, "do not record bpf events"),
 	OPT_STRING(0, "objdump", &top.annotation_opts.objdump_path, "path",
 		    "objdump binary to use for disassembly and annotations"),
 	OPT_STRING('M', "disassembler-style", &top.annotation_opts.disassembler_style, "disassembler style",
@@ -1651,6 +1652,8 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
+	top.record_opts.bpf_event = !top.no_bpf_event;
+
 	status = __cmd_top(&top);
 
 out_delete_evlist:
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 19f95eaf75c8..862a37bd27ea 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -32,6 +32,7 @@ struct perf_top {
 	bool		   use_tui, use_stdio;
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
+	bool		   no_bpf_event;
 	struct hist_entry  *sym_filter_entry;
 	struct perf_evsel  *sym_evsel;
 	struct perf_session *session;
-- 
2.17.1

