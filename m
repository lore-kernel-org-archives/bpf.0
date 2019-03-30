Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7F7C43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2121773
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 00:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553904987;
	bh=QTXvcnDC5k/y+VMNBVikS5uunLtMDKbQSDVcUtuQ7U8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPj2ghhJ59ftJI7JRpZ5mNS51f6IA1ZsJxolCGiQX6gFFicYTecVzWkojfaTRKmQG
	 cEXP61caxjpgnb0dKJW1UFnlJ9KWv+7S8QuWnDSDWRE6c96py410eim5yIuZ2JJqUD
	 3I68dAn/jeEI3S6FxFlXlWtoOS4M95X+jRKQDkME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfC3AQX convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Fri, 29 Mar 2019 20:16:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730232AbfC3AQX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Mar 2019 20:16:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2U0Eqsb024823
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:22 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhwcr02bf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 17:16:22 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 17:16:21 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 094B2760BC0; Fri, 29 Mar 2019 17:16:21 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 4/7] bpf: increase complexity limit and maximum program size
Date:   Fri, 29 Mar 2019 17:16:09 -0700
Message-ID: <20190330001612.2354959-5-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190330001612.2354959-1-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Large verifier speed improvements allow to increase
verifier complexity limit.
Now regardless of the program composition and its size it takes
little time for the verifier to hit insn_processed limit.
On typical x86 machine non-debug kernel processes 1M instructions
in 1/10 of a second.
(before these speed improvements specially crafted programs
could be hitting multi-second verification times)
Full kasan kernel with debug takes ~1 second for the same 1M insns.
Hence bump the BPF_COMPLEXITY_LIMIT_INSNS limit to 1M.
Also increase the number of instructions per program
from 4k to internal BPF_COMPLEXITY_LIMIT_INSNS limit.
4k limit was confusing to users, since small programs with hundreds
of insns could be hitting BPF_COMPLEXITY_LIMIT_INSNS limit.
Sometimes adding more insns and bpf_trace_printk debug statements
would make the verifier accept the program while removing
code would make the verifier reject it.
Some user space application started to add #define MAX_FOO to
their programs and do:
  MAX_FOO=100;
again:
  compile with MAX_FOO;
  try to load;
  if (fails_to_load) { reduce MAX_FOO; goto again; }
to be able to fit maximum amount of processing into single program.
Other users artificially split their single program into a set of programs
and use all 32 iterations of tail_calls to increase compute limits.
And the most advanced folks used unlimited tc-bpf filter list
to execute many bpf programs.
Essentially the users managed to workaround 4k insn limit.
This patch removes the limit for root programs from uapi.
BPF_COMPLEXITY_LIMIT_INSNS is the kernel internal limit
and success to load the program no longer depends on program size,
but on 'smartness' of the verifier only.
The verifier will continue to get smarter with every kernel release.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/syscall.c  | 3 ++-
 kernel/bpf/verifier.c | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f62897198844..a445194b5fb6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -421,6 +421,7 @@ struct bpf_array {
 	};
 };
 
+#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 32
 
 struct bpf_event_entry {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index afca36f53c49..1d65e56594db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1557,7 +1557,8 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	is_gpl = license_is_gpl_compatible(license);
 
-	if (attr->insn_cnt == 0 || attr->insn_cnt > BPF_MAXINSNS)
+	if (attr->insn_cnt == 0 ||
+	    attr->insn_cnt > (capable(CAP_SYS_ADMIN) ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_MAXINSNS))
 		return -E2BIG;
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6dfd148b58f6..76089a094147 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -176,7 +176,6 @@ struct bpf_verifier_stack_elem {
 	struct bpf_verifier_stack_elem *next;
 };
 
-#define BPF_COMPLEXITY_LIMIT_INSNS	131072
 #define BPF_COMPLEXITY_LIMIT_STACK	1024
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
-- 
2.20.0

