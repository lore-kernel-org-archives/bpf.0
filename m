Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0913F0A98
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061559; cv=none; b=ZrMsRPzy2ro1isGrPl9bCxuXM9IqxDLH+tKAG9sBHBIeH1cY4+wc9n1CCBacG3lXiJD0ir0AxrUqwkQpLxiMWtquVRVMJEnHtPqmvnjsJmq+vDa5/yv5sYFtLfFQuz2egc7Svf3lTF/TqYEGUvNdS+mIPaIhqdKlP+Ee9EKcXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061559; c=relaxed/simple;
	bh=EDDonT/gV6kNf+AmN6XTlKHonw2AGAiFQ6rygvGJi48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khengts/EVDvrHJbtHyU2oxH+48TDILMqWIGAzfXhEPBtHKq5zKsyC5v8GX6VByjICvS13CRlle4lJYUp+X+PWtkCdwEFpFnBGLsEnJJAWxmiiv3RLhv7dvL1UgIew4nrEYQHUc90Sv+n1OtrW7Jl3a589PRuiwayBH8xmPEeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTksaRmy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTksaRmy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7927261a3acso74536487b3.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777061556; x=1777666356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=54deu6wo5n8tEL/vkpg6EDb5n7YLGB8ILix5XPcjPNc=;
        b=TTksaRmym3Gt1FS4ZAXuL9+1XS4qUg0bpXls3WHgYCRp2GBRDXudaWogjsHmSzSrgs
         nj9hUlc46UUA3yih0JyrYEyf7BRAMS06tCc87YjXhecJ3pmy2hylni3XQv0PRNYf7eBH
         /b049zBZDrXVPtz5c4h/MCYdVLw4RCVP/3nXQU+dCK1WoX0yk6OG9dNcnCaksukHzLny
         e94DVkLS9mEuGrV0Z3PI9IW/PsHM3X5MY/5iHgIaJwG/3kEB8K3xSlEhi+0RMUjONh4f
         h4qJfk4dFojX7T5hzoEW++kP09DpXMRbAkcjcMouPvoCWSS7a0wUJwEQKnt41LCglnJx
         SZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061556; x=1777666356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54deu6wo5n8tEL/vkpg6EDb5n7YLGB8ILix5XPcjPNc=;
        b=QvnOO2sZiWtBPyB0C8jlmlZHnre1yfj063J3nHKBt1y9pOJLkPEPXwMsBjJkFYxdjS
         xHSRSqtLK4LSxJRHyBu7vT2tP+KSoZzsjjKfjnpmzukH/hCz1C0gfVBBWiWKqqFjyo7w
         86wQBRxgzmY0zdpxWxnzjUYDRB3A5HYsdZw3bioMOEnvfyeffZdcR+kj+75r3D3NGRnF
         dpg+fpoTEhiQC3mZtww+Q4oMFCbCfLnOl8T55Ot/EAb5EHJ35GxPWQcoKeny+9p0lXAE
         sOxSnVOLHcW3gPyBKQCzzhoO35cbSBLYVGOTJVfyRogT9eajhIfXq4E8xQfExYsLhhOX
         F1VQ==
X-Gm-Message-State: AOJu0YwybKnOikZfdRic9orFxw9ZGwV4EsfrA/LXQHUt7joBlnNo4IDM
	1/xphH89V9z449iHeUo1Ivi8NNG76sdqjUedtN+M2zXzGskwOUkqtUY756UrIw==
X-Gm-Gg: AeBDiesGNvYbrBXS66UhHrWnqVUGAR1p4W4TOH8T6ASVa0JHG7eYIn+gOaebKyKYsfK
	6iTxC8x7Csn0c/LZl5m75gTIErOxO6V8+FUMBPNgunenho0LyxgWIPbkCW8Q5zcP0uzOMNKy3OI
	36dVCYOhAXl9Njgsb6tO4s2iSfXUcVIp7l8jOKjdi2F1e6ThSAkK2vwBetsKNQ4Bv1yuSGeD0ps
	SokxuNwZiNzfhakJ2n77Sfv3HX7ztTUybBHC9LT0t34bgB8wEXG9Jx3tFZUty7AR82dppxgcUhb
	/XbZwTI41gcmM2HrLklxEmh5kbJEaB8aXgChj99SUlP1SeOpoiVlnceVEg8J0dmK/M4yLUF7ulg
	xohZkvLHxquYFe0F8Vnn2dfFMjSbB1jmNfs1SzVDwNdtTxxsCm8AJScPK8GIWXzBVO/OELAh3E3
	M80S3ex2sHvRKbmkzSuCl429EJlEs5morywYFNocPhw2wiCdfrtJLhlw/eMviottb8HuU=
X-Received: by 2002:a05:690c:11:b0:79b:d56a:a7c2 with SMTP id 00721157ae682-7b9ed0108ccmr339263157b3.48.1777061555791;
        Fri, 24 Apr 2026 13:12:35 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:cc96:e003:f6cc:4ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee8c2083sm95503157b3.17.2026.04.24.13.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 13:12:35 -0700 (PDT)
Date: Fri, 24 Apr 2026 16:12:34 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF
 ID
Message-ID: <aevOssMWH_Vm9CPG@zenbox>
References: <20260424192252.695240-2-utilityemal77@gmail.com>
 <20260424195958.AED4EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424195958.AED4EC19425@smtp.kernel.org>

On Fri, Apr 24, 2026 at 07:59:57PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Calling `fput()` directly from `bpf_file_release_dtor` can lead to a hard deadlock when invoked from NMI context.
> --
> 
> commit 6368f91be1fd91bc9cb38d3498f35d279bad04c9
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> bpf: Implement dtor for struct file BTF ID
> 
> This commit implements a destructor for struct file, allowing it to be
> stored in a map as a referenced kptr. The destructor calls fput to
> release the reference.
> 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2bb60200c2665e..ee5ceb82e4f812 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> [ ... ]
> > @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
> >  }
> >  CFI_NOSEAL(bpf_task_release_dtor);
> >  
> > +__bpf_kfunc void bpf_file_release_dtor(void *file)
> > +{
> > +	fput((struct file *)file);
> > +}
> 
> Can this cause a deadlock if the destructor is invoked from NMI context?
> 
> If an NMI-context BPF program (such as a perf event tracing program)
> updates or deletes a map element containing a struct file kptr, the BPF
> framework will synchronously invoke this destructor to clean up the old
> kptr.
> 
> When fput() drops the reference count to zero, it calls
> __fput_deferred(). Since in_interrupt() evaluates to true in NMI
> context, __fput_deferred() bypasses task_work_add() and instead calls
> schedule_delayed_work().
> 
> This leads to the following call chain:
> 
> bpf_file_release_dtor()
>    fput()
>       __fput_deferred()
>          schedule_delayed_work()
>             add_timer()
> 
> The add_timer() function attempts to acquire the timer_base->lock raw
> spinlock. If the NMI interrupted a thread that was already holding this
> lock, the NMI handler will spin indefinitely waiting for it, resulting
> in a hard deadlock.
> 
> Would it be safer to defer the fput() operation using an explicitly
> NMI-safe mechanism like irq_work_queue() to handle arbitrary BPF
> contexts?
>
For (human) reviewer context: The NMI stuff needs to be addressed separately. [1]

I guess the AI isn't gonna understand but just doing irq_work wouldn't
be right either as it would break operation ordering for maps and
fixing it here wouldn't fix the other dtors broken in NMI.
(cgroup/task_struct)

Anyways I think the AI didn't find any other problems and the test issue
is fixed so this should be ready for another look.

[1] : https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> > +
> > +CFI_NOSEAL(bpf_file_release_dtor);
> > +
> >  #ifdef CONFIG_CGROUPS
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260424192252.695240-1-utilityemal77@gmail.com?part=1
