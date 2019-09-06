Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2270C43331
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BA02082C
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567755110;
	bh=qXwzPuce43B12+UBtQQdg00DSLSo9Z8JnQC2H4C8bVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=it+pUnMeXrFohPe6EOWf6w9CTgQa1hjxktkzzT8FsV7SoiLIwNQe9DTG/7naIbKpC
	 2PzuKsp82NQni7YWsNfUr9AB45N4F2U0EI7FcoIsVwYKAnrjq7eu4/7Vf0wAJKceqt
	 E3ftxz5i/ejiEeyc/u+OJ+QMgzgLfcnd6dwt0w3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391822AbfIFHbu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732504AbfIFHbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 03:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD8C38980FA;
        Fri,  6 Sep 2019 07:31:49 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2E27600CC;
        Fri,  6 Sep 2019 07:31:47 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH 1/7] libbpf: Use const cast for btf_int_* functions
Date:   Fri,  6 Sep 2019 09:31:38 +0200
Message-Id: <20190906073144.31068-2-jolsa@kernel.org>
In-Reply-To: <20190906073144.31068-1-jolsa@kernel.org>
References: <20190906073144.31068-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Fri, 06 Sep 2019 07:31:49 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm getting following errors when compiling with -Wcast-qual:

  bpf/btf.h: In function ‘__u8 btf_int_offset(const btf_type*)’:
  bpf/btf.h:244:40: warning: cast from type ‘const btf_type*’ to type
  ‘__u32*’ {aka ‘unsigned int*’} casts away qualifiers [-Wcast-qual]
    244 |  return BTF_INT_OFFSET(*(__u32 *)(t + 1));
        |                                        ^

The argument is const so the cast to following __u32
pointer should be const as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 9cb44b4fbf60..952e3496467d 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -236,17 +236,17 @@ static inline bool btf_is_datasec(const struct btf_type *t)
 
 static inline __u8 btf_int_encoding(const struct btf_type *t)
 {
-	return BTF_INT_ENCODING(*(__u32 *)(t + 1));
+	return BTF_INT_ENCODING(*(const __u32 *)(t + 1));
 }
 
 static inline __u8 btf_int_offset(const struct btf_type *t)
 {
-	return BTF_INT_OFFSET(*(__u32 *)(t + 1));
+	return BTF_INT_OFFSET(*(const __u32 *)(t + 1));
 }
 
 static inline __u8 btf_int_bits(const struct btf_type *t)
 {
-	return BTF_INT_BITS(*(__u32 *)(t + 1));
+	return BTF_INT_BITS(*(const __u32 *)(t + 1));
 }
 
 static inline struct btf_array *btf_array(const struct btf_type *t)
-- 
2.21.0

