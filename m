Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25AFC43140
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8673C2082C
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567755122;
	bh=qE2xe/CKuHSPa5ZLNs8qp3IX3kw5hfSSbnkcb2TxAu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrPegHqsqTQO8S4tBrNLtC4jjin6ViUDRlgN9b74mRQJs9ZSRgKr7iBb2ZrWUlHkf
	 r1JkFXaAqUDSsbd8Vg1dpr9L3y41jjqanbjJRpKLLC2PRIR13fdN1HruOSM+nMMpZ0
	 QtX7EVCxgmeEuj65eaImh3wL2M444iMyUqEA9GDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfIFHcB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404555AbfIFHcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 03:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CF6E307D851;
        Fri,  6 Sep 2019 07:32:01 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E2B3600CC;
        Fri,  6 Sep 2019 07:31:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH 6/7] libbpf: Return const btf_var from btf_var inline function
Date:   Fri,  6 Sep 2019 09:31:43 +0200
Message-Id: <20190906073144.31068-7-jolsa@kernel.org>
In-Reply-To: <20190906073144.31068-1-jolsa@kernel.org>
References: <20190906073144.31068-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 07:32:01 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm getting following errors when compiling with -Wcast-qual:

  bpf/btf.h: In function ‘btf_var* btf_var(const btf_type*)’:
  bpf/btf.h:296:33: warning: cast from type ‘const btf_type*’ to type
  ‘btf_var*’ casts away qualifiers [-Wcast-qual]
    296 |  return (struct btf_var *)(t + 1);
        |                                 ^

The argument is const so the cast to following struct btf_var
pointer should be const as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 2817cf7ce2ee..480dbe780fa7 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -291,9 +291,9 @@ static inline const struct btf_param *btf_params(const struct btf_type *t)
 	return (const struct btf_param *)(t + 1);
 }
 
-static inline struct btf_var *btf_var(const struct btf_type *t)
+static inline const struct btf_var *btf_var(const struct btf_type *t)
 {
-	return (struct btf_var *)(t + 1);
+	return (const struct btf_var *)(t + 1);
 }
 
 static inline struct btf_var_secinfo *
-- 
2.21.0

