Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDF368277
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641706; cv=none; b=Se4LMVRw4lxbq67sHV8FDitJlq+eSsRot/AEs8gZgSGCa6TogHE8xPXi93Y/q9CYt++eKipav6uxjBwu8OPiH/r7hoZui0KAUnNtlsvqakFlxkeon+SVZwdicXjdcCsokFONii+9BaHrWO3YgHkPRaAbJ4ZDWw1AeKYbJ9xgOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641706; c=relaxed/simple;
	bh=b0JmEFM09qmzdR3QS8OWc0cKSWWt36Rmn/jK5hZ5wtg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H6pyPs2s02j7tBrdyxmlk8D7VxEMS7ey7WobWuLMDGzbRut1QRPyDmgv17iGO52HdwPCjDpsOV0SB5g4Ej1kSIjBKQXJSHexeh5RDdh3t75P3/i0bUi8y++40D5hhxNSbtN4NqKjqlrQC5FHk/U1UFNpqBtSaRTiWuX0iT/FuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GD5KPeQy; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GD5KPeQy"
Message-ID: <b74c1688-fc14-449d-9ca8-3910361d15e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784641701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsA/uW7tTpaNhkYZL9W12T1ckBY53Lz+POwrMQx3yjQ=;
	b=GD5KPeQylmG9Izdv/nark9HTaf/mpff6c+LGfDqogTL4ufqyGi0/U80J59Cysavetf9dCb
	wRBQNoBm5sIvex8SsO7BUzDIdlWn2AJ1XOuswlwaVh/Wke1y8PfgunGMy+MpmBpiCxMt7T
	f6OR0sYLJA31p9xSrBqJ+mod9G2GCGM=
Date: Tue, 21 Jul 2026 21:48:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 1/9] bpf: Drop duplicate blank lines in
 verifier
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-2-leon.hwang@linux.dev>
 <DK0L4ONMR16L.29VHFM0R991ZH@etsalapatis.com>
 <ae2ceb0f-0b83-4490-9c4c-d070df6fb869@linux.dev>
Content-Language: en-US
In-Reply-To: <ae2ceb0f-0b83-4490-9c4c-d070df6fb869@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/17 13:28, Leon Hwang wrote:
> On 17/7/26 13:08, Emil Tsalapatis wrote:
>> On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
>>> There are many adjacent blank lines in the verifier that have accumulated
>>> over time.
>>>
>>> Drop them for cleanup.
>>>
>>> No functional changes intended.
>>
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> Thanks for your review.
> 
>>
>> What about the files we factored out of the verifier? E.g., backtrack.c
>> also has the same issue.
> 
> 
> Probably, I can post a patch to clean all adjacent blank lines in
> kernel/bpf/ when posting another series.


Will drop all adjacent blank lines in kernel/bpf/ in the next revision,
as I'm planning to post the next revision.

Thanks,
Leon

