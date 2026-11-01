Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560861;
	b=NJUFP6zSR8BvSfbqbe8K2zATU1ZYlnhWa15gJUS9mhCmDmyNotXiKbbO4B54GfZpMJEW
	 SCZmsPXQ2zcMKUSy2lMbwjXAhP+YRwntpvArO0g5or11shX7HyeOltzSHmolmSXbe1uOM
	 tq5KJu9Tvsp7VnG4XrCl592Aaq7W1VzacDYBmiiMx0uCN/gXOc0CkWJCCr7khLwsgxEv8
	 cVCjkfoNJSk7CVE2wiprBeE/VvjmBI39BxteZfiupcis+APZe5GjZ4KagGHoha5kHzJ+E
	 sCVT5G3xOclAsySCaYEr5yDl0mxLtzc+xt8uw3Bq0KMz5kOb+Pq2dKcgOwaT0cz7IAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
	b=sxx7B8WNRmUTlyNbI306rW9kY+G5mUzoN0RKguaTDYJkKmE42atdg5UxvDyr8c0yD9pF
	 kXX85F2DkuvCx3u3HxH9YTzTELO2o9QwHdNN6bwpDnDQPq/SXAd14GRwnuvjFkL0au9b0
	 R+ZQcXnsgxv8W/tVX1tlwL1ayGL125AtCS21imuRujFeygQD5CtfPcv6YepAVtvi9RmG0
	 6mMxLULL2/qz18b+v7L208fY4L9mLv+LNfqstkobwQX02KozGMjYunRtCCKg+8d73u2vc
	 ibpFys41T0bhjbxhRTnec3dbhCwN+krpDma89DTYktKyVvIAtJkt67IXplVrO3AfUgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7r1Pb0P;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9C606A325
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA9C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7r1Pb0P
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so953515a91.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560861; x=1794165661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
        b=G7r1Pb0PM8rKvbabZG6DbUaHrypMYxZIEigHQRNUZCKYZjRfQ0WRO5sZ6lr3XGqnT1
         edU3+biJcSM4yJNPLx50J7uFtFqDxEb+GFxnGSBciBokdfKTYjaRGW1KlVI9yGkVZFIU
         pdfCopUucfGlW2Bss4OEuWrnSEhiKHjIx/FM1qVmbqJ5d0J07EJ3OpuOty4yf133VOl6
         se1JvscppLBxRPyHRQTM8IIENG4MqK5C+k0fmy6WhURdpjEK6gLG12LWlqPupqAMpCTa
         nJqO2iXQF/mxo9QV+v/69gXFvAiOMvu+EWo7j5NXrECeHisdT3CDkOnwwrkMhxSyhhTe
         JHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560861; x=1794165661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAeiSOPaaWkQBppOUsktRtMkprnZmaPxcUrEefFlWVc=;
        b=1il1uCYQx2E/1jIKo8n3Sz1pKcqkt1DMVI6ThDYdvIwhXqOWaQ42+qLzxl+rZ6Kijm
         nmHu2MK1Boa4VNHmDc3ayezq5dXW61VE6Ah9RBKdSdcayhBtpXNaHV1jCEttFbFZfarT
         ZXxP3GP90rK4a/udcdYEcG+jrxpVXwLudHwqqxGA93vynyVnoSEjc3o+VC0lRZOblCnW
         JDmwsaudFFTLtdRcmJ1f+76OOruJMszob+3cuD4c71X40OSubuOJzdIxAEloG/WUe7Ir
         3kKoNHAVFgMbRP8MypVzW2yZyvJWpeXsFIK1cjNXgWyb/+dOT4rQ+wxy2tzXaf4PiNn6
         YaAw==
X-Gm-Message-State: APuU4Z/5LVe71iGYbecSczHUoOADwnUq85b1a0CvpeLbs49HE3UpbXlD
	GX+n8yq86zgDXdZBN25aoC9yr6dBXTmQMVmwkm2Asy4zeql5bhQtEKz3/P3JmA==
X-Gm-Gg: AYBFou3H8zK4bkY2lxRWB0ptSDUHz7voB/ynXFd5zmlxGBhkzUsqwpgGAxypXtmGzF8
	sI10S8RHE7V82DoUSQg1wosCs7fIU8WR2wTo/1DGAOyNQmYeMtVt9H2VvdagyDl85tFKTJshkif
	yBFgxsQCmLoUKRT5Jh0MdikKMYDuxytgMKfahQXZLyy6tE1/v0htMn+FMVuTjjq+joQNearFQx7
	gt9vCkrFfYsEWJ8hMN/LN9iEg7bcS0whSDwfX5UlDiDcgaw8z1n21oW8uvEC1NOcRV6jZ2hzJAs
	qCdiSyobsj6n84GERZytH4sF0gFw3/vjyY1sCj8rvtNQDbDl4sFN6UYoKA4meJ8fKJqL2hdpp1N
	rcOM7k+Qtr7QcjIu9X6P+WtbkGyfY13mo/960z3ZBkngl7/8DxCUo02DVgFasV2j96JMO2EbnCQ
	/V3+mP3ByTCnzmpmKIQRzyEoBoaZBy6Y4Gf93xbFSd90J5oN/HuDuwvl6sXaDMp+I+MEU6Ssvc3
	/HNYcHlNwdBYecTyggthWJZTd7kpTLqIB/gpRSq5eFhqleTdfRNNaqlgVpaaaCA2pj9GjAM+XRF
	91YtsT0A8HDdtFFLCoDBCrXrVgQBcHs6bHY3o48IvjZVqQ7nSNFI4V6Kwl9F6kKE8Lk1dhFvhg8
	WmUf1JX3IQH7tBDM5V4oo8czbkPQm/1IZbVlU8ptnfsNVzw2oqa6sk3OksCBmDUp25NbKsUC20A
	==
X-Received: by 2002:a17:90b:4a02:b0:3a7:9e3d:b3 with SMTP id 98e67ed59e1d1-3ae8987e31dmr6107376a91.66.1793560860808;
        Sun, 01 Nov 2026 11:21:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm11157692a91.10.2026.11.01.11.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 00/15] bpf, sockmap: Fixes for verdicts, redirects, corks and recvmsg()
Date: Sun,  1 Nov 2026 19:20:42 +0000
Message-ID: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

These patches fix bugs in sockmap:

  patches  area
  -------  ----------------------------------------------------------------
  01       recvmsg() after a fault
  02-04    the verdict of an sk_msg prog and the return value of sendmsg()
  05       the backlog of a stopped psock
  06       TCP listeners
  07-08    the target of an egress redirect
  09       the TCP state in recvmsg()
  10-14    corks and the redirect target
  15       bpf_msg_push_data() and bpf_msg_pop_data()

8 of the patches are from Chris Mason and Josef Bacik.

Patch 08 changes net/core/stream.c. Patch 09 moves tcp_can_send_ack() from
net/mptcp/protocol.c to include/net/tcp.h. Patches 10 and 15 change the
sk_msg helpers in net/core/filter.c.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (7):
  bpf, sockmap: Don't let an SK_PASS verdict cover the next message
  bpf, sockmap: Subtract all dropped bytes from the return value
  net: Leave sk_stream_wait_memory() once the socket is dead
  bpf, sockmap: Clear the redirect target before the sk_msg prog runs
  bpf, sockmap: Check that the redirected message is the cork
  bpf, sockmap: Keep the rest of the cork after a redirect
  bpf, sockmap: Clear the end mark of elements added by push and pop

Chris Mason (5):
  bpf, sockmap: Give no progs to a TCP listener
  bpf, sockmap: Check the target of an egress redirect before each send
  bpf, sockmap: Check the TCP state in recvmsg()
  bpf, sockmap: Reset the copy position when corking
  bpf, sockmap: Don't copy 0 bytes into a full cork

Josef Bacik (3):
  bpf, sockmap: Write sg.start when recvmsg() faults
  bpf, sockmap: Don't let an SK_DROP verdict stick
  bpf, sockmap: Clear the resume state of a stopped psock

 Documentation/bpf/map_sockmap.rst |  4 +-
 include/linux/skmsg.h             | 19 +++++++
 include/net/tcp.h                 |  6 +++
 net/core/filter.c                 | 17 ++-----
 net/core/skmsg.c                  | 13 ++++-
 net/core/sock_map.c               |  9 ++++
 net/core/stream.c                 |  6 ++-
 net/ipv4/tcp_bpf.c                | 85 +++++++++++++++++++++++++++----
 net/mptcp/protocol.c              |  6 ---
 9 files changed, 133 insertions(+), 32 deletions(-)


base-commit: 5b96632457e4ccae88ecb751cf48176b2e3629a7
-- 
2.55.0

