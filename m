Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F533E7174
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555363; cv=none; b=Hv92KQvDZ+1dhF+f+aIejJ86vqyesbz6xD/n/zsN9MUU7LNeI6aGnt23cylCXjB+YFCt9Uc+y9SrBKwX3FSKxXHk9xs2Kgq175lKyfHAFNPlSvQRqV5tLTADNj4QtlnT1fX6sNBkpCy1UEhaU2xjM1bDJrVbEiKiNonSrTFZle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555363; c=relaxed/simple;
	bh=T3Znx85+wRAnG9rsNvo9Z30hf5HBN/a8hUHQ/NtsWcA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=Td85+EDWV88rC3lv3SJZzZqbm+70dgl/YLv5DPIXcs+WrTV+tewcuN/jDmDX7xR/4Jv+tmoFlAT8k4ptiIxJY2NhnzWzVePzd/MNw/XQyAjgK+rpLWSFwJ78QKgWMb70TcvP6IjXdSnV+wpM1TeST314hL9DBup6doC5Jdp4ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNFGA+KK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNFGA+KK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2582954a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787555361; x=1788160161; darn=vger.kernel.org;
        h=to:from:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JQN40EZErL2DHTXaUSRxFDwWdzQHo0e1wBH6G70Kxos=;
        b=MNFGA+KKQ/GzWEmOBj6yvmVGQcC3mZcQiL6wx2lHaxRCiAEQ5Y2PFocep+uSvQKfMV
         Wjcd1dIuI+WdlrrtPeRrsFCIOf4HhGqfD1Aygd2C7aMbIKP5GitmTO2RxlW5NnjBpk3q
         Fx6yTekRZp79SokuY5HgsIHlChXKHHynuYYdtS/po47Yt4EtbWWGXAfyfvqzNGECSg+j
         DIHgaGlt8T5eS4vOYIHm/icW1/l4LCyi6KqXxTpxNHJdgDjGOzaU8Yqv/nj2QFTD+u9F
         Y9ILxxzbrlGqZmUHgVGMRPqTUe72k5Wh4XIPYev8BvO9ISxynvsZhKI2oyjPojrQWu81
         mHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787555361; x=1788160161;
        h=to:from:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JQN40EZErL2DHTXaUSRxFDwWdzQHo0e1wBH6G70Kxos=;
        b=KrPh/cI0DiVDnWZgA3Os32sf39haxD7r0xiEuwNDwsWWzzB7zZpuY8O/TpdU+qQPbD
         7rppDFIT5P+4am5qErGnod3ZRzdwYhzwkFXVcQlOCW1xtsBuPVpHyENm4X5TKOlME/Sq
         xA2IkhTCzAG1pARTsyqWSB2jGFtX6g5JclxXAoP8UCiGmDgfeM6kwRZZGFGpDvcVrvrg
         o20s4DFECKukuDA1p8On84513/dUSXE4zqy9qYd5Qbarb4N9gS9RregYMmLQ5PJELUqM
         b0/apCOmAIZO2VxZVT/hcW1MvokYuYqLZXMmHvnVyKXfbhSkLtiiL2VbN4ZwwrWUz75U
         Lm6w==
X-Forwarded-Encrypted: i=1; AHgh+RpvJ0YDVa5NglXQm6CwewKDN7nb9Q8DNPvNk1x/707JTBqaegsdlew+fEMtqHt2GUCxBhw=@vger.kernel.org
X-Gm-Message-State: AFuF++lNf8ZlUcmZciqJWYZ7UfFYTvql3DbJNcnKoMWUMP+5jxV2086R
	6UzuOF43dv5yj6537TpzZFWLnRj7HITtZaP5vcY+lKx9/X0M5J2bhtDC
X-Gm-Gg: AR+sD10fkDl+Y4iCfBTUenRKFq6rrjuFtG+APAQDIcBwI5yuzb1k8EIzLxEAqz8oBbO
	l6i/KcZ6ZPqZjCVsO1r0rX1xWPPtzR/woMXOBS/mYTYHCV8caWsVa6dP0tDhYX1ulnc1QIykGiv
	rpqJJ9Zp06FQAkLjTKv1eV0OmZ07dQfQTuhXS82+GE8PQs+vhQW3o+DD6IYZogj224v6hPIkCFf
	WYwYgEB2EM3Ga0LS/k8LGQqiisfkvvkFaVrinPvcXp2T9LVZOzgUYW03+OTv/K0DDyEfeyaaQQk
	wZf9WWuVwoa5O3b0pIvqJeQLcX31Ca9AY4VlSJ4gWqO/PMrHHmypXb9ir07v9CKPCnUMMhjRF8U
	mlMxJZ4WDUJzaR3DFDNdBjolaNnBVxdKvj8xw1O8cb3Qp414O8+L8aeVkT4awW42DE6JbYoHhqH
	Iccga0A34g81cc9t3UcRqArnboPOwdfT4MjEeKwJ7lpvzaHI44uOfy7c5IqZFwe3S20QUZqm8EW
	M01OOKt4rpb2dLEtbasZQY=
X-Received: by 2002:a17:90b:388d:b0:387:d9cc:7dc3 with SMTP id 98e67ed59e1d1-395a074a348mr40512016a91.21.1787555361491;
        Mon, 24 Aug 2026 00:09:21 -0700 (PDT)
Received: from localhost ([2401:4900:8850:f081:3f06:139b:b140:eb29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3280782f09fsm15279067eec.20.2026.08.24.00.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 00:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 12:39:06 +0530
Message-Id: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Cc: <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
From: "Muhammad Falak R Wani" <falakreyaz@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, "Haiyang Zhang"
 <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui"
 <decui@microsoft.com>, "Long Li" <longli@microsoft.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>

mana_bpf() declares an uninitialized 'ret' and falls through to a
trailing 'return ret;' after a switch statement whose every case
(XDP_SETUP_PROG and default) already returns unconditionally. This
statement is therefore unreachable dead code left over from an
earlier refactor, and it would return an uninitialized value if it
were ever reached.

Drop the unused variable and the unreachable return.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/mana_bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/e=
thernet/microsoft/mana/mana_bpf.c
index 53308e139cbe9..70bb8c9dc3413 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, struct=
 bpf_prog *prog,
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
 {
 	struct netlink_ext_ack *extack =3D bpf->extack;
-	int ret;
=20
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
@@ -262,6 +261,4 @@ int mana_bpf(struct net_device *ndev, struct netdev_bpf=
 *bpf)
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return ret;
 }
--=20
2.55.0

