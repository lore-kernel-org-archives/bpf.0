Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEEF54768
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 01:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778376206; cv=none; b=XIHUGLiccHILdUFN0dkxfo0NmRhFwO6jDGR+xjBzM8IDLQ8BSPwHzMLkx1+r639tSPwQfOz0hcSOJdUanD53ouemaNQkswSMSSweeCm0GuV+BqwIQnnEqIPsjMrLzu+fF8Cv9p2XAGpQbPMalpCuAiHrqt7zAfjFj+jYubqIBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778376206; c=relaxed/simple;
	bh=FFPjyzw+RuI0OtLjHzbIuafeyUusmLvjLTnZyj+4y5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wh3sakk2wVSKtBr6Eksu9mVw51w30E6ZXpnxVvPMRwVfJKALaG+iOuZUdKF+5on9lOKfMK38M0zzWPfeVCCyxP7pxFCTUqTovqXOlG6IiiF/E9mokMf49517eoPc1fIUdoJgf4L4LpyVoWQnaXUE5FHYmsa/SZCHBnyTOVoMvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5GErs3m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5GErs3m"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b4650d5f5cso12127175ad.0
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 18:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778376205; x=1778981005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4I0UKgKu/0EBuCqC1bvuc341Yrim8Vb0KgR6RbKLp4=;
        b=G5GErs3makVCj0ajKpGGlIMJKRbBfG4fWuN2dtq3JdFIWhnpbNP83wTMU1ifSOr3Aj
         B45U/cYkbWnsF78wvOTj0S+r0fpFsP/vAyD3R9BqsHnYB1V/WV6m2fkwmDh1z886tcZe
         L0sp5qopfsEUoqsZH9bIG7ClFcULs9coS+uonCnVye2rBWH/rXn5/WcR27LnBfswA1s7
         DbMk1YX6tmwsEDQ3LiwtN7TwvKuRCFtXil7q6nI57EOQhSKfDegbub6x3fN0FUZ7vp6I
         I86oEREXhNcQG9EqByBMZ961kitIorq6m1T670utZhdO6SxGk3ixEoF0toLErIpmscNl
         899w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778376205; x=1778981005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4I0UKgKu/0EBuCqC1bvuc341Yrim8Vb0KgR6RbKLp4=;
        b=NdJrfBfvAYMW3Vxdqdk/aWYDzefb5DOwBmHyYrhk8iLhoG+3xGuXQdPnu9P7y3IwZW
         MeIZZ4TvVTctMWAvFH4y5OBAamQOlUaPjqrGwgIE5O4ZZhkVhKBSrn3TXIJT5yGZ6MqI
         mirz9qkX+39+xRFi8h8f3TzGdKb4BXsBodWOIBLr4EeWFTlw9JrZuR7YkEvO1c7uPvGe
         CcKkH9Yk/zqJxPt9PEeKm+SHYu6XWuzKsWu4apCDNwzm5msTiGdm1jkeIc9OSj2Y3Dy+
         rNVC+uI9JW3rBxyneAo92APJK4H8EtSjlD/kIQd3OaTXbODUTXSZD7DB19jLtbScb44F
         T0Cw==
X-Gm-Message-State: AOJu0Yz92kyfhcJl4T8owW8nKP7Q0juUSLVEkqI4mGNvlHSTrsfaivic
	+EdaTcnYin8KyO3QMByygwt8XL9Y1T6/NiSZkfKefifntQlzKi2IUZm9
X-Gm-Gg: Acq92OHadFDoW/l+Fnmge7CjYZGiVbk+AwmGJ1W4i1tI9cH4AIp3i5Mb5uAUNCXoy/J
	9PUQ+WMmImhBtNQENl0tzk/B7M8V695xDZUzFjFuBcZfN/hXP3s960zcX6hwkApO4Fn1WiYot5K
	0PM1aycTuM6viPP1BCD+e/Ph0RvWzKJpO9gEE6cqJtEtXrL46CJIqbkfvg2qHqZEB9kKQVTyZch
	4U2VChJrtOe9vumoJB36F77V8CP5Yy1AvNXVme+Tmt6l/tTmNVQ3ymfVcv4JHB/UmvcPOwxwFrF
	yrq5yqTUQ8NV/wRgumrmBVkafgQrdEpuWOOuD6xFa2ZfuwwwCFZjvV0eJxrqd/96ctRTOFyqOsZ
	kvSQqpwqiKPoCT1n7ZiZFH71BGkJGO6tR71IyVbLyd5mRY458jsFvvDyQShnJXr8uiKfpl3ASI4
	uMt7kgbUZ2+knid0qwvNWhgwD3aunwA9maUNReuKsB91QGdXyDMdR87U1wCJwaB/epVKm0jPGdG
	Fn7vuP2lAlXDmgyJmGCUykNTaguYyp2CrWjE9YL6A==
X-Received: by 2002:a17:903:289:b0:2bc:7eee:200d with SMTP id d9443c01a7336-2bc7eee20c3mr39290125ad.33.1778376205093;
        Sat, 09 May 2026 18:23:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:1949:c5e0:289c:ab19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d269fcsm64648875ad.15.2026.05.09.18.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 18:23:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 0/4] xsk: fix meta and publish of cq issues
Date: Sun, 10 May 2026 09:23:06 +0800
Message-Id: <20260510012310.88570-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series is the product of previous review from sashiko[1].

1) META
patch 1: address TOCTOU around metadata.

2) PUBLISH of CQ
patch 2: make sure xsk_addr->addrs[] can be published to cq when
         overflow occurs.
patch 3: keep cleaning up the continuation descs (more than 17) and
         publish its address when overflow occurs.
patch 4: like patch 3, but only handles the invalid descs cases.

[1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing@gmail.com/

Jason Xing (4):
  xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
  xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
  xsk: drain continuation descs after overflow in xsk_build_skb()
  xsk: drain continuation descs on invalid descriptor in
    __xsk_generic_xmit()

 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 48 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.41.3

