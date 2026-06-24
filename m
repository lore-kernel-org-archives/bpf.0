Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F9371D0E;
	Wed, 24 Jun 2026 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336245; cv=none; b=iV5IDgtQEurLseZprF7vBmxbSiergYtIy6Q7SkV6i7Cvb4VTbOixj9/cbdbTo5e42ngJYnvUj8/424hhiw6Ajz4XPU1BzW7axtSogRVzbLyEgsLcayhy43wsQLGWOq4+eF8PLV+pfWmwaAH9Q7l058Q5VFQ+Fgk/Bbae1TEWz4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336245; c=relaxed/simple;
	bh=LZ6uvJ4/wvlPkVNuNVv98QEduTT1Zb1Pw/hDIUzw4c8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=elcOWKMxWSyyKGdF3ImyWSVlo7YY3TQmv5C47jbvslXI/Yi886HkYMF5j2aXyKFyN5QpxHAEgK1wNZUe7OSHcnqVPf8Ke6P4q7FS1A99CPDPMSF4dAvuKQWOcxk1ym3nMxgBPKJHNEe9BXn3+83LYLtSo+alDPW7k2rzowYIuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=N4cnugxK; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="N4cnugxK"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wcV4Z-0071dr-RD; Wed, 24 Jun 2026 23:23:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=zRExXg/2xKpyaZBKsbhm1YAA7S81C3fWbe3RBi1I51w=; b=N4cnugxKNpCHythSsB0WD2zPvM
	iIekjtb/wu5NvNEFjRKN/ZTzggdpX7JS87f/aSD/MX96iszVHTIqYJhEX0+un5+JwFBP7fDdmIHW6
	UFTbFOUaugh1Nk9gOWPi+jqk19cOpsAXjUoJqhpYwibuXnLbiozWTFlAuLTS0virOvCwWfGZ1xT/f
	F8hbVOR00pAtZbNloss0+mZRlnmcRe9XUAfhenia9QqG1Kza8pgd5v2C5AD3WFjnBKEQIvtVWWdbB
	5vVUCgjstz3A3duL4w8KaRPapM2cBcHiblHr8XXZgrKk6o78P9AxLYWdf+Q6b6sL5xGdN9Cq5cSkw
	EDEDq3ZQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wcV4Z-0000af-CT; Wed, 24 Jun 2026 23:23:51 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wcV4T-0038pr-6d;
	Wed, 24 Jun 2026 23:23:45 +0200
Message-ID: <bf5b90ae-4f7c-4a64-9fe1-73428c64608f@rbox.co>
Date: Wed, 24 Jun 2026 23:23:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on
 sockmap lookup-bind-release
To: Emil Tsalapatis <emil@etsalapatis.com>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
 <20260623190018.2B5A11F000E9@smtp.kernel.org>
 <DJGQQDCXHU7C.8HTXC4NI0134@etsalapatis.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DJGQQDCXHU7C.8HTXC4NI0134@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 23:18, Emil Tsalapatis wrote:
> On Tue Jun 23, 2026 at 3:00 PM EDT, sashiko-bot wrote:
>> New issues:
>> - [Medium] The cgroup file descriptor `cg` is leaked because it is never closed in `test_sockmap_lookup_bind_release()`.
>> - [Low] The `struct sockaddr_in sa` is passed to the kernel via `xconnect` with uninitialized bytes in its `sin_zero` padding.
>> ...
> 
> I think these issues are borderline cosmetic but valid.

Sure, I've fixed them in v2.

>> [Severity: High]
>> This is a pre-existing issue, but does calling bpf_bind() here mutate the
>> SOCK_RCU_FREE state and cause bpf_sk_release() to skip decrementing the
>> reference count?
>> ...
> 
> AFAICT this is actually not a problem for this specific test, because we
> fix it in patch 1/2. We have already added the socket to the sockmap so
> udp_bpf_update_proto should have triggered. It looks like Sashiko missed
> this?

Yeah, it does look like.

Thanks,
Michal
