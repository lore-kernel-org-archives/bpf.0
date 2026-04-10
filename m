Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BE3CE4A2
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830531; cv=none; b=gSSzybi7X1YFvaUXk5fQzQ76J9Wp9S9K8/lUyRYau5WFz+OZZiDqbHlGBLomR3p7GT6iFbMvv/tguRYLu3QKPCtvxKgo176dIMvMF6MidEH3La1S3BCrJ7B4J+6XkI6VGH5nr4G0Bx0nb+Fn6d8RcgfnuAWQn++BOkknVTAcQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830531; c=relaxed/simple;
	bh=ZMMwOHR8+o5eywy7A4dv25R5kTA4VWF1ikDRQjsig3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcpcOhaa4WtXv0n1biA0xVMI9tirBZVyHfPZEKCnNAKxONU9ka0R3cT4A6hbbh/LFfXPIbtzQFkbKUgn3AxoBytzWSnP/IBeQgPmMkbLXmhakxnF88SrMjCzeK4rRLcmbDzspEjwYTGVfv3FurITPLBfOQdXUr9Ye2nmW/ZP6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrPaYkMn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrPaYkMn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so25869155e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775830528; x=1776435328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibVIM3YRkDFxVQFXMQG/D+NUY7JRDZKRc/EMBS4wLuY=;
        b=WrPaYkMnAp26p+pfLHavvii60oj5quWpAzHQOoJpk3pNcwB8rRbhAcKP26y3rCOfjE
         2bUhrt7cYb6Ytu4f0pOA7b4UONhlHUH8Sd9zfz3SYosJTJGUD7Hg+ckcXSQKTAis6fZw
         9/ku5BNFLGUqtIy4L5xgrDN1iOl0uNey2cJwZ43btsTFwSwE7HTK49/FdpdwoNxPjkQ4
         pXO8Nw+TAjBMMzhpIg2JFep7mTQqTxtply2zVnqUkP/nz7ZNxLOcaQAz662QuPPQX5jf
         WbmgdSTexyz0b2WpbyKoHyVqOE96QTZGb2TuFeOf3FQiBQ/nRAOW4R3uXWSuJiUuQF3Z
         00gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830528; x=1776435328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibVIM3YRkDFxVQFXMQG/D+NUY7JRDZKRc/EMBS4wLuY=;
        b=F308IuQREzR6JDzou3/4CzjIxBbLkR3LDJ9imfAMVI7BTomp0v5fiUmCoGm+Yc4+9l
         Zhd//98j4FcbGKsxeStBV6+DLCVFfg6ssK0vCQt4O7KE6hT7G6LLKvLXilxwRO54CbnD
         S59zfrbgUqJPX9CPq+KYfHeJ3Ujy+bN3DFjvG3Kdgv9E6NAN3diOj9pxUoBU1SH6kGHK
         srqCYykAMfwIUjqSQcDAIY7yyX25slsiGv27jCZdwbPK1yTD67K4zM3Co7OJKtN5LnYY
         fXm10T7z9GVvK8nfIOLawWG/ibpiEl39oJNYMDh7m2csimFtfFfW+TADne5hWpO+HmBo
         H3IA==
X-Forwarded-Encrypted: i=1; AJvYcCUOzq1sccp1pJOgj/bDy/vBwRFtg+AaLAQMBYbJ8S8mDAeKG3+9cd6v1t5gxMXtxgxMONc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTubihV2lleoB0172mehKWd06ChwMVytJjfRJ1v27PXHQJHTn
	WF51KFii+1luYpQX/i7BEKtX10X5q2/3/rkHCi2Cb0lD1/Xcxab1Hqac
X-Gm-Gg: AeBDievvuYl7pVrIeyL4Kyq/4CCHoJ6f6DXjrhQdmw/k9Ga/jf/HAxEIGJzTHjlNa+6
	WMNPNF1bACN35vuIJkRzGf/ViGO+SlCpqgamwLvHo+nZDnzSM3NrjDTUBe6oPMrxrb1IfaZAddU
	l4fCfRcxc3eJ3z54SVpeJExovOakkr5tC/N0k6t+PXAOgWqRSyVRWsioKSIies/bQy4v0Ulr38f
	OvOmGA11O0sgU9vcrFUJ7oUbEHEE2wh7JPCFqsBHs0jWyRD+tJBqIlC/CLvrsXQm/TvcSYdiHVW
	nhQZ1wPy5KOGQw1631siGtGIT9edHe2p++LD6vIs6EVhVk0Yw8wvFjnl2PO9Pr62VEse10xvcxw
	yK1iNqM4E31TZU0oqoMF/15OkgA0kbUhF7j10Fjai3osVp1I4451ogGGoIG/A3L8byxZg71Aw7V
	s6O3WYGSZwobrtCOyRkXq2nmo6wcFsUGPBEUNK35MDcknmrd4HmAnWMbe8EdFrKmb6X+eeIA+qQ
	9A=
X-Received: by 2002:a05:600c:c08e:b0:488:9619:9bf4 with SMTP id 5b1f17b1804b1-488d686093bmr29672415e9.20.1775830527797;
        Fri, 10 Apr 2026 07:15:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d68585sm36286005e9.1.2026.04.10.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:15:27 -0700 (PDT)
Date: Fri, 10 Apr 2026 15:15:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <20260410151520.3e91c2ce@pumpkin>
In-Reply-To: <adjkn7p4U13WBs2o@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
	<20260408122653.295953dd@pumpkin>
	<adZcnNgxhsUjAgZW@gmail.com>
	<20260408195640.324ee932@pumpkin>
	<adjkn7p4U13WBs2o@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 05:29:37 -0700
Breno Leitao <leitao@debian.org> wrote:

...
> Since these legacy protocols represent less than 1% of the cases, I'd prefer to
> optimize for the common path and handle the exceptional cases as exceptions.

Optimising for the common path would pass a fixed size on-stack buffer
(say 64 bytes - or perhaps enough for an IPv6 address) through to the protocol
code, update it, and do the copy_to_user() in the system call stub.
Write to small constant offsets onto the buffer could then just be direct
assignments through some pointer.

The 'buffer descriptor' would need to contain any associated user address for
the unusual cases (also look at the sctp socket options).

But I still think you need functions that read/write at offsets into
the buffer rather than using iov_iter - which is only really designed
for sequential access. It isn't as though you need scatter-gather.

	David
