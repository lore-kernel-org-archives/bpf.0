Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF03BE174;
	Fri, 16 Oct 2026 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183730; cv=none; b=i7xVO903P4SdiVC2kp9+J+g9Mf4zXUWNYjRy1WP/MsWiU39EdW8w7R0Sffy589gG6hqhwL6FhE2GKHDLNivfEbHsb9Z4RBw3gB7Of58EIOeu3MC0LnHbK/zpx48BroIZTgT1vrZyyNew8gxXc+rj3fWdST8izlWxax3+s4jKiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183730; c=relaxed/simple;
	bh=MwT4uQ8X9dwS7k1GmFi/9aZWXsVVi4PbTuzNd+6OkcI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dnkhadCH92uvCRDnBlYxX32Oy7NL9JPyOfuAY3niTUBmg9duygpYOeD1UrtTlfwTtEWsP8yU+2tjRsgFsLJdG394dnKkAjURMKZgIDtsYAeP7pdyUXUhcjbQDGbBdyf3A62F0ND44NNhNw4KEdANBBwN2NLqWXSeQMk8oSzYpyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLTZDQyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLTZDQyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7756C1F000C4;
	Fri, 16 Oct 2026 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792183726;
	bh=JnmJjyErL28tJ8WeUrKz+eUUMHw+JRscixniM3WmIzM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=JLTZDQyioCMdn3M3Pypm7TuS4vHyfWGc3je0i5HhR0UabPgFafBVwz+K1EwHDz4B7
	 7GW7ZskA9Tu8G3DGM9zaS/XQz+QRMRF0lyhpemsdrWIcqRl8uvpCpJsddzbtzlGtNw
	 /sHkVNtmPI8oGe7S7HU98iywEHul4u9Txo1U/oXw8OFoTFAAaS67gltPvqm441Oomx
	 UphK4qXD4wTlU+4nxJc+8Z3toQvACqQPOsqMHb491MnU/SUwUV4eQqe7gGH1RAKX/W
	 NIW1O5F1j7j7+vrEu5vexfkTV5GIHJ7Sjz9GPpBeBqW/5nZQpjHyEan8awGb6KAGdT
	 ihUdvCsVhwXxw==
Message-ID: <657e92be-49ef-43ab-9631-c4514b0ae61b@kernel.org>
Date: Fri, 16 Oct 2026 21:48:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpftool: Reset map info before each query in
 show and dump loops
From: Quentin Monnet <qmo@kernel.org>
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, skokovmaksimevg@gmail.com
References: <cover.1790615923.git.hi@tychen.cc>
 <14f8779c59411e88bc320f1064a94aa580ca5be8.1790615923.git.hi@tychen.cc>
 <0e477c5d-4fa2-464d-bbf0-853804fa07f9@kernel.org>
Content-Language: en-GB
In-Reply-To: <0e477c5d-4fa2-464d-bbf0-853804fa07f9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-29 11:28 UTC+0100 ~ Quentin Monnet <qmo@kernel.org>
> 2026-09-29 02:13 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
>> The kernel copies bpf_map_info from userspace and only fills in the BTF
>> fields when a map has BTF. Reusing the structure for a later map without
>> BTF therefore retains the preceding map's BTF IDs.
>>
>> Clear the structure and restore its length before each query in map
>> listing, named-map listing, BTF detection and dumping. This prevents
>> reporting stale BTF IDs, choosing BTF output for mixed map selections,
>> and formatting a map with another map's key and value types.
>>
>> Reported-by: Quentin Monnet <qmo@kernel.org>
>> Link: https://lore.kernel.org/r/3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> 
> 
> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
> Fixes: 99f9863a0c45 ("bpftool: Match maps by name")
> 
> Acked-by: Quentin Monnet <qmo@kernel.org>
> 
> Thanks for this.


Hi Tianyi, sorry for the delay, it seems your series somehow fell
through the cracks. Daniel sent a fix on kernel side for this [0], but I
think it's still worth getting the fix in bpftool as well, to avoid
hitting the bug if we run it on older kernels that won't have the fix.

Would you please send a rebased version of your series (and drop the
mention of recursing dumps in patch 2's description, keep the Fixes: and
Acked-by: tags)? Similarly, can you repost a rebased version of your
patches for the batch lookups for hashmap dumps in bpftool, please?

Thanks,
Quentin


[0]
https://lore.kernel.org/all/20261016191635.662690-1-daniel@iogearbox.net/
