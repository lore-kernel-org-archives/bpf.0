Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78D3033F5
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394185; cv=none; b=ZAeLN89lrcCDbmkXeu8QWNLhrpqEakmwJSAoO6rV+MTVoufbmhPZ7Xdh/0faSqA7HqFnxCWRyeDs4raQc1e0Y1YFqdIeQgOb8XVgOpqTZqWCOd3UnGWO6R5vE4IRS3BnVKIwqmh1XpZLFmqH3sqkN4slXYDzFcAPdbOo8OBzh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394185; c=relaxed/simple;
	bh=kKvhR4Sy/FyVK0ouToIj4Luo3WEGl2vEa7H5OHFLET4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lobTOUT2ruPaZDWewZkLDRIFddEdILmitr+zeR2VHGNgJdCLoJY2cbxncI+cn4+xTIanuhFFY3QrYgx6JeFeOmynnH+oFCaDjKch5AqNDrMRzXwL5HAAxrxhx+hewncEibg0CDOsgdOXrJ4Gc68TEiCo2usyDzQU4xmIu8DhAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bW9BrJEf; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bW9BrJEf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777394181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Cr9IdcujjQrXcfxbwzSQNhzqsNG4ekgaxSa1GmQWbM=;
	b=bW9BrJEfiNRXw9wVleUkOQUycSgOVtGPI58dwQeqXqBz41YpAbRZ4sg8VMDlKaibWw0IBV
	eJqFVMBloqZSmmiBwGcEMnQJJR5hLLG8y3JMYYiTH8H5kZVglYUQc+ggiR6rphQ74R2LD9
	R9rEpP4qIplSronShsTcXldtmkNZjGU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: bpf <bpf@vger.kernel.org>,  linux-mm <linux-mm@kvack.org>,  Vlastimil
 Babka <vbabka@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Andrew
 Morton <akpm@linux-foundation.org>,  lsf-pc
 <lsf-pc@lists.linux-foundation.org>,  Daniel Borkmann
 <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] Using BPF in MM
In-Reply-To: <014f3c0a-7c6f-4f64-95cd-b7b69d804880@kernel.org> (David
	Hildenbrand's message of "Tue, 28 Apr 2026 10:12:16 +0200")
References: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
	<014f3c0a-7c6f-4f64-95cd-b7b69d804880@kernel.org>
Date: Tue, 28 Apr 2026 16:35:52 +0000
Message-ID: <7ia4h5ov6o0n.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 4/28/26 01:57, Roman Gushchin wrote:
>> [LSF/MM/BPF TOPIC] Using BPF in MM
>> ----------------------------------
>> 
>> Over the last decade, BPF successfully penetrated into multiple kernel
>> subsystems: started as a feature to filter (out) networking packets,
>> it captured its place in networking, tracing, security, HID drivers,
>> and scheduling. Memory management is a logical next step, and recently
>> we saw a growing number of proposals in this area.
>> 
>> In (approximately) historical order:
>>   - BPF OOM
>>   - BPF-based memcg stats access (landed)
>>   - BPF-based NUMA balancing
>>   - eBPF-mm
>>   - cache_ext (BPF Page Cache)
>>   - memcg_ext
>
> There was also the BPF THP control.

Thanks, missed that.

>
>> 
>> There are some obvious target which haven't been covered yet:
>>   - BPF-driven readahead control
>>   - BPF-driven KSM
>>   - BPF-driven guest memory control
>> 
>> Despite a large number of suggestions only a relatively small feature
>> (query memcg statistics from BPF) made it to upstream.
>> 
>> It looks like using BPF in the MM subsystem comes with a set of somewhat
>> unique challenges and questions to be answered.
>
> [...]
>
> I think you are missing one of the most important points: Unclear ABI stability
> guarantees.

Totally agree, it's just not specific to mm and is not very new.
Arguments about the ABI stability are almost as old as BPF itself, e.g.
a quick search gave me a lwn article from 2019:
https://lwn.net/Articles/787856/ .

>
> One the one hand, we are told that there are no ABI stability guarantees, and
> that we can change hooks (add/remove/modify) any time we want.
>
> On the other hand, as soon as there is some ebpf program out there that we
> break, you can rest assured that there will be trouble.
>
> In the area of THP, where we don't even know which hooks we will need long term
> and how they would look like, that was one of the reasons why the BPF THP
> control was rejected.

Agree. And in my mind it's also related to safety/performance tradeoff:
if we use very generic hooks/interfaces, it's easier to keep them stable
and meaningful, but then it's hard to guarantee safety without
performance sacrifices. Or we use very targeted policy hooks, then it's
much easier to make them safe and performant, but they may become
obsolete very quickly.
