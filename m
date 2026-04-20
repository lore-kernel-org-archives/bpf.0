Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2822541C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700013; cv=none; b=CVZtTCT8EUsFgQpD4GVeHlRYjxXCUISBZRMcL5qio4Q9ukf9aRnQAfkvv00aEJ0+b0JvMdxCJnQV312gbNcboxnRsgMqwRyiIRKRDcNna5cy6GYrvuZaWwcu0UKmoHQn3VPQ1V9RapScxkdC4dS6BsDoPvcg5EJYU7ZaaQy8Xzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700013; c=relaxed/simple;
	bh=hqOLsJxXBWZHEazuHyU2+GRfDrdpRWZZEjbMUveb1fU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=BJPt2H4GBY72mZ5FlQUl7L4mMOu5gpl8+xKRUIQBmBVtP71CltB9x2X1vF9S0HegaOZLCnteUf6OjQBJGse8fwF/r8OEdANtq1Hmi8B6W7JflM3e1Ye/q7fI3vQzSLhnFCgiDacm3n19WzhMSMS8hbFGDQF91AYV7tX/nGSq3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZDzA1nM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZDzA1nM"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd17e19b6so219810a34.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776700011; x=1777304811; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqOLsJxXBWZHEazuHyU2+GRfDrdpRWZZEjbMUveb1fU=;
        b=CZDzA1nMYcBXDI5O04ABJu9vjDMPpVygESROI5p65W3DJDhmUHHmfLfHBmlgGKDaec
         wC5iKDFopGy5rb2zwhiEWgf3apCUSE9B2gM0C6FlJ5f6wLep39YM9GPFcP0VAlBTFmNk
         AKKy7+LfnBfq/y2M8wELUzHBLzD5pWPaDScCPRFyETmXcB9rndkPPA1ZPVQp2/0cqQ7I
         j3LH19orYtj6ZcKGRYpwMPp9p7tj0CpOw36DVwrvIZd7BZWHD9j6g3XIangcG8PGbpi1
         8I+ZpyIFkpyfTMnw3U6WoOWwD0pqOh+A9gUuhV+9+cPQzMd6q52iIwtB7HKIoXh1KFcz
         GwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700011; x=1777304811;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqOLsJxXBWZHEazuHyU2+GRfDrdpRWZZEjbMUveb1fU=;
        b=oUQDqgCrceS7Afh9zVOb4iE/cOnCP0mz9JCPITK21GrFP0+cABpEEcNXM315AfPh72
         uTngezKslontJNTAXxfyzgoIGuEB6lmZ0HkHMOcAXabC1WgIaqPfGWxehfQUHRakbp7o
         /5bbGocKLCsO/kkYdQ34kt4TiU07CZNBz01EoljT5bZ/FMFlftKe2QAJVVpNEka4s6Z5
         Air0wT1cVGxDoSyjLyztmDblAi5MJ+0tzhlpGkIA4Kc2K1hoYEtv9LHJLTJ0fX0tkXD/
         sCl/3KwDofttzRKVKBAYAsWEGv/Q4lILY6nVotnyx9NAN84cudWoHUkZbi+ZBoMGkWNd
         eIUA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZE4ttNVmC0sQkfvTSNFGQsi6LEg9jUfw2z6NUb7Tflz+I/h44IoxuO/nzaPyAuvt79XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWLpoKCGKZi01cpDCVoSJt/khiznk/WoUABCqWXUgVJRwheMeF
	NFeJMAY+q70OhaOBycA6EG8XDAXi81vo7pOu8glHIPQIi7ftGmMGwwkO
X-Gm-Gg: AeBDieseu1zyOTmOHn57VHEwlRGRfv3yMoummNxbtYHfNnQ2dlZLdmX0qRJeRv5GJEA
	DagauaPVJ0G6S5kLd4AmqQXo+g6xfoFFnIEa41zT/XFN4fTF5fUOseuDgVMuSgLd2xPGhYAuNNn
	AVUAeiEDOUeCsnV3AS+rfhbsGRmPh+Shq5dDIoIHFrKIgHsdY01WvQ8GjhwXyD+o+7T0WXhyjM+
	JkFfag/mXtFr9qg4mp44CYYEacDKNVWWr7tsusqp3cj1BEzz4bsAzsJ/GK8FbMng9/w3VlA4PUu
	9zww22xr8t7TBrRijTJPuAvWjAKy/UqGv6/7fgk2PLfxXwDnWrCTmqyRF0uJQLesEM0szqhcQsD
	xAjZjCElPHdQMJk2L46RcqY2tbTeIbolcAx1Dfaz/7mbT4767zQqlcMU7+bOK3It7WpR8B6fu5A
	pUyDfb6wVo/usbYhitSNk1/RG0WqlLyD34/S8zZuy3w7z9DsYbUiB3GYzNs+Po4SWdFGIk3uS/d
	j8tT7FEJXd4lGOtKQvKqubeBuD4
X-Received: by 2002:a05:6820:6ad0:b0:67e:4140:768c with SMTP id 006d021491bc7-69462e216c5mr7610520eaf.2.1776700011165;
        Mon, 20 Apr 2026 08:46:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464ea14ddsm6480142eaf.6.2026.04.20.08.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 08:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Apr 2026 08:46:49 -0700
Message-Id: <DHY3L8BVS4E4.2GLGKFH7NORVW@gmail.com>
Subject: Re: [PATCH bpf-next v10 2/6] bpf: Add
 bpf_prog_run_array_sleepable()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin Lau" <kafai@meta.com>, "Kernel Team" <kernel-team@meta.com>,
 "Eduard" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Steven Rostedt"
 <rostedt@goodmis.org>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
X-Mailer: aerc
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
 <20260415-sleepable_tracepoints-v10-2-161f40b33dd7@meta.com>
 <DHU7408DLITK.2DC76VINL2F7K@gmail.com>
 <CAADnVQ+6udrUD-xW96ZJkz3UkEq8JZAdFiMgB=f5jfFaYVjJ5g@mail.gmail.com>
 <337f2570-acb2-4b31-8c4f-86ba4cbdfe65@gmail.com>
In-Reply-To: <337f2570-acb2-4b31-8c4f-86ba4cbdfe65@gmail.com>

On Fri Apr 17, 2026 at 10:22 AM PDT, Mykyta Yatsenko wrote:
>
>
> On 4/16/26 3:40 PM, Alexei Starovoitov wrote:
>> On Wed, Apr 15, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> One more thing..
>> Please go back to my 'do your homework' request from v9
>> and answer the question why it's not safe to do bpf_prog_run
>> on dummy prog like this patch does.
>> I missed it yesterday and only complained about the waste of cpu cycles.
>> It's more than that.
>>=20
>> Do not send v11.
>
> I see that very similar bug was fixed in 7dc211c1159d ("bpf: Fix invalid=
=20
> prog->stats access when update_effective_progs fails"), the problem is=20
> the same - NULL field access on the dummy prog. So the approach to just=
=20
> allow dummy to run further is fragile, because other NULL fields may be=
=20
> accessed.

exactly. so far we've hit 'active =3D=3D NULL' and 'stats =3D=3D NULL',
and 'stats =3D=3D NULL' had to be workaround-ed like that in that commit.
There is also 'aux'. I hope it's not used at run-time, but let's not take c=
hances.
Filter dummy prog as immediate skip.
