Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB84C433E1
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397662078D
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597865340;
	bh=Fi3+BUE5A4mXbTiMqGBNYNQ6dnKXtOhLvcPzHlq40Y4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lDDAtLFs+b8fnP0yzR++3zeDjgMM9eaxk3zhpIaw97k4zeNpT+eIEw6wTvuyWTSUi
	 5AtWE1oag7+Z7bYCVpg/RLfvICAVQD/5t/Vz0G31XPyq6H0EHfbEvjWgzmyMzUAymm
	 wdy571osPenXBTC2/Yfirq0hd0Y0XhlpDeeHl5mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHST26 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHST25 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 15:28:57 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17712078D;
        Wed, 19 Aug 2020 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597865337;
        bh=Fi3+BUE5A4mXbTiMqGBNYNQ6dnKXtOhLvcPzHlq40Y4=;
        h=From:To:Cc:Subject:Date:From;
        b=NY2jzr+0+YkeoePQDcog1D8FiUOpX2wtpImRgPqE05cvDqC3usRZ8xtMkXqb0Fg7y
         a2seXfIOXkuNo3o81Cv/vMR4mfy2hJkspDhZAfb3T2nNSsMemUiiwVsN4zePnNxSig
         U+viYjmFMu30l7KA2G1nBQ8toiowx5CEa5FIf5ck=
From:   Jakub Kicinski <kuba@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf] bpf: refer to struct xdp_md in user space comments
Date:   Wed, 19 Aug 2020 12:27:23 -0700
Message-Id: <20200819192723.838228-1-kuba@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

uAPI uses xdp_md, not xdp_buff. Fix comments.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/bpf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0480f893facd..cc3553a102d0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1554,7 +1554,7 @@ union bpf_attr {
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
- * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
+ * long bpf_xdp_adjust_head(struct xdp_md *xdp_md, int delta)
  * 	Description
  * 		Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
  * 		it is possible to use a negative value for *delta*. This helper
@@ -1752,7 +1752,7 @@ union bpf_attr {
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
- * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
+ * long bpf_xdp_adjust_meta(struct xdp_md *xdp_md, int delta)
  * 	Description
  * 		Adjust the address pointed by *xdp_md*\ **->data_meta** by
  * 		*delta* (which can be positive or negative). Note that this
@@ -2051,7 +2051,7 @@ union bpf_attr {
  * 	Return
  * 		0 on success, or a negative error in case of failure.
  *
- * long bpf_xdp_adjust_tail(struct xdp_buff *xdp_md, int delta)
+ * long bpf_xdp_adjust_tail(struct xdp_md *xdp_md, int delta)
  * 	Description
  * 		Adjust (move) *xdp_md*\ **->data_end** by *delta* bytes. It is
  * 		possible to both shrink and grow the packet tail.
@@ -3049,7 +3049,7 @@ union bpf_attr {
  *		The value to write, of *size*, is passed through eBPF stack and
  *		pointed by *data*.
  *
- *		*ctx* is a pointer to in-kernel struct xdp_buff.
+ *		*ctx* is a pointer to in-kernel struct xdp_md.
  *
  *		This helper is similar to **bpf_perf_eventoutput**\ () but
  *		restricted to raw_tracepoint bpf programs.
-- 
2.26.2

