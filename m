Return-Path: <SRS0=8dm5=7L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D62C433E0
	for <bpf@archiver.kernel.org>; Fri, 29 May 2020 05:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3364206E2
	for <bpf@archiver.kernel.org>; Fri, 29 May 2020 05:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590729686;
	bh=Iiq3OZfCuHLylWoRVpJBo5maTiAFfzdAW2EnmsB+knY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2pHOeJevQNIgNen/58F1aB465Gg7a9qaQqBEygxdPdzaeRHD7ri1RD8eYsY5PB1OG
	 jV4xY0mvWyVdiyVFGvdSSqh958Nb3Io3+dJYG2ERRRZ3pbbN7BvckeWhmmzp/6N1Gr
	 DZnwTm343eWcdP1JFiEqH8Uuy+nxmSN92mQ2aGD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgE2FVZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 May 2020 01:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgE2FVT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 01:21:19 -0400
Received: from C02YQ0RWLVCF.internal.digitalocean.com (c-73-181-34-237.hsd1.co.comcast.net [73.181.34.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B152E2072D;
        Fri, 29 May 2020 05:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590729679;
        bh=Iiq3OZfCuHLylWoRVpJBo5maTiAFfzdAW2EnmsB+knY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzYUUFfRCK9ZATsxdbM4BBskhHsAIOK7vfYd4Twj9GZ8clQ/jGpab3zI2s0a+tBN8
         sVF+qoZXRiPZbrbQ3CiCTMrXul4B+INRgn2p7tyL9yooo6vhLeoLw0EILJZYJr1xCX
         zjImj190Euj/az6yxrxI+CggDv8VAPLLS5cz+jAU=
From:   David Ahern <dsahern@kernel.org>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        dsahern@gmail.com, David Ahern <dsahern@kernel.org>
Subject: [PATCH v3 bpf-next 4/5] libbpf: Add SEC name for xdp programs attached to device map
Date:   Thu, 28 May 2020 23:20:56 -0600
Message-Id: <20200529052057.69378-5-dsahern@kernel.org>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200529052057.69378-1-dsahern@kernel.org>
References: <20200529052057.69378-1-dsahern@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support SEC("xdp_devmap*") as a short cut for loading the program with
type BPF_PROG_TYPE_XDP and expected attach type BPF_XDP_DEVMAP.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 74d967619dcf..85d4f1c5fc52 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6657,6 +6657,8 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_ITER,
 		.is_attach_btf = true,
 		.attach_fn = attach_iter),
+	BPF_EAPROG_SEC("xdp_devmap",		BPF_PROG_TYPE_XDP,
+						BPF_XDP_DEVMAP),
 	BPF_PROG_SEC("xdp",			BPF_PROG_TYPE_XDP),
 	BPF_PROG_SEC("perf_event",		BPF_PROG_TYPE_PERF_EVENT),
 	BPF_PROG_SEC("lwt_in",			BPF_PROG_TYPE_LWT_IN),
-- 
2.21.1 (Apple Git-122.3)

