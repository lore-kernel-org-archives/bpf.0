Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AF40845
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144323; cv=none; b=uFdKsdsbItL0NDcA22Fu3YLMFyfhwe0X8XV6vFLg4MOy0RtwsXqRcJYeCHbEqIEdMyHXcSUDQlblOn9Ezck1Khnw/jMOjmtvnzSAzIv08hqob7agLHWGuq7RWhkzBN6lKWpWJREXdbE+vzT6aePSl8gSiq6WRdlizUYGbjZPFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144323; c=relaxed/simple;
	bh=uYqSBOWeVY/WJjvd+pqbJRTJ44SZFRnVEYYmOgm23ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anG6E6b3WXQ5xR3TjzLKmyGenBtkKBdYXZA7wZCnasevr+XxATMc/QFwAVoLHAQARw263hxuYfFXSMfxVxdWswr1bJUBPpwK9AeCPQ3vLfircWEF2IXJQ1Nj+0I81hbGp/zJ4c9l7kEwCKa1An42FEeJ8y74Lqw3fdzgrHvwK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnYEQDgD; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnYEQDgD"
Message-ID: <7be9132d-476e-499c-9c56-464ffb0e3a0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709144319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ebn5dYs17d3VrlxVwtOlYL+PwRAYAPaEY5C7BeYPAUQ=;
	b=pnYEQDgD1pDgFnm5tuy9d1vejmoTTN8zoG3Lz9em2IPaXxEosrBuOw1N0DmfWXxz243K9B
	5zvFxLAFajHCZWnecRJPHcGMwb8YqPPuQKfbMHtUULWHn9ylW6OgdmHVSmVDy5/LdQ4EUk
	QlkISwayWMUxmfiPz51FURO83fHZtus=
Date: Wed, 28 Feb 2024 10:18:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/6] libbpf: Convert st_ops->data to shadow
 type.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com,
 sinquersw@gmail.com, kuifeng@meta.com, Eduard Zingerman <eddyz87@gmail.com>
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-4-thinker.li@gmail.com>
 <CAEf4BzZbE=2Kvrx_XK60jhtFfJuFsu18=pcZFry8UuF-s_Lg_A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzZbE=2Kvrx_XK60jhtFfJuFsu18=pcZFry8UuF-s_Lg_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/24 9:58 AM, Andrii Nakryiko wrote:
> Also, even if the bpf_program pointer is correct, it could be a
> program of the wrong type, so I think we should add a bit more
> validation here, given these pointers are set by users directly after
> bpf_object is opened.

+1. The checking that is done at open time (collect_st_ops_relos) should have 
been moved here (init_kern_struct_ops, i.e. load time). I saw Eduard (thanks!) 
has already done that in his set: 
https://lore.kernel.org/bpf/20240227204556.17524-3-eddyz87@gmail.com/
