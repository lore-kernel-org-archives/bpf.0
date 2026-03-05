Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406E1C5D7D
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674475; cv=none; b=Ly9vg79pLHoHHoS7109q3nsuj8rHEW2HaFDX5vIR11cytwDZAC6BGBrZZUDeL17QIkD6ue6b2ATDamdE9OkhapObrnK3y+BwGcXXmMkgegBd/XnGkV5BJq2WDGqvWOUbMGJwziPpwewAtbPm1swxKplQFUY7UVOV85b6OUxTVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674475; c=relaxed/simple;
	bh=pWgQ8y71kCvi/Sb21LxjNPt5SMJRWb1n0bWk+ROs/Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT4MzLXWWXVt5FyHTsdIFia/uLWZNK/hWLErfS1HYWi7pM4HC+6UovVVsrcmbVZodHJIaY80R7Ytf3B/grojJoi602IWuBUi2S1dSuRMOJCmfVjPnc1zvHTynsR/NFZmyqresakKl9OjGscpL6fPPa4yXPljTxNvmfasj+kJLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5J0nCAq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5J0nCAq"
Message-ID: <d76953ff-841e-4c88-800e-5c761f50d70f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772674462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfDN/bvfBCvYWg7+zeSFGz8yRL+iVsNGXGZCk8qgMlc=;
	b=a5J0nCAqG5IDYwn11YB6UPJ4LkY9w2nm0tjGlR37R6r10VAggTWEd9/Pq7zjy39wK8uqnG
	lYcnVkFqkKN9+NSRWFAlT1gYYzwJg7GmzXKSMrs0WKNnU84BOqZ9ola2t7crB1PfX+FYbA
	qcb6hp3kfb82h2Zd5BULQCIBdDF7nvU=
Date: Thu, 5 Mar 2026 09:34:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Leon Hwang
 <leon.hwang@linux.dev>, Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-3-yangfeng59949@163.com>
 <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
 <682b4e08-7c21-4616-b1cc-65923c3ae09a@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <682b4e08-7c21-4616-b1cc-65923c3ae09a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/3/26 09:11, Martin KaFai Lau wrote:
> On 3/4/26 2:33 AM, Leon Hwang wrote:
>> On 4/3/26 17:44, Feng Yang wrote:
>>> From: Feng Yang <yangfeng@kylinos.cn>
>>>
>>> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is
>>> missing.
>>>
>>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>>> ---
>>>   .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
>>>   tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
>>>   2 files changed, 31 insertions(+)
>>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
>>>
>>
>> Unnecessary to create new files.
>>
>> Move the adding test to verifier_lwt.c. prog_tests/verifier.c will run
>> the test.
> 
> It is actually the change from v9 to v10. I think leaving it separate is

Got it.

> better. It is not testing the verifier, so logically it does not fit in
> verifier_lwt.c. It probably won't be the last fix for test_run+lwt, so
> separating it should be useful going forward.
> 

I realized it after sending the reply. Thanks for the explanation.

Thanks,
Leon

