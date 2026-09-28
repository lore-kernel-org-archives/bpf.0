Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3606409638
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575714; cv=none; b=KAP+yHw/njXHtHXO2kv4kWfoC9eYhyNzX9Ir+SJes1gvMa8utyg0GJzQm3iChvdmanWh0YpqqJwLoYv6qnlwmeaTaqvX8fzFszCZpBOUkB+Xaio/EkRihVgPNIwLVW9/NmuaQpGqZPXhok7hGZZsGrubzexNnFlmhx8UAE+R4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575714; c=relaxed/simple;
	bh=xSacYG/s//nq7rOk4ehS+eCmfnhNqBswKprFKuR6Gr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptur51oqn3tAJuN9jGVHimSvqY8wa4gLGbIBoxirwYthlo9go/JZKnEqGWWHLZPYkcz//KaEOE9q6tsFTwE3sxTViAcAdAHnGGucor0DXhSPGtzkYiwmAQPMGOQ34cFOuCsjCA7G/X4bdMvz7RCyJV3CXrWf16FiGG6Mwkz10pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WDdsT37X; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WDdsT37X"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790575704; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=xSacYG/s//nq7rOk4ehS+eCmfnhNqBswKprFKuR6Gr0=;
	b=WDdsT37XQURMnN7Pd99GTTf5WqgPeEeGeG8ffCatgEmfmLPS+5ADVwiNyrulKmBq8cwrPguFDsEK1J+0Gy0GlNY3x1ZxaODc3UJv2qjdey858P8nE/27txSj0j3j19G1uPm3qFVW0NwOUPQJmg1eRQNcBZLrgYMaWn+1EHFqsU4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0XBiw5sh_1790575697;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBiw5sh_1790575697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 14:08:23 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: sashiko-reviews@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Enable gotox tests for riscv64
Date: Mon, 28 Sep 2026 14:08:14 +0800
Message-ID: <REPLACE-BEFORE-SEND@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d4591f24-a3fa-48b2-82db-bc78f933d516@huawei.com>
References: <20260928022109.1093-1-cp0613@linux.alibaba.com> <20260928022109.1093-3-cp0613@linux.alibaba.com> <20260928023109.5C1B21F000FF@smtp.kernel.org> <d4591f24-a3fa-48b2-82db-bc78f933d516@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.50.1
Precedence: bulk
Content-Transfer-Encoding: 8bit

Hi Lehui,

Thanks for the review.

> yah, should go with bpf_insn_array and compute_live_registers testcases

Agreed. I've enabled both testcases for riscv64 and they pass in my local
testing. I'll include them in v3.

Best regards,
Pei
