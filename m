Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA473A7F66
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377952; cv=none; b=P1HuYBqA9seOZ/XQoKTS8sx5rv/pvqV+8Y1+t6V0KXi4I6APB+UIGNxPN9mnN0I7WR/sk0HN4vAlKiBh5Boo/311xZMDFJpOgjU10ECbnIMxyCfJzNUV4b/WiGwF944Fun6BMRXhxzHkf87y2Tg5JwocstgBuKZ1X7HTcvgEnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377952; c=relaxed/simple;
	bh=IN7KgNnqs8D1ESaMkPXU7u0sHCNgKxudHA0yUaGKH3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFXtmyQ6VYKzR9YQ3B9x+gIN012gJCfsbc03fU46kqVuA7kSx3PyGlJRUNZzzD1nbkZRpLjFwON8KQYRM8+TO8yldco4jvYEGifNph/wFPXWKG1QrjFcULl12BKSNvaV3oDVrFTfwiwu3eLpeqrH4xePAk9SS+v8+VL3JILbi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEdv7W3n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEdv7W3n"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso10814415e9.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377938; x=1788982738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qf3cTJ2gK9rwWSik6ILKIPabS+XWIpM77pAw1SCvPKM=;
        b=eEdv7W3nyILq4p2OHNywxGRG+5XtQG2woHts9iT9TzZp1+keMP5y3pdLlzRObQOxCd
         ggUr3NSe9r2lOEnkYHMERSjsKpifnPbzZpYrjPzfkuONGUnZWGG12HSt92li9HgtRt1g
         4zzKucecLqf6xhZOpV43+wW+bUM4DTt1+AUt5qZicA37b0Hi3ru7w1s2hUhVCCYMg/99
         RUHlv8zprAhaD1kkFTyCCmTCM/x7q6nap2N32Vv6hiK0Odjet5rl/NH3ehcnv8Aq8nIU
         oBBTNr3ZRlcb99+VGpj4ilUCD1AiSf+9GmZRHq1LfzO2TmuJnA4vTme2zKRqg4S8A5Sj
         knww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377938; x=1788982738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qf3cTJ2gK9rwWSik6ILKIPabS+XWIpM77pAw1SCvPKM=;
        b=KN8AULoTsNdi1XBKPLrhWZJ0uoRZG0guru7rgq1lCasEAnLFTbcridOB84O5qKA2v6
         vJeChKXlT1lQ+61FALp37wNHX6dIMQ0mapa7Fa51e59TizQHZOkJGXfUVQd27nNm4yyI
         +BQZnFuN2Q/QMmzDJSGz93WSu785FmXx+NYaLc+UkwY+Gy4BSPBSl9eIAatlWfxF/Cbl
         HiVTdycz8KawvrkLxRHwXoye0tDxfRzVtKgXDd217UF/pPRvKQv4T5yykaW82rZbvetg
         lQVwcSTjW8A/qf3KplFMNOnaFQ+/P9fLisok8+d+P7yXEhqVbuBhtBDhwQDibkJVMo65
         aNKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpU/4FLe+Y/p22kMq3FonkprJ4ZNY4vRA7JgO+cKtgesB1VCXgbX3553MsmaLvcXYpj4k=@vger.kernel.org
X-Gm-Message-State: AFuF++msriIJn7/RqqMCsBoqBsHy6fwJ1vv6/cUSk/wSCWngfS9J5u/F
	borhFvRa1uoGMBYI2gADg22So8WN6tgm695JOgAT3rAMI0d34liajMXc
X-Gm-Gg: AYBFou2pRtL73FrqoQbpiWFyCW7lPxh1RWArTlQ/u6duavhxC0iDxUEhncDzimtMrWd
	BjkYhmOi/ocA8b/hhn/BXCG2wBPSiZRbol2i1FWzUP+l7czDlMnFpezoth2h7sI6dDMkoa+sRjL
	hYhwOQShk0gTb66KKGmB3BAeUYaywgcCqoU+LRumfxXjNacbLNP+cck3g1/mmZr30bbP2yii9Uq
	V6GZYa+fW0EGhbASkki32D+HU2B91ubcl3xlQLbYuUu8MPXjgrvCmqUOEZjftFZUrJ85wCuVN/2
	j890BeT2ZADea3i5iVbpiWQpX/XPdTEem+4QM3j5ln6Htt8Qn0J2/cOwUvf1UM6DW+eFtKBkLIF
	XEfrG1gS7sHBuLAUA8W0REyIDqP7WsvMSlR46E230zSgCFt2I/v/Mc8Fk4OYllwmhqlo9KZrbvk
	4he5xcQRvlBkUjH7iZYifnUye0YARW9HA+Vj50/+KxZPCkHLEPKTH2CtWgQcdHs17mTF3GW1XFP
	Kmntds=
X-Received: by 2002:a05:600c:a402:b0:49c:ee22:364c with SMTP id 5b1f17b1804b1-49cee22422dmr34410355e9.9.1788377937983;
        Wed, 02 Sep 2026 12:38:57 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:2ccc:f994:68d7:fe7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce554d52esm49925915e9.3.2026.09.02.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:38:57 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Christian Melendez <chrismelnu@gmail.com>
Subject: [PATCH] Documentation: netvsc: Remove stale "not yet supported" XDP_REDIRECT note
Date: Wed,  2 Sep 2026 21:37:11 +0200
Message-Id: <20260902193711.113291-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831200357.45390-1-chrismelnu@gmail.com>
References: <20260831200357.45390-1-chrismelnu@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netvsc_run_xdp() in drivers/net/hyperv/netvsc_bpf.c has handled
XDP_REDIRECT since commit 1cb9d3b6185b ("hv_netvsc: Add support for
XDP_REDIRECT"), and netvsc_drv.c advertises NETDEV_XDP_ACT_REDIRECT
in xdp_features. Remove the stale note.

Link: https://patch.msgid.link/20260831200357.45390-1-chrismelnu@gmail.com
Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
---
 .../networking/device_drivers/ethernet/microsoft/netvsc.rst     | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
index fc5acd427a5d..616f808e885b 100644
--- a/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+++ b/Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
@@ -116,5 +116,3 @@ XDP support
   before running XDP::
 
 	ethtool -K eth0 lro off
-
-  XDP_REDIRECT action is not yet supported.
-- 
2.34.1

