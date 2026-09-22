Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2A515965
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119678; cv=none; b=tAXZNgF86TRiWwvPLD7ieCH8WLC7xqJEc9NBPjZ2MumlwIrFck/1L7yXuhGYFxnElHg54zLAEiPrKlc2tTON174EmUr9j7Z3M9udMln/yVP72vJpn87WguXFm6U023PPEailqIAXo+x6FljflF6iF4W7Q3LlXZcc1TrnUsGg9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119678; c=relaxed/simple;
	bh=WXvjNDGT5fIJ4+hQrMbJuJmFLYmSKGyYuzOMTm701Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+POXvBXvSK+UUDvCML4uBbu0vwkdRQDSPaE1WQhWQqTp8IfI/x3apV6Em57PcPXzjMnr9/OOe3nsxxDeNr4G+Qu4kmyt9XrhAyQ/NX41vg/VCazCVcllK+nabsiHwbzn8UndmlUKvM0XvdQ/Nfc9SyivttttRumDcs2/YCKBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZRTZXQk; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZRTZXQk"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-801a8bf8112so238610a34.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790119667; x=1790724467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8++WyG12SZPVqlwFfWjIZRV+ikQ2NXn6irkLz76Dxw=;
        b=YZRTZXQk93/XTcsVd3JwZlVnKtfidiAOoq/j1gfSZfrdvg1Y5X7gNJaO+3aAcOJaoQ
         OTU2CRWHefdahBXLeY1f4/42/koVJx9N4XvUtnB3gqoGL7icCRkxUU8a72UMd5R69iaK
         tQpQrwxZI8uCY5hSJ/mqDhOkpm1WJf8+Z7bjU0qGNfVwjrfag5CIgOUQGdaXCKFo7kg9
         3os5t/5rOAWcnyhGJfxfDxlzDbnjA0YEV1Oy9g1DFbeO+ZQKTgP/7FBqm1YRBy3bTOqG
         s3VcHx+yIJHHrGEX1+0jl3fGp9LteoPu9J8Br3ukLvOX7W2xIHTqUc/RS5ba2CxzZpwR
         acVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790119667; x=1790724467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8++WyG12SZPVqlwFfWjIZRV+ikQ2NXn6irkLz76Dxw=;
        b=eYtM125Fz6igLWvc9IuM+fGdE//t4w5EAHM8H4e9E9dZww9BEflRSSmnaZcE5NArWm
         GNSXAk6PuVX9EFzNomPq3pj2+qAEaEhuOiYwqnffqEczmRYzUymf+pshf6SrQdQnxVQe
         pyDlAN0cfpntmTQ93/ZqlrnN80Q3T6g5xotieK95fJR+bgiE1PUEUIemDL2dylaE0sbK
         Adqdq+OwpC4xZ5zNNG4+YuDX2qCd0aetnRIF8kOVKgBAXZNQ/6ch61a42IUYEL2o9Gpb
         5s1WwiJ+m1RqhrLMQvTLoFrHY2oa0AdPilJJvvYlRbHX2J+gKqDqKSNsMO4qyg9v2l+Y
         Eiig==
X-Forwarded-Encrypted: i=1; AKwUvBzfVdDd06MnrK6+iBlOqv/I6tO4XOuOdKC9YqHHKXQxFQTwBArZrsG09Z1rA/4VEoIN10Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mRlF+MM3lxfL6YB46XtMM6sgcCSflpDJHfMLJrCtNTcA31Q1cA
	mWNgDotbA7dSU6EBjHCJHWKHPUWOiJY80aNpInNFn3w1SaaESAI0CqXl
X-Gm-Gg: AYBFou0BpPon008ppxEDHae8DAyVyfq9OPYANqSK03lIlz1m5ByIsO/P/E+wz3zegxC
	sU2AekcLUiYKj8hadO2rPhEHVHe7Fm42/hh25n3Mf2GmnpY4/fkgLkYNZE8Ij1OtyaKdMkCbJaO
	qBw3XESHZkxuRb6FW/z2m7wivs39Mk4kaID/JeH95/gLql3COIKVY85cgZzYxiXJBulKk1lB/86
	VscbjrEzC9L3XOQdYpLQs6FgI6SIUTBfNgrrsDc68qOckLoirSSRiAnq6CJVcxJAdVSNw1fsRXH
	fiQmLRkroyASOww1ULOAfujsw9Y3cn8l7Oz8FZZ3GJLjIDi9suLoMzqa2YtVbmpw5/apmUJsf9H
	wRAzKU9XEsLIlXbWNRIMOV7QsxAggK2bIin75+9+9x2CH5QdI14CCiTO2B5sq1Q0Ih+pSuIaLYV
	RJHpDgSuFXh7rYNQJB8Ww/McPV1yxtPA+nxsObEuXr5UX0iH6RD0E7WJbKvtDttDsotiuV5zOvN
	Vscmr7gzG75Qk2taBG+TQ7iNpXi7EN86xlEfeaAamnn8SMnpt0lh2BhOrJedomYTtWFT1w/J1aX
	QbGwZk5wEsEbD4/Q9RD7dxCrkoYjtzY1syTw6XMp+cLVadgD3dixeUIMk//uB8SOI5tVZ/01DHh
	mPfzoe1sUO6OUNSgjR5wGtg==
X-Received: by 2002:a05:6830:4ac5:b0:802:68c:1b51 with SMTP id 46e09a7af769-815ef299a60mr1161319a34.11.1790119667060;
        Tue, 22 Sep 2026 16:27:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603fc87cdsm1243053a34.13.2026.09.22.16.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 16:27:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 22 Sep 2026 17:27:40 -0600
Subject: [PATCH net v2 1/2] net: phylink: allow stopping a suspended
 instance
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-submit-stmmac-reset-fixes-v1-v2-1-d92e609be996@gmail.com>
References: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
In-Reply-To: <20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996@gmail.com>
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
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

If a network driver's system resume fails before phylink_resume(), the
network device can remain administratively up with phylink suspended.
Closing the interface then needs to terminate that suspended instance.
Calling phylink_resume() merely to make phylink_stop() work is not a safe
substitute: resume reconfigures the MAC and restarts link resolution,
although the driver has not successfully restored the MAC.

This is a missing suspend-to-stop transition, independent of the reason
hardware restoration failed. No MAC recovery policy belongs in phylink;
the driver still decides whether to retry resume or wait for an ordinary
administrative down/up cycle.

Without MAC Wake-on-LAN, phylink_suspend() has already called
phylink_stop(). Leave that stopped instance alone instead of repeating
PHY, SFP and PCS shutdown. With MAC Wake-on-LAN, suspend deliberately
defers mac_link_down() and sets PHYLINK_DISABLE_MAC_WOL. Finish that
deferred link-down, drain resolution work and clear the WoL disable bit
while retaining PHYLINK_DISABLE_STOPPED. Otherwise a subsequent start
cannot resolve the link.

Document that a suspended instance can be stopped directly. This neither
resumes the PHY nor reconfigures or brings up the MAC.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a1458da8111b..df520d77fded 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2495,11 +2495,18 @@ EXPORT_SYMBOL_GPL(phylink_start);
  *
  * This will synchronously bring down the link if the link is not already
  * down (in other words, it will trigger a mac_link_down() method call.)
+ * A suspended instance may be stopped without first calling phylink_resume().
+ * In particular, closing a device after a failed resume must not restart the
+ * link or reconfigure the MAC just to finish shutting it down.
  */
 void phylink_stop(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	/* phylink_suspend() already stops the link without MAC WoL. */
+	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
+		return;
+
 	if (pl->sfp_bus)
 		sfp_upstream_stop(pl->sfp_bus);
 	if (pl->phydev)
@@ -2512,6 +2519,16 @@ void phylink_stop(struct phylink *pl)
 
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
 
+	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
+		/* Finish the link-down deferred by MAC WoL, without restarting. */
+		flush_work(&pl->resolve);
+		mutex_lock(&pl->state_mutex);
+		if (pl->suspend_link_up)
+			phylink_link_down(pl);
+		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
+		mutex_unlock(&pl->state_mutex);
+	}
+
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);

-- 
2.53.0

