Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E982C11E8
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794338; cv=none; b=acgcEopWf1/MgryTYxAmWRq4fVAi204R0Vgdyd9DvhMuaf2MxWzjqOHM2yd0CxDvvgRfjqyf+wnk9tnYYeuW21c2Y2d2N98Ec/gKbOx4CcKYgCIBmROYgvcvKh9Xs07iKcQCg9AomFRK7A9EBshHQ3CmOHcvw4cDcM6uU5qp48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794338; c=relaxed/simple;
	bh=Tmo+YCyg54tdq12GphQgtgtVzleLL71WjIrSg5NSdzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNuyknqKAaNvZ0BKmnc4f0rFeoH+EX1fdqj2R7o3tLgqCRXDYmlm8gO6sBHIHezj/KNwJBKgHn5Bd5afJVRDgsA4mq8jYZa4VLDAj29ua+ER9PKs2l1BosoLlfICzmyBv7/F2MC8r0Hk9/M+cT36yOockQIxKzk89hr5NkJ7WV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pVqYCLDl; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pVqYCLDl"
Message-ID: <8b83f690-c962-48e5-a557-dea03e4cdf2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778794333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR9JknqWpw08s7KOMU4N/HYija63X5YsGCuoO1Qs53U=;
	b=pVqYCLDlx+D/ZjscFpj2+SNOYihVtK8GLnl40o6eWmC2gpI22+t5IDkIlaSfKwmpbxmR6o
	d8PhZGGN/YDvgXZYLTDFjrAERo2AKwzdFiqTfp/qvo+2looDdM+pw2XxNNdjuHNqv20Sub
	I1lWnGxVKam4/uMib+8uHAmrg8Xhoww=
Date: Thu, 14 May 2026 14:31:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
 <20260514184727.1067141-3-ihor.solodrai@linux.dev>
 <agYzuDIJszA_7rp3@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <agYzuDIJszA_7rp3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/14/26 1:47 PM, Shakeel Butt wrote:
> On Thu, May 14, 2026 at 11:47:26AM -0700, Ihor Solodrai wrote:
>> Sleepable build ID parsing can block in __kernel_read() [1], so the
>> stackmap sleepable path must not call it while holding mmap_lock or a
>> per-VMA read lock.
>>
>> The issue and the fix are conceptually similar to a recent procfs
>> patch [2].
>>
>> Resolve each covered VMA with a stable read-side reference, preferring
>> lock_vma_under_rcu() and falling back to mmap_read_trylock()
> 
> Why trylock()? Why not just reuse the mechanism introduced in [2]? That is
> abstract out the mechanism introduced in [2] in mm core and reuse it.

v1 used mmap_read_lock() as the fallback, but Puranjay pointed out [1]
that stackmap can be called when the caller already holds
mmap_lock. So I changed to trylock since v2, similar to non-sleepable
path.

AFAIU this means that the common mechanism needs to support trylock
behavior as in stack_map_lock_vma() in this patch.

Do you think this is worth factoring out of stackmap.c?

[1] https://lore.kernel.org/bpf/m25x611s17.fsf@kernel.org/

> 
> 
>> only long
>> enough to acquire the VMA read lock. Take a reference to the backing
>> file, drop the VMA lock, and then parse the build ID through
>> (sleepable) build_id_parse_file().
>>
>> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
>> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
>>

