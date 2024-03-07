Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0752D050
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851684; cv=none; b=ubtgh9Hs1arrPm9x748nvFxJQ5zO7aEMQEqlm4cxqBwa3QwNX1zWTzYVOVK3diFex5jE323kBVyCCmsglYtPpxqVaLMD/TRnVlWBBcXOSSxjWDiJfKxpclb2nq12oUxT5fyeTIv2LtiV7102iWCEk8hq+c3Msb/T/Ly/NYBc1fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851684; c=relaxed/simple;
	bh=DirvkKJOOPvCNYhFmvogeo6UVHuEwVBxfQwdvk2Nvhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtL4+WvF1m3yaADsK08hV17PQrdQOYd7TR6Ut7rXHMcIvJAdILE0qOvRdzMyAeHT8sTK52Xqn32UNHketg9kKKhAiAvDX3YhvUNP6325QwEeH6I9NalZ+fu/CFJHVsKyKrs1GajxtLDsy3n+A8RW8zgOBYcfnY4/94QsqADppmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hjWofZPy; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hjWofZPy"
Message-ID: <05824ff1-76ff-4380-98fd-bf26c537a6b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709851679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DirvkKJOOPvCNYhFmvogeo6UVHuEwVBxfQwdvk2Nvhw=;
	b=hjWofZPyIVkuazcjdz92XKEVecqDmPpw14Ey9Y+/Uh9P3EM02pc570htzzrDJJEXShHckB
	I9Ya0qlz0zDbRtT0coIVWjx43BgoyfR6GnqsNA4jkzNKrwDytDrUtUDjx5fK3sA2YZ1NFu
	gQ9Lf70S616aDBJPelwELaRcSstZv30=
Date: Thu, 7 Mar 2024 14:47:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 0/5] Add bpf_link support for sk_msg prog
Content-Language: en-GB
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
 <65e8c1a95f4a8_34fc7208ec@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <65e8c1a95f4a8_34fc7208ec@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/6/24 11:19 AM, John Fastabend wrote:
> Yonghong Song wrote:
>> One of our internal services started to use sk_msg program and currently
>> it used existing prog attach/detach2 as demonstrated in selftests.
>> But attach/detach of all other bpf programs are based on bpf_link.
>> Consistent attach/detach APIs for all programs will make things easy to
>> undersand and less error prone. So this patch added bpf_link
>> support for BPF_PROG_TYPE_SK_MSG.
>>
>> I marked the patch as RFC as not all functionality are covered
>> by tests yet, e.g. update_prog(). Maybe somebody can suggest
>> an existing test which I can look into.
>> Or maybe some other tests need to be added as well.
> Agree this was missing it will be nice to get this merged. The links
> are much nicer to deal with.

Agree that bpf_link is better as proved by other cases. It would be great
if you can take a look at the patch set and let me any issues, missing cases,
missing tests, etc. Thanks!

