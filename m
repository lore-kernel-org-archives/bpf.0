Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009D35E1AC
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061582; cv=none; b=GAdTzyqviWSrYO/weaG2MnJfb007NBcLU/X/wnqTuZz+A48u5E1a5Vmu7PUQChQSIXYRBe3T/fjRsuXiTsToUzipDEeSV+kFtBNVCg5LJbofAV0EJGVByttBOO39ZKDrcbkp3qdiU0WAo8Eq5gYnoqS132wY18QWbY8nSjT/VsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061582; c=relaxed/simple;
	bh=p3ty0i+wWfdktVq9nRg6b13I6JNyf7ok7A0AV4/xQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROV3XBJMcWwujajIyCL/0KSThzuRpg7fe6qKVapVRjWnx9aMfu/tBdBLiJJBPgXH2S1Wde1jGbT+l8Gmwx1AU5vVsdHOTgDwm7+nQNzVNqUQxNolJ2FzlZL0YF2R/kZjzX1JLINAVXkOWkdZboG1bw0yn9iO+Jt5DKpDWgEkA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oY2XZupy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY2XZupy"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493b1710405so25222125e9.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061579; x=1784666379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5D2M+8JC0T4UT29HnUPeI2z7I2/miIRrXwPjpYCuscY=;
        b=oY2XZupy2BbDi+jM8PdfvhXqKK7jgIKpkvPsb4J9K4w1EDU3e/aVcG52qey12iP0Cr
         nplNFknaPWpGSA6bXx8eA2rMZ0zSWp9trh8l3FTF454xhWhYgEudGsm1fbS6HaYQFyrY
         qs5M0F6a3WaxEPy+v5I9w4CPoEHaYeEZi5kfbuKJxn6mGZrB1wpQJRzMvADZG51tNDeF
         z38Q4e3dME/vzxrJtf9/hEHsHdJlVjDVhC9EaQ/gN2RHyK1pzpIBS+VQ4xGvzeCfSge+
         qfvp96Y/yHbXXBVN74EJg1kKqPCwwzMlseNNwGFW8cHZ2bMVMMowjPDogTBvuJUeH1Vn
         vxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061579; x=1784666379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5D2M+8JC0T4UT29HnUPeI2z7I2/miIRrXwPjpYCuscY=;
        b=PHhLE3yjInbaMAjS78MwIs+r+1QyS4aDasVvoCW+yw1hgX9SFvX2eivTY6SrxYx+M1
         XJPUmxeQFI0YdleGoAnzNwAF4q8tGDs9ipqUEdDBDTHePyk77LfzeV1yvlFgqq2L77DB
         k+MP4t7kLlarao23y8w8Xce4pDdh60D634tJjb41i4ROPYBWbIgkRor1gvt9n+l0Xm6G
         ywYBo+nq2x8ruijM4xzoFiCaG7pfWqihWlRL6fICr5AVfU5Uyf6q4ylhzDQBP2lqzG/Y
         4zxg6oBZt1f3aDTCDeBVs1iwrVBfrbFrTmWZI3aNfdximfJiZFd0PSFPkS7I5fXM8jMZ
         X7XA==
X-Forwarded-Encrypted: i=1; AHgh+RoJ9Uy1d/SE9KaLKYXp1X100YDu+Z3UcZ64FZo+UlDgEHAxQ6HaQVnNPGxMwHpobpbUlvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0JU4lMI9mBgZdjUglh9E/X36d24WciujX1ZMkOuVmmtqoDsV
	8aQT+zVUKOwJknGHaEUu4AgFZwv0Obo0v6vZEKzkI3OwGwOnDJcmyzBd
X-Gm-Gg: AfdE7clOIKijGRnV0V45QI9zbHN3OdPNKesiEqVbvNqIIOZBBFt0DywuFxVLwDX/xvS
	SIDcX+Ni0VM9wl4q4ZBqYsw3hi3vKjXf4hZiXz1CFdvOWgRW2rOEvWFXtSl5vZ1BdIreoI28qSy
	g6cewlredBXYrjzhcQ1OSaNpu8g6pdA89cWnIKToKd9MS51O38r9HnBbigVmZLuSc+VK++DGR0M
	WSEyoXB8qQs5/rVxrrqLlNNcIsLhy3FfiJiPXZH0pLehSmOn/P8FNrE27y+48uFXJZObr3g+Z5G
	CBkGGxki7x8B7JdQUhGQkPBhts70FsgPjPHF1xO52UEPxC7e9uQtyOsTD2EdFoaFojxE9zh9uM9
	HmCTDnd8DW9sqwnSJwSBXpbechT3EL9M5HEmD9biEGJHCxkv9NnxAQ8IqaK0LWu+iSR8jp9WTu8
	k6mK9Rw61tUQRdsdG6Prq+0E3BTTvpBxbrfY+5cFMGyEujG4II09/gtTGLwcz+Y8Srv4XFG53pU
	FdlnvazA/fXVJs=
X-Received: by 2002:a05:600c:283:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-49518306db9mr41584185e9.27.1784061579422;
        Tue, 14 Jul 2026 13:39:39 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm98894115e9.14.2026.07.14.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:39:38 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: nnamdio@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v3 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 14 Jul 2026 21:39:25 +0100
Message-ID: <20260714203927.32289-1-nnamdio@gmail.com>
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

Changes in v2:
- In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
- Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
- Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain

Changes in v3:
- Added the sockmap_recvfrom selftest.
- Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
Nnamdi Onyeyiri (2):
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

 net/ipv4/tcp_bpf.c                            |  55 +++-
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   6 +
 .../selftests/net/sockmap_recvfrom.bpf.c      |  31 ++
 .../testing/selftests/net/sockmap_recvfrom.c  | 288 ++++++++++++++++++
 5 files changed, 373 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.bpf.c
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.c

-- 
2.52.0

