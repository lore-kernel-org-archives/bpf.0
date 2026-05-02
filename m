Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93C38B7DA
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777752460; cv=none; b=NqQ0AJCgz5ADmiPlT1k+kmOjUMjPMbxWIhc24PJz35dWE4KWfH0YqzmB6VoZEzmdHlg8DowWMTe0BrZlBX8UeqQ1bUCYWK91k9ZEcLifsGQrX/kzRC4twr25qlpG8/+F9FlZkgrFhSjDMSSpjQANRMhCV/Zh2COLECbpcxzfXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777752460; c=relaxed/simple;
	bh=61yGRpOGhsMPizgyfnAILecmujq5o2oGJ99FPk6KnZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S89VgLDyU2sXA7iXRqx02fJkk4VHLhNHpd/tx5whpHLSxOujNcZIwx7ClH8burg1feshD81LinuqhMZoycyMzv4JyHn3F3d4gAQTL5qBSTZnt99n0leE77ODezukSSz0cBgh8IUJBDoyIUNCkNFh1c+qpXYJEtqzV6vIf+XE52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY+KIA6/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY+KIA6/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6794b8699b8so3738534a12.1
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777752457; x=1778357257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADxWoAHbEQydtNYkP2gI04XyqSskeEphy2PbnGArJe8=;
        b=fY+KIA6/QXWq2+AuPPNvzF3Y799LuP+nJDTmx4KT1uBSxkTNx94k0ynds990u4eqOR
         9DeMOxbTy/KVtWsILASJoN9DR29njhoCp2Nd46vxYdwQSWgmyv3G3JMYRC5fH/JlvW9m
         NJCWaftDT7hSggD4+5nsODnYWwf49dWLd7eMalfLDssXbhz3d9pqgTv59KGtb644WkUt
         nSNrn0QXeds+f29gx7KW0kbNOHPQMH4CjEVIN7HqH9Ilr08U6XE5n3BLL6abpZOjytSC
         jHb3StgzlMyOY2/eC8aCXNgeEEN1JZfAXhexIu0LU+evE8d8U9bCx4qY1/sDvRSDVb0D
         DLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777752457; x=1778357257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADxWoAHbEQydtNYkP2gI04XyqSskeEphy2PbnGArJe8=;
        b=BHDEgLgWQJ5sQjutMviH1NWTNXRWAqRtkNuJYbmkpMyAkP2/vtHcpZf8oVv+mtlf2Z
         M+npbBvzdKhiW3iXUt7jayuVxhOYfm3eC0TdUwfZGx0ZHR/itOHU9yYXmrjbq1EJfGc/
         Wu2oOaWI/3WBqkhGjtaykKRwYX539QQ+2qMO5XVHMGgHjqiDmadt5dkC18otfCugZFk5
         r3SmUceSw6Kr/w/RHmTJQK05r7RBcyw6PWXqpes9Cn41CGnbhKaC+nbF9N6XvPtiRH9h
         +hAtOUrWIThrsfVbs2Vd8CV3Yc0nIsvV5iUVKAhoNGV8fHwoloF4jMqbG2bo3V1MZld0
         WqDw==
X-Gm-Message-State: AOJu0YxRubjPnfYA4EA9qVl83ffi4y/7EJvqfegXUIbDX3YM0mo1yt3q
	Kp+LrPr656RZ7U2mY4RHAeI4OTYlu5Z8UToEK0R9xSfTI3WKR3OBFxHD
X-Gm-Gg: AeBDies5RmsNBAvkYRlFGCsqipIHkLBwe845vgDIwqbtk/FLpBSKzGFMo/oZiS4OKdO
	T4LsOjbh5Zvj+rprWOAYRkTvPnbou3n+jYDLqpAiLyctIlcHkUHKux+7cjeM1T2IrsFvCTkzXBb
	iIY3hnspIVzULT6+Jr7IgBgg3lhrDbRHo+YBTM2sBCThRnJ5tVjiyZZf9JOyocJCJ98ONpbkhyv
	QPqDBv7U2atPUqEhyDchVVkyRCEM/akbCSOtUzvkhyBRmUPW8F/4ol+A+BPQfdOu0gNJdp52LLW
	htIrchhIvYakqzKa5hhmQp1n/feUrlCsqDLzKJ+K6HlY+O2GyPdAQS2Er2C3o8ZdmUtDZ4jPo0A
	Zi0aSXrKpJ3iV0C+SKkbVX2gd3PMxQNXwRn0WsR7ENMGCP90A2nOVU0gwgllpKzvI6cW+0afQUG
	5PetmOJlEdytizT/k5kep2/Z1Vx5ieq9Eyp2V6MglWqnJsqbh0603zi/1t4fcmIL31LCndjQfNF
	OKl7lpGDGt12gdQJlzrX3dgKJhi
X-Received: by 2002:aa7:df0a:0:b0:66e:bb0d:23e1 with SMTP id 4fb4d7f45d1cf-67c1ada378emr1085057a12.13.1777752457235;
        Sat, 02 May 2026 13:07:37 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([41.128.91.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88094aa4sm1902528a12.24.2026.05.02.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 13:07:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v5 3/8] xsk: handle NULL dereference of the skb without frags issue
Date: Sat,  2 May 2026 23:07:17 +0300
Message-Id: <20260502200722.53960-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260502200722.53960-1-kerneljasonxing@gmail.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy() (e.g., MAX_SKB_FRAGS exceeded), the
free_err -EOVERFLOW handler unconditionally dereferences xs->skb
via xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing
a NULL pointer dereference.

Fix this by guarding the existing xsk_inc_num_desc()/xsk_drop_skb()
calls with an xs->skb check (for the continuation case), and add
an else branch for the first-descriptor case that manually cancels
the one reserved CQ slot and increments invalid_descs by one to
account for the single invalid descriptor.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 46660943c81e..ff1eade29aa6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -896,9 +896,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3

