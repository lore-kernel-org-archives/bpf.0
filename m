Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093315478D
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716760; cv=none; b=JtzHztzw/ajyKoJXzEn/xo5G9eNZMt5LiixFNYRek+0y5f0looSPAj1VsllpofqDGzl4tXTaIzetrb9Sf/3g0x2qvMLO0M1fDKjlBFYCMbkTjP7U72wp7+4u3LRVbNXb4CEqlgkFt90JyfKl/mFsgckZpDtl9EykX6M8aIzl5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716760; c=relaxed/simple;
	bh=UnRv2kJQ1JRFuj0LmylGhr3hYfhCjC6ZpVyTyO8dyzA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=StJBDQXAH8tjR4Ok2V/SaGIpfnNPP2HOCE2Rscf3ClJy9Mah4S04bx3NCGMpaTVl/aFVTpqqjJH9T1R2u4DHovdZJqE3/tixGV8O2q4k8bBp8UZtOFOfL8JpslY9tTL71Og4kOj7xA9BtbYFDeJKkXbNeznTEYYcjLnzen3SyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3mx8bJz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3mx8bJz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3562bdba6f7so21505802a91.2
        for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716757; x=1772321557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3oo5WYv92eSKemLtXmzpyJfmU5CKEG9EoCH4o0pkRSM=;
        b=Y3mx8bJz15tOTmtI6WHO64/CEgnKJun9MysaaCckEmE8k7274d6bEYxFmazDQSRfVU
         k7bJZgDiK7QJj0zkaXmRGuNVQRUjUyQEEe5L88dCFwojaUM4ieDUH8tisFcVffBDktEn
         mcgWTyUvBpWtIPcKdFHwzUpn30LR++UXgMSuMvDPerCoceHp2PoI0Z2kZFvhM3mXNfsb
         hGRAT+O18Wo8OV8+XXE/T8T23Dvj/3G4C+kDHSBez8xV4/emF4CP25mr37y2OVlNtWKz
         a46RekAF7EPYPFvM/mMXJ8POUUtnjfLaitSqVXwy1nntpKPN4VaZwNoY46C30tbH3HFu
         Jt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716757; x=1772321557;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oo5WYv92eSKemLtXmzpyJfmU5CKEG9EoCH4o0pkRSM=;
        b=eiwQb9ntb5oxYc2v7DeDNzbAttCQ+Jznu+dF86mq7r0OSD/gPo5/1FiuQf5PqePKUU
         xGuilnX/z9qOP4OfWhr56IH9nAAcZW+XNdpBWMql1Q9iHDtPPd9K29UWsS1b0VcDU/fw
         BKTM/g1BN7qrnOt9eMnkHBydNMTXOgmw06XxrAitjW96t/9ivtHXfCwkOPoyjAMDVEdI
         WlPZGAKmdC3Zd9/DjBwFSaV4LspXgbSRm/Eb3LrNZApclFB9CwLqOITv5eB5GuKAO+2D
         eWTfRfSofHbbmGurLaEDsI3YRzsG4nqziHRCt2bq+dkh6AMiiGEtf4DuVAywqCjGdcU8
         Touw==
X-Forwarded-Encrypted: i=1; AJvYcCU+xroBHdTQPGfGO7xm3muwaYgOIK0at5Wo0wGRMvqD59tfrP6813ryEdi1W3yZiNf2LBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9j9v16u6i26jwKiBHVwNMVb90ppx8f+rnYI5KZ+GvcbpypSw
	/WAHHAV8lyWh4PwHdkeVvhufpQoYhDfg2iWby5HGb7Nhn/TsBI/17qd6wrGenQmFaHjP+33QAz0
	t4B9n1w==
X-Received: from pjbcf11.prod.google.com ([2002:a17:90a:ebcb:b0:354:a065:ec58])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4987:b0:349:2154:eef4
 with SMTP id 98e67ed59e1d1-358ae7c86camr3321615a91.5.1771716757214; Sat, 21
 Feb 2026 15:32:37 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-1-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 0/6] sockmap: Fix UAF and broken memory accounting
 for UDP.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported 3 issues in SOCKMAP for UDP.

Patch 1 - 2 fix lockless accesses to sk->sk_data_ready()
and sk->sk_write_space().

Patch 3 fixes UAF in sk_msg_recvmsg().

Patch 4 - 5 consolidate sk_psock_skb_ingress_self() into
sk_psock_skb_ingress() as prep.

Patch 6 fixes broken memory accounting.


Changes:
  v4:
    Patch 4: Don't pass gfp_flags and instead change it based on
              take_ref in the next patch
    Patch 5: Fix memory accounting condition from (skb->sk != sk) to
              (skb->sk != sk && take_ref), the cause of selftest failure
    Patch 6: Fix deadlock when requeued

  v3: https://lore.kernel.org/netdev/20260219173756.315077-1-kuniyu@google.com/
    Patch 2: Use WRITE_ONCE() in udp_bpf_update_proto()

  v2: https://lore.kernel.org/netdev/20260217000701.791189-1-kuniyu@google.com/
    Patch 2: Cache sk->sk_write_space in sock_wfree()
    Patch 5: Keep msg->sk assignment
    Patch 6: Fix build failure when CONFIG_INET=n

  v1: https://lore.kernel.org/netdev/20260215204353.3645744-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  sockmap: Annotate sk->sk_data_ready() for UDP.
  sockmap: Annotate sk->sk_write_space() for UDP.
  sockmap: Fix use-after-free in udp_bpf_recvmsg().
  sockmap: Inline sk_psock_create_ingress_msg().
  sockmap: Consolidate sk_psock_skb_ingress_self().
  sockmap: Fix broken memory accounting for UDP.

 include/net/udp.h  |   9 ++++
 net/core/skmsg.c   | 100 +++++++++++++++++++++------------------------
 net/core/sock.c    |   8 +++-
 net/ipv4/udp.c     |  11 ++++-
 net/ipv4/udp_bpf.c |  11 ++++-
 5 files changed, 81 insertions(+), 58 deletions(-)

-- 
2.53.0.371.g1d285c8824-goog

