Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FF3C65F8
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290514; cv=none; b=kgKAu9hW4ehp2KBYoua7QSqUVmMpGNBHC/cmfRP4HkMNFeqgkk1h2hUwfd3QiinNuTyixNkzk7Q9R/Q0DfVVYierXmWm/WVDFpgQD3OAHxc5Rzbn0KZYHWYg0L1+LytQQFa/6VetrLTwQZsLbcnIkPcXVe/80Eetc8SfMv57gZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290514; c=relaxed/simple;
	bh=SOKRwxDlDZlKiYi/jrSARj0ARB0EEcDrmHsL0id3dGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RITJGN1nntvgnwJFTDMHFc2oBIjw6bqJnj8btl/mlBe9KBU9XtEIUsDdX58mFWdFT9b5I66cndkpri3UGGmJ9r1gS0jjMutXVevaWb3FxfG15l780KNYV30lYkF6s5JcC+Osct75ME1MeFdRb1ON59Ge1/msBvxRM2JnhTbUBpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvnVh5E6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvnVh5E6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so27332885e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290507; x=1774895307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
        b=FvnVh5E6wh+gHStwCqmHLOixYxNEoQJEakNdZrwpmQ0hyAvANmWh4eDzunNcGllo0W
         +v7dvr78OyEBlnkT/daYwE6Yq3RyD0+5DOnFJEpAEVX7JpxrHON2Wz+3be4Ll7TFeAXh
         IEj+w26oa2vnT3cexsNCS1NY1x3xlV0Naybz7opaJ6yyYnR3BG6Xt89VePK8wy6PXLwc
         LXT4szYihM9stDjzpZAkcYVR0/SAWHo7Q7xWAySF6kuq+QCIubs7beW9GulR9y01ZhwX
         9NuP/yE923/JOcn+qV5K/wBtL31ekUono1H+zpGqj9pgxiTfDRStULG8Wk0qBgAxSykx
         Qj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290507; x=1774895307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVKv4h6csSNr26F3fg2SyyHjtvzkcdDJQ8W+IAxz4h4=;
        b=NEd+QvJIKtraYR5VpZ3+cozDsOXLItlRRrjJq3J4sL9X/Z6O7wB8om4u5wQp/XVSJ2
         wyqOgg1kmQcuZrD+o7744MyxRTOFkQkDJFbcgjYFwRPM9yCI1fthD5y39HvWiBXPJ+Z5
         V7v9HmBqc1diotMXXuBAeNcZ/HHPcqKimeuqJlDoj4HWfcvumyeA9odBwI83EatY7K+0
         sCg0Hxz1FradpdI4zezQ4p6XilZhh0EXJ6OfRpguoH/S/W2HSAv9oRGy4a2+8HehXgnG
         IH8caVRQp+lYAE4gyR0/66YuKkimbAdOE+k9liO8Y/xR6zuuRr87zfi54hSeJTd2rHKl
         LY4w==
X-Forwarded-Encrypted: i=1; AJvYcCVXQyIvf7sdD5XAefufAQDk/p2pEHgp4ZC4P4JTb06uwMN8bC/jKk7G9Fycq4Mt5t3baqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRB4qzYV0gcsvS96cea+kvu3qYs/Ys1CiT4/MGmLhXD6Si0SrU
	k2szrqdWCmmX6wWEwLeYa7iJg+M1mlqORh1q6LLI996C85dHbvLzEryu
X-Gm-Gg: ATEYQzznA+7RRcCt0+6bVuShXBjqiildj3SYD3Bcc7oNJQteoAHdpcrBRnx+zEc3/ee
	ydNq9tS3zYd35se90Wf4MaaOPxoP8/7SwWVkEzuaCnrnBepIpMKzJDhr5vQfiA3QbXqKOgwiAwI
	Fx8gBvbz50p5aq96GHp0kYKpLm0XUh0OruFw7dbaJndZjgtOLgYGoI5tDMhGTEMXZ6NclD87Tfl
	9GA6eI9epQzph9Q4Nbfnro1mcRq5g+4rY+zABZsRFSy4unlDz6OY08sOiMtjgCLe31u/joYdVg+
	IozRj21KRzbP1zfg4KzsIJCBNIVL59bJDXbR6cB+6UAXpl3XulMRkkF9M9evyxTCpyA+MqDBg7e
	fvk13LphcD86bhEm2Qo+fFZuVa88wyXxcz6/0DgARpo4yYmrjwr19qDvBCS7ODMEKVbjsrAwygg
	gNuYGzMLLeh2zIuFf5DA86NmboHrn47JBWMIWRhXUcDwdwyCrKn9uQTNvfsnqrZ8gzweucrGcCV
	jM=
X-Received: by 2002:a05:600c:3b07:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-486fedab424mr187730755e9.4.1774290506520;
        Mon, 23 Mar 2026 11:28:26 -0700 (PDT)
Received: from turbo.teknoraver.net (net-37-119-137-97.cust.vodafonedsl.it. [37.119.137.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm28448751f8f.31.2026.03.23.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:25 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] e1000e: add XDP support
Date: Mon, 23 Mar 2026 19:28:21 +0100
Message-ID: <20260323182823.5813-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add XDP support to e1000e driver. First patch adds basic XDP support,
while the second one adds support for AF_XDP.
Tested on an Intel 82574L Gigabit card with xdp-bench and xdp-trafficgen

v2: added a missing 'select PAGE_POOL' which triggered a build failure
with some configurations.
v3: removed a leftover file.
v4: bugfixes

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/Kconfig         |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 610 ++++++++++++++++++++-
 3 files changed, 617 insertions(+), 12 deletions(-)

-- 
2.53.0

