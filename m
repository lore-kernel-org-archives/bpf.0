Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7E61C84D0
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372589; cv=none; b=IDTyTylmk90IDlFBG1WpwhKiFdf1z9X2kss9R/4xjFdxDvYEir/zHjihmPqrJWkD88haHelutN5Wz5lf/tcSTBgFcUFrcQ3zp4ju+PUzkn6xA/he7dqiLGwhja79m/dRJ8PVkbPNlUJ9x22bZlRPS8jYTixWZLwO5oxcQH2wveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372589; c=relaxed/simple;
	bh=lPK4hgNXmNG7xTs8osaIM9GP4txc/7L8gR6l4ewS3yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFirKtvv4ln2qMd38JkbW42A6J7HJBTZsDmyo/Intk/B8VZAFvQLMOL3oxvRIZT2GJjqoCiaTeUW3jXyFRgZ93XWFjkCQJADfY5E4VRNjdCMdcNVQy8h3Ca37JlJ/q9P1W6AnBp4PAgu0TEN9L7bGgZolRiBnz04n4tbUjW5BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhbgDtCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhbgDtCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0F8C19421;
	Fri, 13 Mar 2026 03:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773372588;
	bh=lPK4hgNXmNG7xTs8osaIM9GP4txc/7L8gR6l4ewS3yM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uhbgDtCtgxXJ33cq03BbjOwyh6FbczjllEw+7O9gje6vsCWkOZolH0qpLvevgn29+
	 NjIi7cOtmoI0SNrGRIS+U/yVFVBkr1nUbqwm+vj5x29CK+Kg0gK8JEpIp7DNnlO9OU
	 ro2O207kfnk8G8h5oJ2uEO63PVFIJe/Fr979JWhTvGQf2o+Yx+Q2rvHjnV9fmguL9j
	 WupD6IlIev06/4scXf+ZvlNZHV9H78yCZpXHx6WsGJFJ5sGjOpKL63XxyEKvPuxdX/
	 PEdPusU4TTs2oP68WOXxg4B3r8epbrBLCsHWl9Y50/TkMgK7G5l8imv+8+NrcjJtnZ
	 oiaCg/FXTidUA==
Message-ID: <a8f6460d-bd36-4563-a731-80eb31ea72fc@kernel.org>
Date: Fri, 13 Mar 2026 03:29:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Need update to libbpf/bpftool for bpf_stream_vprintk() removal
 (kernel sha 0cecd492f516)
To: Calvin Owens <calvin@wbinvd.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
References: <aa8KBN1kQnng3yma@mozart.vkv.me>
 <e1918475-8028-45a6-a669-dc9031f73c2f@kernel.org>
 <aa9RLM_OwFmI8X8l@mozart.vkv.me>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <aa9RLM_OwFmI8X8l@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-09 16:01 UTC-0700 ~ Calvin Owens <calvin@wbinvd.org>
> On Monday 03/09 at 20:34 +0000, Quentin Monnet wrote:
>> 2026-03-09 10:57 UTC-0700 ~ Calvin Owens <calvin@wbinvd.org>
>>> Hi Andrii,
>>>
>>> Your libbpf github sync at [1] happened just before [2] was merged...
>>> would you mind syncing that bpf_helpers.h change into libbpf/bpftool?
>>>
>>>     In file included from skeleton/profiler.bpf.c:4:
>>>     libbpf/include/bpf/bpf_helpers.h:318:12: error: conflicting types for 'bpf_stream_vprintk'
>>>          318 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
>>>              |            ^
>>>     ./vmlinux.h:128001:12: note: previous declaration is here
>>>       128001 | extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz) __weak __ksym;
>>
>>
>> Hi, where did you observe that, please? I don't see it when compiling
>> bpftool from the main branch of the GitHub repo.
> 
> Hi Quentin,
> 
> Thanks for looking, apologies for not adding you to the initial mail.
> 
> It's bpftool-7.6.0 with libbpf-1.6.2 that is failing to build in my
> case (with 7.0-rc kernels), exactly what is described here:
> 
>     https://github.com/libbpf/libbpf/issues/947


Ok, reading your first message I thought the error was when compiling
bpftool itself. Now I get it, thanks.


> I think it was just "bad luck" that it missed Andrii's sync, it was
> committed in the kernel 18 hours after his sync. But maybe I'm assuming
> too much from the timing...


Ihor and Andrii synced the libbpf mirror a few hours ago, and I just
updated the bpftool repo, so you should be able to pull the fix from there.

Best regards,
Quentin
