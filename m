Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC73BED09
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858076; cv=none; b=rBgWJUpOcVA2l2Jr86qPLCiYDa7HabMNzD0Ts+ym/hS7md9GHfFCAsAHBphmvBCJdEOBL9cPCN4CR+47Wzdoxi1HR0MEuOZqCk+Bjb/KIvOmDxrv8GeH9U5MmDxSeWV4VtsV0Iz6A7hhDlicrbIjD3IulELqridcq3walvhFujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858076; c=relaxed/simple;
	bh=zVco1oKDcUYbgBsCcrdJK+9g+/5yVaZdicz/x62jtC4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pOYAyuAkgY39mM4J8jPSnsAvSg4t5MjStEF7KDyrFPBDUYOMaNWDzkGpWl0nrzfVVEpNX4qLzv/OzPQvBtCL876m7LN1PJxDFvvONb2S5rl7NzAGo+VQaNimencrb/75M5PUUm3yLhBEuA1KKjnS0vwHv9qB4pxJyqCPaynzFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EpDa4vtK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EpDa4vtK"
Message-ID: <57882bac-164a-46eb-a4cc-51c66823d82e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773858073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zVco1oKDcUYbgBsCcrdJK+9g+/5yVaZdicz/x62jtC4=;
	b=EpDa4vtKdSvcm7k9B7h0uqPn7MT1hiI9eLOUhs6IZ4WmYBYgGziOyi94exehh95WbkS2+W
	Uwxt+CRFxDhJc5Gn+dyUVgBPC8jr/cG7GF+xAYoBzTvcCsIJUgaHEZyAQSLryTAfl1U2pA
	4aEEhE4VFOUbdVUqHxIrgYs6SjQlm0Y=
Date: Wed, 18 Mar 2026 11:21:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
Cc: Kernel Team <kernel-team@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: [LSF/MM/BPF TOPIC] Support more than 5 parameters in bpf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Currently, bpf function calls and kfunc's are limited by 5 reg-level
parameters. For function calls with more than 5 parameters,
developers can use always inlining or pass a struct pointer
after packing more parameters in that struct. But there is
no workaround for kfunc if more than 5 parameters is needed.

I started to explore how to support more than 5 parameters
for bpf prog function calls and kfuncs. This involves both llvm
and kernel bpf. I would like to present my findings
at LSF/MM/BPF.

Thanks!
