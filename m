Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740864;
	b=euhbkRYVPhnE2PhMHCvE3IipnrObLX84bcbi8ioMDDz23pD8gQTeZuEK18FkWjtFa9E3
	 Y9xgmMjZvHD8gggp1UGfm8Wb6eVkkaWVhB6LQxtV++EA9GsNKneGTqJf4yG5dABCUbiz5
	 RVziAjkx+sJWYmAJjcR9CdeZFvYpo4t5Wf5YqBryaT/VXT2wTnuuqV6un7ZsXUsUUo4Z2
	 U75YBKf6DTwJKZJj0tluOWrfY2aTFfN5pt9susIbU8/WTzy/wCxxW0KvKCfnH5W1oqLQX
	 MPHeP/Yxj9ldyt78vp92bqsHeC9TE/9qNDAB5L9HkrJ/GAOZKiqf3J3Veqek2ks4oAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740864;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Oyxbvr7lEIaNAb3MoGhHVG5ZkYUYaADS61wDhzBXdXs=;
	b=poeU8fIksA336rpfqNw9zH8fJQrerqd8l4sPzJF1wa3PDCtflQEzdEtgAcnVZf0GfGGK
	 WK5AtHqsJ2d+RtqBb6m8ETyyaEERjcnIIe5kAQ9QsKpnd7geMPPOtY1yvtKq43NkYCZ9p
	 5TdKfbOMZi2OpLjrxJxaT7hfSdjlqO8BkF1KjpBRi0zCbLqTBVqk05DKFjxvDnUgF1Tvn
	 +6LpMAxEq+Lgt0yiQghZJqaU3y9G7hpL40AL2/TRXgM1oro6EreEAB5eT0VMjsYrH9xeB
	 mG8jpVaypAwOyFal7BBe2RlkNPkLXed5hlfhvPZLttiCv17scKXxngGJGq/Sv//stng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mZVO7Vx+;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F3606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 07:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A17F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mZVO7Vx+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Oy
	xbvr7lEIaNAb3MoGhHVG5ZkYUYaADS61wDhzBXdXs=; b=mZVO7Vx+LImU6LbXSg
	ipEFyUj3USBcHrCD3UrZc0ZvrEyUFYkJ5n106Q9THDA+mwqxflQXhHNLx7bjcGrc
	+suHSkpGyn0JBJy3Fs50Vm6n6DkulPqP3gPgNKnKE7P4AzgjKlxYhb/JCeNYt0vp
	i/1Hl6S+Lq4LZ77FQYRoOZaZE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3nxfnDdtq5rowCQ--.8275S2;
	Fri, 23 Oct 2026 15:33:59 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	yangfeng59949@163.com
Subject: Re: [PATCH bpf-next] bpf: Fix out-of-bounds btf->types write for split BTF
Date: Fri, 23 Oct 2026 15:33:59 +0800
Message-Id: <20261023073359.642990-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <sashiko-outbox-182361@kernel.org>
References: <sashiko-outbox-182361@kernel.org>
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
X-CM-TRANSID:_____wD3nxfnDdtq5rowCQ--.8275S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUeUDJDUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8QgPh2rbDegT7AAA3a

On Fri, 23 Oct 2026 06:46:07 +0000 sashiko-bot@kernel.org wroted:

> [...]
> Should btf_check_all_metas() check and propagate the error returned by
> btf_add_type()?

The previous patch at https://lore.kernel.org/all/20261022064727.747304-1-yangfeng59949@163.com/
has fixed this issue.

