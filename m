Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A53E717A
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092650; cv=none; b=nVakbZSuGLXgtPNwEVVkV/WrSAz9qmG8M4CNMI7RV3MF9ex7iGwB0jKjrmXXfYHGIKPTpD+RmpMH5571in5N1+O+NXfVban02UmTPsjQXkBRwihXd0ILFxWJQM+d3Eo4aXcv4jwUWuhNDdkVRSOaBIqxKTLxBaX5/vOTDrG25/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092650; c=relaxed/simple;
	bh=Pm0SSXQemv2uh3B1C/YKpI9VqnSeLwbthTiy2vHdUlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dg4mONT8FjnjvLDmwVQm26VVlO12ddP2wyy0pk6oq2qTnB7ghVlh8/S1mj2hPrvSrDS+7VnsODmlf68gfoCuTkiq0dvAIqJ/I/ZWZuqXaDs1UmKwfefEN8xpnDcce2Wn7M+4QNilVI9G1YqfAbQ3AXKWvDZH3xOi4JEnrfIMCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPvJWtHd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPvJWtHd"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36643b96b99so1875993a91.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092648; x=1779697448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DoCMEHbqsmQR26KKm6FMm5fGobBSkxtUUIymvUejsM=;
        b=LPvJWtHdXp2vS3XHhC6maCHb/AwPvzyNCNQ6JVWLV/cZhex+3W6j/xmtc8Czotn3SK
         3OkPgf6xPVpbFSPO+EL1PVVBCWABisuSAfSzM2+4w1FyVwlcA6xuPm14J6xJOcTucQHk
         wQZehM8J7u6SfmPaSwTTVvU5fTB4XLTqe3WLjQyKkQuBNGeVHZzxPsomrx4wiex53QEn
         GUVMdwwjwD6N2K8dFxKmnEv1gCXNjDAOZ2aZfPEkt/A8mS2VkC/AzwMNjBkNbWaT8D0L
         qbV83uC2KtonkJCvh5bxJhrPsBuShOuCN2Pt7FMMurVE59QuiQCMMBwDdcHbhAzxnktJ
         CtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092648; x=1779697448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DoCMEHbqsmQR26KKm6FMm5fGobBSkxtUUIymvUejsM=;
        b=SLpMvtSXChJpghfR5BeU4lsbg6O0XWFcN7HcQaNheLaA49cy08QA8xyk2VaNA75IP+
         1kQIdFWb0hfgsFrvInrY4+cY2E9War4DDgsvbcxmSb29CzUn+QtIQ8im00FKP3M/6KBX
         WCYLFO43v7CXFGW5//SEWAIMU/Xd0nvznb63BfLoYrWHusJ6JcciW3LNDw+94BYcZZQk
         6v9bJ5RErcq7Cxoi03ur/5Cj5RzvnbIo2VmElF+j7novm9tDKVAjjshJThiy+uglZPqB
         exS4nKarwbdgjLKcMBxpQhw4MeHseVaDoJxZW5bbEWEvR7u+TZ6PNOy0cRPMtjdRSSft
         ykMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qr2+FR1YwD/abJjNxT5f9IgZ0vC7C9U8HhTpm5uPFLAP+SYTsW2qJ8lPNJ2WuzI+7x4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeaE9rhhE2mL+0U/yjDJyqbungHB1KBRrabTDGLqhwlm/oxvB
	zAnDWxUiOYq6lY7GeOwPEFE44utbmptjJU4GmR8rEwTf+8pBeaH01LAy
X-Gm-Gg: Acq92OHB5SOT/gK95EOPneMNV+LIFWPGAPvmctHFCQaJYIp18EG+1+I+6wwBkD8ygT+
	1tqq7SwG++DzSP0NzwwWX0ox1tAIyysHpsXve4he2+kX2VZtMa8UE/IKL5hMFyxlWpS73rFWWRn
	PGfiAbi/X9vdIGhysqQHZNQG276YfZv8nMzp0ejDcmFyqHF7l7r70M0WU3ZAMeHIn78LsOCeGw3
	l9s1+ooIRD5LB3aQDnn3MUuDhmCKJynSYeoT/0Thuk82AnyZv77FRGHBCZvQw75r5IFWGrFHt5r
	JNBR+jsxI2KwNFGyAiaIUUBwbBeFRT6Kw6ge1ocoE8hJKK/FA20eiurh3ueXFGqz8chqo4aO7za
	GVe81/qTUTKBX7TQO3g0f2ytTugWj9O8A7hIiEZA+FLY4Vkg2gATmyRNvcDGmwGmo3t0B0lu/jb
	GJCItaMZIx3bj4EqKMRz4VR1H65j9L3BAPFpDyWakPSXsghKfvdw3UyCgqSYz69ySrNzlxUfRNb
	z6RpyOc4xxDQ3uhQs3sQcj0cm+cTQ==
X-Received: by 2002:a17:90b:3c87:b0:369:b957:1d84 with SMTP id 98e67ed59e1d1-369b9571f47mr3798456a91.14.1779092647645;
        Mon, 18 May 2026 01:24:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:06 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/6] bpf-timetamp: support rx side
Date: Mon, 18 May 2026 16:23:38 +0800
Message-Id: <20260518082344.96647-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Previously the series[1] has already supported tx side for BPF
timestamping, now it's time to support rx side.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=68b92ac494eb

Jason Xing (6):
  bpf: Add bpf_ktime_get_real_ns() kfunc
  net: export sock_disable_timestamp() declaration
  bpf: support bpf_setsockopt for bpf timestamping rx feature
  bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
  bpf: enable bpf timestamping rx in TCP layer
  selftests/bpf: Add RX latency tests for bpf timestamping

 include/net/sock.h                            | 12 +++-
 include/uapi/linux/bpf.h                      | 10 ++-
 kernel/bpf/helpers.c                          |  6 ++
 net/core/filter.c                             |  8 +++
 net/core/sock.c                               | 20 +++++-
 net/ipv4/tcp.c                                | 14 +++-
 tools/include/uapi/linux/bpf.h                |  5 ++
 .../bpf/prog_tests/net_timestamping.c         | 69 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 ++++++++++
 9 files changed, 172 insertions(+), 7 deletions(-)

-- 
2.43.7

