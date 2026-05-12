Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEB2C15BB
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555089; cv=none; b=M48K3h3/CgGEls+uTXKpFLvrBadx04K60Wg8citRAxcOa0jXqqUUCABpA+r/3rc52U0nbcReNpm+5jNcNAvtOzUfpR5jYsoeSWxIMVMkVdsI0+JvZZAU4Jq1+CwCxbXm9UbVzvN8Qcx4x0X6wM3kEgdT/tMTsLdOyIosKSHKQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555089; c=relaxed/simple;
	bh=QWDzoZDl/VJ5tTrwP4SFQhPh2pNHbttlKL0hMLhvfus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQIdsFOa2qHtWgb0L91ZbXr8je31p8E3u3Q92R3SAe6M1PX/YkEh26lXHsjwumE2DUG3YSGPBui4v15kSyxFA5MQMWep4uMFy75ELHSi1ZEkzT79oFGLh5aIlzy3mLenRWF/v3KPgfc1T2eVzAbLZ6+13lEPw/xfL3qtmGAPmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b7pmwk5E; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b7pmwk5E"
Message-ID: <4469c765-e9ab-46c9-adc1-ff1b812bf1ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778555086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7i+xfahj3sBGPHY3FghsQUZZN9rtw3UGJspv71jxBo=;
	b=b7pmwk5EZBtx1GqfX4icfZpzpD89QYWxhBv+DhdgE/TC3NZ/m6l4rGyZsH35gS3m4ANRKK
	Hjqv0tGR223mY1v47QpukFw6xipAkOlhwK9/IYYdQD5irgdVxGj7XG9qNdQfwc79zIZ0JY
	PNyTx3/EyUxpBKtYagv75YQ/CxARuSw=
Date: Tue, 12 May 2026 11:04:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Add Jiayuan Chen to sockmap maintainers
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20260511-sockmap-ktls-fix-1-v1-1-96ff8c1906e4@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260511-sockmap-ktls-fix-1-v1-1-96ff8c1906e4@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 5/11/26 8:10 PM, Jakub Sitnicki wrote:
> Nominate Jiayuan Chen for the sockmap co-maintainer. Jiayuan has been a
> regular contributor and reviewer for the sockmap and networking code.
>
> Since we are now down to just two maintainers, and John has to split his
> time between BPF core, BPF networking, and sockmap, having three
> maintainers again will help with the review load.
>
> Signed-off-by: Jakub Sitnicki<jakub@cloudflare.com>


Acked-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Thanks for the nomination !

I’ve noticed more sockmap-related issues coming up recently, and I’ll 
keep helping to track and review them.

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2040011a386..dfc621ff629d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4861,6 +4861,7 @@ F:	kernel/bpf/*iter.c
>   BPF [L7 FRAMEWORK] (sockmap)
>   M:	John Fastabend<john.fastabend@gmail.com>
>   M:	Jakub Sitnicki<jakub@cloudflare.com>
> +M:	Jiayuan Chen<jiayuan.chen@linux.dev>
>   L:	netdev@vger.kernel.org
>   L:	bpf@vger.kernel.org
>   S:	Maintained
>
>
>
