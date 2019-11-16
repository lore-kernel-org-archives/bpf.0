Return-Path: <SRS0=JBMC=ZI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613EC432C3
	for <bpf@archiver.kernel.org>; Sat, 16 Nov 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B0E2081E
	for <bpf@archiver.kernel.org>; Sat, 16 Nov 2019 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919352;
	bh=HsPWwmDEIMEtsZTabfg0H5Vjz9voDV9fpRM5MsHpzpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ov4mijnGVPpAW/nftf/7U64DxR3+W6xmG25ar1gkJeYUpiYY4EnmJdVbTDn66b8i3
	 6rDxgIWDuIkg9Mdh6tvuWAtmzdK89fmCCblrdidNK7Pnt+IpxyYfqHDPMIcsm3Nns+
	 35hyZ+ItldzvGHlcgCczPl6Gb1keBl7w/0QSDRw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfKPPs6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbfKPPs6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:58 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7022086A;
        Sat, 16 Nov 2019 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919337;
        bh=HsPWwmDEIMEtsZTabfg0H5Vjz9voDV9fpRM5MsHpzpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPkZ0RWBlRmZUlrCMs1PzBx6T3OLoSPeotxvUx3fcuBCzhr5gSQ+xGqyziWvON3OV
         E14ZCzt04i2IcCuP5LX6eeVFNasEZfM6TycsKHMAH6s5LQPrpX1sGQbsmlyxuOhFIj
         6p7MIzPfvFr3V6C60tMTNsTG1/aGPc3YvzVlEyGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 077/150] sparc64: Rework xchg() definition to avoid warnings.
Date:   Sat, 16 Nov 2019 10:46:15 -0500
Message-Id: <20191116154729.9573-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 6c2fc9cddc1ffdef8ada1dc8404e5affae849953 ]

Such as:

fs/ocfs2/file.c: In function ‘ocfs2_file_write_iter’:
./arch/sparc/include/asm/cmpxchg_64.h:55:22: warning: value computed is not used [-Wunused-value]
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

and

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function ‘ixgbevf_xdp_setup’:
./arch/sparc/include/asm/cmpxchg_64.h:55:22: warning: value computed is not used [-Wunused-value]
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_64.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index f71ef3729888f..316faa0130bab 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -52,7 +52,12 @@ static inline unsigned long xchg64(__volatile__ unsigned long *m, unsigned long
 	return val;
 }
 
-#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x)							\
+({	__typeof__(*(ptr)) __ret;					\
+	__ret = (__typeof__(*(ptr)))					\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
+	__ret;								\
+})
 
 void __xchg_called_with_bad_pointer(void);
 
-- 
2.20.1

