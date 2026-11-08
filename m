Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129877;
	b=5sgkBaMfTezJSNamMFBbeYtnWfAoiBnDv+yBU/cwc1kgYSU5Xb98r6Ajb+ObPRTOVOcJ
	 pXozCSqD7G5pGi7emR8/q7N3gfmawjDUmagQQPYkvynsGlHWpt/vcXLrgvTJP8zUGGDWU
	 yPKs68pkbjGSicgdWVOy7X7goa4/KVw3Z8ZhE/vyWDWeyMvNrNGkT6XvayjZs4Qk6+17r
	 EIZfqMhKyapEa2wQvdCZhJnqgsyVaCAbGMlooBwb220GvH5/8ZsmpxNnYTNGVU9BcEiji
	 1IGUrTUBFTphmt0ci53sPvh9R55ieETzJWRCMxu38L+cd/DgpQEYpPLZ5P+bwlBCh4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129877;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PnzH+B+BQHmWRcHqdfcGVVstdJf8NJtY2FdKLBnT8BA=;
	b=u6lnBriWkO/IT/STdue0S/unIpFazF26IJziWxRfj3101nifgJXw4MpwYUb4sD8mmCpU
	 0O90y2NgWTguoJBIAELATahep/ldP6/6MWbZHGG0kX9hfV2ntTcV686i3FLXoFkTefb1H
	 IarGBA/ODuCibrlAGdfTNHehT5Zd8uXncWKE1qWSHyvoZZi5LGP2ZvszB2e5xJGTBTgaH
	 xDqV2z+WSDloBkPs5nkDjo/YiPQDevqArn1b/Lp6omGiVBANsw2wnxeZOpSRlzixFy0AN
	 GCSqeDF/6NXYd8rnrPTZQXW8CorV9L4W1ecyRAYy+a4OF3fRUk+XP7opC8DVKhATlrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P6HdDUCZ;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36D5606A321;
	Sun,  8 Nov 2026 09:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F36D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P6HdDUCZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=P6HdDUCZ2dodrGT4fxgKTi+gcM2AkdrIy1MRstIFj6tiyIi5AAWFz+a1KqJgaNoDq3kdT/LXsx/Ol
	 8lpjzTROB9Pi98FQQudt3FpG6rLUHyHcUubKzESAblFP6B7rF2p4zESaYABsJ7axqy7o0Q+xxQxy2i
	 OhHS1Qcf+NsKrn+M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af03fcbe3e-5aacf;
	Sun, 08 Nov 2026 17:24:27 +0800 (CST)
X-RM-TRANSID:2ee46af03fcbe3e-5aacf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af03fc1270-639dd;
	Sun, 08 Nov 2026 17:24:26 +0800 (CST)
X-RM-TRANSID:2ee76af03fc1270-639dd
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
Date: Mon,  9 Nov 2026 02:23:54 +0900
Message-ID: <20261108172417.56607-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179411647562.994134.8636776015987575971@kernel.org>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com> <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com> <179411647562.994134.8636776015987575971@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Nov 08, 2026 at 05:41:15AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > and binding an AF_XDP zero-copy socket fails with -ENOMEM. Even where
> > the mapping succeeds, the header shares cache lines with unrelated data.
>
> [Severity: Low]
> Does the second sentence here match what the patch does? It reads as
> though the patch also gives the header its own cache line.

[ ... ]

> Could this sentence be dropped, or reworded so it doesn't suggest the
> patch provides cache-line isolation?

Agreed. The header is only mapped DMA_TO_DEVICE, so the sentence
doesn't describe a real problem, and the patch doesn't change it
anyway. I'll drop it in v2.


