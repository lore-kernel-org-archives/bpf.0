Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C3391E73
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977433; cv=none; b=Z/MyY9fqzDTcWIG9iwEMgvwHV8ex/jNKQ+zea6ziZkj4MnYE+dxyQWAb3Rra0DrdBFgvee/skOYdd1lYKa17dFBXrTHL6kri8/VAAp+xF/4oZ6FHkkatOHNTPVx9rwptdyaTWnW7Sa3QffXt7gp/teQwsC/lxg/zxgKfvHGdy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977433; c=relaxed/simple;
	bh=x+NXchhKNn1US8YrXfT7r36JzsNDE+4Gub0IBRuW3qI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UXnWpG/BoEf7px+wc1sTJ9Tfx4L9YA8HpEx8gxLL+mu4bvoKJaWNsx3ivy4MTsLxYTLg/1jNsVEN6r4bsBgSR+P3MlFRQi76X7IUI3ZO+Y/91aujeJAAFS/r1h7x+Pnjp/lvQ8MPZ4Bp3SARuj4u3C0PlXX1Abr/WyzKI782ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=GOTs+DyN; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="GOTs+DyN"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wfBsI-008gZX-DD
	for bpf@vger.kernel.org; Thu, 02 Jul 2026 09:30:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=k/IN9tcXLzYu51F95Z1lAvB5s8HqhNlgkhE8zPLZFAU=; b=GOTs+DyNXh0ZcGDa3DhMVkgtV2
	pfKxoXPzfzjmcrw9p1unujpaRVr0COWR5y1IjmoonxA4kb7JGv/FUlYldFDDDkJPOy9avF98i7GPm
	1h3T8Gs9RsM4SN7ULBwFKBkt9pyOYOYo3Ou6qHwPdxFkdafsgZ6W1ELt48ASHJdqPh0UDOTCdki3O
	0Q/roqzwW0H4Sdt452zMdgqFbATy2wcVrJjsV1bwk+UpiCFTnPeA+/5aU7pwcChBtrhDvYjuBHQ98
	/a++DQjcf2GL9cX46NQauar4Nvb+FPMRfa46/gwhmMZQ0skzhYRjrUH1+00shcCFTGzvO5/3IdO96
	NkETJIFQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wfBsH-0001sW-Rd; Thu, 02 Jul 2026 09:30:18 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wfBs1-003H6L-6D;
	Thu, 02 Jul 2026 09:30:01 +0200
Message-ID: <4541554a-1724-48fc-b147-d4be4b634cf6@rbox.co>
Date: Thu, 2 Jul 2026 09:30:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
 <20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
 <20260701233446.DC20B1F000E9@smtp.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20260701233446.DC20B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 01:34, sashiko-bot@kernel.org wrote:
> [ ... ]
>> @@ -759,16 +759,15 @@ static void test_sockmap(unsigned int tasks, void *data)
>>  		goto out_sockmap;
>>  	}
>>  
>> -	/* Test update with unsupported UDP socket */
>> +	/* Test update with unsupported unbound UDP socket */
>>  	udp = socket(AF_INET, SOCK_DGRAM, 0);
>> -	i = 0;
>> -	err = bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
>> -	if (err) {
>> -		printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
>> -		       i, udp);
>> +	CHECK(udp < 0, "socket(AF_INET, SOCK_DGRAM)", "errno:%d\n", errno);
> 
> [Severity: Low]
> This isn't a bug, but should this new code use the modern ASSERT_OK_FD()
> macro rather than the deprecated CHECK() macro?

It should, but it's a slightly bigger refactor. test_maps.c uses CHECK()
from test_maps.h that conflicts with CHECK() from test_progs.h (where
ASSERT_OK_FD() lives).
