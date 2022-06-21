Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B5C43334
	for <bpf@archiver.kernel.org>; Tue, 21 Jun 2022 20:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353838AbiFUUqz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352430AbiFUUqy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EFA24BFD
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F6D61857
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E02C341C5;
        Tue, 21 Jun 2022 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844413;
        bh=bELpyDwJmv34Yo/vC1UO2hSQqFCVOmUFIBnXz30WfLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WV4kv5Db/CEgR/oDnQpRFVqe03yvrlu3BwwpQhLe0QaI+J9jt/G1zqVjVGvwRxXcy
         COK/SmMQ4otzgNyD6cAUDqltLWB2G4ehUsW++ZYFo6IADPOHT78r8s+Au2FYNUuyH4
         4K1Nm0gq9HheCGQpy7FAn7A4O02dwKbLixgocmsnarx9WU8UEwPY7zpXBRlq9f2Mpo
         Qzj50UzYiQDtLUGCGtxXUG+13cTOdxB5Us161R73T4mMdAZCF+dzldfyMztSAw5gh7
         rtbjdpuW0nBY/0e2BuAAM22cdykqb6d8LjbkL8myVR7FfdTKlimHCToT51upIzUaZO
         qYhO95g1sPEjA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH v3 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM programs
Date:   Tue, 21 Jun 2022 20:46:40 +0000
Message-Id: <20220621204642.2891979-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220621204642.2891979-1-kpsingh@kernel.org>
References: <20220621204642.2891979-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In preparation for the addition of bpf_getxattr kfunc.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6608e8a0c5ca..c48566dc86fe 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7261,6 +7261,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
-- 
2.37.0.rc0.104.g0611611a94-goog

