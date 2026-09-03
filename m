Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F336B939
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477942; cv=pass; b=L7YOUE1MqhfjUuKAb0sr5wNsvMwvFanGjb80EN9q+hvFQJGxRfZugds2CAszOTaPQo8fLSBqIrt7+zlq7IOQt+7bReo9FBq2hrbxfhZmGP8eEaKG2Gq/7HWW+ytBhKP5+HZuYyUMYLosDe4Lnb1+CWR2NWXhlu0pajQIIfgPduw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477942; c=relaxed/simple;
	bh=9Ecw7i4IFSWAiYgf4yvpHq/WIZf2MBln7vAiGJOr+Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojaz45QXlAm1rN7FD39heRd7itFIPOukntk/EVM9K+g/+E/6xi98+uLjbLAItbV4C1REVHRlb4PixeIZlf0kfrVAjZKcJrg9muu7IpKSlMZbqEpReADPMHtbGV+wm8vjiw2k4O5iwCgRSbJYEkcqKQj01/gBN98ardsML486vKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGEz6d2D; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGEz6d2D"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66f8908a887so474354d50.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 16:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788477940; cv=none;
        d=google.com; s=arc-20260327;
        b=TrktSUkUcUo4P6WIGcKzWQ2JSbEQZBYjOmrXdLys7pc0DIIYaUliLckFSIllgUjUg0
         1LLPNQmd3MvRPAWFHwG5j5KQcTuUtEPCXf810fQAbyd/yrz+w5L1mYT5J85rPuQWuAOK
         KMKhPM9dycRgzzhsI77jyD+nEUAGkwWG5k8Fl2//6i1R8PRn5AdFvya1Up6w+IiWwAEV
         Az2Pvutit6Eul4gZOGDghxi9oygUyz14t8vuVQkztiEpHdp50F/bgBwljCEc/Ive8V77
         OcKOaGOrYJVO1zcB3Lo94qQ/j1/e67Y2ArGAdjeZK5/VvXlUYUUcm/tS4Ieddsye2QIY
         uYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9Ecw7i4IFSWAiYgf4yvpHq/WIZf2MBln7vAiGJOr+Vg=;
        fh=/tbCTvxHrzrrDqGhveJIqe51r9LHTUwkt981Np+NltM=;
        b=g/RrP/cJhy1X8F4iRI4sr2KgShIUNag5jzvWpbQyISx9q0V6vfsGe2gaBQN6jyd1xo
         HkP5Qlp9mW3Ds2Hj3vnExHhjVTNlOZQ1HqrHrSB+geqG3gtsi095Lz/BPgRiE+ztKprf
         ADepMe0S6UYkWC2a3hkdXVcMa7xEnuYvJ8T7qNHDnyhgihoMDh4rZJu20Eo9PZmsdcD2
         LruOhw+aRrPdH/XIdgACIX6WDobnz67EL5w6FH9fnPd3Ghx2+RVvECkp4fWwmMXCRPlQ
         2uai2jxJg7bXmS9gCOTubzNWpIYi20NanNregMglkuggRuRWPi6tYPPrKxltwkvHbmkw
         40jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788477940; x=1789082740; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ecw7i4IFSWAiYgf4yvpHq/WIZf2MBln7vAiGJOr+Vg=;
        b=LGEz6d2DHJDEY+uo0kBEqASQbtoihJPae2Uj0ZEgo6e41E601jmPYJi71IEhgTg+o2
         5JPhPp3/pFejwoRVNfwkQtFjS8hssoe7D3y+4+xK6oloOVOLJ3/kUyhOmX3mDSFSZKTJ
         vpSAa5pUuEAnme9Qud0H5AJQ1kPH3K35W+uw+6YuyS6zmWDwGDEYI5aF2ftPd4qonvjJ
         +uyE8O9tO7LkPb+2J1rrlq6zexmIWbzwC9nc1woiH8bPrsrdFSgU4DhMbjJ2ATmAkuxT
         CV72lG+v8XCFPzRaQD6aT4YVDQuMNKPRZJW2/ZlJRYo2PNvWrBS3pDyGgHIclIoODQIt
         /Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788477940; x=1789082740;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9Ecw7i4IFSWAiYgf4yvpHq/WIZf2MBln7vAiGJOr+Vg=;
        b=hX+KFHTVIyW38KteaIxIgCr4qYX/mCAyglYCykc568Auq0HRT0VRdoX4dO3Kj5w0O5
         oDPd2qKQnqahE0izdI/N4xDQYkAEcyDSw8VoLEg6BE+hvbLHOJxkQJVjDrWL+Old9lOr
         /x7XvqnM8wJak3zaMjGTV2dgaVWBcVKSeVkfUbnchqTE5AFQj4ZvRE1v61u8GBbhnQPi
         XkkSxQ/gU2A9CAAUam3+5QnPd1KphL6F9ZEswiuBpENmLvXealinI2kB1ClCPmkeEhTc
         mVU+lzAQpbHwn4kDfrnmyDJWg43ksX6rJCKv+ucajIBnFOB79raaQzK/aN/fOQno+9xc
         te2Q==
X-Gm-Message-State: AFuF++lC6WeSPYUQtU9xO5nerCgXDDuydDmBW82tAaQiePPo0ps3rkGy
	BshxXbcUMpSsm9Eov4Rseqm8LYzto2aqVLO+trPZ8Y099+aEbNKGjSK4oeCLW6Ya04DtYmNFfSU
	J3k4mL9WQwp21NEFU5j+PUFBj1xd7GAU=
X-Gm-Gg: AYBFou3nbzgaIK2T+QMozLR6DySpgHFB1jsXjK0lA5tmSnj38AfoicHsnw76UAhGnfb
	PqfhffMXVbvq93NaJYLG6FPqk2KyOyg1TdvwUeAapw1T/x1j6L8YwEwiNv3uNf8XDNFTsAnR1oh
	x28xqI5CxzoaD6veAr8oi3AcvdGdANnbw+urdXqVJQ5IglC45INQ8JjLfPseXBOUJ4kZJyPpN7C
	+L8jxJTKJYwyPbG/lqXnw3zWNp/JxIToePzZkWZEkoZCSrcRxWSvYP185hZaw2MUSDzZdO9fuRu
	IfYaTK7JQxK/ym7q6O1J+IqiSlRQ0CmKpbDuMaX6IF5OmYYjAJ9+U4G9
X-Received: by 2002:a05:690c:62c4:b0:870:96e4:6716 with SMTP id
 00721157ae682-87127b36981mr15271717b3.28.1788477940163; Thu, 03 Sep 2026
 16:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819010523.1057789-1-main.kalliope@gmail.com>
 <20260819010523.1057789-3-main.kalliope@gmail.com> <CAM1=_QTDhirxjCmXUqvPqTqXMY=uVVcPXE0H=qHH_B+7XFrnpQ@mail.gmail.com>
In-Reply-To: <CAM1=_QTDhirxjCmXUqvPqTqXMY=uVVcPXE0H=qHH_B+7XFrnpQ@mail.gmail.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Thu, 3 Sep 2026 19:25:27 -0400
X-Gm-Features: AcwNN1WPW79iTNDFIj6Mm2_tt4C65PnsaWbhuk-2wHJUQ72fLnU0kvZ9DHQ8yo0
Message-ID: <CAJZwKkj_-0vkH7nUr3=oUUZSpNSk+rsqcJW8MWnqAPxMbrO44g@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, paulburton@kernel.org, 
	tsbogend@alpha.franken.de, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Fri, Aug 28, 2026 at 12:16 PM +0200, Johan Almbladh
<johan.almbladh@anyfinetworks.com> wrote:
> The MOV/MOVSX structure looks good in general. Some remarks on the
> implementation of individual emittor functions.

Thanks for the review. I incorporated the suggestions into v2: moved
clobber bookkeeping to the common emitter tails, grouped the 8- and 16-bit
cases using 32 - off, removed the middle returns, and used emit_sext() for
the MIPS64 MOVSX32 case.

I'll send v2 shortly.

Thanks,
Nicholas
