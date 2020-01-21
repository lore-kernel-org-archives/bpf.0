Return-Path: <SRS0=fGWk=3K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C33BC2D0CE
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F8E24125
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579608330;
	bh=g/WKrRWI62tMiZNawtYpXHD+iEfNtQzh6DM3diPrThE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9SffQX3o29jgzsOUCJEvCahrj523Wj0YH14EbDDN3iZrrVr8tj0V8k6bsWkR5fWR
	 iLZAlJRZhxXxdSUDrUHYcNQcKSij5QlasCoUvBsVppcyUS++2ouVFwgT7WqSaTrkkS
	 eEToS2UThQVnHRpOVTwRQmuDb5w3iwFeGiDNAlOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgAUMF3 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 21 Jan 2020 07:05:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47412 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729471AbgAUMF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 07:05:29 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-giJJb_gDOYil-IfQgFQFCg-1; Tue, 21 Jan 2020 07:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA056DB62;
        Tue, 21 Jan 2020 12:05:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D00A5C28D;
        Tue, 21 Jan 2020 12:05:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH 3/6] bpf: Add bpf_get_stackid_kfunc
Date:   Tue, 21 Jan 2020 13:05:09 +0100
Message-Id: <20200121120512.758929-4-jolsa@kernel.org>
In-Reply-To: <20200121120512.758929-1-jolsa@kernel.org>
References: <20200121120512.758929-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: giJJb_gDOYil-IfQgFQFCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
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
 kernel/trace/bpf_trace.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6a18e2ae6e30..18d6e96751c4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1198,12 +1198,39 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_kfunc = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
+BPF_CALL_3(bpf_get_stackid_kfunc, void*, args,
+	   struct bpf_map *, map, u64, flags)
+{
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	perf_fetch_caller_regs(regs);
+	ret = bpf_get_stackid((unsigned long) regs, (unsigned long) map,
+			      flags, 0, 0);
+	put_bpf_raw_tp_regs();
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
2.24.1

