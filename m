Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD95B209
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197086; cv=none; b=S2+OUE5dbUUd11Nf7aWLFPLORrdvUU+D+bWZvhZtpDfmANEiVtwTB93/hFGu+FU8pnzsDpSHpNiA9uSuUHXfJTH5eg1b2B3Z27rc8AU6TsvarJqWO1IT7QjdX39CXe5GwS9nIk7SgCFaT7sxWdI9jtuPNO56mWXy1QIAB7VHR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197086; c=relaxed/simple;
	bh=08GB0/4eTTlgVB3a5JApnsvioQrD2hP8fbrZxFvU3ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIA4tJvzul1x6VQZJ+XxrCme/v/W+RjJTdL+YpeF0Ge7iaEcYtDgBpsHNasjPopPz4FAtWJrb7GgrEtKGN1EDEsqyqPpB5YGm3NoDOV7mfvt29c2mhdKdjLSrA6lNnbT3VF1KS2vEQz0PjZZgH4PTZloFFbCpbZJ0EWfBzcXBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQtovySg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQtovySg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4132953e130so12011985e9.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197082; x=1710801882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR2TwJcY4BxdmMnFQfZQdWddRgehusymX0Fv4xNTSsA=;
        b=UQtovySgR0ZMyo/LkbodC/LrOyMjXUNr9xLSgvxfbeLqwCG9QNAbJRe0y7dBWfnXN2
         2r6hVccpKav0NHNsty+zWUS4y+oGq6UOzPbPW9tsNbN1N9Hq3j923gnLtl8LlvxeK5kP
         +7wTSYoVTXUjrtAlK4hOAVj0TA5ZJPTi6W0sM6CWBjgFxBQkKFTbXQSF6sk44TWS09IC
         dgb942Z5zN0CjbkXtq0d5Upnj7NSmunhxIdKONHPK5nHowjnOfVKi/UTU+/K4pVy/eYu
         jxOQLLXd1VfpQE/Ck+A8ekUmV4SMErCbRuF8DlXaCckYtKjN38pcldueT7dG+aKrwBAv
         h02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197082; x=1710801882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR2TwJcY4BxdmMnFQfZQdWddRgehusymX0Fv4xNTSsA=;
        b=qJuzKaxk+J1GSbDOuTFftBIAvfQvj+O38wVKVHloy8/GO0vGfi+XFxvdb5P9dbNjJ7
         xPy8cRW1z0PYjgyJ9wkbux0FHoNLakLJQvzzKSoPLif/r0j0d825lGLjvyWa9Sk9DRca
         OoRtMeoe0eGidoOtBo/EUDbt3b7wZWDH2QhCdnFa3/Omq1yBdP/mMXTxY7hAh3X9Pehq
         g5t+lLTA8k+9kiUQipxAfiJWyPyHEjdmMJhZ928X1wq5V7k4JTHK9ZY0BiaIEV9/f0Ka
         mhWY7lOJFfZBk7kE+hjmMvG70fFUyN1Y5Jus8VoNoQkOYyXNx/sZStvDK4JvZyEE+Hy5
         sWAA==
X-Gm-Message-State: AOJu0YyEJJAuaie2N8JN/8RBTVqEJRGwTg2TOq92PepiLPhQtTkwQ4hY
	wZIT/yxHSYTk9xhdyKHqk4P4+9O41U5xeZseCnh8tYNUqFm2R2TAQHz2avUWTBKbD8QL7y2wIbF
	FEIIKSI/tZsEAOQCOX+QTw+esiAY=
X-Google-Smtp-Source: AGHT+IEP7fIKzFYFMsCLyjd667drldv7jiKoX2qbqYzPhgwtmhy9VZgqM25FnLaTIdw/xo1Bfnir3dxCXrReZRjKeHQ=
X-Received: by 2002:a05:600c:c14:b0:413:2cbe:2398 with SMTP id
 fm20-20020a05600c0c1400b004132cbe2398mr2234983wmb.1.1710197082410; Mon, 11
 Mar 2024 15:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
 <20240308010812.89848-4-alexei.starovoitov@gmail.com> <CAEf4BzYuou1A-3_1Q5qoecLsE42880MYvDCv6shOUVYZKHQb_Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYuou1A-3_1Q5qoecLsE42880MYvDCv6shOUVYZKHQb_Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 15:44:31 -0700
Message-ID: <CAADnVQKsQ=RvS36GwHtK86WkoVv+CvUkfB623GDr3dox7zH6_g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/14] bpf: Add x86-64 JIT support for
 PROBE_MEM32 pseudo instructions.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:06=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> > +       arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->a=
rena);
>
> and I'm guessing here you didn't want that check... I'd probably go
> with explicit pointer checks, but ok, it's fine

It's not only here. I expect all JITs will be calling it
and explicit NULL check will be replicated.
Hence I went with a NULL check inside that helper.
Another reason is:
__weak u64 bpf_arena_get_*()
{ return 0; }
So simple code overall.
