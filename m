Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6D4C8FFC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271885; cv=none; b=p8Xy8noRx1hqVrO0XsoNonNYQDLFB+Aotg+Dfm28Q8NKYr56AloIcbbkeZwRm2zDm+1Rd/2sn7etofYn8hXpCve+5frJ0LY+9q2AUPhwfSrj0SaKl+CEim0hKCokaZW3coFX5NDznao6kY/6NTJmkSwxP2MWev5YOyBnL9KrfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271885; c=relaxed/simple;
	bh=X9s3Sgeg+Qz0CBFuoc06D8CjvCY8qzDKaEoRAYjmcpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCr5mSXHloOhtPV9aW6/iPgAL3nm6nnKvHUdiISojYLEXBroWx41RyGfDgb0esV3nTnIthjdeZjzqCsyjJrEXXtnbIDMGagMmXCk+yy+9WtTtOh8ik5jQWfs3c76u4K5opsX9CK7f+pVi67y1S/YjzREnXvcy6puCbpORbJAGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAddMsfA; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAddMsfA"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-48f0056ef38so213326fac.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271882; x=1790876682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nf39wGs2BpcRYOj5iRc1ngLTSaY62SScC50mxJXgkk=;
        b=tAddMsfAAU1PPSw2FJQfGPBb6Odv8qU2IKRwBjYnrPB0HnuQSHGIFmXGFcmg0mOXfE
         Lj9erZWNm1FweaStbmSK/flb2iww+b99ydbn6LxUBQ2EutWHbHmQtpfWrwqkE5XfjdEv
         h047eG/FIiYj7C5Z7I/Nyx1+PRu+/eFlhU0wB7A6ynDkBEsIV7FoovsW5R/jBrbHJcgL
         1VmBQyiDbJpsthEqGLgVCxP9ACEgkmqkQ5aBxWe46E8Rd6xU0y38x9WHJi2hPpliUkbW
         2boKDXlzJa5SOWq6rElGvDWg1KmFdyjwYJhku/NAD0Gct9ZW8EoseK7oeisVbdlfn5+B
         alqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271882; x=1790876682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nf39wGs2BpcRYOj5iRc1ngLTSaY62SScC50mxJXgkk=;
        b=Q1w5mYSuWbS3kiqyHP0rRGKu6Gn92IegfUnr3oNMWUv/NOPE8+Sk/gQtnqdnXLboe8
         JuJP5CHE4p4U0APoKaV6Wvao5GpEIXnJLwivBF9N8XW3xepB4kk0Zj5GLpFzi7ADj8XK
         fmhFvXStdZn3MvXZiae7MkEunv5md5/F4FG1WoLHjTBcDfd1aIHzd3OSiJMUoQiB6ru8
         5O2MUlAKsDTYCVXqapHEoz6q08er3Cwe/FxOozDwOKyCuVFrisVu40l+E9GNkX45VLg7
         Ri8rRtgdMOYh4ydNJt00Wni/erv2zYo0wMF7bl83WzZZnkhHENhqfTc9FIWGRsM7N96n
         Eorg==
X-Forwarded-Encrypted: i=1; AKwUvBwq0kMYjt3v2sWdfgiHJQkQ68zTF3gZpGJnxKnhOV/+j7knqrtrcyqAHq3IK2Sw0uVdlkA=@vger.kernel.org
X-Gm-Message-State: AFuF++nCdzqfslAaPbDVBoVdBSuWHv8SzeVm+D9+ZFgbnLjdlIpECcxD
	oy9R+jpn+l3kuKxMHIbyKl4pqilT4hBSO09nQmz+FOocivOnauubwNf+
X-Gm-Gg: AYBFou0gxTor8ao8atjP1kf5bxwpqGEWWsmzsIHJ3ASZpYQ9WHS/R2XGZGm5oMyVwNK
	LH31nhVYFU+XdspPCDlLWMzF5ONQd+wRijHevZ6xy+cdaZRnbm9MyN5j/aZ/lch/ohI6wW3oLF1
	Jtu++hQzvXPKDjgM4siyL5rx1A046ciFrzkwcO0BmYo9aKG6cJ6QTVnWT4rC8Kg6Pp3FBs8fiF2
	yD+rAJ5zfEZB1fvKIH+yCePjBXNnsir+cG7mVcvGx2ppbxiO4CpCocWQmAagKN9v/me1v4tS5Pf
	m/qKpuQeRbvPYkjqvNPl6LUJgIE8igG7DP1zUudLa5BFayZw26gLEYahc7yeitmjRMN69da0QQd
	GgtEnMCOuqZPLtUmgVmXXNh/+pG8p7aHW6KlEjrc5INeole9qc+EXwuUVq56XXtGEOqusWLskEM
	Wi4qMI+fWwvyv5fs4Qii05BWujWaWAvUE0UQ5tCcsZZFnvdr0yZphzRjnKnT5tF6GNbtyPbcbgp
	Gaqz+GbjCILB3aVtaQREjl/QrgVHQA/SbkHnlgf1zvGhWaGDnPREDgCF0Kdf8CKirHyc5aDPnZR
	274Y+q7KDEqdbu/8181sOI8lRB3NE/o2TSZJgo++jXuGdviZvN6uJu/V2+IffoR5oTKUknT4OSK
	spQl2vlpDRimwX43BJ6C7Kg==
X-Received: by 2002:a05:6871:3a27:b0:479:a30d:60e5 with SMTP id 586e51a60fabf-491e91f05e0mr3134003fac.37.1790271882396;
        Thu, 24 Sep 2026 10:44:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:34 -0600
Subject: [PATCH net v3 04/10] net: stmmac: leave the datapath running for
 normal-size MTU changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-4-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Changing an MTU at or below ETH_DATA_LEN does not change the receive
buffer size or the MAC receive limit when the previous MTU was also in
that range. Do not release and reopen the datapath for those changes.

Besides avoiding unnecessary hardware resets and their failure paths,
this keeps live AF_XDP pool bindings intact. Preparing replacement rings
before stopping the old rings otherwise binds the pool to a temporary
RXQ and consumes fill-ring entries while its current RXQ is still active.
XDP already rejects jumbo MTUs, so all supported live XDP MTU changes can
use this path without preparing replacement rings.

Keep jumbo transitions on the existing reinitialization path for now.
The later ownership and rollback changes address that path separately.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 43a6154fcf6d..f7e91ae21448 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6223,7 +6223,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 	if ((txfifosz < new_mtu) || (new_mtu > BUF_SIZE_16KiB))
 		return -EINVAL;
 
-	if (netif_running(dev)) {
+	/* Normal-size frames use the same buffers and MAC receive limits.
+	 * In particular, do not disturb a live AF_XDP pool: XDP does not
+	 * support jumbo frames, so it never needs the ring replacement below.
+	 */
+	if (netif_running(dev) &&
+	    (dev->mtu > ETH_DATA_LEN || mtu > ETH_DATA_LEN)) {
 		netdev_dbg(priv->dev, "restarting interface to change its MTU\n");
 		/* Try to allocate the new DMA conf with the new mtu */
 		dma_conf = stmmac_setup_dma_desc(priv, mtu);

-- 
2.53.0

