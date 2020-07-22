Return-Path: <SRS0=WYs6=BB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E6DC4345D
	for <bpf@archiver.kernel.org>; Wed, 22 Jul 2020 21:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD3522B3F
	for <bpf@archiver.kernel.org>; Wed, 22 Jul 2020 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595452415;
	bh=w8g1lidcdX6BST10NUvuueLGhXyKrA5JghsndPucpOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hO8yhFCfdo7nf7+yG0OYifs3y6BGycbmMBpXjblW+CxFjqziOi35fWtEiZcZPS7Wa
	 rzAmfSxUwtCUfn03W6blL5Q0MvM+yxnhCG/zKlyX/39bWFSf/gIu+dGueip1C63yAZ
	 xPDw39VtiMI+Gz6ISOnWoJPnolyfYXSDpi0N7PPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgGVVNf convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 22 Jul 2020 17:13:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24744 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732324AbgGVVNf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 17:13:35 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-xxnTTcBcPmKaw3P-S9ln1g-1; Wed, 22 Jul 2020 17:13:18 -0400
X-MC-Unique: xxnTTcBcPmKaw3P-S9ln1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED8E4100CCC1;
        Wed, 22 Jul 2020 21:13:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E57B019C4F;
        Wed, 22 Jul 2020 21:13:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v8 bpf-next 13/13] selftests/bpf: Add set test to resolve_btfids
Date:   Wed, 22 Jul 2020 23:12:23 +0200
Message-Id: <20200722211223.1055107-14-jolsa@kernel.org>
In-Reply-To: <20200722211223.1055107-1-jolsa@kernel.org>
References: <20200722211223.1055107-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding test to for sets resolve_btfids. We're checking that
testing set gets properly resolved and sorted.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 101785b49f7e..cc90aa244285 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -48,6 +48,15 @@ BTF_ID(struct,  S)
 BTF_ID(union,   U)
 BTF_ID(func,    func)
 
+BTF_SET_START(test_set)
+BTF_ID(typedef, S)
+BTF_ID(typedef, T)
+BTF_ID(typedef, U)
+BTF_ID(struct,  S)
+BTF_ID(union,   U)
+BTF_ID(func,    func)
+BTF_SET_END(test_set)
+
 static int
 __resolve_symbol(struct btf *btf, int type_id)
 {
@@ -126,5 +135,29 @@ int test_resolve_btfids(void)
 		}
 	}
 
+	/* Check BTF_SET_START(test_set) IDs */
+	for (i = 0; i < test_set.cnt && !ret; i++) {
+		bool found = false;
+
+		for (j = 0; j < ARRAY_SIZE(test_symbols); j++) {
+			if (test_symbols[j].id != test_set.ids[i])
+				continue;
+			found = true;
+			break;
+		}
+
+		ret = CHECK(!found, "id_check",
+			    "ID %d for %s not found in test_symbols\n",
+			    test_symbols[j].id, test_symbols[j].name);
+		if (ret)
+			break;
+
+		if (i > 0) {
+			ret = CHECK(test_set.ids[i - 1] > test_set.ids[i],
+				    "sort_check",
+				    "test_set is not sorted\n");
+		}
+	}
+
 	return ret;
 }
-- 
2.25.4

