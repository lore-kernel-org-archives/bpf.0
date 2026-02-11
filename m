Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3E34027E
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836325; cv=none; b=TQiSgg26+yb4pH2UrAHUqwYZOWbQf9IzCaV+wLRM7jq35b8qhuRn+TCbrAdCdjNIYgFPE5WjwCia+rfkBEBGervPSVr4gm7tZL3wao+Bw2+jNER9KXBft+26qIA4dkPJ9vJlxftwboZnv3/1d6u7FC8Npbd9tV1I7MovHrbzbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836325; c=relaxed/simple;
	bh=TYF0LNel9Dh1kqeyOAurV7Y9kXCPZcqgn85QIwoot8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmG15f4BxBLx3C6rAFGgWkJWOoW4RXRE1hoR6pnK1XmdknIqvQDc8Grx8/kKmc0Q9m7KXSuCZGfII7mPtgMIL2M3gr0W9X+O+dPPltckaYmbm6Mpn3SHHCi52s4rJunSps+tC6w+EWB3VHfY+d3IxQgB4TtvgfZQ+LQ5IfPnFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATcBO3ZQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATcBO3ZQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483487335c2so30094995e9.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836322; x=1771441122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS7ExVQwY7zAOHUgSx6QZkP4tbXT72iphOSjIQmbqWw=;
        b=ATcBO3ZQ6qFreRdDHWOaM8QqpmeM8aUmUWhQzPgv/BMB0GJupuewTQnHIQqAmm68kX
         0y+12YDK1XKx1y0fSE9DiEtaXw3T3QpmtQ+zXhHGcwh7ctTcMuF8jZXR69ErIPNF3rrx
         gCeVkEXbyx3l/IZicuk4hVMXByXDL2+PCHFgGphvqJewRB55vfMkHmppU5T51Fnwv8Iz
         RPtGE8DSC9l2iuVBJbZWuoJrtXSMnalg6Bdd+93RzURj0iQoUhtaO7d9ZmqS1f4oEUZB
         anIIkQrBF+/gvHqPIDp/mjt7OkZJ7LjV8FTyCmVs9YBTxEK9sgdlN5CaZ0Puu4mmpLQg
         Ec0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836322; x=1771441122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rS7ExVQwY7zAOHUgSx6QZkP4tbXT72iphOSjIQmbqWw=;
        b=ajmzMIa/Xk5sMei6okrvMEkUDc1c3mlQVbmy9ooMOrUM1s65baz7T1sgxw9SICMxAk
         CXxQvi2jJCLSZXE1miYUt9bHSkRkb8RDCeP5sIbnpEMLtkE+jD6MBLHn6ddaJZ3a9B1J
         rRn7SV+hnzrNJThDwf24QMIO/K9cioSYNceaq8SxcAylwjoB39e+lBm7gr83zt1Vk9aj
         unGjRa7Fpojmg0G2xJplmRHSxuP1o/pw7Mmg8hBDY8VcFfP7tulf0BfyfrvmIL7RIcI9
         XvdiaL+7Z4hLpicstMf08WcR8iWrsVP8TJENQUlBUuqvLH6Q4IzLlr3IALND8UuSOcBs
         /JrQ==
X-Gm-Message-State: AOJu0Yyp52iK+svZHPHiJPs0bl76lRPyxHNzE4tzNcUP0Bsd4Sp24c1V
	apUzN7S+Cwb9g5FV7KHuZ6W73ekSZ/xc48VrmxcuqabEMFq30F72TqqLaA45Jxnl
X-Gm-Gg: AZuq6aK3Fcqo/cdiNCwo4IXuY/GBBukz5GUyWn1pcWbvcIyA0s6y/bhJ1iOYJdTpr9b
	E9wJd1xqJbpb+iAQnPtOuf3pc4f/SXYr1S6+946ChRWwFYQng7f4Jy1/WKGueqVXY9Mm6FqjhKt
	TK4H/B6lkWaPgP2nxXBFcl/HrMgtjJDlk0P0FQBYaKt9iRcgObMHJqABa8LUkreXSQujadsdn8A
	tqUKfqjem6bXhVUwFWnRAItx+ZOoYHDp2mretQ4tez3yYGtsD7SDGOZL+YHBzcyCAwpbELeIrac
	cMW72BKsueXGp6Vdd6/Cb0rD5+TsxqRnxUylwGHEdepLkwlL02PKNJkVgHXmaleWCx0psM5LV7t
	4+JQlqBxc/xfQ9ihikoXlVjJ/QaJzbXwky5HNpzn7HG/gxEXdWbrG7CzBkPsHcWZ47AoMMz5zjd
	hnFWWLFVDH2BZbQ8tr0Dfv/ub8/c3bRcBLD6Zag3H73E/m2d3XtUIkm3u6gr4B4sRgL7ee5N8Gj
	m6vuzOdPvkkDOTHImWGSCQiAmleZ3rF5PJdC2d3YE4da/Jvfv8kmns4r0ZpVGUYk9LBlsYIW/J+
	Yop+dtu9et9E
X-Received: by 2002:a05:600c:548f:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4836571010fmr2027805e9.22.1770836322271;
        Wed, 11 Feb 2026 10:58:42 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e0196bsm6653831f8f.23.2026.02.11.10.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 10:58:41 -0800 (PST)
Message-ID: <1e797bda-a74b-4873-9bfe-f7a6a6263dd0@gmail.com>
Date: Wed, 11 Feb 2026 18:58:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH io_uring-7.1 v5 0/5] BPF controlled io_uring
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
 <90c1f09e-9334-4036-a6be-ad7d2f91bfc7@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <90c1f09e-9334-4036-a6be-ad7d2f91bfc7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/26 15:24, Jens Axboe wrote:
> On 2/11/26 7:32 AM, Pavel Begunkov wrote:
...
>> It might need more specialised kfuncs in the future, but the core
>> functionality is implemented with just two simple functions. One
>> returns region memory, which gives BPF access to CQ/SQ/etc. And
>> the second is for submitting requests. It's also given a structure
>> as an argument, which is used to pass waiting parameters.
>>
>> It showed good numbers in a test that sequentially executes N nop
>> requests, where BPF was more than twice as fast than a 2-nop
>> request link implementation.
>>
>> I've got ideas on how the user space part while writing toy programs,
>> mostly about simplifying life to BPF writers, but I want to turn it
>> into something more cohesive before posting.
> 
> This looks nifty. Do you have a repo on the liburing side with some
> examples to play with?

Nope, it's all in a pretty dirty state yet. The selftest is pretty
good in that regard, it show cases a fixed QD workload. It's easy
to convert it to reads, and that works well, but I guess I need to
add something to show how to use the memory region to pass
parameters, e.g. iovs to readv reqs.

-- 
Pavel Begunkov

