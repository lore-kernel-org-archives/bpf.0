Return-Path: <SRS0=x1rW=43=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C425C18E5B
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE2E20873
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 18:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TYd512vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCJSgi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:36:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgCJSgh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Mar 2020 14:36:37 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AIUcFK021705
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 11:36:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+eS3IUq40uvWPmNkB/O0B8+FDFFKJxEFUm1IT2d8oeU=;
 b=TYd512vFXkbYyOwkh3dOUnTMjznRP/fm+trCh3NJmAwSag6SU+pD9NU+pD3+NVE+qXxA
 wF4ejqsk6GGG44whVNzKdFnw+ejNMdZuG6va3A87Aig6NqhyLkOWC9lzFrW13qkhYuat
 CobAMrlUN1YK284MgqkqFaRguXLOvkVPMT4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2ypfsq87xx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 11:36:35 -0700
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 11:36:33 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C511562E28D2; Tue, 10 Mar 2020 11:36:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <quentin@isovalent.com>, <kernel-team@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <arnaldo.melo@gmail.com>,
        <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] bpftool: skeleton should depend on libbpf
Date:   Tue, 10 Mar 2020 11:36:23 -0700
Message-ID: <20200310183624.441788-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310183624.441788-1-songliubraving@fb.com>
References: <20200310183624.441788-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_13:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100110
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the dependency to libbpf, to fix build errors like:

  In file included from skeleton/profiler.bpf.c:5:
  .../bpf_helpers.h:5:10: fatal error: 'bpf_helper_defs.h' file not found
  #include "bpf_helper_defs.h"
           ^~~~~~~~~~~~~~~~~~~
  1 error generated.
  make: *** [skeleton/profiler.bpf.o] Error 1
  make: *** Waiting for unfinished jobs....

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 05a37f0f76a9..0389355f8bdc 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -128,7 +128,7 @@ $(OUTPUT)_prog.o: prog.c
 $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(_OBJS) $(LIBS)
 
-skeleton/profiler.bpf.o: skeleton/profiler.bpf.c
+skeleton/profiler.bpf.o: skeleton/profiler.bpf.c $(LIBBPF)
 	$(QUIET_CLANG)$(CLANG) -I$(srctree)/tools/lib -g -O2 -target bpf -c $< -o $@
 
 profiler.skel.h: $(OUTPUT)_bpftool skeleton/profiler.bpf.o
-- 
2.17.1

