Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B633C1B4
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018284; cv=pass; b=r9DTGHTD9chGGq8goyUE3loidnxjuwKTzJyrVX1TXINtcMn9Hx32FrGYGImVbFzxZ76XK0zW3fgCGf1bhYrlSCFDs/BeNW5yQUmbGuVt21dSQtvFuOUFbcZeQdAZQthyE/BFJT3rYNdqgidwTaUIKLaUkxeGYvKqkX1lqldWmAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018284; c=relaxed/simple;
	bh=bVBv5qGTZX1JZrmKbht+XHZLieimkBF3AOTYIgjgkp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTV/wf/JV90iYao6iPCq2tmaKCtKL4E0DmMErILLLUKoBRdiT2j62QiiL9P1RXDKsf/4V5iT5zarp4qY32pOaefV9+9DliV/PM3Wq84Zokg1ARFC6yDBQAfFAPM/2JD447Ry9D6dyiIU4a3AZqENHlxZhzTml/m7S+PYFACpHB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJbucJFe; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJbucJFe"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-501511aa012so13451cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:58:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769018280; cv=none;
        d=google.com; s=arc-20240605;
        b=iv4t6tLq+XkwUuAN1KgtdHZnpk2UdGoJqJByurX+C+TMybUBQuvHG1otgjWi4JtD1p
         Sb3k4Jdl7k6FspUBAR4kQnDTECx5RngQn1gM6OlOhbr2u2uD8ttl70uaDID0HgJxgIjN
         +9tslv4n16mUIPdpEMdqmsWxPlI2TSZy8BaiU8EboToo7sXZviNphHwKOvNalcdKhYGQ
         /Cv5PdkK7Iax1MKEnRblnXPpZD8ZQjCZFFcvDP4GV6Si8fUSeAQEdYRX2X1M4lOU7193
         jFk2Bkn5Pr/wX0GYc9vpGD0xAIQE+9m96amWOGX04Mou2KJs0JPZ4PwbKsAstGsmcpjt
         DDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2e/dfKIPzPxfuYZfQWM3FRBJx3bq+IVKEQQ8IC7MPec=;
        fh=GS6CBK0qYxMK9m2t0t9hDIOV8EaTbvjC/g2+0/BNGXw=;
        b=OI4Q/uqT72y/ONw84ucxB74Qc4qov7/EW+Gf5Fl+5PdTo0vXG4EcMwgGgb7pGT+H1A
         t24zxIPkFtSm1cIKRx0jnBpi1IgU8Y1rapIYgzeoTqwiDH3ddefYKdFVCVHVxgYugVyh
         vVFyT1iXSXdHagYWh23vLVSw74hv/wDr/P19fINe3Y0wwiwPL5shL4Umf8a9h2b13bMT
         dwaH0r5lVa2mJL81racVkUDDy0QFyVEwaK8+ucdA7ARYsBZoTJBWakuljRuxK0+bl5CD
         IDSde2KjZJnKdneDVi5Cxn7P59H09CRgnw07vKjJQw0bxqiy276YZI05w0vp3RtdUxgH
         I+uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769018280; x=1769623080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e/dfKIPzPxfuYZfQWM3FRBJx3bq+IVKEQQ8IC7MPec=;
        b=BJbucJFetb43AeAAmxe4PVktv6QWxzXyQ7sm9+dk1BL11xhZwjRt183IHX34SXzZJu
         sYAl6WsioPaWjbD8Br+6WuzrpZyg8yUmJVBJ9/fjXx9gTHtGwwUeg70nzjbfg/Q0w5Dn
         NVObOBS4d5yap1fQCscDsiiduRt1/6uFUyxSip+75NXKdDpQAFIAzm7AIECtRBmd4fNV
         KmIVSwkfOUzzauHSJEHqorkUIBr8V5VvrQgDTjBsMqKgacg+Fuc1IAqAlxvRR2t1Nvy/
         V7ztfr0OrZuLqwXGuwgzgDBV9XmwEwDHrM5vL1J56jFwsYk7IIDcT4ldxPQjQOZMlX+j
         ty9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018280; x=1769623080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2e/dfKIPzPxfuYZfQWM3FRBJx3bq+IVKEQQ8IC7MPec=;
        b=ddC/Cif5qTBM8UYX6bN/WEBVo9FyRhpDrUyWzNS1n9Unbp8kGyytznebMNW8sj0CWW
         R/Q5GDvZ+5C18d4P4kowc0gRMsPDItpA0XZGcLUxl4yzXFhx8jypEQA65PL0oUcd4Ci/
         +JV+oj42IfWPWpmrGPSlc1yWUver/oDDtkq2J7XwglB0/ZfqMOfZ1ve7jBsbjbM8Fw1T
         E7vJ320O8QGpKeaJstEGDx4rrIXAbtIrq7F63iP81bN+vbzGc+/+hPJhFgjU7u9xstsm
         RrgPcgY1/Of78eE289w4KeyrMeEpmLAIaEIOoYl510Yn2/ucjJQdxZK9OEY5xmfX/WCv
         dM/w==
X-Forwarded-Encrypted: i=1; AJvYcCUfkB3VQLWSFif7XWyDqz9D50iZLjrpAPOG8JQ/U0+afno3eW8cQnEitisS26Ounrkfc8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxB47XrC7q3vJrWpBXq6Y3ZInnIFdM5Z5aVdtKYizDGQaExAZt
	4v03Z2nSH+6D8fzqmtEAYm3lh2jkC6ZuGIGRttxq6ZKEp4z8KdWP161C3HD8J0auLHxdOoJOUEh
	yBzk8qAdg8hcvdIX6/WSMP5v6pkuxP1IbZNZW3Z/h
X-Gm-Gg: AZuq6aJmDHCFAwyJVeMiEQ+OX9hK+p7S6gC3QBmfWffURdA6KAfkB/5z9RxbsL5hVki
	i70kq59CiXlvnHjP13ib7IRIKnLxgWRCwwvBGP6L5XUg6Z4/hoHp+M2B15gRiOOtMqTudGfZ9Bj
	QXpn0SoYJNno2b4l+el8WUuJ8FuGIRkXraolmhnPXo6lhyz/spNvBOIcxNIJ7RMwTix7+b3qFgs
	imzaX2BVrG2wBvAHKHk64SEQJ+Q86snIn/nDbFTGwhztVvXkpEITltEf2A2Gh8lpndZ1r2XuWeu
	wIT04BEaoe3zRkgWRUGDT54=
X-Received: by 2002:ac8:7e8c:0:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-502e0c62ce0mr15215251cf.14.1769018279867; Wed, 21 Jan 2026
 09:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-16-5595cb000772@suse.cz> <v6govsosryla4nzgzbfo3eeiziabn2tdprzhg3zcpoxkxq622f@2ra34j7326mn>
In-Reply-To: <v6govsosryla4nzgzbfo3eeiziabn2tdprzhg3zcpoxkxq622f@2ra34j7326mn>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 17:57:48 +0000
X-Gm-Features: AZwV_Qj7XuXMulWBwzFRyGRxqGQl3pWQ5GGLctP7N8bmgHrWL6WoILa1XS1waUQ
Message-ID: <CAJuCfpEPX-jjztYVRNX-MzQYdcf9fBrePf0zbhDJFKaEvpcp2w@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] slab: remove unused PREEMPT_RT specific macros
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 6:43=E2=80=AFAM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:36PM +0100, Vlastimil Babka wrote:
> > The macros slub_get_cpu_ptr()/slub_put_cpu_ptr() are now unused, remove
> > them. USE_LOCKLESS_FAST_PATH() has lost its true meaning with the code
> > being removed. The only remaining usage is in fact testing whether we
> > can assert irqs disabled, because spin_lock_irqsave() only does that on
> > !RT. Test for CONFIG_PREEMPT_RT instead.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 24 +-----------------------
> >  1 file changed, 1 insertion(+), 23 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
>
