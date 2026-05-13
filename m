Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA023A2E36
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695884; cv=none; b=XhsedhdpjNSDQh4Ly+bDa+3P9NU2Z/w2n862cRONH0fHMsw18mWQHNbyYLO6B1BQG4QYm5a+sD/zJnE7iKSqQAjk0Za6KvHjRDfH9UtKYeFtFE84HynZk5Gp87C6lNDrLt/Jf3lI7yxDXUQZy58Q4+1X8CH9D8+OkR4msJZBJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695884; c=relaxed/simple;
	bh=4LSk7L01Q9ihTE70EB4kDWJsuJfIxrmGPSTK2f3ahGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLtk0+h70cbTmhs0G449745pvAw0J3ZPkwD/lwp6IlwMC+Oq3XbxCzs7IiB21Gsv8Z9rLxSk+6R/BwDFEs5GK2AMUEymxfYcdlnCBwr2XO4EUZq8eWETVhiXK198V2RdeCo34ldt3JPNeatTo+J32kRaqV5nE3nj7pw2n3uzSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LTYgBV8P; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LTYgBV8P"
Message-ID: <ada9dbe2-aab7-4182-9d5a-7784a3d581f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778695880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LSk7L01Q9ihTE70EB4kDWJsuJfIxrmGPSTK2f3ahGk=;
	b=LTYgBV8Pd0HeNVTpaEEs01deD6igIWW07uC0tdBHpVGT+2hlXiXcz2rZbZLJfg1kkbYX97
	wppIQXLWeCG5yHeXWtb2WevB+U6OOZ6lVFpAv9c4sDpPnBOB+7fBaeFAl+6Rgvu9eZEzwq
	8B4FFVecAkHW/scjWA/Fz5nZtJmq+kQ=
Date: Wed, 13 May 2026 11:11:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 00/25] bpf: Support stack arguments for BPF
 functions and kfuncs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
 <CAADnVQKjVKG8cfMBpWpmbtPToGPSyD13aXLNOzb2PTQm_bS_2w@mail.gmail.com>
 <0b02e692-1ee1-42e3-a437-97a3a9ca2481@linux.dev>
 <DIHQNAWQDSUB.8I0DTXB0NDK6@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIHQNAWQDSUB.8I0DTXB0NDK6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/13/26 7:51 PM, Alexei Starovoitov wrote:
> On Wed May 13, 2026 at 10:41 AM PDT, Yonghong Song wrote:
>> To really fix this issue, we should encode btf with true signatures, i.e.,
>> btf should match the actual function parameters. This should be done
>> in llvm.
> Yeah. That's a real issue and llvm fix is must-have.
> I recall there were many other cases where funcs with 6 args collapsed
> into 5. Like katran and others. We have them in selftests.
> I suspect they're passing only because they're static functions instead of global.

Ack. Will work on this. This should help compiler-generated vmlinux BTF
having true signatures too.

