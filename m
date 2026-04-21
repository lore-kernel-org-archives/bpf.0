Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2C372EE0
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800307; cv=none; b=LvUvpb0aAFDhK0qlUiyyWGyz1QAdP+Dw2HRVc7WeFWmgn6KSsbJBHxRk3P8NaRgFeRjzYTl2Hd/D23BHJKZrBlaTB6yLKaFIlT2B4ei/qu2ZECNXjNcBJONMySsuVhrsDpg1HeS4/Hus6t3H2mo0JzSwvUJojlpCtk+fhWh0FcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800307; c=relaxed/simple;
	bh=T31XkmK3RYAHLWgtLcpdoMfs6Ligmd+vlyTVMJlJYnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRxKzJNzsr6Qn5Mrkye3XMbOtfGqLPpQ5ymtGvvEPrWaMSW0ObkpmPWM3kqq9KAhyJlOzMJHq4ALWInLHxIC0UsPgellvYMg/6oSeBVeRHLdMJPXuOVZgpgMVjTWA1RcgZsP4NPg3nbvrHQW3G+WI5GNCpZDygS9Fq2XQIB5Et0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5AHof+7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5AHof+7"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a60975dc5so49539887b3.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776800305; x=1777405105; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2e0TKxjpXGN0t5xUf6j3MFPELJVwvbaTnpZJeQDZ8C8=;
        b=j5AHof+7rgliQIt+IU9fTcfRzwl9Jg2RC3DtSkr5JsIcdIkULgcYp69ntb4/XycrcG
         VUNX9VjN0N5REJ40ez+YOR/8zVxpJKGAl5kyWAOWFT6+TBYNhFy/DTw4cEDlqHSzWP2v
         mH2Kk8KApEklWz4R2//TP0GQlquQ0Ets8APW/K56ukw+Wkv0xNrssBUPAM5xP4XfaYZw
         RZmhhGijUPN27RgTOjvSOa0PN/mZf7fSZcA3v4w0jMOKkEwwLsp+CnxaDixRWCP0SYht
         xr/3R8h/e6p9cUD3/95BN00U/hN1t+yV4fuw5jN1y3K+7ZN3XdG33HKsJaXMFnQXgUxI
         6ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800305; x=1777405105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2e0TKxjpXGN0t5xUf6j3MFPELJVwvbaTnpZJeQDZ8C8=;
        b=q3u7iIUjvSFJurjIesN541ZPsoL23SjpP0cM5dsy44TR1ScVqRF7/pPZ2v+8P3FLZc
         5MmXgOlC0r7JIGdijo1KArcVGbFY1DEEHp5mfqZZs0uU17VGF7r7StmJcoWtvP+HrmWJ
         DFlkPW0ycMrGRnZ/Zi7wGzKTv7AHuamMJxmJRCvG7YyX/VIOA1JxHfbBCnTRKIlyZuEU
         IPbnVMuZe8Btnv58T7yrE2arQor/3CCkAHkupzjlz+2qM/BEPzukTO4LcVFBIu18hOb/
         wclEaYroyGvtKd/OGFvJZyEnWL/7BsUpI1SfjIjmy56Q59VSbA8zhgkmo7dThhnRcNi+
         HYgQ==
X-Gm-Message-State: AOJu0YzKzCIneVLnUIJ89LpV8xLHC8LSt1KdfrNAQ/rEAkSciWRlnQ6T
	wRjXhsba+Kr80twPogC/6D+n2fnpY6Kq+YrYPr1EeMm1WqyD4VEJ43MSX1Cj4A==
X-Gm-Gg: AeBDievmHxsr+9c4iVCIzigaQGbaI0S+jnObW0kEI+Z/FRSyWmI/OFkX/y4jasL9QtU
	MPTNONZ0BB4nvruqP1qm0wP+f4ZtjQ45b12B4B1/9zFur6KwqukkaHNymNugoIeRe5pqKrbaLwo
	WWOtjwRHmqT8g9Jb6HkX9pSpbjOMrqStqsfE3Zlm9P1WIWiU91g3ENYWKZGlkAoLEZ4Q8VhR3D3
	45jrid7B8KE0hkKgMESYP+W1ZHvrkAJDhBBZpx25U+qya1Lr1eAwL5AqHZJK7kqKJnITAW8hy5K
	d1QAr+MDGMpNl/rbHqNP0YdZZFUTUfszvYGMwy0F9mgvHn3innoH3lxKSHabtieJlu0We90CpWj
	dD+avdeoQLQYIF7tCWYvTyJtXMCesNzU7eGCUyChgdzLW2QSFiLwSKSpz2dmQYK/wYSkHe3HD3u
	X9LhuV53I6Y9GDCFRT9I0Z9Jge/AGv+/kR5cgQddoEPkfTKtAhbsFx634gvUIWSm3nQOdT
X-Received: by 2002:a05:690c:c4e9:b0:7ba:f1a2:a470 with SMTP id 00721157ae682-7baf1a2a7a2mr97154747b3.1.1776800305008;
        Tue, 21 Apr 2026 12:38:25 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2ac1:99d4:1cef:9896])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99b964sm59521487b3.23.2026.04.21.12.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:38:24 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:38:23 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement dtor for struct file BTF ID
Message-ID: <aefSL_kZ8GSbpdfH@zenbox>
References: <20260420203306.3107246-2-utilityemal77@gmail.com>
 <20260421010536.17FB1C19425@smtp.kernel.org>
 <aebef2Mz9fLoChwK@zenbox>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebef2Mz9fLoChwK@zenbox>

On Mon, Apr 20, 2026 at 10:18:39PM -0400, Justin Suess wrote:
> On Tue, Apr 21, 2026 at 01:05:35AM +0000, sashiko-bot@kernel.org wrote:
> > Sashiko AI review found 1 potential issue(s):
> > - [High] bpf_file_release_dtor() directly calls fput(), which is unsafe in NMI context and can lead to a system deadlock.
> > --
> > 
> > commit b9990bf55467191e86e004a62cdb84e6dc71b794
> > Author: Justin Suess <utilityemal77@gmail.com>
> > 
> > bpf: Implement dtor for struct file BTF ID
> > 
> > This commit implements a destructor for struct file, allowing it to be stored
> > in a BPF map as a referenced kptr. The destructor calls fput() to release
> > the reference.
> > 
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 2bb60200c2665..ee5ceb82e4f81 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > [ ... ]
> > > @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
> > >  }
> > >  CFI_NOSEAL(bpf_task_release_dtor);
> > >  
> > > +__bpf_kfunc void bpf_file_release_dtor(void *file)
> > > +{
> > > +	fput((struct file *)file);
> > > +}
> > 
> > Is it safe to call fput() here?
> >
> > BPF programs can update or delete map elements from NMI context (for example,
> > in BPF_PROG_TYPE_PERF_EVENT programs), which will synchronously invoke this
> > destructor.
> > 
> > When fput() is called in an interrupt context, it adds the file to the
> > delayed_fput_list and calls schedule_delayed_work(). However,
> > schedule_delayed_work() is not NMI-safe, as it attempts to acquire spinlocks
> > such as the workqueue pool lock and timer_base->lock.
> > 
> > If the NMI interrupted a context that already held one of these locks, won't
> > this result in a hard deadlock?
> > 
> > Would it be better to defer releasing the struct file using an NMI-safe
> > mechanism, similar to how other BPF destructors handle this?
> > 
> BPF_PROG_TYPE_PERF_EVENT allows the kfunc bpf_put_file which also just
> calls fput().
> 
> So if calling fput in BPF_PROG_TYPE_PERF_EVENT is safe for
> bpf_put_file, why would it be unsafe in a dtor running in the same
> context?
>
Disregard.

The AI was partially correct, but my course of investigation revealed a
real bug / reproducible deadlock in upstream.

In addition to my patch having an NMI unsafe dtor, the existing dtors
are also unsafe in NMI handlers.

I was able to make a reliable reproducer that deadlocks the kernel with
the task_struct dtor on upstream (without this patch).

I'll send the full report in a bit.

Justin
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260420203306.3107246-1-utilityemal77@gmail.com?part=1
