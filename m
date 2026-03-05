Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AE3A0B29
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719325; cv=none; b=idABt+s2EqEvHZSpQoM6j+FxlvgISCxuZffRR6i8J3FXRhJkK25u/XNq8FOp3hLF9Mo3dHYP8bST5lwNElI5lHq/5rEFyhxvUaFh2t206FNnT+DGsIH0WkbILpnCVXbp2pn3rerDhp0saokLpJx3IgsHFZ9vBNtY9HCkX1xtiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719325; c=relaxed/simple;
	bh=wCKuyoYHdsF7VRUt6rFUlygCPxFUFjIMXfz5pBeiyoI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv4iXTP/0xxbDeH9OA1Mzab0cTDwJs4vj0aOytzcpzs6RGdwC4Ytfb6KYOkrOwlmgY2tw4UlyOome5BADOJ9gHdHbOi6DGhFI+3+mx02I4ITX8KPV8JGLaTZuHMUaZIBM2xiUjXhsGLbTSdiWzoI4Xe/l9pIjGJ5h0ngHczBlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GypRQfWn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GypRQfWn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso74118465e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 06:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719321; x=1773324121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46FAW/yHkg8KAkHx2LgsZYfHV1h3nutXQ6HHt8zFYy4=;
        b=GypRQfWnpVbkkVZVglqLrMQKn6kKSF3yjRDNRYNLvUjXuc2xMg8gWhThYXZ3EoMzLH
         3UrgN9QmgRNrdazpMeVd2aF1gGgjjI0sVy3uUw839n0rnNVAhMX0N3ODrNmdLOod+qr6
         HKJUvFLjjzEs8NybAth4J7/lmCVLHQJj/BIPYFgY3cjpoL2vax98foaiAasyufBnrq2g
         U8demKpkVmeWfkb3b8w9hqIG77XRwvlEnd1oNHEQ43+78N4nEMOdsq7axGL5FQM/+nG0
         jirj7SWeFrKWoORBp7pWip4sJ+9azBUrVC0L5LDtUPuWsC/kQvoRlPVylRRFJl3+ROLI
         xogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719321; x=1773324121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46FAW/yHkg8KAkHx2LgsZYfHV1h3nutXQ6HHt8zFYy4=;
        b=iqV29R7DhUzK8wHGmf5G7nQCkocX49p3yC7FXHW3HhuOS7Pa/bRq8snh9DftaHB7Ot
         ndQrBWK0dQgd2GR9I6toNE2CM/dpE9YUg1td5qex/0DKFPI0DVioxsG9E489NKcan17x
         x0aa/plow1yGhUeOnr7LJlpHGfxKI9rGQYxfsHyWGTBgmOu0XFNTrFQQw/Q3rS020KXw
         sr9nJEao6b40pXoRuh9Zm3XcvCGTXLcwdsl5yfEsoBKKAz47iF/0qdWurYv0woy9qzZ9
         NOD2ybH/JaDR1bcKJObRaigJoQkPZSHx3maptYVhHQffwpEt+CCjGM0OJS3ZtgJSavLr
         5VVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgwaWQGxUbbaHexVm9ydvm8kmIxMFgbHuuuAyODTUxcsPUcsjV3+n3ZdKtD/G8te/TllQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUb73QgAnUeZzeu6mpZLW0SQdGZkC2uqdRV9VHMYwKtM/k0v/x
	pM+eP07GH7x3mufL7lAgvqc66KHOhdTnpskM5HjzDbACnUX/W/3pyxxA
X-Gm-Gg: ATEYQzxOWowNau4oXliR9Hon/ZA5BCIaGMU6SwuDtw7JRteGYtILjODhgfQ3YcKBHqg
	BSe7gNccJ8wxHBqUPU12Yb374w0G4vCGPMxyj9Z65Jb06BORw+FnQn+w4slK6rtrc6tgdq1KasK
	QBXBS8VuHdE0FkVGotmg65fVwldYN3PuLJT1xTXxkF+Ve7alQ1+J1SmA6IpEB7DEWakZD6/yNhd
	NNVSM1HnzDpz9ENAmPnpXxZwC3gGEdFk+WCBeEs267otO0DbOl5YoXQlp4uuEeTlv5hEpPwEPrK
	rpL4GA9qyyuOcmyAg8CZDtf2wyUoB/nlMH+jli5gS80EZV+IK6nM4sA209ZxlM5b61VTDxWx2+y
	7/gSkrk1yLQZ5lWqgrxIc3SNXFvQDlS7jJUsrSOQNI8hZ+NMI/aBa1FMlwqkM9oLioE3ZU6yP
X-Received: by 2002:a05:600c:c8a:b0:483:456a:5146 with SMTP id 5b1f17b1804b1-4851989fc75mr89024795e9.25.1772719320806;
        Thu, 05 Mar 2026 06:02:00 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fadeb5bsm61260585e9.5.2026.03.05.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:01:58 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 02/23] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aamM1n-ha0LKnry2@krava>
References: <20260304222141.497203-3-jolsa@kernel.org>
 <28376b19ac32833bc93e5688dbb271724f84f19aece2f828c7ca56bbd9706a0f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28376b19ac32833bc93e5688dbb271724f84f19aece2f828c7ca56bbd9706a0f@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:28PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > @@ -99,12 +127,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, unsigned long ip,
> >  	 *   cleanup_direct_functions_after_ipmodify
> >  	 *
> >  	 * In both cases, direct_mutex is already locked. Use
> > -	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> > +	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race condition
> >  	 * (something else is making changes to this same trampoline).
> >  	 */
> > -	if (!mutex_trylock(&tr->mutex)) {
> > -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> > -		 * some progress.
> > +	if (!mutex_trylock(select_trampoline_lock(tr))) {
> > +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> > +		 * makes some progress.
> >  		 */
> 
> With a pool of 32 mutexes, the trylock can now also fail because a
> different trampoline that hashes to the same pool entry holds the lock.
> Should the comment say "something else holds the same pool lock" instead
> of "something else is making changes to this same trampoline"?

right, will change the comment, thnx

> 
> Similarly, the sleep comment says the holder "makes some progress" but
> with a pool lock the holder could be operating on an entirely unrelated
> trampoline.

this one seems ok to me.. holder is 'whatever holding select_trampoline_lock'
which is correct

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038

