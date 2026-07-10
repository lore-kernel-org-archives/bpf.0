Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90F3ACEFB
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663234; cv=none; b=WUssD+dn7HZq0ociJ67WWNFcd2BXnjOUhUuhgMAKTtIo6MO9SeeI3GfJVbvV7DBoPX6fVBcgZby02fTEzeKykzLkmmYaYwaaPSgt9bFewpUHyQk2H8T3mwFR6bvADsalLPwD3qEGCC9EGdym/d5Fai64RWWMIi7wa1DMjgnHhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663234; c=relaxed/simple;
	bh=Sndl6+aSLdi2r3UN3eGnRPZpR10WJiIEXoy+kd63sKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usyccdRITLe4GAgO4xEqnYCwmdaNPhHlDhk3UCqqtI2gCebqTv+LgsHV2qL5lADTZPgnDK7aVrSgj9+SXyu2s2dnn+rX9C0Uj+UFC+/x0jew7QjsdqJvV6k50XhtcVatPRAAOcU/8RHPhdr65GIrc15GztcRVF0+EQ6qr0Qm/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXanNCxR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXanNCxR"
Message-ID: <29c790dc-2e14-4ffe-8231-db8dba4de0c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783663230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW//WQjaq9XlcGZ6G+ZQIrOCOzr44pGBa4wa2EKvirc=;
	b=vXanNCxR0IVc+cZudlKAX94yq6hmyPsE6UMENpSx1dOO28hiuDLrkH9QQjVXD3Bmhej+9J
	MJ8dQmpDApcNRRxzXgRkZqwzBY4REfSfUPGnKTk4R2j4m5jrMR4fnUzOGnsBOBw9C9R+u8
	0RJm8xUtoORdWHpInjTdXKaX8Z4Hzeo=
Date: Thu, 9 Jul 2026 23:00:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 00/12] bpf: Support 16-byte return values in the
 R0:R2 register pair
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
 <b364ef0ad5425d97180220af23be238a4c4281d7.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b364ef0ad5425d97180220af23be238a4c4281d7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/9/26 5:56 PM, Eduard Zingerman wrote:
>> On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:
> A design question regarding to how this series handles local
> functions:
> - It relies on the BTF gate to decide if function returns multiple values.
> - It also prohibits local functions from returning pointers as a part
>    of an aggregate return.
>
> I think this unnecessarily adds an additional discrepancy between how
> the return values are handled. The practical experience shows that
> existing differences between local and global functions are already a
> constant source of pain and confusion.
>
> I'd also argue that lifting the above limitations for local functions
> would make the implementation somewhat simpler.
>
> Therefore, I suggest to:
> - forgo the BTF check for local functions;
> - always copy r2 from callee to caller at EXIT

Not sure about this. If r2 is always copied from callee to caller, and
interpreter still only supports return r0, then this will imply interpreter
will never be used? I know interpreter will be eventually removed, but
at this point, people still use interpreter?

> - forgo the scalar struct requirement for local function
>    return types.

I think this is doable.

>
> Wdyt?

