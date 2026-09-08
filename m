Received: from mta0.migadu.com (out-161.mta0.migadu.com [91.218.175.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBDBA3D
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841276; cv=none; b=Q9GbKKn3O55j/KDdfrpnKdUwXHM4HdS2y5TnIn8OUmEnaKePyEzYhnwz25TxwlEnng1jsit/c9U7vT6uR0KneQxWaRMgWB7publZoLrq+/Ba06n5CwaP0YdXqDdLSVPhnwTxvD2IDW//F0pp3aavWlaNzNQq0b3153OYvQldYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841276; c=relaxed/simple;
	bh=oYzcXMC6uofgNB2Bihq47JJsRXtRXX6ZNZJU9a37c54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIxi4XM6XHsw0/mJSZmzvBLGrhl0P0Kj16aESWSCbCk4SwQqZmE5pu6WJePcNVZqQWUxfei31Z3vtmLH5Ud0rRksOlojC7HlslUxIDNlQHVb7vEFTFd7L6SdfGAeDowh+9o9C8KFL077r/TycF5phM/+vi2CACuDECDzGuEZ9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=go4rgxbT; arc=none smtp.client-ip=91.218.175.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="go4rgxbT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oYzcXMC6uofgNB2Bihq47JJsRXtRXX6ZNZJU9a37c54=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841273; v=1; x=1789446073;
 b=go4rgxbTJ1TAKfniREEhO/q7VKKIsffISQ08wNBvkKVbj11mY1OKQHVUSwnb8uOZOVCwODf5
 0SuEIg5mEtTu/lTaWAM9rIV33txSPyl9p31E8cwAcrzb9EzqyBdyI/vxexHMPse9DvdTIQUnKDf
 jNDWPb0kxNyZkKl5AkuD8zI8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c41ec260f017a90d;
	Tue, 08 Sep 2026 04:21:12 +0000
X-Mizu-Trace-ID: c41ec260f017a90d
X-Migadu-Flow: FLOW_OUT
Message-ID: <5cadfa6f-5dda-4244-a6ad-628d24fc9670@linux.dev>
Date: Mon, 7 Sep 2026 21:21:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/12] bpf: Support __int128 as a by-value
 function argument
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260904051018.3978585-1-yonghong.song@linux.dev>
 <675f27ab87b96eefc817fc14ad5e696c8cb75fb2ca315a39a52e8fc04f523fea@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <675f27ab87b96eefc817fc14ad5e696c8cb75fb2ca315a39a52e8fc04f523fea@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 11:09 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Support __int128 as a by-value function argument
>>
>> A 128-bit integer follows the same calling convention as a 16-byte
>> by-value struct: LLVM emits it as a 16-byte BTF_KIND_INT and passes it in
>> two consecutive argument registers. So a __int128 gets its two slots.
>>
>> The test added at the start of the series, which recorded the wrong
>> register map as an R4 !read_ok rejection, now passes and is flipped to
>> __success.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for the multi-slot struct argument support added
> in an earlier commit. Should this include:
>
>    Fixes: c9bf7bb8555b ("bpf: Support by-value struct arguments up to 16 bytes")
>
> The earlier commit added multi-slot support for struct arguments but
> incorrectly treated all BTF_KIND_INT types (including __int128) as
> single-slot arguments. A 16-byte __int128 should consume two argument
> slots like a 16-byte struct, which is what this patch corrects.

There is no need to have fix tag for the same series.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551

