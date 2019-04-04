Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E4DC10F0E
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B0A20657
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StgITAeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfDDSvi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:51:38 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:49038 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfDDSvi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 14:51:38 -0400
Received: by mail-ot1-f74.google.com with SMTP id 70so1691346otn.15
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2019 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e6UMHrEtEbL92DS9PjWj/7fvQl7YBzd6cUhEvqAndy4=;
        b=StgITAeI18I39FLa6i2CW8HewY5DeYs1X0ZaXURFPjhlLQ7PjINmjxyn257xpPt93e
         J85leNXsQrNegGIX7hm84wWpvGAfP4bTfIL3DjTD8F7TQRewZiiyBWoX1z29HN3P50lq
         ogey7/iJvxg82byQv67B/WzA2N4dI+4Gv2wvyT/6XrUjOnjGtW3jf0V8h0jkK7F4AFBa
         sq33esZFQUL2tE8qztM9cZqM+9uMdlgUmlEnKGtGnjxFmG1BNHWDRywTnQzCUwZw7Zn0
         0daxLQUE/iYA4YQS18h5Hl1zMHM3ZrmcIjsv1dk4f6R9UyOdkCRLJFJKLkk7TkB4igFn
         NPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e6UMHrEtEbL92DS9PjWj/7fvQl7YBzd6cUhEvqAndy4=;
        b=Uun4VFC8855n3m5cujJDJYCSDLz5jQrJ3fOYPh6wsPTP4g6Qh/Atq8lHUWS1xno1iK
         kDQqtlzlh8NfppsnpF4PvdDhnaYF3ioHna1+CC66ikk9Qu2WVkt//ENAlBrl1uz3qLzx
         rV3oPwfGCUHuquZ0VLbhX7PqWP009qqPUCt8/A1MqtfWRFqs+ZXOOazIl6dkeSb4uUjg
         Kq9oya0kUk9jZxKuy+PQvXeWaFY3Vz36TRR2G9MWEIBwi7wSBNS/+APYrDC47yj+n3Aq
         hP/Wvg/kQj/Z70GciP1ReQIWNbx7UWJpZDLO8Hng3nFA2LxV0Wh6NEPmGoLbNLBLZykU
         R6MA==
X-Gm-Message-State: APjAAAXm33YLyVWsnL8FjWqGvOxt5JAbXAQmC9liZjrdZMirxCUUP25j
        mApdLVptIDJDQwdyrOlTMDBGRNQ=
X-Google-Smtp-Source: APXvYqwJ7MljyjaqEddbJhcOxxTE4X7LfHiH/h24L/Hk3kqhP2QEUziNv0ptA+WpKoBDOOI9tOfqaQs=
X-Received: by 2002:aca:5004:: with SMTP id e4mr743516oib.1.1554403897571;
 Thu, 04 Apr 2019 11:51:37 -0700 (PDT)
Date:   Thu,  4 Apr 2019 11:51:32 -0700
In-Reply-To: <20190404185133.95071-1-sdf@google.com>
Message-Id: <20190404185133.95071-2-sdf@google.com>
Mime-Version: 1.0
References: <20190404185133.95071-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 2/3] libbpf: add support for ctx_{size,}_{in,out} in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support recently introduced input/output context for test runs.
We extend only bpf_prog_test_run_xattr. bpf_prog_test_run is
unextendable and left as is.

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

