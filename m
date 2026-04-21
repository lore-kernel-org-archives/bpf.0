Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA815B0EC
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737924; cv=none; b=KoUmAYjJlphK2RSqLP9B/0s+wDNVhOUdby9SytuTQrOnTAm+5Mh8tAyGn2uRC/DLrjzZdn4LEKCkd6AVyWmJsckRIPK6VypVenHVtLvDHbnniSjrJ/Xe0nnuv9kcTj1UN4n1749+rpJyd3jCpjEtZKaw9w4UtG+0l9gq3rUc0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737924; c=relaxed/simple;
	bh=8rGyBy/ZRN4q7EJ1m1I1QzDr+63hTD5LpQQ0JkAgNIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUNkxbprSEUJGDfHVDmQOVnE3kb90t5WNevTe6L5GASwWOGUDLFMHqq5zniAZO9QCMYkyA3LVqn/9/t7LTMuIRabpctulbPitNSRQSPm71qu1ayQZASH9Vzo8mguf99Vr9Jlm+rjC6OKYOuO1IQG6hegU7Q/+I5X+kKF0GIHjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Krr8XDzd; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krr8XDzd"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7a43424f861so37858447b3.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776737922; x=1777342722; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xCNeYMOizsEqn4WcsJW3FhU4jSP+KC2SeVh9elSYjU0=;
        b=Krr8XDzdFar1mVquj4gCSCmkwmmGI7IpNcT/m+CnOF/T8wB6uln6Ts13LX2lJZomDo
         02zoOKS4J95EsJC4l+9rcB1dbdEPNyJtvU4lyJiWYZQcwLh7za3aycMBrIXFsG/ZjeOv
         WElQP1STrm6r0/Bn+rIxORrdeDT0fP6oXVGjBySFRolwkJgTKVKPZCgYCwW5m6S3nXrR
         plA+y7kPO/qA4UtNyG3J4FJJM6yl6X8dq7JZynIrjQz2jPlGLuHlmfmqqSywFM3lydfs
         sSIPmeWZcvJj/XoJXl85a66tpVpgki1AVBw0NdsYXc8B7j1sGAcTAGPDUOo5azh6YYMX
         78qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776737922; x=1777342722;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCNeYMOizsEqn4WcsJW3FhU4jSP+KC2SeVh9elSYjU0=;
        b=JaFjX6gQndp7Z7KWMQvGKPhuAI8SAUNJJ5prGzfQqTM2s64uB8HJfpVU61iwT+SumK
         9qnUxeUg4ewcpitdGSjZbSZpk5m/51lBfBYHr+fFTEa9SIOC3kjFUtrXbOyirZXMaTSi
         OXlVvG3Qov/SQtUWT3jVtWx32beN+LpK+4KM2Yt63//fd1y2/yzC38W+OqFSjVLwJMc9
         FV0maqB9JFaFwMjCpnG2VCXZrSPXKKdSdiw2jXa1UCGmu8MFkjdhZx33o6+GP/TtmN/T
         827Ez2yB+a//I188IqlTtFooDfb7qdLB9gSIcE9v0EMdI/Kayi7XkT3nI/+QBkcof5IS
         1qrw==
X-Gm-Message-State: AOJu0Ywyx+wkt6dBeqhhHfjZ6Wxsru3eZ36ujKUP7u4qLYBUqbYohKhX
	3xLvuYcVs9svN59vS6Pn7IB/6s2OMHFDyeu8+NFQcP4Q8ysyWzgYM/EWAAnVHQ==
X-Gm-Gg: AeBDiettBOEvgwDepV/BUnv0LwnLY8getU+GrVds6NS1nhsHh2aEr7lSsJ2OmQL+G5f
	wXvqBEKgww1rdaJ/0QEEgpxUGi+dfCvQzBQb2q9sDTBWNVe8MQfw1N+a07gNWUrA+MFEz4swa9E
	xeWY25YAj3NoK82fWUU7pJh6bZypuNQPRZenJ8A75wAZCiw7UBWuK485MsTcEbUzoNmhQGLBVFJ
	IWeqM/BLRufNbyH6evC7Qsvwe7tTEc8jBN96wiNQ5sPtI5QDJouDsacGOEZLSB9TXSl3Xr/Scw0
	TV7VPnBJzRPYJSVJOmLCCzMZKABMldfKSad3J4XB8oUMvUPQ4xGhIKFVXhyD98T0WuGf/rngpVH
	NAQ6GFBpcOucClsmYikp74h2A2cWRWmEf1CmcwmIHsRl2sL4hLI/EqHYcixy6F2GbGjW3qabbSp
	Zoesz+rsZN8YoDV5V20w5GWB2lrM0bLPKxgBTnwl6D7otKshmMpHD7zwi8WKZfp6SrAcMx
X-Received: by 2002:a05:690e:1913:b0:652:55ec:6a2b with SMTP id 956f58d0204a3-6531086f9a7mr15307746d50.25.1776737921945;
        Mon, 20 Apr 2026 19:18:41 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2ac1:99d4:1cef:9896])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314e32a25sm6094684d50.13.2026.04.20.19.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:18:41 -0700 (PDT)
Date: Mon, 20 Apr 2026 22:18:39 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement dtor for struct file BTF ID
Message-ID: <aebef2Mz9fLoChwK@zenbox>
References: <20260420203306.3107246-2-utilityemal77@gmail.com>
 <20260421010536.17FB1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421010536.17FB1C19425@smtp.kernel.org>

On Tue, Apr 21, 2026 at 01:05:35AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] bpf_file_release_dtor() directly calls fput(), which is unsafe in NMI context and can lead to a system deadlock.
> --
> 
> commit b9990bf55467191e86e004a62cdb84e6dc71b794
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> bpf: Implement dtor for struct file BTF ID
> 
> This commit implements a destructor for struct file, allowing it to be stored
> in a BPF map as a referenced kptr. The destructor calls fput() to release
> the reference.
> 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2bb60200c2665..ee5ceb82e4f81 100644
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
> Is it safe to call fput() here?
>
> BPF programs can update or delete map elements from NMI context (for example,
> in BPF_PROG_TYPE_PERF_EVENT programs), which will synchronously invoke this
> destructor.
> 
> When fput() is called in an interrupt context, it adds the file to the
> delayed_fput_list and calls schedule_delayed_work(). However,
> schedule_delayed_work() is not NMI-safe, as it attempts to acquire spinlocks
> such as the workqueue pool lock and timer_base->lock.
> 
> If the NMI interrupted a context that already held one of these locks, won't
> this result in a hard deadlock?
> 
> Would it be better to defer releasing the struct file using an NMI-safe
> mechanism, similar to how other BPF destructors handle this?
> 
BPF_PROG_TYPE_PERF_EVENT allows the kfunc bpf_put_file which also just
calls fput().

So if calling fput in BPF_PROG_TYPE_PERF_EVENT is safe for
bpf_put_file, why would it be unsafe in a dtor running in the same
context?

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260420203306.3107246-1-utilityemal77@gmail.com?part=1
