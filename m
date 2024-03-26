Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4A3DAC02
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450681; cv=none; b=uH/1vNm8MDKrGWmB8BY9l/u4iPwYs3jL2BTB8DC1cs636fz2dcCzOX7Wj2q8bAHYfSEP71xjDsrrxQLJBD8KKWhx0J4kt/v3pkxFJbfJuVKeNn3iIILW8pZelzmIAXCG1Vur3TgfncntgRESkEIJgxls7DUyDyWyJWWntgJLOqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450681; c=relaxed/simple;
	bh=2ivGfYRpdQgZemw9rb77JkAkZ409pzS2I4XDWey5FSY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czUuK5RnmTADoqHMOeZ0wx1wExWO8lZQLh3WY9Knptj1TZgL3N7Rn3d04UKEC2FvI3pSu2RPEjlfYN9SbeOgI6vkoMU6y2OeIAKgCaWxsW8LDtcn0Rf6efPiPwGoBoeQvGpy32hoJO+7aB+a5cbrMBIJpYTPOVsL0SMZ8GFO+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHKN/3BZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHKN/3BZ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso653689566b.3
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711450678; x=1712055478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLYTZcXLMERi71fcEURWW+TL0AycLOFwuLq8X7zfoAE=;
        b=YHKN/3BZ9rlpsUSmCbxrsDMr/ZsurnhGpiTp6fGrGzy/cNsokRWa6m5OU1HTvD8EcT
         3vPu8LWxoRDKd8PGDxlt+Z/Asxqq3Ju8K2RyXkvtJYO/tNpzwEGALS7U2et9QFPP434Y
         1xR6JyNYbklGzJRVBEuqSk0RQSGUOEF6UNE6/t3DYqUZeZRNPMvGGBCnb7RWGoqXBRp0
         4PGR3qG6dRxkQd+ifpNDnKRdZt/Z25YvnRBc/9zscpLtsCEbMic0iOjbvH22Ij/LLRiO
         FaGXGqilln4KtWpRpqDAhhI2WOkuk9RPmwxvcO+dxOBii6XdvjwbB28ujHH9pNRYZqVH
         dj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450678; x=1712055478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLYTZcXLMERi71fcEURWW+TL0AycLOFwuLq8X7zfoAE=;
        b=vdWQihWzSDYyZJvIY66eJ96LZcWS2Ml0PswgHu5nkSZJRO+Yd3BjkXuGDg8IBvJ8vv
         KWtO6hwr2EYG3s5Ky5hfvxRwiwUuQrjNuNZSRw4jf3eLrJGl4Tg/qBL6BVzXTvfHpiXj
         JFKqb6IdczdiTUSLD5Up5B1djVIWfSDMHTZIG0uzZdvdkwQuq5Jqshq9Lq6fRHa/NhKT
         42rp9kgkDh0HrR6epB6WsOQP8IGen5/wy6ZOcuGLcj0IsvebV42GxkV4c1RqYaGMb/ih
         WN5buIguThJj3RCQABy0r+PkWcZWkc08T09lY0gwW3PuMYaOP9wF/4i5q8etWNczdh1P
         zOng==
X-Forwarded-Encrypted: i=1; AJvYcCXUjYdyaTZYR27/t0/URcdCc2F4I9Vex3ST03deKs2cARzU6o+eQ7J4Ll3rKG43sn5RLk2HDlQHvA1NlHs0pZ/7mxUn
X-Gm-Message-State: AOJu0Yy8r2s5W/85iJIGhxyrZSwqDyalWPKJsl2yNRc08h+iVdBfPIAk
	FkBJNSx6Nn98Q2vi+8q6xHLPlIss//oHyBUDOxz+sn/ZdZorJmH5
X-Google-Smtp-Source: AGHT+IEZRJ8fvEthRm2YyejBxaO2wXxaEfqbrmxApQ4gN7V/2GPJBmmHDyn9++4sU6dux8xDHMVZTA==
X-Received: by 2002:a17:906:55d2:b0:a46:1426:f7c with SMTP id z18-20020a17090655d200b00a4614260f7cmr616009ejp.63.1711450678186;
        Tue, 26 Mar 2024 03:57:58 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id yr5-20020a170907334500b00a465fd3977esm4134831ejb.143.2024.03.26.03.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:57:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 Mar 2024 11:57:55 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
Message-ID: <ZgKqMwmrjkr-ByYE@krava>
References: <20240322000041.2919948-1-andrii@kernel.org>
 <20240322000041.2919948-6-andrii@kernel.org>
 <CAADnVQ+SWwJMtdXj1s1RtzXJfjXU4Y41eNg+xzFXe2-DNUR8Ag@mail.gmail.com>
 <CAEf4BzbNRhjALGK7LpHmHsnSHEfmrzserOy07RDyP3aSbF5HcQ@mail.gmail.com>
 <CAEf4Bzbu_4OZwgXREAbxY4fjwG2zFhox8nXpRgd_p6aUENCufg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbu_4OZwgXREAbxY4fjwG2zFhox8nXpRgd_p6aUENCufg@mail.gmail.com>

On Mon, Mar 25, 2024 at 06:43:29PM -0700, Andrii Nakryiko wrote:

SNIP

> > I'll add bpf_modify_return_test_tp() to not touch all the tests using
> > bpf_modify_return_test() and bpf_modify_return_test2(), if that's ok.
> > Existing ones expect some memory pointer, dereference it, etc, it
> > seems cleaner to have a dedicated tp-triggering one for this.
> >
> > > Exercise of test tracepoint can be there as well.
> > > Asking bpf prog to call a kfunc to call a tracepoint
> > > looks like extra hop.
> > > Existing test_run facility should be able to accommodate.
> >
> > You mean if I add bpf_modify_return_test_tp() above, I should pass an
> > argument of how many times that tracepoint should be triggered? Or you
> > mean to use test_run's repeat argument to trigger "driver program" N
> > times, and the driver program would just call
> > bpf_modify_return_test_tp() once? If the latter, I'm not sure it's the
> > same as calling the driver program once and doing a loop inside, as
> > we'll measure more of calling driver program overhead (N times vs 1
> > time right now, per each N tp/fmod_ret calls).
> >
> > (But tbh, not having to use test_run's repeat functionality is a
> > benefit, IMO, we can have more flexible counting/timing code and
> > whatever else we might need, I'm not sure why using test_run's repeat
> > is advantageous here)
> >
> > Not sure what you are trying to optimize for here, please clarify.
> >
> 
> So I currently have these changes. I moved tp into bpf_test_run.h
> (didn't know we have that, this should eliminate the issue that Jiri
> saw as well). Moved kfunc into net/bpf/test_run.c and renamed it to

sorry I did not get to it yet.. will test the new version

jirka
