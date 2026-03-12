Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC243CC9F1
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334045; cv=none; b=Wlxfw1QB+74/XlKQL3zridv982ox6gjlQVyVbQ2Oi8M838ZLSJDhbtPvZejGW1RrfDgagSfvM5Vesnjz9dKneBAgZHeDQx20FDDxtTTL9SmkjzaVHfUXCgaRrdnuY5xdxkzgYkZA6Zo6sQhZWcAH0oTLDOJv6FBsS5KhQUaDzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334045; c=relaxed/simple;
	bh=UBQbW0eq4sa5zN52N1YB21vPYAdlF0qhPLwWNiVTRmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSOuTBIrPEt/6aTVb3dwmr3Yb0ZiGsMt04xRXlHtNGKqoxcCdYONpKGKUAjwyEzdXInxO8p5J3Oq1S9dBwQtuvag+fq4nUXy8pDT30j/vFVpNAMjZHNsGbc743ZBSgiSOTEyzN0gFx+Y+axDB6Ome6YpUnpZSU1f/2OHVH5ccXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQxkODNu; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQxkODNu"
Message-ID: <f5928adb-8456-4345-8544-a60f6b39454d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773334025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vy+GISsOPuuv0AOSo2j2F5vWJR35fOliwK7loISvZQY=;
	b=uQxkODNuYFcsrXaguVPf7J5bAaNaodDaDxMhYWfABFTO7+uvZajQ9mNUS80BNRFszxzyb4
	KRIH6FGTEQ/64meE8LQGVM8/rK5u95dWSGEBv1dJL4J/zoCMVbLwPVv358eTkfTI97amyI
	n2VsxHgNrHTctFqudIbVvkmfRPA2ges=
Date: Thu, 12 Mar 2026 09:46:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Content-Language: en-GB
To: xulang <xulang@uniontech.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, kaiyanm@hust.edu.cn,
 huyinhao@hust.edu.cn, dzm91@hust.edu.cn, kernel@uniontech.com,
 linux-kernel@vger.kernel.org
References: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
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
>
> In the kernel, map elements are typically aligned to 8 bytes. However,
> bpf_cgroup_storage_calculate_size() allocates storage based on the exact
> value_size without alignment. When copy_map_value_long() is called, it
> assumes all map values are 8-byte aligned and rounds up the copy size,
> leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
>
> This patch fixes the issue by ensuring cgroup storage allocates 8-byte
> aligned buffers, matching the assumptions in copy_map_value_long().
>
> Fixes: b741f1630346 ("bpf: introduce per-cpu cgroup local storage")
> Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
> Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
> Signed-off-by: Lang Xu <xulang@uniontech.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

