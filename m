Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598963BB685
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394575; cv=none; b=Ba1poY/G8cIMfps8MfexgSjOKy1TLKxk37NVHsHc2sQZsAcs3ULC0Nvp1Shgd7PgWKEAVmLSSpneOIgetMKqz/fLPgPxSlCF1o7V735mWCC+BqhGz/leRH+5dAMu3T4JoPj0SaPCqvxaOnXkSWanlBU1uxwW37PRwW6dkP40RSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394575; c=relaxed/simple;
	bh=ZgdLdpm74cDoIxgbhtRr84Gzj/uWS/xL5orGe5R+7Cs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YZQtTs8OCjvBcdybkMDdJ+H+orijIR0Wu3ox9K6/cSBVSAWuZPoWonlgFwq87krQZuH2X4OF658sMMuVUxNyi5ztYXRoxTyMN7dUK8nM/JUOcJ9Abh8T76z3XZpNsSwkLBh1i4JTkuJuunyZ6MJX//qEJMq/mANYlfvu51xxArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=isDrroe3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="isDrroe3"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-918f75a68f0so26988846d6.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394573; x=1791999373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gmeAcyK5eqjCw4xS6BsUJ8H3lvAxc7Bdjv7guNzVZek=;
        b=isDrroe3h0KT4oozOdd0avBZ/1GghPKudCEsS1CCpXe6zf+gO5qf2PhhVEGM5YFEg2
         MvM3qi87dwFdFnlwNnL5C/8lPdsWz09xGybH8PXWIUvKIjildRZZUfvyOCQt1nHAYiOp
         ui7NClyarkYH5UTEzxs/MHDUlIh7IlQK4Gnzz7cT8AaEdcAzeKRAo8loNFMPvTfJfrkk
         1ULSsULsVG9RaFpQcrVpkvXpdRjBtTjhnK9s1ly3IHxpivtyqMlBRaOILYSTLri9KVIB
         FNuzywXgfcMK/usbzsdM+eLdng7N4nFxsob750l48JWHMZNEbkcNo82O6es7iPF7exNC
         DE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394573; x=1791999373;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gmeAcyK5eqjCw4xS6BsUJ8H3lvAxc7Bdjv7guNzVZek=;
        b=kyhyjLuOSwjWWILIPCIU7UYWIgzV+KeapuWLbB0xrecRco3r39icl4+YwVuOeyEtgE
         xGA1IKWDSI08+kSnP4rd3BW3M2MUKXADoowYiFJ0u3LvrJ5sZQThLm3551+kpx9NTIlh
         z+sk7005iXtWxig2b+OeohdArDzubJvw8XcZmTKNe11HgqvkCEYuMaGBh5iOdUsDV9t1
         DQnoydFQEunb1xS3Y/L19y1ioAd6/1DEln8+l5ts/5ZanYLod/zKR7IDTlqAou80+Oub
         0hAJ2nZkBENzbRXhsNmkUtkW9oeHJvAceCO/Csjrjrw69ZUtZ8YGyOPxu+9A6GN9MgvU
         rA7w==
X-Forwarded-Encrypted: i=1; AKwUvBx0AqCSHrCH0iUmlzniHMWg/SE8JpqJ9fNaYyGNpgRJ8eizT3EF8hsimP+c6ZlHlvCuaBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mAZzwemIP4MW2h1Kr016AvXeKxozzbi0txmzHxJKzEPCdLQ8b7
	HdLMQQnBm2HLhySDcdWYtfW05N1oKjbntdvBiZAHhjQbRJ+jYH68yjVqbyNZP2Uw/QE=
X-Gm-Gg: AYBFou3RTKu6OnATwq/QS6ZkVuKTPguNFjqg15nfp1T82I4Vd5yZ4IUMFhuVRk4o0IB
	D3XjCS9XoGlEcrN6sMng4WTAE6clLMcOeD0tjc4SDozItXTF0S1ACdrr3e0pMsQ8MYgFIR+yOKn
	BPrbFh3+6OmDNcWibV9HjNl2aJvKFxqVOBW09NpoCpYv2ackPDDJhjRpMisPIzBwsUZdRJ7GHU5
	S2gtGA/wt2TZ7QWFEVRCp+/QoyzerUXsno+zL1xZK+DjCTtPani65CZ/vGqG7GIXHigUhz9IJfF
	XZnYTnp8MsAsu5QbnW2I5wHehi21pEMr+zvsHUTUI8LftbTGYGkl7VyCV0Zt5sjbcdEV45+icZL
	rjqMP7ZK+YzQxpSxIIuGn2jk/1RfQEuGNaJq2jVTa9ltvyf2Cpu0Sx7cGJIkNik1Z/wLnM92WlG
	NWOOE/CrwM10TaKkhgrmAimDB6lEj/FtB++1bgiKGidOQrzQPqbMhmTnfL7VjDM6JL2OO26meYv
	So413FAl99gVBQ=
X-Received: by 2002:a05:6214:268c:b0:917:a16f:543d with SMTP id 6a1803df08f44-919978481cfmr59228366d6.31.1791394572632;
        Wed, 07 Oct 2026 10:36:12 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996cb5d2csm25492236d6.10.2026.10.07.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next v2 0/8] net: skbuff: replace most BUG_ON()s with
 error returns
Date: Wed, 07 Oct 2026 17:35:59 +0000
Message-Id: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGDxmoC/3WOzQ6CMBCEX8Xs2RWoRdCT72E4dOsC9aclbSEYw
 7sLePLgcWZnvp03BPaGA5w2b/A8mGCcnYXYbkC3yjaM5jprEKk4ZGl6QJIY7tTXNVLfoLNIopR
 SybI4ihzmWue5NuOKvIDliJbHCNX3Enq6sY4LccmSCozkldXtYj26hGSymj8/lmhrQnT+tQ4ds
 hX+f9OQYYoZSbmXOt/nhT5HNxrdKXtVO+2eUE3T9AHnUqLE/AAAAA==
X-Change-ID: 20261006-b4-skbuff-bug-on-b2844a487925
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=4181;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ZgdLdpm74cDoIxgbhtRr84Gzj/uWS/xL5orGe5R+7Cs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBt4SRkK3gBACGGlfQEaLW1ZvrNlcV7jUHyU5ww/iwexWbxL9OILCmzDzAn/fAr0lgrhmZZJDzI
 60fF7w6NQWwY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com/

v1->v2:
- Use DEBUG_NET_WARN_ON_ONCE() instead of WARN_ON_ONCE(), so
  panic_on_warn systems take the error path instead of panicking
  (Willem, Fernando).
- Split out the skb_copy_and_csum_bits() unreadable-frags fix and sent
  it to net on its own with Cc: stable (Willem):
  https://lore.kernel.org/all/20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com/
- Rebased onto current net-next.

--- Original email (v1) ---

I'm going through and reducing BUG_ON() usage in areas that have created
the most problems for us.  89 commits in the tree quote "kernel BUG at
net/core/skbuff.c", 31 of them since 2024, and some of those could be
triggered from inside a user namespace.

The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
in a buffer headed for the wire when it hits unreadable frags.  The
BUG_ON() conversion of the same function needs the same handling, so
it's here rather than sent separately.

The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
Each one becomes

	if (WARN_ON_ONCE(cond))
		<error path>;

where the error path is a failure return the function already has and
its callers already handle: -EINVAL from pskb_expand_head() and
skb_segment(), NULL from skb_copy(), 0 from skb_shift(), and so on.
Each patch says what its error path is and why it's safe.  Anybody who
wants the old behaviour, syzbot included, gets it with panic_on_warn.

A few don't have an obvious error return:

 - skb_copy_and_csum_bits() zeroes the part of the caller's buffer it
   couldn't fill instead of leaving stale bytes in it.
 - skb_copy_and_csum_dev() copies the frame without a checksum.  It
   also now catches a csum_start before the head and a csum_offset past
   the end of the frame, which the BUG_ON() missed.
 - skb_shift()'s second check ran after the shift had been committed.
   It moves up to just before the commit, where nothing has changed
   yet, and returns 0 there.

Two BUG_ON()s are left on purpose.  __pskb_pull_tail() and
skb_pull_rcsum() have callers that can't otherwise fail, so they don't
check the return.  Some of them would carry on and BUG() somewhere
else, or push back a pull that never happened.  Those need their
callers fixed first and will come as separate series.
skb_over_panic() and skb_under_panic() keep their BUG() as well; that's
overflow hardening and should stay fatal.

skbuff.o text on x86_64 defconfig grows by 114 bytes.  The fast path
takes the same branch it does today; the extra bytes are the error
paths that BUG() used to replace.

Testing: x86_64 defconfig with CONFIG_WERROR boots, and every patch
builds net/core/skbuff.o on its own with allmodconfig, W=1 and
CONFIG_DEBUG_NET.  A test module drives 12 of the 17 converted
BUG_ON()s with a bad argument or a malformed skb, skb_shift() through
a test-only export.  Each one warns once and returns its documented
error, and the skbs are left alone.  The same module covers the
unreadable-frags fix.  test_bpf's skb_segment tests pass.  The other
five were only reviewed: skb_crc32c() isn't built in defconfig, and
the four skb_segment() layout checks need a crafted frag_list.

Thanks,
Josef

---
Josef Bacik (8):
      net: skbuff: don't BUG() on bad arguments to pskb_expand_head()
      net: skbuff: don't BUG() on a bad frag_list layout in skb_segment()
      net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers
      net: skbuff: don't BUG() on leftover length in skb_checksum() and friends
      net: skbuff: don't BUG() on a bad csum_start in skb_copy_and_csum_dev()
      net: skbuff: don't BUG() on leftover length in skb_copy_and_csum_bits()
      net: skbuff: don't BUG() on a missing head_frag in skb_zerocopy()
      net: skbuff: remove the BUG_ON()s from skb_shift()

 net/core/skbuff.c | 118 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 98 insertions(+), 20 deletions(-)
---
base-commit: 45ad84d2800e4a092fb8d96006a533b2d0ab13f6
change-id: 20261006-b4-skbuff-bug-on-b2844a487925

