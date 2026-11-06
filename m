Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965586;
	b=ZotDKcqKO3yrjzD2SqfjWVPmmVXm8wmZLFp8SeALcu/ZWbFLko4fsu+ZEe6T5PwRNCej
	 s6O2or9i/PAYv8FthKW+HNDZW6zlJr7qNyhErwH8crWZMDQA0vgKT8hrFSPX8d+sJUUCW
	 ddSBP7ovXg/1Xhc9t9gR89DbrpV7w3OFUuUVeqtQQTRTl5l8x0vT3DYjOONa+zXla2ro1
	 JNCd9ivjDHyjxIVMud5mBtJcYCvjRhVApStE4JJsI4V7sTn32IHzWB/+beCONjJ2TOa1v
	 A+QSpd7BveWgvubD9nhQsvy/hmpinNI1m3S3B/RyubcpZwEIIfhkc0yloXSWBJZvtnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
	b=dKTgFEp4UzgS15RPpbLM7cDqR5oGghWbnNHdONB34babqGN+Q3+VnuqDL4B+6mwgUprF
	 mmL7PsLo7RPyebQxHta6cxJs/un+Fuy3dqDRpk/SBWnBu1fRT/fje+fZcGU4h3Etr6tdr
	 tFZbrRBVZIKlRoXqOMcGYCWn5T6wMTjIQzVsOK7ILcVchI34l02cvsUQTsVWNc4luZQke
	 bERseUsBaeUIdCiTUIWs89JQzCe4ksKSwIkPZJdConcl7pqd2rBFTHOHyizM7fxiIwbgB
	 uTkqs17TFw67OjSE7lL0dY6q5BtwtTxZldgUtIkCGkoGo2BDmzzLvv2h/eJU8Tf6iag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mKG/AQ/S";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB283606A935
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB283606A935
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mKG/AQ/S
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36e795af1d4so483447eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965585; x=1794570385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
        b=mKG/AQ/SA4Y2X8gh0hGyM4oubFdXoBqxMnh8G6XQzKaP0lPmU4nsMkWYHLmJ7XTPkl
         AX+JFGVxQ0NaRb95p9vzR3WUlvDZwSQzZgppzMG/kekQCPd+H17mg7rvpOXLLRodpzy3
         n0QkzjwOhxjvebmwM67xU7qvGWJ0YuYjgfYdDVBsthfsAxfXbN7Rx96QSCjNv5Px5aZQ
         eTIP4ej33VY0gmC2lD9Wk/E+CYxOjLrj3U7WXf96lZlHh2WQopOxMnRo+WRzZWYeBtpt
         2rc0uV+y0aKF3Gwk2G3Mb48I3UfLeG5bVn4Ijw2ASqMgm4Zvd28ccxxkWGET6rY5iMWl
         znCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965585; x=1794570385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLGfYC71OScNX4P7b0Ywj1iP8vp//hNbWZvlIRGfX1E=;
        b=tUb2mCFML672X/WTLQZjleBrT4j76vv4siXTJe6mWJ3IEoz4nmDfidL+b6pguYoJ46
         XJWrM7y/Uiz2e4J07UhWFbkX+QaysmlUaeeDhq8lt6yaPAZpBYXm8nn7kxI0qcNU3K4M
         bg56ppkXDowkGW91SP1IwM0e/10GXQ2CRPa8nRKagjVdGS4FJ5OvbfXukw2/IwstPpeH
         D33lzlfeNUcgj/aB3pbsNmqJvI0RA/zohJKTCehY+QebWQml38/0B8CjSpe4vvujVy0b
         k2zASnB4wEuVlAJkI7ukwd7K05Hw9r0hX07qqGoA/g5EaUyYg8Ovi/OWLHe/eNMSN2Uz
         I+bg==
X-Forwarded-Encrypted: i=1; AL+hErHPCVNvBriuervh1cCjHRoZK3A29wPkky/KaxhfA71Eno1HVvXUsKVKl44M4vazPqJNmSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zEGj3sY3YzoVcHy+enEJc5XSmHLMk1sRtVKbcDk9xLvzgpOVo
	ol1DikiX13xyl537UMLWfw6DUDA251yH7fnUNgQjM/8dNi6LNZ0QllA/
X-Gm-Gg: AYBFou2byTopA9MrAo+u4cwGM8Jbk8gclUE6j3QNxcOZE/lql3BdpQxt2V9ffygZ3ZT
	JfHDxNQSyrfMoxNu4qCuqbo0K5ssg2vuNelrihlllOf7Ms6tWAZ/lfaYwOawGERzJ2uRdJfnjYc
	NYafpqQ/w3Ibb+f6Jk72HJO/3aH3sgKJ2wr5+/mbun91iTgCilxeCivcaKrWVgIgOx/qUw611Ij
	nfMLAUyVbuPZ4lV4E8rCL+ZczvAGKK6Ca7Wn4jloaO2AuqiqsO9aVff0QozYBTA9gE/VQFp0Zmw
	8Z0AhzO8RYCpF7khOJeobOTUb014rjy8+qD4pezQXPwiOEU0UJZEfGH9/2DsDlryqjyY61gs3V/
	lj9hJCGsX997QcBhSyxH577gzLdKjy5iaGwCHjXeBXd8ae5v/AV6z7JhcWDbenvsiAH3WMUx5KD
	Tq9ov1qEPxUAWdhBUIknSi2zCbk6mHPYn2+1XxV3Mqyt1fozAgXvTWiG4pFd5Xt9JUYEKuN4Dsq
	3uqmlc6ZmQisRsI3tzbOxX2wFUlvq5LMO3ILFm5xVE/KMfar1XXN0Wl2UNXo8Vk0GC81+FFCP9T
	xSYPDm3rF8SzUjGKvPMCV18n4V38dMimsYVrgZFtO/Fi
X-Received: by 2002:a05:7301:190c:b0:361:a195:c46e with SMTP id 5a478bee46e88-36de39af458mr6879740eec.1.1793965584700;
        Fri, 06 Nov 2026 03:46:24 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:1d31:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9be7077sm6167055eec.17.2026.11.06.03.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:46:24 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v4 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Fri,  6 Nov 2026 17:15:49 +0530
Message-ID: <20261106114551.212675-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
so a single get_page() from the stack, e.g. splice() of received data,
overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.

With the smaller bias the driver gives up its last reference on a page
once every USHRT_MAX handoffs instead of once every INT_MAX, which is
only safe while every consumer holds its reference until the buffer is
recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
AF_XDP socket in copy mode, a path the driver never meant to support:
commit d8a8ca14c937 dropped the queue_format check that used to refuse
it. Patch 1 restores that check for DQO-QPL, so patch 2 depends on it.
Trees before 6.17 still have the old check, so there patch 2 stands
alone.

Harshitha mentioned on v2 that Google would send a patch blocking XDP
on DQO-QPL; if one is already in flight I'm happy to drop patch 1 in
its favour.

v4:
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/


Amaan Cheval (2):
  gve: block XDP on the DQO-QPL queue format
  gve: fix RX page refcount overflow from the pagecnt bias

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c           |  6 ++++++
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

