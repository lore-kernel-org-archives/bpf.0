Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A5421A459
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402651; cv=none; b=ahkVeif0YhyZDaxvbCHaPv02MZ+SOd31qxTNGQG/sjXkHDgK9WIKFxL1d+VdUHeY01YVn7jbzHep7cNd8JPzwIRRicQzevMDgbxoKAdFuBrxhTlugys79ebC0bUSgMxUD12hiemG4Qx7LrOrWOasE8pkAcWYS6xlBlMT+n4YTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402651; c=relaxed/simple;
	bh=EPry/P7DHSqqeLG9DHQ1JSpzqzDITZnJzRYLwBpjATU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L63ssnLIOeFO9yarJJJwWx3ehvlCcukyZtwAVNAlnhU2jCwKTR+pWBIvEqcvr/NUxch9rz5MacN22oJnLZ57RRROHN2ZXOnLKlRcYh2eZSG5xWPoWta94c0TUfcjjnFUyF41BVo80nqvK4wWlpCxr9gBEPcH269Y0pstny62W0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dqt/dOEx; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dqt/dOEx"
Message-ID: <6b534263-62d4-4a0b-abbb-69286ef689f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774402637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HJzKbJx5IWl4I/kBWYotOhJYOBozBabjWaFivm2PEI=;
	b=Dqt/dOExMaZWt83k6N4b8E4PL+IgJuOI44Xp6qcRX0fcbff0WAGnbxfOCJbGcFhxuOgqFa
	Ih2erBKgFWrcVePCuXFlrEsH7iDojR4OCQ5rWqvO6BDTgt7kWrniuOAwj/tchINHTWUOVi
	9DOx7Xg0Lkag3DJl2+RLJgyQSJw6oQc=
Date: Tue, 24 Mar 2026 18:36:58 -0700
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
References: <82ee475b-034a-442c-b290-cc7905a7f33c@linux.dev>
 <20260317100227.2157104-1-xulang@uniontech.com>
 <7A2B50421D98AFDF+20260317100227.2157104-2-xulang@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7A2B50421D98AFDF+20260317100227.2157104-2-xulang@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/17/26 3:02 AM, xulang wrote:
> From: Lang Xu <xulang@uniontech.com>
> 
> An out-of-bounds read occurs when copying element from a
> BPF_MAP_TYPE_CGROUP_STORAGE map to another map type with the same
> value_size that is not 8-byte aligned.
> 
> The issue happens when:
> 1. A CGROUP_STORAGE map is created with value_size not aligned to
>     8 bytes (e.g., 4 bytes)
> 2. A HASH map is created with the same value_size (e.g., 4 bytes)
> 3. Update element in 2 with data in 1
> 
> In the kernel, map elements are typically aligned to 8 bytes. However,
> bpf_cgroup_storage_calculate_size() allocates storage based on the exact
> value_size without alignment. When copy_map_value_long() is called, it
> assumes all map values are 8-byte aligned and rounds up the copy size,
> leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
> 
> This patch fixes the issue by ensuring cgroup storage allocates 8-byte
> aligned buffers, matching the assumptions in copy_map_value_long().

Comments from v1 are not addressed. Please address or disagree with them 
before reposting.

The cover letter did not reach the bpf list and patchwork — something is 
wrong with the reply-to. In general, avoid reply-to for multiple 
patches. This makes the thread unmanageable. The revision number is also 
missing in the subject.

Please read submitting-patches.rst before posting again, in particular 
"The canonical patch format" and "In-Reply-To" sections. Test it with 
your inbox first.

pw-bot: cr

