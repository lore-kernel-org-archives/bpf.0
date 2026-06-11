Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCF19DF4F
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781141778; cv=none; b=bi/IVtI6zLTuqU+MF3uMN3+oBETsVY9KjapseXYaV8iXiCwptDcDHvombfJJDL8Lm3SRlG7PzNOwrCazZR0ao7H8eABOSHOHs1b02uUITdO3567etQZebYRFI0f7wbIh2EwzqLLNMlXfGqFxJWVfZSu50vtOMxZpP2n8QF6773A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781141778; c=relaxed/simple;
	bh=pYVDpAnTenU9Mvczs98nX4U1G1mFl/znk2z5FkrpZ/w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LvAJqTuZD3IU2ONcIanPRH/BDJ/SWQhPFXEW07rYE9YIJgMxayMQazypxx0ZM27nhFy2B4JRAuasNcANh/VCsiwCTV2Dev8MeBQNnAzQedgHxo5WnQTSc3/oNhb/Bcc31PAdofN2qbfGjMxxNvwTEgaTWGe+dmHY/eDB9OqISqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITt4pvlO; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITt4pvlO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781141774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6nensey72qM9bt0+fEstk1O07rm/WrGrJ21XH6l0KJk=;
	b=ITt4pvlOGG7u1KEcf/lsmLUZAigcX2LC+VXH6+A9EVSjIasEs5vUh3Go87/dBxx5UXE6TJ
	ms4coSHOn0I6OcB3M8pvUl2zJGqY2g2uFBRncbFBt5hxoZjEmsRbkL65rBWe9kkxY6ABjj
	FA/rzBcdVEbUZ5twjBILYdI+f12ppFk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Subject: [PATCH bpf 0/4] bpf, skmsg: some fixes for skmsg
Date: Thu, 11 Jun 2026 09:35:43 +0800
Message-ID: <20260611013547.247039-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


All fixes are from previous patches sent by Weiming Shi and Zhang Cen,
which have already been reviewed by me and John.

https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/

Weiming Shi (3):
  bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
  bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
  bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

Zhang Cen (1):
  bpf, sockmap: keep sk_msg copy state in sync

 net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 7 deletions(-)

-- 
2.43.0

