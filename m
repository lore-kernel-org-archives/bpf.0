Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5057E105
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274574; cv=none; b=O/iqfmmuawH5rasqfCaM27ePPXDPpTp1NiHwdR1kv1ilta3zjcC6U7ggY/rZml7VS5t0wOGjNINgZJGPRoXyTZBP+/ZtEts/gsWmLSHulwJpNL1glvBGhFjS1EU2ozEIHtWf7pgYd8R0hOpqaxvbwgIC5HXaeBuanwZjSzSFinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274574; c=relaxed/simple;
	bh=G/0upb5pD8s0T4yFFw4uscyF6E9BxFzTAwOKlEOmtH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUSD6sDsYIih0uyN6ZyLlDf/FaBDsI4rcYymwJ3PXC6W61RhJgoQxM+Ghv1EcRawSHXrufbPB3ZEYORqrWPn8PGIEBednBzoLG28TZCvtCJwIKiGfqBskG6he6WDO9BzR4xDBT+Jv8Aj/G+iU8Yp/WCnBE4cOPs9jsZRwhe5tzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bjm1cPvW; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bjm1cPvW"
Message-ID: <d6bd1b3c-17eb-40bd-af02-e7135db07fd5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782274570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2+DA39nrhHiWdlgSJHaUeBl0G5vMQ788v0kMi4/43U=;
	b=Bjm1cPvWTuuryH8v87J0HibzVfzV4MCq1xy3S3lJ5pb0yt+i5dyvPsyuKguK6p2Sfo6Wwd
	uCp8NWGnZBHduIWgapjjn0IL33YL0c9mHH/SCfr3PPI8gUiu+/YKQd0OXw+aBLJFxkQMgy
	BTE6RDVj+y6vT9wZCcXbGTc8hS1Rm6c=
Date: Wed, 24 Jun 2026 12:16:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 09/11] selftests/bpf: Add test to verify
 accessing rdonly percpu_array
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
 <20260622143557.22955-10-leon.hwang@linux.dev>
 <CAEf4Bzbmj-ekwYQ6oGW-BRnzLBDvWgLyn_QsU5g1yNt_8A0H3g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4Bzbmj-ekwYQ6oGW-BRnzLBDvWgLyn_QsU5g1yNt_8A0H3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/6/26 06:46, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2026 at 7:38 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Since percpu_array supports direct-read, it should not break accessing
> 
> what does "it" refer to here?
> 
>> rdonly percpu_array.
>>
>> Add a test to verify that adding '.map_direct_value_addr' to percpu_array
>> won't break the case.
> 
> what case?
> 
> I think you are testing (read-only) direct access to read-only per-CPU
> array, is that right? Just write that out? Though, really, negative

Right, will update the commit msg.

It was to test the change of patch #4:

@@ -6113,6 +6115,7 @@ static int check_mem_access(struct
bpf_verifier_env *env, int insn_idx, struct b
 			if (tnum_is_const(reg->var_off) &&
 			    bpf_map_is_rdonly(map) &&
 			    map->ops->map_direct_value_addr &&
+			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
 			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
 				int map_off = off + reg->var_off.value;
 				u64 val = 0;

> test (we *cannot* access read-only per-cpu map for write operation)
> would be more trustworthy for this...
>

Makes sense.

I think it is worth testing both positive and negative cases:

1. (read-only) direct access the data of read-only percpu data's
   percpu_array map to test the above change.
2. direct writing the data of read-only percpu data's percpu_array map
   is disallowed.

Thanks,
Leon

> 
>> [...]
