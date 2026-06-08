Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109832874F8
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923081; cv=none; b=jtFuz8ZyeA0+QTxj44zzPVf9DfGfDf8QP332lL2xrVft4g1q6b+lzjjSWVt6sq7iE4ki4P//njrUIMiDHH2UVN8SJIfVsAuB+o5eayPXUgIm6ZDF5e4gJ6x5z1urlHykTYEC0zkmKupQcpdY0loP+JkInBW8G0NytmpE2v0ynO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923081; c=relaxed/simple;
	bh=4z2Rgmywx3dKcU9riJJgvptpRkkjB2SDKxUXXsIEHFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4c4wqZAFgNlkA4CgvUiaZtGN5YKCOf4gBCxzO/JFubkIfUMEugKBHnMnWgAHDzRCyyV9c0h0E9wJKCo7CJrD0uWPI/gOb4wdT/JBubfHsLzq6BcMaflfXMJchM3HG+50+dDqSQWdzfRRt4sVRXZTFodQPmFkj2yB0s8Gh3hefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rx9R73/m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rx9R73/m"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BCA641A37CE;
	Mon,  8 Jun 2026 12:51:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 877F05FFB7;
	Mon,  8 Jun 2026 12:51:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C940106A27FD;
	Mon,  8 Jun 2026 14:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780923069; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=S/RjHayFBF/C/REvWMSwc8nupUyFZ2JmSvsNWn+M1AU=;
	b=Rx9R73/m73G1dYoNx2JucwRM1rLhrBDndkWReNCzF62bOcx9UmmaGsuo+jQYmn2rbgYdtv
	P9ZpMtGPNRvl2X0k6D/SbMgksNwgDelbagVMuza9sKBTB5PqWaAvdg3exhiOdFwwthvSx2
	vDh2/wLKlyzm0UflF7PeFipcBXkFAG+ylTn7iTt3fZ0VMwcVAKZcA6ohUrb1eO6STQeRzl
	KfmTr2mXekfkzlrYNIZU9RHiz9S0hSMuPJ8ccggy6A9IIRkz1hL+aYs7QgPGJwLNZ4GswF
	J+ihSBV6H8lNyYxq0mFBJeNafRllFAFPtUb/lAjWcyLBgABAjRLyxOa6FW3aDg==
Message-ID: <8cc9e60a-4935-437b-ae79-36658223defa@bootlin.com>
Date: Mon, 8 Jun 2026 14:51:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/selftests: remove lirc test
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
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <aiLpfQze1msH8ubd@extorris.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Sean,

On 6/5/26 5:21 PM, Sean Young wrote:
> On Fri, Jun 05, 2026 at 06:39:51AM -0700, Alexei Starovoitov wrote:
>> On Fri, Jun 5, 2026 at 12:58 AM Bastien Curutchet (eBPF Foundation)
>> <bastien.curutchet@bootlin.com> wrote:
>>>
>>> test_lirc_mode.sh fails with the following when run from the vmtest VM:
>>> root@(none):/root/bpf# ./test_lirc_mode2.sh
>>> Failed to read decoded IR: Resource temporarily unavailable
>>> FAIL: lirc_mode2
>>>
>>> As part of the ongoing effort to get rid of any standalone test, this
>>> script should either be fixed and converted to test_progs or removed.
>>>
>>> Remove it.
>>
>> cc Sean
> 
> I've sent a fix to for the test in a separate email.
> 
> This regressed a long time ago; is anyone running these tests? There is
> not much point to selftests if they're not run by anyone. I should add
> them to linux-media CI, but is anyone in bpf running them?
> 
> I am not familiar with test_progs, what's that?
> 
test_progs is the selftest's application run by the BPF CI for every 
patch series sent to bpf@vger.kernel.org (or PR done to the BPF github). 
It's made out of the C files located in 
tools/testing/selftests/bpf/prog_tests/.

The shell scripts under tools/testing/selftests/bpf aren't run 
automatically anywhere (to my knowledge at least). The goal of the 
'on-going effort' I mentioned is to get rid of these scripts by either 
integrating them to the 'test_progs infra' or removing them.

If you're going to add this script to the linux-media CI, maybe we could 
remove it from here ?


Best regards,
Bastien





