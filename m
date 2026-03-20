Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702036E470;
	Fri, 20 Mar 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041592; cv=none; b=fuXDJeadJSSolNd21DT0Hi3Y6m8pOg+NxFl7w1IU6vG9ywcDmASvCH8P/D//AGVv8/YhLq1oEm3UvsEUfBBL7YdY1kb5jB7mg/2z6QfhnxLYfcueWVEsf1yNE2PfcrbqhfSJXJSd5gbWl94uYJeK0BBudmV7oj+sEtbRiNW1akI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041592; c=relaxed/simple;
	bh=Qj0VCImCrWJnC20PW2Tcs//uU7c7cuxI1j0MHoEqggs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjY9VlMLBQT8JfyDtHCFPfwGNf+Cay5EW8DIRgZrhjus7M5ty436ec5wsnOGV7rBJRMzdYgY36jyCp9Dsnc/BelhfEICbLS7H0EXdeQC6BCgZah30ESQVvaQf1oAg6LVnpXZONGHH1Rrnxp4eo4GMHd/EYWQPVP4mXOXwirzK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ArQ2Nktf; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ArQ2Nktf"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BB60CC00081F;
	Fri, 20 Mar 2026 14:19:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BB60CC00081F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1774041589;
	bh=Qj0VCImCrWJnC20PW2Tcs//uU7c7cuxI1j0MHoEqggs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArQ2Nktf3jVtIbnxmMSl9mPe+MIhMBWmUQtghIm15+GbJnJBWWDVsjEb29flyJJeN
	 ElqFmI/U0XHc3iv6h3NWiB+PzDW9aAGDy1UJINileumZHhOSJHt2WOQgFVIzOrJLzz
	 xxLgPJRFv/ebBYJQCbaA5UaIhmVUiQbXhhOPLY8A=
Received: from lvnvdb8054.lvn.broadcom.net (lvnvdb8054.lvn.broadcom.net [10.17.214.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id C6527AE81;
	Fri, 20 Mar 2026 17:19:46 -0400 (EDT)
From: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	rmk+kernel@armlinux.org.uk,
	rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	me@ziyao.cc,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	vladimir.oltean@nxp.com,
	lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com,
	maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com,
	yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com,
	chenhuacai@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v8 1/6] Add 25GMAC core type to dwmac_core_type enum
Date: Fri, 20 Mar 2026 14:19:16 -0700
Message-ID: <20260320211921.1202058-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
References: <20260320211921.1202058-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

The DW25GMAC is a newer ethernet MAC IP block from Synopsys that introduced
new DMA architecure called Hyper-DMA. Define a new dwmac_core_type
enum in include/linux/stmmac.h file.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 include/linux/stmmac.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 72febd246bdb..464f4f2e366a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -197,6 +197,7 @@ enum dwmac_core_type {
 	DWMAC_CORE_GMAC,
 	DWMAC_CORE_GMAC4,
 	DWMAC_CORE_XGMAC,
+	DWMAC_CORE_25GMAC,
 };
 
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
-- 
2.34.1

