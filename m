Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F87AC433EF
	for <bpf@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiBNIO2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Feb 2022 03:14:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbiBNIO1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 03:14:27 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E95F8EE;
        Mon, 14 Feb 2022 00:14:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V4O5x7N_1644826457;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V4O5x7N_1644826457)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Feb 2022 16:14:18 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: [PATCH v5 01/22] virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
Date:   Mon, 14 Feb 2022 16:13:55 +0800
Message-Id: <20220214081416.117695-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
here https://github.com/oasis-tcs/virtio-spec/issues/89

For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.

Since I want to add queue_reset after queue_notify_data, I submitted
this patch first.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/uapi/linux/virtio_pci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 3a86f36d7e3d..22bec9bd0dfc 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
 	__le32 queue_used_hi;		/* read-write */
 };
 
+struct virtio_pci_common_cfg_notify {
+	struct virtio_pci_common_cfg cfg;
+
+	__le16 queue_notify_data;	/* read-write */
+	__le16 padding;
+};
+
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
 struct virtio_pci_cfg_cap {
 	struct virtio_pci_cap cap;
-- 
2.31.0

