Return-Path: <SRS0=hmOx=2T=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE16C2D0CE
	for <bpf@archiver.kernel.org>; Sun, 29 Dec 2019 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C1F20748
	for <bpf@archiver.kernel.org>; Sun, 29 Dec 2019 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577630279;
	bh=BpmdD9s9qvupnl0V+Z9FUuN1co6T0j/KoTfA78O2v58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zRgQS2bnwZ6ZdMxaIyp7OyznMlMDr4CysVD8M+hjhq/3gnfIUWp76vlcPZ/GO8oSf
	 zN+ru2rDfmyfSat8FZoIhR5AvlRe2/WXeM7YWOL7bOX9nfer65tv+uv221HDxItjWX
	 XlVtDMtthZsr9k+N0KfbKO8p5rwhgigLrdULF7eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfL2Oh7 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Sun, 29 Dec 2019 09:37:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726728AbfL2Oh6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Dec 2019 09:37:58 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-P3Sfw3ASNXG7ANfNk_ItoA-1; Sun, 29 Dec 2019 09:37:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1413E107ACC4;
        Sun, 29 Dec 2019 14:37:53 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-25.brq.redhat.com [10.40.204.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90ECD5DA2C;
        Sun, 29 Dec 2019 14:37:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@redhat.com>
Subject: [PATCH 3/5] bpf: Add bpf_get_stackid_kfunc
Date:   Sun, 29 Dec 2019 15:37:38 +0100
Message-Id: <20191229143740.29143-4-jolsa@kernel.org>
In-Reply-To: <20191229143740.29143-1-jolsa@kernel.org>
References: <20191229143740.29143-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: P3Sfw3ASNXG7ANfNk_ItoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to use bpf_get_stackid_kfunc in
BPF_TRACE_FENTRY/BPF_TRACE_FEXIT programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1b270bbd9016..c8e0709704f5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1203,12 +1203,40 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_kfunc = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+BPF_CALL_3(bpf_get_stackid_kfunc, void*, args,
+	   struct bpf_map *, map, u64, flags)
+{
+	struct pt_regs *regs = get_bpf_kfunc_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	perf_fetch_caller_regs(regs);
+	/* similar to bpf_perf_event_output_tp, but pt_regs fetched differently */
+	ret = bpf_get_stackid((unsigned long) regs, (unsigned long) map,
+			      flags, 0, 0);
+	put_bpf_kfunc_regs();
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_get_stackid_proto_kfunc = {
+	.func		= bpf_get_stackid_kfunc,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_CONST_MAP_PTR,
+	.arg3_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 kfunc_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
 	case BPF_FUNC_perf_event_output:
 		return &bpf_perf_event_output_proto_kfunc;
+	case BPF_FUNC_get_stackid:
+		return &bpf_get_stackid_proto_kfunc;
 	default:
 		return tracing_func_proto(func_id, prog);
 	}
-- 
2.21.1

