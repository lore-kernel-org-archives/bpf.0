Return-Path: <SRS0=6uvD=EB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B3C4363A
	for <bpf@archiver.kernel.org>; Mon, 26 Oct 2020 21:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75097221F8
	for <bpf@archiver.kernel.org>; Mon, 26 Oct 2020 21:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603746248;
	bh=pJK1OJkuepgQNI/swpB2eC2t54KgsoqFayP1FDpJXfQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1alZOMgobKvJkxc4tO9t4omlX0OmXeO76m8Dl3UkqGosxus0e6fLePISfOMG4HUkM
	 FNhfTPQ3mk6L0dfPxyQSU6ioQl7xkHnZ156UJAiBfRzl5GsoAyTDalGKa5H8BBcBYo
	 i8cupOgBosW6EhrNLvv5MWoUfqse2WWqG2pEl8Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgJZVEE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbgJZVEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 17:04:04 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4555D20773;
        Mon, 26 Oct 2020 21:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603746243;
        bh=pJK1OJkuepgQNI/swpB2eC2t54KgsoqFayP1FDpJXfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=il+Ezvkv44gRlBOPG/TAjzsUspGL735bVU/p1dkTXRRr2677e7fkKH6WBUkYfghhK
         Asd0ogLsUT8EZNaFDP+XWlMRSUiJQOudCF9pj+P/wWo+hYIqInx2uajeFs2o8rZQkN
         VfuQHXsNQUb/ja8DpWG6qxO/QRhqewWqOJzQsbDM=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <kafai@fb.com>
Cc:     Marek Majkowski <marek@cloudflare.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Jiri Olsa <jolsa@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Hao Luo <haoluo@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix incorrect initialization of bpf_ctx_convert_map
Date:   Mon, 26 Oct 2020 22:03:48 +0100
Message-Id: <20201026210355.3885283-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra points out that a field may get overridden in some
configurations such as x86 allmodconfig, when the next index after the one
that has been assigned last already had a value, in this case for index
BPF_PROG_TYPE_SK_LOOKUP, which comes after BPF_PROG_TYPE_LSM in the list:

kernel/bpf/btf.c:4225:2: warning: initialized field overwritten [-Woverride-init]
 4225 |  0, /* avoid empty array */
      |  ^
kernel/bpf/btf.c:4225:2: note: (near initialization for 'bpf_ctx_convert_map[30]')

Move the zero-initializer first instead. This avoids the warning since
nothing else uses index 0, and the last element does not have to be zero.

Fixes: e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a dedicated attach point")
Fixes: 4c80c7bc583a ("bpf: Fix build in minimal configurations, again")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed7d02e8bc93..2a4a4aeeaac1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4218,11 +4218,11 @@ enum {
 	__ctx_convert_unused, /* to avoid empty enum in extreme .config */
 };
 static u8 bpf_ctx_convert_map[] = {
+	[0] = 0, /* avoid empty array */
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
 	[_id] = __ctx_convert##_id,
 #include <linux/bpf_types.h>
 #undef BPF_PROG_TYPE
-	0, /* avoid empty array */
 };
 #undef BPF_MAP_TYPE
 #undef BPF_LINK_TYPE
-- 
2.27.0

