Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B533ACEE0;
	Mon, 19 Oct 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392460; cv=none; b=qMdbe9SvVRwNH+m6IGdvDJB9ri98cN2ehdoPv8TOOPytIQf2J6EvMZxTFIPw3jiSb6cu/eeT3iyX/hC3IiXm08S2hLqDSicVgubEzrPz5RYpOO0HsbVj8a5kKwHFpGCsuys//Cv2d3MBS2gpfulGCr6iDryA3VjNEcERgTy1TyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392460; c=relaxed/simple;
	bh=jqaEbChx396H10kMxA+Is5Sf+4N76tAW0GR1lXgOUzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4lzB5XKMT0Y+w5csPUVW/85LPD2v3aoghdve/faM6qNTFAvRq6oD8McL8B3LIb/WovoeOvc7uiT3eSv28DNLzmOFgu9ZxO5HHruU7iQ+XHsaL43J0K48vAvs2VYnYyufZEc7UEZcFrRzW0myMABFCEc4mdLuAnofYW11j7JDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QlB2eHfn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QlB2eHfn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=T6VFUEVaTxjuoe/WVPkToT5Het9q+u1DoFazzDhqVTQ=; b=QlB2eHfnwSPwHJ64t7BOABQE1P
	krrQ54K0vU0VG8mnGQ0L2Ike0H2vWSK0pFtaBADB5MYJ4j2piVDDx7zDUJZg5MBKZ7SPh8x/NgNXu
	cjuAa9NZ9xSNuhQPuiUNpTRpL0z2IvO3+sljfqspr3huAloiDdV53kaM0e6n7psBo9TVklDFcsMl6
	ioglNEUtvHojmQsa/cptRwdBBVgnYVcgR9fY2bsL49oV7mw5SYJhXtOCweyvZ78MP8KpdxsnYJrbE
	rgCG6Uf7dfab6J2uXwLRo+TeC/Ai3wZ1PyPfZxtIZzSiVDcZeu+dXCnQwy427cbyDrLURTO+kfUXm
	MiETBSEg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIh9i-0008LY-0m;
	Mon, 19 Oct 2026 08:47:34 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIh9h-000LR0-1D;
	Mon, 19 Oct 2026 08:47:33 +0200
Message-ID: <d13c66a3-0519-48c1-88fe-55bc755b79a2@iogearbox.net>
Date: Mon, 19 Oct 2026 08:47:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Use snake_case for subtest
 descriptions in jit_insns_arena.c
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019040106.27309-1-yangtiezhu@loongson.cn>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <20261019040106.27309-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28157/Sun Oct 18 08:24:14 2026)

On 10/19/26 6:01 AM, Tiezhu Yang wrote:
> Normalize two inline assembly test descriptions in jit_insns_arena.c
> from space-separated strings to snake_case.
> 
> It is done for consistency with other neighboring subtests registered
> in test_jit_insns() (such as alu_imm, alu_reg, etc.). This also makes
> it convenient to execute these subtests directly from the command line
> without being forced to use shell quoting.
> 
> Otherwise, unquoted shell word-splitting causes test_progs to reject
> the extra arguments before the filter code runs:
> 
> $ sudo ./test_progs -t jit_insns/arena access with zero offset
> Usage: test_progs [OPTION...]
> Try `test_progs --help' or `test_progs --usage' for more information.
> 
> $ sudo ./test_progs -t jit_insns/cast to a user address
> Usage: test_progs [OPTION...]
> Try `test_progs --help' or `test_progs --usage' for more information.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Do these not work already?

   ./test_progs -t jit_insns/arena_zero_off
   ./test_progs -t jit_insns/cast_to_user
