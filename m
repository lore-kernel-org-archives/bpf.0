Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392B36B07D
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926245; cv=none; b=qHYUHFJU0VVs7OGCESbQ+9GJiSTJWOp7JVSaFSHTltP8ahbO1IQoCvuB6vop5bGMwo26xUKOVlaA46zKSRAUg69qVWWA11XU6LESuJ5u5uPCcZ1FJmrvzDj0knDBIC9cjfyVwHm/d5oeM8haazYlA82AuKV1Wi8bpO2nH7oRsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926245; c=relaxed/simple;
	bh=TdWHCJGxiNxPpYkVdyej/lHl0mRtn3vydtA+b0GEnVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1PDtHk/sejmfYIsDHuegpcA07wZxEKxvWM55fgvdAdbIXHJgaagDlSQLZcUKqXvLog7uLbH3DVtPibyJzMznE3k/A+GUtsYs8ctU9rEWiGBtKllkgttxPdiJMuCSm3tnlH7T6COP+lpyg0nIvPLZY+9OZJ+kHWvhivYNMsLY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RHNHd4GM; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RHNHd4GM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1771926164;
	bh=B3VEdznsWpkfDr9QKXPiM7eIhmuJf0hm42zxkoDh9Tc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RHNHd4GMDvdprytjeVC5p5mvSyblFwun80K8JBA1iIc1u1S8AObeJ6BkcDVF9KC3A
	 glBmla5/pxrycSp0SNgDpqa5O8JbsI/H8m6QQpLhNoN8SJmK8P3eXEo1FNg7rhLwZf
	 u7xdij1aGQJSbJj7duwNvUrR7r803wpOTvSCO+HU=
X-QQ-mid: zesmtpip3t1771926146t24e36ddc
X-QQ-Originating-IP: 8DgyCkKmQ8gI8soOqRKhNCZ2MVC+RLoqo76mD8B8V9Y=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Feb 2026 17:42:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16782320365479766795
EX-QQ-RecipientCnt: 10
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dddddd@hust.edu.cn,
	dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com,
	kaiyanm@hust.edu.cn,
	sdf@fomichev.me,
	xulang@uniontech.com
Subject: Re: Re: [PATCH] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
Date: Tue, 24 Feb 2026 17:42:24 +0800
Message-ID: <3D1D15D636A13931+20260224094224.591202-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <64e56f03-bc93-46c1-8d5e-fa9720821620@linux.dev>
References: <64e56f03-bc93-46c1-8d5e-fa9720821620@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MACXe2l6e7j9suffBR7ouw1RChuqitQ72jA2/E65UlSR7CyVjJRcGhfE
	1abUtOH58T8xHgC32k8V5+1vYm0p69GBv13HkuPvMrMYf8JP6LgiNH16W9snWZvUcUGKm+n
	r1aWwak/bRtSIZN3seVLXk4LaIpooTIiyono6a95c8oUFj3dx3jZHWomJ+WW0dcxsMt6KmU
	ST7X2YfqQLzFyV2vMFarY5qEPPjObZf5CErTo1xPXqQibqlsS5ukLiBWP9hKstNMrneAVfG
	Rw9iJSAfQmAi0dmDrIfo1bsIzdYuLDpOmOg03cguPCS/eAlm9a+pSGbS17tN6fHOUb/OprK
	cGE3UocV+5fRI9+W0Xy25C4m1f9jLws2QQ9xTu0dyZTfy6601NsZnvwlax5+NGRpcto0rYD
	oxQTtgqjvyBfYRXngr++KV3KxGalphLJChQEWk4I5PpVC1mI2Nl+/cg5++RKT6jj0bQvOvT
	0PsTjOs9aBau6Sznxtj26x9CdJZBJBlTXyguddwZsplCOQetDccvjJ+lvb0OD7I95xFw9lE
	JxlZHfk4+vtp8Eucrxq6ig+Y6ley8IzWZ2Xi+EtdztiUCApCjf491U+ouFVTmgUYex/vygQ
	fU/B4xaP/yqL4T+KCYM/rTDgPngL+7kRgt05eZXiW+E5cg2dl71iaW0e6GFolyHr1bw/WOz
	XKjA94+TWs0+QHu+7BADymCvOWBwv/hJUitYz0z6UFdofcYCMADCRjUXOb5sVtPr/k6pZcZ
	ohjKbc0huwBacz51vpm7Ty1A5WAHoXjmUB5vCaAI0h5kzn7090z7jq2nUxPzrT/k5pFNzHa
	yW9KiWEu0t9CbrBYq18Kc/MWqOGo3X05NQxF5nr8PcvSG9UmtPbhkVoB/j8X7Fxg6fjE3uK
	lNW0KmCAtGT/Q38LpJjeS7yabDXKHCRn3LxN1aU2QtaQwQUMJfVeDlagqVg+BOorgzmDICB
	wUhG8WarGvFv1YCXv00aGzbjW76eutbZ36ZvxyAJ/8qXxegTE4EwC/mk9JF0+QTGgu+LXdG
	qOGqVOnQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

> I am not sure about this one (details below).
> 
>> 2. Guard the freeing of `shim_link` with `tr->mutex` to prevent release
>>     while the mutex is held.
>
> The link_release is done before the link_dealloc. Why it needs to hold 
> (/wait) for the tr->mutex again?

Yes, I realized that later. There is no need to guard the freeing of `shim_link`.
I mistakenly thought that `shim_link` might get freed by dealloc between 
the mutex lock in bpf_trampoline_link_cgroup_shim.
