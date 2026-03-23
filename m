Received: from kansas-city-edge.smtp.mymangomail.com (ip74-208-171-129.pbiaas.com [74.208.171.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B016372ED0
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.171.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300802; cv=none; b=a4RSz3WrEd36G8JE84MXm1nM0sH+5H1PmvjIzaIJC9QINEMTL5YjYvDCDu/fe5mWWKLp08BHWz0DygwGRR/erAjeLCC0My8jNiMVwmlhusMtsEE1gKeD+qM5m5J17FR9u5RID/G/U9TZwwiYw1eRI8S0Gloso04BP0bERfLxaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300802; c=relaxed/simple;
	bh=ocR8arEr+uD87PB3qmhlQd+JAxFcs72/H7NVaTE3XbM=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=bEwD1hZEwtWwEzAPb0emPZwlvyABgVV2Qd9yaQPOg0VeoqFdIKN0juCg2mIDzWv9awOfywvLshhyo/qU9ghggThYOd0HG4kjv8DWeNzkd2xIGZKK13Nw7XIJV6Cd7vnAY/rf4p5SwBM4IuEJMxm1daRO7vBqgK3BZCf0bDdnLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gerlicz.space; spf=pass smtp.mailfrom=gerlicz.space; dkim=pass (1024-bit key) header.d=gerlicz.space header.i=@gerlicz.space header.b=GP0TQUQM; arc=none smtp.client-ip=74.208.171.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gerlicz.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gerlicz.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gerlicz.space header.i=@gerlicz.space header.b="GP0TQUQM"
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id 3AE7A5D9BD;
	Mon, 23 Mar 2026 17:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774300785;
	bh=ocR8arEr+uD87PB3qmhlQd+JAxFcs72/H7NVaTE3XbM=;
	h=Date:From:To:Subject:From;
	b=GP0TQUQMzRrsEoMppBtx+DENVrbJ5s93s/7ZddIr2VmRYhmfn8Q9loKLA8l4EpqKc
	 EYjTo3h+m+XfuQP1UnmFV8jDhPcKwwg4JZD+t74obeqUjPXNrZuSURl47nplq8aXzA
	 yuAbuckF4d9GIEgUrfYcA9Jb2AcPu1gLMkGdAlSE=
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
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 07C915D9B9;
	Mon, 23 Mar 2026 17:17:44 -0400 (EDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 22:17:44 +0100
From: oskar@gerlicz.space
To: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic
 tracepoint programs
Message-ID: <629d0324276759a1bda71248e93a99e2@gerlicz.space>
X-Sender: oskar@gerlicz.space
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On Mon, Mar 23, 2026, Mykyta Yatsenko wrote:
> Agree, the same point was raised by sashiko review.

Hi,

I have a follow-up question on the recursion handling.

Even with migrate_disable(), this still runs in a preemptible and
sleepable context. So if a task sleeps after incrementing
bpf_prog_active, another task could run on the same CPU and also
modify the per-CPU counter.

Would this interleaving affect recursion tracking correctness here,
or is this accounted for?

Thanks,
Oskar Gerlicz Kowalczuk
