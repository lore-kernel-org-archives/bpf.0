Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E335676B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198936; cv=none; b=PbXCMkQVO/+RiI00e+FkvfhLDwhwLNP9fgpt+A+D4YwUF6XQ9bgMlIWAsfAKpwwifZAao29npLc5zI9aWdSs/ZtCozJQXmhhhJvQJCs4BOqN1eUCaZo7WiZuzeeMtWP0zAX/XApOsA6cFDzglNRsPoA1PYr9YeSnj4n5muwkBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198936; c=relaxed/simple;
	bh=ZVMVCy+5YLTcUEbYimQ2OkPduNxoBr36ZpqTdmZuMw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aORQXjSl8Hi1ZIE6Btu/dg2HUxtTT+kO2K0ktRbRmWs7DIvpXwDuiz9I3plaNGgO+f0Ia8sZH+dzHU4f/USMazn3i/CzjegzBVtma1KaBjb1kFztmpxiK1pLlYKGHcxjWQ+KRFHqvLvmkFXJ8eVjlw76X4wG3jke2rS5lAOa28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmRD8xUM; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmRD8xUM"
Message-ID: <a4f21915-cccc-4f46-a3d1-0a9a825b47e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784198921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KF6F1IBEP/oQ8UWITdmZa3tHiqzXYueqmN5G4KAT3s=;
	b=pmRD8xUMq34c+6Lf9bm/re0CopZpPjkUCWjbAXKC4gJUAbrFVCv39xvwmTVAT1EZnXvqB4
	Ihq0IW0hjxMJsP5BPbvdFojZH0sP8NBlfqnpJ0+5xJUU4bcwdJNPxNDie39WhbFJjqyq02
	MFE+SOUYNam6X7F2HD9qk8BU+aXmAWA=
Date: Thu, 16 Jul 2026 18:48:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data()
 wakeup
To: Nnamdi Onyeyiri <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
 kuba@kernel.org, kuniyu@google.com, ncardwell@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sashiko-reviews@lists.linux.dev
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260715213538.37229-1-nnamdio@gmail.com>
 <95e690bf-2eed-469f-93ef-6ae3fb2a7162@linux.dev>
 <aliwTlOayzvvlN10@localhost.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aliwTlOayzvvlN10@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/16/26 6:24 PM, Nnamdi Onyeyiri wrote:
> On Thu, Jul 16, 2026 at 09:30:30AM +0800, Jiayuan Chen wrote:
>> Please do not send a patch by replying to an old thread.
>>
>> ...
>>
>> Please use a commit subject like "selftests/bpf: add selftest xxx" for the
>> selftest patch.
>>
> Sorry, I'll resubmit with these changes.
>   
>> Please use existing test frameworks such as sockmap_basic.c or
>> sockmap_strp.c.
>>
> Just to clarify, do you mean I should add the new tests to one of these
> existing files? Or that I should add a new file, but write the test in the
> same way as sockmap_basic.c implements them?
>
> Thanks!

Using existing files is enough I guess.


I didn't read your selftest files fully, but I don't think a selftest 
with 299+ lines  is a good idea for reproducing a single problem.

I think you should try to shorten it to a reasonable size, e.g., by 
reusing helpers.


