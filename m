Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C69346FA0
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256485; cv=none; b=tt6c2oAq5uX2tuaFtF2AM3EvJA8SY9unRvhyC7HbEqqeUlZDeUC2t+jSg1kq8TMHqRRhNvI20Ut7k0Zcz6CAfkZYVtlcRqJbll9Gj1/h15evemXxBrQmWC1UbELQYxGG3kaJ1S3tT13jkZk+7Mc3U/Isi/8U/kNCVCZArSIZPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256485; c=relaxed/simple;
	bh=Pq7WKcXzSeR7KVK6f6E09WyZ843apjaQcmdYAuPWLlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhQKqtRutrm+NHoQUn5Ye/PNR9gXc+AAIIOKQgE/M1WIy74M9fB+gJtz9qZfI73L73TU4659xpDxnWXc2e2Mo9gsledSepavG8tS8CxBHm2/LIeWTbyURe6ZQlnPL1mCB/6j/szTkscIwY0OpzuwltvPY4S5Ta7xTaCASYXSEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1uD9uvs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1uD9uvs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so1714965e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256482; x=1773861282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkT5h1c9h1wMjZ35T4RgGzgmp+0K5CAbj2aPzzC5vSs=;
        b=U1uD9uvsGFOXPNydxgv9RLEDUHGgYCFkXYkPB6D+YBsC7Xv8Q3ZsLQ1USFdmawiFjk
         wK/85NwfoEShE5+ozaO/JPgWy9QOfHINdmv7xKtHHyOjvltRNIfNvTDRgAzqBBDcpUVb
         niGlsLPkyW7FJUkjm9gMdJQ4+ZyTWNIZzcR8kG11+TPj9OIWcG7DDS2FzzSupq/mx6an
         hvbMHPPb2PRW99dgbJWTO7Mp2grf+w/Nb6TOlzgfzI2h+1jf3isM5HkHHslEAVc08ouo
         f0uOX+ri4+kVWjn9a+En9790e10O9qK6Ic+VEVjC2BuJBnrAzq4hLXH3+6ZQPkRDAvuK
         ke1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256482; x=1773861282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkT5h1c9h1wMjZ35T4RgGzgmp+0K5CAbj2aPzzC5vSs=;
        b=GMhOsKbHzDTHGc/BGJRn6+VJ2OaRqXbrIV09XE6wWR69KqX9En4g+uVw6vGnu06vbm
         U0tz/iYkdpTdU7S5g9eMdSNvQz5HHkbudWTWOSz52V/IquzGOEcvxEbgD1U5QWloCdFi
         0Z2WAz2IajZmqsnbo3ZyIpDXP/U04dDMWKIwuBbXdKbfzZUB27qeMlWFVmmmS189tI5n
         ADne9gmy00UomhwjzuL6GRXsGnY58wqdIFwZCLFaKCDw3J+psGUSEhQeJgsJuSbsYfXm
         PtwkDYNgojqSGF7pkWqbdjQ19WBu2BCJquKLX1g2jLj3NwsDb2Ei690gFGAbrtULoLx2
         K5/g==
X-Forwarded-Encrypted: i=1; AJvYcCUSov3qKbXMlXv1GcJYirusBjOJg5nocPcWiv1qciNr3sqKFNSKKCFqilxxC/IgCX3Vc68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1p0MvGpl0cfFO73Dw+IZye8Hipj7ibIzfaR2lGuj8xPZc5Kx+
	IWmn4p4e+s/Vr/wz95XFtyWUtfPyUSgSVbfNiE4mPJ9C42siBxnWAJT4
X-Gm-Gg: ATEYQzyAn3QLYhSVCRpaisBVW8hwFqQbdES61wtAS9ON2Esc4qtspbSWpDTLMa+GTRp
	LgqRjfahtSuHeJL+ZKKbd/VZXxO74WdeHqxkGmztC1hcnb/qp99qnVmgsQvDYKMbO9pgnD+T3wy
	JzCzvyTdmHDDEfc3ixPAiTP5qzm3F8dN3rfQU1uU4vnlZ/QukHz+CceW1fs40tUb37b/8cAt0YM
	zlbtlF6sXA1HBfOundL3lOpxACmjUSA/KbxonBUPRdyn7BmJNTQRLq1TNM2h/B9DBMy8mvFM9nz
	D+eMJ3CXps+vXk7/gD5n0Z/55xwykaex3h5RXcnTh96OSD1rjjNvH8fk6+h0XeZGhIaiBWUvSe6
	MUcLCe+ZFzH+V7WZ8+eG8FcC7UEjJcSJYUiASmnfU+H24DclbPcwHGz5mJgOGDUP3OjPtgp+i/H
	gGoOQrbd1P4t6L6V8YR18jRJBGJGv3zAxB6skzLZqeo9tc6u9dT8Y/Blv2BiTh0kyXBciQpwZS
X-Received: by 2002:a05:600c:3b1a:b0:485:34b3:8585 with SMTP id 5b1f17b1804b1-4854b0d6ca4mr71576735e9.8.1773256482205;
        Wed, 11 Mar 2026 12:14:42 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2eeae0sm28084075e9.4.2026.03.11.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:14:41 -0700 (PDT)
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
Subject: [PATCH net-next 0/2] e1000e: add XDP support
Date: Wed, 11 Mar 2026 20:14:35 +0100
Message-ID: <20260311191437.3581-1-teknoraver@meta.com>
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

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 600 ++++++++++++++++++++-
 2 files changed, 606 insertions(+), 12 deletions(-)

-- 
2.53.0

