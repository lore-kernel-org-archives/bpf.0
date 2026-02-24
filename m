Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952A2DB791
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959920; cv=none; b=IacrkNqDzerj+gQrE35Wrn39gC1SPr1DE0H/9WJvGiphDKxqNwk9Xi0Z05UQwp9iAHVI37zSOx3RJcVBuHgtnBX7yf0UCzRHx3zj7JuDlv3LuZIOYK8b3wNvIz2MisFuB4yEG1vmsVR0O3cdW/PM91ehJKK2gu6dFQH5YqsJVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959920; c=relaxed/simple;
	bh=OCNxYDfnz8wR5V9Cv3OB9XetH+SY51hTcnZZ4pAoI5g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XCRTuzilfx6BOJWyBKiA0sgnB96ktXrbgsVZ/KSyk8/20oIxpW9tY1kvYnY6194+3gBuFb6ZfME5hj8DPmUgIfY0TYl/wLkJ2xgCBX1gkCqaOEBDP7GPcAa+owGpsYbvv4IeD5ny1AgR68XCyzILIksbDEVPI24c4aEtDvG4hgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHsjTNKJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHsjTNKJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aae0d40a47so474937695ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771959918; x=1772564718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l5d55I+UC4S2v9rGNSOm/YyhWxZHXqmfqn1568sIRjc=;
        b=HHsjTNKJTJxT8hFmU3BbJSH2Le1PqNLW2Ni/8y2S3trG8vQ+KHTAy3H/ur7NNCzt2O
         DlO0l0WZZcBjb/8rqy4HA77kfSHorYtHu0CZjUvCmJKfoz3+VuRXlzZGMf2UURnJrnVl
         CvZsbdFoauQGv1tpo47euPYcA4JvdGEzfE2+r7XqNJwkdg5YjkpHLEBuPwYcNVnvvYAK
         fy7oQcin6t58ZP/Ki9+/lay1CQKovggNCmlPLa2b4xT2QJUbYecEAKlmSQuMdmn+hl+A
         GQknNDk1flBMRy5BO3T0xIYcwdXS75BASjIzIRsC5+638uKfytwwdHK3HRmvLJGqlS0k
         tN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959918; x=1772564718;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5d55I+UC4S2v9rGNSOm/YyhWxZHXqmfqn1568sIRjc=;
        b=PF0D372hTE8Tp3sMy69KcKa2WQ8LfjSL7VcAIq0nsHxRqe83YmUcLbSdsQBZrH6FI6
         1rvHvcR0E39uh+P285PEEq0bTP8PlTa5JfUqIAPM+1hW8Uqt43xJPjpON4PK8odHXuGh
         +2hshBU3UnRK/r3n6jmHOLxLl8UVOuReeb6+aFFZZs2/3LSADjuWEyZI2Lzarj06GnTL
         uiv3vmuJgs7atHszZij5zhLEnwzVhotLcDX0PlkU+ieJ5YVb37g+Owh5kdXsslM9VOpe
         Br+aaNubYl5XQdj0erpO2PCRog1qnACYv0duips/n3BqwdYvVQa6haGjQps/aEU3pXSK
         1/RA==
X-Forwarded-Encrypted: i=1; AJvYcCXVLelxUWw9EspCK+ujaqBdfbzQO9l1poz0GVYcR9TNWsZzL0CHRcXETwvZF/fXQQZUC1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dCFVBzLsdVfOWR/d7BRhOVS+qlcC0pmUT0Uss9rQ/F5z1sh8
	aToNdIkKvHjhOm05vGOh5WVYqFs5oZQIwl8bD3DMA/yJHMFT5iKmP5ADCOROYOA9EotJMfkpDGs
	suw==
X-Received: from plei10.prod.google.com ([2002:a17:902:e48a:b0:2a9:4415:acae])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e787:b0:2a9:3396:738
 with SMTP id d9443c01a7336-2ad74547d8dmr114595125ad.44.1771959918369; Tue, 24
 Feb 2026 11:05:18 -0800 (PST)
Date: Tue, 24 Feb 2026 19:04:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260224190516.2102048-1-jrife@google.com>
Subject: [PATCH net-next v1 0/2] Preserve UDP socket addresses on abort
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>
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

Jordan Rife (2):
  udp: Preserve UDP socket addresses on abort
  selftests/bpf: Ensure dst addr/port are preserved after socket abort

 net/ipv4/udp.c                                |   4 +-
 .../bpf/prog_tests/sock_destroy_release.c     | 135 ++++++++++++++++++
 .../bpf/progs/sock_destroy_release.c          |  59 ++++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
 create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_release.c

-- 
2.53.0.414.gf7e9f6c205-goog

