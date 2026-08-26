Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C207466AF5
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761285; cv=none; b=poTpb3n9j9O3fbn2zO2yVbgG2KvPZE04NNH9+EHjTg2BTGZbGG11+eE0pGGmB0uAp9SohiSUrd/GjCmWMP/yOdLsAh+DNVVOXMFdzGJ46oi2UxjH/SUnER80WLqXe/8jsMbM7olw72iifvTeD3nv8a9AyJc8WRkQ5xdu8dhbE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761285; c=relaxed/simple;
	bh=pvjWpnlTdBZKx5UqOCq9/dEYrGv5OCu+9mtstfD1pFA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=thCn6/BcIsO+VMVQFFxGQJOG5bS4sE1wCIy+tja1zS6KAMyrs+RZVdekWrchkIUQLa7Zh9VNBQlq+EzJ1tKyv7eiqWlyquMj2LqyNMEk41tvvrtmkZIfLhcOfMFmXuTVsGwpT4hIWRlqBVA2VajoFPsLzOuach198Xo75EfUO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVQ7iyD2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVQ7iyD2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso1747347a91.3
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787761280; x=1788366080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/VxaBSyrAp2V1JuGfOC1NLa01pzB3ApfCB2gfxG+kg=;
        b=NVQ7iyD2jeGIpRsm1FJtEPzmfezADQch930PPya/IK6VEsIO2zl4I82W6ul6Xb6nXo
         EtFF4tTiyIi/jNTZdVYCE+uh0SxdBxJY2Zb8z4mWzZAzGXxGzr1qHOwNDDJ8Ctx9rwWj
         K3eXFRM7tjiTS6yliz0EwwOcuvmhaKdepaUx6m99H36KUqNQdlRMuXImCRZNvp8S6VZC
         zQMUbWBvP6f/JfUCdAWcHkr21bM9doH+rFqrV6mMUfav4/kbT8BizPdQWotpd+9TZnCr
         C2BqPgT5rf9wNyOyuDHH0u0YbWd944ZD+O83dnRqgOVxDyOHi9svquv+JxIzYEbbD6vX
         SC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761280; x=1788366080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9/VxaBSyrAp2V1JuGfOC1NLa01pzB3ApfCB2gfxG+kg=;
        b=HXbUsvptkfF6T5xgUTpfmiNZreraAZtSsxolzP/YXVtRb0131wG70F/ZySYQWCp31m
         hDrYQDH5OE/kbb/Q7JkfFZXA5QV8ZOrpfhvdoUE10cE/WVW8C+HNPHDRvpJSmTC4wYp/
         sGNJ2fYeRictj4EJtFh6bQXiQv43ksRWOhGyAaWQJsv3W7X4qJz11zc2iLYKFTTnWgWB
         Pm2g2TA8Om0UXzXkhCXS8tqLTJ1SMyNz29RunB3aqey+CtjkLYgiNQL4/5CoFzhe09D0
         bkLVnC5qDo7ixnljFf8t98lksp5MXVW7auVs+B/031JKT9LbZyPmETXwqmCRgw56Czrt
         /Qag==
X-Gm-Message-State: AFuF++kwIHoYzb+lBlwdt/47AXDetZkNvQfQUvmbQ1PAj6zuRF/fd0tB
	4dZwiZSmN+Mgna5t/UJkom1Wn37OdgekM/wQGB8gi9ULyMQI/Ks14vxgM4T2ByLhk9s=
X-Gm-Gg: AR+sD13uo4tAgY+EFysbrs/Bllugsi5OwETmG+8CQy/QQq1tjLDWRK6d7UWvXUQQbx5
	9p1JkB0lPaeKiu9PYmtpqKQe3Q517focH35RGwO0epurvUDNXsJyRwQlQK7wBI3ic36A9lENSMl
	ob7WJWhXWjCq/QTeLkquN9sRWx+/NWuGkpIYVa6p4ZhBXwQLNCXNoy54pszStv4ejr9trrT3saF
	StaDPHnwwD7UZGej1vQleeMBNx6ZE8X1dAiQAfIni3fxAEvtm0EaZY4fk0n9nm3RbFIaVwxuCDA
	VVZ6bY/Fx+gY2zo/yuIDL2fXhX/g18EqyR0sqbf6ej07caR8Bq8saajyppV/DRAJFjbKIZd8Yw5
	m2BAZvlmC+Ccg8jatAEyj0oykjk7yE6cbBYTWw9Qb2Afs/F1CfvktNjQsrNno28zViDSUadeZzB
	ZOrEDZCk75GyN9OKWjzS/MJk8ymJaw060J2XFJXLait5pZpBgnw8jLmi9KPsmhwIJh2LvJf9QMf
	zibLZjTmAZEjLFa6NbrYhE=
X-Received: by 2002:a17:90b:554c:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3966d1396famr18305322a91.1.1787761279828;
        Wed, 26 Aug 2026 09:21:19 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396689f1419sm4660649a91.9.2026.08.26.09.21.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 09:21:18 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2] xsk: Fix circular locking dependency in xsk_notifier
Date: Wed, 26 Aug 2026 21:51:10 +0530
Message-ID: <20260826162110.99879-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a circular locking dependency involving &net->xdp.lock,
&xs->mutex, and netdev_lock_ops():

-> #2 (&net->xdp.lock):
       xsk_notifier
       unregister_netdevice_many_notify

-> #1 (&xs->mutex):
       xsk_diag_dump

-> #0 (netdev_lock_ops):
       xsk_bind

In xsk_notifier(), xp_clear_dev() was called while holding &xs->mutex.
Because xp_clear_dev() acquires netdev_lock_ops(netdev), this created a
nested dependency of &xs->mutex -> netdev_lock_ops. Combined with
xsk_diag_dump() (&net->xdp.lock -> &xs->mutex) and device unregistration
(netdev_lock_ops -> &net->xdp.lock), this formed a circular locking cycle.

xp_clear_dev() operates strictly on the buffer pool and net_device, and
does not require &xs->mutex once the socket is unbound by xsk_unbind_dev().
Both xsk_notifier() and deferred pool release are serialized by rtnl_lock.

Fix this by capturing the pool pointer under &xs->mutex and calling
xp_clear_dev(pool) after releasing &xs->mutex in xsk_notifier().

Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
v1 -> v2:
- Resolve the circular locking dependency in xsk_notifier() instead of
  reordering locks in xsk_bind(), avoiding ABBA lock inversion with
  xp_clear_dev().
- Preserve user-space errno precedence in xsk_bind().
- Reference the correct Fixes commit 2495b430e382.
- Link to v1: https://lore.kernel.org/bpf/20260825152152.86092-1-ahemadkhawar123@gmail.com/

 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4..c2f47182dc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -2106,6 +2106,7 @@ static int xsk_notifier(struct notifier_block *this,
 		mutex_lock(&net->xdp.lock);
 		sk_for_each(sk, &net->xdp.list) {
 			struct xdp_sock *xs = xdp_sk(sk);
+			struct xsk_buff_pool *pool = NULL;
 
 			mutex_lock(&xs->mutex);
 			if (xs->dev == dev) {
@@ -2113,12 +2114,16 @@ static int xsk_notifier(struct notifier_block *this,
 				if (!sock_flag(sk, SOCK_DEAD))
 					sk_error_report(sk);
 
+				pool = xs->pool;
 				xsk_unbind_dev(xs);
-
-				/* Clear device references. */
-				xp_clear_dev(xs->pool);
 			}
 			mutex_unlock(&xs->mutex);
+
+			/* Clear device references outside xs->mutex to avoid
+			 * lock inversion with netdev_lock_ops().
+			 */
+			if (pool)
+				xp_clear_dev(pool);
 		}
 		mutex_unlock(&net->xdp.lock);
 		break;
-- 
2.54.0 (Apple Git-157)

