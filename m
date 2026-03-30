Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E293A784B
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907833; cv=none; b=Dd+sHBHPLswyjwlO/S7H9rBDwMgtBwKgQeLfnR1E3OTET6qUwfm9uLUV2IDLNlJr7ioReOFQKpDOClalfQSfRRbHf7jekXLkNcTg2nG5famfblHchY+0mO0gllgDERHHGb9iL82CS0tDOyuQxicKy5Yc7pEldKy7yKUdmU7KSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907833; c=relaxed/simple;
	bh=TUABFKh2Cj1ynxKxcSeh4gP82eO8t3Tm55gdX0npR7I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bcc2ZhD+wNsgFSQjFLUKN4/Oa4ni++Rj5m5Mloq31LRUFAZ72SfSnzRyyVsYjjPvqCPQxH9dIomJ2YC+N6gBrucMBLnK4bpHr0GP/cCCz8bKRhBJ5R9ZEYFY1C3Gjs1uTjF5nt1yUs2jPUkNM3gco9nfdhk27pr4iNKDDmw9UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUfXroDu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUfXroDu"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c73781252edso9712899a12.0
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907829; x=1775512629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ezkx37vFhwxIuITDyGC8lYQPdysOgwQvvO9b96vUlI=;
        b=IUfXroDuGiPXn9rzqF9N3rBOWdaiehmgv7d9j9QVaCy9T6Ssy+Zdi4r6QrljL3cSWb
         ltl/tzxnDSxln/vioyoo9uIfUwhtiPK1G24lpVOpRHVFRVq9ehnteLZSRrnmlIDj6qYP
         WE5JDgqV92tv5E6BqY+aSZYsoB23qILgmuwieWsvCFlixFnK3yk3qsOoGOOSN5hrMEW2
         FXx8we029RFPRd1Z3jVDYsNH1JicxMfCxuSrOLJHmzorYNEVz3QR0B/8qkpggsv+9X7j
         eqUStduC9Al+OufKQM8WLBguEf3vPI2MxTjj3+UlKzyG476pkM3chD4OiP+8TAsvBRrl
         3Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907829; x=1775512629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ezkx37vFhwxIuITDyGC8lYQPdysOgwQvvO9b96vUlI=;
        b=RAcz4YQQT3h86p2DG8zBpXKTyAEkb0jD5M9i0RvGYFMO0QHFG2pr8zH7hkmz9kEN0G
         8wi0nZm795qagfPmbw5Q1dERYWmo9hmngNlGurc4rfI8CXF1Rpoi4WgsgkgK6lJIa53M
         qGcCdU1MhA+P8tPy/y/IdSmGAN0nHCWgHhVuCe0jGg0G7dxLoYWR9zBemnv3ZO3MLjC8
         Z+w0/9LinEEGxyIEdv2R3PhHvN0gYilnHfPF2kASrieRxT8HtMm1S+ZA5FqGXqU7PRf/
         4L7VQpg2w88g0sy9V/1dm6NoSq5HxkT7EzJmKXmuLK0o+YIGUZpOB7zO72pjoE1eI4NH
         FgNg==
X-Forwarded-Encrypted: i=1; AJvYcCWf4aQ2vUuzsQ9V5nfRHnobHYI1DnYx3zj2E5vlM9OAOnwAzCAprZhlKktc/OGntfqxkN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYhmy59YcFWkqozX4s1/SZONMGztDyQWpymkU4lKCnwQXWj7V
	+dQ0iLoRrVGlT3rmBYcMcTUwJujOHu/ARiC/t5hwmpjBdPHLm1tYE6c2Nl7n+Mp/jW7qerePPhw
	Y/g==
X-Received: from pfbif10.prod.google.com ([2002:a05:6a00:8b0a:b0:827:45df:8f74])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3698:b0:81e:e09d:2687
 with SMTP id d2e1a72fcca58-82c95af13f9mr13335495b3a.1.1774907829135; Mon, 30
 Mar 2026 14:57:09 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-1-jrife@google.com>
Subject: [PATCH net-next v3 0/4] udp: Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

BPF cgroup/sock_release hooks can be useful for performing cleanup,
map maintenance, or other bookkeeping when sockets are released. Cilium
uses cgroup/sock_release hooks to do just that, cleaning up maps keyed
by socket destination addresses. This works fine for TCP and connected
UDP sockets when they're closed gracefully, but Yusuke reported in [1]
that behavior is inconsistent following a socket abort.

From the perspective of a BPF sock_release hook, the state of sockets
following a socket abort (udp_abort, tcp_abort) is inconsistent and
surprising. After a sequence like the following,

1. connect(127.0.0.1:10001) or connect(::1:10001)
2. abort (diag_destroy() -> tcp_abort() or udp_abort())
3. close() -> sock_release hook runs

, the state of the sock_release program context differs depending on the
protocol and IP version.

   +--------------------------------------------------------------+
   |        Configuration        |           ctx fields           |
   +------+----------+-----------+-----------+---------+----------+
   | Case | Protocol | IP Family | dst_ip4   | dst_ip6 | dst_port |
   +------+----------+-----------+-----------+---------+----------+
   | 1    | TCP      | IPv4      | 127.0.0.1 | -       | 10001    |
   | 2    | TCP      | IPv6      | -         | ::1     | 10001    |
   | 3    | UDP      | IPv4      | 0         | -       | 0        |
   | 4    | UDP      | IPv6      | -         | ::1     | 0        |
   +------+----------+-----------+-----------+---------+----------+

For TCP, the state of dst_ip4/dst_ip6/dst_port are preserved. In the
case of UDP, both dst_ip4 and dst_port are cleared for IPv4 while
dst_ip6 remains intact for IPv6. This can be confusing for users of BPF
like Cilium where a sock_release hook makes use of these fields and
expects them to match a socket's state prior to abort. This series aims
to make the behavior consistent across the board to eliminate this
pitfall by preserving the state of dst_ip4 and dst_port after an abort.

[1]: https://github.com/cilium/cilium/issues/42649

v2: https://lore.kernel.org/netdev/20260303170106.129698-1-jrife@google.com/

CHANGES
=======
v2 -> v3:
* Expand selftests to add coverage for scenarios where a socket is bound
  and connected.
* Simply unhashing a socket in udp_abort() as in v2 immediately releases
  any ports the socket is bound to. Instead, the socket should hold onto
  its port until it is closed just as before (Kuniyuki). v3 employs a
  new strategy where inet_daddr and inet_dport are left intact in
  __udp_disconnect during udp_abort and bound sockets remain in the
  primary and portaddr hashes just as before. At the same time, the
  logic in hash lookups is adjusted so that inet_daddr/inet_dport are
  ignored unless the socket is currently connected (sk_state ==
  TCP_ESTABLISHED).
    Kuniyuki mentioned that performance may be a concern with changes to
    logic in the fast path. I've tried to address these concerns by
    testing the performance of udp4_lib_lookup2 before and after making
    the changes.
v1 -> v2:
* Set connect_fd back to -1 after calling destroy() in the selftest
  (Jakub).

Jordan Rife (4):
  udp: Only compare daddr/dport when sk_state == TCP_ESTABLISHED
  udp: Remove disconnected sockets from the 4-tuple hash
  udp: Preserve destination address info after abort
  selftests/bpf: Ensure dst addr/port are preserved after socket abort

 net/ipv4/udp.c                                |  47 +++--
 net/ipv6/udp.c                                |  18 +-
 .../bpf/prog_tests/sock_destroy_release.c     | 180 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  56 ++++++
 4 files changed, 278 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

-- 
2.53.0.1118.gaef5881109-goog

