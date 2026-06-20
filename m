Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F597394E8A
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969256; cv=none; b=HMqxACJHHmoE6e7ATRZCDqHQJ73e5GPYOrxzT1tbPgxJQI/2lbvvOa5WCwQTIhcpyd7HmVuFp4pndOZdayy46bhOmq7+AhXmvNQ5VjWxdsf1wHoKV66g5gxIngSLNVY1m6jwxhbnOdsvLIU19wfQSiaDWuKXYuaceNd5zeEWJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969256; c=relaxed/simple;
	bh=LKgl2yGCAeXGesvUL7VMfbYsGCy8mUh34Xh+N14+g3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Akx1ojmjAzr9sU0KVmSHExXuHQ96/RfpExNK2oleQKrQiJfSJbIeeZodli18iV/3i5CC9tBkDK7OWpGTojD+hkxGPY11sjRjRHlzc+bV0Tb01NsUK5jQwmzLvADFYNUwQ3j37GCcksARG3ZxTsuCiDR96CqoldMHmuVOS5c2Ub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aytbJl7i; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aytbJl7i"
Message-ID: <fe2b54bf-8201-41a1-bc3e-cef2e68582d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781969242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VL+yRD+WzB33/gwPxUctl39fBtkl41WGXKHo680bMpU=;
	b=aytbJl7ivnL0oX5WGY8RnpzkmFllxNqKwTMIfkZmsiZ4CtrxoYmW2kvqIuxQrxK6PJJxgq
	7J6Kc33H4+3dTELWpnRUxlGxaPIFFp4dujsY3dFhV19fMBHharXulkbx3A1xmmiktbuh2Q
	0Ht1BFWbzJTOyuPWULuHgq23oNaUVR0=
Date: Sat, 20 Jun 2026 23:27:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 11/12] selftests/bpf: Add test to verify
 xlated insns for global percpu data
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260615152646.27639-1-leon.hwang@linux.dev>
 <20260615152646.27639-12-leon.hwang@linux.dev>
 <DJ9XY0Y2D2R8.16S9E0QFFMLQS@gmail.com>
 <d9eaffaa-6bbd-4af1-97cd-e5e37917c526@linux.dev>
 <CAADnVQLnnSrHDbw4OQCPrXz38wZ15PC1HuS1-aSB7LZxOQhd1g@mail.gmail.com>
 <b1efbbb0-d2ea-4050-aef7-e35db35bd8d9@linux.dev>
 <DJDK43Q9Y1RJ.3SDUVLSC5I50E@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DJDK43Q9Y1RJ.3SDUVLSC5I50E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/20 11:29, Alexei Starovoitov wrote:
[...]
>>
>> The point of the patch was to check that
>> percpu_array_map_direct_value_meta() computes 'off' correctly against
>> the 'off' encoded in ELF obj, and a mov64_percpu_reg insn should be
>> added after loading the prog.
> 
> If that was the goal then it wasn't achieved. Just test manually
> that the 'off' is updated correctly and skip such selftest.
> There is little value.
> 

Got it. Will drop this patch.

Thanks,
Leon

