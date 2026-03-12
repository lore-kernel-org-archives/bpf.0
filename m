Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A383FF88F
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340706; cv=none; b=sMy/ZIuxifv/g88+1HO+hiZdpzSp/TaApali1ca82Ue1lLjiTPINzeBX1dGNbb0S+KUafYLZ0+d/6Evw7ivlfQGZirJGfLfuQQb8cTHlb6xieOcguso+z4cOKG/Xp4kMyyPnnf6z1hegVH3+EAe9TPtHn7A95sUGXC9GWo26Px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340706; c=relaxed/simple;
	bh=gWKYnA9y4mRp/F/hXQk0HtNNu/EJeWyE9t/c9l8lo/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqyuaWRspQ2xkr+dptCwgiXgq7hJVXBkYAnQSSI4k714PZYBQkSULY7DzXl3YF2eDWHfMq1kL5/CW0Z+95sLVsLX5HYpuZV9z+jInoMvhaiJuKsAdALdnNLT2pcXDztyGcTyQe1tp4nPC9X0WRSc1FCKpaKlP64VdfigDpHlZzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iaq94g29; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iaq94g29"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so11407845e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773340703; x=1773945503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OnplUakzpDGl0akz+yg54GLhkStqs6kOTbb2DNMmxE=;
        b=Iaq94g298bAeB5MUt2jvG+jvR6C72rLWJXuvnR29jvum+HDt2IOa/7eRR63I4XLHjQ
         G1WEuEvCEAb//1yESfM+uEwU8kiSDOoXU1EXKYMA0mvKSo57bTgvJWEU/iQOWl6sIW3P
         S8Dx+WXAYsqb7gkyhlJ3XogQkvaWzVBtzDIStRJPBOVXuFPK9ScDDPWEQWLBWyp9IJ6z
         pFTbL8DGtTZ7xPoYSF+U3oX6rAp2dg87+wDVLnM5KQhUG6PU8pwsby6W8+MWoYTcrDGH
         6XiSHAQ99y9A2xnirnemKUotFMtP3t6ksJxunLNh0IhZnYQIythFwOPIyJ+XDEps+woN
         Nl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773340703; x=1773945503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OnplUakzpDGl0akz+yg54GLhkStqs6kOTbb2DNMmxE=;
        b=EFmUxC22xSDKhI8Fp96AMWMnzKCvHpEs+oLc72C8/wbTFj+u0AD2J1hJt27+XWHXyo
         F4jgOmAfdySlYbcJ5iCUbLBxsrsdtRSs0Cw0UQy049uTU9/qxtl5t70kB/kLO0nkfRPQ
         YgWUsQeMih5nXP5Tp2ReN2IdR3qsg5UwbEMZ/Zxbcf3drg77TbssG3OatiBaPqTNsJny
         M49vfhTdCYyZ7rqLmhKGvtXNmEX7riSidxixuAC6AjA9qcRAZvOhlOyQvTyPpVTJRjjP
         R77xGlRgFUUF2HAir9aMiU7wMm7SM3CGHS4j8xA7bGsUF2cgKxPfq0a4SuVswos5Y2oV
         ixGg==
X-Forwarded-Encrypted: i=1; AJvYcCXbf+tYgsDUNv7z/40eXui3+RF0eNmrqHHoywUgKyj7tQSw9RT1KaJDa71nzj6mzPR785A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeLnFO9XJx4JRRbkAWshldrKCceWEeU+5kBf2U3GfQwhU20zu
	eHscXY+t0iXY1kmwGehqg6826URJCr+bfo4/0bKO62+3w3pYIXEhHkl5
X-Gm-Gg: ATEYQzzCDMiUcIpHTL54HduhgsPgdUak/ldEEGtS3muo3Jaffz3VCcoYkgpjfDVoMnT
	ai2ADwQM9yn23lrdT2aZI4GeMfnhsBtszJff6L5JuctAEjerZCBoo72eYopDcfOBwmI1M3ybjPu
	6KXdNemBJ1x8wHoKV7I6LddlWW6/WXiQ3+GPHNxwEwRrIW8cfsUD6YPonnZ3fCMTjZX5GmETj6C
	8yUBmb0ek7sE7jPHdjYnv0pFWuDrGS5p2gG8jq3JVYBFRWXONzaaq+myUmuR9ItxQRtcXsptuV9
	Pn40Mh2sb2VPKyNJTw2o54+Feygh35nA+OrLZ60uaVlpsqG8oYeQJ6vl+216ewrcxi680YREDlJ
	Bo1mfQB/+fIzbpMzRQ2NZqZUaYZJTRmYZTeD1kEc3xSWDLSQGiHDi9Dw2zVwbYhN+6t0Z26qHjj
	7Fw7wp9pg5Zy1IXGx12gp1gpz1mh9QS4SdO+ljgXfiox/YfJgrR+WrZbqjdoTdqrNli/jdH3/F
X-Received: by 2002:a05:600c:c4ac:b0:485:40a4:364 with SMTP id 5b1f17b1804b1-4855670c2a5mr5450795e9.26.1773340703080;
        Thu, 12 Mar 2026 11:38:23 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm135560395e9.5.2026.03.12.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:38:22 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] e1000e: add XDP support
Date: Thu, 12 Mar 2026 19:38:15 +0100
Message-ID: <20260312183817.104878-1-teknoraver@meta.com>
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
Tested on an Intel 82574L Gigabit card.

v2: added a missing 'select PAGE_POOL' which triggered a build failure
with some configurations.

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |   18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  600 +-
 .../net/ethernet/intel/e1000e/netdev.c.orig   | 8529 +++++++++++++++++
 .../net/ethernet/intel/e1000e/netdev.c.rej    |   46 +
 5 files changed, 9182 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/e1000e/netdev.c.orig
 create mode 100644 drivers/net/ethernet/intel/e1000e/netdev.c.rej

-- 
2.53.0

