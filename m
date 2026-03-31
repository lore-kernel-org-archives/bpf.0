Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2D2D9EC2
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 04:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774932007; cv=none; b=cW0o6j91z+1trfn89teJ+mun6OhPd1u0japs1PdYK9Moiz54dst23tv51pj2kmE3Z59DNsKLqwgpjxl+Gy4Py2zjCA8aBcREYf1JBQ82T1HlMit8OL2rPLmqymWLBpswh/kVXsJjagz5uhbJjMZdvfM7bbOpuXBfCLrIeZayc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774932007; c=relaxed/simple;
	bh=fOxxIqdTFJP3A1Kw05cNCMMVFmFtmA9Fw2d0z6cJvQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUblgEK0v1xjDMze0linzZpsuPgur8ATpmBqPuZ0+vBEEjQgxSbJaxi/4u+EF0ZIIi9DDEw5MpZ2cfNU1mwe0l29DecKzHsaCCRAeGXQaga9Ws1jB8Dhrba4YWR1zSyrApT+Ksj4MdWR5hmI/LnuccicocyzR8cXKbHsU3SASk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ac4OBR4X; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ac4OBR4X"
Message-ID: <c12eccb7-d0ba-48a2-ba11-59d25958de92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774932002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KG2i2dwHTF9049hVg810gwOO7gmVlQK+Qd6p0/S9A0=;
	b=Ac4OBR4XylNXzIUUUvReB916Q/KhQa9TgpggnLw5g53ypRci/C/jk9zxEh4nJHAkb0cDcY
	u1QmdGg40O8wXlPTWWTCfkQIh35bbKALuJFRmGbqZEZot9YWJJj122o/vY5zf6lwRWiZBe
	MvEwabQtcBL/wx/4x+RvJeB4c0bVh3U=
Date: Mon, 30 Mar 2026 21:39:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
To: xulang <xulang@uniontech.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, dzm91@hust.edu.cn, eddyz87@gmail.com,
 haoluo@google.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 jolsa@kernel.org, kaiyanm@hust.edu.cn, kernel@uniontech.com,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, paul.chaignon@gmail.com,
 sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
References: <6b534263-62d4-4a0b-abbb-69286ef689f4@linux.dev>
 <FA0A9158227E9982+20260330063228.183119-1-xulang@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <FA0A9158227E9982+20260330063228.183119-1-xulang@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/29/26 11:32 PM, xulang wrote:
>>From looking at git history on pcpu_init_value, the issue should be
>> introduced in commit d3bec0138bfb.

> I've tried for several days, to adjust 'offset' to match the 'data_end', but couldn't
> reproduce this OOB since there seems to be always a 'tail room' after the 'data_end'.
> I've checked how the buffer of a 'skb' is alloced, take driver 'e1000' for example,
> it has many complicated round-up operations, in my test, when I send a UDP package
> with payload size less than 210, the alloced buffer size of a skb seems to be always
> 448, I've also checked the validity of its KASAN shadow memory, it also says 448. when
> I go on increasing the payload size(over 210), for example, 211, the buffer size grows
> sharply, I haven't found out when the 'data_end' reaches the 'tail end' yet, different
> NIC driver may behave differently on the 'tail room'?

It is hard to audit all possible sources.

> In my opinion, 'pcpu_init_value' shouldn't read 8 bytes if it has
> no guarantee that the 'src' is rounded up to 8-bytes.

so make sense not to read more than what the verifier has verified.

Before commit d3bec0138bfb, it didn't round up.
The current pcpu_copy_value() also uses copy_map_value() instead of 
copy_map_value_long().
