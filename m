Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472703596E1
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893229; cv=none; b=j/RD4OW47GwN4iaDBzwg49aq45pgQYFE67YY7SUBshoD1dkIHUxzkhRCuIr9ydjkj7AEQSTHEPd6DvKZXy4V6XTe/s6gb16yuQjgo2uHFsZrueq7PcQhJ5hLSchB0s1+GoT5fZ9JZu2NT40A6PRGreeu7fz9cYg5N8/VRirdIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893229; c=relaxed/simple;
	bh=RQv2v3GrtyPH1P3jo+Fvi9hLCNkYsZV4mlez82tXnqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1oPmb4AEzL+ioeK75CM5smcWIhB2/Oombk1SJNbBiIgNjiTN3Y3xys3ogAelReARfhB74ScxJDf1UlOgBb1xnzZYutAD6dCw1B8mMdsU7pWJioTyHv/dss2kasqw9Nn/vGk/1ngmGzjYlfpBvimKEQNkWxWdr5Lxb3VUb8bYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Rklsa3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Rklsa3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so122755015ad.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779893228; x=1780498028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQv2v3GrtyPH1P3jo+Fvi9hLCNkYsZV4mlez82tXnqU=;
        b=K/Rklsa3boOzEkEY0psrb4Irr1v+nqy0uwraxezDBoPTZymMGdreF2kRiKavyR4JM/
         NdVkrQsgUROSMK2d9sacqmM744lK0sOkeUlnzGam0cIjfP7WjRjQlDoV4oo/vPXBa6R/
         bs2G/5FcGVgDImvJRK67Z+LPtyAj4/Yv3kcV1fs7yqubjEyZJyumhrXBWUdcty1mDtHr
         AWfTJEfzPZ1X9jb95kOWpJW8AzdnD23wFOfWj2q3Vhq2RyGM2CAsLpf/ltGBQ/ytAkaB
         JICVjLcYXaD3Q3ENVFqwA8V/PAFV3Qroa7WMxKZGPCfuNQevv3qvRVlnHG6/mStaIRDu
         Gmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893228; x=1780498028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQv2v3GrtyPH1P3jo+Fvi9hLCNkYsZV4mlez82tXnqU=;
        b=KLY8gbsZEIKt9FWw4WZB9GAzVWDqUEw3INDNf2Lxdfx7A0nn5408FOP8/pwWZN0mNC
         l/RYEl1JKlmyKuuwIsDis2qRdp/aWnlh5Fit702D8Ejw8PqZQwZUUEPvIJvQ52RGgk+8
         qB6QMdJ+pZ8PcdbII4+ZCA40vt1FKD8GekZoQLKJotIodNQO3bATj0T6qkF3z9ec8GOB
         5rmfGu+pUSz6l3SWQoJfhXKs2M+aZjvFUkn/bZeOr5F9hy8Gz2HwG7LYpz/rP6Cq+1T7
         bgWyi9bBopQm0f+fnFGHX3lTiC/Nz9FgQTHS1GZSbGO0uejQxd5z0i69eXRbNtYU+M2X
         H4qg==
X-Gm-Message-State: AOJu0Yw4ug6ziITtzJzsQaUP/LVb46fz7/HMitbi4AzwejqcNE9KUf83
	yPYko+i9f+sCb9kGX4R1bmG1/Whz346wDETCCOREPxIrecprwEoFdlCR
X-Gm-Gg: Acq92OH7RcG88/zTaTDMg4PKHxwdVraLMw73YO49BVv6I5rJlEaIUPzMuEnVt22xuqj
	y4Kli9jGhSsOLb7Um2H6bZhLmIy5oLZywfDeKVMU2jf2IDS9ZtQOJNamHw0m910HuxrrQRB6VeF
	DWXBB0brHNyhO79UAiEweevWrlsIJSXZi2rL2X70wBXzP7RYSC8G5WiIan/eeovIzuVtzLLZQQh
	n+isan+e5CmeX3NPAaPOh84sR14reGGsp1nsPyYcwd0/eIAan2LFgx/e5OoG+3q7TpkXXb5uZvE
	9KOADwXV4HeAMfQj97cd4PKiZ6ygP0sowuctHyTA3+VKWLB02tiEbeSavB9LGz0eUoVdpQjzb9n
	TLuMdbpP9ZzYLMk0hTjf6Xq4SjjhDUCbzAn2VnQsqAokJ7JkFFPit/Mq622D4Th4xlUAmjMViYU
	tNPyb48BDkH3TDl5tb9h647g==
X-Received: by 2002:a17:903:3c63:b0:2ba:85:5827 with SMTP id d9443c01a7336-2beb05ff545mr297392925ad.26.1779893227497;
        Wed, 27 May 2026 07:47:07 -0700 (PDT)
Received: from john-p8 ([98.97.42.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58fd888sm161317245ad.73.2026.05.27.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:47:06 -0700 (PDT)
Date: Wed, 27 May 2026 07:47:04 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev, 
	daniel@iogearbox.net, sdf@fomichev.me, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	xuyq21@lenovo.com
Subject: Re: [PATCH net 1/1] bpf: sockmap: fix tail fragment offset in
 bpf_msg_push_data
Message-ID: <ahcD0MqTSelmtDEl@john-p8>
References: <cover.1779636774.git.xuyq21@lenovo.com>
 <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b129d10566aa3eb43f61a8f9757bcf51707d324.1779636774.git.xuyq21@lenovo.com>

On Wed, May 27, 2026 at 11:48:15AM +0800, Ren Wei wrote:
>From: Yuqi Xu <xuyq21@lenovo.com>
>
>When bpf_msg_push_data() inserts data in the middle of a scatterlist
>entry, it splits the original entry into a left fragment and a right
>fragment.
>
>The right fragment offset is page-local, but the code advances it with
>`start`, which is the message-global insertion point. For inserts into a
>non-first SG entry, this over-advances the offset and leaves the split
>layout inconsistent.
>
>Advance the right fragment offset by the fragment-local delta,
>`start - offset`, which matches the length removed from the front of the
>original entry.
>
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Cc: stable@kernel.org
>Reported-by: Yuan Tan <yuantan098@gmail.com>
>Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
>Reported-by: Xin Liu <bird@lzu.edu.cn>
>Assisted-by: Codex:GPT-5.4
>Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
>Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>---
> net/core/filter.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

eviewed-by: John Fastabend <john.fastabend@gmail.com>
