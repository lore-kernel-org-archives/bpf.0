Return-Path: <SRS0=qFa8=AG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40765C433E1
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 22:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F36520789
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593123224;
	bh=wINGYD9kEko8RGerhle/jGdgc5+XQAHbXkuzdHMtq6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cKD+ujzaU2D3MFAwT1qfRfAaviUEQ9ftS5JMYojMa+uMETfy0tVmDLUg5pBdXgD1N
	 EZMN8s8pyUB+od+YtjouLyslTgqHeagVi3gCT6WANKvtAsCM3sYq5D6ETI6lBSHfBt
	 32eOoRBUUOf/ip6UZvmOqHbTbS0gilNeWz3Cn8d0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436493AbgFYWNn convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 25 Jun 2020 18:13:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22707 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407494AbgFYWNn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Jun 2020 18:13:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-CTkIy6NiOOqERUUgejX7eA-1; Thu, 25 Jun 2020 18:13:39 -0400
X-MC-Unique: CTkIy6NiOOqERUUgejX7eA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 337EC1005512;
        Thu, 25 Jun 2020 22:13:37 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9A957933C;
        Thu, 25 Jun 2020 22:13:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 bpf-next 06/14] bpf: Use BTF_ID to resolve bpf_ctx_convert struct
Date:   Fri, 26 Jun 2020 00:12:56 +0200
Message-Id: <20200625221304.2817194-7-jolsa@kernel.org>
In-Reply-To: <20200625221304.2817194-1-jolsa@kernel.org>
References: <20200625221304.2817194-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This way the ID is resolved during compile time,
and we can remove the runtime name search.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/btf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4da6b0770ff9..701a2cb5dfb2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -18,6 +18,7 @@
 #include <linux/sort.h>
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
+#include <linux/btf_ids.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
 #include <net/sock.h>
@@ -3621,6 +3622,9 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
 	return kern_ctx_type->type;
 }
 
+BTF_ID_LIST(bpf_ctx_convert_btf_id)
+BTF_ID(struct, bpf_ctx_convert)
+
 struct btf *btf_parse_vmlinux(void)
 {
 	struct btf_verifier_env *env = NULL;
@@ -3659,10 +3663,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (err)
 		goto errout;
 
-	/* find struct bpf_ctx_convert for type checking later */
-	btf_id = btf_find_by_name_kind(btf, "bpf_ctx_convert", BTF_KIND_STRUCT);
-	if (btf_id < 0) {
-		err = btf_id;
+	/* struct bpf_ctx_convert for type checking later */
+	btf_id = bpf_ctx_convert_btf_id[0];
+	if (btf_id <= 0) {
+		err = -EINVAL;
 		goto errout;
 	}
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
-- 
2.25.4

