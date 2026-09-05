Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5537BE98
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788647080; cv=none; b=SU9THIcglJCQzt/EM++8HyC1/Mo9uwqwqTiFLD4pMJoWe44ZJgBMCiynU/5RsQdfkx+qwNscaLXOHNoICHZGCteYk0FRvTcsO86c52QyBpjOHufSsrDNK8S8Yi//xBVgigzh5arVtSN9JPK4S3cQZB6ZAQKTQBzG79x8NotcBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788647080; c=relaxed/simple;
	bh=euymEhroWZ9Lxa89VdU44nzhP3mvslqrXMiL6PZkZrI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ITjWNiCYABnOsz4qPhKfyLIgcezIsNulHJSINp/42in6wDow2fh17rMZsEOGHN57dkGSGR97cxmYnJHbKLUzPFVRp02usFRI1+dt+Kc7VFsHQQjea9QtyspGtyVxqyLx22xzqpBxmBIOssWMi8B5ZTdMGmRxMae/28dFFoOrD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=rkYVF9GI; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="rkYVF9GI"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x2yoB-007naf-LG
	for bpf@vger.kernel.org; Sun, 06 Sep 2026 00:24:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=euymEhroWZ9Lxa89VdU44nzhP3mvslqrXMiL6PZkZrI=; b=rkYVF9GIy4W7DKuddlkx7Kjee6
	Hxxm7jOKW85dnAhAG8DIUsZsKNSgvushqjSs6B3dwEA3cvBO1RhE2Si1wS0W3M4YioGBz5i2QSueC
	zRUY1hY8ZJVzTKUus31ytB6yTHSBjzvLg0UhmZT5b0kaFz+g+bO1gcrl+dXJBrjUwsLTTz6bnTws5
	lVomFK64W9s4+uyvB7diP7v8s1+EUp6IZoqcYb72ZUsSJXfqKzgKzO4mSkJkSaBCxhRYqA07JNGnr
	tpeugPq8buT9WRMvgBSxjygjlhbD0Bi/ijbni/9RKHk6P9taClcO0bi3CM2mlnztsutv2SnmxpnTn
	oWkcaYzA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x2yo6-00010j-9o; Sun, 06 Sep 2026 00:24:18 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x2ynm-006yaA-KJ;
	Sun, 06 Sep 2026 00:23:58 +0200
Message-ID: <2bf5493d-a87b-40b2-bd3c-4d726da9af9e@rbox.co>
Date: Sun, 6 Sep 2026 00:23:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v3 2/2] bpf: Fix reference leak in bpf_sk_assign()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260902-sockmap-lookup-tcp-leak-v3-0-b998b3d49d07@rbox.co>
 <20260902-sockmap-lookup-tcp-leak-v3-2-b998b3d49d07@rbox.co>
 <20260902183840.9756B1F000E9@smtp.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20260902183840.9756B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 20:38, sashiko-bot@kernel.org wrote:
> Pre-existing issues:
> - [Critical] bpf_sk_assign_tcp_reqsk() stores an unreferenced pointer to
> a TCP_LISTEN socket inside a request socket. If the packet is queued via
> NF_QUEUE, the listener socket can be freed, causing a Use-After-Free
> when the packet is reinjected and stolen by tcp_v4_rcv().

Right, that's another bug. So either make bpf_sk_assign_tcp_reqsk() call
inet_reqsk_alloc() with @attach_listener=true, or orphan reqsk whenever
listener can outlive the RCU?

Sashiko is quiet about this, but doesn't bpf_sk_assign() have a similar
issue? Commit 3b836da4081f ("netfilter: nf_queue: handle socket prefetch")
fixed NF, but other RCU escapes seem possible; e.g. skb_do_redirect().

