Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C2C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C35620833
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bL2/7J3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDIStR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:49:17 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43741 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDIStR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 14:49:17 -0400
Received: by mail-pf1-f201.google.com with SMTP id i14so13606843pfd.10
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u3I8fwzqYgrCn0WIQ0BYIF9H2xgpp408VT93MrK3acY=;
        b=bL2/7J3yBwGKZTc+4iDjT8eAlrTwbGxNAs16ow5JIg6gOSOpmT0+p5ffdcB06kmmPg
         Ja5w+XEZszNN1aJqVMUT+89HSry/nBI8h9EEJkSpW/w1txo0WicYD/JnTAy8zuK6Ae4q
         0zyZvZMbX197NZz9ah0GXAd1Gx68b7HvOe+2B+LqUHDSQNn/FzYjXHN2fCRWfSgTu6Pt
         eYu7NKec581xcvRCFQ4crj0CQ3dOTSF6IewWKAx5rbOFlhEdyrVyrpEypTEl6n2IcEnG
         jjFgfylrX8wDcNkbraH+lX5j2bTPJ4x1wazLGLgltmrJ5Ahk68JT5uj3BfXNTUSU4vaZ
         1pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u3I8fwzqYgrCn0WIQ0BYIF9H2xgpp408VT93MrK3acY=;
        b=HDYWmQ209l/o8HBTLZfkKIjtFvVCyiNFNEcvwRDEUqyGlz+3YkgH7sBTT/4Cf4hfxt
         YKaX5XKcOowNzXcjCLMWkhDqL2f5Jd7I1AGeFXM4XeLkeJNarWAYNF/crB/cAzmLLjF7
         +E2nhL4lvhj7K6/G0GQogGmKKed7htxJn+bVF/MiviE5xuui1f2y7n91+do9kfwUpK1h
         raYk54+fSBjbyUUZCVMxL4s5LbhZtTV1+m7KCMIGP486ckBB7u2S8am7doNeVtj+tGXr
         X1QApaQgk3YS36m5IuTis+PI92PLFSv9SzoE0+okVF/J830D0+bo3j6n5ILQXDNZqGol
         krLA==
X-Gm-Message-State: APjAAAXpmoizR4X+7zssxnWGNDcIuTGupPrvOVju9rcjTV3tlAYqs3o0
        7OHTHFwmpOnN26lWqLk9rRTiRrI=
X-Google-Smtp-Source: APXvYqzncV9k7q6Re6bEwk9ctHrGlxpgz279/WhIdveoly3LsZEI3VGkpF+/lBgmhEppIf56YcBCVBE=
X-Received: by 2002:aa7:8695:: with SMTP id d21mr1022060pfo.16.1554835756024;
 Tue, 09 Apr 2019 11:49:16 -0700 (PDT)
Date:   Tue,  9 Apr 2019 11:49:10 -0700
In-Reply-To: <20190409184911.97485-1-sdf@google.com>
Message-Id: <20190409184911.97485-2-sdf@google.com>
Mime-Version: 1.0
References: <20190409184911.97485-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v4 2/3] libbpf: add support for ctx_{size,}_{in,out}
 in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support recently introduced input/output context for test runs.
We extend only bpf_prog_test_run_xattr. bpf_prog_test_run is
unextendable and left as is.

Cc: Martin Lau <kafai@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 7 +++++++
 tools/lib/bpf/bpf.c            | 5 +++++
 tools/lib/bpf/bpf.h            | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 837024512baf..8e96f99cebf8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -396,6 +396,13 @@ union bpf_attr {
 		__aligned_u64	data_out;
 		__u32		repeat;
 		__u32		duration;
+		__u32		ctx_size_in;	/* input: len of ctx_in */
+		__u32		ctx_size_out;	/* input/output: len of ctx_out
+						 *   returns ENOSPC if ctx_out
+						 *   is too small.
+						 */
+		__aligned_u64	ctx_in;
+		__aligned_u64	ctx_out;
 	} test;
 
 	struct { /* anonymous struct used by BPF_*_GET_*_ID */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a1db869a6fda..d740da7ae1d3 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -545,10 +545,15 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
 	attr.test.data_out = ptr_to_u64(test_attr->data_out);
 	attr.test.data_size_in = test_attr->data_size_in;
 	attr.test.data_size_out = test_attr->data_size_out;
+	attr.test.ctx_in = ptr_to_u64(test_attr->ctx_in);
+	attr.test.ctx_out = ptr_to_u64(test_attr->ctx_out);
+	attr.test.ctx_size_in = test_attr->ctx_size_in;
+	attr.test.ctx_size_out = test_attr->ctx_size_out;
 	attr.test.repeat = test_attr->repeat;
 
 	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
 	test_attr->data_size_out = attr.test.data_size_out;
+	test_attr->ctx_size_out = attr.test.ctx_size_out;
 	test_attr->retval = attr.test.retval;
 	test_attr->duration = attr.test.duration;
 	return ret;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e2c0df7b831f..385418a6d54b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -135,6 +135,11 @@ struct bpf_prog_test_run_attr {
 			      * out: length of data_out */
 	__u32 retval;        /* out: return code of the BPF program */
 	__u32 duration;      /* out: average per repetition in ns */
+	const void *ctx_in; /* optional */
+	__u32 ctx_size_in;
+	void *ctx_out;      /* optional */
+	__u32 ctx_size_out; /* in: max length of ctx_out
+			     * out: length of cxt_out */
 };
 
 LIBBPF_API int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr);
-- 
2.21.0.392.gf8f6787159e-goog

