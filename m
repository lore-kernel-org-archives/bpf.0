Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A02FD1DC
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551822; cv=pass; b=b+wB7MdFS3yc6dBlDQx1FlnbMCLCkKrqQvehhRGbw6WXWlJUwAvg+OaNdqn+hlm6JYoJKBh9/Qy/FCscPg7MucozzTBHaMzvFK8XJn/j7Pxs9FI4Ufx0rsNpfV50CCLj4/sefvIXTOhhfR7x0Nv+FlJBskaIiwUwbFCYXLVrvf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551822; c=relaxed/simple;
	bh=2igPjrmSmxOZqXAz/2IGESBsIQPmX2WXNrQd96+8pbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R//Nz/pGu4D9KGxeobpNQSTmoOzrL3c47VBsO+z/q2s6T3h30MhqGQkU/7rn3y8IGM3ZHreoan5rBLcQmeDOnPJbSbgWgzTlhsMIYvy23Ese5spO4bWmUpdzkCp1wZ1lLMMcjCfKL0dfmEBCNIApuXRShcoHmhmooFO6QJzcIIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVe27ha2; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVe27ha2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a7bceb6cd0so48353145ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 14:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551820; cv=none;
        d=google.com; s=arc-20240605;
        b=VsdlVkZFswyiBQgXZBr95v3kvArcnHLasz6a38B53GwsZ+iR67EaOaXSg8mbLkv284
         mfdnOvrZbXYd3ZXyXgGrKCYti2pMFU+PYud23yonCyLDC7VOEivVzAE/ejHJTzCn2uaL
         L5O0+yO349kphnGAl5pzx31t30Xd99eglMuYQNc8GMbV3fRSopABfp1jg4rzHBlqZUEO
         cPS17YNv5b9Nj5RGCHof2364UnkM59yeT4+3vcLzJt1QzS/9sSGqCQ9FNgiRv3hPjhEZ
         t0cGp5ygk8/ch8Ke303zmf9oqO2uPWWTPySfveEdNf84Z2me+n09SJwhsd06HrGqtLDJ
         i5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2igPjrmSmxOZqXAz/2IGESBsIQPmX2WXNrQd96+8pbE=;
        fh=V30d9EXvxT7qKJKX2frpmmYzaqXgQZ0GWaNK/mWBiCA=;
        b=KOHgv7zjPS6i9nPW4CLzZq99/ci+Ne4FpWs2rz9MIk7D59BaxpVvdcGBUhrHNdA2Q+
         gm1zJyt4sj0yCBunKZ1achi7AfzlrWLt4ALuDFPmolzgFWpg1DgzKoiqLoJCHYYXofZ+
         cCRNXiQIIpwoDOLycMdj12RI76o9EMptzayymEpbRoY2Y+Vlm0SHbD4fNJnC4Xr3qGo1
         fKhFTpuqi/PzDvq/dojqky+wVCiRGYTV5BvVJgYssF0pYpRoj+ANwQH1g51mBr3o6ShQ
         s3wRSrcKKcKJCZ8ScbEAMFagK4+4TJ22n7QOUr/zDD+moi+N1NCtOP6JqdYPxfA5hty8
         AOgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769551820; x=1770156620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2igPjrmSmxOZqXAz/2IGESBsIQPmX2WXNrQd96+8pbE=;
        b=CVe27ha2D3rmmMZ5sqYdS8cbOvLaWDWbHtxiT3/x+cC96RkcLkbr5vMxGyrybF21pd
         iBR3PLkVl6GmxnF8HW7zDVs6IIA2ILZlu7DjJvuEb6hNuT+MQI/qnrqP4pQa25YnzSBg
         1K1uNR6Cbpj/M/wMDGMCmetEA8MlHiiqIP8Ii3555pA0iNlR7EVVxtMb1WsN783cyKeU
         xx1M8NoXk7lYTt7Ew8KKW4/hq9l+UhLkf5TBDftMQV6GnEwlMHQVR9r4AnkMut+9maNg
         b4bzeeKWYF+PUhqYPitQXAXvUElaDIBSotk1ns2vbV0YodEQVDduH7J6B4BzCN4qsxcu
         0SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551820; x=1770156620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2igPjrmSmxOZqXAz/2IGESBsIQPmX2WXNrQd96+8pbE=;
        b=hCAQ9269yvR+stUjztoRSZQpc4JfR8Am8AKct8bylRElt5Oz69yEBXzcfl/ZEooVwA
         HvbMSM7RJkN3l9pHJtYpQ8aPOADgHsDOoQlX5+VRJY6whKtz59U5/t+igF5TVOZlqTny
         ArZgKrTbrn2faf9Gb9LBP3fQzvpmOclGCYNOiIql9vzFOQhDgaaKabmFsiQ5/LKRYHYx
         ODBcxNoG2ouvUg01NilKZxp8mvbUJVjDgvvx3lcq+yehTF6HQctSW1SCik8bg9zPbZM2
         1EE+SHIChWqPn7eshMvNOenlwj85HqAgU5/KFrAxPTh7FKj4f/QEg0rpO/HBM9Wl4XN9
         3igQ==
X-Gm-Message-State: AOJu0Yy7IfBa4oRB0Xzy0vrzLwA7WJyNtn3ZlztLBd3cioL0Yjxr+Qgm
	MYUkdBUTELjNssD/BymZkOi69o/8h0JHafAbeLgqczskCrznMHGJOZ187mdghoMR7zCLhtG7wRV
	6IdDD+Fnj2LesCP54WxhBHBJf6oH9bgg=
X-Gm-Gg: AZuq6aLmzoSJKGC/sHztSj9dUFgGq9YKmB6kFFn56rICca8RYIqgda8qMt3cRYSzoLm
	9t30ufFEbX2leLfoqwHaknLRDe2wW+6o6Ti4e2ICsGIBMdnlN0RkrqRS55LIdU8WkDXtHR0skCl
	FpNWvZbYCsozXdZxg1AyN1ieub2rNIKOjNYTfvC2IKhEJyUxvReaT31yzf2NNAjOPjwOxAcB9pT
	r/Ecz1yuGWVlo/QnJ+Ca+onfOKwYlchQcxfSt/plmzAasmaQcG/5qREGx0oLpgNndPaTiHE9kYG
	EXr+iy8n2J0=
X-Received: by 2002:a17:902:f684:b0:2a1:4c31:335 with SMTP id
 d9443c01a7336-2a870d64f9fmr36415125ad.26.1769551820018; Tue, 27 Jan 2026
 14:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home>
In-Reply-To: <20260126192010.4f14bcb9@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 14:10:07 -0800
X-Gm-Features: AZwV_QgAMpwdi6vnx5r9uMVQgv8akXjIQ0yBaldhR15yHy1c0U4XSXNJcMja_fY
Message-ID: <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 4:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 26 Jan 2026 16:02:10 -0800
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > So what we will need from kernel's sframe support side is just an
> > internal API to get stack trace, similar to get_perf_callchain(). But
> > it will be guaranteed to be called in a nice task context. No NMI, no
> > irq disabled, no nothing.
> >
> > This shouldn't be a problem, right?
>
> Not at all. The unwind interface already has a method to get a stack trac=
e
> at any time, but it's up to the caller to make sure it's safe to do so.
>
> See unwind_user_faultable()
>
> I guess all we need to do is add a perf API to call that?

Yep, unwind_user_faultable() should work. There is that
current->unwind_info use, so we should be careful about nested
sleepable BPF programs, but I don't think that's possible right now.

I don't really think we need another API, we should be able to call
into this directly. I'm not 100% sure on the best way to expose this
through the BPF-specific API, but that's minor.

>
> >
> > >
> > > I've been Cc'ing the BPF list (and maintainers) on the deferred stack=
 trace
> > > work and did get a few comments. But I haven't heard anything about B=
PF
> > > utilizing the feature yet. So I'm asking now if that's in the works?
> > >
> > > If not, perhaps this would be a good topic to bring up at LSFMMBPF?
> >
> > Yeah, we definitely can sync up on this during LSFMMBPF.
>
> Awesome, I was looking for an excuse to go to Croatia ;-)

heh, you are welcome ;)

>
> -- Steve
