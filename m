Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E015884F
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795246; cv=none; b=abOy798+7bpjEuJbmr/637v8cIpyQc2XyJsUsxrWYuPyd3FJgyP3W0rl9nqO3DiDZ4tptvDKXjWYYM0Y4aLfkZ0sIeyYUxz+fCY9bbnulf2h5o44mGV/FuQLW7xr7ESxkNTrqL34WOokCzDY0/zrn4PTJ9I67PbeNu2DXwB6SW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795246; c=relaxed/simple;
	bh=/zCcP1X1di1bJ8igzkeKa8QLS6+W1fjEL6lp+hEgy6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDHUw9fE1oSnTEzYPpxf3CS92/b4XKl3ihyknoC2l90VqgRxgEytenLOZDS4FDsfCN7KYZIKAtLIxttlovpWm6icE5a9uQp6KXXDCROVl3ZoW0Q1zpNbmE74YldweDeWjtUMMTFE7KhPyXsH8tjIQfb56OvV1ET9Pagz0mXeMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYahn0dK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYahn0dK"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso28711a12.1
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715795244; x=1716400044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zCcP1X1di1bJ8igzkeKa8QLS6+W1fjEL6lp+hEgy6k=;
        b=xYahn0dKtXhY820/F6CDXFoP2gqTb3Hyfibp5IhGBY3fywmEfVxRVozqL6hItqnjnO
         73RLzB7KCmKM0I3TXcX/6+7KP/ldHnAKgdM57sUa2XOpDyDsCQGCBT/QAhjBWCgfm/V9
         u27KFFgy07GkEfUxR4YN+0E6bH0YfVYZKH4RG1WXz4bVxJAUJGSGaxXNh5IVF/r5F0Lr
         7DyJouQ+vssBpPZW2Qlx/9mMMOVzgCu4C4UpFSti3OYZkOL/j5JYtOSOt6b6GhsTF1/t
         jeuqic9Jwm+9EhQbl9/vwBfrxgxlRkOecOmKXKHIpZ6UHf4OnFBlF6olubIFhO5fAmzo
         qTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795244; x=1716400044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zCcP1X1di1bJ8igzkeKa8QLS6+W1fjEL6lp+hEgy6k=;
        b=tXtnXF2HxHDM38xp8Wjk0EoYRAtyzTWIYBXgvoLyD5HgykTtoQn4JpJoUMNeXVINLn
         cLMVGASgMPvM6TXYtLSqL+mBAuSboegdrkqY7neUm9FPOqrfWGmIrKcNvYy1hrlTiwSt
         v29GCtOD4JhW0k0B4QExxVPwNjC7VAGMtSN+nwB9uIXDgGEnthBY5NLx6Ku6c89VsAKh
         HvuIKeHLBfqvenlB7DGFsegkgYbWXEGLQRSTVYSamqtzmvyBwvvaInnYM9+gHCs7mSCV
         Ah4uwchFpPmJHwrcLPfwWJ8yIXx6pC+OdU3gcC7UIXuZ6b0V/CPmFlgBbfmUtVBh+2mY
         ybhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbCqbmPaN9GxvdmtRIi/ytU4WKuQ09BXRsV/hUw+fVYR/2lRBs7u75u9YC0SQn4ULrxD1tPvT7sMIf5XokaMAwJDKj
X-Gm-Message-State: AOJu0YwxO89c+hvaUWj72B+Wfb5XfSAtrOn8h7R1yaI/6sJivUktleNS
	6A1M76kCDY5MzoLe91rIsMgnYwKdgphjToPOB5gwlL1EUtI9zcAIRn6r1TyboPJAjMdyLBy52A5
	9zTspFIrPV74a3J3mtQs+F6e59xK50oUOgpc=
X-Google-Smtp-Source: AGHT+IGAXYIvp/5ckzCX34ddHzC1hiYy+B64kYba2ozl+yuCpUfE1UDiQpoL6EmGIVsWJBofAQCpERhDXWItJwqAXeM=
X-Received: by 2002:a50:cb8c:0:b0:573:438c:778d with SMTP id
 4fb4d7f45d1cf-574ae3c1280mr810495a12.1.1715795243503; Wed, 15 May 2024
 10:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-4-yabinc@google.com>
 <CAM9d7chNz8-84m28q5qSLjUjZ=Ni1CA_JzbB_P+YJooLQd85YA@mail.gmail.com> <20240515085840.GD40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515085840.GD40213@noisy.programming.kicks-ass.net>
From: Yabin Cui <yabinc@google.com>
Date: Wed, 15 May 2024 10:47:11 -0700
Message-ID: <CALJ9ZPOr7Jg8Vic9Ap5+jYqJVaLeV3DEJm3dAGBCLB9DL5EusQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] perf/core: Check sample_type in perf_sample_save_brstack
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 1:58=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, May 10, 2024 at 02:29:58PM -0700, Namhyung Kim wrote:
> > On Fri, May 10, 2024 at 12:14=E2=80=AFPM Yabin Cui <yabinc@google.com> =
wrote:
> > >
> > > Check sample_type in perf_sample_save_brstack() to prevent
> > > saving branch stack data when it isn't required.
> > >
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Yabin Cui <yabinc@google.com>
> >
> > It seems powerpc has the similar bug, then you need this:
> >
> > Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper"=
)
>
> Is this really a bug? AFAICT it just does unneeded work, no?

It's not a bug. As I replied to Namhyuang, the powerpc code checks
sample_type before calling perf_sample_save_brstack().
