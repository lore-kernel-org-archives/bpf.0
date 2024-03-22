Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D24481A5
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119630; cv=none; b=LVCvxBeeXX1exX5Tp43sBO5xZau7M6D1IWOI7oyV7ee+WjrY3G7NsAbXozrGRhmcyLOLtD9tb3Nnk7USs4txc0YUHZNneq+PTd+JWE8WEE7wd/lNPi/0sOT9N/fY8gIZZC7ofAsfEyW3tDcye0BOzs03EFL1PJ6J5QNZcPlh2Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119630; c=relaxed/simple;
	bh=qXdtNxvPpsbpNODgvKjpT5XrGKp9Pc9HMJY7AIX1h3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4bVhc3iHeb4oft6xGk+R+Vib5ugvZJt2dIctNrmHrnemkGEmb2OXa0bFfb2/LazkfjF7yvL/3WnZzB+BtG33eAPvRltEevUVfufZxcVaHa281GPvt71kNZnVdQOWmfZ0QLaylvli6sLeVC0yhcubLYqUkesxdiUyUvhmPutJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEoVVAJb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEoVVAJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711119628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ot97iwVakR2lkEIdq7JcwHUhieIrzYpSO8j17uVWGlI=;
	b=KEoVVAJbe3uloCRgO6WKszqfyRRwrILRmHy5t0/7apQ1T97xLgn9v4Kw1/eu0MXilJQNzd
	lP2HXWQ2gZZ60z/xwkDv2dm3cWnJI79o3AkpYuWwujbe7GRU8bS9jxQoGR9CWO+H/o8/rl
	KzZ+VpFONk/v+mCiEEwI8J7qDdcb6O4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-i8gf5cOQM9CrD4CcjYMaGQ-1; Fri, 22 Mar 2024 11:00:26 -0400
X-MC-Unique: i8gf5cOQM9CrD4CcjYMaGQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d4a8dc0e79so24003351fa.1
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 08:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119624; x=1711724424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot97iwVakR2lkEIdq7JcwHUhieIrzYpSO8j17uVWGlI=;
        b=DkiBvBkOvrZKc9QBfkHYU7F3Jz39DD+FgXhkYUYRTcL3IScNBCA7ldCaemv5bcCiEn
         /Du2BIHb/Je9GyHrxyl98ckkFepyK5dgvW7GOkCHWcjR//rTllDLBDHiQKxFgnW0uHl6
         VmC/Ofl809Hol1n4Vv8yasotE2qskZE3F5e5ylLOxs0w9DW/yXhS+9jN3D0e8yU/I3s/
         VhmytMJ/3aRlk8Ymhd/8mmaIUjlEkjMQW3+ALxFKsiBr0fqW+opOkMMH2RW4/d0ee2gD
         rc+ZhJcOoH+AxE/NXXZDygpZMOHocFIpVA7/IjJm02o3F0nHf3uxwD4dHMgN4F4217wX
         N9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUifbpEARn9o+sVPY7wHMk5I6W0wrTYX0T1f2p1ifKmUotVlIZ+QZhsdDmRIyMr5DTzBB4lIeKZrNGndeg5U7Uk0eQK
X-Gm-Message-State: AOJu0YwGOdHlir6VtgrSACIHLDUZZdU27P5u9OhF2nDtSNvnH/zqrD0l
	0u4IiytI2YeDCRhFvsLXPAdsP4wNlUzanrKfbXJAeSW0Yc9yTZOVwn8Ole4PobG4A9r0YZ66hOW
	vJN/jS65PMvNyxz7FPwUL704ad1VuJKh0TUk/MLsTK314DeyMhOgu8CxeAOTgzG00WVybOGQB72
	Fl8GY7MtaVf6Kx2/YXS5vvpTL+
X-Received: by 2002:a05:6512:612:b0:515:9ae2:93b0 with SMTP id b18-20020a056512061200b005159ae293b0mr1451123lfe.19.1711119624756;
        Fri, 22 Mar 2024 08:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoRqFuVFSCcYFtb/4CXLayeI15qnsRqHHZP3UDWQYikqtlTHVTRgMB97SI5tl1UUWqtCQprd6t9b/Lw0uFLEw=
X-Received: by 2002:a05:6512:612:b0:515:9ae2:93b0 with SMTP id
 b18-20020a056512061200b005159ae293b0mr1451109lfe.19.1711119624396; Fri, 22
 Mar 2024 08:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
 <20240315-b4-hid-bpf-new-funcs-v4-2-079c282469d3@kernel.org> <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
In-Reply-To: <1c1ea8cc-22ba-40c4-a26a-5339c3050678@infradead.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 22 Mar 2024 16:00:12 +0100
Message-ID: <CAO-hwJLgx=vndgMRW=f-Gy_36CJLqwAzOoELbckvBn8NvCJB6g@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] HID: bpf: export hid_hw_output_report as a BPF kfunc
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 5:06=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 3/15/24 07:44, Benjamin Tissoires wrote:
> > +/**
> > + * hid_bpf_hw_output_report - Send an output report to a HID device
> > + *
> > + * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_=
context()
> > + * @buf: a %PTR_TO_MEM buffer
> > + * @buf__sz: the size of the data to transfer
> > + *
> > + * @returns the number of bytes transferred on success, a negative err=
or code otherwise.
> > + */
>
> Minimum change:
>
>       @returns:
>
> Preferred change:
>
>       Returns:
>
> "@returns" is not documented.

Thanks for the doc review (and in 5/7).

FWIW, I'm still waiting for other reviews if any, and if there are
none, I'll just amend the commit before pushing.

Cheers,
Benjamin

>
>
> Thanks.
> --
> #Randy
>

