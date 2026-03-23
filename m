Received: from kansas-city-edge.smtp.mymangomail.com (ip74-208-171-129.pbiaas.com [74.208.171.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B837E2E4
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.171.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301349; cv=none; b=f3jIwQG49nclokLDxi02kwlbGD0IN4yzALfMg3bCiBS8dqurK4vkOGNa0/gtIre2j8HM2biE1wY2tNgQ/8InH1OcjJCGHqdYZagYUzOCFCCRlRZoE6aqX80xt5dnYiMlIKxdzCTfOnzCnw7I4XYv7LAkoPCxjHZBwL/cBvaOWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301349; c=relaxed/simple;
	bh=zaNX0Z5MKkFSoUKBfZvCJ2AKJHFrw4FxeVogKekCOlw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=drE3B4sUmQpc7OeBOwIoLHZLLFUr9ANWUJhuNNnAgIvC5LfclYeBgN8uOgStylqXohPrZguuS12qbTPatxN+3jNiuhAIQmJ3hFv9DDtoXSfMf+iQQjrDc3G5nRCfEOdFHfx947T4k+d19dGrvosdCHspTf7APEBVKPhliiB01Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gerlicz.space; spf=pass smtp.mailfrom=gerlicz.space; dkim=pass (1024-bit key) header.d=gerlicz.space header.i=@gerlicz.space header.b=m73KaLgg; arc=none smtp.client-ip=74.208.171.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gerlicz.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gerlicz.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gerlicz.space header.i=@gerlicz.space header.b="m73KaLgg"
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id 16A5D5D9C1;
	Mon, 23 Mar 2026 17:28:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774301333;
	bh=zaNX0Z5MKkFSoUKBfZvCJ2AKJHFrw4FxeVogKekCOlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m73KaLgg8Z4RBAUPaEm6XLBdvlEGRRvH37vv0PNlmHmBSfHK1BPBpIglQ/Bxoajgo
	 SZGxdPGYu2E1ySkwBSuu0RuVUhT+87xcKv1hbVMK7hsZDGTdi67qhgzsT4f3xlGvsE
	 j1RQ8YFMvtf8OzRVlk5jYvc+KJB1piZ8tlSrPJyU=
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
Received: from authenticated-user (smtp.mymangomail.com [205.185.121.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id EE9AD5D9B9;
	Mon, 23 Mar 2026 17:26:54 -0400 (EDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 22:26:54 +0100
From: oskar@gerlicz.space
To: mykyta.yatsenko5@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic
 tracepoint programs
In-Reply-To: <629d0324276759a1bda71248e93a99e2@gerlicz.space>
References: <629d0324276759a1bda71248e93a99e2@gerlicz.space>
Message-ID: <7560779e22010c1907fe6045ef595d19@gerlicz.space>
X-Sender: oskar@gerlicz.space
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> +       if (unlikely(this_cpu_inc_return(bpf_prog_active) != 1)) {

Hi,

A question regarding the recursion handling.

Even with migrate_disable(), this still runs in a preemptible and
sleepable context. So if a task increments bpf_prog_active and then
sleeps, another task could run on the same CPU and also modify the
same per-CPU counter.

Would this interleaving affect recursion tracking correctness, or is
this accounted for?

Oskar Gerlicz Kowalczuk
