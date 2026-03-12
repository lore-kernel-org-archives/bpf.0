Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE5283CAF
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297795; cv=none; b=dae0uV0nZyLJg+ieUGtr7/EGkQHshsWH38rV6SqgC23wDetBv+YrIjyugdWVvgDB62/MQNpgFxSYavaJk0BWqiLZd+ztVES9bNyH6jRT3LnndPUTBcFDAUNT72+vCVPGQG4g/HWIuudPUEb3OYsR/0fMfEWFRTd2AQb2XyApMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297795; c=relaxed/simple;
	bh=gZKq7OR7mOOdC4WEU9jaX+2Gc8+Pd5s5ccoZyjYI0T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu+Itc1Oxai4C73AuEEySkDd3AlCPAGZooCq0BDBp7Y2+d1M4EIGhMXOMcowMd27i+ba5Qxwfdl1/WFyoGGIJ+JMpwllf149SRxW5Q8eu4wA+uuDNVMHYeb416hHiZHV1RYKxInthLW3bNQf7eh+e1s0/pPPEfDqsGSE2usRbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wLz5TutG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLz5TutG"
Message-ID: <92089d01-d396-4fcc-b45d-46eac4c78b61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773297791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mj06PYjGlHsp3qxgmTdAavaHF8srCIflyI+SP6vMUNA=;
	b=wLz5TutGkUbQL8ZJqZZP5a+Px47CiRPz6rOtvdiwNqY32adfM5TMqy7AGvThgejA7JQa8d
	thaSstuSxZxjahC2L/cgl6W2Rct0Z+xVRhPDgHQt/PpFn03Vpjaiw/AQvL7NU/KzcPuVZo
	LhB1DWUvAezMxFsgfiYoxwYQnb8wEw4=
Date: Thu, 12 Mar 2026 14:43:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
Content-Language: en-US
To: Menglong Dong <menglong.dong@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot+bpf-ci@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, yatsenko@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
 <CAP01T77gknuNiiVKny-cThb6b-dFxGPmPKx1eMryLoN2AkHo8w@mail.gmail.com>
 <46583200-ee0e-41dd-a0a9-8944ad710a9a@linux.dev> <6246261.lOV4Wx5bFT@7940hx>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <6246261.lOV4Wx5bFT@7940hx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/3/26 14:21, Menglong Dong wrote:
> On 2026/3/12 13:50 Leon Hwang <leon.hwang@linux.dev> write:
>> On 12/3/26 07:07, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, 11 Mar 2026 at 19:53, <bot+bpf-ci@kernel.org> wrote:

[...]

>>>
>>> We can ignore AI for now, Leon has a change for this.
>>>
>> Just to confirm the change: is it
>> https://lore.kernel.org/bpf/20260303150639.85007-2-leon.hwang@linux.dev/?
>>
>> If yes, it is to add "fsession" to the verbose log message in
>> check_get_func_ip(). Then, the AI review is correct: "fsession" was
>> missing here.
>>
>> After searching for "fexit" in verifier.c, "FENTRY/FEXIT" can be updated
>> to "FENTRY/FEXIT/FSESSION" in bpf_check_attach_target(), and "fsession"
>> is missing in some comments. I'm not sure whether it is worth a patch to
>> do such cleanup work.
> 
> Ah, when I search the "fentry.*fexit", I found that there do have
> some missed things in:
> - the comments
> - the log message in check_get_func_ip() and check_attach_btf_id()
> - the document in bpftool-prog.rst
> - the help info in bpftool
> - bash-completion of bpftool
> 
> I can send a series to fix these things, except the log message in
> check_get_func_ip(), which is already in Leon's patch.
> 

More appropriate to include it in your series, I think.

Thanks,
Leon

