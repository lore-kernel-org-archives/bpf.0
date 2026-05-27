Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594C40FDA0
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889238; cv=none; b=r1rquHkG50qA6vkUPkOVe5ybUYJUzd01JYdo0SSKLMJlO65J+SbdzxvApycaeRHtmJmEdIvja5OLREE8V+ninP6e4mgLxKrVHhTFxQ8JIbzaY6TtspNmWIWSKNrhwD/9OkRoB5NX2garBrDSnjAe4i0w0S3JxIDSIHpotK0VuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889238; c=relaxed/simple;
	bh=zBnqFwJS2yVjxtoW6v1LXOru0S4kJQOnIYkjY9t21lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN9t2pdWMAL1aJ5yp+0iAX9vOFQ/MmD/E4HknWxpSqvMvZq9p6D1TK2zYYRhhi+1+u/bCP0SQ5EVk5LDTUJeICneNRGvJkrDbQjH+ZPCfXOK0z0HZu2p3VI93wwrhwgO9BzcgbMqsShIBcV6yFRs8jg8zBQg5H+zwZv1Yi/AH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rtuUcI1z; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rtuUcI1z"
Message-ID: <69d589a0-dcdd-47b5-905f-f7b5d3c483de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779889231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVk4BypCf9T7mGm14228pz8b/IEOnfCruXIgb+bymeM=;
	b=rtuUcI1zvNmMbIOu2COoCh5d9DWqtYhmO1GeEQ95sk4WArtnenPz3mDMGoWyuOQe9qTCL3
	Ui3OPDTJ+i51SqN0KAWVxY2crhc2ClS+xiY2Ly0qBtk5YsUAPk0UWRyNzACTx76e+LV/EC
	HU6jFq6+11m48Qoo9AtE/4HE61Vl6X4=
Date: Wed, 27 May 2026 21:40:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add tests to verify the fix of
 encapsulating VxLAN in lwt
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260525142650.2569-3-leon.hwang@linux.dev>
 <20260525151755.035AB1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260525151755.035AB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/5/25 23:17, sashiko-bot@kernel.org wrote:
[...]
>> +	 * Ethernet frame uses a broadcast dst MAC so the IP stack accepts it
>> +	 * without ARP or FDB configuration.
>> +	 */
>> +	SYS(fail_close, "ip link add vxlan4 type vxlan id 1 dstport 4789 local %s dev veth8 nolearning noudpcsum",
> [ ... ]
>> +	return -1;
>> +}
>> +
>> +/* VxLAN encap tests (IPv4-outer and IPv6-outer variants).
> 
> [Severity: Low]
> This isn't a bug, but this comment block also places text on the same line as
> the opening /*.
> 

Will update all the comments with BPF comment style.

Thanks,
Leon

>> + *
>> + * Test 1 - functional: the BPF LWT xmit program encapsulates the packet
> [ ... ]
> 

