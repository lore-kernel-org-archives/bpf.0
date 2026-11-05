Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874335;
	b=INE4QXp14So0JutxnEVxr5zApi4mv0jS9H0sBjPbrRrjfvkB1WMoZiMDZ2fwmmkQX8cS
	 v+fvslum6jhOmG6STuGrNggZ/c1z7S67cH4JAbOfiu68dl/MrRBRDFRFlckh9ya3iAVFi
	 T+dxL5+eEr7XmMb+ylhK0NBvWGagxZhdIJ3fuStIyMb6ZNl7GHw0v9BrJDW/Mzfhuq4WY
	 v42v8l6iQd9paQYWsZqNXwX/4SeFm0deg7oRecTEopQvdX5GRNcb57lEz41aDPgPJ73k9
	 woaVGcF7KRDF6udBtK7tBKaVPbu4U6MMwD55LBZMHE4ddN53VhMQotnlcC9Mfvx5gtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874335;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CTZjVvkIUqA1hYxbAMBN5D0S+bQTUaargjdOqGhgIgw=;
	b=IZxeKe72Wyyov0LYs3JTcuSApXa4F6Jy03TO2TSlRCoEYmdu4R5J0Y6ZF9tEq1Th19Gb
	 wycRTltCqw4jZFyt0xN9yIczmDi2fXz54Mdk27PfOeBcDNHd7vHWi/Mdf8Jm7uJgqt50O
	 TFus/NkA98TOJyYJ95N6rKkrzo1cFmC1kBhtNjwmzcpQzFH4vNsylbQ95pZWbxIFgAnHl
	 uJ09jw5yuATFlAZQyuytZJyg4cY0y6ajt3VuaaJOS54qdQh7akJdL191kgrZtnBV6A68H
	 5LNEPta8t+LdeRQ6wiXmtAwmUQaU1CHwbf1P33D2xvf0hkBgpHfEEukL4YrsCK010Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWA5EUum;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1F606A31B;
	Thu,  5 Nov 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWA5EUum
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3DA1F000C1;
	Thu,  5 Nov 2026 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874335;
	bh=CTZjVvkIUqA1hYxbAMBN5D0S+bQTUaargjdOqGhgIgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AWA5EUumNdwSBWn4g6tCydb8yT3P9NIpU1AhnI/l68ypPPQQjsmlpmZcmjqP0LN7w
	 N27be4rfuMZiWwBCq7her7lB+sc11HSH4D/It973/gw2n+J+yJdXPUKAwXRjqOXG6y
	 +3pvrnmk/IkTbMiVT+f7swrdRCPqMW2Hvq2OBNpXeaZjFaLDXFyS2ZLfADRs+mUY4L
	 zAGr34i+l3CSk3NcxiMWRysp3rMsXyT3OAyIDd0GQElcCJpX8c7qsNkVzOhFqRdS82
	 7Ro2+vUiGHSoWSeJ0BfSs4RidofOfhFtdjMtqubRz5QJeJjYyTeuR/NxOeDYB3wbBP
	 DHBSE9YQBSBJQ==
Message-ID: <9c367177-1822-4b6d-8bee-d283eef7b895@kernel.org>
Date: Thu, 5 Nov 2026 11:25:25 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] locking/rwsem: add down_read[_killable]_nosteal()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Waiman Long <longman@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261103-khugepaged-latency-fix-v1-0-a07ab16ac860@kernel.org>
 <20261103-khugepaged-latency-fix-v1-3-a07ab16ac860@kernel.org>
 <20261103115159.GK1813469@noisy.programming.kicks-ass.net>
 <aunLcWto870swo38@gremlin>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <aunLcWto870swo38@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 13:24, Lorenzo Stoakes (ARM) wrote:
> On Tue, Nov 03, 2026 at 12:51:59PM +0100, Peter Zijlstra wrote:
>> On Tue, Nov 03, 2026 at 08:27:44AM +0000, Lorenzo Stoakes (ARM) wrote:
>>> Since commit 1a728dff855a ("locking/rwsem: Enable reader optimistic lock
>>> stealing") a sleeping, queued writer whose handoff timeout hasn't expired
>>> can have its lock stolen by a read lock issued before a woken queued writer
>>> was able to acquire a lock.
>>>
>>> To avoid write lock starvation, this is only permitted if no other read
>>> locks are held.
>>>
>>> However, this behaviour defeats the purpose of a reader periodically
>>> dropping the lock to allow writers in, as doing so only works if the write
>>> lock is acquired first, another read lock is held, or a queued writer's
>>> handoff timeout has expired.
>>>
>>> Provide a means of indicating this intent via down_read_nosteal() and
>>> down_read_killable_nosteal().
>>>
>>> Implement it by exposing a steal parameter to rwsem_down_read_slowpath(),
>>> update the starvation logic to modify this parameter and modify the steal
>>> branch to check it first.
>>>
>>> Also drop the duplicated RWSEM_WRITER_LOCKED check and remove the
>>> goto as the steal condition makes this redundant.
>>>
>>> Exposing this function is safe as it only makes the lock more pessimistic,
>>> so does not impact lock contention.
>>
>> Not generally a fan of this -- can't we tweak the steal thing to never
>> steal if there are pending writers?
> 
> Oh, well, I had assumed I couldn't fiddle with that behaviour across
> rwsem's in general, so if I can yeah that's preferable!
> 
> I could send that change separately then and drop it out of this series.

Just so I understand correctly, this patch here would be gone entirely?

But #4 depends on it, so now I'm confused :)

-- 
Cheers,

David
