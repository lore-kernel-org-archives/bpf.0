Return-Path: <SRS0=eV/F=6V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CE3C4724C
	for <bpf@archiver.kernel.org>; Thu,  7 May 2020 10:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CCF24964
	for <bpf@archiver.kernel.org>; Thu,  7 May 2020 10:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAin0dEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgEGKoM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 May 2020 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgEGKoL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 06:44:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8543FC061A10;
        Thu,  7 May 2020 03:44:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so2832129pfn.3;
        Thu, 07 May 2020 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tz8I1ofrUYKZZa7+UlEDx8Su4gDS1jJlBTe3ya5G/ds=;
        b=hAin0dEfa8D0QT/xdbYwtSmY+r/ADzs/RPbx2NxEa/jKNukKs4rwsNguI24CIp6oTf
         gmtWMp5Fp6TJhu+iSldZKsyr9EcJZe+amBQs0Fyro1du0s74NdVqBX7ashXchIFoiZBK
         Rzx3vBfVsBxZNMjeZIQBCy74WhlkOxhCohnT64oWhUz+r5gutgpq6rDrmnZ2jwBOQkhV
         Tgqt/+w/Zp5vljfRZkDy9npt5mCCOKu7kzqR+JSsNy7zJ2E58+4ickhJ4ZfWH67Z21IA
         ACnB0xTW80+ptgxCStBbEadbJxULXX1Yk7ccye9KwhZ7lOlYi4VZSjDKACqCV1ZMLLLM
         ar1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tz8I1ofrUYKZZa7+UlEDx8Su4gDS1jJlBTe3ya5G/ds=;
        b=b1WI6bp8s4ZIsdirijey4tAeVlkH18plLw/6er8hJNdxQGTSF0qfp2fRXI7SE48fiN
         Zr32LKhPBcRSkssmVisXwiOp5az5Nc1ZDWFOT5F0NudbIA52A6jzUhunb9qtJ3QbUbR4
         yrTEVjQNrjB/A/NLxneWw7cXCqUojiohKXXp7Xfkjfu35y2NudSWcY/knLM/XjfqA+VB
         f5VZyqljpnYVrnDXOOtACfiy2plwhpHB/NO9oiZ0Nz6aldE8bkZjZq5BENFXCf0tIvkZ
         59IS2l1TszZa0xHyb0p/S6fMNbnGkT4cGtF26wIzFC3cYNQtb4lHyvkqGkhJ2UPgcjZs
         VIGQ==
X-Gm-Message-State: AGi0Pubbda2Owlk0x+DGKF/gnEbofc/6HlcXVNdZ4jFMfhpQHETviPgJ
        y6bbTzf+zlFHoFVCtZfytEE=
X-Google-Smtp-Source: APiQypKbdaq3C7zr1ivVJbvbFSEBssGigWYGEZNCrfHBlivoeLmBnZs2pCPAgqtUg9m0K3FwFbyBWQ==
X-Received: by 2002:a63:db03:: with SMTP id e3mr5482597pgg.413.1588848250940;
        Thu, 07 May 2020 03:44:10 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id j14sm7450673pjm.27.2020.05.07.03.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 03:44:10 -0700 (PDT)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        jeffrey.t.kirsher@intel.com
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        maximmi@mellanox.com, maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 12/14] xdp: simplify xdp_return_{frame,frame_rx_napi,buff}
Date:   Thu,  7 May 2020 12:42:50 +0200
Message-Id: <20200507104252.544114-13-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507104252.544114-1-bjorn.topel@gmail.com>
References: <20200507104252.544114-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

The xdp_return_{frame,frame_rx_napi,buff} function are never used,
except in xdp_convert_zc_to_xdp_frame(), by the MEM_TYPE_XSK_BUFF_POOL
memory type.

To simplify and reduce code, change so that
xdp_convert_zc_to_xdp_frame() calls xsk_buff_free() directly since the
type is know, and remove MEM_TYPE_XSK_BUFF_POOL from the switch
statement in __xdp_return() function.

Suggested-by: Maxim Mikityanskiy <maximmi@mellanox.com>
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 net/core/xdp.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 11273c976e19..7ab1f9014c5e 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -334,10 +334,11 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
  * scenarios (e.g. queue full), it is possible to return the xdp_frame
  * while still leveraging this protection.  The @napi_direct boolean
  * is used for those calls sites.  Thus, allowing for faster recycling
- * of xdp_frames/pages in those cases.
+ * of xdp_frames/pages in those cases. This path is never used by the
+ * MEM_TYPE_XSK_BUFF_POOL memory type, so it's explicitly not part of
+ * the switch-statement.
  */
-static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
-			 struct xdp_buff *xdp)
+static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct)
 {
 	struct xdp_mem_allocator *xa;
 	struct page *page;
@@ -359,33 +360,29 @@ static void __xdp_return(void *data, struct xdp_mem_info *mem, bool napi_direct,
 		page = virt_to_page(data); /* Assumes order0 page*/
 		put_page(page);
 		break;
-	case MEM_TYPE_XSK_BUFF_POOL:
-		/* NB! Only valid from an xdp_buff! */
-		xsk_buff_free(xdp);
-		break;
 	default:
 		/* Not possible, checked in xdp_rxq_info_reg_mem_model() */
+		WARN(1, "Incorrect XDP memory type (%d) usage", mem->type);
 		break;
 	}
 }
 
 void xdp_return_frame(struct xdp_frame *xdpf)
 {
-	__xdp_return(xdpf->data, &xdpf->mem, false, NULL);
+	__xdp_return(xdpf->data, &xdpf->mem, false);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame);
 
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
 {
-	__xdp_return(xdpf->data, &xdpf->mem, true, NULL);
+	__xdp_return(xdpf->data, &xdpf->mem, true);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
 
 void xdp_return_buff(struct xdp_buff *xdp)
 {
-	__xdp_return(xdp->data, &xdp->rxq->mem, true, xdp);
+	__xdp_return(xdp->data, &xdp->rxq->mem, true);
 }
-EXPORT_SYMBOL_GPL(xdp_return_buff);
 
 /* Only called for MEM_TYPE_PAGE_POOL see xdp.h */
 void __xdp_release_frame(void *data, struct xdp_mem_info *mem)
@@ -466,7 +463,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->metasize = metasize;
 	xdpf->mem.type = MEM_TYPE_PAGE_ORDER0;
 
-	xdp_return_buff(xdp);
+	xsk_buff_free(xdp);
 	return xdpf;
 }
 EXPORT_SYMBOL_GPL(xdp_convert_zc_to_xdp_frame);
-- 
2.25.1

