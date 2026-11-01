Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551568;
	b=5CvPEjqBUVVvzuT1R7+pDLpsxBpW0gQ9VoWvwO5lwYcEASFzgkWJgsmgIOv4idJXWnxs
	 /cOog0W1JAwFvHT2c4Jmyz/XfMZnTxAvkivLHMVIMys5XuDgkfnlN+xc2TGEEFbi93Kjf
	 SZ4Xikpq9iIWyk+qZOiiWXdh8znBImPjY1bTxvUwqKg6ln93FJnJn8TirhsitT4B4DDRL
	 NH0LFiAQF8q4lQRqTX/7vnarF8rEMYf+ONFAYBgQ5q427ljG+ePGSrML7KxqPDvA8nkmr
	 XnzuDtlnmOqOWA3+ddTtUTVSx8ezHZnMrzevl4Nt53Rvc3dGSCjOUOaNwKv8H81M3+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iEErhRDl3S56+aNPJWVUQgzwmxLxife0dB/9v8Rdiiw=;
	b=NzbaqtOTV7opHh6HWsLq6uewH3Pl84H0zuRRZnXSx6NkKPJEznOd0ppxL+zNQ07iowOE
	 rASICHMxnwyahtU8VUBxzGzI/AGmp2Kro9GtGTwRrf81mBkY6x9VeZvkZU0kb9fw5STsf
	 zez6mjU+jyJbUweZsPOtUkAWwsGGNuIrk+lNX2Q4iOABzLhZwU6KcPcyb1+ijsJ96CdGQ
	 5xKklCaA05cmHaN6dojCS0aSJrVqQ0wO+PFlnlkL27fBWPjvsAR0bAqzLnSYaCYSHQSKV
	 LEzfyZvtzOsfC+O27cM+zKePpwm9FDzEvLg/vV+swwiaP6m6iAmAjbSf/Xqz/SDmxEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Mo1VfA1Q;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAE606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEAE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=Mo1VfA1Q
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c445c95d553so292432466b.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551566; x=1794156366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEErhRDl3S56+aNPJWVUQgzwmxLxife0dB/9v8Rdiiw=;
        b=Mo1VfA1QYS7med+7h5C2VSJWUvErjNDQBkiMVwcSRop+V16SphII3OJte2cUBPuAAr
         C8BxL3wPOI3Ky8AhF0wkCfP3ORb3XvxQaceMLD7ffw/UtUYG/wbM7k78/u5Pf4glpx81
         Fqn2aLbG0GQnnQayVcf6JUGvz7OPIfCcBPlIs2FrxS1fSHoHKiDs1OuEuv6z5coc9JB6
         DFpWyK1uLvNXJSZVI4HyUj/iAVHfJSx9LF9rX+JqQXVZDS4vg3Wal83xLp46YguuOWX7
         Pu+f3MhVPkO842hG1GXmkAQt4ghJBd26E/ujEws2yX4c54RnIKcVS1Jngr/RZvIYI8af
         LmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551566; x=1794156366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEErhRDl3S56+aNPJWVUQgzwmxLxife0dB/9v8Rdiiw=;
        b=E5fXPiVKAMsc28wp9a30xuD5i3Qjc4Ef/UCiCr7drqFHZ81L1WgI3gss3oFJPdpQ2A
         Zbpju1IucKB/UsqDWzGnf4RgrYzh2B5uvQ5RS2UJiGQR9ZHSmiIpmpO94MKsX83dvUqD
         3sNxT5RdR+FFmhk5iEk5GzVAVT+ATA0lcItz0DxZ+gdkKRJDE7v8ZvGh34ukIPwBS2fF
         y8HrXGBurOwwC6uz62XM6u+CMiQg/I5u+MyZtY0ke2+x/u0PukjIh3aY+Lwoz21MhBgo
         Eoj0tB7izw02r8/ksRVAdJYG1zpzeHY7/7wjX9F7vy8Y6V8jJiHHn7s2K3NG3m5ccHrJ
         CLyw==
X-Forwarded-Encrypted: i=1; AKwUvBwohEoomrN7DqtbckduP0xxvs4syXDKyL67GzlVphZkUZhRDFhbt7BFY+p+Vj8t1j2xObk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiZAvxBc+ktpRckKsTgPMA7tBRhICoSSMTdGIQAeO5Xvw6o2np
	GFqiFDoiC7/RlHFl0a22Q0+9dWv9LpVypefKrjeFSIijKNnGGHhcpXCYBFdm0XxXZg==
X-Gm-Gg: AYBFou20nYhmg0u/Ed5wFAS/+nXFSV5jKn6728oI7u3pTAsc1Af46yleFZssTzK41a3
	l80int3umRUDkJqnVdom5VdIlDEAmyIBnPSbBbZ6Z9qZ2eBBr8cUmyh32a/lbda1DZhvxHkUJY7
	z/wm5nQdxoJr8BgAt+Nvs86lxJsWi5EwJ/pFW8V1mtOd36B+cQTQyKZjBbJvOCHjoYp4nzHaxEN
	XF8P+o1Vlr0uc8o6e4ttVbnQqH/jNHBRZAunq2QEPyxDD7dPylv5Pn2XggjePNTygDSn85gbj7D
	cDlIV8p3Ho7cg+W72431z08TKaLpRrx0yLvhU6SfESAZDXVg/FnqHf9xm0t3Gq9TcUkKjVTXJIj
	4PLLYyXuTGK2+33COdcChI7RiAi0t4QI++NzEQ8mEcs9DQgBnRyWz1+tL5ruNbqZHK0FmT/QNnl
	NEHN4P2W0G3aPigNlM3hkeCJ6cYkCTjePyO3qLQ2yI/v3zK0LpxkEipE8TxAqH3CMlWgyY8Fr7R
	mKe01lewxxIkxMjZgZvopogl5gPWQ7yFRcgNCs2v0ncdFqUkdaLRyjtK1bhS4LjgVAzs+MDOk0A
	Fgq8mMg0UnnIN5vfnp9JldSPXCntb5ygmBgyoEIat3OdgZZu7qW6i8Irb8FhaO8Ef7+6Wc7ZO3I
	vbMPlV177LjGGk5rqhYad1Ako/TUZ35Kim67s8+Qykh/qVZNUizkMjrGSnI6SL+r+kONcVBjj57
	HGZaO6OUjmPLfWt5aUpHiwRVfvVHE7WDttINuNLvau63U3vwUlq7RJrnIk/rxdd+ySGlT30Da9D
	hBR+GbSOwzw9VQz2rJuPDWQjpob/jYiQhuo8eZMk1zhNO8Z1gysd8TdIP5d6qme64hIf0BDUrtj
	EZHFG9q+PySFOJ2x37I6K+cvb2sffyqrM7AoPrI9
X-Received: by 2002:a17:907:3e9b:b0:c2d:bd87:7fa7 with SMTP id a640c23a62f3a-c4ca7a88866mr599588666b.24.1793551566094;
        Sun, 01 Nov 2026 08:46:06 -0800 (PST)
Received: from Desktop (p54aff790.dip0.t-ipconnect.de. [84.175.247.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfd254sm296928266b.29.2026.11.01.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:46:05 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	richardbgobert@gmail.com,
	willemb@google.com,
	ecree.xilinx@gmail.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: keep the TCP fixed-ID flags on the header they describe
Date: Sun,  1 Nov 2026 17:46:02 +0100
Message-ID: <cover.1792857378.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
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

GRO sets SKB_GSO_TCP_FIXEDID for the outer IPv4 header of a TCP packet
whose IDs do not change, and SKB_GSO_TCP_FIXEDID_INNER for the inner
header of an encapsulated one, since commit 3271f19bf7b9 ("net: gso:
restore ids of outer ip headers correctly"). Encapsulation,
decapsulation and the GRE and UDP tunnel segmentation paths do not keep
the flags on the header they describe, so a TCP stream that GRO merged
and that crosses a tunnel boundary is segmented with the fixed-ID state
of the wrong header. Sashiko found this in review of an ipmr series:
https://lore.kernel.org/netdev/cover.1792293419.git.julius@bairaktaris.de/

Patch 1 moves the flag on encapsulation and decapsulation and keeps the
encapsulation level below GRE and UDP tunnels. The three changes are one
patch because each alone loses fixed IDs in a case that works today.
Patch 2 adds a selftest.

Tested in QEMU (KASAN) with the selftest, 17 cases, 400 segments each:
- net (7076f684d513): 5 cases fail: fixed inner IDs incremented after
  IPIP over IPv4 and IPv6 (40 distinct inner IDs), outer IDs repeated
  after GRE and VXLAN over IPv4 (10 distinct outer IDs for 400
  segments), and a VXLAN stream with fixed outer IDs whose outer state
  survives decapsulation into IPIP. The same 5 failed in 3 runs of an
  earlier version of the test.
- this series: 17 of 17 pass, 3 of 3 runs.
- with only the decapsulation part, or only the encapsulation and
  segmentation parts: 8 and 5 cases fail, among them every
  encapsulation followed by decapsulation without segmentation, which
  passes on net.
- fou_gre_gro.sh and bareudp.sh pass on net and with the series;
  gre_gso.sh and udpgro_fwd.sh (3 paired runs) show the same failures
  on both, which come from the slow emulated machine.

I used Claude (Anthropic) to help write these patches.

Julius Bairaktaris (2):
  net: keep the TCP fixed-ID flags on the header they describe
  selftests: net: check TCP IP IDs across tunnels after GRO and GSO

 include/linux/skbuff.h                     |  30 ++
 include/net/ip_tunnels.h                   |   2 +
 net/core/filter.c                          |  11 +-
 net/core/lwt_bpf.c                         |   1 +
 net/ipv4/gre_offload.c                     |   1 -
 net/ipv4/ip_tunnel_core.c                  |   5 +-
 net/ipv4/udp_offload.c                     |   1 -
 net/ipv6/exthdrs.c                         |  11 +-
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   2 +
 tools/testing/selftests/net/tcp_fixedid.c  | 396 +++++++++++++++++++++
 tools/testing/selftests/net/tcp_fixedid.sh | 291 +++++++++++++++
 12 files changed, 744 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/tcp_fixedid.c
 create mode 100755 tools/testing/selftests/net/tcp_fixedid.sh


base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.53.0

