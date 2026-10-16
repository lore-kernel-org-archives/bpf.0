Received: from mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779C2820AC
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166204; cv=none; b=eyCftLuZ73453pAfzSAXbQNxFxeh+D08U+TuG9GMMxvFY7F6nD8YR4EgtgPmSN5HCNc0XGo4uFIRsSQ1TN2rByxKLI5kTKkWZu9clJ8sGuY7B+F/52Z48ab85LHXovapj9NaXrarbXnllPOGZHWKa7bOhyd92taSzSvKRPlcIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166204; c=relaxed/simple;
	bh=1qJ0GFBlqkscSNTHGsBedXcuLukMhY1I+VTkGjNVO+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4907h8W/ynerTFTUq2LUQa4nY2caNDYk5KLKSvWax0d0mQcNOak9cjvlgPG04kUDqpp043tydBqNLcbS9MdlpMnB68uk5Nd6NvfmorihBA9AOtjMu0+2YGCFiroYfXVeEXF/UssVsWDKUa46KL0whwCNtpE3CKJKNP7/jSv3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bWc1/1mX; arc=none smtp.client-ip=95.215.58.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bWc1/1mX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1qJ0GFBlqkscSNTHGsBedXcuLukMhY1I+VTkGjNVO+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792166199; v=1; x=1792770999;
 b=bWc1/1mXPFDJ6JUnC/3p0r9pnS9mDTJtG9AhOvU4k07KwXTt4FuSm2pvZYn0duswrDijVcLl
 u6HFNA8gja5MzIi2maEtD0agfcDt/HIVdiGMGvlYMMFIJ8Ohn0JO8GlAyrdSOVZ+YAGyIQFmhJ4
 nv6j9gCUBEVt24FZbi0+XgfY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 88c65f79d0ebdc69;
	Fri, 16 Oct 2026 15:56:39 +0000
X-Mizu-Trace-ID: 88c65f79d0ebdc69
X-Migadu-Flow: FLOW_OUT
Message-ID: <05c5e255-2c9a-4064-a283-f63ed87e99e5@linux.dev>
Date: Fri, 16 Oct 2026 08:56:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 13/26] bpf: Allow a subprog to end with a
 call that does not return
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261015040143.854070-1-yonghong.song@linux.dev>
 <20261015040250.860960-1-yonghong.song@linux.dev>
 <DM5WDDT1HM2C.BQULK4DXMUU2@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM5WDDT1HM2C.BQULK4DXMUU2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/26 7:12 PM, Alexei Starovoitov wrote:
> On Wed, Oct 14, 2026 at 09:02 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Let a call to a subprog or to a kfunc be the last insn of a subprog, and
>> give it no fall-through edge in the CFG walk or in bpf_insn_successors().
> [...]
>
>>   include/linux/bpf_verifier.h | 10 +++++
>>   kernel/bpf/backtrack.c       |  6 ++-
>>   kernel/bpf/cfg.c             |  5 +++
>>   kernel/bpf/liveness.c        |  9 ++---
>>   kernel/bpf/verifier.c        | 74 ++++++++++++++++++++++++++++++------
>>   5 files changed, 85 insertions(+), 19 deletions(-)
> This is quite heavy.
> keep_subprog_exits() in the previous patch adds 'exit' after the last
> insn with bpf_patch_insn_data().
> Can we do the same for a subprog that ends with a call
> before bpf_check_cfg() ?
> Then cfg, liveness, backtracking, fastcall and prepare_func_exit()
> don't need to know about it. Only the check_subprogs() hunk stays.

Indeed it is quite complicated to maintain all these places where
they do not need 'exit'. I will do that you suggested as it can
make things easier.

