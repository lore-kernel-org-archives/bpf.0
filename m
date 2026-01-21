Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E872320A0C
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971026; cv=none; b=MbdVLV0E2kua23AELE3gVYdiySOYmPsC/bOvxFUh8ePeVzpDbnobRzBymCdV4TpS5VO5G3VFeMwxfJbB2kQZZ7s+3W8VMggdIevhOIKqSNtF9OXekD0Cijn+wDQiSOaqFepUxqoY2oLUpLzDFLwAM9//4LAj6NSauC91l2Mk8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971026; c=relaxed/simple;
	bh=LyEat/pwgLv74VtxEsZu4wCbiA4ff2YDvo2lAmAC9XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeU3hJ6dFB8IGiHaD9YALiLEVFelP3AmHhdmeqaSVyBL1T27dpts8YqcQhGylPneSdhjuV7d2PGkv05a8kQy5OtCEFu7SaG5iCrN7V6Z5mdKaLdAuGAmgK1GsuBcJz/54e+hRkLGofaExQD7j1OQ8STkV8EEq8RgkdLvgrbzC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IU9k1+sB; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IU9k1+sB"
Message-ID: <1897b382-41b7-4d63-815d-ac63f38485ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768971021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENIsfiCzdvI33VE71FBPx2F3/IeAnfM0oFC1UqV/shg=;
	b=IU9k1+sBpD+0qKNN/WuQLAFN+mpGcGwdeHlMRVhIkZ3hg1efgXXf07JS8vXklhEKa7xkEb
	81PXRQm0wqWsu/XjoPUVtjRerCupiYd/rRw8jCiVXyxl6MWZ4WdUh/ZpvAspxN/6emNDul
	2HBqYwI58qk5t0mHD5SLqRNACc4D1e0=
Date: Tue, 20 Jan 2026 20:49:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
To: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120182034.3647092-1-gary@kernel.org>
 <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
 <DFTNNQLGB1CS.2HDOGB99S9ACP@garyguo.net>
 <ea83b91a-796c-4329-bcf5-2c49efa897fc@t-8ch.de>
 <5364d5ec-f30c-40d6-9a99-c251fec3868c@linux.dev>
 <DFTTLB4I89PR.26SQVXWNG9U7@garyguo.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DFTTLB4I89PR.26SQVXWNG9U7@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/20/26 3:54 PM, Gary Guo wrote:
>> [...]
>>
>> So it's trivial to put $(CONFIG_SHELL) in front of it. But then it
>> must be migrated to #!/bin/sh, right?
> 
> Documentation/kbuild/makefiles.rst says:
> 
> Make rules may invoke scripts to build the kernel. The rules shall
> always provide the appropriate interpreter to execute the script. They
> shall not rely on the execute bits being set, and shall not invoke the
> script directly. For the convenience of manual script invocation, such
> as invoking ./scripts/checkpatch.pl, it is recommended to set execute
> bits on the scripts nonetheless.
> 
> Kbuild provides variables $(CONFIG_SHELL), $(AWK), $(PERL),
> and $(PYTHON3) to refer to interpreters for the respective
> scripts.
> 
> So I suppose it would need to migate to POSIX shell...

That's my blunder then.

I'll send a patch tomorrow to make gen-btf.sh runnable with /bin/sh

> 
> Best,
> Gary

