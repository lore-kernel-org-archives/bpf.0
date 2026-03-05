Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659CFB640
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673083; cv=none; b=ZMah34aQGs+QJta/icxXTRR2T/a7zFvQP0SHl3cNQpv/RUsynudnP3QFBkbHjnXf2BrtquE/EPJsvizYx/79TaDmRpFO8Kl8m41cM+GByLqaJOLpQBXbhi1XZfNOYs1Cv6Q+JJSF54zjSLKaBtb7Blrkd50AXDOYXbiiV+5+rWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673083; c=relaxed/simple;
	bh=6j9+bYJ9UVL6qrFbs8/OUsNVswHG1yIys0c/DuTaeTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddyPwPiA6G4rB+Bz7SOJ5PvPoz7Zs4m+gjPyi2uwg58ky6tqJFo5xY6BMhLr37gixirkg2vQSUBZGyOW83D1FOgdEfXKbBJXuPhcGe62n9qKWtOW2WJGa0J+DDRoubaZ4uh4HRagGklPcWuBynhB4EeknL5CmDe17BF9anPu9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lD9BDUNx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lD9BDUNx"
Message-ID: <682b4e08-7c21-4616-b1cc-65923c3ae09a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772673070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhDbeBcQSmf2HN3hAelrmzZ/D4QuioH83c5OluSuGY4=;
	b=lD9BDUNxnIhtn+vP6DoCTYsQ/ojmfnUoHTsuh0ygyT5TliZprRNCnU7Jsh7SemQRepTfXB
	7W6Hqt9HHId+I8Za/BxFw7z8AM4n08K4sgHKB+Tv+YOeIGKPv8iP1hrr2eOx4poqQ28DWZ
	iB0C3ZW2RipayWGiBzWNmSK6S22gWfM=
Date: Wed, 4 Mar 2026 17:11:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 2/2] selftests/bpf: Add selftests for the
 invocation of bpf_lwt_xmit_push_encap
To: Leon Hwang <leon.hwang@linux.dev>, Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-3-yangfeng59949@163.com>
 <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8f6755ed-d2ae-42ba-8052-2e6fba3d5c69@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/4/26 2:33 AM, Leon Hwang wrote:
> On 4/3/26 17:44, Feng Yang wrote:
>> From: Feng Yang <yangfeng@kylinos.cn>
>>
>> Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.
>>
>> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
>> ---
>>   .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
>>   tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
>>   2 files changed, 31 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c
>>
> 
> Unnecessary to create new files.
> 
> Move the adding test to verifier_lwt.c. prog_tests/verifier.c will run
> the test.

It is actually the change from v9 to v10. I think leaving it separate is 
better. It is not testing the verifier, so logically it does not fit in 
verifier_lwt.c. It probably won't be the last fix for test_run+lwt, so 
separating it should be useful going forward.



