Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB43BB4A
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439267; cv=none; b=as04h0GwMwUE0litPfyCadwWKfqspHmldLV9rv7LufNld8W4Pu8DFnRvlrp/lUomkdPP2Y2jMyEsfVTLrXwRamze02oJKh5CzQdG0o+acJi85KyEWq+UK1j7StZ0Tz4cyOd8y1rO0p3qp+fzeXPjl7bjNhicRFf+P1kIhCF+ReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439267; c=relaxed/simple;
	bh=Lh8oXrP1xibgtkVbMaxAE7Bs5bJd2E8n8XUos3XinnA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E/SNU1NrBwXmBbFeQD8odZ3uQSEWGGOqqzPEMvv+7ts9U895pVRK+jiY4KVy0g3hlhluh4o6fytcyfc0ylfulR2xRGFQzl9WrfoT3gvnOqt3zk2iq4vZYB6Tt04HHxroBzZ14v0H9Qvwt6BdC7ztH1/eU2Lg0F0xkIxDebojqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T7hvKDQP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T7hvKDQP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-915aa0a9293so159736885a.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782439265; x=1783044065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0i6zOpZ6BVT9WWXIWxceZ1rEM+Y8Lvo4LC7l/NlLRM=;
        b=T7hvKDQPPsRoSOdYwJffO9ayu5VGc9fYV1HsiazpYsbXhbmVd0wYtgsbIz7tqioeog
         Mo5CScOy2jfwb5E28A1D0xdZ9+MR0Ztwll+cOxz5V91j/O53Q+0WXR6m45G3/x+UJI4z
         OeLhZfW9hjeGLB2ptltWDNgCJNeTf9xjjxdIGTIo6U4cLTzTdAoZO9ZcFr1FcQHfSyO+
         /9F5HWajXEFca7WifQDjuCPMylXY+lgXNaphUlHziJGEAc/Cu+yG2p8MimVGWUdEPkRK
         4UiqCZbluJviEkqtK28o0bDm5IwTcRgwhD76+Ch3h1LYse/mrlOR2sGPjQ/D+FpfSlml
         pskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782439265; x=1783044065;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0i6zOpZ6BVT9WWXIWxceZ1rEM+Y8Lvo4LC7l/NlLRM=;
        b=pvBBiST/CN0JAqv/Vyk6yrA51TIN7mlPHtS3w/V0Ux0Zr3/S9Aq8X4opm5rypmOsOZ
         Y7cyD7AGacnKQvRag9Z+Gego9cQAbLWRO3OkRd17rkp1F3bJrf+lVA9HVGXSUicnYL/B
         ml5IyVzp9ftQjweWT5qwzdFBteqeO7HtXRzfSSWSRC4yTI0Wh5F6rskkfqdkUO5WL+49
         l/50Af8lZ8nEWDLFW4lCmBb2PLYKCN671uV+ueBjuMR6fx3GGgW91aZahzIrOubHdEZw
         OaU1XHaY/9MJcKIoFpJtIWQFzFmI0pO9kzFqd/V4kN4X5g3n4LeNjTmTtiT42r3Wo9Lo
         9N0w==
X-Forwarded-Encrypted: i=1; AFNElJ+NGN9Wj3YYAdC/iBj3laH+0HOgHPPqP90QSRHK02Ssq7Lt2kyNEkQfRRHkFS0ZDBI3hlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0G+ZqV4mkZMNVIrV3So4g5ac/13BrSsvhSxhgvmlT+/ob+5UH
	B/1yAAHyFMZ1YoCQOJTcZ2FtUcj0p043Kfb8kI4e55UTjKirW8Q6wL7iwFMKZMwCBw==
X-Gm-Gg: AfdE7ckBmfOLyRWK6znZcpIrKgqY2ZAjQmUOC741L4T8yDkBjieDtW1rD+BOWqMQPF1
	b6u1NYYmbulrwWX+doj7B7+HrYf9HD2hl1ZPVxSmu2pijVYOkQuNbYBnOuchNXzMCgZsio407bV
	732VCs5Mp4ytWLLLX/jMvalH3igyd+59YVb8tfRoDUqKVP2KaIX8ZL+/OgjlC/ugBb0FoHhDE3m
	DTAIlsaXQlD+MrPJVF24J0M/MYY5375soSzv1ht8yk8HVeBg+iQbXSW0f4gCjOUqe8TMt8qjsB+
	0zU3m1ohVuWHnbftd2H9PytYLlFkvCeKhnWE7XKN5TRC8NFgkMYcSfSbt82puNtROeAR1ntj7a/
	jEZV/va+eVhYd0707XHLiOMAnjHDjeMlQuK+nz0zh6bjGrXEC4/YVj7a/HsZvdl4BkLXDWzGRdD
	07nc4kOxzSUimjmlNKCyVn0iubZOVKtcy6qxbpfgnc/+TPQYGpPnjjSGnnVhav+Q==
X-Received: by 2002:a05:620a:4613:b0:915:aa65:6e95 with SMTP id af79cd13be357-926039b55abmr1151848885a.44.1782439265487;
        Thu, 25 Jun 2026 19:01:05 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fa56463dsm1007413685a.0.2026.06.25.19.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 19:01:04 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Date: Thu, 25 Jun 2026 22:01:04 -0400
Message-ID: <19f01a8bf00.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAADnVQLdDZR+q66XgCgprPnikhE_Zf_LH3XTFh43u_ks62cWRg@mail.gmail.com>
References: <20260624140301.93421-1-daniel@iogearbox.net>
 <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
 <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net>
 <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
 <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
 <CAADnVQLdDZR+q66XgCgprPnikhE_Zf_LH3XTFh43u_ks62cWRg@mail.gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at load time
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 25, 2026 9:44:54 PM Alexei Starovoitov 
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jun 25, 2026 at 6:38 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, Jun 25, 2026 at 9:16 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
>>>>
>>>> For all the reasons I gave previously, I can't support moving the
>>>> existing security_bpf_prog_load() hook at this point in time.
>>>
>>> Paul,
>>> it's not up to you to approve or deny where security_bpf_prog_load()
>>> is called within bpf subsystem as long as it doesn't affect behavior.
>>> Daniel's patch doesn't change observable state from LSMs pov.
>>> It merely moves the call from syscall.c to verifier.c.
>>
>> Alexei,
>> It is my responsibility to speak up and voice my opinion about LSM
>> hook placement; arguably that is one of the LSM maintainer's larger
>> responsibilities.  Non-trivial work, including several allocations
>> (which can be quite large in some cases), occurs between the current
>> placement of security_bpf_prog_load() and Daniel's proposed location.
>> We must preserve the existing security_bpf_prog_load() call site.
>
> I don't think you read the patch because you're saying nonsense.


I've read the patch, as well as the code between the existing and proposed 
call sites that is outside the patch's context, that is the basis of my 
comment.

--
paul-moore.com



