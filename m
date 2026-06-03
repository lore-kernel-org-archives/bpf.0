Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8691DDC3F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451707; cv=none; b=WPV/B7V/5KdkICwVGD7bX7VyM+nm6y2B0uS8rGqBzQ9afpYTbueaE0GmArEt4zTQ+I+9vsKDRSnh4Q7PLDwTt9x3QYv8OxdnJKPn9R8K9ycBtcYWNLjbMHUEFoorVm6Lv58SJ8OvqvNQH5Ue37WjcWxbgI+upajMN7tpBQxG4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451707; c=relaxed/simple;
	bh=UEVXsKZ8mZXfuja/5unJYxEXxoh9gZ1JWi9ai66EFVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRxQZL4CUS+Dq6MGMKu6zks6cqT/FcDjG8zM/Dv0wc9ESX5tVw7zPvNC3DMb7GnreqXRa8AClIUEh+iEerijtRRT8p2zaPWUnfIBC9d1jVyjLFAEx7Qtw2fYYDbw6zrAEYKleVvSzlgcY/B/RH4aoIQcV4aUtM3wIXPZUJJqXHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RBuWy84l; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RBuWy84l"
Message-ID: <e887ebe6-937e-46f4-a914-9f8215887863@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780451703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrTTyWB6pY14Se03EZXE5CLDQqYFbDmLGtAAKIcnZ4E=;
	b=RBuWy84lUEfY4Rkl+eSRJ5jRtv4fENsug8vZl65nxCFfNgKjHoY5eCgKISByjY9lG+vLUV
	jOeB2iPh9K4y2oUuyRgjZUn9/B4DD35wXm3/Ygs1yC5XOQA9ofhrDzHNvM9Xxkr26rQWBS
	ykgfdd3M9DqIpMdRq595ljC5Xm6H7JU=
Date: Wed, 3 Jun 2026 09:54:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260602150931.49629-2-leon.hwang@linux.dev>
 <20260602152356.C87F11F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260602152356.C87F11F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/6/26 23:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing IPv4 header length (`ihl`) minimum bounds check in `bpf_lwt_push_ip_encap` allows denial of service via `ip_fast_csum`.
> - [High] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in `bpf_lwt_push_ip_encap` due to re-reading from eBPF map memory.
> --
> 
As Alexei suggested in v2: right now the priority is to fix the issues
that normal users can hit and not bots.

So, this series aims to resolve the VxLAN packet-drop issue caused by
stale skb->transport_header on ice driver, excluding the issues reported
by bots.

Thanks,
Leon

