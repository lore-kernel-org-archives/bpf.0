Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7E22127A
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157329; cv=none; b=ND8vL8B5CiUrjEthlv37IOYbdw1XFbr62Zsy9jh8piVQQ4X97kgSVOJZ+TWAcQ7XA9jOBEfKAahOEx6NoIvcfAqsdc+DflZS1+dbuAZTTR05kElF3At3iX3MY014OPu+0GCLQvuVRG9/9+8iuCadpAP/ixanTvP2ii1FPOvJq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157329; c=relaxed/simple;
	bh=Yyg+1CSAdkDrCJKOB63lMdzGb3YgbUvVbjUo6XlbWP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kftnAL6dfOLk6yGxQofSKfTblPxZyVQOkmOQ7uJyI0A1Q3Iq8huaSZ309/KoumZM+tpG0xplvvyL3R8oSGjUFkY4UZDviOj/fCxC2EOj7FTn591r0UK8gpTlOOKloso13GIy8NYYkBCrNfTbraLpYzd1vsJACvtiZlXJej7Bxaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzN7B2D9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kEMYs9ZK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzN7B2D9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kEMYs9ZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769157327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjkX2MlTDk67zQespuvb4QMibqgFcNjzieDp97hbvK4=;
	b=YzN7B2D9qFj4cxu2SgXg3SerXTcHNa7Lh24VY07u87MjiMbtICawWr6HKdsuldakn+S+9M
	zxRCAydEKrO3WOm4/Gm0HRkvmT+ApE0uAiY+43XauUGS8px6Do1xpL1fykzvnNslvvyzkA
	RimLt+6Lz5zAFj4fqRVlbol/vodEnL4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-80x57CZKPze4k4kJj3sV6A-1; Fri, 23 Jan 2026 03:35:25 -0500
X-MC-Unique: 80x57CZKPze4k4kJj3sV6A-1
X-Mimecast-MFC-AGG-ID: 80x57CZKPze4k4kJj3sV6A_1769157324
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso1233559f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769157324; x=1769762124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjkX2MlTDk67zQespuvb4QMibqgFcNjzieDp97hbvK4=;
        b=kEMYs9ZKAKSOog+Y9HBvSX9cBk45XO429qQdMlUG0bhzb/bII3wGk0hRAU+9L0aSsw
         YJBsMcIJZC+RkV/TkVczE/p2XYmO2E6YaAdbd4WvzFzAfeMS/ePVJaunY4xFeJCdjn95
         nvmRemirRV6TJcQ1ZSMX2gXNBntEMic6ahdvm4hRo3gBiiNygpftlGl1Snq30qEcfhvW
         c9jKiTugUGMPy6cYiEOE1bL20XdTdH2FBAo8q0XETGOXOLIe/0nF9VWOf4gyzrvDR0AQ
         VZXIt0LizzqttnhhOJf2i5xwcfql4lureazpWUwn8spe8asoCflPulv/To4W5AzoQf8+
         JaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769157324; x=1769762124;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjkX2MlTDk67zQespuvb4QMibqgFcNjzieDp97hbvK4=;
        b=WZeKZWMSs828prKR5hWgrI6LegpGHUPTMRLyXnsQEOm6y48TYNXkJLvFBMmzeqEFCG
         zps9KB2S1tq4UGS//yMk9eOOBVeHlQ+Nmm9s8bWUqq6hi1Y/P/wJfLK7qTwIcfl13KL1
         0Lgll0YILcJsGWAEDbTZCAMpsHdrpN6X0CqvBLoQ7Q2cUun75vAgsMVpIUJRkcJtN7Xu
         mopmdbDuu998ew1gngKCwI9alv1Q+BW9kjH2kaQDo+6giL5ixBtIiVcbulj+XIT2YiZp
         dTwV0CYqp/zz2JuIP1OzGUiY6I/PUHh/E0yHzBSeF4yFy6PrM/55/HF+byjqqjtinSEB
         X2AA==
X-Gm-Message-State: AOJu0Yw3t7RjAvfllsUki0kCxRsOALVwtT8cBBdZOx8nIYxuW/SHPF5+
	+3QyYkIVAsi93VXw44UI9xFkI1ix8xyteP9l5PV7wm6s2D1J63CSQf2KZMEFEZVr9LDetK+byW3
	G2VVlDPH89t5/mD9v63x8OD2bSBN8yHTjgqP5jTjRFxrfn3Q1dbkwNnVUnl6M
X-Gm-Gg: AZuq6aImydPLR1kh8QwyykRn3YjEeaDYhUhtWlyIDMmRDTfQtM/37T6I/pD2d3wNTT2
	fwtw6SncwcYaeO32p7UDGTnT7az3LKTBs2GkPcpmeK5xoYEirzE9FdoFo19rlgnziUb9bmMVIsm
	ltcpFqeuXn7c1+ziNwwzKXm17aPQr4cEr/m6bYgCLUPNSK3Ql+XrkVj0pofD4HiYWpq7BL4nQod
	MkjMAuoHfkwP5yMIz7E/VUkikBIXcQGNNsOWApZ/ztlVEkLqu0Evp4L2PLzgk70aac+T1px0vpX
	5Bp6utGLTE13HoWSFxKzS1wB+Tcpt3pUrSG3gT41kFrayMDQKFFIVxumfLbgKIMnGyzEBvREcqB
	1qgkhdUrNFBkBnK9czFsf2Y/EEEHB854ww+mqiIk8PsMG
X-Received: by 2002:a5d:584a:0:b0:435:a258:769 with SMTP id ffacd0b85a97d-435b162730cmr3219706f8f.59.1769157323763;
        Fri, 23 Jan 2026 00:35:23 -0800 (PST)
X-Received: by 2002:a5d:584a:0:b0:435:a258:769 with SMTP id ffacd0b85a97d-435b162730cmr3219666f8f.59.1769157323294;
        Fri, 23 Jan 2026 00:35:23 -0800 (PST)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a8asm5100744f8f.12.2026.01.23.00.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 00:35:22 -0800 (PST)
Message-ID: <041ea510-cf8c-4633-8bc4-24018ed1a875@redhat.com>
Date: Fri, 23 Jan 2026 09:35:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] selftests/bpf: Running test_progs with distro configs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
References: <cde02506-a9ff-465f-a720-637b9033d017@redhat.com>
 <CAADnVQ+hTZ_ynDJk+pccBwHGLs3hyvjDUGyiaKR2osmi0VAQ9g@mail.gmail.com>
 <3ca5bec2-a138-4f3b-990a-8c786c1c247c@redhat.com>
 <CAADnVQKnyX-RLjfu-yNSPw2=ptP6k347=YHqOfePA4cOhphA+w@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKnyX-RLjfu-yNSPw2=ptP6k347=YHqOfePA4cOhphA+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/23/26 02:38, Alexei Starovoitov wrote:
> On Wed, Jan 21, 2026 at 10:38 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> On 1/21/26 21:54, Alexei Starovoitov wrote:
>>> On Wed, Jan 21, 2026 at 7:02 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I know this has been discussed multiple times already but I'd still like
>>>> to open the topic again.
>>>>
>>>> We struggle to run BPF selftests, especially test_progs, on distros
>>>> whose configuration is different from what is in
>>>> tools/testings/selftests/bpf/config. While the tests usually compile
>>>> fine, many test cases fail because some required config option is not
>>>> set (for instance CONFIG_FUNCTION_ERROR_INJECTION required for sleepable
>>>> tracing programs, which is often not enabled on enterprise systems).
>>>> This makes processing the tests output much harder.
>>>>
>>>> One possible solution would be to maintain our own DENYLIST but I can
>>>> imagine that the same problem affects other distro folks. So, I'm
>>>> wondering if the community would be interested in some solution which
>>>> could live inside the upstream repo. Obviously, I don't want any
>>>> complicated solution which would require a lot of maintenance and would
>>>> bit-rot over time. So, I'm thinking something like introducing
>>>> CONFIG_DENYLIST which would contain "config:testcase" pairs and a couple
>>>> of lines of code to test_progs runner which would parse the file and
>>>> automatically skip the given test cases if the required config is not
>>>> enabled.
>>>
>>> test_progs already has -a and -b and BPF CI is using it to
>>> silence the flaky tests on some archs beyond what's in selftests/bpf/DENYLIST*
>>> already.
>>> For your use case I think you can introduce DENYLIST.redhat file.
>>
>> A separate DENYLIST file is a good idea. I just wanted to check if folks
>> want to share these per-config rather than per-distro. In case this is
>> only suitable for RHEL, then we'll certainly go with a separate DENYLIST.
> 
> Are you trying to share the burden with other distros ? ;)
> It will bit rot anyway and I'd rather have individuals taking
> care of their own denylist file than a semi-functional group of people
> pretending to share while care about their own thing only.

The burden and the benefits ;)
But yeah, you're right, maintaining it would require some very smart
automation and it's not worth the fuzz at the moment. We'll go with
RHEL-specific denylist.

Thanks for the opinions.
Viktor

