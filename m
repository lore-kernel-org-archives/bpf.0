Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729688;
	b=zzoHbPYcs9Pgu9L3gc0Vb9np37GE+H1vTto3z89l/yPedQWMmW83+OMZVLUnTPuGlhqa
	 c0NxKdXSu8FeTYOmpv7IeVquvKBuBn8/VFGxpI5hndNcVOR62Fd+yApjnctjGCCSLTtvg
	 qm3W+dgXmhuOaRbI+YwLgPaOYAbhFjmBdHgZc0PFq3wzBmFyOs8NTg15s7STW50HuuVur
	 95irYsAXPNkGOq3ConAmapugBQX4qG/stdHvGQHZLA6xFlRcn1kWRXcZYRntu0SyFXOPu
	 RV+uSRgjoT0PKSAKLqc7YSqNorJyHm7SRG4zKJU9pXdveuI1j7ZIEj/pgKXjBi0+CsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=UhwuzspS0Yyijji1M7E/UqphlI1Fhl8GUBAG8CiVACA=;
	b=4JydVvX7mZHcmBldqQsZkw2Ve8YXmowWnr4b2xVDZkypo5oObjKjb9nWhjrvzd5iXyF4
	 8bLkOgEANvtFjEXKQQsV/5TMRbuWlpoH7412KNwxLVrkwGlw6+xGtZbbsRlPKRuS1OFy6
	 pD3cS7qmeIGVYHYm2enWhO1D+vY1SaBsqUFuuTJgHYljYuwp/m1Ox/704IhD04vdr4tk8
	 LWP+M8PJX1zHjPqpXgLb2MhXWupltZjr5+Ekpx4e7qywJ4KuEXiJtm1Ydz4L1i3+GzY9M
	 GvwzOsSLCzpgo7sm/4FJ5BEIsjRVLozMBOLhxvD4PSulZwhbSnDJ7Wp+xWM7+Xw8qBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+pqAzLG;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0176606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0176606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+pqAzLG
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso26566435ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729687; x=1794334487; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhwuzspS0Yyijji1M7E/UqphlI1Fhl8GUBAG8CiVACA=;
        b=T+pqAzLGRhfho17ISJiPBzo9Vm0WZ0VOpbCIz9fTLNtU22DlVClTI0m1qSFgsFBaKZ
         J4ntsKG8WJlXizSAk6CCiW8IcIb92j3Mf2fvkqcYsvgAbqZ8U9KrLd2i27w69Y7txFaz
         KZIqpxClXaHhL2CbaRX+LgfJKj7NitexpFfUoZX0qw0k8o8DRN5Rbx08fxkEMTVaQH8y
         ymz8US3QILzm0heLLvQFx8h6oNhQS5UHmg72pYDxJKGHpqE1PoSS3MFmWLHJRTk7bhQY
         V2NfnfeGSBAMDSFfPwviDqkxVFV5nieJftargTrRoH5Jfa9Jb30hnZokwDWqv0fnqwGU
         i5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729687; x=1794334487;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhwuzspS0Yyijji1M7E/UqphlI1Fhl8GUBAG8CiVACA=;
        b=Vkpil471+cxzt0EMxOG/+usJx9oagXBxhdwo/uym5W/d0yVLQILAt/0YafoZgHZ6tH
         cEM9SBCuD/MXcPkfSqSwMH7y2Qs66euQIFKHk8IddzrZv4LRs64Ecb9kKc7A6jP2M03V
         MYEtGZNiiiFNiRpTNfPgWB1WAdnHGE9YAdp5c2Sqb/4lHVGLA4leJNsv+aSSIIYFzzkZ
         F+gaJCM+QXWmggpS0BOHr/TyN0FCeb4OxGdj4PXYm8LUjSyon9cR40KlqtkHbB6zdRh0
         MOmamF0IAN3F74Wm0COJOOJRbb2SjFECG9r3s3xviFPsKlkVJlO45b8OhtRYTLrJlI5A
         hkjw==
X-Forwarded-Encrypted: i=1; AKwUvBzKhmokVFksya4HacgjVwo7IuEvS5P4ItPbMt+ZFHAOsujGHaxRGw/8+wDVsZj2zLe8Arg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nFLK4nty/DwR9xwnpvHcc8agNmicixJ4qXgUZHHm8uhDPChv2
	EtrFT/a+N3qsngS46BnZ4mI8FCH6a/PoQ7m668+OS1hTe9InDSb6aURy
X-Gm-Gg: AYBFou2MDb6LLuZbw7GTFRDJ2p6Jfxmm35NnrBmdNTfak3pdnaFdI6+m3Ztx9n7zeFR
	+5PrfKhkfqoWQApHlyWDKRpit9ctoqRAkvehLfGQyUQW6z28CPEAsGXrVPbpb+5tIcNyjMjIQzW
	57SGhYvKLKZ09yGATXJ+Oay6Zrjdu06y//vmrXXRc3CLdekK9ypbV94X/9cf9LoMcHq8JnjVR2d
	0TsQ5YfEdjin6PjEawEh5g08F2mG11Cui2cwR2fVappdSYKQPFeKNamsLvVd+T8ssGu643MsLC2
	5Id5v9H8VDPI3y9ycm/KMGV2BQU19Hp/cko7KaokbbPwneafWZ5uuKc9sIpSMo2TQaOSNI5dTIe
	5JPRboEu8TCVhymzta8unKboxIeLQv4CeIlxmZqLKrvsc9n53gn4w4YYsY5mbTokaxHoWvkr8Ub
	1TLgDKycDF/jyDAICdV8QUIpWkTAIfjFf8RGrgwhl05i0/ucPbwoP3dNPBVwKBag3i9euJEPmKW
	LzxnDmXm0M1YP7AUzxiGl0UcFeQRWPI35cBrKGshvz9PaOQQyOaJcluFT8mkNEi63eNwQm4qGSp
	Jc4az3T9tXbtEYCXNAYTC501atYYUgEYAMlvRqX5nyOe11EaXHPcPm6DJxNv6NdCLu8MEbg79nq
	bIWWDCufchvGN/W0O5IsNg404PY036LyOlA==
X-Received: by 2002:a17:903:1cc:b0:2e9:a166:f7fe with SMTP id d9443c01a7336-2eb364961bdmr141273635ad.62.1793729686970;
        Tue, 03 Nov 2026 10:14:46 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392a5f48sm43693435ad.64.2026.11.03.10.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:14:46 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:14:45 +0000
Message-Id: <DMLS3TW3RYF3.230ZHPCINZ0N6@gmail.com>
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: port test_ftrace.sh into
 test_progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <DMLGLCFQW48J.334XR00MX6V0T@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com> <DMJE6776F9F0.1O5A9ZMKWYEUP@gmail.com> <DMLGLCFQW48J.334XR00MX6V0T@bootlin.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 01:13 AM Alexis Lothoré <alexis.lothore@bootlin.com> wrote:
> I initially went with a ftrace instance, but I came back to global
> ftrace because graph function filters (set_graph_function,
> set_graph_notrace) are not handled at instance level, only at global
> level. But maybe setting only set_ftrace_filter and set_ftrace_notrace
> is enough for this test ? That would indeed simplify a lot the setup.

Yes. set_ftrace_filter alone is enough.
The test needs function_graph and a trampoline on the same function.
set_ftrace_filter of the instance does that.

>>   all functions are patched       only the filtered functions
>
> Are all functions really patched with the current series ? It is still
> applying filters.

Yes. All but the ones in set_ftrace_notrace.
Only set_ftrace_filter and set_ftrace_notrace decide what is patched,
and set_ftrace_filter is empty in the series.
set_graph_function is a run time check. Every patched function calls
into fgraph. Then graph_entry() -> ftrace_graph_addr() drops the ones
that are not below bpf_prog_test*.
enabled_functions shows what is patched.
