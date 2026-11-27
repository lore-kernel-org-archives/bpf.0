Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776848;
	b=hJunG9Bxyvx/5tA8YkFjXU1TXYTJHOTiEYBeTslju9kVhA2Q53RuJ/59Cvv/UcOfB6Vi
	 yopviNMwUktBNpvVN5SVqTg4SoFcHAH22rqhp84tTclaWhtaosR8mDFeL6vgQKlcgCYC/
	 UMcct/9St7BdXCrFuZ27ctxFZ1kD58uo+qiRNY1Uq9GPs4NXH8IvaeMp745bblCJMCptZ
	 JtZ4HKJZ0xFrcRbDhOU5BARQbtXOfeMiWQG0Takbbersa3ZmRIYshfZNyrbx5fHMot9MM
	 O2IkGlKwiEL9oeIv+g8k3XcFTQyJl8rzMFlAKel9Od/Dhz9evlRynI6t14mmIVes3gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KtjE+y39LGbirxSIXRR4VoQCxmboKYF40P25tI5iNJk=;
	b=fBmPVHDJvoC6yP7xA4qovhag99RqxzjOmA0GjYjrgOa1JkI4Re/2BfUFr9SFhFu+wu+f
	 AVh6tv21dfDCagKSTRq1c3pGHshVTTK48S+9EtzViQshSzvf8yiIt2VF1IHTBNC6/+/nD
	 9W8+J7a9mHYbwRErnB8vXXzeLiBQ9v0M8bOskJ4ZXmCZw06A/BMM3UFfnSx92XzhyKwcV
	 ttUf0OSIsQDReQRb7PmiJjopIA+e/xv9KOYpqlRkWupcS9q87SpgJiZpzWxUGI15AU3ir
	 shv3XNJ1MgYY+YskVtuekFvdrcBkfvKseNQI9sebI626OGNHBtS/WUOQQIXvOm3Irww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJDRLZtR;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29656606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 10:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29656606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJDRLZtR
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b546061d58so18457493c88.1
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 02:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795776847; x=1796381647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KtjE+y39LGbirxSIXRR4VoQCxmboKYF40P25tI5iNJk=;
        b=YJDRLZtRKgK3UzAzZ/9roXYftDiQfz3ptAtB8V6A/is6kf1b7P0bzMLL6B8Y+1V9G7
         rK1peaWVd9nEl/bySmGSkk++VrwTNb6MsFY3+IAPpNzOO6ie5py4kbjLsEMagEC1Itmp
         mwdMIe0JeN79mofeBwpckqISeGbZXuctNdLaEDxhYYqRaPioOH8dda/bSH/OVoqDp01z
         XvppX/7t1wD5nmeiPncPlnHCo6/4XDpUrYxj1llBWuVF0kyZeRXe/lTTwdrpo9i+Z2hY
         LNU68MaTW4slkOapVv+TETuNMUpQV2sJMvalEP2xEBO3SW8Su4MY7w3fvkenEZVAg2b5
         dnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776847; x=1796381647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KtjE+y39LGbirxSIXRR4VoQCxmboKYF40P25tI5iNJk=;
        b=C24C1iKE03tG5lJq9nLJxPHxznqfHFblu9Bhzdf8x5N3bjP9jOFjtMPYL5uIHhvlN0
         ZCMnLdYMZFtzAE7Rp0r0sTsXu/tpxnflowlu3rpxqHHXmHGkT8o88EDD41JyZ9tlwAq/
         9vOAJ3mRGCC08pD7RSEiISP5vGSAPxp385EjUZZTvhPPmjSMjXhWM4weJgp4C7FdZZ86
         KctlnQZJgHUjngEK1SO96iJzhUcBhCMCnp80lDK3EGx+8HYAP0oJSar89TTAINDaQvHa
         ptSI/1QrlBUeNlRplLj90/ChGEjfRji5oywFaUktB0MyMQ9j3pvX18AEYW5LhYf1AI6N
         Pmvw==
X-Forwarded-Encrypted: i=1; AL+hErF50431UZODE7hrzjmHhQyuImVmlCL9zt46TRpAjAO7Ng3oYhBAA8GtapEbrzjOpY1QRxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1IFG0KWyF4BI5tSevVYVxhcibTH7Fj4JtGfpppC5HmoALJfcv
	NC68ZcuhTMckvhQ7hj0wRIaLKkxvDfE7Hx7/kp0bVKpHIee1H8Cpe4z4
X-Gm-Gg: AZFdTZc0019GPUH+5Yl0Cx0SwyjRNq64NJ6qvrXBS8YfDlT3p1jkbSyph7kWe16tU/1
	Nsb7EdmwGtpCSSjiVQ32FbcZVqCD0UzWeUXqG6NAIxWxEyWkW/z5ZW34EWEQoUFb7pJxZ83DCeS
	S5d03yepZdYgRo9hvJH2n2zdySdkGww/EuRxlWa/zdXYM+sL4xTcwREb7On3hTxom9A3Muqro9s
	fyHMsThYDKblX84K0F6OooQetIgJju/+np+E3DnbQ2bQ4hxs2J2ZPuc9ss/1UTgosqAoFVX1o1h
	cg9XhL7GGJC6sNC76cf0rr5n4/qOugljeDqufN3DpZg0pIN1ZUYQRDm8TlcyUB9ip7rVINDVCga
	KYGQXWyx7JK580Sbc3utenpMD9iy4evkDBauvWml/qBP0MafBzO8+0yGxo4jWJW/AObXMdTSWs1
	e6proh7y9WdLxyV/3DbBctwafzHIwRVnTOOAcvhWcI1xfxzZ10jplu/o0pnQtQinQXorfFXp7bD
	16SWzF0D8dAlDwArg9As5Jpxe8i5BP/YDY8lCZL9hISUYrU4VD8XbGLL42jQCtprHhZ8IB/dt+E
	wUEmOK/2l3JJbec7nqqtw4hs3sV8Q11LwAV4/tX4RjXuRYgIIOYy1yTm1d7c+iLvjgjrXIVJEHU
	3t3hpoejh2IslJikwiz0ZQfZWbHsjDWSbuTCpRMSCevwM9PVOcwLBm6W0kEtpBrTm7XnrMQVP
X-Received: by 2002:a05:7022:1701:b0:1a4:c892:b130 with SMTP id a92af1059eb24-1b55feaa6a4mr22058271c88.15.1795776847208;
        Fri, 27 Nov 2026 02:54:07 -0800 (PST)
Received: from localhost.localdomain ([38.114.108.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm54992326c88.2.2026.11.27.02.54.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 02:54:06 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: willemb@google.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	bjorn@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net v2 0/2] xsk: handle two header issues
Date: Fri, 27 Nov 2026 18:53:45 +0800
Message-ID: <20261127105347.72997-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Cover more potential mac_headers cases in __dev_direct_xmit, including
xsk.

Initialize the metadata of headers in xsk.

---
V2
Link: https://lore.kernel.org/all/20261124083520.45547-1-kerneljasonxing@gmail.com/
1. address issues reported by sashiko
2. introduce 0001 patch to prevent the changes from 0002 casuing ICE
unintended buggy behavior because of using mac_header in ICE.

Jason Xing (2):
  net: reset the mac header in __dev_direct_xmit()
  xsk: fill in header offsets for TX checksum offload

 net/core/dev.c |  2 ++
 net/xdp/xsk.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.43.7

