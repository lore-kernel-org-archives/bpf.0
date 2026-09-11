Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274EC3DA5D5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789104769; cv=none; b=aNRQMLN2gNmizSAIwXfiSiT++ix4IaE0ffBKaBcPObjOh8PCKTnWZ3lVw7tvB2OoemgatIOFDVHF4YWmhqbQBOzoE0fn+lZYsTMw2ZhzdA7c2okRrjeRiFduPBVgXp0llwbiMG9/JcKhjgs+VhDfay35Bawbm3hcElL6sE2l7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789104769; c=relaxed/simple;
	bh=zGn0T5wZpUDDT0cSVOr3uvrMBzChL/s9otKYamLONUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaZ6hG9Zx9kIRwzrA66T/j1JCUn/OkdLyQjwpYLwgRSTP+uyyS+fjamYCK5rDJYxXKf0W8yE9x/FVVhKXDSRdC0SjZ/Pzvf6pCo7X0bFgAQspvEiHe5eATU9MM1JO2RH+n+ODMsmhHBLL34QT/BfmaioUDtGSrSns/MbyUCy6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OFwssiSe; arc=none smtp.client-ip=91.218.175.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OFwssiSe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zGn0T5wZpUDDT0cSVOr3uvrMBzChL/s9otKYamLONUc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789104762; v=1; x=1789709562;
 b=OFwssiSe7+jywNhxhIEjZjwtfJiSBknC6FvgGJoyUjYtF1MS04X1KI6tpGtlUQ3PFszEDH7l
 EhJIGv68FCOCf0dMWJMwxCZkbnhHetsUwPgIXamtbG6vqbK5OMs1X0ycPxUOBSAat08jdIpMVaI
 d9+Dbj+wNxwGJCk6Z72fRJbI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0230c50500f67a7a;
	Fri, 11 Sep 2026 05:32:42 +0000
X-Mizu-Trace-ID: 0230c50500f67a7a
X-Migadu-Flow: FLOW_OUT
Message-ID: <8a5452a5-86c3-473c-ad48-92f62dfc5847@linux.dev>
Date: Thu, 10 Sep 2026 22:32:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 08/12] bpf, x86: Move kfunc arguments into the
 x86-64 calling convention
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260909062604.4008177-1-yonghong.song@linux.dev>
 <69c3b97a109100393b692506d0926bbe1b7c13bf2e4ec7dfbac1586774efb766@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <69c3b97a109100393b692506d0926bbe1b7c13bf2e4ec7dfbac1586774efb766@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/26 12:29 AM, bot+bpf-ci@kernel.org wrote:
>> commit 7d2a9d78dc93fad535592157230f508d5bc54a7c
>> Author: Yonghong Song <yonghong.song@linux.dev>
>> Date:   Tue Sep 8 23:26:04 2026 -0700
>>
>>      bpf, x86: Move kfunc arguments into the x86-64 calling convention
>>
>>      Do proper move from bpf calling convention to x86_64 calling convention
>>      to satisfy native requirement.
>>
>>      In addition, the arena argument walk counts eightbytes rather than
>>      parameters, as an argument may take two registers.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for multi-slot kfunc argument handling. The fix
> corrects emit_kfunc_arena_args() to count eightbytes (register slots) instead
> of parameter indices when walking arena arguments, which would cause incorrect
> register assignment when kfunc arguments take multiple registers (such as
> __int128 or large structs).
>
> Should this include a Fixes: tag for the commit that introduced
> emit_kfunc_arena_args() with the parameter-index bug?
>
>    Fixes: 34c3503cb29a ("bpf: Wire up JIT support for 16-byte kfunc returns")

There is no need to have this Fixes tag as it is in the same series.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441

