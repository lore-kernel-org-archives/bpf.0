Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAD1F30A9
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731541; cv=none; b=Oe2QyESimaB/AeSSbK74mghcalzdWMPFvZ2kQ6zveDsygQFmWE7HQfTkJ4hMr/SALURTu87H9HPtwcMs6fiaq3Cvnv7DEGoV2lbbmTPaG2a9pRv+fsAgnUgU11MYUkuAlq68QkRG24lPXfniw9ggRxpccbTpoZ4j/KK/7U4EoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731541; c=relaxed/simple;
	bh=MuCHnkT/76HR5kI6MTpVC4n5sjzqmsaLA1djUnKU818=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaJN3LsYie0LRbgAs+Jyyy+ApYKpOmMeIEgobCGDlTO/PsMTTh5WhdvUqLvMSUbgwotZatnU5gFEhOFzilo9kUieZss1E837TWDhP2wr/Zdndrc7rlpvvK0ujNikKLD41e5Qa6t5C2oSwbPEa8DFSBvv5IoOzjiQY/piCXpn0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cV6P4HNk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cV6P4HNk"
Message-ID: <84d3de0a-5d81-47eb-9e41-7107c0c15d70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784731527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZQHj//W3wrPBt+vPqcY/ihQCddTbbdsI2etWjc+kNg=;
	b=cV6P4HNkvZR98ac85VaYtspeCrcWfQs2OYMvq7a9IHNMkTQRttTuGevMvEcY2dI9trWjcE
	clav6NcRDCL6dIVYALzzmt8JMMMHbG6aAOyyIZLLJK/d4WMxbmyFMQOfgrmSI14j914ugP
	/67WK75JCAt3SfZzLjg2v/HazEgtTiw=
Date: Wed, 22 Jul 2026 22:44:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix WARNING in bpf_tracing_link_release
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Jingguo Tan <tanjingguo@huawei.com>, Pu Lehui <pulehui@huawei.com>,
 Lin Ma <malin89@huawei.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260721133036.49265-1-leon.hwang@linux.dev>
 <20260721133036.49265-2-leon.hwang@linux.dev> <amCnUg9xTo4kStW8@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <amCnUg9xTo4kStW8@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/22 19:19, Jiri Olsa wrote:
> On Tue, Jul 21, 2026 at 09:30:34PM +0800, Leon Hwang wrote:
>> The trampoline could be corrupted by the blindly
>> 'tr->flags = BPF_TRAMP_F_TAIL_CALL_CTX' in verifier.
>>
>> 1. A fexit attached to a tail_call_reachable prog.
>> 2. Another fexit loaded with the same tail_call_reachable prog target.
>> 3. Close the first fexit link.
> 
> had to ask ai for more details on how the warning was trigered ;-)
> would be nice to have that info in the changelog


Ack.

Will add the change of tr->flags. So, the detach failure would be
obvious due to the incorrect tr->flags.

> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>


Thanks for your review.

Leon

> [...]
