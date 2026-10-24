Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792851128;
	b=sHZtDUv5v67pH6FnFG+hq8yC4T6Evz+lzKcifT5NeS/5N1ON+PQkhqpCeG+NeSvXAs5Z
	 JmxGwHtedesBRhjCsO3JfZAFxa/xSwkj/KTxV38/JLiwDjld9g/iBWbOUvGCFH3DREFfg
	 ZbuKSqXxd3Vuo+drwbW4BrlQc0c5o0WV6CAQ1hjIq+AIwtN1itMWGZByBNwsoDn6P+Ell
	 Ey9CA/7so6xeF/W6bm5iK3PwSYS2i7S1mP6mxbRQSY5DXBeYjSsj9eGWfA4tTH6vVa7ZE
	 ry3+sYaSFhY4xPHquS13SMOHrKj+yc+GukbqlSUwoz0S2hDInSbH5YDaO7vZilUIcWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792851128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
	b=bty3U0M1FAMzunli/ZT3KVPvVbrqzCHskrzrdWy38E070zXuJS73Ho/BuHKw/xmh2OEz
	 E590YbC4/O2OwcFfCXbbZ4k5MzEwvPFo40/ebktMWerPmIQQinFwXhh3z4WW55caHphyA
	 Rv/P8nSivn5Jjo9VA+dnhk1T/FFmvoMUo79wT6q7iV27IbSyZL6lJFHKEjpunZu6wRRsl
	 K0VSONA7TxTL9IitOGJzKhXae+5HfF9IQkkPB5WMfM3XpB9l2PFmUVFppIgfA7aFwNZxg
	 6dqbIMK6/yEE9fFtkx/zwiKbTn09LcyBCcsxla8JLCGvEaWmpaZC8GN7JOYW4dkkUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="qN5mw/Re";
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B6606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A46B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qN5mw/Re
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso1632534eec.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792851127; x=1793455927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
        b=qN5mw/ReCB7w8Fr8wpbp17/Wt0LcVzV62xdjLQJ45acFlyX54MQXD0yvZoA6L8h9UW
         SiiD9IQhqeUWGygZQriJ8FqLzFn9RLTs8083oNXLfcKarEq3cvER4owatxsYqXeq8Jkd
         W9C1Sz6G7shKH5U1M8kbiBE6OgQDySs4MCSjBmrQqu9wSo9UlV2qE/T+bfMdQ+GA5fU5
         r0f7O+Yx5nywRv6ffU3HEQ4x2mFkftgZJu4dvT7m66Afx1IY4sR/aYG94t4t1bczeWFi
         mZHgp8AqWv99yVVShTVN2KQTRP9ugWMbOdhS++FaWnokQ19pN6smKvYZi51G1H5Ozps5
         0+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792851127; x=1793455927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CGYl3C86hfPgxp/SJNcGcvJ+3Ge62EjjXQJjZpVCIVY=;
        b=MOHkMwCcj9pMN0T9GFz1JF7gf/3M/ZekneKGbUoIthNVyMvEtgScb3Vu9JrLi7UsSE
         R8OlKow3DC3NYWNP3ay6EmdlU76BKHHLtxqE7hhQ1kZM8LpAVeM0X0y2cWjCLJHh6dEp
         TS97I8fA1Q1D/Sf4A7r7TuZLKak0EBd+NGie1b2K/XqVXeXcIIYWQAMIjKbBDQaDfjl2
         u6xXD3na1PzWu5s2CnxLQKiDtmOkYo3Mm/zVFW7m22RA9nO4RrvwmndwcXH7VTJwEZBJ
         leT+OQt/kFdwygeSOHwXhvmWuWiEyJOEcmdRUTIggzyHdb498wPwhFyE2vJqpOHmhzkG
         bJHg==
X-Forwarded-Encrypted: i=1; AKwUvBxJ0zsTPEZxDmI7dUx/tFWBcNK7Exu9c7fakEoN0ohhM1jQrA3Ny/5obZ9LgHoID5HASMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7rv+wjbkRfPOiTgSCmTj7k+1idWgQLPbOJ2u1TMFeio3lYmVf
	WcNBqqmFg029qYhmIxSxX3FgSGAkmBHloj2IgWlP0+VgLvtxC3kWAE7X
X-Gm-Gg: AYBFou3gi1gE4He7tZD9+EjkyXzFlYcDg1XT6KXxl9H/tNU9zFXN0AlYrCoZ+hJ2FL0
	3K77Ylhdky5LMdmJi4LytOrEIYiiBqPLUM+z7B24PUAzBunYpZae+06ZXhe1yA3iItiK6a+LxF3
	fGqDBLl0VNBrHX28jYl13gGuFoUxNuOMG4D8SfjfzLuQpihxIFMWVp5PYj/gZmYUVpyCiVvLpLv
	HxbKsxR2gSSmRISU+iMxzo5Q9nxiwouv472Z+d4v19GgLi86t5ye4coC6aOrv6q3NDUMy8rUw1/
	ntJlnq6dyPdUtnFkyLJXDIwHP6b7FTmRI2PbdryVURf7f4+QgNLNCnIpfemDcV2fo5Q9e1IbOFp
	sRk2HNtPtIiZHmMxqp69GuF2pQx8WUqVYktMTm0f3WJDHq1NU3CFCNmcwbrUXbLfo8evPdZrK5T
	44yP4lJKEGgIPcPWumLs0AJTv5IJSM0OJvKYaalLgKjpXs14A0ROyhr9W+3daMuWcGFujAwRH/V
	lPICXBaal3nm6TmNpS5URpd9tlYc8dMla1AjZPSdavdPXW8hlkGIFOZcPTXwP1SRlEnt3EXM9ws
	07D/2j/6DM18Al1hg+XGKYPt
X-Received: by 2002:a05:7023:a8e:b0:14d:c9e:a356 with SMTP id a92af1059eb24-1993571a2eemr3465311c88.12.1792851126409;
        Sat, 24 Oct 2026 07:12:06 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:6887:87ec:7e6f:2a79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm6366905c88.12.2026.10.24.07.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 07:12:05 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v2 0/2] xsk: fix multi-buffer TX software checksum
Date: Sat, 24 Oct 2026 22:11:55 +0800
Message-Id: <20261024141157.59301-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261024091256.17918-1-testwrzwrz@gmail.com>
References: <20261024091256.17918-1-testwrzwrz@gmail.com>
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

This is v2 of the AF_XDP multi-buffer TX software checksum fix.

v1 was a single patch containing both the kernel fix and a standalone
selftest.  Review feedback asked to split it into a 2-patch series and to
reuse the existing xdp_metadata selftest infrastructure.  v2 does that.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

On a checksum failure the packet is now dropped after the descriptors have
been consumed.  Metadata validation makes this path unreachable in the
current copy-mode implementation; keeping the defensive drop avoids a
retry path for an skb that is no longer complete.

Patch 2 extends test_xdp_metadata instead of adding another test harness.
It reuses the existing AF_XDP setup, packet generation, completion, and
verification helpers, and sends the same UDP packet both as one descriptor
and as two descriptors.

Testing:
- final exact-else patched kernel: xdp_metadata 1/0 PASSED
- same-config unpatched kernel: checksum mismatch, xdp_metadata FAILED
- checkpatch --strict: 0 errors / 0 warnings for both patches

Changes in v2:
- split the kernel fix and selftest into 1/2 and 2/2
- reuse test_xdp_metadata helpers and reduce the selftest patch to
  86 insertions
- use literal else and unlikely in the checksum error path
- document the drop decision and test it on patched and unpatched kernels


Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  22 +--
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 126 ++++++++++++------
 2 files changed, 100 insertions(+), 48 deletions(-)

-- 
2.39.5 (Apple Git-154)

