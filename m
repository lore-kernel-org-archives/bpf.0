Return-Path: <SRS0=I/LR=AZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64EDC433FC
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C1D22518
	for <bpf@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594735050;
	bh=RcEbvJVJN196M8KBSoV1tLLR/LFOVDAM9Dwbj49E7gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2vsyRE56WyJs/mFRg8IvlguOR64My7vVFa29ve3Ym4CG4Pk/3urMe9Y1SUApir6c
	 Nlwfg7hj/HS9ROnDJQjxUO1E3kXK7UfTkz0LPnEI4FGjgMhUnPH9JAwm18uU5h3psm
	 PdMRJc4HaKTtvo4IjFI+WemLVQCDBF+9qKhihjBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGNN5a (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgGNN51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 09:57:27 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A55224D3;
        Tue, 14 Jul 2020 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594735047;
        bh=RcEbvJVJN196M8KBSoV1tLLR/LFOVDAM9Dwbj49E7gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxv7kUVSUsibb/VM5tvvkIr1BUjb7mU9QU8890yxKNJwV9ZHv4de+Op/dc2ncwxkN
         lTtcPWTE3c6anNw4Pe4y2sEFSNiB2pOuF4ftBNh6twB/tKnAF+nBeRBzVdav8bOell
         YhfEo5akneUHOPYgubM8ss7l6H1pqVghIoMlarxE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v7 bpf-next 7/9] libbpf: add SEC name for xdp programs attached to CPUMAP
Date:   Tue, 14 Jul 2020 15:56:40 +0200
Message-Id: <33174c41993a6d860d9c7c1f280a2477ee39ed11.1594734381.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594734381.git.lorenzo@kernel.org>
References: <cover.1594734381.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As for DEVMAP, support SEC("xdp_cpumap/") as a short cut for loading
the program with type BPF_PROG_TYPE_XDP and expected attach type
BPF_XDP_CPUMAP.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4489f95f1d1a..f55fd8a5c008 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6912,6 +6912,8 @@ static const struct bpf_sec_def section_defs[] = {
 		.attach_fn = attach_iter),
 	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
+	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
+						BPF_XDP_CPUMAP),
 	BPF_PROG_SEC("xdp",			BPF_PROG_TYPE_XDP),
 	BPF_PROG_SEC("perf_event",		BPF_PROG_TYPE_PERF_EVENT),
 	BPF_PROG_SEC("lwt_in",			BPF_PROG_TYPE_LWT_IN),
-- 
2.26.2

