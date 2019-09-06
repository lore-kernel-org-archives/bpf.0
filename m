Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7563C43140
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973AE20842
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567755117;
	bh=0SLlVRHPd7RYwyeUnSBnNev5mfQpFOPlfNG/F6UfvOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jG4v5h1F9v0Hm+yX2Tr8iTXB9/72hRkeURi4pXfX1nl+KWpmYTnlG0tIY9WZDp5QX
	 gywaXTK9ZgfKIhtwKDeMxMBUixQsGX0sNJvRty6SmG5cdp7IR+X4Ao4fujtK55QHHV
	 bJKsVWvvJnCT2R/FOqdw1L0YWnpiU+3+xIOLNwGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404543AbfIFHb4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404541AbfIFHb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 03:31:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08F0218C8934;
        Fri,  6 Sep 2019 07:31:56 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.205.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 432C9600CC;
        Fri,  6 Sep 2019 07:31:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH 4/7] libbpf: Return const btf_member from btf_members inline function
Date:   Fri,  6 Sep 2019 09:31:41 +0200
Message-Id: <20190906073144.31068-5-jolsa@kernel.org>
In-Reply-To: <20190906073144.31068-1-jolsa@kernel.org>
References: <20190906073144.31068-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 06 Sep 2019 07:31:56 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm getting following errors when compiling with -Wcast-qual:

  bpf/btf.h: In function ‘btf_member* btf_members(const btf_type*)’:
  bpf/btf.h:264:36: warning: cast from type ‘const btf_type*’ to type
  ‘btf_member*’ casts away qualifiers [-Wcast-qual]
    264 |  return (struct btf_member *)(t + 1);
        |                                    ^

The argument is const so the cast to following struct btf_member
pointer should be const as well. Casting the const away in btf.c
call where it's correctly used without const in deduplication
code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/btf.c    | 4 ++--
 tools/lib/bpf/btf.h    | 4 ++--
 tools/lib/bpf/libbpf.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5a39e9506760..560d1ae33675 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1463,7 +1463,7 @@ static int btf_for_each_str_off(struct btf_dedup *d, str_off_fn_t fn, void *ctx)
 		switch (btf_kind(t)) {
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION: {
-			struct btf_member *m = btf_members(t);
+			struct btf_member *m = (struct btf_member *) btf_members(t);
 			__u16 vlen = btf_vlen(t);
 
 			for (j = 0; j < vlen; j++) {
@@ -2797,7 +2797,7 @@ static int btf_dedup_remap_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
-		struct btf_member *member = btf_members(t);
+		struct btf_member *member = (struct btf_member *) btf_members(t);
 		__u16 vlen = btf_vlen(t);
 
 		for (i = 0; i < vlen; i++) {
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 3b3216fa348f..cd1bd018ba8b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -259,9 +259,9 @@ static inline const struct btf_enum *btf_enum(const struct btf_type *t)
 	return (const struct btf_enum *)(t + 1);
 }
 
-static inline struct btf_member *btf_members(const struct btf_type *t)
+static inline const struct btf_member *btf_members(const struct btf_type *t)
 {
-	return (struct btf_member *)(t + 1);
+	return (const struct btf_member *)(t + 1);
 }
 
 /* Get bit offset of a member with specified index. */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2233f919dd88..7d3d6284dd2e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1389,7 +1389,7 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj)
 		} else if (!has_datasec && btf_is_datasec(t)) {
 			/* replace DATASEC with STRUCT */
 			const struct btf_var_secinfo *v = btf_var_secinfos(t);
-			struct btf_member *m = btf_members(t);
+			struct btf_member *m = (struct btf_member *) btf_members(t);
 			struct btf_type *vt;
 			char *name;
 
-- 
2.21.0

