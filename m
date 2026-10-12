Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CA468C3D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794719; cv=none; b=L2+9EdWBm20DvkxYRtyMVSn4qnkXaVFs9g7nFwj69G/4qkPdeI1QtnYJqe+QZb5eZObJbWsn77zs4mVD2vsh9RATwkXfXEYsLNl0Pn3Axug0QFT5pE3+ldA25t4BQBLTPVTF5s5ulIL6TTXdplPaeNC89+lfUtWMvMVKeaq74nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794719; c=relaxed/simple;
	bh=0j/aiiftZU0vGNnv8/4Y2C4M2l9nDrV+XrpGRtFRIYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Y2mI0apcBUBipgrQRfVsnQJNpvkonLd2przt9lS+svOA2Cf8M0SAYUlzqpFAkIo5TO8GfddulA344YkDwx/ahv8ADS8ioCAgdB5//shbYA2knrjocMZNsI+FfmROZYMrawy6qaxxeiq8HMIFeIhUfifqUQ2SxU85+yihnb/wGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFZKX6C5; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFZKX6C5"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4a1963cf318so8859085e9.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791794716; x=1792399516; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P4kSx0FazYsdoDFplrljfKF5N8207GUdLLroBPFjNw0=;
        b=aFZKX6C5X5FysL9711rSDHxyPTpP93nz69fv27Ivt5Dl4heERldtW1muT+6AQBm8oq
         qo+aOsvIDFiYKdctYV/UyiHVDwe2BTebzftYBTokgXQN8V2lx3Bx+JfGjTAn3T2GZa02
         TS5JD2gufjFkvKR4b3xCkfhkY0//NnD+3GZS0CW5Inav4G+FQHHkWTr3kdC0+6bIf4fq
         l/w2eY7O2voHiyvzDz+1rmEnBCeXUzvOcpiTsQ2vRF+Lyxzb44YNuMaH5E0LefDcly2f
         8pklm/Qz1xKhnc4/5WCdn0Gjugmyl7+se9hek3nxtnCLUoGdpU8gORIe3fK7p1OnFweG
         4+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791794716; x=1792399516;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4kSx0FazYsdoDFplrljfKF5N8207GUdLLroBPFjNw0=;
        b=yDiMJTRob7X90iE6VRhLmwUpi9R1jZYAt+B1uMQsTdBPx3/r6Mkc66QsGEe1LtTQh2
         aygDyit0qTzLwVgVxoaMXA2aXd3ny5LjyFstRM2HF8gj9nMx3JbZuBvO/S+Ecb2Q/0o9
         0qIwRsTIRy4/DjRaJFsd35tIv2j1PtMgUZNMDjV/TjXVXLEMOx+OaAgSXh1AQ6WhGI9A
         +oG2hitX7oqYWSdmV18RBmMWosB36s/mn2t4j63uxiSIm87iVWrKM4k8XVh/kqC/HCyb
         lQD6bM6spysSZp7EDjKRJYXdzqez6BRVtnmrSW4/UCtGmcUM+7Ha2pV39zxmDlOR9lQW
         +Z1A==
X-Gm-Message-State: AFq9FYLE4KTqIw+NLdQToV4RaD/sSkYHGPsagwK5VwSXK+W3+QKDFTHk
	kmeAqmUFu470j8iCZjWLryo7hE8c5XQh3nPIVOUvITqc7Ifrs8LTngzkUFNmY72r
X-Gm-Gg: AYBFou3IftibfoXhLXlGNMvrgxs9DtwBtoev6+dc8BZOtXQSX2xNq0Yt+NGeQNI/q/I
	MOqwj9DWFJsKlpShCI7dT0eRo4UpwSIeqKZa30jCO19EWWRmGpgX8hyD09UHklTK+S7MNepmNGh
	2ZIY7cKwEktBsQDV5A28ENHF7vvbI/nKwU4CFmM/uBAKAh1CenBBpTFKJOxT4hXfvdx8J4d5siB
	R7gGcor9RDPd3ztf/Ki+mQhKKseegfpgoxQzHngDXUsiLciWDYau0x+6hLC+IkNyUAcyBZ56Sq4
	EUENTfzvjrGR7eK0qMG9ntl9bwqJiwkSJvpLbVtdjNcS4Ej2FNpwexQBZo2GRgi0CXuF25e7AEf
	a4hIQNTH62sigXDhlzI11NflxqCHFaLx+ZIsYlCj2OX9w0KqM5qMPRoVDmepzQjT/WveWIVdaOk
	o4A8YifItT8eYw0kfV1RqwuwG7wttGv86hLlIkEFHIctZcaq036a7pE6jcBwII9ahToTp8oK0Yk
	Qh27rfdCJvlVqp5XfF/tWgAJOfmapHvX8kr5XxddvcfKrczAt6NawdWvt64v+yO0DsvzxBDYeep
	gUZU2ObhCnHutiCylaZgA3xi8Rxm6C7/eH7jkQ==
X-Received: by 2002:a05:600c:3e1b:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4a18e487239mr178421455e9.14.1791794715449;
        Mon, 12 Oct 2026 01:45:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm209668285e9.4.2026.10.12.01.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 01:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 10:45:14 +0200
Message-Id: <DM2Q7S9925AD.3JJZRRIWRSAFE@gmail.com>
To: "Leon Hwang" <hffilwlqm@gmail.com>,
 <patchwork-bot+netdevbpf@kernel.org>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Reject BTF ids with the same address
 in tracing_multi link
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
 <179178300502.3203934.18259867735111186075.git-patchwork-notify@kernel.org>
 <6c732e69-0878-4bf8-80ec-47e40bbedc6f@gmail.com>
In-Reply-To: <6c732e69-0878-4bf8-80ec-47e40bbedc6f@gmail.com>

On Mon Oct 12, 2026 at 10:26 AM CEST, Leon Hwang wrote:
> On 12/10/26 13:30, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This series was applied to bpf/bpf-next.git (master)
>> by Kumar Kartikeya Dwivedi <memxor@gmail.com>:
>>
>> On Sun, 11 Oct 2026 16:48:34 +0000 you wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> tracing_multi link accepts different BTF ids that resolve to the same
>>> address. The attach succeeds, the detach fails in ftrace and the kernel
>>> crashes in freed trampoline images.
>>> 'test_progs -t tracing_multi' hits it when the kernel is built with
>>> CONFIG_DEBUG_INFO_BTF_INLINE. Without it the ids of aliased functions d=
o
>>> the same.
>>>
>>> [...]
>>
>> Here is the summary with links:
>>   - [bpf-next,1/2] bpf: Reject BTF ids with the same address in tracing_=
multi link
>>     https://git.kernel.org/bpf/bpf-next/c/7211c18d7ee5
>>   - [bpf-next,2/2] selftests/bpf: Test tracing_multi link with BTF ids o=
f the same address
>>     https://git.kernel.org/bpf/bpf-next/c/60e84b9127f6
>>
>> You are awesome, thank you!
>
>
> Oops, the applied commits did not collect my Acked-by tags.
>
> Pls collect the Acked-by tags from Jiri and me.
>

Fixed and force pushed.

> Thanks,
> Leon

