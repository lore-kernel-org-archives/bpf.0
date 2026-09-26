Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C2379960
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437774; cv=none; b=gKuY+kKTQVxlC3bjWeOcgGgi2/NelH0xYlzcB+GiNQ1BKQcfvmpKV/7dKeaBIOnpFeMzLiquHkOUGji9bSQ2xqUpakuP2uS1zyu0439FyBYydmpA30+zeWhiLVTQZi/ZstcW0u6eUbTCi835xR04N4JfyxwlctLeopml54XCXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437774; c=relaxed/simple;
	bh=2ChPtfS7fuQ6xmL5pBM0ED+Tz6MNWUwwNmCfWCfm6zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uT+JvImz+d3c+3qTrwMm5m4S5gmPLLlzW5JH8KqBKWgCDSsB1NjwYtw6Tktlr7hmOYVoYhDwRmktCfssCkW5zRd7ij1dw704TQHwEnaOwlUTGYaZc11vstvCTbZlTBxw4FbRoW1a6f+hrmF9PjIsyfujthIJboqwfXyqJAbxQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mohVNcip; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mohVNcip"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fb68so1098792a34.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437768; x=1791042568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pt1JZ0Xx4dSQpjlcwcv4OrOAetyhY0kdTpc42Knguac=;
        b=mohVNcipWlGEJslyD0IsZkG+B5AWQcv5qAkzYCOwQUICWSKmnSx5vjgc13hcsLdTpZ
         qlyD7kSE0P6DL3qf2Kfg9MA3nVIP5m19BH1Fa/68btsEZPAGWhOnXwH5VxCn1snzRnDi
         v1DcYeborhQd2p3+CZLOI6wImkx69Hk+T+rK9h60DiouWnNNQL5UG4xC32i9hUnvG9h/
         4vLAJwdMOREqCBZy4wxmp29ie15jvz0LXK3Db8TOcpc/qfPu6Dg+g77uI9q8ckGdwvWv
         5LJXZPKn40TOYbxMBRPBI27DLYyWyeYhN8x4bZNuSa2DyZ4I/vZM5AMyR+JXTdX1E3FI
         2grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437768; x=1791042568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pt1JZ0Xx4dSQpjlcwcv4OrOAetyhY0kdTpc42Knguac=;
        b=Y0xbmqqOH9WRJ4qssf26JNIvbT36xPJ0+2CPTXDfOCWt2dmVeq5S/XUeK0edqx9DBv
         FkmlnQpaqN+Fqo6PSuba7N7sfJSO0+NCOm4ZfufhCA4W1MLf7YV3u6m61mDBnivyXoxw
         uqrDOqQu8A4z3IOVsu71hgfZeMbOoGpOPTvQF1en57i/h33AwArHr0AGEC28Mw8oEKhq
         e5jbj1YP5p0G2wkx94b0buEqNQx6t9+WWidFgN+noaeLHa0+EQ9qTVEF/qP8J8xlwWeb
         Za+qySaQFisxoA8XnqOfJSbaJbLTsjkIcvHco6UawpPXZk1/2sgHBK9CEOLRjTeGNmsK
         0mKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKfOK4hoUCfoiXRDunpl4Y7Sh9ugVwkZa3KWpYzOJKIk78YYIZpinRNLivX2Om2DdbYFA=@vger.kernel.org
X-Gm-Message-State: AFuF++mCDWz8YVOyPy7KWEicIZjG4CQ5VgxGqssIAMd31UeQwxCJEz6M
	5be2peyqEpVICHFo37gdjquZ+7JXcbfyasMG7qoFMB/yQsNkz0A2rgk/
X-Gm-Gg: AYBFou0EDLHTuKofMQTgiImwjXQDBQ2vi3Man0HuKne+WJYSVYR7YvHvxkCCPfEzGnE
	CBIHDyZKWmZEyDiwtkNua7FeRwvuZTt+WiyzbJo479K44zFTWVHJbDpXubiz/zH9tBDW7yKzOvg
	9lA/xb6mp1kP+CCAQnTt5DyuTpUt5HIol5HK1A+eS7toGdhokoe3pxT0i1TnkSOIFk4JWFLPASF
	P8jTXI60BzhTYH+BtPtQvxKhkYTGCq56Dnlt8YkAMwskUqX1M+Jha8N00PsIa2GSn1P1/R1bBAt
	iYBCzQkxyruhVDG0FjzbAInea8O0bXgc0UNCv07NlpvlJe/M9tLxuBug47NuhK1bovXtvv0Tcoz
	+9Og6GPL7GLc1qaRPrQ6oIgexHmTmJ4ziwYvdWKEK39noIQT7EhOgJRH/hM7BazGNSjDqvdDt48
	KuVS719SdNRPKvnE6g7T03dcw2J849bfaQ0Z9JfUUndZUGR/XYZdy6twN5T7I7UvvP40ii6rwVx
	DBeUcFTfyEJXSUu69WIk5jQgNtLVwHcpKKYzMWJvtIUizspRC5nDDf94Yk1pu3NvxHLmnhiGpNT
	UfCOsP49QK4FBkk4ShvwxVZQg1ifMJ3kkg7nz5AYXQzedSFP4OaCfxQ+MBEZnYJ2PoLOZJvhUxZ
	uVltwjOxe3yvsOsTA9VVm
X-Received: by 2002:a05:6830:6734:b0:7dc:4a43:fb5c with SMTP id 46e09a7af769-81781294540mr9561085a34.11.1790437767719;
        Sat, 26 Sep 2026 08:49:27 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e98b16d4sm5442366a34.26.2026.09.26.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:49:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 26 Sep 2026 09:48:59 -0600
Subject: [PATCH net v4 04/15] xsk: freeze deferred pool teardown during
 system sleep
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-submit-stmmac-reset-fixes-v1-v4-4-ec1c0250b3c9@gmail.com>
References: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
In-Reply-To: <20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
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
 "Song, Yoong Siang" <yoong.siang.song@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>, 
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.15.2

Pool destruction calls the driver under RTNL from system_wq. That queue
is not frozen during system sleep, so ndo_bpf() can run after the device
suspend callback has gated its clocks or after the noirq phase.

Use the freezable workqueue for deferred pool release. Work already
running completes before device suspend, and newly queued destruction
waits until device resume. The pool, UMEM and netdev references remain
owned by the work until then. This does not replace driver error
handling after a failed resume.

Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/xdp/xsk_buff_pool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9d2d94f1fb75..c58f56f24a9c 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -337,7 +337,10 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
 
 	if (refcount_dec_and_test(&pool->users)) {
 		INIT_WORK(&pool->work, xp_release_deferred);
-		schedule_work(&pool->work);
+		/* Teardown calls ndo_bpf(), which may need powered hardware.
+		 * RTNL alone does not exclude the device's system PM callbacks.
+		 */
+		queue_work(system_freezable_wq, &pool->work);
 		return true;
 	}
 

-- 
2.53.0

