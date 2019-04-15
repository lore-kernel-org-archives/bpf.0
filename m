Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742ABC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 21:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC6205F4
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 21:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDOV7B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:59:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbfDOV7B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Apr 2019 17:59:01 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3FLpVFV003443
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 14:59:00 -0700
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2rvyws0hhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 14:59:00 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 15 Apr 2019 14:58:59 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id B02398612FE; Mon, 15 Apr 2019 14:58:58 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   <andrii.nakryiko@gmail.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>, <davem@davemloft.net>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] kbuild: handle old pahole more gracefully when generating BTF
Date:   Mon, 15 Apr 2019 14:58:39 -0700
Message-ID: <20190415215839.1895340-1-andrii.nakryiko@gmail.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

When CONFIG_DEBUG_INFO_BTF is enabled but available version of pahole is too
old to support BTF generation, build script is supposed to emit warning and
proceed with the build. Due to using exit instead of return from BASH function,
existing handling code prematurely exits exit code 0, not completing some of
the build steps. This patch fixes issue by correctly returning just from
gen_btf() function only.

Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index dd2b31ccca6a..6a148d0d51bf 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -99,7 +99,7 @@ gen_btf()
 	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
 	if [ "${pahole_ver}" -lt "113" ]; then
 		info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
-		exit 0
+		return 0
 	fi
 
 	info "BTF" ${1}
-- 
2.17.1

