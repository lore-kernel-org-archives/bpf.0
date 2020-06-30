Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F4C433E1
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 12:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D1920774
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593521481;
	bh=asZVTOfRDaIe+5d3XpjzlIhAgVjxLyWnenKWAyFaee8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SoOnexNaA0cONDmBywHMqYtO82oXK3O7aBj+YXwWXtU+Fl5QZavvEg4KMicNMeJZ3
	 vz159HJDf5GV4PqTLNEqfVZ5DSpcMhGgdOvlwxikF9O+WqGN+bEdE0Gi1AidPlw2Kq
	 wioACoPw3I6hivy7qY+imMQlsc4W/nOdlOjoYcVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgF3MvV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387975AbgF3MvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 08:51:20 -0400
Received: from localhost.localdomain.com (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8409520853;
        Tue, 30 Jun 2020 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593521479;
        bh=asZVTOfRDaIe+5d3XpjzlIhAgVjxLyWnenKWAyFaee8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnBpkB8+/hBruplW0m0kSg4XdtdxJBdU/eCBIpZ8G17Wj7Z6OeinvGrp06VDLKN3j
         42nh+qAkfV2Xiv2KHKa94ObakY5o/7EQqqtnIKU0myVicFIcWJzgQkxDKkLF3xe63k
         b6Lht9Xma3GcDCu8fHa9F9tCgwDZOoOxM99nx7y8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v5 bpf-next 7/9] libbpf: add SEC name for xdp programs attached to CPUMAP
Date:   Tue, 30 Jun 2020 14:49:42 +0200
Message-Id: <de19593f7e2991bc64f7362054c1a00378a50567.1593521030.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593521029.git.lorenzo@kernel.org>
References: <cover.1593521029.git.lorenzo@kernel.org>
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
index 4ea7f4f1a691..cad4312cab8e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6906,6 +6906,8 @@ static const struct bpf_sec_def section_defs[] = {
 		.attach_fn = attach_iter),
 	BPF_EAPROG_SEC("xdp_devmap",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
+	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
+						BPF_XDP_CPUMAP),
 	BPF_PROG_SEC("xdp",			BPF_PROG_TYPE_XDP),
 	BPF_PROG_SEC("perf_event",		BPF_PROG_TYPE_PERF_EVENT),
 	BPF_PROG_SEC("lwt_in",			BPF_PROG_TYPE_LWT_IN),
-- 
2.26.2

