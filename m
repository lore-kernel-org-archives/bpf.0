Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E83955EB
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657997; cv=none; b=pTZT0J4pS0pCyS/jr/S9MSVOqUWGZEQTGsWr42XXtyz5H3R66LboMCyybm++x3a4NtHoenntL1bCL9TsTLSioaW3ktfa+hBwyhoR4WHvYR6ACs3iUZ47N+ph5z6x6Or5mZdfbUPAO6atHEf9n0cYAsSK2kiCl1tnouwZE6jUgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657997; c=relaxed/simple;
	bh=ziN5dHVkV7ZdQAPjkzWjVLHjoV13nwProvcGUTsmyDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fcd3enqGD83svp0/jGkgMSxzw2wXUbwUm5+cAPgx0ePWg3ZQ8qGfkTHMr5891BBF70AA676tUphOXrIVFfopLf9IyQO5W3yX5IIXE6kGI5G//uBg86LaXR/w6d5/3Uw6B1BU3dEIuWLJi9vcreQjcxAk60/ORJ0/T3jlZ1xasas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DA1aMAEk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA1aMAEk"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso3826582a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657996; x=1788262796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7GgJoXYOELWkqQCC4YCb3LS5MbgnsksiqjGFB0Iuyk=;
        b=DA1aMAEkVDqufl+F4IT/112LAraoB66rzwXfyw2uQ4C2LN320OKrRbBbPVGnZTDMdw
         k/Fs8uHBiSyy5aHyTcZVa1bx9wwPewJcbuUr6nvhmFqV7Wtv5KFPkR3Md/9uI+mPv/sh
         2RQNVZqd3wX84fqmJJ7I6InTIlt+eNFjTdeCGLfoqHr41UP2ufiQhpsEK/EFOKyYl4r/
         S6B2VS8isPfJ7UbSPDHaWw+LD5KH7ii68cB0vVCVCRsBB5R++FMCN0o+urN4YXh854av
         FbYjrDSQzf3xJY/Hfm09s3XZ9uAFBUWR5Ytc6VKbb5psyJ+wNYMuyhtxwyT5i2tSMt7B
         bxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657996; x=1788262796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7GgJoXYOELWkqQCC4YCb3LS5MbgnsksiqjGFB0Iuyk=;
        b=V705n7sca/zWhD1+D45KDHNrJOble1b6nj3hMwXG+JKtxwqB2Mgudd+wdV2+4mHGID
         edCAY5UaVYYNskO0vA7XjkVA5PA7m6vJ1V9QO7CCKigVINvYGZn2qljP7PGw+lxv4/Al
         8CbSehfTR1xGeZ+IuCjlRJIW24DXdneLsmRUWXswbjuGgW5z04YNFPkRdfbPqlo/Saso
         FadoPf5S1zueWIXDYWj5BH7DSs4NNWl4EPD9KqESpjXV3nh1dXi3hZFi8jEHWwJKrTsQ
         n0mDcDwXac8pbnqyrzzHNnt7Dq3BnlV8En38p0ZAYw/yTme2DmDgbQR72mSH8LFeaxyo
         TBJQ==
X-Gm-Message-State: AFuF++nX4LCc2Yp+et+npY3hKtnwnFC3USlzaRu0JYo30C84UFH9TBXC
	vcMJ5lDQ5zdhyoK3ucPvtDJ3VQkcKN1u8QHv9boah8/zxI6hjdEbLluRkH1w5Xeampk=
X-Gm-Gg: AR+sD10SAuH1NEIImOKDqGi6BfgIKrximu5Lh+VW2cp6QQNV6PwXUXhYV/4Rb5QvZKp
	wLFbL4PgP4ZN70E6DEadJzFXC4JPeLtiXxRy1HpTPofMCvaMHtkBSHk4LEe/v556mDTvcELncBt
	W5Gy8faJSP2Gm7yolnC0IRPNtcaDnI4/mZZxEBb+yABZdn3u2DhqcWp0E+obM0+weLBO1+hh29Y
	PKnd5ie1e0MVJ/g20pOg+GQ+/Bf8QMt1ImuNLp2PN4v85BvDd+sjLcUDOONLzTF75ke049NwSh5
	6mfV2wgWcHwlXdH5I0FSsksGpLGxaVbhTAINGFZgJDAh9zud8PKa3NMcpMtaL4Cvm3rv6PUdjPl
	AyWMqQNWIqra13Thz5wKsFpF2ShfYb4UPPa8xO9Xt3+LMvq5DKEmicijSb7rj5xT5AVmHvqiFT4
	RIx+6zMv1m+jRV0Shb29zBd6/WJBF8VoceM6QD3XEdaXAXqLYVwH6YH97etZFALNQxo+7vk37jE
	azWiJW2IGsm7dvFB+AYlR6nnQ==
X-Received: by 2002:a17:902:e785:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d64b0e2c7fmr683379535ad.14.1787657995861;
        Tue, 25 Aug 2026 04:39:55 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f920e0desm6962043eec.24.2026.08.25.04.39.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:39:55 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ahemadkhawar123@gmail.com
Subject: [PATCH bpf-next] bpf: Fix stream capacity leak and spurious -ENOSPC in bpf_stream_stage_commit
Date: Tue, 25 Aug 2026 17:09:48 +0530
Message-ID: <20260825113948.85020-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_stream_stage_commit() accounts the staged string length against
the stream capacity via bpf_stream_consume_capacity() before
detaching the queued elements with llist_del_all().

If no elements are returned by llist_del_all() (for instance, when
the staging list was empty or failed to allocate elements), the
function returns early without releasing the consumed capacity.
Because no elements are queued into stream->log, no reader will ever
pop or release this capacity, leading to a permanent capacity leak.

Furthermore, if ss->len is 0, bpf_stream_consume_capacity() is invoked
needlessly and fails with -ENOSPC if the stream is currently at
capacity, spuriously rejecting a zero-byte commit.

Fix both issues by:
1. Returning early if ss->len is 0.
2. Rolling back the consumed capacity with bpf_stream_release_capacity()
   if llist_del_all() returns NULL.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 kernel/bpf/stream.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 7a5c3ac867..3ad58c8284 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -350,15 +350,21 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 	if (!stream)
 		return -EINVAL;
 
+	if (!ss->len)
+		return 0;
+
 	ret = bpf_stream_consume_capacity(stream, ss->len);
 	if (ret)
 		return ret;
 
 	list = llist_del_all(&ss->log);
-	head = tail = list;
-
-	if (!list)
+	if (!list) {
+		bpf_stream_release_capacity(stream, ss->len);
 		return 0;
+	}
+
+	head = list;
+	tail = list;
 	while (llist_next(list)) {
 		tail = llist_next(list);
 		list = tail;
-- 
2.54.0 (Apple Git-157)

