Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01F3F58DC
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884710; cv=none; b=enatfbnsjq8J4Fa+qZm0VscSs4LKIlrf/rFGwxPv0Jr57nftYZX7rpdxVUYlZClaP9OhhMRiHI0iavp0d4JS/w1HZPlQuL/HADnUtbiJFxlsFNmmkKz2CvsoanjeNzvHuE6bEW16sorw29HX3he988CYJB2Ji3O+CGXzuX9MtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884710; c=relaxed/simple;
	bh=mjwGIZ2kZHJmgR3R62XVlxDdBSkKuWbIdCvpQcxxNzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKATEGYSExb2ziBQvbP7/CVbO3RkqAPozZR0/nQJpZovy75sHdGjlPB3c5YLIDYFmi0S5JHQ56CDsE02CaaOa8M9ElTziZqXRGBrwnAiTqGenziUSXaMn/PCK36jyzGqKQiyjLOCD7K4sCibG5TLnq2uMhYrJb1yr+CJudvnuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=RqnP3vL/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="RqnP3vL/"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-484f0167156so372234b6e.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779884708; x=1780489508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOs/E8rK/exLB/8Zk3Pk8ZyyhyccLxwjQ0Syjke79QM=;
        b=RqnP3vL/pYGXLZQpnic5o7jfnMb0U7HkWjm2FQW1jsO01TdtGYcKMy4ZHpcsZb1Ycy
         jiKy35rI5r2hgx+gAtTC8b3a38Qdaf/JFq1Uof2Yg9qsBjgGVqsouKpZbYNqznCDsc1J
         jWIrb309XqqfCmy6zcGemXybFEfAdPoiFoKb7D+VsLSKIZ+I1iDwTBKQogpX3pPU88BL
         Q77sjKCU0oyq4/FXhYplL1k1Qihnnp1VOsBw0ayiIj3imdsDCMlXWVnw/ZDhwL+J1/2l
         fragFjpF3oxlQYeqPOtB3/jflGJ2qxqQiF4XLSDyAAo+r6KKBVxCtsWnnCt2WJbCGfwl
         h0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884708; x=1780489508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOs/E8rK/exLB/8Zk3Pk8ZyyhyccLxwjQ0Syjke79QM=;
        b=FaHyJzEiRk0BJDdGIW1XV1wMMWhm0Q1Lv+L1lWS09t4zNgrBWj4o84kPnb5Wf8Wr/w
         RtImLkKZwtQtD/g0IIwzZePWymPiQXJBznwLXqTAdf16wkfnmwtiXp29tGt/U0lnCOSt
         xtRnU5RQUWsmFMJf1cLJmCkz1Ps4faLC5qX/p9E7L9z8UYfH25j0PmqDy9hCEhB63Fwl
         pwLt5/5crp5/j7U1d1ov9M+DLVpIDsKpGYs8zxrv/RgosHPbHLObLs/OrvB0IBRrFg/7
         tLV/Zy35mANErRnVfX1Fx8FvjM5r/kNKS0oy7OUnuhF0EeBZvZKkAEs0nZVDuZlBSIUw
         6DVA==
X-Forwarded-Encrypted: i=1; AFNElJ+5EqQuDDORwB8O38QxPqBEjhiYTj29tsHvtEnOz9BVTHqJ1uBxQNF2CHC+qr3EiqH/t5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztlWPiRWqcnPnVwaacUl01btovLYmjOt5m86MvBYGKzesbpXNX
	AzQkS7wHuAbfNPnBN0C9KwGoNf75dhY1qtoOZniVC94gcDXAsRapqycXOqIo46ZtkpnD
X-Gm-Gg: Acq92OEy0n59G554PAApbNfYK89w6/Nbwe+8Hkpwr9zJdduc/oz0mAKKQ9KknwVmlU2
	AUhUk/i5rELPwy47sHXsmYl1UuA/pnli2azhC8T3UFD7Kg6imB0KKqOmxeN98uPXqGuP/ciGCAD
	EL5ZAFhFqTQn9PIUqUdYZJW0xl9piJ3uYs5hA/H7B4gnEwdD3VjbxxzWulpFGj3dz1tI8r6YI77
	izQv4Cr6m6HK1NO/ERnHbqKs/qbca+J2EDZI0L2DK8XJblAh8E0cA3+f9JGHUqBVJhmFURGvleM
	5U9i5EpL7nHBMFk00DGlLNGMUAy1EAYEYY4F15teb/jj9ydil3dI/dfm+K7BKKq5JdBZG2uCbrf
	E1H6pOVJnk5nN4Ih+nDN63lX3kPFQvW9GWD4aWFziFr24QUiFNiXotRx333bj+l7MQfdZQr3iB5
	2Jedl8PDNbiD4Hwint9GPIQFYUHX2Eh7T4mqchn9cgOUjIqLhRGLyslJuspJDlYga4OAf5UbwdN
	q9oV3i+q/ItI8M=
X-Received: by 2002:a05:6808:1523:b0:479:f928:44dd with SMTP id 5614622812f47-48549ecff8amr7221156b6e.1.1779884707715;
        Wed, 27 May 2026 05:25:07 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485b5f0661bsm1475842b6e.13.2026.05.27.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:25:06 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Date: Wed, 27 May 2026 08:24:54 -0400
Message-ID: <20260527122454.66639-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161101.691d4cb7@kernel.org>
References: <20260526025154.60607-1-clusk@northecho.dev> <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev> <20260526161101.691d4cb7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 16:11:01 -0700 Jakub Kicinski wrote:
> module params aren't a great API. If we want to deprecate it let's just
> remove the integration in net-next. You have my vote..

Happy to draft the net-next removal series if that's useful.  Let
me know the scope you'd like (sk_msg verdict path in tls_sw.c +
the sockmap-attach side + selftest cleanup; or a wider sweep),
and whether the stable trees should get a narrower fix as a
separate backport for the 4.20+ tail.

Christopher
