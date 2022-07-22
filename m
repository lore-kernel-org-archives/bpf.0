Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DE5CCA473
	for <bpf@archiver.kernel.org>; Fri, 22 Jul 2022 17:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiGVRTF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jul 2022 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiGVRTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 13:19:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1AC7AB2E
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 10:19:01 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LqGMR5WSJz67L3d;
        Sat, 23 Jul 2022 01:17:07 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 19:18:58 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <jevburton.kernel@gmail.com>
CC:     <bpf@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field for bpf_*_get_fd_by_id() funcs
Date:   Fri, 22 Jul 2022 19:18:23 +0200
Message-ID: <20220722171836.2852247-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722171836.2852247-1-roberto.sassu@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf() system call validates the bpf_attr structure received as
argument, and considers data until the last field, defined for each
operation. The remaing space must be filled with zeros.

Currently, for bpf_*_get_fd_by_id() functions except bpf_map_get_fd_by_id()
the last field is *_id. Setting open_flags to BPF_F_RDONLY from user space
will result in bpf() rejecting the argument.

Set open_flags as last field for the remaining bpf_*_get_fd_by_id()
functions, so that this information can be taken into account by the bpf()
system call.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 kernel/bpf/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83c7136c5788..b4311155d535 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3689,7 +3689,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 	return prog;
 }
 
-#define BPF_PROG_GET_FD_BY_ID_LAST_FIELD prog_id
+#define BPF_PROG_GET_FD_BY_ID_LAST_FIELD open_flags
 
 struct bpf_prog *bpf_prog_by_id(u32 id)
 {
@@ -4315,7 +4315,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr)
 	return btf_new_fd(attr, uattr);
 }
 
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD open_flags
 
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
@@ -4733,7 +4733,7 @@ struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
 	return link;
 }
 
-#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD link_id
+#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD open_flags
 
 static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 {
-- 
2.25.1

