Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764104;
	b=BehaYGCZiUdv8xdliuQ2bRHwcPEl7I5o2SzwtMmVaBbY6Nd5kY9SYIjsfbQQa2LZrIEX
	 Hx3Q9AyJh7mDoGQAVn6uXgJZRClWQ0ec6WuuB7hJdMdPnP5pffnhxDYSxeBLRYEjxc1hl
	 ky99oqHYx9Y2SN41N6XM9Femf5CcPMux0vvCy2XGnkRzCI1Kk+f5hN2eTa+RGShuguNuF
	 d5n7CvTn9aMiPBTONXrlZ9y5tjk53rjZiXMx6Xc2Tr9rHygRTvZbfZLe0X0E8+jg/JHFA
	 fC5iGg3OkWY9DgUyr8hOVz7stoQO6LSqDMl0MqB/S717iRayUV2LlUdKZciWMQi0ohA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
	b=twVTGj6qe7VmiWtHv4cpA9o6duWM5JvosZ5Z8WveKIHIoWTFVIeawNYfISktf3PS1XI3
	 tE1rEnZ1SKLVivF7qdABrA3eC4ivfrdD4V7k7OlV+fJPCu1RdB94ChooQC2R0BO2komw1
	 BwWEf8sJiF8Kyt0dqL5FGBNGePOEVfVod1n1J0x2t47h7KJl1tRmRNbWoo/FZSBi+h9MV
	 GGq/tirrX30ajewu1Ap6Wcnc/JR6CSVBuUyTvbTm5qjqCNq5YUJ9aK3PJ+beONtDKF59w
	 A54yMmHVdLNaRGr6JroeSICgco05GA1ovu2jnoIPXWzVkC0bahgqiRhZaPS0FFboG3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgUuajXE;
	arc=none smtp.remote-ip=74.125.227.135
Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A70606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A70606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VgUuajXE
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-3ac63aee1ecso132779a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 19:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764103; x=1794368903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
        b=VgUuajXE3fSQNacAxk3tEj3LnGJEDe8eO4Xmi74v6UY6fHz6tM3wa7S4tUAUWkHaBM
         59ho7QGCRoW/e1+9Kfw/D3fuzzPaViTo9tlaMuoP7axIzYO2nEO17qpALd9cEOTLymK6
         UYFvxKM6X9SUGVxJowCEQrtOBdJW/HWvUoAZoEvn5ATujp/55l/zYq78izLTyuuLUSpe
         wSrm7vgT2wQcq1AB79XHUT0+BU5jNvnwTpab77YKTc5ImYJFdywHCga0pB49jTwNEAOn
         YENRyBabanJlUxoJqV4t6/vIXVCXdMjYrbJ26/qhFsUqDm1o4E5sTJf1sc34JPYx5bsJ
         /9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764103; x=1794368903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgT7bUtyHPWasmCZmDkpecrIY3qUpLy/3lFoHoAwrQg=;
        b=au15Ezy8HA+deQL/gkBJ+w5HZ442utlvmndSKhw9iTMN2G0IkIL9JdL7UbMgV3Avgx
         DsawQ1lCEIbsNiL36yYG8dc58Fs6bXhKpAf8mPo9FV3vmYVC8drGrm0+Tn0ZNPToaSeV
         urmK+6K1XLecBxP/O8Hrh1WTJXFiBA1YM7lIm7OgIMKTg6XOzv8CQuQaJTzTwwIs5oYF
         isKOSIP3mvmjpdOr60jVjEZhuLEiLn2HJwpC5lglwxfDnk1EWanSLngGesl9gbtFN3VB
         dS/OoCy8aDnrQcWUofX/kgg7aHvGaYuE1reY8jjAxYOnxyHewYtRxrM4DM9nZL8dLizD
         Xz/w==
X-Forwarded-Encrypted: i=1; AKwUvBzXNbBgKeoSsU/FWwt8+R+nYpHWXglZyVlS9gSfoWjzVT3eA2L7eNxfUH5LvEmOVcxX+CU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dknCmi6zIgihMK2/M3TdFHB85UlXTAGqxyEyBXiiPBpbbYCBZ
	eD5UhEOIN9oe3MVJMaEm0D5CRy1kbbHt58vKSnLeBLPD2BNmOVElLOaK
X-Gm-Gg: AYBFou3Io5r9f9utFCoowzLHvx18UBclWdZ7s3M6IHRH8OUZon9Gn54TDzDFpmxBy1A
	mz9QJPb5onQ3GUhLLsQKOrEagYFNGh5aOADRqZVHp6wM6oBaDZX7g5gY4gxGnJUM/zMJ168p57T
	CcPeWs5dEptCVDhJL0+ogrmOUmIFGg6zvGvqUMMQ0nUJiAjqp8heSJhHeyjKd8Fh2sowMSpA1YE
	7HnqmcS24wxoLTrTGsQ4zCpDIRsnWvhd4XPsblD12k0s300OupKnGrBACmeQ+PE1/7lxschpOId
	u9B8ity8BVTnNy1NesX/pK4Tkiq0ekLdm68H/aa+Vc9ve3JmzYkBmy9+CW3HDcKdizHw7RTXsJa
	lsgYVQbL1mqmTATqgOVmQ1vX0H+8V3+ZMOZ9jdERCYicVNriXwvDKBCTrdnLOxaVK0xZUEArTGk
	jMSr1pzMLs5dqp8S91Hn7OqJLya5Gc+1dzqB0SwcWaTkX1/jfDcnDWWDy/+vbOHLnwfYqpkKZCa
	IdglqnVOj0apvU/h3IsZDZZJA1A9mCb9JRX0tf9NEDzN7zGLcnfFL8kOnCJs6d0hsGH96QL3bGb
	/RQFyn/nN+QVadtYvBUFQ8X/IANuadZ9GH5FlwODF/O1t7n+EGelDpBqthG2xMtimF8E
X-Received: by 2002:a17:90a:ec90:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3ae89831a14mr12516860a91.49.1793764103123;
        Tue, 03 Nov 2026 19:48:23 -0800 (PST)
Received: from localhost.localdomain ([240e:46e:1a00:3fd3:e1be:ed6b:40ce:8dab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1705472a91.10.2026.11.03.19.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 19:48:22 -0800 (PST)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v5 0/2] xsk: fix multi-buffer TX software checksum
Date: Wed,  4 Nov 2026 11:48:07 +0800
Message-Id: <20261104034809.24545-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is v5 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor
was correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 sends the packet using every descriptor count from 1 through
MAX_SKB_FRAGS + 1, and runs the existing metadata and checksum verification
for each case.  The last case is the copy-mode frame limit documented in
af_xdp.rst.

The updated selftest passes in a local QEMU run.

v5:
- remove the unnecessary else branch after the multi-buffer check
- carry all review tags received on v3 and v4

v4: https://lore.kernel.org/all/20261030023248.78802-1-testwrzwrz@gmail.com/
v3: https://lore.kernel.org/all/20261028025026.11401-1-testwrzwrz@gmail.com/
v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
 2 files changed, 107 insertions(+), 63 deletions(-)

-- 
2.39.5 (Apple Git-154)

