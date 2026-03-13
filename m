Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A96375F78
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434117; cv=none; b=f27CpV6hEaMrTlKQONxNfHGaovg05rm57dLDnCzSPGtngYUuhs4FLOnNUsE9Tp/I/PkC6i3Cdpak29056SVSi00PhtWC2Ici4R9eX2Kr9tbGg2eKAo5ZLf0Cxq6cKo7zhpMIebEE0a5RjAzMBMPxelqmI+jzaJCHPjrpYEUvQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434117; c=relaxed/simple;
	bh=1yVJJbevpcOogzgxvmVFsl/3Ea941FkIsqwm7LYpASQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB5Oe28vXyWa27TYBZHunCBGdN4r/Odusr9GBKZXt19iAHyeXJDiEqj5QpgywgitUEZ96+Zjsqg6guoHYUQp/aTmu6n8FmttRgtUk7Xezj5eWY9UQRICr2yDNX/07O4qZLUjbK/ji9pJII+oWF1EJD6qkyYU3LNzWv0zQ7UqgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YT7INOlb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YT7INOlb"
Message-ID: <db2e04a2-3cf4-40f3-85ef-14197148d027@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773434103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+RJxdQMmis9ts8VDYUI5wSWspq4QjvNq24xu97H/1g=;
	b=YT7INOlbcj78gSAql3FiOO6gFdfoL9N9JOAkC0wdQKjnWYGUsaj5AfS9k6fSdifvX4VnC4
	PDzlVqlrgYwngYBb3xTesBwf+bY/B8abctBwVTFRC4V+cMijtOrzTRoMTtrX2MQXW2wy1p
	7md/jk0ecxhWxLmgIpKpBR1t4n14JrU=
Date: Fri, 13 Mar 2026 13:34:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
To: xulang <xulang@uniontech.com>, yonghong.song@linux.dev,
 Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, kaiyanm@hust.edu.cn,
 huyinhao@hust.edu.cn, dzm91@hust.edu.cn, kernel@uniontech.com,
 linux-kernel@vger.kernel.org
References: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/11/26 10:25 PM, xulang wrote:
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

Please create a selftest for this.

pw-bot: cr

> 
> In the kernel, map elements are typically aligned to 8 bytes. However,
> bpf_cgroup_storage_calculate_size() allocates storage based on the exact
> value_size without alignment. When copy_map_value_long() is called, it
> assumes all map values are 8-byte aligned and rounds up the copy size,
> leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
> 
> This patch fixes the issue by ensuring cgroup storage allocates 8-byte
> aligned buffers, matching the assumptions in copy_map_value_long().

This is fixing the src side of the "copy_map_value_long(map, dst, src)".
The src could also be from a skb? What is the value_size that the 
verifier is checking for bpf_map_update_elem?

