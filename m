Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084428F5
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691915; cv=none; b=F3EgR/QgzRl23CvW4OnAyuZwXUz24BJZVHWgzZfl2q6HJSaGbyCcIyVwrnrdAZHZzG2raKJ2ulteB189ZEvUcHuhbKvIDdaCGsvNLTH2AEA6aF2phz3sfGRj8hZn4qQ8ItI9VsNoqeRVRU9VF7oOh5VUv1zJdoA1IBWj0PsNI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691915; c=relaxed/simple;
	bh=vPkwgFPnqoJlzX2e0yJuH6OmwIycl8QowE9g4ipalIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABWdAaCJ1S6F/6dWmKhM+sPm6Y5Fcfzdh10dmUhZSKKlr+BbNzzrHuQevHFoe4P3SYCvsKzz5coQNwqb0sz7olCzNp/TgkYqOZ14/EoRMH5xKTvkY32w+XZxImg4l74XIMxoeJRO/GQGMo94pqGskPry2xkF6B7dKuqjdzVILmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPle4zdo; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPle4zdo"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6906a7870f3so13315166d6.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 18:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709691912; x=1710296712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B18+fvD7I5lwIMvlxhNlkjjBsTwIg8yDj6F0MGuNpXA=;
        b=XPle4zdoqA9TXPuR/tvSdI5ir8vFFK+rJCyV82SCRAQW+juA/6h2nrSN7oFfrOSEuf
         xFCJm+JhoQBo+NozvkIKIkG9cBT1rBYExvhDzZI8pNafTOPIS60SMOVu/Yqjac5suTpu
         mCozAbJ3ssgW/YuBBklbvb2rAyx546RwF8QNbfAu7MG0QsLMRKs9rrW4lVBxrqJnQ74g
         4EuD1bWR+ED0S7VbFAYU3iNPQEs9j8mnsQ/ZIQaNvpQRoIKDyp7BHKovj76YsjqPChvK
         Wdr9K4dXr+g+pXFkaBhIHc7LMZKBDtLtnLVvyeHyA276lLj5IcBSkPsIfr2I/WdtKhO7
         L+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709691912; x=1710296712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B18+fvD7I5lwIMvlxhNlkjjBsTwIg8yDj6F0MGuNpXA=;
        b=CpFOsdMj/Rkp2wQvaDqdq4zCFQlkccyCXm9a9/rAF4/L5v6hlFjCgt+N78hcWGMBkg
         yoLg8jJYlxDniV2ekRO4QejCihXLaXf3lVipGfXbMsUhdt7hEr4OiZFNwllfvULwkbYt
         HXEATYcvFfiNsq5WKVgZslGdpK5dOGGYJxsR9Odqs0Z0PtuEkT290B3x5y2HQcOLRmgp
         cEMW05192hRRD/enkbSaWPZlyuismY36ZIiByx0fOKa9Dn9eNpGPPBwQrN2yWlDI2rmV
         pdPB3ZpogMr94RmQ9aKn+mmuCKxOsxnEH1y1uRzxjfHKblRPC5Ao1WB7ZW2g1QjKYHYr
         AVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1SKpTcNlnjGtHmicNMI2BpD8R1Uj2xCIl4St+Zs04lb9L83KhkKG2/B7UtyZC/Ub7UbOQLZJ5O64CS3GHcY//UM/
X-Gm-Message-State: AOJu0YwM+563DBtgQR0kku8MdxZaBGFYaJe+EvWk+HxS40B6fkyRntxe
	3jUBkMasAvZ23VUMH80XvI/v5POX6Ri/XH4jnNbFlScJfBMvGvVgBHsd1CCEW2S/np4AnEBtq2Q
	/QxiJTao7TeRjB/Qq2khOE6UPvfk=
X-Google-Smtp-Source: AGHT+IHjr0WR5MBvrj2vQBakubGWIb7M7YcC5EDQ3e1rMyarxwMNyw0nq65h5dVcz138hXYM5lSpGoVbWfsb0awhqlU=
X-Received: by 2002:a0c:f012:0:b0:690:4d5e:f8e7 with SMTP id
 z18-20020a0cf012000000b006904d5ef8e7mr4444408qvk.62.1709691912525; Tue, 05
 Mar 2024 18:25:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305064353.69734-1-laoar.shao@gmail.com> <20240305064353.69734-2-laoar.shao@gmail.com>
 <CAEf4BzYnMrpT2B2OdkijmR8AUhRXhNoKHM9=Q1GmRdp3FxnUEg@mail.gmail.com>
In-Reply-To: <CAEf4BzYnMrpT2B2OdkijmR8AUhRXhNoKHM9=Q1GmRdp3FxnUEg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 6 Mar 2024 10:24:36 +0800
Message-ID: <CALOAHbDPgBgNAYQOoMH=fn9Mk57WmwMKYPJTTqjwiU4kF6OLTA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:05=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 4, 2024 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add selftests for the newly added bits iter.
> > - bits_iter_success
> >   - percpu data extracted from the percpu struct should be expected
> >   - RCU lock is not required
> >   - It is fine without calling bpf_iter_cpumask_next()
> >   - It can work as expected when invalid arguments are passed
> >
> > - bits_iter_failure
> >   - bpf_iter_bits_destroy() is required after calling
> >     bpf_iter_bits_new()
> >   - bpf_iter_bits_destroy() can only destroy an initialized iter
> >   - bpf_iter_bits_next() must use an initialized iter
> >
> > This test case can't work correctly on s390x for unknonw reason, thus i=
t
> > is added to DENYLIST.s390x.
>
> That's an unusual way of handling "doesn't work for unknown reason" :)
> This might be an endianness issue I pointed out in patch #1.
>
> pw-bot: cr

Thanks for your reminder.
will check it.


--=20
Regards
Yafang
