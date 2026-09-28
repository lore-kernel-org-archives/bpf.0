Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFF4B0E26
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596015; cv=none; b=jePmSTp8T4E8jMzOsXv8gJg0thTvq3c1T5LCwI+J69xKlP4/x51T4sYUTCYjtxXGXMRHeLv4ZK7Rf9hZ2qnhxEdnSDdCmvvx0gK/c6QenwDqx523n+MYI+PzLWVU42T2cOohgLW3lyvD37wYpJ+oIczErDHMfdCVdhkZUWyoaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596015; c=relaxed/simple;
	bh=MKDXr0XHfUyb9JcXyauSG5qugGLrcl6kIhIiqOoL8rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xkj0JPpmNR2oVL2jktPJ2by1zl1hAfZIgPW/+prWucSJMHv7QChXxPcsXpGV/R0i9L6XzbNpG2F+tevgyvvM/eai7xM8bxsu6GEVP7FPCffnxjuCrOWfZDt+1WmIduQSLcKwlIDWU7kApV+DQXzkse5OOP0JQCqv/mmvRSYlC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXTMXrbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXTMXrbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159971F000FF;
	Mon, 28 Sep 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790596014;
	bh=Nqq2XpcOkHuQ5BT/fhQosvGaRLjlYZOoRJKIocTjoxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TXTMXrbu42ijBe5llTQgKPsOfRf+sMTvL1MHHU2DZR5vfUn3bazLYABRkkoFwaehZ
	 niF8kFWSNH/DyuIhxywsI+B/YGMz64N9HBvOC09qhTwn/7LGK5H09wxqrv7UjmviJE
	 fwbMJMuTxx3NWMYB/PwcGBtiDES195nwk0W/Jp3q5mz/C4Tp1c+1KnVM+Ix5gAovWb
	 Acjju7wLX9L2hSYIUEseBweTSthAGq289TFv8pZifmbXjoFO/d3Mz6EVpJzswD0qIP
	 PymoPyK6eZSEi+eR/fCjGFcwWnZ8CyRN7nEC4RDDmLyLNMAXrBTjnvQyUkSVUXPfkD
	 Z6vdk05TeOYdw==
Message-ID: <488cb936-6d3c-4dc4-8588-1ac02983121b@kernel.org>
Date: Mon, 28 Sep 2026 12:46:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/3] bpftool: Update func representation to
 include function signature
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
 yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, yatsenko@meta.com
References: <20260926175113.2368566-1-alan.maguire@oracle.com>
 <20260926175113.2368566-3-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260926175113.2368566-3-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-26 18:51 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> Augment func= output for LOCSEC entries to include a mapping from
> function signature to where parameters are stored; for example:
> 
> [290179] LOCSEC 'inline.text' vlen=524941
>         func='task_pid_nr(tsk [reg0])' func_type_id=136691 loc_proto_type_id=136693 offset=2097226
>         func='get_current()' func_type_id=136694 loc_proto_type_id=136695 offset=2097247
>         func='arch_static_branch(key [address 0x2e275e8], branch [const 0x0])' func_type_id=136697 loc_proto_type_id=136700 offset=2097296
> 
> Fixes: 321562c34d5b ("bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks!
Quentin
