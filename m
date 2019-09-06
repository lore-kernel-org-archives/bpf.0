Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED6C00307
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6F5208C3
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567755125;
	bh=KNng9riQeIKkFsgEcRYjyH5sd2YJjSRhMDbpt49HUvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MR01TYMV44D3ic3gCixVIfoz/zTqYBSpT9LfG6fN/cEh0h2t79bT4OJJnC+tu/Sn8
	 7v9uFefaPLi3xYGCurTI4tg51UrnFcnWjX4z0uZA2tGCbJ9skcLZ0Fzl5utcz8F6Q3
	 puZG60Ec/Vc3lpTXHs9kTyAQltZj3G0Xrkxx1Brk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbfIFHcE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:32:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404555AbfIFHcD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 03:32:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CB67308AA11;
        Fri,  6 Sep 2019 07:32:03 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59D56600CC;
        Fri,  6 Sep 2019 07:32:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH 7/7] libbpf: Return const struct btf_var_secinfo from btf_var_secinfos inline function
Date:   Fri,  6 Sep 2019 09:31:44 +0200
Message-Id: <20190906073144.31068-8-jolsa@kernel.org>
In-Reply-To: <20190906073144.31068-1-jolsa@kernel.org>
References: <20190906073144.31068-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 06 Sep 2019 07:32:03 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm getting following errors when compiling with -Wcast-qual:

  bpf/btf.h: In function ‘btf_var_secinfo* btf_var_secinfos(const btf_type*)’:
  bpf/btf.h:302:41: warning: cast from type ‘const btf_type*’ to type
  ‘btf_var_secinfo*’ casts away qualifiers [-Wcast-qual]
    302 |  return (struct btf_var_secinfo *)(t + 1);
        |                                         ^

The argument is const so the cast to following struct btf_var_secinfo
pointer should be const as well. Casting the const away in btf.c call
where it's correctly used without const in deduplication code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.c | 5 +++--
 tools/lib/bpf/btf.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b5121c79fd9f..32527622792d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -526,7 +526,8 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 
 	t->size = size;
 
-	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
+	for (i = 0, vsi = (struct btf_var_secinfo *) btf_var_secinfos(t);
+	     i < vars; i++, vsi++) {
 		t_var = btf__type_by_id(btf, vsi->type);
 		var = btf_var(t_var);
 
@@ -2830,7 +2831,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 	}
 
 	case BTF_KIND_DATASEC: {
-		struct btf_var_secinfo *var = btf_var_secinfos(t);
+		struct btf_var_secinfo *var = (struct btf_var_secinfo *) btf_var_secinfos(t);
 		__u16 vlen = btf_vlen(t);
 
 		for (i = 0; i < vlen; i++) {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 480dbe780fa7..ecccde0988b1 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -296,10 +296,10 @@ static inline const struct btf_var *btf_var(const struct btf_type *t)
 	return (const struct btf_var *)(t + 1);
 }
 
-static inline struct btf_var_secinfo *
+static inline const struct btf_var_secinfo *
 btf_var_secinfos(const struct btf_type *t)
 {
-	return (struct btf_var_secinfo *)(t + 1);
+	return (const struct btf_var_secinfo *)(t + 1);
 }
 
 #ifdef __cplusplus
-- 
2.21.0

