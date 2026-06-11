Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781213B5307
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161986; cv=none; b=YL2YqFveOGjPop5V7Htyt5u8W4EY+4WCgfpEGULEuDqal7rGl2GxpSBu5i9tE8xVw3yXU1QCuYvnpupEYOQdIt7V9svYPVh+MpmtRMxUk8K7IamV/8SuR0zVr/j0VMKtffESYJNs5uNIMM0jLPCVPLe3tjaHCACaeHoWH9kjPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161986; c=relaxed/simple;
	bh=5Fmuk1WPgZ6FNiG4XsMRoLQLg665mOSxeBLCg1WHEJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMtb+e7W5TSDSnjF3jFNr65HnhhF/M4IgWCLqjTXUIynL6wtRjSrgKePpatXLlNojSyd1+6EL8+1lzPLBez8m48X+4k8J0PNnirJMLoOkRSPfSYBJyV+kigHCyixLhd3iO8k/WtmwmqC4gqjjcZqAuXvjj2mzrTBsMCUbS8UNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz4olM/Y; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz4olM/Y"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7de68222e96so70362007b3.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161983; x=1781766783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBX/SP+Br7VLRns9PD3V50R59mUWLcgOroTlWmFsbRo=;
        b=mz4olM/YfkHNqwH6OTFi9mfIi5e0Ovqa4xUXyuDtlrLB8Sf5RhW9tN48zAMPJ6+gDg
         k6iaiaUkc4ZkgisKao4QVy8f7qPMkOp7mZIuYk5fnsaZwOT052GmpNAnIyPqkiLRILDz
         9w6wEgnjuWvbsOvRrOkN0yNa0dvMEke2aAYF46HGnSwk1SLjys3RfUsyeyTrNGEhcZGh
         624lcj7vi3Ngyaqao308A+ay6k07jKiWOXMTZ1gGfqafAYGZsviI/D5qThS0p2IO7txq
         dGGWzHQflj61zuzj9QUru4x5TjtssUC7xpniURoAjauPkk26U8PEv0/OtXk3v0jfSHIM
         fi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161983; x=1781766783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBX/SP+Br7VLRns9PD3V50R59mUWLcgOroTlWmFsbRo=;
        b=BSVL6l97nGr/447RjOhcs2rJxk72/3Y6EaG86VfdofUmF8es8xMUN0OB8AsAJW9sBw
         c6aLcilLQRsTY6w0NOheBQ2Cd6CoOGiCxpG5YEcV5IB9hgs4OpBiDzhZ501I0LQnB4GX
         DyaNzQu0g6Nyo9AHjlhSsO2s8+TZMB6Jw0FbqEoHWiRvp7Lp4jlAU2KNXolhNzd0jqa2
         +BlhLAp/Vln1hWbmjTk1mgDTAI5X1B9IU2ACl8ukY8FBwP8tW0PcWEi3YCRUeCwp/+I6
         I141ywajC2QjgOfYmxV2frf7jIQfHebbwRtLGGv+9XSPTkCT2kaxOyj3l+Aiq9bj8Eok
         NjbA==
X-Forwarded-Encrypted: i=1; AFNElJ/DSA9elqam7zTDtKLonuWzLKWeiVB5C8/Jcsob9h8ubp7PC4icLt+sPnYnLKTYc/wZgdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/L/TNFxsOKwiBC4OsSH+Wy6MMv4+dA/QJt8UFiEbCQ4CrPX3
	qVZnlAlOHPPOXcAVNvUlBErcb68qYy4w8Pnv1IWSAGWJ6uMhrqjvNvII
X-Gm-Gg: Acq92OFcZcoeHQOcnaAsf70lUjRwLMPv7VnBsP/H0kHY2apP/TDvQXKUpikXyNfXyPE
	0j/03QlcP1zFSLkzMs5EcZ/oW0sX2R/5miUUcrK6spTDHSyODYAchvl+VdYubWLLt+eO+kjDx9I
	AopZI1mmlQzj3+6Q8L87/N2RIj/yE5yasvF+MdbOGYbV1pSgDKgqubRsd/7Qoxd/UgTFFIRLWso
	QzAiSFKhPts+dZ2hjvkpAkAC/NK0anVw8Q0GhkKuWM2lg8+6TO+2Qv9wTBXXrtkvvzCzjVPv0F4
	bwSwhfY7wszvB4THhf7fwnVRSigEgomswPX8urf33IZzBQ+LnGGoQh6OGfsrY7s8D4iKIln6Nty
	Fxv4/FwtHCHxoHHcW039JasJIMcun5eGnVG/KW1UCxqIz0N6M/Ikll0NUNp8V1PsOSNK9F3ppPK
	A/5CrSJKTaTCJQ/G3w+4gma8zH4zUKz9yxibazLYjWi7pMOGyUsJ4=
X-Received: by 2002:a05:690c:6c13:b0:7db:f8b1:cd80 with SMTP id 00721157ae682-7f654f04a6fmr17001257b3.2.1781161983511;
        Thu, 11 Jun 2026 00:13:03 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:03 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/3] xsk: support tx napi busy_poll
Date: Thu, 11 Jun 2026 15:12:39 +0800
Message-ID: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in tx
ring. The sk_busy_loop() will poll on the target NAPI. However, for the
nic driver that support the tx napi, such as virtio-net, it can't schedule
the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk and
use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn't
handle the packet sending.

Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
NAPI if available. To get the tx NAPI from the napi_id, we add the
"tx_napi" field to napi_struct, which is ugly :/

Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
this a little contradict the design of tx NAPI.

Menglong Dong (3):
  net: busy-poll: introduce sk_tx_busy_loop()
  virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
  xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()

 drivers/net/virtio_net.c  |  1 +
 include/linux/netdevice.h |  1 +
 include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
 net/core/dev.c            | 23 +++++-----------------
 net/xdp/xsk.c             |  2 +-
 5 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.54.0

