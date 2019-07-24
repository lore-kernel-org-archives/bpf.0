Return-Path: <SRS0=hBvA=VV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB794C76186
	for <bpf@archiver.kernel.org>; Wed, 24 Jul 2019 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B0C21841
	for <bpf@archiver.kernel.org>; Wed, 24 Jul 2019 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sqj8KFoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfGXQ6f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:58:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56389 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfGXQ6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 12:58:34 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so28947057pfa.23
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HR+i5k9D3xN0HWRoWeihUWIzPrhjF/a9nve8ODtPhD0=;
        b=Sqj8KFoPc7hD63y6Ke6KRZCuC892AJWxBiBjXl9lm7e3VHw7v9+2CPKEKkIIGVduBM
         +RBU0OzJVulCwCav3ICiM0TTFqCVjHo32X+Gfur0MmkdF5f2GDgfrmT1WIagFWh/eLk/
         TfTRNQzkoI/Rmz8NQgzm6MtkfTWjehevn3uHkGkt71GlOorwiX63MNuUwmdGSK1TELYZ
         yZsjvh/nyXpdbATi79pq4jnwWfIB3+8JKgOd7lSJg16RSNjIDMyAHd2Wr/9b9d6aEVNe
         gVfwYSSWh8TBXcNRNU+IBM8ZgPWDd2ZdkP3MJYeVX+vkgj6Oq+OZ2br+9Ddj79zT7PRs
         HCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HR+i5k9D3xN0HWRoWeihUWIzPrhjF/a9nve8ODtPhD0=;
        b=NYuFKYQyLD5QNQlvyzXjSHvXlOkG7IKFo+paSvUM4n+q1llzeCK5bZbrc5JUueSatL
         u54QnnjJ93Qwu/i9fJihvtdynaeWMenlO95Rr8mBMileTu8v4gHtfOmq1m/loCBZZWJK
         /IKUrN3ViDsJ2iuLKsVrmUF7G0KndBQw8eZmvcEqs5Tds0IQTT4PGmzJsPy9pgibNYgi
         6CQ6KyUfqfbphsGX2aLAPSdAIIba3dtVT9zVFv3xN581fltagrLrWw/iH5sJ8c+zQOLU
         r2E47CjJALw0K9dV9OQODlFgfdTAzwFS3d9zh1870wdA7S6YVfH69TnliE38Rb424YOD
         dR7w==
X-Gm-Message-State: APjAAAWnqDm1FcQR2Iv+mY7Dunl2Z27uT94MrMN7ytglLXXD63wGmPkM
        UxO10wrplqtKZ/uHAYnIHAgHS6EEmwmd
X-Google-Smtp-Source: APXvYqzu5AQ+mRmZp518hex6IDEIzKbEvvBp9hLrjMi74On/5T8AvUdwkgxhlgx4t6PpiuEpqSWlNkQJPxJ2
X-Received: by 2002:a63:3009:: with SMTP id w9mr7663984pgw.260.1563987513746;
 Wed, 24 Jul 2019 09:58:33 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:58:00 -0700
In-Reply-To: <20190724165803.87470-1-brianvv@google.com>
Message-Id: <20190724165803.87470-4-brianvv@google.com>
Mime-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 3/6] bpf: keep bpf.h in sync with tools/
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds bpf_attr.dump structure to libbpf.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/include/uapi/linux/bpf.h | 9 +++++++++
 tools/lib/bpf/libbpf.map       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4e455018da65f..e127f16e4e932 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_MAP_DUMP,
 };
 
 enum bpf_map_type {
@@ -388,6 +389,14 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_DUMP command */
+		__aligned_u64	prev_key;
+		__aligned_u64	buf;
+		__aligned_u64	buf_len; /* input/output: len of buf */
+		__u64		flags;
+		__u32		map_fd;
+	} dump;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8d..cac3723d5c45c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -183,4 +183,6 @@ LIBBPF_0.0.4 {
 		perf_buffer__new;
 		perf_buffer__new_raw;
 		perf_buffer__poll;
+		bpf_map_dump;
+		bpf_map_dump_flags;
 } LIBBPF_0.0.3;
-- 
2.22.0.657.g960e92d24f-goog

