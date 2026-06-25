Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D236165E
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782423578; cv=none; b=IhhdL7umG/YYn+NR53JFyQ8jiTp8aVJIt9pcgjtWgBtELEUmgatXgiw1z7Bs9kX/CxuJG9F+FPJYbKdHYD730YQK/gomgrin04NNJWd8m+ZDfCWg/IT2whCrESIDrMZfr2LwY7eycd4sBQmD9nnSakGjH3NWPEGLY/lVWe1bxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782423578; c=relaxed/simple;
	bh=lsR19j1IBGECl1iTvnGDnFVZMGUdr970UxvcDFoKpdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXTG2pt1ddn39QI26DVemDgzyJEJSn274f4Xl+NhV3mwZ8WS02JBcwEzKbrEHOdSWwtmuN+TCk9PZuOmFZy86eymXkTmUyuNdqSyTPaD5GkdK8pVVcuda0wcRqzifM50y6hPedES6yn2jd9/v8IXcDo/kbFtZPe+shsSvxAYIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sRbNF+/X; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sRbNF+/X"
Message-ID: <91fb97e6-f6da-49c0-bd0b-3dc8390ca3ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782423564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsR19j1IBGECl1iTvnGDnFVZMGUdr970UxvcDFoKpdk=;
	b=sRbNF+/XCdvmuy2b1AOxSuHwwTebFUephjd2GBUXM0gmLS1yeSrUSWhjV6SlHkqRfokKJn
	LApeDhAisjTfViNbzajZUyQONMojdyZu9pZQNWEWcc559wWXqt22VtNh0AZdPy/zVhwFim
	aCFYFJy1lQ02AOtR/FwVG2l4wiCl7k8=
Date: Thu, 25 Jun 2026 14:39:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Cover refcount acquire
 node offsets
Content-Language: en-GB
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Shuah Khan <shuah@kernel.org>, Viktor Malik <vmalik@redhat.com>,
 Leon Hwang <leon.hwang@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
 <bf2a2033ced272106292de4465b8ef3fb991c912.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <bf2a2033ced272106292de4465b8ef3fb991c912.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/22/26 11:11 PM, Yiyang Chen wrote:
> Add regression coverage for bpf_refcount_acquire() on graph-node-derived
> pointers.
>
> The rejected case passes a popped list node pointer directly to
> bpf_refcount_acquire(), which must fail because the pointer carries a
> non-zero fixed offset.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

