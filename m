Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806A3C3448
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494793; cv=none; b=IZjGSdL1DEfjzGCLkm65Wo0aAWxNdt+dmnJeDhWBIFSml2bopWOQS/9LzGUMwAXKUJC7DQ33aUYdYR3djBovCRklEzijR6DggFCSzgQ3Y8pJyHUg3Pu1pCjD+1W8W7uq+zJ4fffADRIvX+4r4ZKMgQ3028l0NZj7sOMlg3CHTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494793; c=relaxed/simple;
	bh=ks7ehWn0UhqW4rk4JLDGsqK9mOdKkpROxg8rbvdFVTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdkGXtjTCSdFuVS4MxVHElT3OwEeKFdIXIaWtbSxT56qvGow6eigQJu8DdVcjFBPrhf0NWaoHQWQrSUL3wgvMXRQoB7rAac8tqOsLw572sMGRFx2Sh0ef1fFpQZaTB5sXt6nHC0m9JvwC83belYm/HWgh9ZSgnxAZusxNyXaROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap5uKObf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap5uKObf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so7742635e9.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494790; x=1779099590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r0JHrPlA1DfO00D58uuDhg6hCJil6vaxkPYydwdL2oQ=;
        b=Ap5uKObfUWRZkqyppgo5/5Kc+OjgGMz6Fy0if41zoJsz/80AgRxeoDM1sj4kSNHU5M
         2FaQN47OPdSNqpc1PMnJKZ1JHPBnIDwC08E6iuEHYjIKWzDJ+VMPUKuzm5b8adrw7o7n
         d4mhTFb1JuMQMQRcEslgEmkihiTVUyM1hSmTYZigS5HZDddCwyirQ8XiHN1ZXn/VO0Nb
         OGFLsFEFc+cXMtB9oD/VeQBiIFa/5OFQNKBnc1unMqN9yiiUtzSItRcuScE0h2vfzpF3
         qwAxinBxju0DZJ4D+RZF2rQ9jclECHHpJOeyX2EIrKL6FALFvvvt7EFJzx0tk/OrahAZ
         UA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494790; x=1779099590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0JHrPlA1DfO00D58uuDhg6hCJil6vaxkPYydwdL2oQ=;
        b=ne+i0iLUzf0FScNX98H7bFFAVcQTUdw9j652TXkfYpEcBQ3YTBBcYnaXJnQhAyuw8Z
         DCtz0/bx6IYJO4WDFUP3/CdayFOtxj0pwNeqT6s08+HTo/52TY1vHwq8CnCDSdDTN3LT
         LmxXCXxHsLZ0Zudf/by/jh5cmb5BkhCwgUdD2N0YISnUM7zkTmvabvFlfUV3IvJpqpIp
         ppOOWJJfWNg9bBjzr38Ow5YRzn9zZBQuNT57NFKHe1wkxVSURdTEu7bwRmzUcFQ5xm4E
         iaMFN/aiqz9osBLq4X1fJiYZFE1G7G6CxG7lV+3qOjjr23jVC87QcIHgkp1ol2OWC2Cw
         qhZA==
X-Forwarded-Encrypted: i=1; AFNElJ9+M5Dskyu15mpykyC4hXW24llp+/gwqXTwX2ingjlNYL8q6sEl/Rzhi7hzfgN3KTj1vCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPltv53x11TRoNG3B6xPzcj9xa4NPswwDVpILv70iRbhrvyQ2y
	qGA2kRbgEUMSr8X5/qV29Zld7VpyGWwbS2goGbUbu2WdvqHQEJeC8g2O
X-Gm-Gg: Acq92OFJscNyyzM2wm+zdqwM9sPCnMI/7AN9/gnH59E9zBVY5j6Z7JAEaK/NyfGY/J5
	AfyZU9d+w9s3DcBZsZ6i2b2cX0mYDur5inKA/2uP9O6nNIcDlKN//5UDDWk9xkSER/8LabrfqTP
	PKQzdUcuoLkslAUo7b6iYRadnP4a75J6bfPJivZuajFCiLtAMlVZIJilt3F5LS187Kx+6a6aolj
	ZSiWZgcjazxLpdt1LyPBgnlzy07p9mSeEtsv0HL3L5I1YL3IYd8f0yqO0PtIdR4F6txBk7AzQwG
	khpzH21YvgngkTxeJIH3UKxmKkiPHLUner5TctdFeXB68pBDQKGso67O6wiyyRFziXmmUbbnnPD
	TetdJAhN6dWA0LEMfgS5dwSYKzqizmT82EggEs5zE5+xZBFRl6DHGOjtVwE7iyuY9+onemgZrFw
	KtK52PzfbzA/l+N9y1q2hbFtsxyz4IxKNXAz3xmKAewL0ppC5RD1vP/tfA9Xkg7UOXeXqQOFTNq
	xoHvzrMwmsHHwIo4FtmJ/X8kOzP+KlIrLLTuDS5xNn0kq9mxJ/Da+sIiJ1i4rw4HyqrVNWvTDJh
	w8lGGKIEJk2D+6AtCbpjgDYcPwCSCVkjCuoVWTj0ip8=
X-Received: by 2002:a05:600c:33a9:b0:487:2439:b7c8 with SMTP id 5b1f17b1804b1-48e51e0bb9amr240043685e9.1.1778494790084;
        Mon, 11 May 2026 03:19:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec426sm169695515e9.10.2026.05.11.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:19:49 -0700 (PDT)
Date: Mon, 11 May 2026 12:19:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf] bpf: Don't run arg-tracking analysis twice on main
 subprog
Message-ID: <agGtQ0PY3ziCoFsn@mail.gmail.com>
References: <e4d7b53d4963ef520541a782f5fc8108a168877c.1778176504.git.paul.chaignon@gmail.com>
 <CAADnVQ+kM=Zg_pcY30QHFPu_16L8wa+DbgQqnidqo-QZphihFQ@mail.gmail.com>
 <3e3a145bfb6c17535c5c921c60f405d56d32bf7d.camel@gmail.com>
 <CAADnVQLpbXdoqo11c1a4mS5XYPG+5WXrd+MP9EFoDGj1_B0uaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLpbXdoqo11c1a4mS5XYPG+5WXrd+MP9EFoDGj1_B0uaQ@mail.gmail.com>

On Sat, May 09, 2026 at 04:16:10PM -0700, Alexei Starovoitov wrote:
> On Sat, May 9, 2026 at 4:50 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Fri, 2026-05-08 at 16:24 -0700, Alexei Starovoitov wrote:
> > > On Thu, May 7, 2026 at 11:22 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> > > >
> > > > Because subprog 0, the main subprog, is considered a global function,
> > > > we end up running the arg-tracking dataflow analysis twice on it. That
> > > > results in slightly longer verification but mostly in more verbose
> > > > verifier logs. This patch fixes it by keeping only the iteration over
> > > > global subprogs.
> > > >
> > > > When running over all of Cilium's programs with BPF_LOG_LEVEL2, this
> > > > reduces verbosity by ~20% on average.
> > > >
> > > > Fixes: bf0c571f7feb6 ("bpf: introduce forward arg-tracking dataflow analysis")
> > > > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > > > ---
> > > >  kernel/bpf/liveness.c | 11 ++---------
> > > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > > > index 332e6e003f27..505250998f36 100644
> > > > --- a/kernel/bpf/liveness.c
> > > > +++ b/kernel/bpf/liveness.c
> > > > @@ -1914,15 +1914,6 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
> > > >                 return -ENOMEM;
> > > >         }
> > > >
> > > > -       instance = call_instance(env, NULL, 0, 0);
> > > > -       if (IS_ERR(instance)) {
> > > > -               err = PTR_ERR(instance);
> > > > -               goto out;
> > > > -       }
> > > > -       err = analyze_subprog(env, NULL, info, instance, callsites);
> > > > -       if (err)
> > > > -               goto out;
> > > > -
> > > >         /*
> > > >          * Subprogs and callbacks that don't receive FP-derived arguments
> > > >          * cannot access ancestor stack frames, so they were skipped during
> > > > @@ -1934,6 +1925,8 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
> > > >          * each subprog is analyzed before its callees, allowing the
> > > >          * recursive walk inside analyze_subprog() to naturally
> > > >          * reach nested callees that also lack FP-derived args.
> > > > +        *
> > > > +        * Note the main subprog is also analyzed as part of this loop.
> > > >          */
> > >
> > > Thanks for the report.
> > > I guess the fix is correct.
> > > This part of the comment needs to be adjusted:
> > > "they were skipped during
> > >          * the recursive walk above."
> > >
> > > I wonder whether something like this is cleaner?
> > > -               if (info[sub].at_in && !bpf_subprog_is_global(env, sub))
> > > +               if (info[sub].at_in && (!bpf_subprog_is_global(env,
> > > sub) || sub == 0))
> > >
> > > This part of the comment:
> > > "Async callbacks (timer, workqueue) are
> > > * also not reachable from the main program's call graph."
> > >
> > > is also not quite correct.
> > > In here:
> > >                 } else if (bpf_calls_callback(env, idx)) {
> > >                         callee = find_callback_subprog(env, insn, idx,
> > > &caller_reg, &cb_callee_reg);
> > >
> > > they could have been reached, but find_callback_subprog()
> > > will ignore timers because FP-derived args won't be passed
> > > into them.
> > >
> > > Eduard,
> > > wdyt?
> >
> > This is a nice catch. Idk if 'sub == 0' part is necessary, tbh.
> > Paul, please add my acked-by when you respin with fixed comments.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> Reworded myself and applied.

Thanks!

