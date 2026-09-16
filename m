Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CF37F742
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535318; cv=none; b=eg0KxOMZCLbaByH10xvKnLNyxGvy8MWsQmmulvgNtxiCCaQvnEvycD63T939Wfy1Duf9x5TByKjo+P87MZsfIchdhL2G5psMmQd41uC405o3WfE6mIcN4XG6UNfKCAMAB9P2Q6jrq+AJH5s+aRlGgxKqXBNnIgXHP/aSXiSTQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535318; c=relaxed/simple;
	bh=2cgZHqdIDWjy5S2mo79peEOhzTJ1Ke+APakpgI0d4ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8DjUOH1JQOA0OYc/D8Eyl2T2HwpFdMqBG/5mLSev+rND7HacdN7qTLwBTM7M2vao+q8+PDlOMJqkjEG9T8GR85Z2ad6Yntdc/aQ8hXocegc6sFFANeCFFSfW758WW1vD39Cx1zM1xvS1Nye165L4ePDqTqU5qGJbV3pqkwu6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=I3WP6PLh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="I3WP6PLh"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so423862a91.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535315; x=1790140115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j9ZKxm5fjZ6Tz5RkeiPUJnapHxTN5p2mOK51NP1wOEA=;
        b=I3WP6PLhDcuaKCqdSweGcprMPYZHHHtH2X35W33TwkodGvSxmlYZR2kkFksr2M3639
         3noZq8jDpVLhjVL71c/nnG1Pi/bR25T8+xmnvUdY1W2n09JYOQ4bGDf8hvxyJoXwp4Rn
         p0ZMpTZS2xo3HvkkZesb69eYs4mjiCW0K1SqlW8ENZfjKQ7DIWIT7rjqRgJhfSX4m4iM
         Qw0sUGOH854L/Umhz7l8G9W/LCuRIBj1QIctp4Aw3vCs82XbJuXpUvI5Z319q6qRb8MS
         rsU5gO1kw3eQkBORn02k17jhYO/kl7HwstbCLmPz/STiakzpIvGhCCkAO+mA9+sKmHeG
         1cIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535315; x=1790140115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9ZKxm5fjZ6Tz5RkeiPUJnapHxTN5p2mOK51NP1wOEA=;
        b=wovo3GYwcpexNlSWNv7XrBN092XcfWdgzj3SRIehtzw09RYIOPduSX/nhnQAokfICq
         BGsJRAGpB+jH4eUbARgq7uwCkclffonLh22HWnRPLbdTtQix/KmtqDVIFa5j5SmxI+sS
         N9d+hRiniiO6SQP11ftk8wM6qCFiHIQelL0sMGGkGrGCpudvRvFo1E5ENVFcVno9fhPo
         k9OecNGDurXbahEn2XHhZI8E0bAVZ/4m3EPOJr+30vEL+nf9s72DqX9pwRhQhkoTCXa4
         1NPUPv7pIeD79kfl6vi5GKWMmaYpYV/NFdbk304+YZ/ESts0uKsYGDOjFtxYsfSawAC4
         pFvA==
X-Gm-Message-State: AFuF++kdWuz0iFyNvQrhTh4BBrMw9vSBetmCXDJ1YL1bZyH24W/aSb6r
	fuG3vxPJu4PAqHRX+nOn6C919KB9XvHmmvw4KIFtGsqylolhgXgXvX7E/n8L6Sr+jzKpbFCosUg
	qBej+SnM=
X-Gm-Gg: AYBFou0k7B7SHNBymI6E0o7/rYa99QSzOuFTkyuHdIUXLDE26flE2SXx5rjfSbyIA2h
	ek/lseX0wouk30wE0ge27xpKzbaENYLMZDi5c4vPBV2G3YHnO2aXia5ALd1xeaNy6L6PkSO53iJ
	KTa+LyHQPEJm4EjGgvG94Pc1/4Nt/4dYymLW+91uKELFRqn+bU4IRPvntPUUbRhsWn3zgUSEdlf
	zh9leFfAxBg5Mz/2IJORYFH5J5LqAUfO0Bg9buWndExS7ALw5SDmU02wirtMAW4aDnB5/Pg1hCA
	S+h24QXc3D+59BsQBw8eCoqFZEo7mMKaQAIq2QX8JHcddCKg/3acAuqZB0/o1cZuFvepRmJ7sEW
	hvB26az+8v3SMxPjElXgwex4vwP9OMU2nBycnZPM3KX1rEqjCa8jOESb7L4r8yfRS9ketjqd4oi
	TE+pppAA/z1o0TxLxDUHJejUbe4sQxuVOXUR5TCBYe266w9iaoZ7KHVRgAqLWJKBpLOGrj/wi7v
	zhwVuNGrnR8NTkZCRD8mVmCkYHxDaoU33w9LBA=
X-Received: by 2002:a17:90b:3c11:b0:39d:efa9:cd1a with SMTP id 98e67ed59e1d1-39e1e2655e6mr3057475a91.4.1789535315262;
        Tue, 15 Sep 2026 22:08:35 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	etsal <etsal@alpine05.astextra>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 00/11] skb/arena bugfixes
Date: Wed, 16 Sep 2026 05:08:18 +0000
Message-ID: <20260916050830.8774-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: etsal <etsal@alpine05.astextra>

Set of verifier-focused bugfixes related to dynptrs, SKB
management in BPF, and dynptrs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (11):
  bpf: Fix bounds check for skb-backed dynptrs
  selftests/bpf: Test dynptr slices past end of skb
  bpf: Fix bpf_sock context code generation
  selftests/bpf: Add selftests for rx_queue_mapping context access
  bpf: Reject pkt arguments in mutating subprogs
  selftests/bpf: Test rejection of pkt args to mutating subprogs
  bpf: Prevent variable arena/non-arena register contents
  selftests/bpf: Test for mixed arena/nonarena code paths
  bpf: Track whether dynptr type is known
  bpf: Track skb memory invalidation by packet-backed dynptrs
  selftests/bpf: Test dynptr slice invalidation on skb clobber

 include/linux/bpf_verifier.h                  |   5 +
 include/linux/skbuff.h                        |   3 +-
 kernel/bpf/cfg.c                              |  10 +-
 kernel/bpf/verifier.c                         | 112 +++++++++--
 net/core/filter.c                             |   7 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  10 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      |  20 ++
 .../selftests/bpf/progs/verifier_arena.c      |  49 +++++
 .../bpf/progs/verifier_global_ptr_args.c      |  53 +++++
 .../selftests/bpf/progs/verifier_sock.c       |  38 ++++
 11 files changed, 472 insertions(+), 18 deletions(-)

-- 
2.54.0

