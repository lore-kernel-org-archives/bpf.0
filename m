Received: from outbound.mr.icloud.com (p-west2-cluster4-host11-snip4-10.eps.apple.com [57.103.69.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670F44212E
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515120; cv=none; b=ugRC2g/vW02+xvP/7Dj6on+/1kSGzNyRfXrObonS0lwQBNP+8D+se9+JMSTQwQLoexs1D+AJbDdffnXjmh0lUIxGe9BeOtIU3elJZU9hAzlUFlgz+zU74cq+wxpwodYmo1e9BpnvE0jdDfE1d2TF/F43FvcyCng6OM0f+9LiFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515120; c=relaxed/simple;
	bh=6mYHmLwbqFYeDIRM8O0HZW6mnDgqtUID8vI8kZ+/Dbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Imj1Tfq+tUTF/VFnDrwxOM9XHNR8yLnKeff/j208MgTcQsDhH7lMBs65lazhWxtZRBjIc6VcJRufisaq4JEhJelvZJBV5ZUgwGufpGL5s2h+6XNEfK8ArHconcvgg4t/G15kV8NaTa2OS2MNxgwRIPbKGxDOtglW1c+cmI3lMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=igSeJC/y; arc=none smtp.client-ip=57.103.69.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verdict.gg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b="igSeJC/y"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id D692E1801269;
	Wed, 08 Jul 2026 12:51:51 +0000 (UTC)
X-ICL-RepId: 019f41c8-e0b7-7dbc-b929-378bb9c86e8c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNDGRBWAVhWXQVNGlwYWQ8cHUtWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTFoXRQhFRQNHAUsGXANfB0UXH1oZGQ9XHFAKUgN3HVcCXRFQGRkMVU4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783515115; x=1786107115; bh=Vdtxtw3pbukTyLj+9wd9smqQqhdMezxfdvk4qQmvK2I=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=igSeJC/y8p98JrLi7ygnL29dABjlUl2cSISKzmxgDykKcp8gdT6GuMe1dPgOnQMqnskPHmQ+beqVNINxf5EjRCJ+mB5NWFfvpdi9Xqt0rhsFgJiBXZut7sBx1P79TJY3m0ZHpNH3H1ZDgLthangqZAyT7QBQTV1QgHLHNv+KayWPewcXSSpnXKs8Y5D5RRDVIvF9orMJ1GebwuQ3S3rCj7TN/jf/RAb92jsrYIL+KPMC9me+UDkKHqZla/642uY/VP/17vbiL1wfbuOd9+qq7L+iPNBs63QnMLWWGRhygdsZGt8tNSDXEhBwC6WFLnKohduk3xq4WqsfWOvVLNC7zQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id 176E71800095;
	Wed, 08 Jul 2026 12:51:47 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: lorenzo@kernel.org
Cc: sdf@fomichev.me,
	kuba@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	sdf.kernel@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next 0/1] selftests: drv-net: XDP RX checksum metadata test
Date: Wed,  8 Jul 2026 15:51:43 +0300
Message-ID: <cover.1783514455.git.deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <akZ7QPfn83OUx5Vm@lore-desk>
References: <akZ7QPfn83OUx5Vm@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i0yUQV183GR8doiG7WnL10dtACYG5yuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyNSBTYWx0ZWRfX4OdgaQx72hbl
 SfycGooSeAILZL3tsPfMQtKvUo0Hr9sPz78yh88+H6G2ExTgVtMGrUQxZ6uPf44kfZCTMlEhnfq
 kmnaBqXMXTMrm25TX8kqU1853pfUPyMUP3RC4b4bNFQPQf2ZGn7kJnY64nMVZCJ7YgzdHJoji+Q
 QRo+m1zGiWLIZDBSS2dhfwXnyTSSMgug6xQShOX3d/JQeo5hx/hOOwv3oxUtc5SOXYOMNIYmMRd
 P0ybWeKsB1dn1wZB5NLC7ZF9fWQewH5m6dkFCfy0Tr98qyJ1OUm68w9IDH1i54ItFFLLYy/j5cN
 3t9wLHYbPUh9qJsroQZ
X-Proofpoint-GUID: i0yUQV183GR8doiG7WnL10dtACYG5yuW

Hi Lorenzo,

Here is the driver selftest for your XDP RX checksum series, as
discussed. It is written against your b4/bpf-xdp-meta-rxcksum branch
(the bitmask ip_summed + cksum/cksum_level API) and applies on top of
it rebased onto net-next, since the drv-net xdp_metadata.py test it
extends only exists there. Feel free to pick it straight into v4.

It adds an xdp_rx_csum program to xdp_metadata.bpf.o and two cases
gated on the "checksum" xdp-rx-metadata feature (SKIP on devices
without it, e.g. netdevsim):

 - xdp_rx_csum_valid (tcp/udp variants): traffic with a correct
   checksum from the remote endpoint must be reported with a usable
   verdict (CHECKSUM_UNNECESSARY and/or CHECKSUM_COMPLETE);

 - xdp_rx_csum_invalid: UDP with a corrupted L4 checksum (net/lib
   csum -E) must not be reported as CHECKSUM_UNNECESSARY.


One question on the invalid case: I assert only that UNNECESSARY is not
set for a corrupted checksum (COMPLETE may still legitimately be
reported, since it carries the raw sum for wrong packets too). Is that
the documented expectation you and Jakub want the test to encode, or
should it be stricter?

Thanks,
Vladimir

Vladimir Vdovin (1):
  selftests: drv-net: add XDP RX checksum metadata tests

 .../selftests/drivers/net/hw/xdp_metadata.py  | 103 ++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++++--
 2 files changed, 202 insertions(+), 13 deletions(-)

-- 
2.47.0

