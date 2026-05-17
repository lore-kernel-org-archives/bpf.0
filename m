Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162027587D
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029808; cv=none; b=ZLizj02pVlLGu5vssaklMaxQmol4Y3s6NuIiaqcJVOiLCoKwHj0gjM4w3F0en5wayAS0JwlKR0BX8KHGLWIZKMfwnCk0AS+2e8hmcBblCOYEKrWIJYKKwzQ4io1ORhIFMYOsHh/E3YCxFRBVwNwKd5zRijK+6d0kRzgAqGgWH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029808; c=relaxed/simple;
	bh=INaGmIt0//C93uZOPPIiep3TMeifrVgauwt4fvfY+yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTeU3zCNts0IYhYFNUWFWfEJWTnkvgC5kZHvWsPfrBkj3gKpfXYmLbmiS7V3vjfrR/ZxOx1XOtK91CNhbGZI+7ZcGg9G9f1h527spbvNVq3T54wUJCGi+6S+G4+gRGovloavIb6+vubGxX/8X61NzW/Tjffg2a+318FwJMIulKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5jN8EXM; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5jN8EXM"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-369002b26f4so610293a91.3
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029799; x=1779634599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7WER+JhbZ/KqlU4Zw1Oz1ftuqqMYu4Xbn9qvubzl5s=;
        b=K5jN8EXMBLZhe6vTLC2Mw+UvmuwYDYJAk/4l1MPkcWhaiLC4lEJQoCZzrTDONmvn/e
         RTkPMgukAKfgjD8oi4Zc5WcE0xkKEeUQOhT1B0xghrHvGIi9BwTBhW+koTfJ6Vkwj6BM
         cn8GHk9+36e3hxweBL8kajUU5uCd07tQTTSBHPdsn7TFe1LuWfwlvDLhEAJib+QMek/S
         qopwylK9v3xmrqDssfOc1BedhrRvYiIms8I6xGu4CCU0RO8Zi/32Hia35fBhX/8L/u5x
         4894uAgn8J1biqW1JFSiOtn4rWMKqK3qHcHvm5rly/pgOOEctWO+uxPSar/mCso25hRj
         45UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029799; x=1779634599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7WER+JhbZ/KqlU4Zw1Oz1ftuqqMYu4Xbn9qvubzl5s=;
        b=V7biufZsJtxsw5/rZyDaEnC2nAKayRyhhK43L32YhDzl93NovoDGUkfD0jroaHLJgY
         w0eB3GquJO8S/UXOPSu3CLJbzWlf+DF5Ip1RIrtWDnjskRQjyYEXtGVWh6z+Imv22vRI
         CN6gszrX6c4W8jySg63G4WHFjMr/Ozz410c7iOc7o8eRi1jg0WwLxSqSx95tUcDtvong
         ePee/ggfADevkNI5d10tVEBj65CDG1CNsrSywAFeHi9flnunK53k0HIqQ0ga+Ftnyb6K
         QNP1jSSnpQfu7iRf7KrQjPbV1thB/6a3dEOP25g+1ESHFraQbiJk5zzmb0pbmXMDB1k1
         eHRA==
X-Forwarded-Encrypted: i=1; AFNElJ+MQbPWKLSDJQ05/suhbIyd9pOMVeAQ3xeWIcWJXGiJDfpg/iP2+texFz3iYGektIWEUcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfohVEOllDySbqiAiM7Ej/4V5zT7DRWWfhAoFMxMDFLJo4Uapg
	EQQ71A7/unREu/LQfDhil2tB/OZR7a1gkMXTRzBx89I1HwI/rTgNKDBw
X-Gm-Gg: Acq92OGuvDEj9qfhPJGLNqfi+fdKFKCQq+oc6K07nzpKAp1vw8mlAwXn9tSIbt0boPI
	zYWDn1szRwbm9PUlrWo1hz71qB6U5HsPFMn7cS3Y910t6G6wKiZcbN2PO34yo9LWGXYmXeQaLgL
	TSuxjW3ljJuy3+I9QuVjTmf0ZqFhVbG/yfE2etdOEERZgjhauIJeZpnaCNjC0e/nKf1NOp7ssJn
	YUDDkmA3gPS/4Uhnd/jKF2nTrk3zNBvY/tNBVQZHxKCXph+3JUlIynk2c8/gW3GssEks4mIq8nJ
	AiSStt+ygYh0M7RbRz862TvdpE9OJH0s0n+rkyRh3ErLZNEMB5KUCCE7YbzDcXVstKaBLRH3iXE
	oUrawieZCWTNvMot6Mo4BRSD4mx4Dt6QOWuvDmuRLjFgnDUyLre/VUwlXgzbKwOaQ9GwjJiUZ9i
	gYv3mSLOIaY6xA1zkgD6DfRdwy/sH8o5cLKc8=
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36951895b57mr10465826a91.3.1779029798633;
        Sun, 17 May 2026 07:56:38 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm10392522a12.21.2026.05.17.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:56:38 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	mrpre@163.com
Cc: jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v5 0/2] bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
Date: Sun, 17 May 2026 23:56:25 +0900
Message-ID: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sk_psock_verdict_data_ready() lacks the tls_sw_has_ctx_rx() guard that
sk_psock_strp_data_ready() gained in e91de6afa81c.  When a socket is
inserted into a sockmap (BPF_SK_SKB_VERDICT) before TLS RX is configured,
the missing guard causes tcp_read_skb() to drain sk_receive_queue without
advancing copied_seq, leaving a dangling frag_list pointer that
tls_decrypt_sg() walks — a use-after-free.

Patch 1 mirrors the fix from e91de6afa81c: add the tls_sw_has_ctx_rx()
check to sk_psock_verdict_data_ready() so that when a TLS RX context is
present the function defers to psock->saved_data_ready (sock_def_readable)
instead of calling tcp_read_skb().

Patch 2 adds a selftest that drives the vulnerable sequence end-to-end
and verifies recv() returns the correct decrypted data.

Xingwang Xiang (2):
  bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
  selftests/bpf: add regression test for ktls+sockmap verdict UAF

 net/core/skmsg.c                              |   9 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 103 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  21 ++++
 3 files changed, 131 insertions(+), 2 deletions(-)

