Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7EC77B61
	for <bpf@archiver.kernel.org>; Mon, 24 Apr 2023 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjDXQFp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjDXQFo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DB6A63
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5734F61B47
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D8AC433EF;
        Mon, 24 Apr 2023 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352342;
        bh=wq2SNcUk2IUQg/YAu2RwBStrExCr+1rRnd25SvVfb44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8quFtRPupD1KFIjgAtUrBUhXOzx0gQX1CuZEpIUhrLuxx/1FvXHZ1YJmerLZDsUU
         GyxeK0xhKEJVISk0OX8hx5tGYAQ/R3AZyaOQ2ONud7CNNCKoof4N3mAs6YJvRnju0D
         HMnX8LNbj20VDW72QXki6qDpSV0a6f8RQN69S/KWUbAd6bUkW4TTBYM3hsg7F0VUXf
         RrpNA2m5wLgnJZNVQ/KljqL7j6/ASWBF3+mr1vZumeGkuT+F0pihj0PCZwGBhN6imx
         3FOLE4YN0mzDRr40GQbSShHjgvlb9ivmI+HuvnxncbJe+ShuJUVBs2UqEl7Do6FpvA
         cKIrzHTb5+BvQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 05/20] libbpf: Add uprobe_multi attach type and link names
Date:   Mon, 24 Apr 2023 18:04:32 +0200
Message-Id: <20230424160447.2005755-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding new uprobe_multi attach type and link names,
so the functions can resolve the new values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1cbacf9e71f3..b5bde1f19831 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -117,6 +117,7 @@ static const char * const attach_type_name[] = {
 	[BPF_PERF_EVENT]		= "perf_event",
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 	[BPF_STRUCT_OPS]		= "struct_ops",
+	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
 };
 
 static const char * const link_type_name[] = {
@@ -131,6 +132,7 @@ static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_KPROBE_MULTI]		= "kprobe_multi",
 	[BPF_LINK_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_LINK_TYPE_NETFILTER]		= "netfilter",
+	[BPF_LINK_TYPE_UPROBE_MULTI]		= "uprobe_multi",
 };
 
 static const char * const map_type_name[] = {
-- 
2.40.0

