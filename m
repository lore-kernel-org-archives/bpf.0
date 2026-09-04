Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96543A7E3
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511466; cv=none; b=ek3ChHPwb0z0KgOKzbNcLsyBJbNuAnz3pAyv4FZoYDbIupPqVWEICGp7nujeVEEmcX52nI5BAn58gkRSkm57NWfU1rAdx8UCtwjC8pSaPP9MbFzbpjeTNmsuVF5MmWIhM0h19CUMkrel6Jb8ZdRl1m7b+B49bsA0O3qp9tGmMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511466; c=relaxed/simple;
	bh=xPYwvZRikG8q9ZyxWeu7lxa0JAUe+/NgRurcSzEGzog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcNkzG5HnBuKCEEbC6GuqfErY1Zx6IGcd9vCc0okUhhc3zDvFs0RW+RcsBFVeXNKGlDaCBZKsWQNNQ7YwnE4aPYHAV4sQD8YBG/YpK5OrnIcH7zINEsQYV/9ZlgofEFaAwkt5BODXfLuVwVPVZY0lkMifkSzeqoL1KAM/x392iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wCea4xlF; arc=none smtp.client-ip=95.215.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wCea4xlF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xPYwvZRikG8q9ZyxWeu7lxa0JAUe+/NgRurcSzEGzog=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788511462; v=1; x=1789116262;
 b=wCea4xlFPFXS9iryzoxD22+Rs3MizsGQc7QlUuf7MhSyLlniVY2il/odR6wbbgiGBc0dVHEp
 5eox0lRbfTmIN7XykVpF9KKaisZhsV3eSIhA/yOMpINz0fSRiV5ST0WG3qSHQzjBWl8qRrV+kkd
 XwMk3f8tMrH7yE7cRhlCXV0g=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5cf789f7f263980;
	Fri, 04 Sep 2026 08:44:22 +0000
X-Mizu-Trace-ID: a5cf789f7f263980
X-Migadu-Flow: FLOW_OUT
Message-ID: <46b5b4b7-4c5c-43ab-bd2a-66ab6e860914@linux.dev>
Date: Fri, 4 Sep 2026 14:14:16 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 3/6] bpf: support low-32 subreg scalar linking for
 zero-extending movs
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-4-vineet.gupta@linux.dev>
 <3409369bebc67b512257583556b02104710fcd1c.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <3409369bebc67b512257583556b02104710fcd1c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/26 9:37 AM, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
>
> ...
>
>>   include/linux/bpf_verifier.h | 10 ++++
>>   kernel/bpf/states.c          | 23 ++++++++-
>>   kernel/bpf/verifier.c        | 91 ++++++++++++++++++++++++++++++++----
>>   3 files changed, 114 insertions(+), 10 deletions(-)
> Also, would be nice to reflect ZEXT flag when printing the register in log.c.

OK.
