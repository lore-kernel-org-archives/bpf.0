Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB04A37E5CB
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151346; cv=none; b=lmMWEILn1vtztpqzIskXET6Zo8j2x2qjR8GMBZm124Ys2mNcdVfAEl8TJzkV+0KSd6dewBX6YqFX+cSv4i45iNSXfKxO+25qYbEYcijqDyIKPC+0T3NGBFCSTsYg9YdREuBZ7bFdAPl7OLxwVRXWZR9TNMHi8rlSYc7kWXmRhDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151346; c=relaxed/simple;
	bh=H06707SCcUEpQKy3SuFkb5jGYwBixHq8bDcyFHkpNwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjwM/D66p7FsrIFOquHH3U9iOmjtTYoah7CQgZClhYn4zJ/tHgZ8ljzHhtEUQaPrbJlsCnB69XQsuYS0ZJxE5MKIIDcryoYUv2U1CD6OGJYvOYiNFWt6tk0lOEHM64hZjRjlH+oPklgDH0GBkPrlcx3+XIMKl1v8DZGnDmg+Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9gfOj6q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9gfOj6q"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-474560436c3so1929018f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784151343; x=1784756143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoPbLUiXGDVybmpDf9ldp04oUouyQ+e8sy+2Axcu02k=;
        b=D9gfOj6qVfv+R1Mdq9wEJiKaoKsEPAb+ckiNPGzL4iYTQCQudsm2ew/lO+SNaK3ttp
         SgpguTVx3ur5KwSco+6mCYXO69HMfG1AVgS3NFFy1KXfKlnIxa/M9UKi3+429xhSdFMK
         7b2W7Xq3cYZOOZtLBKUrSNBmgCILfMWKv1ilaAGEmGd9eFie3PXwsvLtueM8CERddAQY
         puyrt12IjRbjauOJ710lf1pwY7wn7KFTJ7ACq89h8Lgh237dDQCSc+Zu7de08HVatplQ
         GbL1Fj/LdqeYtjQne7AtEo2f12HD39K7pnN2RxB/1H3OmKIX4XU4J1iwcBcTFjRRHj9O
         4fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151343; x=1784756143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XoPbLUiXGDVybmpDf9ldp04oUouyQ+e8sy+2Axcu02k=;
        b=JVQKQhoUOjfSDInPbcx9fKUdIub2QBrfuOF5Yvjyu55k4Trf456S274BtHkuscuQ35
         U6IE8GY6JvdfpoQqH+zXHOyzv7asqraq9/SWbQiEKNSOrf4YYAmcx+mkGZaGDBEhRzoY
         E5dGIXARC5keWOuxR2QSvgq2vXwYq1w62QltkcCPtA8G+pmAjae1O+xqhNkfb/JNCNzD
         2SbrMXgiIimr0yZErXzM5l6lHi/Fi2gs885CLYAD3My+9DmWlIlf9daY0ZeJYmDznJSY
         cGr33yFPGeIEp1/GiX5Ffxlqt/Bq5ZZjurGYuLfUb7FLjnEQk2Q2BsXWwLK5hZigLjf5
         JLWA==
X-Gm-Message-State: AOJu0YwpMlZEEsAa8CNV13XZ+T2V66IGP83C+IHzBD+mtQ9ZzMaKqx9m
	LZJGOcRZ7RaWRaHcXpIDMlMzSNzwc25eQJa/ucUlTFm/NJzL/xeXSe6q
X-Gm-Gg: AfdE7ck0kzlyguI75lIf/w7TjPtiUDp5l4rE1htFK/lNam/WEgUaHMwWhlPEon4Vfjb
	0f/S3C1SO/LXX6p1loKmHlqM/l/JxuQ4ys3m13szmmRU/sxge62mDAUtGt4CvjJBmZMqIwMKwFt
	ez4um2zC/8XWUuAMrD1yR+DSnPhTKyoujOn16A3opzW8Mwj6DvXZFB0LRJXdcJEKtl8S2AE3x7p
	2ChfyIuNyO9YEh8nFr8/gMpSXu/YLUln6awm97JHZpSN2lxVZo/+jczKB3Vu3vweDZPAtApiOXq
	hx8PQYjWNDp5jyLmUN62NvcP262MR2iV1omASKhdeLvPK7P8j5EBCUydUmqsonqLOYuj3vKckjQ
	jLuaKK+QXvLjmwRpK9c3I9TQG+7688XXny4chTmhQzjX9o2Np+IgbL8l7i52o67SEKQlbAwK8wJ
	JOz+HDLhbT64gnxPh7peQEGZoPX1RmTWUtOwYnD5PVdZwVi9K4+RoH06Uvd7G22U4IZtsJZPPsz
	L8w
X-Received: by 2002:a5d:5f51:0:b0:47f:51bc:efe2 with SMTP id ffacd0b85a97d-47f51bd05bcmr4660373f8f.11.1784151342782;
        Wed, 15 Jul 2026 14:35:42 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635c86csm19224122f8f.16.2026.07.15.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:35:42 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	nnamdio@gmail.com,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v4 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Wed, 15 Jul 2026 22:35:36 +0100
Message-ID: <20260715213538.37229-1-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spurious wakeups in tcp_msg_wait_data() isn't being handled by
tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
wakeup and a selftest.

This issue was first discovered in an application that adds sockets to
a sockmap as a way to view the received data.  No redirects or any
other operations are performed.

Sashiko has noted a few other pre-existing issues in the same area
(https://patch.msgid.link/20260714205118.17DB11F000E9@smtp.kernel.org)
that can lead to EAGAIN in tcp_bpf_recvmsg() and
tcp_bpf_recvmsg_parser().  A local run of Sashiko also identified a
potential issue in tcp_bpf_recvmsg() handling zero-data FIN packets when
the MSG_PEEK flag is set.  To prevent this patchset from growing too
large, I intend to submit follow up patches to address these once this
one has been accepted.

Changes in v2:
- In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
- Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
- Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain

Changes in v3:
- Added the sockmap_recvfrom selftest.
- Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain

Changes in v4:
- Fix potential data loss in tcp_bpf_recvmsg() when a FIN or RST has
  been received.
- Check the return code of pthread_create() in the selftest.
- Fix race caused by using EXPECT macros in a thread in selftest.
- Link to v3: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
Nnamdi Onyeyiri (2):
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

 net/ipv4/tcp_bpf.c                            |  69 +++-
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/sockmap_recvfrom.bpf.c      |  31 ++
 .../testing/selftests/net/sockmap_recvfrom.c  | 299 ++++++++++++++++++
 5 files changed, 397 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.bpf.c
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.c

-- 
2.52.0

