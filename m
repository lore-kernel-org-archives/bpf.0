Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D42777F3
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991451; cv=pass; b=HFslX4iQdM3iUyTRdYYOCQm97X+iJlb3TeaM7v+9uVyBthX4zukU7u1qdw+pJrzsddK7KeP/oDRSheUobOygGSGX3U4EzrtqPofsBe4VTtS1fsdHWlKRi735rIbzECV8vozJYKqZTF3VlLaFdb0QfUumYa9eL0PRi3rhQrYRxag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991451; c=relaxed/simple;
	bh=UGBK6pHkR9Fws1o5ffzJGj07ypfppVcq9g4h3f/XeNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn91WY5Z/a+3RfTweQhCdaXmcPCKVGP0NCA3c3LXJ7ox/gZydh1z4Mm/gVozaFSs54ZGpOmoWF8K/33KP1MfUAQrWfk3ZSv5iIhgdqGvPxdroKJEbSQ2CzYUvcu8ImEy+Qf/YLOYa1Q6hdouf73uz7xtR3FMQ/nJBxZbZoq5RBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN+HfDeg; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN+HfDeg"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c2020421077so285753966b.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 21:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785991449; cv=none;
        d=google.com; s=arc-20260327;
        b=ICefv9HA5umWrPTQFXurs06Zx0vMa8FgX36Cp42QYuAp44uJRw0ljo55nIO5EkKloZ
         ragH8fI1k5tPM7PI1IFNHGCLSjcMYFl4ptzUEM71AWJx792eu4ELGdLinLZM+a2r2ATu
         RmwKb/DyGTvAIv1dLn4t+1YLjD8rhNMOLpz2eHcuWkPlAYJ/rNnabQ5ien2nrnK6kElf
         UIthG/ju6IXqJ9HgBQj0+5NGUJijYa+X5CDLHnmkxYV9ha8w01sk8HwX6GLHUbB9tAlS
         /TZBeP9cQYNlkjUpsVYifIGTZlnrBYkiJJyL5fFxX/aTS5CHL4f3wfnx49atk/+qtpom
         krwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzndrXqK7dugyzD+dEx8n3HKXIXDFoLh63SKmFVn2/E=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=IEJHioFljJEe/SzDkXROhpkjquX8IrcPLkTxnYr/JWFkIwJzfAp3i6fbwP4Lq6jyrv
         midWVMTVQKiCxB5gd1uUg1xkJgWTTMUcUjmzybj7CFOi5Sk2jgyWj0rfXeNmUgC0QW/f
         XF0AVFmyfbk+bJim2NAkveAWuz6a6sSmA6L59DzM/l29VY/RY5iLd6gW79buydaJOQ4o
         D6TAtN3tj0b1HVUWCw1uJrpqn3JgJ5KtsDBzhLyjnWc+lMfQXT7zNrlkizIySNzyEAxQ
         YEGzS7fFGbaLWX1bLfZFVOLDxsTfNi2+4oAv7CfI5g7RhbVpl9h+oa1vMlV4bPsb0PC5
         d1mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785991449; x=1786596249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DzndrXqK7dugyzD+dEx8n3HKXIXDFoLh63SKmFVn2/E=;
        b=SN+HfDegByAbNVsd6U+f3pF3uQsCDjTwpw/Eso3xyLywkl3Ju6BiCQpHotKGX2Ntrs
         pi9Vdjg9nC/IoUfDTVOyYEoHvSn+aQ0Mb7Bm6H5RQka7oaSFLgs93iuYHkOhgfRtvbmz
         4aOvbi0NiE7pKv10NFOM9oNbRBwa9EudLV9jjD+Luf6nesw3F9/1apIUYIuz7yz3xll+
         0z6TBYJjBRqXON0vedpuewNiJ2CV0OB9g0QUNlcbF3ruAvvJsqYF28MezP8NZk7J0Y7U
         Feq8Vv99vM0T0rS/LK9PLWd+CPo7KqIyIswMY1IuWjttXNdTBBtTKzbN/TS7MmYkoqgY
         6azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785991449; x=1786596249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DzndrXqK7dugyzD+dEx8n3HKXIXDFoLh63SKmFVn2/E=;
        b=fiSpBjt7axA7XSVy01Y3Xg5WUcmeQrMvkHnfB8En+JYU7pITeTH59z2t/Gl6s9uYp0
         DmzF5EHGtpix/7dj42ulLaNm/NoUOekd+GSRs+eCnWcOk8Bnk+qbxmU6t6tn6TbqzgRG
         Kba9AMJM2++3kiyvAmxm2LAKu4NTIKLuUiSdI0eKpVEgy7xF6epm3LMHteM1pu7e4j1B
         wLx7GlLZbld0DCsGIkDeR1ScFE9AE5l78EZIlz9ZIWbagL1ecpVvpT8EYwhwJ2xv74a1
         6k6QGrITbBLJIstHdwZHjnHMBqG24BFzJSAwR0qH9Y6TsNKh7TjewofXSt0vWMZY3orL
         NEgg==
X-Gm-Message-State: AOJu0YwGyxDpjgY3wsWsk13pKRy89C7CkxYqtZXLT1xVqzs3tFbMGHM9
	cRYb9V8A3h/foh0MNJT+cmYEXTf86lwbxtH7qggqxSYTlzmZs4wlzOVPaMD7iGKze6JdnefxrLo
	q64DblEPVUiWDzoeIWUTBE8kg1gy0uAIM+H5y6mv6fQ==
X-Gm-Gg: AR+sD11hdbZQ9wLMOGOHuYKE38dxSjiEkJVirL9Y3k7j3QxlOXCNBsSkLDekzbd0bFy
	INHBlNKcjxwPVAQ3OCLWLHWFvCEO3IP8ivVb2wcCXYgeuMl/jSURBwFEoQYu0w26f5AoBlyHvhF
	mPEYSfa44Z41o1/onIcBGOnCvi6VUUz1bFxKjKgTYLbqXoCVsbNKYbaOZYm3MBsiwwUT9mfD/hX
	b7LbDYj0+R1aYdpY68J6qQzzHCt0w3dm47uZ7ccieWHHLlMnEyQcCGTG2zySv01I2ggZHQg3gLD
	p7aS/xug/1xaFGf6LmEoleldlXAfzlgwpPOw3BzkfNEb7wjRBa7Dg4ZqE6dzaLroDee4fyrEo5t
	MVg==
X-Received: by 2002:a17:906:100f:20b0:c20:69e0:2ea1 with SMTP id
 a640c23a62f3a-c2069e031f7mr16826666b.30.1785991448446; Wed, 05 Aug 2026
 21:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-3-nickolay.lysenko@gmail.com> <16bd5e96eaa2376e1e235b280141ade8486af206.camel@gmail.com>
In-Reply-To: <16bd5e96eaa2376e1e235b280141ade8486af206.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Wed, 5 Aug 2026 21:43:56 -0700
X-Gm-Features: AUfX_mx93e9JOQ0Bc00PZkxzPPh2j3WculQRzq2p3ZUo1MdRwvNLVH7scEptSPY
Message-ID: <CAMtxOX1Sfi4ispM9suGXKPaRss3bZ_rxAYCfvc+vv-J-d6-dmg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 2/8] selftests/bpf: drop stale and no-op lines
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:28=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:
>
> ...
>
> > @@ -480,11 +479,14 @@ BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$=
(SRCARCH) $(MENDIAN)     \
> >
> >  CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> >
> > -$(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
> > -$(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
> > +$(OUTPUT)/flow_dissector_load: flow_dissector_load.h
> >
> > -$(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
> > -$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
> > +# progs/cgroup_getset_retval_hooks.c includes this top-directory heade=
r,
> > +# which the progs/*.h prerequisite of the BPF object rules does not
> > +# cover.
> > +$(addprefix $(OUTPUT)/,cgroup_getset_retval_hooks.bpf.o \
> > +     $(addsuffix /cgroup_getset_retval_hooks.bpf.o,$(TEST_INST_SUBDIRS=
))): \
> > +     cgroup_getset_retval_hooks.h
>
> Would it be easier to just move cgroup_getset_retval_hooks.h under progs/=
?

Yes, that is simpler, thanks - will do in v6.
