Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446F3A9861
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786537; cv=none; b=lPXZspO3Ww6I16Ta284F1lqTZRxEf3d1H4tQD9PCcABxeft7AxDvogA0UwQZsVGqKymTif6xxlneBczdl5i6KZhLBvjdrSoWkmpha3STILweCV+DRNY9z2lQl8BAPZ8zMKcJ+suS2s+6MVKzl7BZ8XabLEWsM+xnUXEYfgiDebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786537; c=relaxed/simple;
	bh=OoOCXYnmsHcXFceRPA+Lk0L4+MHLwRINzS1Fo7C+b3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAnfLAFl9fZ6TLcq+0dINU4I6r5H2Pcyi+cvBjyVZwYCd8VzIi0RjGFnEAgceVvom8+/LQvjdXZ33raHaVF4y1KWlWORyoWwd4eAIZk2rUC5WzZJjmP1/Mo4V2TX1EZ80UbsxTT00LgmKV7m+NVHuC/bj7ThEONMIkbK/dof6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up2JHHuI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up2JHHuI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so23599375e9.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785786535; x=1786391335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bWuva+yS1TaIijzyC+2mlVwhJ1Wvxg7k7qqP6DARP2A=;
        b=Up2JHHuIaKtgPgA3fKs0PHPXLDKw+OUWzQrKZGmLbZ5SbP5jF7pSrG7LHe89hums7T
         Amy3weE6odeL+B8bzsyXX0JyNwgIfnuZbJlzrzJwxRP/iOoJj2uLRWB+IQQ5QP80NRkc
         2WTp1PaZHmeVeNF8up/a/6XiwOsda3RygS1Po9Q1xTcsdImmhvh0wxIxhVSlerUq+WQL
         QmBsWh/CNa9/jckJ+5fbQfxuuaUUwWvIGseTxRSdqgsCD4bTAddazF2Rrrxoh8iWo8Ye
         bI9A8ibJKBmknW02ybU0A50LykRhAH3iJFpRdkUGJCGzSynAunhtiXux7wGWAfTErRcH
         wJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785786535; x=1786391335;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWuva+yS1TaIijzyC+2mlVwhJ1Wvxg7k7qqP6DARP2A=;
        b=j1slbj7TKXCCFjdWB5ZdVekb3SjaWvbroc1GLHsM53/rxlItma3iqHmbgYd2GiVwWN
         Ydz4lT8Ieien+oNR4chuZzIhb+sqr2yxBOMr47sK5LL5JUG2P1mssWtxcc6OY/KkhrV3
         6a72/mUkJshvGGOYfhDyzoq7LfbrkJu8OvUvA2ki6VZSWS7o2587izEtXb46n27Hd3X8
         ns1Uv5zhiE7ZBIpLo7O16R5uP35HG0/M+JZ1Z+31yUraqSf8f/TpAvXprlUVlIUKr1Q/
         5yaVAb07b0RdDsXAuQ5r6FT3p0FJYVoAwD+RbKWLWC9rUuhxCoAAMT63Nmonj28ebysK
         6GYA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr0Rf+F76jLwve1bstelC4hK6jciEw4KRgzvxl1/iaD11U74Xxrj3dAkJ40NAddPTAtQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz36qihKLMe45psCwNKrpdLYzsb0rfvCXLbe/Tagude4pD2U2ho
	7emTxJjIB8TzCNnjxZPn9yjS1m6atBiiNVgsVXSzYwMfD/ykPQabczVj
X-Gm-Gg: AR+sD11EHk4HU5SUjfqr9lsBtTZslo8/lwermCPndnGeifYWOD/6NkunEEtpJatw922
	cvAr7I9HtCAMhtKmD7jMj0au4+E//DPyzKV6v9z4ANnJ4ypO6cWDdCX38UYeHMawbQFU7Hz3q/S
	D8SFgkTZSeB2P7OeLlhaLwBhKHyTLPN65V7WEBmzOyICNCXvZ5+/B+djyHWWpxi2bNCvXr8+Y2U
	kgdMa7vIg1eRx3sCB3bt09ThrqngfOfRwV9eq+SFsJFmZ4xqu5GBuNYRoznVACIYy0F4le14iML
	bu3QwVKNgaUKAHVgDRFSvfTTYO9UUHKmCjdmJcQVM9wdwQbwEkoga1HlLE6boudppFFMmHE0qek
	7Qzoz+HMEOOQrim+QKbKzj6UgAB7gtjkSjLuVqE7NZnbBxCduWlhRa/7S2kHiUsYAbeYBHCnydE
	C6x6Evf6SsD6IucDjwwYELKly2jG9QesQPeF/VpNeT0nhD3xc+
X-Received: by 2002:a05:600c:840f:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4980c6071c5mr221995145e9.0.1785786534376;
        Mon, 03 Aug 2026 12:48:54 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cfde0sm33538389f8f.3.2026.08.03.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:48:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 3 Aug 2026 21:48:51 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Message-ID: <anDwo-qXH6_W0_3n@krava>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
 <20260727142844.21212-2-leon.hwang@linux.dev>
 <amnqXeC6D4mjcAe_@krava>
 <d745ca80-6516-4c61-8107-88c6a2d9cea4@linux.dev>
 <amsuU7eXuoziObdh@krava>
 <3f8e64b4-e60a-4eba-afb6-5af668ac1f85@linux.dev>
 <am-sK_buCVI3khJv@krava>
 <6af761df-9abc-4854-971d-ca6e4ed7a2b7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af761df-9abc-4854-971d-ca6e4ed7a2b7@linux.dev>

On Mon, Aug 03, 2026 at 09:32:14AM +0800, Leon Hwang wrote:
> On 3/8/26 04:44, Jiri Olsa wrote:
> > On Fri, Jul 31, 2026 at 10:30:37AM +0800, Leon Hwang wrote:
> >> On 30/7/26 18:58, Jiri Olsa wrote:
> 
> [...]
> 
> >>
> >> Right.
> >>
> >> Pls see the sibling thread with Ihor. With in-range BPF trampoline
> >> allocation, the slow-path regression should mostly disappear.
> >>
> >> Let's continue the discussion in that thread.
> > 
> > please paste the link/subject for that thread
> > 
> 
> The link is
> https://lore.kernel.org/all/77edc25d-a521-4f65-84ed-dbb016593902@linux.dev/.

ugh I see, somehow I did not receive Ihor's email.. :\

thanks,
jirka
