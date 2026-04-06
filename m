Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284432ED58
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473090; cv=pass; b=iyPiG/oNSg5SLq2ogAxi8QQqK+dgQu+G0t+N5Fo56Ll7GmURQhOBixHjuegKzCr/NalgkzFDwVpESOAlgp06Ju2wpQwCBLLOTpy2d5jPsJ9BSOr2ujT2x+c92uvvPzYlXO27IUV6ptZA9PC0CaKP8E2kH7vqDTOaOqLHAr5glQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473090; c=relaxed/simple;
	bh=KeMAFzLFrGIxkUSWTmdTJO0MCX9FTfYruj6uWs8QBjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv8347tyd3JtlDPWEioAect4k/ejcEDoRlKqOYp170UqKDEAdc64eLD9elpm0VBAIqSYn0ZCm/X6irWprRoWDrImpIPyhbQgEevotMiBGO9D1uoxm5e0bUSU0Ddslh33doOH9Bi03b2fypN9Kt4a0wREe0YSXDUYtdcNxRud86M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PICvgEH3; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PICvgEH3"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65032e9cf01so3454839d50.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 03:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775473088; cv=none;
        d=google.com; s=arc-20240605;
        b=SsZeW4YbMXBjDqVMKq8LjiYbNYtPN7XtIegjMxySkLSBqfF2mN+l4zjebPj83ugL2G
         cN23Cx4AC+zabOhHlSEljApCrBqs7sLC6NM4R080KvIZQsC0NM/s15u6YsxyFsBHI4lw
         IcpYiHrvk2Ojexu6VT2YtjMDkYUBhO3Jw3bKvjAhFz7UScGaN0mfL8WFcVutLB2x0LnD
         tE0H/7ctLilmz1XXfruKwT6j6RUsxrC6wLEpPNEl9HnJxpJuFFJtgcrAqCZbi3bkZjIe
         DX46kp+oEpJJk0pT2owd6WfJiXEhY6QcXVxn5Doe+oavVbLcPTJy+ujNGvQA4aiZcVsq
         /OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23p+wdS60pXtBpNvZkSzHr5OzahO/ZfsvZCv+StoNBA=;
        fh=0sLCikyNX1Q5qonF8TYlcTns2lt85bDKHnA1+8fKHq0=;
        b=GoHMCG/WUJaE6e/d8nwVHrs3jgeUQY6hUW8VyP4vuBJxOs7llEkzPJu+pFVsQn1+qT
         AhNoOLjg101liZpaO0TI2YDFawpEsZNOCtOABdAwaw6iMSisWVdPzkZieDCsiGMK0NiV
         AngdCnExqIyLnLnyGRE6Dh22aY8Ftiw/Gce9mxcOIhs2/r2OCHvPYSt7r1rDucvU3or/
         tDKq38jkaPcWgqJjkVsIDbyIGS8AEHWwzqApZ222h5+mJbz3VbcykG+xEO2dmWz245JJ
         M+w/UGlV2Q+9OVBq4XVc1k6t8vlioxoV0foXiJsn7kHgooFUNrTtnwiwpEJH5s2d0ur1
         sptg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775473088; x=1776077888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23p+wdS60pXtBpNvZkSzHr5OzahO/ZfsvZCv+StoNBA=;
        b=PICvgEH3Aqo4JlF4Yn2MC+MS6TAmKNY9U0p/v0YNLFnBZJuXzixlR8UyzCFgCamAg4
         DZpQreX2d+1R8I1x+RLvHJ+8s12yedFqlomElfPovotJgmilDeaM2cQChJs9nstGPDqu
         uB6w/uGnRcy19lo0V0l8LBZ5hB8kEFqBOEC2s6Bu+tgOHF5BmIPlal1j1xK4b+Xg+jYC
         2wBVY17ffKYfgozT5f+7fEjml/kg31wr0gMH0nh/HkguiqMpfnN1sDO4yOX9OSP75Hss
         1meCr88nV3GNMi5F3e36sDMllzeAo2i0lVmUW42lZQwWkUa9rSJLW+r/XKZ7O91UAsGl
         ueRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473088; x=1776077888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23p+wdS60pXtBpNvZkSzHr5OzahO/ZfsvZCv+StoNBA=;
        b=qFGofHLb87NTtXPImZ1cNCbO6ybCZmINH3HtInhQlMdDKmiLLCh79eKWKXEg5u2Eay
         FBwHirWss4oDVVDQF/wDh+J2K8qC2XEaW+pJzFJAUcOP7p6CLHTRRJ+E1RYBCT8+Mo5Q
         fkfHCwzzQ5vN5TmloxGaG/SF7daNXg+3Bk2ItawHRo0ohVAH2qiUUwUrhN7E0Rmsn2Bm
         psJVQtzR7ouZgDLHY4RWHW/3Kr4at3kiC6WlCmZNdGv4c3892x5Ai7KnDL814lGoW7lK
         tukwQKsjQbLK2CjRWzruLN2DJ5gu7DoytNLgZ4jDRT/LckWJc5HcCEVtQrB5uuoIPudM
         51Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWS6CXtaIKnbRqeZejpvXpZ/KPi7Dxx41NqZtBz5ZLP1pjZnwKI3HLD2F4OyTc6BjiuU+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlmmaG86Apc32kFJx72AFZUpen7fYD24lcDyy0OASPxeNUkQA
	ViWZwAhPe1vRqIqBHpDqPB2NUwmvMyk7xbfC3mMCez/q9cpdCj9tXgySIIuZ19US74E6rTBV3uH
	lQGjKFu8PI9NoNX3W0SXOpwPfZ7+nEwQ=
X-Gm-Gg: AeBDievUYXQy3my3iROp5V/0AhfYaV5plcKbf7cwK1EXn+nND1Yaf8JHvId15YcshXR
	Vi992TjCPVkNdXua5WQcvpQzySSB6L0FmVyGS7KSFzSAwQxl5V8mG43TqCFmUCaNkgu8y2mnTse
	etOPg6MGzyheSaIvhsydqWJeQpDcKQuqSl574ncyDr0hMHWw8PWR0n8qhvD4jKYt9OIk+i7q9J8
	QR5CURbMwijjv1IA2f/Iz9MAV37NHBZCAFgIZf8OEXdrUB/Q4NoX7fKXZ3tUWl87+JbfPNfZIS1
	Rre+kjFDx5RCMOWwi4fj9kkhAetRUc5kaYp4/a1xShOV8ELKpA==
X-Received: by 2002:a05:690e:484e:b0:650:3831:5728 with SMTP id
 956f58d0204a3-650487252b7mr8448323d50.27.1775473087931; Mon, 06 Apr 2026
 03:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <adNGXfRI84mZrUSs@infradead.org>
In-Reply-To: <adNGXfRI84mZrUSs@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 6 Apr 2026 18:57:26 +0800
X-Gm-Features: AQROBzAl0BcDhENrlTb5JpJbwT_YJ16rCE4wk9DxJbKmVNmRtDNxJ6Ti_Yessu4
Message-ID: <CALOAHbBM0YNr3vozKxAwVOyBdZq5S376uwZBpfxNujhzV7cM5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Christoph Hellwig <hch@infradead.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 1:36=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Apr 02, 2026 at 05:26:03PM +0800, Yafang Shao wrote:
> > Livepatching allows for rapid experimentation with new kernel features
> > without interrupting production workloads.
>
> Myabe it allows, or based on the rest of the mail not quite.  But that
> is certainly not the intent at all, the intent is to fix critical
> bugs without downtime.
>
> > However, static livepatches lack
> > the flexibility required to tune features based on task-specific attrib=
utes,
> > such as cgroup membership, which is critical in multi-tenant k8s
> > environments. Furthermore, hardcoding logic into a livepatch prevents
> > dynamic adjustments based on the runtime environment.
> >
> > To address this, we propose a hybrid approach using BPF. Our production=
 use
> > case involves:
> >
> > 1. Deploying a Livepatch function to serve as a stable BPF hook.
> >
> > 2. Utilizing bpf_override_return() to dynamically modify the return val=
ue
> >    of that hook based on the current task's context.
>
> Whol f**. now.  Is this a delayed April 1st post?

You're already in my spam list. Don't expect any further replies. Feel
free to keep your verbose rubbish to yourself.

--=20
Regards
Yafang
