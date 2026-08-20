Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FE33C1D72
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256308; cv=none; b=q/EbDEkPZOUOrtn7v9lsm1G94QMgPvIYwGGgTy50utUt92rnwFGbk/qJ69dlNLl7/2p76XPiiGBRD3SyuFQxGojsT+u0lWVXJKFJQNnPjOqVWSxzXeBr8tdHPd5V881pBAvEZ7fqzGMh40vkKzUCSbKV8k4dswBGZauKUultobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256308; c=relaxed/simple;
	bh=Aw/ofYSmMq/hCctkdEPZ9sneab2XTminwcfhlt6xz3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWhu+qy2B24Q8mAgNSeHvuNbejAWlXsq5u3kqQ9V3CXrKo+i/zoAfv9v3S92+u6u1Zo5uhEGrcdrrcg1o45XKI6CO+aALzwlg1zIsOQs34Mj9uQcNtD0YVVm3kfbiY+Tq1h0xeJ87wSZOvcJDEYiBtW6cZ+k85LKXhFFrkbG4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CspOK5+8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CspOK5+8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso1859595ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787256305; x=1787861105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+ttLV2jMb/uOUdRDGthE1WHXT4FvT3P7ffiAV7gUtI=;
        b=CspOK5+8rXyfrhCiSkiXDpyCsuBHQUUYtm7NREaRjf48p5mXd9uLLSVBLzWt8FhdhD
         BvnzmGQPVmFq306Hsl5npy8DBYOYjaDGv5QFOnbTLAfQ5SNcTr75xEbDurQBBN9pbd6W
         YQllygYUNyDq0gU3ia79PycvUh1QerCAbwF1JMM/h45ovXt8JMnacYRtJasKMV7CZX5A
         PjvDVoo0AyrQVRddbTO7t1cDHdtYx6eY8d8IEqQRB1nLbL4w6yNSbXl3LJGEV70t4EZ7
         b8UZGipq+Yu8zxh4/f+J7xwa5Ttrgq+wkiNocoCHGNbsIwnBFWz3uOL8B93MmQJMfb35
         Jycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787256305; x=1787861105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+ttLV2jMb/uOUdRDGthE1WHXT4FvT3P7ffiAV7gUtI=;
        b=I6PHrcXy33kScZecFXAb3W+2q1H0Qoxx3xQl+SnzvNU2JQTHodAWXUnEoV56ZpVL3+
         4sz/31Nw0dfYGrjZoFUkXHNErZYT5V8LqaeWzUxYpVF+WlDgrhHSTBVvutDAFnM6T9ve
         KCl2oi9vlCKNRFRB//NEMhaGsJ7Y1rplAbry2wEat4M/3Q1J0CnEdLkQQ51ejnF8jXI8
         qGWVJGRNrQrpxsqHWDICnevKWt3y4+SrqxdBtbm4a4GK/G+yZtQV0V4NqCo6u4Bt6PlQ
         +geVjJYv0VuFaqFgzLZMbtymtGWv+Q1nm395zBbiWl+AbQYd5+MIlWyh9g4muwVTgAv5
         l/iw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+IbSXci6ASSlOD6ea19kkqAHFVKRX1jy5FJv3CmoxrPdTmkSsTIqzpojpFV760tkJr0c=@vger.kernel.org
X-Gm-Message-State: AFuF++lJQtqCnB/4N8M2r9cGgxKD6jq6MxvBodnk+KF4yP2BMPNV14SZ
	oJ+tJmOU2deA2/FDu8PjeHKFtA2i2MQmcU/Z/2PeHWbS5/Nv13kDS3uE
X-Gm-Gg: AR+sD122c8yj8bbygRaw2/MTWLqOQeMHPf2D0tvagMF9jZHRY0pPmDZTKjScssaeqNE
	vx3GIAi3QDGQKqs/ndt78NasIMqWAcNRTdsRXgT1aNV/j7zjVPpXY0ZsdY/nAlUCk5ckrqupQlI
	GBuxXR0Fnra/rDiXZCd/Q9k1QXbGGKBltTrcP42tejdlD9VNYekZVvGCykeHj2PHySNk49TjkzK
	+LmjrvPZGS3kueGw/j8SjKhtpQ3AC0tj86xU1ys8/ZGKJnGMdP6RAAiRyeAJXr5YwgFU96cwSMo
	OpoVjnD49NPUvWAhVg26+DmDtO8PTGL7THxRZyW/knFsyLnfon6iyX80g7L3yIHVHUzBk3OslnE
	2ljKAPLPJFnP0XIm/V0xrSR8ZqZx67CxC4A+lFnr494Hm0MOuRMxa1NcQE0nX/dEdHRyXwO5k2J
	6hE1ZmilneFB/7A5S7bQbDv5kj0dEQjulK+OcImePYJF47g/Uk0ncqlPSgjizC75T8tPkWknhoM
	8mpcnTA
X-Received: by 2002:a17:902:fc48:b0:2cf:7ea3:7cf1 with SMTP id d9443c01a7336-2d61a078e1amr118047715ad.5.1787256305116;
        Thu, 20 Aug 2026 13:05:05 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:6b::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf191821sm18740151eec.28.2026.08.20.13.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:05:04 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:05:01 -0700
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>, kernel-team@meta.com,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cgroup: add BPF kfuncs to read a cpu cgroup's
 stats
Message-ID: <aodd7S4Broor2oHt@devvm16600.scu0.facebook.com>
References: <20260818002450.3071325-1-ziyang.meme@gmail.com>
 <20260818002450.3071325-2-ziyang.meme@gmail.com>
 <aoSTaFwsVEoNW01D@slm.duckdns.org>
 <aoTgVOTxsEbFXTp2@devvm16600.scu0.facebook.com>
 <aoTg7ybddqzoZbz7@slm.duckdns.org>
 <aoTx1eaNNJ+xrUq1@devvm16600.scu0.facebook.com>
 <aoYYX60TCD6cd601@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aoYYX60TCD6cd601@slm.duckdns.org>

Hi Tejun,

On Wed, Aug 19, 2026 at 10:55:59AM -1000, Tejun Heo wrote:
>Hello,
>
>On Tue, Aug 18, 2026 at 04:59:17PM -0700, Ziyang Men wrote:
>> > > The bpf_cgroup_base_stat() takes an rstat spinlock_t, which can sleep on
>> > > PREEMPT_RT.
>> >
>> > Is this actually required? This doesn't really make sense to me. Shouldn't
>> > what SLEEPABLE mean change on RT kernels instead?
>>
>> Oh sorry, I didn't notice that.
>>
>> I might be wrong: this function calls the cputime_adjust(), which in turn
>> acquires raw_spin_lock_irqsave(), so there would be NMI deadlock in the
>> perf_event program. The __css_rstat_lock() take the spin_lock_irq() as well. So
>> maybe a SLEEPABLE tag is still necessary?
>
>I think this is for BPF folks to answer. I don't think SLEEPABLE is needed
>because of RT but yeah it wouldn't be safe to be called from nmi context.

Ok I see, let's remove the SLEEPABLE for now. 

Thanks,
Ziyang

>
>Thanks.
>
>-- 
>tejun
