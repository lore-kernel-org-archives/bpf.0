Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1A39DBF2
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601131; cv=none; b=WsozthNqKXQJN4/CwqMCISJJLaBw/hAegvWSXSAiXV0F9XPqY0vxy+RUQTh0ZxPqEH4COU/gvLbgf7usETf60O3nGHGZkXS+P/hxszL5j3eCwtskz2oa1l7VFr83Pd1SmbZiUKu7jp/zsj1e2rzUlmRiJfZ89Trc+qXKG+xIYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601131; c=relaxed/simple;
	bh=OLrKwtOMAAXc+cn4sWKdPlWR3wyVQ6X+l83adwNoANE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lp7ruiE0cn4JMmMxNt/QeDBT9ZK2Oq4NVB8dj9tIJKngbj1YLw7ySfvPmWGyFeOmOcvHfsUvmvt5dtVQO6OijhGmev9TWYEkAPCDGy1EF8Mwfi6EW7HWAWLYhBoqNPEIr0Dg5Qt3vdTz/s6ZJ2sUt3tCasJpHdFGGcKGctqxNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wa/ls78t; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa/ls78t"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f869421so3429734b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781601129; x=1782205929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCMlAj/PQW48QlYO1ogaZDvkUzT5hyp9HL1ZWQeHJVQ=;
        b=Wa/ls78tFOo1qzCj0oCRILESDpCXDR+h6xSJg5/l2VdBMETLiZn1gUm+h+RiRREdK+
         AfDtcW986iAokSUUTfiMKvFwwYUYtzHt5VH2ucUg2a0LEJ8brKpjOT/2ysJec+/7w5Te
         MxJ5Rc95clxinK+O8EeQ++qAB9RrS6zM4JfsE4Nh+1KRGblDIzd2celhNqmEU8uLv7l7
         bc+p8fE2B7BBoUFkbVsWLsk4/aWvO6hmOllDFHLDechHxlx0L9yre6PkhuuN07c7O6T5
         Kyrgy6KnqylWW7b9a8JM9q5tTt8O/yavvjb2SnlPJSx3p+qemuZA/G74Pn/Tdac2Ptcf
         YuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781601129; x=1782205929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCMlAj/PQW48QlYO1ogaZDvkUzT5hyp9HL1ZWQeHJVQ=;
        b=LANQ3ztmmT+1q1vDslmE6wKL73zcc72oCX8gsK9FyxQgul+yvzhXIqI4fObrIEtWKi
         DRaBlUi6UlgA26SFkhtclvXPme6aqCel+B4cU4rEKeGQJR/ZVaTHtd41mQHPdN7BE31h
         NHH6qSJDfE3Wja6YQoS0acW2wWuvumhKHKo1ZMYXFnjjlu/Fh4Gfd1lNANkF8RQtXzn2
         2XE5ZxAqDx65aUn0yBgkmpF7eiRcBSAZET1RbS/3UhvBTJYOSsPTmfOvCfWq3tKPN8RW
         vDUjRWelsgwTk+NaWMWUHjf7czdPIFwj4kwpQuDQU89UlRcy52Qx7Y6N3IKJvCm3Oh92
         L0FA==
X-Forwarded-Encrypted: i=1; AFNElJ9Y85vJM7tPEHnWf1DSFU0K62UbruFR54aocW4wrEx7IWiXubk43PeKlNxch3YN2p/DABk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64kOwv6fJmuq5pI+8+k0d4VbU0q+Z4kZpsD/PQFjpAZAiJC/3
	FVNCl0mj5jcE5lMJfOAeqU18JvPwlEsvdsX7wuOP/SdqpyKKJeXSgzbI
X-Gm-Gg: Acq92OGkL1QnPWonIO7B7SeVwKLpC9p24d1dXto8gcqCE7JhHrvyFj+CcZM5YELBkqM
	j3aNBo5PbJcGdzyy6VDpf90DOaF+e9kRe5TSIRSt1C3n59ijkqG6WRq/QhJL/pJMc1FAc6Y6lLv
	6C5snJoepZ1tyiU4ZB9ms4CPXxzF+2oOVS1HSlWAuldxiQ1zaItpvhUY4RlaC8vlMj1qi5op1b0
	+4ERGWT10yW/DEqbrd9/PKWNxBjaLOdv8evOo+DdTqxg3Q/Dfjz1y4X4qew/8pev9WNrW9nwZ2J
	EORxc76keEO0HK9MWPkSSXz/nbQIgLN77o6rfr4PFsCGfYy6+qYS/kZuxyLyX3WCDrsS9s6JJYE
	5SGZMIDL/aHyug93x9yAXQvLFR8R0l6GYIKoJc4LXua5yHjPYX112fRk/H3AEaJflpAjLZTDXcw
	CMcMhLjxtF/ctFQj/0m9S/nT8/JOZzuJL1ogH2k37FH1kTRM0n7FDejTwZEsbMpQ==
X-Received: by 2002:a05:6a00:804:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-844e1a2f1b5mr14917312b3a.27.1781601129475;
        Tue, 16 Jun 2026 02:12:09 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acf23a7sm12026478b3a.22.2026.06.16.02.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:12:09 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock and sk_callback_lock
Date: Tue, 16 Jun 2026 09:11:51 +0000
Message-ID: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_map_update_common() and __sock_map_delete() hold stab->lock and call
sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
sk_callback_lock for write to stop the strparser and verdict, giving the
lock order stab->lock -> sk_callback_lock.

The opposite order comes from an SK_SKB stream parser. On RX,
sk_psock_strp_data_ready() holds sk_callback_lock for read while running
the parser. The verdict redirects the skb to egress, where a sched_cls
program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:

  WARNING: possible circular locking dependency detected
  7.1.0-rc6 Not tainted
  ------------------------------------------------------
  syz.9.8824 is trying to acquire lock:
  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
  but task is already holding lock:
  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173

  -> #1 (clock-AF_INET){++.-}-{3:3}:
         _raw_write_lock_bh
         sock_map_del_link net/core/sock_map.c:167
         sock_map_unref net/core/sock_map.c:184
         sock_map_update_common net/core/sock_map.c:509
         sock_map_update_elem_sys net/core/sock_map.c:588
         map_update_elem kernel/bpf/syscall.c:1805

  -> #0 (&stab->lock){+.-.}-{3:3}:
         _raw_spin_lock_bh
         __sock_map_delete net/core/sock_map.c:421
         sock_map_delete_elem net/core/sock_map.c:452
         bpf_prog_06044d24140080b6
         tcx_run net/core/dev.c:4451
         sch_handle_egress net/core/dev.c:4541
         __dev_queue_xmit net/core/dev.c:4808
         ...
         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
         strp_data_ready net/strparser/strparser.c:402
         sk_psock_strp_data_ready net/core/skmsg.c:1174
         tcp_data_queue net/ipv4/tcp_input.c:5661

  Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    rlock(clock-AF_INET);
                                 lock(&stab->lock);
                                 lock(clock-AF_INET);
    lock(&stab->lock);

   *** DEADLOCK ***

sk_callback_lock is an rwlock and the established side takes it for write,
so the read side cannot re-enter once a writer is queued.

sock_map_del_link() uses psock->link_lock and sk_callback_lock, not
stab->lock. The socket is removed from the slot with xchg() under
stab->lock, which leaves a single deleter owning it, and its reference is
dropped only by sk_psock_put() in sock_map_unref(). Release stab->lock
right after the xchg() and run sock_map_unref() outside it. Do the same
for the replaced socket in sock_map_update_common(). sock_map_free()
already unrefs without stab->lock.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/sock_map.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 99e3789492a0..390bd5ee46d4 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -421,13 +421,13 @@ static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 	spin_lock_bh(&stab->lock);
 	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
+	spin_unlock_bh(&stab->lock);
 
 	if (likely(sk))
 		sock_map_unref(sk, psk);
 	else
 		err = -EINVAL;
 
-	spin_unlock_bh(&stab->lock);
 	return err;
 }
 
@@ -505,9 +505,10 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 
 	sock_map_add_link(psock, link, map, &stab->sks[idx]);
 	stab->sks[idx] = sk;
+	spin_unlock_bh(&stab->lock);
+
 	if (osk)
 		sock_map_unref(osk, &stab->sks[idx]);
-	spin_unlock_bh(&stab->lock);
 	return 0;
 out_unlock:
 	spin_unlock_bh(&stab->lock);
-- 
2.43.0

