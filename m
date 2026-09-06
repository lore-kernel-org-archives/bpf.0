Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50F3195FE
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737697; cv=none; b=cNg+bbVWa2OnQmoAzxaUkX5UByAr+hTwq8mNKvGTbFMue9nB6qc0WJ3QUWcUqZGWXDqaLWr9pnMa+7NcVhdSpBJgFlSe8m73qo7wBsznaLVNztQlMBJVCa7Xx9nP+eYUWQFF/cHlb0WhmKP+LBIeBjwIMhmg2Mm0Vr8rgXs0mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737697; c=relaxed/simple;
	bh=ZRMLp9K788Z4SDoszNhgTgPplacmYKB2xV2L+vAGg0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFGi7yPM681GJVvBablRvM+2yyHH3CoUA4jNNx7IdSnWU2Pb2w6/on8lP2z9TIAthAigzpFY2SQr5/Czpz5Ef58wyluamxHYCzb0jjRZqQBMQgdilGt86Wl/Tq1gul9w8aJvatm+ju8yTJGeaBfsmvgXmFbR+zAFF7DZZ9AZJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Se+r2oHf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Se+r2oHf"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 553DC80E7D;
	Mon, 07 Sep 2026 01:34:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxc-G8kZz4wG; Mon,  7 Sep 2026 01:34:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1788737692; bh=ZRMLp9K788Z4SDoszNhgTgPplacmYKB2xV2L+vAGg0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Se+r2oHf3IOw5LrJMSMb7KI8uEbv2xgCV8wCHtdaVBGNUrjabCE/98iLtGPt6MY/K
	 9sRXSpZ/uOegRNyMC94UHMV2H0Cxv4n4/hNpU9ytOSy6CQEW+bfu1a/kY8rmEcD/cW
	 YRsFywdi7GE0WAtHuL8f1cRqMfUSoYoYeID+oynDsAlGgXgM1nwlinqN5VIpnXdrqD
	 gPxylBRNiqid0ADN2QIOW1aie2DkuAMGaone7pol6QhbT5YAoceGnPy6rWmK4ptEvh
	 GIZkxUU1IR9bDexGz5GrM3mjmdECc5OlaSiHSB10pDQuzNJN8wDH3p5c2BHmscqy+F
	 RrK6REfhadViA==
Message-ID: <da7d3192-a275-4d6a-bf9c-525bdbb6c9fa@disroot.org>
Date: Mon, 7 Sep 2026 00:34:45 +0100
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

And here is the output of the same test after patching the kernel:
$ sudo ./test_progs -t map_batch_overflow
#212/1   map_batch_overflow/array_lookup:OK
#212/2   map_batch_overflow/array_lookup_4gb_plus:OK
#212/3   map_batch_overflow/array_update:OK
#212/4   map_batch_overflow/array_update_4gb_plus:OK
#212     map_batch_overflow:OK
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

Sorry for replying in multiple emails.
