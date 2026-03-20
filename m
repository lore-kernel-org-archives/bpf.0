Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8B3A901D
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774013044; cv=none; b=n1uo1Z7qcXmvWsS0W0Netqjg2WLhR+6UrCTGxAoPWDMpkyg8p5GMj/SGC6XXCO0liYiXYbaOFtPosqAtQY0XNRXGcIl87u6EDaQNxy+cC3oGx4+dlPG1PExK4w8mAnGR+53CTkdjeu0ye2AXTgGArdBAIjEU62bbkI297t5m+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774013044; c=relaxed/simple;
	bh=cxwIc6Pd/IRwJe/y0ztE5AzEdh/NkI72t2V4Q2ucEm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APu+DGBgPBc4l6n4O4Z2IKk5FkE0sDd/av2SKDtCcmm7kEKu2A/fXiJGj3oNBnenLmMtVPFNeG+jtg4noOAtS9OGA/qCa9sLXSZe5osLTl8topRpdIHcpLDebFfTL3cQhuUG3bVQoAdJ5iXbrGTCyCVLKNw2Eh3C0a/Ve3XhXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwQ/cu6G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwQ/cu6G"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso17917525e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774013040; x=1774617840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFhDSJQ4+P/KK+sAv0QkEo3dxSGCedmuq7aAynQlV4w=;
        b=lwQ/cu6GbZd5i75/2UaWxDfMw2tv2LIRVI/OFWBtRbjHkDt+BdGZDPeEEII0GDeiwJ
         BvEchGBFJkF7RXLo7F3FyWqdzthIRd1Frykmc70iyGX7EP++jMsnmemLYK9uAEx7fSRg
         6txsFrfCZoDTwWaQ15OIMXeUkOTQcXEJpVlIhl4gNw5EKWL+9hzDwtL1hM7W6oD+LcuN
         +gT+g3PKRLadKLS2sR1u0q51cEvw6+hrONnI20TC7x2ObI77ac4IPW5a/GDyfDyJnQI6
         NcEMSMKWf9XXlb5qlzYM6Ey71VpkXZD0a5n54NjjIvSgZ3NPaCehrxiDP2gqPDWBBO3A
         VkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774013040; x=1774617840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFhDSJQ4+P/KK+sAv0QkEo3dxSGCedmuq7aAynQlV4w=;
        b=QCIGrRxaspvyy9qxbnHacy+fawZHnCA4Bo5cABnkGmsZT45cZ5OGiInsQfpEdm5A9E
         ZezyCnxVV6qkkj/+Ya8nle1TUA0SUnLru4rXjBIaMMMeLvk5R98gR6f3tX5KKXIZSmK4
         hyPMyjVnPR5o3OtefSh8ngrsDzQIMOstr7Bzh11uta4Ymr6BMW41/YZnZnQK2b+dMu+e
         qsm/w7PHlGrO0+SpUS9n0QUhUvQTsHTblOWq6abnXjSWtHUcudMPtUoHIYumw6H3TBrk
         vqCqZ/4ySF/6Tce50h9AiWzdFMvJzDXPaRgkj/gSjAorQqQ8ZnZd28XwJMtr68rhzZcp
         jHWA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3AAM5zySHvJ0JoQWm3d+Bh9xeUNGFwfaYvPTDcZNGdZwXRAT/bAvs/8e0TDUXOn0tHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpWtKoNswmcUwPc12sP8w7fz9BvyEoJfpCtQJTuR0oOc6yYT2
	iak23P8qRTlPe4oEtLDcqcNv8fQyjwAb1dKPY3tBkczK+kKRhgXaAkFg
X-Gm-Gg: ATEYQzyDUX0YRYYG4CE4PhR0ZleQnuQyOFGLojkpZfShiw5iQADr/dBvrgPk7Ds1Kdf
	O1CO0KrQv5Lp0s9gvJ4sR3ROoixo0X47vsLXlyPdHCEMw7bSqJ+Fyr0Xyt7DOsVPmomTZ7MY9sQ
	GrndYtPpqypVIzs76jFVGFXTzZzBccMYpnVn5GnVvDpqnrwNz1VIiNwziYn533grCO864ayAsgk
	1j3Ho5aZ9AC/6CmgTTAbkSsaTztfRrv2WHzN3pHQrYPKaS8ViwizP6YCxwoX8fmXwnaT9eeb752
	46EIgn3w9CranwiYlSp0ewx9t4V6AYvB8mK7jvGqgveaGCvJ4PwxQA3gLUEX34rHFgXD49hL2pO
	oGx1KY9Tf1oSgzKO16m2kUDZ7Zqin+HYKEaKToAqrVyb/7pu0m3oXcgW5qDwexAlSJ7kSuAR/s1
	LQcus6qJRjg3c7vRAqRXUKY+JVDZe+TsWTF/Wf9vqHQFMeKUBd12KLJnPoVK9cc5vO+6lZyGyO
X-Received: by 2002:a05:600c:8119:b0:485:345b:ccb1 with SMTP id 5b1f17b1804b1-486ff031f5dmr39443345e9.27.1774013039582;
        Fri, 20 Mar 2026 06:23:59 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487004e7bc4sm16427095e9.2.2026.03.20.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:23:58 -0700 (PDT)
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
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/2] e1000e: add XDP support
Date: Fri, 20 Mar 2026 14:23:54 +0100
Message-ID: <20260320132356.63194-1-teknoraver@meta.com>
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

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/Kconfig         |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 600 ++++++++++++++++++++-
 3 files changed, 607 insertions(+), 12 deletions(-)

-- 
2.53.0

