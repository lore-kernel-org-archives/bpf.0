Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E626A1CF
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769588365; cv=none; b=gW5wGvJxi+DFgbrlhcvpWNnYeRrSIDLk6thJAdZDg0+t5UA1rXrilPn/yrrKwLzyrK9vzFkqrQ3Ct75fbYJy+OKK5shO2MJABOcXrNQXalJZMtg49Gso+f81Uch6LzqysoWWaMbCqQg6G1zjrxDgXznHlUx//SU7NjY99/8fYuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769588365; c=relaxed/simple;
	bh=I3RR4mkzvl3vrE7xdB+EXcNPHaVK9jeMfWJtpB2Cb/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPPOLcaUmMC2SYscqBkDGkK8V91Ciomao1+SP/wuFBfQgOzfF5xvUM/e+nPZhgfR2M+KEgol4CgQsHhEFTCE5OBUitt8B0+TEtyPHoWnJaGh3b92fbbZK9Tj7+CSFXBa0mZHvTinINvrSdeWoWHah++nz7MN/+dpePpmfRG7Sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YektZVu0; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YektZVu0"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c3e921afad1so2427196a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 00:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769588364; x=1770193164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syby8oeFyZiDA53Kg1ApA4RRxVSYxXfIUH/FGHxf7A4=;
        b=YektZVu06aPh2N57E9Reg7Bg5oXylj8Cs/Ww/9s/CT+T6rVCNDqF43ogxGpcIAzcsD
         UhTb7+HLeLnZ08xeyCEIZoukDhPhkpoEhT3bgfR8nqGRGPaHzI9ryqQ6Y09OyXEC+TgU
         +FWz5K/tA5lmQqSoJ7vjKmFzeWViN2rhQjPwfPSFDi1h353cOYQg8ZF82rBh6X6hW9LA
         xWkiAmKgflCRHG8dCinaF3nYtJiAZrVMqZhClbhFPgWW+XzYQ51sBrxQsZ9lH2UaRTnG
         naowKAMfrFkUnAo5UmI1+nTPCeTSmkTmznzXHlfg0FwqNnu62+h53G627UDTKXsn1d83
         KaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769588364; x=1770193164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syby8oeFyZiDA53Kg1ApA4RRxVSYxXfIUH/FGHxf7A4=;
        b=gFk9yroGHSmSJg8pYRrxFNFWsEu79jBb3K++RnMukrtoeM6neJD1w59NA4qmNh6bsu
         C10uta6HO4imo35neqoJkGMxtV2d2IzEl+xHgx50we0fHjHN890xveylFjJkQyImCKPZ
         oF/9f0r5q+byRaLtIZYo4NLPlEdqfiXekhYf9zdytliCQnWkgUfi/CQOqKDlro9SaHM7
         GdLIn4LGOQDd37170B7Yc40BSBEWaySQEPU3I0kgkokGsM1vmhvGbRwMfu1GvfGvLMCH
         cFHS23ZJ7Fj7rsx2XlaAwn9FsUD5wg9W7vmooBE0MfGqCScgRs81KMPQ+mnuLBAATifg
         o5cg==
X-Forwarded-Encrypted: i=1; AJvYcCUnq5lvmIP+txlLg+G7mn1hwS68KbHV+aTgwHjScomWFHwIQvW8atNZ5mv4sRhL242bvRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBl/lEUG1tyTBdA3ehvFOQHL/XlaNV6lmUBWQ/sWBsx1s8MYn
	gIbRQxHPeob2UPxT6dz9CLGCvI2OCjlToT1gfMCdEfHpCxS1x4V+3E0u
X-Gm-Gg: AZuq6aJQ713PBVfeMBQM+i+k+mb1gpHO2JZ6bCsFNlZeUgibWr+gTd/F8NzWeaXEdbm
	u8bBSgh+HmtTd7pSkd/V380L1Obn20N6sXGOZaDi4M8IYTvBAVokupWPv1u2kKIsMVKfQ+F4iKf
	KhpobXMMefqL4RdgITutMyrjfp1p6DwFmKUvYS9FTC8N89kje8aplQOQp+HoG9kFgY2QW/Dwr2l
	i/Wj94TWaq9Pao5cNIxTD5jyJ6JCLU0lGjzaZTrv6D6T8UmFKb45RHhL15J7xWfKCe0mFKFMB2d
	MaSprPAlCXZ6sJcvrVKWXTFHK0jvbYLaM4OrCZD/ru6AnH+ughr1lgCaukf2BZlgciCvJwqNRAl
	f5YkhHixjL+sZCFHzbr7WwvmVLJu5CcPZ1kIqE4Cs3zRMEXWkjp7WecX2ccjnf8x0A0Fv87aHzN
	yZazhCdw1NnSErBxrN8eY=
X-Received: by 2002:a17:90a:e183:b0:34c:37b8:db34 with SMTP id 98e67ed59e1d1-353fedb153fmr3633477a91.32.1769588363583;
        Wed, 28 Jan 2026 00:19:23 -0800 (PST)
Received: from [0.0.0.0] ([188.253.4.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm1664437a91.0.2026.01.28.00.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 00:19:23 -0800 (PST)
Message-ID: <874829ba-00b9-49cd-8f67-a4c33a8f409f@gmail.com>
Date: Wed, 28 Jan 2026 16:19:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf callchain: Fix suspicious RCU usage in
 get_callchain_entry()
To: Qing Wang <wangqing7171@gmail.com>, andrii.nakryiko@gmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, irogers@google.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 namhyung@kernel.org, peterz@infradead.org, radoslaw.zielonek@gmail.com,
 syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
References: <CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com>
 <20260128062656.1860201-1-wangqing7171@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20260128062656.1860201-1-wangqing7171@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/1/28 14:26, Qing Wang 写道:
> On Fri, 19 Jul 2024 at 01:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>> Which is what I'm doing in [0]. Radoslaw, can you please help
>> validating if those changes are enough to fix this issue or we need to
>> do some more?
>>
>>    [0] https://patchwork.kernel.org/project/netdevbpf/patch/20240709204245.3=
>> 847811-10-andrii@kernel.org/
>>
>>>
>>>> ---
>>>>   kernel/events/callchain.c | 11 +++++++++--
>>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
> 
> Hi,
> 
> I found this issue still exists after your patch in upstream and I have a
> patch to fix it.
> 
> Patch here: https://lore.kernel.org/all/20260128061753.1857803-1-wangqing7171@gmail.com/T/
> 
> Looking forward to your review.
> 
> --
> Best regards,
> Qing
> 

Hi Qing,

I have a change that will remove RCU. As Andrii pointed out, using 
get_callchain_entry without RCU lock in BPF appears to be safe for now. 
Please point out if I've missed anything.

https://lore.kernel.org/bpf/fb745675-e25c-4dcc-be4b-4a4411056755@linux.dev/T/#mc0fc5e0fec2e6456f72f402308fd4e397ba19d09

-- 
Best Regards
Tao Chen
