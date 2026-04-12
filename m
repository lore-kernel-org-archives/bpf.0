Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A191A3166
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001870; cv=pass; b=GSzWYdu31ufmtlqO6ERqc3m96trLMjjUCitzRcBPi/4qTrG2BQT1Bs14D9jJLlOl9tcrNukUy/4xsvm5wG76ST0ArJSHpjXXV+gxk5lcsPOzwavK2PcK/YgC7WHeipZ0+alKtrQNksYi3cWT2ggz17u7+cJWWG9f5TqSEqBRu9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001870; c=relaxed/simple;
	bh=Vm+QvtQZE23sVbgK/tEkRjhUlOBlrvQ/gGRliE28Mbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUD25kZBCByQDsDkiQRZ1HloTDE8m23RkQMbSDTT/rwrx+v97+gw3ldGGmI8YuW0Ua3fj+Ao1mWncIDHMHz2zbGWD+baZbqAWUBIuTeFYAd95t/R3vijZx0Ny9pa+lAlKQmPGt5dawQEeB6vC4WmXz/9HQGcfcBB5ZogWn3Id48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9EpLx+G; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9EpLx+G"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6501c4857b2so2966180d50.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 06:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776001868; cv=none;
        d=google.com; s=arc-20240605;
        b=Kw13p6jrme6BkH+waUsg8Cy9mlyl8DsLPFLoGqq8vrmMv6eE508KbqOBP5SpZ2VuF8
         P7BXkebuxyJB5WeOfC5/lgrEfAZ/EJnzGfR55H3v1fq9ySx3cG4840TvHUa+juttCtQM
         IxPKHA/KuiuAP6DLNI/ouT8h8Zv+EfGPMugQvoa6YynylL4A8CW5q8lEaXHOhbzcj+UQ
         2l9NRG52ZCaSMlEzf6qX8wPPFgbN08eJLZ/6QGeezL7L1EkuD7Pwu/WtTVzZf5zvWeCK
         jTlyoyDS1JZ1LkMrMY3ZnUACRJZAkmmUKqTZWbH7kZjYc7lhmyydaRAl1BN//Xh7Stpy
         n8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdsrFw8g8Bu97byW04CT8KXQ2lpv8OYnpWUOna6h/+A=;
        fh=F9+GiexV+OeJMSYY6YtbhVpRT8FtmqyqVu+uQWGa81w=;
        b=GA8FvAYbAg+5+qQ5/MUdJp+a0bEd2wXbptj5zg9zWNGtMs5g5sQw/gr/fMwPmhOljU
         HaxVYoNkko15xbZMMv9pB1m9IF+IQFBs+kV4YvZpDW+D7tM+wSwgguwOHcsBklH8XprH
         b3C9wCbLCx3RMzbjz8uwo/jagW2XUyHAYKEs55ff7TDLfbdlF9VPCA9Ex9erFz6011r2
         bRBtg0rEa+RW47z2EiaqWjoWN9UBHElLnNdhVUNSrFeUEI68z4yp30DIMkuSmwAfrEFE
         tr+R9uthpEGAHWq7Z+6h/sQhKTVChXGk+YBrMwp0vkqABDXNbjiT8OYvT9dYbFukoaKV
         JOkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776001868; x=1776606668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdsrFw8g8Bu97byW04CT8KXQ2lpv8OYnpWUOna6h/+A=;
        b=C9EpLx+G3IANRDKis1pKPomgySzvwrG/DTrjgtOykO1b4WyF3+cMHefL7ElWXKi1FU
         CeYm5P+RLOwAP1N249Neu8WTFkgGtw5FjimXN1muGdRIrzADFh+Uq3Go1DbLWIXT7RjX
         V07TzjpDIxbj7Oc/EFLBW0w7CQ4HHrvyUJ7wHNLEwrDPgS1Yw9gOm8oDkmsOnVwJYd3u
         To0SeMQSipn0oCThDiy4jRix087DHW9zam1PJ/H8bxZ77aBwnIj0uKulpEq4DjCtYRbg
         u6OhiOFwAcxkzhM2L+cbQcodjM+mQfGnKAzlqKb42c8jnt1MikHeiFpTgFWx37F2Doem
         QqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776001868; x=1776606668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdsrFw8g8Bu97byW04CT8KXQ2lpv8OYnpWUOna6h/+A=;
        b=ZfHUP7kyvJPerwrogLezLZYMF1Zax4gS02Gcp4DroXms2DWr3K6FM+0HPrZg5Grm1O
         q5K8EJ/mKuq8pYax6cvTr4y1dmAqRxikAdfSiAeWXXeYBzfTw/xJlo5SIXegaBeg5c6s
         UzltOQnpcsbXFRZOdlLopOE5Ap2d6qXrF9rcrlNzy2AlrG+Drk+EkDNBRDC6+qO0nRHN
         bpTsNDkdEqH5B1PXjV3XXuXSNBQCcPQAzw1ROiEw6L4U0JezMWrgK/tsE0hAYmyyJNys
         z8IERTQgf63ZAOqv1Jk/qPfcFsTrjob1fop91REm3h3xvQ4E2CnidCInIkJjPgVH7Ny4
         glhQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JcLLsyb99Gg/Ex93h75iJjxOXzWyTJY8B6wp3oHGEz7nJnJ5AviIK+IYlbpcRwnyHSXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemRxtNxdjhczvZFuzjneDcgujVK2su3aT486FGFvlLkkg/o99
	mMrJnVVwYedCGK29pCxtwNlqutlHjL4sekUgSpFXg54HP9Waq/S3s9OsSYDkxM/Z/KX8b/kCL44
	MxOmtXpIjhirGXaxg+6qHnJTFR/ef6Y8=
X-Gm-Gg: AeBDievZ9b/xlAj9VZ4T8nTHFqBvpTEwxn+rtyRRvXMgwEqz3iH7mCRhNnASqaVcBXA
	SAwqvc/7NH/vPymZVOjQjjFF/7yLibzPfriVHuuLpL454Ugh12IPPMBFatJOkszrcjyMNfPy/rR
	EqAVQK3jd9d/otJmQaL2rxzQTYPx5c3YTAeYhDqfIdlTrkvg3kaa3FIOfmxUQwyjL6mDkZ26Hwq
	vXediu1RyluUNAANiQq9K9xxyp+gqwMiyoj8obwyYZEp0twzrbsWw7VfBgbuFst9CkxxrmjSw/q
	WN6SWhPLo5jHMjSwBlOpvfgUcguzJKjoVnn4CcVX
X-Received: by 2002:a53:d246:0:b0:650:77f5:1410 with SMTP id
 956f58d0204a3-65198b47128mr6848061d50.33.1776001868315; Sun, 12 Apr 2026
 06:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260410133844.56ab7964da7628d1c3482acb@kernel.org>
In-Reply-To: <20260410133844.56ab7964da7628d1c3482acb@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 21:50:31 +0800
X-Gm-Features: AQROBzBaWJkKG21AiORGSzFrR-pHHuRCQzMa1l_wXUruYUno8uNhz0WAA12-V04
Message-ID: <CALOAHbAOx=C4b+4xQwRf59xvY0vbMPfOjO5LMDghC4Ryksv++Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, song@kernel.org, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:38=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> Hi Yafang,
>
> On Thu,  2 Apr 2026 17:26:03 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Livepatching allows for rapid experimentation with new kernel features
> > without interrupting production workloads. However, static livepatches =
lack
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
> First of all, I don't like this approach to test a new feature in the
> kernel, because it sounds like allowing multiple different generations
> of implementations to coexist simultaneously. The standard kernel code
> is not designed to withstand such implementations.

However, this approach is invaluable for rapidly deploying new kernel
features to production servers without downtime. Upgrading kernels
across a large fleet remains a significant challenge.

>
> For example, if you implement a well-designed framework in a specific
> subsystem, like Schedext, which allows multiple implementations extended
> with BPF to coexist, there's no problem (at least it's debatable).
>
> But if it is for any function, it is dangerous feature. Bugs that occur
> in kernels that use this functionality cannot be addressed here. They
> need to be treated the same way as out-of-tree drivers or forked kernels.
> I mean, add a tainted flag for this feature. And we don't care of it.

Agreed. This should be handled as an OOT module rather than part of
the core kernel.

>
> >
> > A significant challenge arises when atomic-replace is enabled. In this
> > mode, deploying a new livepatch changes the target function's address,
> > forcing a re-attachment of the BPF program. This re-attachment latency =
is
> > unacceptable in critical paths, such as those handling networking polic=
ies.
> >
> > To solve this, we introduce a hybrid livepatch mode that allows specifi=
c
> > patches to remain non-replaceable, ensuring the function address remain=
s
> > stable and the BPF program stays attached.
>
> Can you share your actual problem to be solved?

Here is an example we recently deployed on our production servers:

  https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqge=
o4C0iA@mail.gmail.com/

In one of our specific clusters, we needed to send BGP traffic out
through specific NICs based on the destination IP. To achieve this
without interrupting service, we live-patched
bond_xmit_3ad_xor_slave_get(), added a new hook called
bond_get_slave_hook(), and then ran a BPF program attached to that
hook to select the outgoing NIC from the SKB. This allowed us to
rapidly deploy the feature with zero downtime.

[...]

--=20
Regards
Yafang
