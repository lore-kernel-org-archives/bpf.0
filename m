Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D00FC10F14
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D4020857
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sH2xkoEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfDHQEi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:04:38 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35908 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfDHQEi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 12:04:38 -0400
Received: by mail-pg1-f201.google.com with SMTP id l13so10488943pgp.3
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2019 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TPX6cTYh61RNjrelF8pt2tCkW6NVS4y5gHCKwdw0Nmw=;
        b=sH2xkoEX91xB0GoEJlFiyihE548rQV7YzkKuDFIYVkOn0T+vkkPfMHR7bBUYTidknv
         olQrdcPQp2FAR/r6mJl+/NEu2jjxOR+VVGzjkH/hGzl7lCTa2dTEbMRMWaQfnaz8OCmc
         gad3Qmo/iACpH5IjtArJ6WzOoBXt9R+bV2gYEQLJaoZf6NZU7o6/hpL8P7tsfZFdSHf4
         LTNMiEiX5wOZ97sOHCpAWPPx5untFRyyDe78a1dKZ5jfEC1G3V27Nag4QHmi9aQLzyAl
         CeMOTeTqGockZ4h3Y8T1tJOUYb+5oWYwUic1BlrQC+OPiRIzw2RC4ZfRSej3MQTuytEE
         aarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TPX6cTYh61RNjrelF8pt2tCkW6NVS4y5gHCKwdw0Nmw=;
        b=pDTyMKKawjquv60Q1zNFIeXLJJD2Xehl25NMfxrWHMr9m6Y6VVixE3FFAP0HgHZi3y
         58ZRxsBc7697VGrKjya0QErW/dIAZqJcPefmEpZT37knrI1d5meHeVWFCWJYrWO9tE2M
         9I0aHk8yS0AMqtkMx+ZLVh4Uqkuc2iodyGYwqQjO1pxu1VRG7dYVvrowNeGpn2qjc53Q
         Jms1lJTMq0BmGIjCalAnQo5bmysW6NkEQyr5+5e8gQG567JWdpsjjL2jQIZY9fUkf8dN
         H9qn+2uYXr/21EsHu2yoKXyEPGF6nigKgSetaBHNIPLain6sSv2natBM8YZH1ozQlv70
         kYGw==
X-Gm-Message-State: APjAAAWMrI2YtRRcQ5jsDb2wv8F5Zo3Sv8OeVs9xMTMfTVyCdMBxSxfC
        a7RiWvAKQFd9yAxQmXkKRAvpWLg=
X-Google-Smtp-Source: APXvYqwlKjRBYlzlwBDcq48YfTlMTQPRwBknb6333Cys5QHRVKaalRAjjvcOrOX6Zpr5vm6TEHD7+2M=
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr1517901pla.102.1554739477102;
 Mon, 08 Apr 2019 09:04:37 -0700 (PDT)
Date:   Mon,  8 Apr 2019 09:04:31 -0700
In-Reply-To: <20190408160432.151478-1-sdf@google.com>
Message-Id: <20190408160432.151478-2-sdf@google.com>
Mime-Version: 1.0
References: <20190408160432.151478-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v2 2/3] libbpf: add support for ctx_{size,}_{in,out}
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

