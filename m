Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFCA37C0E6
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830766; cv=none; b=riZdsmJjjq+Qzfu3f7YPmoV9D5Hrtqj+CqmvBR299A+hzstz+7TQdxxFE5WczngQqVnCZBjWimxn07lofDCv6yGOlJxoXTLwmzZisR5sVb8QXsWmzKhxMAe54VxccVVbxtV9kvt6iI/uArXCUHdXwwB5k++4B+J+hBiF5ogip9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830766; c=relaxed/simple;
	bh=miLFvt7EhNiAlNwVMV+hibZ0YnJTrxy2WaDHFXqFBVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BubRGtH1/P+F7X9Vw4jj59KKrF+PIvm6De42rZfOkvaWQkkovK2vQ/je6y9jZeOuKEe3vnE/DfMFY9eUrCxe7/2SG39TRjfsZR+w3ikcwQO8Sbay3TRO0xVKjj0WyMLfAZyytSn4VG4k6Je6DaipuTZrvRiDhM5emxUctfkpL0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLAI8l2s; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLAI8l2s"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3652546e41aso462997a91.1
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777830765; x=1778435565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIOsGM34TZvB0EPu+0vpPxUmOc1xougDZkRZDU3Q73s=;
        b=CLAI8l2sbcXiY8VQqotwmm/gtip/RXy/rKApgeSLz0HPcHbhHYLFMCh1B2PCJIKKqU
         oPVXeESn9frj556amFDvlSxGBMOdNB/Z5wCiuoE89Ow77X2XT20DOklzODbKmkroOKaf
         tNdQzU2kWPIRuIyiYRhV/DpDedP/ydUy5CJbZ8rLW7e2LVMEipw046SD+oMJGYI0isI+
         X3g/6e1vdhVDJIXql2CxOavregQN2lDsgbGKkd0Z6+GcYco5Kgm0JDVgC0wRXURYzhOo
         mxscucAchCXxKPhSoR+eNw+tX1NtCtFpoh9ogOiOn+QbrtI2ZJZclHrwmwT8UGBcoK6z
         uxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777830765; x=1778435565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIOsGM34TZvB0EPu+0vpPxUmOc1xougDZkRZDU3Q73s=;
        b=ljmZEtqt+5bHQ+6H/EWM474SELVXU/lXLZ4UDwG7nuLHManAdp30ElEiRVEm3tElaf
         /XyJxr/y3MZFKjsPyek4djPrgp//6vAav4Pxwoxdt5B/YU0eUZ24ScUCBQ1k/8DxZaV6
         SeuPucGF4PRxmFmnH7j5ONM7Vzp8UAjSs59E82/Kjp+fSnFwPJcvO4CLsVL8CmNrB2aM
         8u+9jr5PthasOsXB0oFMkTZ0lMiaue0U+tYi8GMkzYFS1m2ennm4TDH030K2IDYfGwEQ
         NXm0mdyYdAx1G0iO1HsERZqYRC4qQH4xbbIPF+B2uGJbpg6tcWaBjt4JJdBzNPr8LT2r
         ZuNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cNNi1ZbcP5eZuPpW/TYO1nCgJhJInwQRvDqYfwn71mZmNC3QFlDwzloSfZiH9h7ZoJLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuRfA+c81Z+rkbvsSJB4MvBxSiK743ZES+SH8rBuQXFzYzrCC
	UNb9NTU7+lV/HFIcXpyueSSNDDolCPw0aIN5JmFMrFnRIhlZQUfXPJN/
X-Gm-Gg: AeBDieumWTk5EmL0QPzuJq82hILlzw9pD+QOsEVpvKk3AqvcjIigs1nIvj6Rme0Glqy
	wSJxXh4/g4L+t/8psJyLLKtJZ8bcZTVEBd/4OskHdbNE0tZoK3p4t29sHK6rTTV29clg47vO2Bp
	WRYQ7ksYPJx3Pb+8OyymgDiNQ/pShkV3Xjt3+u/XmkxGl5kADUJpcinkRVv1tAsO/6IxkWDYi6+
	r2ScTbutR1ugj8bbXkrcNl2FtZOf8fwjo/xKc81sXZFGJ9JbFoJ35h58WoS86JfPuHxPoh0DQUp
	gAjICe0yESh6nUraXaqOvjTEEOlV551J0Xs1q/i5R7+q+Z/7npjD68aWxEDdgVsUAz+GRSybfVz
	rriisqa8eVQZZWMQ9iMA74E5ToXpaNd89nQrezQ+V4j9Vk70lkB/uAcjYI6bVKsaVlvdb/rLupo
	omv2s6A7nJUMALOMnRxIZdISO/u4C6ia8vM3p1b4wTrI8LwfcFnZdU6HB7dF8TuIr49ck3aL8XW
	4MbqLCd
X-Received: by 2002:a17:90b:58cd:b0:35f:b7c1:faad with SMTP id 98e67ed59e1d1-3650cf46e39mr6719559a91.25.1777830764967;
        Sun, 03 May 2026 10:52:44 -0700 (PDT)
Received: from google.com (61-230-38-200.dynamic-ip.hinet.net. [61.230.38.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54203sm11772435a91.7.2026.05.03.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:52:44 -0700 (PDT)
Date: Mon, 4 May 2026 01:52:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: geert@linux-m68k.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
Message-ID: <afeLaDbKdAB0MQYq@google.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
 <CAFr9PXm0qxeSYq42MEOARKsmOT-hRLbT4UpchkwuSOMYKYzfOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXm0qxeSYq42MEOARKsmOT-hRLbT4UpchkwuSOMYKYzfOw@mail.gmail.com>

Hi Daniel,

On Wed, Apr 29, 2026 at 10:51:58PM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Wed, 29 Apr 2026 at 21:41, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add a BPF JIT compiler for the m68k architecture.
> >
> > The JIT generates m68k machine code targeting m68020+ processors. It
> > currently excludes 68000/68010 and coldfire processors, as it relies on
> > 32 bit branch displacements (b<cc>.l) to handle large bpf programs.
> >
> > Tested with the test_bpf.ko:
> > test_bpf: Summary: 1053 PASSED, 0 FAILED, [1041/1041 JIT'ed]
> > test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Cool! Which CPUs did you test on? I guess 040 that is in QEMU?

Yes.

> I'll check on real 030, 040 and 060 machines a bit later.

Thanks!
I really appreciate your help with both u-boot and the kernel.

> Since you are doing code generation for m68k now maybe you could help
> me when I resend my patches for runtime consts support? [0]

Sure, I'll take a look at the patch.
Feel free to Cc me on any future patches if you'd like me to help with
reviews.

Regards,
Kuan-Wei

> 
> Thanks,
> 
> Daniel
> 
> 0 - https://lore.kernel.org/linux-m68k/20251127000505.2117956-1-daniel@thingy.jp/
