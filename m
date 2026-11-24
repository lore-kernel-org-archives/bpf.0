Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562093;
	b=0ZPijMnRSlo/+E+EUROjCZzMY0sydHwKzj7XJEjYQSDZfavFuDequ9124vrfpg9pE649
	 QUa7xv8iAuglGxFEepRNetcTVUwFLjvxfVQX7U9m+mmF46qKxlFhaOTx/y88EH/FXsoK2
	 mLWYtoOdkZuhMZigbKXsfwLYaLYMcanoJTb2qE3uybDqNsc6sc3ori75PNMANKUYL1o3W
	 sWE62wqVma6gqdD9XPj5IA9crBSQ7UCwPiMUdY3w2TbmEEtIX3+jh0caEcEOfWJvq77b+
	 Da9jTmlkLSCHg6Zs56EZU6PujmI6QbBfu+aWoiwKCbCfjJjcKu/W4xxmzwgWzJaPdLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562093;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned;
	bh=kVMqQyKRPOrNXj1KvHYDyDDl5HK15qVM/bRTtBFwrmA=;
	b=0KO2vHBGSuc52Ha36A/+GKjtKif5oa6YUyHQw+udT4rpWKWcWxW3i1strD6y5WHQNijE
	 vNJSJxyNzxDm96nPr3gN8QU/Sufe5Mg2Yu1mVDk/chSqS5T7pzdyeKaSFzc341OWu5PJZ
	 RjYMIZXWLLIkSCj+XlNUo0ReMv2AyN3/U27dL+S7fGULQo17WEEoyU3ph2MJrbPpIK+ZW
	 ZFos/zdkYkjGsf21VTHP5NXW2EYnOCnT6v2Z+DZa2+hTxnvZeVVMJYkcl3nPbq98RWZyQ
	 F7Ps1jHAVBkOS3V+9htMt4dOqyrmKihOz1YeosoEiYfeg40Q7KpvTlBOxU0JTxoPz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=YvDRTU21;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540C606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3540C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=YvDRTU21
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=kVMqQyKRPOrNXj1KvHYDyDDl5HK15qVM/bRTtBFwrmA=; b=YvDRTU21cYzciOAatQjfw+KkRs
	YJ+IRWtmcNa7JdKFadWRUUPnEFaVSOmbIyjMRJH8m0eDFMZgLDJmtfZSCz9HtkPhUmRRfC3e0pm+6
	XhagMDvhFKC50Hyjj7rUboeAmhTKc5f5tHGG2Um23Crt6DJSyVV9Ul6l4s/j5quBWsRaQNV7S2720
	sjsge2cZUYSIpC6o6lBpX7SfVCFD/rNWtwYeWKzuGs8HVeIwHSydVc4lscimKac0tLQAMWd+5THVG
	u5V+RIId3ZfOncjL4DBMLtXE06bPANNtnE/PAVKMIycWIdJvp4DDvKa6PwbB1rnBM4rS59pdOE6tS
	UAZOV91A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xVzim-000PyE-1O;
	Wed, 25 Nov 2026 00:14:44 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	will@kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/5] Follow-up fixes for arm64 insn encoder
Date: Wed, 25 Nov 2026 00:14:38 +0100
Message-ID: <20261124231443.3424414-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28193/Tue Nov 24 07:27:44 2026)

Follow-up against bpf-next to address [0] and also a few other findings in
the insn encoder.

  [0] https://lore.kernel.org/bpf/a7605e34-15d4-4bc2-a424-fbab47d20bea@iogearbox.net/

Daniel Borkmann (5):
  arm64, insn: Reject ADRP offsets that wrap in the encoder
  arm64, insn: Reject a status register for the exclusive loads
  arm64, insn: Drop the unused outer shareable barrier types
  arm64, insn: Widen the ADRP offset helpers to the reach of ADRP
  arm64, insn: Reject offsets out of reach in aarch64_set_branch_offset()

 arch/arm64/include/asm/insn.h   |  9 ++---
 arch/arm64/kernel/alternative.c |  4 +--
 arch/arm64/lib/insn.c           | 62 +++++++++++++++++++++++----------
 3 files changed, 49 insertions(+), 26 deletions(-)

-- 
2.43.0

