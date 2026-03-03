Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8B3358C2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557271; cv=none; b=dylcoEidojk0qSQSKcU91EAPTCG4H7wnIljTj7EqsOnq6+CCBxQoubXX+zLV8xj/ghqQoD44vkr9c+QWvbqVEuVxTq4HpsUU7yEOxxD88+9LszGAsPPqfUiNEvu3zn7kVE4fE/5I8+wr/2EOGmkrHNPGd9mYTzRfA9H+rqzAPDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557271; c=relaxed/simple;
	bh=BLatzjqVvtRsincIhVbebxR/E15+tJc7XPVTRhg/sOA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h6M/OzdCyiVenDPySQfn1PRBmdK7IiZj/mk3bch7m1bahHiqx8gZMtiODwkplTyQDIyc6xYupDKe6NgSIuS1nZWEfRG1oTjMqkJXtlYZ023mlBbKn0Eef2oJFbjv9Ofr2uU0w7j2TyhV1KMwtMIi/f247B9RvFJufh1zKb1qt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wBqH2qq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wBqH2qq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4a6bb316so27808595ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772557269; x=1773162069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3W9msYejfIcxyZd2zRSvO+gfVN6T58KsrkSE6malUmY=;
        b=2wBqH2qqXp70k3QpPRUCGSBNul+e6Kq29ZYea3P3cYm+xuyaXEaton5qX91wONraSj
         5vZdbdEkgi+wtGNe2vF5mtIdfCfhkzWJDHLdIE0tcO1TZmJCtIqxcTT7fv1hIo2MGzjX
         A7picmfgB5DQYvLJ+01fN7xfRjPZ+SrijCUSjqr+ufU/sQg1SMIyTGaTNjDcBoRJVmT/
         jPtxdcqgHPAXUbtOyRdtkBYQlR3Ek+BThpOJKNza9rrXqA7J9d06K8+krX+cE40hcfMO
         8QSAJcJyECLkf60j6L3RUWAIbpngVINw8MYirc1/7G8t6HnTupReKSYKAtUUfxGTx2ok
         7t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557269; x=1773162069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3W9msYejfIcxyZd2zRSvO+gfVN6T58KsrkSE6malUmY=;
        b=VQQLhQXN9mbQSAz8PtGE3J3oitWrCgVfQ16Zk+dYrcUgKSXoucAAXg2t3LLKe2RmOe
         i71e+7BjbQH7ebzL9LG3ZUlFvjK15PvcVqGM/iuBbbxCf3WzWI5WoiDoNDN9rGcTFVP+
         W1LjGeS8IcaFOtqARfb8dmtKx26mG21ZMSTSXs3I3Q0M/aJFQuyqOWJI+Hqs/CGvLkkU
         Jc00HVLAYU6fYyesOXL1swMXJcFZhUuB8bOMU/upQLue6zBpBKDVH5mB1KEnxaF4fbvj
         gVFsjtOqigd59HIdNntjm/wwx7R2CeAql+HTmBZ9ZyG/d+QxcORgHqrmZkJvxrOYG2bh
         GOUA==
X-Forwarded-Encrypted: i=1; AJvYcCVFzCxlRc4bhYxJvWWOsKiop/O5oQRpVCswqWRNmFO2j4yqAoilNYoIDr8twjeYQfUiKsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0i1GTChGVcBA+zuYHg0ZXAsmsajOPezb8xkCLNMfFevPxyM2n
	PceL8FIsRR3FaG7bZRUGQsLx8KvnFrnZx08nj5N7QsbYo7QcKnCInefFN9dNGpzo+LqnBHvU1l1
	73Q==
X-Received: from pgbr11.prod.google.com ([2002:a63:5d0b:0:b0:c70:e705:e5b2])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5747:b0:340:25f0:a9b
 with SMTP id 98e67ed59e1d1-35965ce437amr14974704a91.33.1772557268887; Tue, 03
 Mar 2026 09:01:08 -0800 (PST)
Date: Tue,  3 Mar 2026 17:01:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303170106.129698-1-jrife@google.com>
Subject: [PATCH net-next v2 0/2] Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

BPF cgroup/sock_release hooks can be useful for performing cleanup,
map maintenance, or other bookkeeping when sockets are released. Cilium
uses cgroup/sock_release hooks to do just that, cleaning up maps keyed
by socket destination addresses. This works fine for TCP and connected
UDP sockets when they're closed gracefully, but Yusuke reported that
this fails for connected UDP when sockets are aborted prior to closing
the socket. Cilium in particular actively destroys/aborts connected UDP
sockets, so this scenario can happen easily.

From Yusuke's testing results in [1]:

1. socket connects to "127.0.0.1:8000"
2. socket aborted - diag_destroy (tcp_abort/udp_abort)
3. close(sock_fd)
4. BPF_CGROUP_RUN_PROG_INET_SOCK_RELEASE(sk) runs my_sock_release()

__section("cgroup/sock_release")
int my_sock_release(struct bpf_sock *ctx)
{
    ...
    /* For TCP, dst_ip4 == "127.0.0.1" but for connected UDP
     * dst_ip4 == 0.
     */
    ...
}

Case  Protocol        IP Family  Type	        Result
1     TCP             IPv4       Regular close  Cleaned up
2     TCP	      IPv4       Abort          Cleaned up
3     TCP	      IPv6       Regular close  Cleaned up
4     TCP             IPv6       Abort          Cleaned up
5     UDP (Connected) IPv4       Regular close  Cleaned up
6     UDP (Connected) IPv4       Abort          Not cleaned up
7     UDP (Connected) IPv6       Regular close  Cleaned up
8     UDP (Connected) IPv6       Abort          Not cleaned up

This patch aims to make the behavior consistent between TCP and
connected UDP by preserving the socket destination address and port
through to the sock_release hook.

Regarding my approach:

Currently, udp_abort() calls __udp_disconnect(), but this seems like
overkill in the case of a socket abort. __udp_disconnect() handles two
special cases:

1. When a socket binds to 0.0.0.0, connects, then disconnects using
   AF_UNSPEC it needs to be rehashed as described in commit 303d0403b8c2
   ("udp: rehash on disconnect").
2. Avoids unhashing the socket in cases where it was bound to a specific
   port.

This makes sense in the case of a graceful disconnect (AF_UNSPEC) where
the socket remains intact and may be used in the future, but it seemed
sufficient in the case of a socket abort to simply set sk_err so that
future operations on that socket fail and to unconditionally unhash the
socket if it is currently hashed, thus avoiding any of the field
manipulation that __udp_disconnect() would otherwise do.

[1]: https://github.com/cilium/cilium/issues/42649

CHANGES
=======

v1 -> v2:
* Set connect_fd back to -1 after calling destroy() in the selftest
  (Jakub).

Jordan Rife (2):
  udp: Preserve UDP socket addresses on abort
  selftests/bpf: Ensure dst addr/port are preserved after socket abort

 net/ipv4/udp.c                                |   4 +-
 .../bpf/prog_tests/sock_destroy_release.c     | 136 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  59 ++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

-- 
2.53.0.473.g4a7958ca14-goog

