Return-Path: <SRS0=fGWk=3K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F057C33CAA
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 12:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653DF22314
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579608329;
	bh=BkHrbqMvATjGDN+G2h5meMJxbkbptjKyqhj/oKSVFUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ioWA/e4RQHEIzmWr+Yu5qENhEBc4GRxjnPG8++nyP7WD/MR76ietpi5H9wUO4DcD4
	 m80qdrPjKmR5MDo78Oj1B4t9Rfl7aJ7wDPy4rwXALN6sUnbuox6MUTpAZnt+q3GaP3
	 LakYJOZawSWR6oLTv63RLf0D9HG8/6/kErkWCHOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUMF2 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 21 Jan 2020 07:05:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35941 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729417AbgAUMF2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jan 2020 07:05:28 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-AloRpjTrOFKL8Zfe0I62Yg-1; Tue, 21 Jan 2020 07:05:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10422477;
        Tue, 21 Jan 2020 12:05:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29855C3FD;
        Tue, 21 Jan 2020 12:05:18 +0000 (UTC)
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
Subject: [PATCH 2/6] bpf: Add bpf_perf_event_output_kfunc
Date:   Tue, 21 Jan 2020 13:05:08 +0100
Message-Id: <20200121120512.758929-3-jolsa@kernel.org>
In-Reply-To: <20200121120512.758929-1-jolsa@kernel.org>
References: <20200121120512.758929-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AloRpjTrOFKL8Zfe0I62Yg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding support to use perf_event_output in
BPF_TRACE_FENTRY/BPF_TRACE_FEXIT programs.

Using nesting regs array from raw tracepoint helpers.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 19e793aa441a..6a18e2ae6e30 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1172,6 +1172,43 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+BPF_CALL_5(bpf_perf_event_output_kfunc, void *, ctx, struct bpf_map *, map,
+	   u64, flags, void *, data, u64, size)
+{
+	struct pt_regs *regs = get_bpf_raw_tp_regs();
+	int ret;
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	perf_fetch_caller_regs(regs);
+	ret = ____bpf_perf_event_output(regs, map, flags, data, size);
+	put_bpf_raw_tp_regs();
+	return ret;
+}
+
+static const struct bpf_func_proto bpf_perf_event_output_proto_kfunc = {
+	.func		= bpf_perf_event_output_kfunc,
+	.gpl_only	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_CONST_MAP_PTR,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
+static const struct bpf_func_proto *
+kfunc_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_perf_event_output:
+		return &bpf_perf_event_output_proto_kfunc;
+	default:
+		return tracing_func_proto(func_id, prog);
+	}
+}
+
 static const struct bpf_func_proto *
 tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1181,6 +1218,10 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skb_output_proto;
 #endif
 	default:
+		if (prog->expected_attach_type == BPF_TRACE_FENTRY ||
+		    prog->expected_attach_type == BPF_TRACE_FEXIT)
+			return kfunc_prog_func_proto(func_id, prog);
+
 		return raw_tp_prog_func_proto(func_id, prog);
 	}
 }
-- 
2.24.1

