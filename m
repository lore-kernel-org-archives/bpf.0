Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF939F187
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776728713; cv=none; b=jKcImQufjS5gepJ14ey+rjRI5uFICuSV8oReTC4XSSihMTXfKlZpo94aFsDu1mhPQxxTQWIpTbQCzLZoHexzGozR4iAfP18Q5B6HiAxY+c+X2ZZbHmeAmwqxe9REd0s8fKRwOdASJDwxtIfzzNizeec0qRNrmHHPbCeJeMk0sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776728713; c=relaxed/simple;
	bh=SFXlExNtsx9rc9zTtORp34qIJUbnwK5l1GPZ6ntRPEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEmZrGJcR9HHF+Xv2MIb5h3PhJz5SDZ4qRHnLPNCliftEqq9dufwRBX3rZ/Te0a6fT9A/S8dCIMOK/NsLErNMRR6yFH+sEhhHwwsEWeQUYfzL7K7Pbm/osFMsMI1lFNgfeIX19+avNh/DIt9Y1vJiU3LYHssCrfcWH36zXiD1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FTBKvEf+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FTBKvEf+"
Message-ID: <19bb22a1-0594-497d-b25c-889b4c5f00a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776728706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFXlExNtsx9rc9zTtORp34qIJUbnwK5l1GPZ6ntRPEs=;
	b=FTBKvEf+ou8hFImKIYNU0PNw9qwRrFncchoVs0hfM2CiCtXvCp69YLIAtivF92Btowclsp
	1sb7NPGN9JNHK8RBZbJdQL9xftf8Lu97Un3QFB5aCAe54Ovw4bkPFAWVkdBHQF5bcZZ9sj
	w+Od/HcF7gtWNSkbCOxhS7xNUwE8kH4=
Date: Mon, 20 Apr 2026 16:44:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 00/17] bpf: Support stack arguments for BPF
 functions and kfuncs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <m2mryx1vwi.fsf@kernel.org> <21aad67d-97b8-4ffd-8b4a-747ee8b917be@linux.dev>
 <CANk7y0iU-u2=Rmi88DbHz_L87ERpXvUR0EormKqo==9KPh0MvQ@mail.gmail.com>
 <CAADnVQLw3LEh0sn-3F5dkns60rFvHe=0kKV7WCL9GPeCRP3Pdg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLw3LEh0sn-3F5dkns60rFvHe=0kKV7WCL9GPeCRP3Pdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/20/26 2:49 PM, Alexei Starovoitov wrote:
> On Mon, Apr 20, 2026 at 1:25 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> Okay, doing it separately is better I guess, I will wait for your
>> patches to land and then resend the arm64 support.
> Just combine them into one patchset, so that CI tests it all together.

Okay, will do.

