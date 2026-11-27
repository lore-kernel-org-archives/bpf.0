Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789303;
	b=LBlOP0Dpp2F4m6nq/sR0wbgfO9L7M9sg00Rv91/KNNd4pR8Tk7sgqeAbml7dd7950BKB
	 0cZvZS4MlgRPmn7tBdFoHXhQ9Pm6DTKk12RG4tHtprFRNkh5+4VqlxaH6NBW1zvRJLdjz
	 Ls45S/4XnJ4nOxfEniy9yVjy/krBjVBNsd4oD737QONGHLjX/TsybEx9UU3qriHMVnuLi
	 BBxhLJf6MI586ZOEhyCfX59Hio25OJcs8HS1c5uOrQhiafjy6/h4VSen6IP1u1FmxUfMz
	 TeEVJJgVWExute4nfXhA7qatC/Zq13W5dnkeVBTRpYi6Qm1fyYP2K6Lk+eIeBNZcEdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HE7gEqGCw4EyFiuV8uGktoGe7HLL7Xdr4RQo2bxKmaU=;
	b=kdq0CIzc9MQzrjJrNvM4CUVLsrV8zFIPtNW5LqRyQ8EaLmnhn6Bj/2Ua5NK/5gssV2nJ
	 QHiNn9sfG9ArkMXSpx5X6OCEIVuLHuZ8Tq6+RM1K/y5sJSYXrjjsIwXc9P/GTJ/bs9myT
	 sHw4o8L27Ti6jnylNwpHIWySvrIWCwh1JKiRBmL5FEK9NAHL+1g99CKupgm5cEqh+jAgU
	 Ia8gD9HJ0BUFfWbTY/Kj89Yv0tdd+UYKweOLxfLOTvmJS7DTy8kzxCsz1Z9dfNAbazeaJ
	 ExnSZkUnb6WjGuBwHQ8jja63ouTKq9c+onbUXJDIGdDAsXgEkn8KotktsahwkcLZvtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSZfoBMC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AB606A32E;
	Fri, 27 Nov 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSZfoBMC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC91F000C1;
	Fri, 27 Nov 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795789302;
	bh=HE7gEqGCw4EyFiuV8uGktoGe7HLL7Xdr4RQo2bxKmaU=;
	h=From:To:Cc:Subject:Date;
	b=DSZfoBMCSmtY1GfTC/aIsp071xWx6Mp0hDMLkQraEQDi8XJb1Dd9rqkypOU8L1psY
	 eB/vAXVvxYh1jKxDT/9Viqq1QtP9B3iC1uSoeVW8JbqQrgdN88s6KprKBUH4Ghe6gx
	 wqw9+rMaO8T2/38DOzym6kcukJMMMiz0vkyocUzAKxI4iCXlQgl/2oVSstArCKrqJu
	 qayNzLkTUVxoSA7IdZXIinv836XVHWNwDFBu7pMC+749RSbQ3+KqIlMVcHAExQWYxa
	 3YWSAnVYjz8+U+KvJz1JwGKBzqyEsNoWS3dUTHyHkepJH25gf9HhnzboSb0zrqsUAd
	 IeL4x1WxCS2kQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] xsk: Keep the shared info of zero-copy buffers in kernel memory
Date: Fri, 27 Nov 2026 15:21:26 +0100
Message-ID: <20261127142131.3527737-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A packet that AF_XDP receives in zero-copy mode over several buffers
keeps its shared info, the fragment list and its count, in the UMEM,
which userspace can write while the kernel uses it. A rewritten list
or count makes the kernel read and write out of bounds.

Patch 2 moves the shared info into the buffer pool and lets the device
write up to the end of each chunk. Patch 1 makes libeth count XSk
XDP_TX buffers one by one, as it read the shared info at a later bulk
flush. Patch 3 updates the xsk selftests.

Sashiko found this in its review of the AF_XDP device buffer layout
series [1].

I tested this on mlx5 hardware, and on igb and veth in QEMU. None of
them receives multi-buffer packets in zero copy, so i40e, ice and
idpf, which do, are only build-tested. Intel folks, could you run your
multi-buffer zero-copy tests on them?

Also for Intel, found while auditing the drivers and not touched here:
ice no longer sizes its zero-copy RX buffers from the XSK pool. Commit
3a4f419f7509 ("ice: drop page splitting and recycling") programmed a
fixed 3072 bytes, and 93f53db9f9dc ("ice: switch to Page Pool")
changed ice_setup_rx_ctx() to use ring->rx_buf_len, which only the
page pool path sets. An XSK ring gets the length of its last page pool
setup, 3456 bytes on 4K pages, or 0 if it never had one. With 2K
chunks the device can write past the chunk into the next one. I found
this by reading the code and did not test it.

[1] https://lore.kernel.org/netdev/179561567996.3135.9952128421877275714@kernel.org/

Björn Töpel (3):
  libeth: xsk: Count each XDP_TX buffer on its own
  xsk: Keep the shared info of zero-copy buffers in kernel memory
  selftests/bpf: Drop the zero-copy tailroom from the xsk tests

 include/net/libeth/tx.h                       |  3 +-
 include/net/libeth/xdp.h                      |  9 +++++-
 include/net/libeth/xsk.h                      |  6 ++--
 include/net/xdp.h                             | 32 +++++++++++++++----
 include/net/xdp_sock_drv.h                    | 29 ++++++-----------
 include/net/xsk_buff_pool.h                   |  2 ++
 net/xdp/xdp_umem.c                            |  3 +-
 net/xdp/xsk_buff_pool.c                       | 17 +++++-----
 .../selftests/bpf/prog_tests/test_xsk.c       | 10 +++---
 .../selftests/bpf/prog_tests/test_xsk.h       |  2 --
 tools/testing/selftests/bpf/prog_tests/xsk.c  | 13 +-------
 tools/testing/selftests/bpf/xskxceiver.c      | 15 +--------
 12 files changed, 67 insertions(+), 74 deletions(-)


base-commit: 28a371228d4eb4857cc31eeb1a0d7d01e9c3ea2f
-- 
2.56.1

