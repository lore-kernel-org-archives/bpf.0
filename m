Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC7C77B61
	for <bpf@archiver.kernel.org>; Fri, 28 Apr 2023 03:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbjD1Drh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Apr 2023 23:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjD1Drh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 23:47:37 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD79726B2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 20:47:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682653652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4o3d7zSr32oZnoLcX2S8Z+ksrEE4ErjH0pKnyR8LQTU=;
        b=xmE2kPhKSw8asni8EJ0SerRpeKOXAbQY5wUjYyUZJngBjlAOoBrMq7Z69wuhjU7p3oohk3
        lRD6dIfBogHXBQ37CZtIe+AlH0vRsfEZNzB8SzCnhxhB62A1ei4iv+UoNL4aICMw65R3mD
        r6uNddcILYcst7hdBr8fwpDjpfkRmTU=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Manu Bretelle <chantra@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: Add fexit_sleep to DENYLIST.aarch64
Date:   Thu, 27 Apr 2023 20:47:26 -0700
Message-Id: <20230428034726.2593484-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

It is reported that the fexit_sleep never returns in aarch64.
The remaining tests cannot start. Put this test into DENYLIST.aarch64
for now so that other tests can continue to run in the CI.

Reported-by: Manu Bretelle <chantra@meta.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 4b6b18424140..cd42e2825bd2 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -1,5 +1,6 @@
 bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
 bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
+fexit_sleep                                      # The test never returns. The remaining tests cannot start.
 kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
-- 
2.34.1

