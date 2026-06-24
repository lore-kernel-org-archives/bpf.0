Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77D145B11
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274219; cv=none; b=NR/DGT5jfAZcDX2e2sk/SDdaLEofiKEFN0Q4M5y6ppBNVjoRxRQHbpIY9Kaua4WhOZiByqQDsEzVhUULIr9YmmCYBQQNZOQk5X36LKpyY0AdGv45wsnxGhb03y8y6a9uX3QeZjXzEESFR71DXcnvpxgEx/Iov2T1LeC1c0EXvZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274219; c=relaxed/simple;
	bh=EOJzw9KrzYeejHXRacYEVWrKwjSSxhWN64Deir0FjCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYG+wQjl1VomWRGGPQlRBCyOgq+G3f2GjsV3CldvEJheGN3mD0STi8EsRhk4eoN+NAHWnF8rJ8R4tn5P/eSXkrglQf0mKMxFckpdvcah9sU3E0fbCyOwTSlkAFGHUpL3969+zaUz48JN5Wp0hBw19lPhYzKNR4xUmN7XKifRhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a02Neh24; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a02Neh24"
Message-ID: <571678b5-e731-4ea6-afa5-c79b3a47ab2d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782274214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrShSej5OExPGuD5IES8kTIdSUT+H6q31oEPMIGBDlI=;
	b=a02Neh24XY7GEsJEjdHJC/vzxgCHin4xxQWaDMln1LOwV1ftvuL5kW2Ma+2vBi9ul+x6Pz
	C7QZvQaFbsMNcO1I9elYC0tr/PAxgYlBGNjwfDkLntk7L8ayl3g/zMtsSzSZO0dMH1r8GM
	bNHUU0uIjfIfzAB1hb18bodqhd2J1rw=
Date: Wed, 24 Jun 2026 12:10:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 02/11] bpf: Disallow interpreter fallback for
 user BPF_ADDR_SPACE_CAST insn
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-3-leon.hwang@linux.dev>
 <CAEf4Bzbx5xB9sA5vpe0Y37DXeJLRYsbSHpvHTca6uw5Tj7jBAQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzbx5xB9sA5vpe0Y37DXeJLRYsbSHpvHTca6uw5Tj7jBAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/6/26 06:45, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2026 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Since interpreter is unable to handle the 'insn_is_cast_user()' insn,
>> require JIT in __bpf_prog_select_runtime() when the prog has the insn.
>>
>> Fixes: 142fd4d2dcf5 ("bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf.h | 1 +
>>  kernel/bpf/core.c   | 1 +
>>  kernel/bpf/fixups.c | 2 ++
>>  3 files changed, 4 insertions(+)
>>
> 
> apologies if this was discussed before, but this seems unrelated to
> the main patch set, why not send it as its own fix separately? same
> for the next patch, no?
> 

Will send separately to fix the issues of interpreter fallback.

Thanks,
Leon

