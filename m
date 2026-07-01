Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40142D592C;
	Wed,  1 Jul 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919590; cv=none; b=gK8viuKmDFqECC2d8V9SGnhWV4fRt7q3DZB5bCphtjLNbkTyJi7a4rNqimg2A+/XNdTm+bnGtr+CmIm7n/D1pEdbWHz5X4m+s5t/fS0wArRr50aAimZFv59smD1hvn8yWToXNfm+VhiVZkygDDHrTxyQNW1/DiYGxXqpWCDEFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919590; c=relaxed/simple;
	bh=x9xXwvlw18vCoKHShyoev5PrZsEHYltpf+5WkK6WbJ4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l58hzd2M2DU51CWmdLD4Ly11+GG2a/apKiYhSJsSJVXIR8N/xEzPZCUDWFkFmmdS8iSTNsD3DabjxP9cbDSPdm8OvGL/Z/EJLLelYpzvV1QXxdhbQjOiRc2di52cAT2UIniiBnul/FF5kjK4pF5pxNYEZ8LsD8NFCs5zHyrxf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y/J7xCio; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y/J7xCio"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D42E1A0DC0;
	Wed,  1 Jul 2026 15:26:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2790A60288;
	Wed,  1 Jul 2026 15:26:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E22CE104C9645;
	Wed,  1 Jul 2026 17:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782919585; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=X1P6Uopi1no2c62h+MDbAYiRELSK5xbROG23T7VO3RQ=;
	b=Y/J7xCiowcvhxBMaTKEl0M+9uAOYyD5/+LJc+ZWLo44LKYCjXfEuNrkZcxW4dU6JVfBA/B
	XMezNwv/dUf82pifFTi3+uX0ST1IcLizmnsxT352HHFBRLF4M0TODHwdGeuB1Dub1F7i4V
	A28kddgmauKV3URWxMLF3HHtU+ulniL4u+KpXB6BhTbC4e7XF7lxHMwPn0SWf742hSFM5R
	nhiiSL27BoNgG38DUsMyLPKk1Po03CYL0OhHNl38JxpgRw6PBVgygruYFbua7xHK7YNXQR
	P9x4pJa4+eBFKsii5wcsAA2thbPXqv/MVx8aFUNrIbjfL9X4Z0b8doJrGo5gNA==
Message-ID: <8419863d-1e0f-4343-acca-ad75c66092cf@bootlin.com>
Date: Wed, 1 Jul 2026 17:26:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/selftests: remove lirc test
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Sean Young <sean@mess.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>
References: <20260605-remove-lirc-test-v1-1-ee3f1ea5f3ae@bootlin.com>
 <CAADnVQJWBN2wohM8PM4rNGqtgGWQH__sgjrUv7h8SmWE7Px0FA@mail.gmail.com>
 <aiLpfQze1msH8ubd@extorris.mess.org>
 <8cc9e60a-4935-437b-ae79-36658223defa@bootlin.com>
Content-Language: en-US
In-Reply-To: <8cc9e60a-4935-437b-ae79-36658223defa@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sean,

On 6/8/26 2:51 PM, Bastien Curutchet wrote:
> Hi Sean,
> 
> On 6/5/26 5:21 PM, Sean Young wrote:
>> On Fri, Jun 05, 2026 at 06:39:51AM -0700, Alexei Starovoitov wrote:
>>> On Fri, Jun 5, 2026 at 12:58 AM Bastien Curutchet (eBPF Foundation)
>>> <bastien.curutchet@bootlin.com> wrote:
>>>>
>>>> test_lirc_mode.sh fails with the following when run from the vmtest VM:
>>>> root@(none):/root/bpf# ./test_lirc_mode2.sh
>>>> Failed to read decoded IR: Resource temporarily unavailable
>>>> FAIL: lirc_mode2
>>>>
>>>> As part of the ongoing effort to get rid of any standalone test, this
>>>> script should either be fixed and converted to test_progs or removed.
>>>>
>>>> Remove it.
>>>
>>> cc Sean
>>
>> I've sent a fix to for the test in a separate email.
>>
>> This regressed a long time ago; is anyone running these tests? There is
>> not much point to selftests if they're not run by anyone. I should add
>> them to linux-media CI, but is anyone in bpf running them?
>>
>> I am not familiar with test_progs, what's that?
>>
> test_progs is the selftest's application run by the BPF CI for every 
> patch series sent to bpf@vger.kernel.org (or PR done to the BPF github). 
> It's made out of the C files located in tools/testing/selftests/bpf/ 
> prog_tests/.
> 
> The shell scripts under tools/testing/selftests/bpf aren't run 
> automatically anywhere (to my knowledge at least). The goal of the 'on- 
> going effort' I mentioned is to get rid of these scripts by either 
> integrating them to the 'test_progs infra' or removing them.
> 
> If you're going to add this script to the linux-media CI, maybe we could 
> remove it from here ?
> 
> 
Gentle ping: would it be OK for you if we remove the test from here ? 
I've seen your fix, the bug was introduced in 5.17, which means no one 
had run it for 4 years. Given that, I'm not sure it's worth the effort 
of porting it to the test_progs infra.


Best regards,
Bastien
