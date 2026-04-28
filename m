Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1B313539
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363942; cv=none; b=uZG+qZCUZwWrEhKo7iTsqCH5SCM4LF7yMMHALGc6rOxrSIF08pKC20dTQ8nREGDBNfiBLbBi69IoCUKBsD4XYXpm1oFHd9w5CyZzY3qhvYBx1x/DDdzT700CdFMEkorqtEbCVf0E8dQeB1K1mm+BEfUnmmHJ1MSnTP/Or9GQ2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363942; c=relaxed/simple;
	bh=wWWSdK4kqaTeuEWEsFP+Ws///SZc85DrBERApaGTlys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aC3SMDgB5PVzPuJsupMy4J5mXBejMG4J9brLtf9BlW2QNeUnifYetk0I4O7YK5qghVrUv4LBlVTTekMRNDDtPNEKUaPvmDJN9OoRE1HwZ+FmcTAd+HdGQD8GMw/bWT3J2tF3nEt8zSpyK105gVrJo3JAKRfjJjMiRKdcybpzmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Qzz8ak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Qzz8ak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776F0C2BCAF;
	Tue, 28 Apr 2026 08:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363941;
	bh=wWWSdK4kqaTeuEWEsFP+Ws///SZc85DrBERApaGTlys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V1Qzz8akwmKUrJKZDa3ABXy2/zDM4ePMvZenwIU0WMpcDE3Ch8xofqBUsbsYxkW1s
	 Y2sg/oP94KjlL6HMg1u4LE1RmXL416fCHXvqY7lpDWCYbhYAIL7vwD2cBYg4KEYaZ1
	 cbRPt+LVcun+IvD4lmPR1oQSMi/oM2NKGU1osgrH/+jMm/HC28tB3MJrVXzgqCQh/P
	 YOkcdjDVrNrq0KB21iVsuN+l2zEcf0Vkp+nLHMFFMLsKl6C/bfnzMOebIYNSgaQJhB
	 jKXI30eZVMXJu62cRwYI2dXU56Vr7RKjsLHziZHvQV4xJB/iasVz3Ji4dsuuf9y91Y
	 XS/CQ4jAWHIzg==
Message-ID: <014f3c0a-7c6f-4f64-95cd-b7b69d804880@kernel.org>
Date: Tue, 28 Apr 2026 10:12:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Using BPF in MM
To: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <7ia4o6j4c5y1.fsf@castle.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/28/26 01:57, Roman Gushchin wrote:
> [LSF/MM/BPF TOPIC] Using BPF in MM
> ----------------------------------
> 
> Over the last decade, BPF successfully penetrated into multiple kernel
> subsystems: started as a feature to filter (out) networking packets,
> it captured its place in networking, tracing, security, HID drivers,
> and scheduling. Memory management is a logical next step, and recently
> we saw a growing number of proposals in this area.
> 
> In (approximately) historical order:
>   - BPF OOM
>   - BPF-based memcg stats access (landed)
>   - BPF-based NUMA balancing
>   - eBPF-mm
>   - cache_ext (BPF Page Cache)
>   - memcg_ext

There was also the BPF THP control.

> 
> There are some obvious target which haven't been covered yet:
>   - BPF-driven readahead control
>   - BPF-driven KSM
>   - BPF-driven guest memory control
> 
> Despite a large number of suggestions only a relatively small feature
> (query memcg statistics from BPF) made it to upstream.
> 
> It looks like using BPF in the MM subsystem comes with a set of somewhat
> unique challenges and questions to be answered.

[...]

I think you are missing one of the most important points: Unclear ABI stability
guarantees.

One the one hand, we are told that there are no ABI stability guarantees, and
that we can change hooks (add/remove/modify) any time we want.

On the other hand, as soon as there is some ebpf program out there that we
break, you can rest assured that there will be trouble.

In the area of THP, where we don't even know which hooks we will need long term
and how they would look like, that was one of the reasons why the BPF THP
control was rejected.

-- 
Cheers,

David
