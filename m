Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7351C4332F
	for <bpf@archiver.kernel.org>; Tue,  4 Oct 2022 23:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJDXMR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 4 Oct 2022 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJDXMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 19:12:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9E564D8;
        Tue,  4 Oct 2022 16:12:10 -0700 (PDT)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ofr56-000AJL-Ih; Wed, 05 Oct 2022 01:12:08 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, john.fastabend@gmail.com,
        joannelkoong@gmail.com, memxor@gmail.com, toke@redhat.com,
        joe@cilium.io, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 04/10] bpf: Implement link introspection for tc BPF link programs
Date:   Wed,  5 Oct 2022 01:11:37 +0200
Message-Id: <20221004231143.19190-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221004231143.19190-1-daniel@iogearbox.net>
References: <20221004231143.19190-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26679/Tue Oct  4 09:56:50 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement tc BPF link specific show_fdinfo and link_info to emit ifindex,
attach location and priority.

Co-developed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/net.c               | 36 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c006f561648e..f1b089170b78 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6309,6 +6309,11 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 ifindex;
+			__u32 attach_type;
+			__u32 priority;
+		} tc;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/net.c b/kernel/bpf/net.c
index c50bcf656b3f..a74b86bb60a9 100644
--- a/kernel/bpf/net.c
+++ b/kernel/bpf/net.c
@@ -357,10 +357,46 @@ static void xtc_link_dealloc(struct bpf_link *l)
 	kfree(link);
 }
 
+static void xtc_link_fdinfo(const struct bpf_link *l, struct seq_file *seq)
+{
+	struct bpf_tc_link *link = container_of(l, struct bpf_tc_link, link);
+	u32 ifindex = 0;
+
+	rtnl_lock();
+	if (link->dev)
+		ifindex = link->dev->ifindex;
+	rtnl_unlock();
+
+	seq_printf(seq, "ifindex:\t%u\n", ifindex);
+	seq_printf(seq, "attach_type:\t%u (%s)\n",
+		   link->location,
+		   link->location == BPF_NET_INGRESS ? "ingress" : "egress");
+	seq_printf(seq, "priority:\t%u\n", link->priority);
+}
+
+static int xtc_link_fill_info(const struct bpf_link *l,
+			      struct bpf_link_info *info)
+{
+	struct bpf_tc_link *link = container_of(l, struct bpf_tc_link, link);
+	u32 ifindex = 0;
+
+	rtnl_lock();
+	if (link->dev)
+		ifindex = link->dev->ifindex;
+	rtnl_unlock();
+
+	info->tc.ifindex = ifindex;
+	info->tc.attach_type = link->location;
+	info->tc.priority = link->priority;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_tc_link_lops = {
 	.release	= xtc_link_release,
 	.dealloc	= xtc_link_dealloc,
 	.update_prog	= xtc_link_update,
+	.show_fdinfo	= xtc_link_fdinfo,
+	.fill_link_info	= xtc_link_fill_info,
 };
 
 int xtc_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c006f561648e..f1b089170b78 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6309,6 +6309,11 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 ifindex;
+			__u32 attach_type;
+			__u32 priority;
+		} tc;
 	};
 } __attribute__((aligned(8)));
 
-- 
2.34.1

