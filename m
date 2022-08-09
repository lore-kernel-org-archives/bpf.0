Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED757C25B06
	for <bpf@archiver.kernel.org>; Tue,  9 Aug 2022 10:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiHIKx3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Aug 2022 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbiHIKxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 06:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E5F95F49
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660042403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4t5AWs+u5EvUjx0b8iyElLx44EEba3jEMvid4zYihvo=;
        b=eNqpbN29HcBj2jdZJAfV3ZE37S2VY80/CC7s0xZAViaDNin+QPByeZ6iwCBxUDBB+XMFIS
        S0PDm4xADUEq7oInopmMIgwI0s1YfFB3pFDRwROsosuhOqMj5n+k2rhbScwOhdylR+9jg0
        37RHxbth5P0GKvuiq4At+wIkFNFs+fE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-tyGxiXnyNpS4M681TYH1uA-1; Tue, 09 Aug 2022 06:53:19 -0400
X-MC-Unique: tyGxiXnyNpS4M681TYH1uA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EC531824605;
        Tue,  9 Aug 2022 10:53:19 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7A12C15BA3;
        Tue,  9 Aug 2022 10:53:18 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id F1E921C02E7; Tue,  9 Aug 2022 12:53:17 +0200 (CEST)
From:   Artem Savkov <asavkov@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Vacek <dvacek@redhat.com>,
        Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH bpf-next v4 2/3] bpf: export crash_kexec() as destructive kfunc
Date:   Tue,  9 Aug 2022 12:53:16 +0200
Message-Id: <20220809105317.436682-3-asavkov@redhat.com>
In-Reply-To: <20220809105317.436682-1-asavkov@redhat.com>
References: <20220809105317.436682-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow properly marked bpf programs to call crash_kexec().

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 kernel/bpf/helpers.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f961f9982d2..103dbddff41f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1711,3 +1711,24 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return NULL;
 	}
 }
+
+BTF_SET8_START(tracing_btf_ids)
+#ifdef CONFIG_KEXEC_CORE
+BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
+#endif
+BTF_SET8_END(tracing_btf_ids)
+
+static const struct btf_kfunc_id_set tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &tracing_btf_ids,
+};
+
+static int __init kfunc_init(void)
+{
+	if (register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set))
+		pr_warn("failed to register kfunc id set for BPF_PROG_TYPE_TRACING\n");
+
+	return 0;
+}
+
+late_initcall(kfunc_init);
-- 
2.37.1

