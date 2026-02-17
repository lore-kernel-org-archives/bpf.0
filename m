Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464371F0991
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356783; cv=pass; b=trQtDLliN0asRLU3btCCpCoae2B5bS8jBt4cv6puHNNGUKExtK+eJmlbBF2jzmDUhmgtZhJN7JMBYoeebBZEJ8lyJ1ugspE9OI0mo5pln7LPoszexQQsGDJxwu33sPClPaHSmOf5uGjt2g806LFHQd3nhA76oc+WA7ccQEWnI78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356783; c=relaxed/simple;
	bh=zwIDiRqmXir6C0mvykl3/uMjWyEox7piKGIk61fk1SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHRIY3XF4t28A2lRjGkr5zCTWLVHOx/b/otHamQ/wUp8lJsOMaqXbBx3gugsNZw6wiPA/jFVS1zp6OosOHqn6+yvuWPPVBZjXUYXHuNjtf03ZKh24vVkwpMWPKlAmhmffH+RtZq2luHAyK9+Q9Kd8oXSWVeYZ6vSix+K8/kWAaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKQKuKxO; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKQKuKxO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436356740e6so5431318f8f.2
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:33:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356781; cv=none;
        d=google.com; s=arc-20240605;
        b=bCUzL7hyUzw6k6tcfp8/IfNnqK199d4AwUy7Ul47OrU78P0wdu6L+O8mNb633Cqtby
         CpX4Tuqxk4L0vgrZCwqMAWywMM2wlQWiHfCXZ0Otj3QWoDcuYDMZXAxwxEFBZI1mr7Ch
         rE5D8JpSAVwhqLw1ho1Lfuf9uZOjy/l6rGBjc86CX/Y7sVNdcMUZCYs8ZN9ZbjYJzazv
         uoXuzYQuI+DWk4tZJUewXBjzt6OwshvrfGqDmwyd9QeXzT9pIundOb4LK0qmzuRvpuOl
         Up/eedv18kJEdUhrAU2lJzsiM6vyRVJyq7cVO0fUZ68qTpts7vEae/Fu1/oTnTeJ2Tpw
         zy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zwIDiRqmXir6C0mvykl3/uMjWyEox7piKGIk61fk1SU=;
        fh=/oUrUe+7GYLJeruo+pZaK6BobPhdLtW0pP23Eb9z4ZE=;
        b=k4eBHd5MdxE0bW4ReNqQ0r1QrVbVKgR+QrROe3pjUDw60SLNDLzUEWDqnvaH6FJSZu
         uvnxWWzT4++YS5EtbxK55ubCMr08yVyREAF4oo3Bj+rKkD1X7xgYesrhYHqZ6iX91wib
         m+xEHUN5t2DzvjtjpqrTLuQ35pMHb3PIuVPqDnBy/wtMw1EPhw+YY9zwWpqR2lVe23iN
         do8KkyMp1k1B1RghWe6PnUWm7598bQl6NdYo0YweKDK3oafPUdCsos9tZwfO7Bi6DiRo
         hU7wsLj8GP7jOm7laEG3+gj+CSAky9WHi6yE+BFCqOMZI8V+b6nM+FHYHvygeimA3GQ8
         CZhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771356781; x=1771961581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwIDiRqmXir6C0mvykl3/uMjWyEox7piKGIk61fk1SU=;
        b=ZKQKuKxOh9tNRhyIy8P9PiIbnN+6T36mvQYYDjqF8qyYzhUaFrMAjC3mHJntkXJXJf
         PURqxVluyGDG3pHVC3UvMasBVFDH82UinGFad9BQNlG5xSbDWR7wvxsMucSv5I5jj3Is
         d4ZsU6dZMbrvPfSc9majxByA5y3YK/ImX7sF0V9LnANtqLcYc+GeUIGK4yU2b3olAmnb
         bCiuF4oVdF9AclVjdO/FdArmLfm8hpkj/hXHv5DEevIYxM33YZ17xblmjxRw5sG6v1VV
         /OId5EM0IkbODjRs13ILgsxHKRRbmOtj6+bd+6H88N/TCCdOr61F3Ab536cjBwWJIuY1
         x0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356781; x=1771961581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zwIDiRqmXir6C0mvykl3/uMjWyEox7piKGIk61fk1SU=;
        b=KZjx6YfBcM55xcQmJzStbpWw68h+mfEbBY0wn7A8Pa8Gr9BiniXlnM02dAT6ZRrGtL
         5wku5NqyCQKk9hLjlWehFrIGwruAgdTJm0e4DITWt6ExINv44p9tt9zIWujrMLXuMMSZ
         6Ut9Wc9rYjqPHi6OuosYdwl41ONfDOpr4Yt26GSKUkGLYbrdxg4I7nFtWIia0f4yI5AL
         8XmdHBoQXIPMeWngDIjUTNyKf4mP+YI61HsgKZgEABWv+MrcQGURZe4UUrpnXQ2y7PaT
         yIpUorWBWEA9rTbnrkaF/CevhAbxn1p5VIsWxHwBUx2FNy0lnbQO3CUqJJcxlc2tK9Ge
         vbSg==
X-Forwarded-Encrypted: i=1; AJvYcCUTJzSZWlkAdwwecT7Zjgfl5eANA0y3A+RbIuav0zFMc1TtBcP4MFq8HUuDR0HWaNa+S04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3ZMs6fIDYTl2cVuQ4gg4ybuxNTihL91rbRvsk3iBPjiTBFd9
	6T4XEuO7ZY0XxlbMvHpFEQHC2hCBviMwCk7FUC6UYdeQB3F4xKCp7pGMXRIT4APXw9dEJyUh0yJ
	rfuCaCPKXYN/Py5MdiDLKwaSGMz6+eU5deSZD
X-Gm-Gg: AZuq6aLM7G44AgsqvCgsYOzLBfEyq9a0i1AZVB7pu7mNR0UByBtEhCGtegKG9iHRTMK
	CFT8UBhyXBg7JRD6ju6/LaR+47jbQJPGxMUASNvl00xxOg1Katrczkn4AYJmcHSPDXpobeWMxRr
	dsHDUbIMp4KUT57G+24iZnWSfHYtIzSIHRIVb9HDW7xc/Nh3GMokV6FkyMGkoWBDLCM/dXwZ+WX
	333KQjB2qIxMYCFNvdS7fOD0MM3KFVwC/Cdj8GsfHvAkXSLAQQ5SJAQk/JmHafNKDiIjH/7/EOg
	6YbEtF3czAVmDRh/HREZ0WTDXFipm0aFLOd/HRX+0U3ix6NB5RMzv4y8TMOiTK3e2CW5fhCl98l
	YY+uS
X-Received: by 2002:a05:6000:26cf:b0:437:678b:83ca with SMTP id
 ffacd0b85a97d-4379dba36bamr20063457f8f.50.1771356780235; Tue, 17 Feb 2026
 11:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217160813.100855-1-iii@linux.ibm.com> <your-ad-here.call-01771350933-ext-9929@work.hours>
In-Reply-To: <your-ad-here.call-01771350933-ext-9929@work.hours>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Feb 2026 11:32:49 -0800
X-Gm-Features: AaiRm52gxEWwTHXEnlzGlYCyHVwzpRejpcXb_vmVXUZpdHvSeJSGJjqWrYBO5sk
Message-ID: <CAADnVQ+TB09AU3VTmjZ97xNFPG=3eOpoHut-dsnPSsJRLPPStg@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf/s390: Implement get_preempt_count()
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 9:55=E2=80=AFAM Vasily Gorbik <gor@linux.ibm.com> w=
rote:
>
> On Tue, Feb 17, 2026 at 05:05:07PM +0100, Ilya Leoshkevich wrote:
> > Hi,
> >
> > This series adds get_preempt_count() BPF implementation for s390.
> > On s390 preempt_count lives in lowcore: a per-cpu data structure
> > mapped at virtual address 0 or 0x70000 depending on the kernel
> > command line.
> >
> > Patch 1 adds a kfunc to obtain lowcore address.
> > Patch 2 is the implementation that delegates to it.
>
> Hi Ilya,
>
> do we really want to expose bpf_get_lowcore() (full lowcore) to BPF just
> to implement get_preempt_count()?

I think there are no other options. For this and other cases.
Like to inline bpf_get_smp_processor_id(), current_task, etc.

arch/s390/kernel/bpf.c is a good place for such arch specific kfunc.

I cannot really tell by looking at the implementation of get_lowcore(),
but can this kfunc be marked as KF_FASTCALL to further improve performance?
