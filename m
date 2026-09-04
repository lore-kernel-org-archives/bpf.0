Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4070379C44
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528010; cv=none; b=kNUOwSr+hJrUoM6aRDF6y9JFT35QZ/u6uEHlKyPhVQiPBB7MXMUSFnIySGbA5x3M0UwZJio00CWFR2H+tG4imXYghwRuNNOQOhBvGH9vzSnXKY1zOsXSmh9cmtmeA5clc4+qtTcQGKOOlJNSXMgPbLe6CzcLSalmti49u7UNsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528010; c=relaxed/simple;
	bh=/2fUvIuu/nTZnBkb3VRz17/FqoO211tdHDuAV1Ba960=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lw1XWTRM56ny2xgRAliS+wztMkofO3jh06G/R61UPxwIu9CyCYWzjTKEYRtQ0M+x3Q1NnyD+NngSWpS12bs5FPkqlEgv3c0+bilaQQhfAsaEJHFKg/wpw3DmbtQx6pmICtO3M3/l/saC636JetJOj2F8adx+xHUPpmvtuyv/vdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EqpCauRR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EqpCauRR"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9791488926;
	Fri, 04 Sep 2026 15:19:56 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uu-c0JmfhXX0; Fri,  4 Sep 2026 15:19:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788527996; bh=/2fUvIuu/nTZnBkb3VRz17/FqoO211tdHDuAV1Ba960=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EqpCauRRX4RoGnJaPswX/SVcW0mczm74kkRDq6tHkAJddJLobTDPiHGzvRgi+b0mU
	 2j0Ovpermn439ZHdf9XddDF6LnArt+a4bFvIxULIWs1MOXrjEU9apVlZIKk3VrIT9t
	 lHWA8hqiamo9Mngg7u9RPTiqGrCSJIPvSNd3eH6FacIpbvn8/eIcYmzbKa7YrDoiSv
	 RTyuinMAxl0NfcWUfKuyn8F3DNpjFZSINJe9JSoheBsjhUL4PWXs9nKD+9VaOsemsL
	 RWrdOwN9xv8KbBRlptQHyve8JIgJRfqzcCb1cYrVmkduTTRm4UL0s4pVUuzIvRWMNI
	 ee0bnpWddezIg==
Message-ID: <322400e7-c708-4da4-a317-cbaaea62848d@disroot.org>
Date: Fri, 4 Sep 2026 14:19:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Brian Vazquez <brianvv@google.com>
References: <20260902204439.287888-1-maghasi@disroot.org>
 <20260903082734.623904-1-maghasi@disroot.org>
 <CAADnVQLX5bjLTPm8Ch0wNuojHrKw6R5iJDBRsMJwrWMSupVwew@mail.gmail.com>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <CAADnVQLX5bjLTPm8Ch0wNuojHrKw6R5iJDBRsMJwrWMSupVwew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2026 05:45, Alexei Starovoitov wrote:
> On Thu, Sep 3, 2026 at 1:28 AM Masoud Aghasi <maghasi@disroot.org> wrote:
>>
>> Several map batch operation implementations such as
>> generic_map_lookup_batch() use calculations in the form of
>> "values + cp * map->value_size" to compute the desired userspace memory
>> address for reading or writing. This can overflow the u32 type
>> (the result of "cp * map->value_size") when the map size exceeds 4GB.
>>
>> generic_map_lookup_batch() may corrupt values for some keys in
>> userspace memory, and in some cases it mismatches values for some keys
>> while still reporting success.
> 
> without selftest I have to assume that this is AI hallucination.
> 
> pw-bot: cr

Thanks for the review.

I didn't found this bug using AI. I posted the sample program that
reproduces the issue in v1. The reason I didn't include a selftest is
that reproducing the issue requires 8GB+ memory allocation, which I
don't think is appropriate for the regular BPF selftest suite.

Personally, I'm not sure an opt-in test would provide much value as a
regression test, since it would not be exercised during the regular
selftest runs. However, I'm happy to add an opt-in EXTENDED selftest in
v4 (using TEST_GEN_PROGS_EXTENDED in Makefile), if you think retaining
an explicit reproducer in the kernel selftests is worthwhile.
