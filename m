Return-Path: <SRS0=svjS=DJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8661AC4363D
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 14:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4AD20719
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601649790;
	bh=nTkR6CoGaIVQB6iOYx0cq2wjexcHkxglFc3NY+26Wsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1y+o+o6vhniHQRTNu7qJmOXqHdQJxHwh68gPpAoKrmzrOoOAMQ/JD/Oblzcz1dgK
	 MvgXX2EVsZhCv9SFu38+F00csWvKv9u8P1ZhBmzK0eUfLNLLsq7RoKk4GulLIXeIvG
	 dt+KXRnXydKwPUxUUsEw2lmI/rkQkHfk8O8aml6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgJBOnJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBOnI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 10:43:08 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10620206FA;
        Fri,  2 Oct 2020 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601649787;
        bh=nTkR6CoGaIVQB6iOYx0cq2wjexcHkxglFc3NY+26Wsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ux2FDOoM8BjL412Vr1UJU5hLGWpEa17G0a1LiL+kj5JCLk2juJr37L64GaJv3iSmt
         xGfecMnzxslUMZAm4XO5tLy4fEZB2fDDTN+dCqzDUvtu4BKAJPqTWETbadlsvJkGu8
         D+SE2TFTsp87i5mSN++6nP+eS51p+SeY/TDTIG50=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, sameehj@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        lorenzo.bianconi@redhat.com, echaudro@redhat.com
Subject: [PATCH v4 bpf-next 10/13] bpf: test_run: add skb_shared_info pointer in bpf_test_finish signature
Date:   Fri,  2 Oct 2020 16:42:08 +0200
Message-Id: <25a087aee8345fd87244d2e860e6636db36af01a.1601648734.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601648734.git.lorenzo@kernel.org>
References: <cover.1601648734.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

introduce skb_shared_info pointer in bpf_test_finish signature in order
to copy back paged data from a xdp multi-buff frame to userspace buffer

Tested-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/bpf/test_run.c | 58 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index ec7286cd051b..7e33181f88ee 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -79,9 +79,23 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	return ret;
 }
 
+static int bpf_test_get_buff_data_len(struct skb_shared_info *sinfo)
+{
+	int i, size = 0;
+
+	if (likely(!sinfo))
+		return 0;
+
+	for (i = 0; i < sinfo->nr_frags; i++)
+		size += skb_frag_size(&sinfo->frags[i]);
+
+	return size;
+}
+
 static int bpf_test_finish(const union bpf_attr *kattr,
 			   union bpf_attr __user *uattr, const void *data,
-			   u32 size, u32 retval, u32 duration)
+			   struct skb_shared_info *sinfo, u32 size,
+			   u32 retval, u32 duration)
 {
 	void __user *data_out = u64_to_user_ptr(kattr->test.data_out);
 	int err = -EFAULT;
@@ -96,8 +110,35 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 		err = -ENOSPC;
 	}
 
-	if (data_out && copy_to_user(data_out, data, copy_size))
-		goto out;
+	if (data_out) {
+		int len = copy_size - bpf_test_get_buff_data_len(sinfo);
+
+		if (copy_to_user(data_out, data, len))
+			goto out;
+
+		if (sinfo) {
+			int i, offset = len, data_len;
+
+			for (i = 0; i < sinfo->nr_frags; i++) {
+				skb_frag_t *frag = &sinfo->frags[i];
+
+				if (offset >= copy_size) {
+					err = -ENOSPC;
+					break;
+				}
+
+				data_len = min_t(int, copy_size - offset,
+						 skb_frag_size(frag));
+				if (copy_to_user(data_out + offset,
+						 skb_frag_address(frag),
+						 data_len))
+					goto out;
+
+				offset += data_len;
+			}
+		}
+	}
+
 	if (copy_to_user(&uattr->test.data_size_out, &size, sizeof(size)))
 		goto out;
 	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
@@ -598,7 +639,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	/* bpf program can never convert linear skb to non-linear */
 	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
 		size = skb_headlen(skb);
-	ret = bpf_test_finish(kattr, uattr, skb->data, size, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
+			      duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct __sk_buff));
@@ -683,7 +725,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (xdp.data != data + headroom || xdp.data_end != xdp.data + size)
 		size += xdp.data_end - xdp.data - data_len;
 
-	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, xdp.data, sinfo, size, retval,
+			      duration);
+
 out:
 	bpf_prog_change_xdp(prog, NULL);
 	for (i = 0; i < sinfo->nr_frags; i++)
@@ -793,8 +837,8 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	do_div(time_spent, repeat);
 	duration = time_spent > U32_MAX ? U32_MAX : (u32)time_spent;
 
-	ret = bpf_test_finish(kattr, uattr, &flow_keys, sizeof(flow_keys),
-			      retval, duration);
+	ret = bpf_test_finish(kattr, uattr, &flow_keys, NULL,
+			      sizeof(flow_keys), retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
 				     sizeof(struct bpf_flow_keys));
-- 
2.26.2

