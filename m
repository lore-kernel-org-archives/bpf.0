Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636843D5C2A
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546404; cv=none; b=LUybElIYIWnE9M+khDJec2JOl6EyCMGn4ic5dJs+m8ikk2MaQiiurLwfcMjixLz+pa0TrZSMSkcLHECjJDU8jxIAvobtY9MmEaFyDpz/vasvnpjYQPxDZLhpPeM7ESvnMh0e/mt7Pwy1rtfW0UoQSQpQ10YW8enylq1fqOlU9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546404; c=relaxed/simple;
	bh=2ChPtfS7fuQ6xmL5pBM0ED+Tz6MNWUwwNmCfWCfm6zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKx2OuZvz1M7S67gDpj6jyoouVYOR2ghCdJXwn7wDRl5q3I1UHZ6+J4j4c0HPJdNO1dz6a1Neq5AAGJrnWr3IqpCXdi3OBdBamMvsuTUi30mANnMuyqwaDAmgn0r+ozmrGsSWviKTLmE8k1+lqrV44JMpsCbVXc1ItTI3/O9YVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEi6GvdR; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEi6GvdR"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b485c8368so514978a34.3
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546396; x=1791151196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pt1JZ0Xx4dSQpjlcwcv4OrOAetyhY0kdTpc42Knguac=;
        b=CEi6GvdRr9Qc9e5aohxNgsgG1WWEfL9SmvQl2UZhtPWzlz9PZ0Ph10zKMiShuWufKd
         +y5LKJ5MwfK3HsHgB9to5D+nLxvfX7fsC+dW1ePeAv9eqxxBpIGPMXqIE12Hx9W6zv49
         T9OmTgGIb0B2BuuBI/W/xeiSU7GmlYljzX4Scct/iMvlEyjRm8ywQ+zjzG4Ei6IsayfJ
         PvGcqpzIBh1TVyZGJHMQihOYCQeyCDXNNTfsTLVv0TVk4LhdoKf/ll1kvwBA+kbYszdi
         /lBT3zMlNocApC9m3dK7LIHeJ6U5MeCE8y12BqSYFZPWHIKH0tHp7+ACFRYdwvhTkFRB
         lYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546396; x=1791151196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pt1JZ0Xx4dSQpjlcwcv4OrOAetyhY0kdTpc42Knguac=;
        b=rnIq8eHtc8qvyYTHcRQ7pE/DbiPMzm4hqHi5mBoX1g987U/YUptijba9c0529KubyV
         SR3M7TnPjpl2CHOnbJSvn0f/OmeECSoyhYoqVN8ZD62S++n6JnKXVDjjJuYFc/Da664L
         JlV7ZNCqtYL2m2GcZ/jVqOHBvKIB8foeb+X9LPjxa3KBB16uXftXWiX7/WhMOgC0CD7K
         ROfW9nVFztlVkZAvrEQRg0qLnO4IxR+6ONAWhMhGWv85YtolPIi87OCfg/65n+DA76gF
         udspztgb6q01KbGy+IXYI94sdE63XH726DoiaFGN3LXTosoToe68vp6wk3Pt+d9kRtnm
         r3nw==
X-Forwarded-Encrypted: i=1; AKwUvBzgDwo730Yq4HU5cY34zAJBVV5/5BYn8w595Ju1QNExf0oYB2Gej1o+AZbkgmriFjdakew=@vger.kernel.org
X-Gm-Message-State: AFuF++mVSvg/cqjwq0m5/17Jt/TDU83Rw21UK6IAmkpJ6tXH2GO8+vDs
	XSmxS6urnrSxFsFVwA3Ca/gh2GKvRGeXC5iQzg13je8LqCVeRosMfT2o
X-Gm-Gg: AYBFou0l9qSoxcGfLnIkA3YiuyNqLNd89Zp7ws8GErkKnF23vIzNCIDrG40hij9nbhL
	/++0Bkc6QYP2RkRrKBxx54LF3s59obUIEe/HJxTJC0xlHysdPUoIKwwcvwJ2rBBzGQL7mS2fXoU
	gTou+iAhis3Kxro1N2avnPkNRuguxg9tA1ctHJSVfEzcKcbBhMHKsmmlRmYGfJet32xeEyqS2iA
	joyKYQWfC8Wj5EV13ZoM1m0KmQ4MfWYHnS2S9+dTChjmTfIyVZiQ5srAMjTVoSCAFX1OgRFhgTp
	RV08DWddVQ5S56CSNQ+awgqG4rmVnOlPASPncV8K4l/ZXZV8ENpk+2UbCzUGfcVW6FTvQv1vGRI
	rUExO/woDD9sZPKPTcYFNpUbLVqlHO8RNrqgrmgxAnhrABBRJOcpT+S8NEHHNlW4X8x6c00DMRl
	L903znc/AAED8gZ+hBj6WL/V3C0UxgcBDqJZUmSKES539p+f5Lv0ygrJG1lMwUMAwdsnDOf3LrG
	tehBY5P9b9PWLV2XXChU7vW7W5vGwgwqCQRjBGQUSBRi2pXXOsSWFAkppM9qQGIfmXBPUpt0VWm
	o6G1+xc9arShTBVuPCmJ3tDQOBYYvF6jFDJTzvIS7UaTOjBJhLii8GSp2YdgNQlqW8Rjk6A6WEb
	RX13oNJrAzdFpBezPwXqV7QvblaRGlzU=
X-Received: by 2002:a05:6830:6d50:b0:7fa:ac4f:794 with SMTP id 46e09a7af769-81781d93ab0mr13732683a34.16.1790546395901;
        Sun, 27 Sep 2026 14:59:55 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81b3de6f7e1sm4874147a34.22.2026.09.27.14.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:59:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 15:59:39 -0600
Subject: [PATCH net-next v5 04/19] xsk: freeze deferred pool teardown
 during system sleep
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-stmmac-reset-fixes-v1-v5-4-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>, 
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
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

