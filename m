Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510D1DDC2B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127892; cv=none; b=FfHrSmw6AYA+533X5fRVJLPIcSbrJ6fGdMYbgBv18ni+egRUibILORzeOKtJsiq92/iGKKs7MdIzQDznbXtGIgctavdRIc1aRQKy9dhn7MDEd2MLYvkON8H4pyhytpyb10cUyLm4m8nJxg5gfwkg62LSKTpOp77yPQKKr9wlPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127892; c=relaxed/simple;
	bh=VoLu55M4eHzoCFOQCYpm32Gnh0UNHqCysGgrOufBfPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmZ2SXcKR0GlZrSWvGaMXiSseUqvu6ON6jLPEEr7hfzPW8Vj5a7nKkwB0thNF/QRUeT/mFopkVqlTSmq2qJQP9LsqufmxBfQoBFmTCk6U8NAl/DVRuk3On1QAhyrobQDthu48jEyDwOTTqeozvaRw4/MHdlUC8as/z5dSnTvzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=MOTcuqVN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlgBYPum; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MOTcuqVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlgBYPum"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCDD77A025C;
	Mon, 27 Jul 2026 00:51:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 27 Jul 2026 00:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785127889; x=1785214289; bh=Ig5JDyqJW0
	m29EiI+eTcZraJzQOeE8lxvivV9zinQxg=; b=MOTcuqVNdUmT9WJQ2S4ZpcIFdX
	l9j6u2zKfnFOs5OuCdlH5WutjBuvJ5ZwhVxhRab3aEBZfH4EsBNEbjEJXwso/MTt
	1O5fvVnh/Fpyx8FWPTWUlH0fF/6uBHiY5qYzkVeneurI9p6uhM67aDsDnm4FJC9o
	OsoLutRN5Jv0KdlSMwuC0tbxz/ThDEI0sK1zHCvtBvGv0pCoZmDYQi94gw+1eqnE
	soL/5gH7SV9BYUGJK5oncvRB0dMEEsgTcGA1ZEfS01dWRS2vJSRmXYIe0idJnolP
	upxZFW1pDE4Tf31Go9Nbq83GE2xKvMa5ENqXtrjXVatnxgRGlpkmIdTDkmDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785127889; x=1785214289; bh=Ig5JDyqJW0m29EiI+eTcZraJzQOeE8lxviv
	V9zinQxg=; b=TlgBYPumB3b5EneOrt0Pd2VeWfBLbWGZ3yLK6cFAVLht22lmDf6
	04uMrUEVmFVj/HQLij1/gaeiptCjRs3O0ULHChYZyvqT/oz84ngTKDOaIl7WZFBa
	aOGQF6KLgvo7sU66E5jmkkBENE79hzzMikdo7uYxeO3P8+e5iCvyCJ8RE8jWXbDW
	KzNTRn0sBfwdkS4Fo+nwVOq5hmQtMWy7nWSa6gBaO6ZvBIEX/HSdUC/noseqcZoH
	++7gFUmFyBB0+xFXtC1dVZhtpYgf2iZHnM5OLfxABBkbexXl6GM3dtUcKogrF9/p
	bcp30iZadRW9rmGZLMTKolPZlN5XNpATQgg==
X-ME-Sender: <xms:0eNmagpJ3rr0yBak8hiTVCdGcivmtnaySGfRg0PoHqOXi-Jz5_PB6g>
    <xme:0eNmainUwJDPKGTAQK-cswD-g9urzYWcLevKFXKPEJ8HORAulAT3U-XoLr8p5SNdz
    60z1b41buBRdZPSruVo5mTBU-_Ck0YDyJ8Zs7D9GvjgpFqd4g>
X-ME-Received: <xmr:0eNmarXHZMfsMa8lyn5uUJTz4IvE6-NUH9MoYCxhEYFN6NhunopwETIU9ZG_6F-njkRvCBT5lobgMZchlVncLHavYw>
X-ME-Proxy-Cause: dmFkZTGcKVlw+4tuBEN7IPzbBKJNDEiEeEXVpksoLo5PJJpuaqm/ElAE1CrHpyzTfkuUvS
    MWiV61IKOGOx6IgCBf7Lt+6r8sWAwq1lU2l1YvpObSbkRxCRvtgRBztbTlTqw18q38ivIN
    QIm+onMX5605nPXxdsQUoPqGBznO+eQUE9tV/b6r63spPbBgG6pfWKpvo++MeMWLG+jnro
    zfICnurWuE8X0/G/pq0Ybj5SPOhGTs7C1iMDQAfvZ1Lf1nAqVIIJ78SWvmEaMAV9XkRNtu
    PxOzGwVYxWIEPH+23aQR9sKwHtI+6uhBWdZKqySkyyObJCHVLXHjpQKa/5uLM0oY9bPgn2
    PpiUwPTWiZl9L4V+gtuhTbo3sCzHM7ZESD4aHRNdUKDDXmHvc8ujuVc1vu87oya74u7dQP
    6l5abPihmvWtOkzp7xddmnnDCU3pg+7secrLxPIGzSBA9/ZuHsXD4SkM5Q/O/9k69z1b/k
    FsoI/LTtaAmwvyL2t3aLnWXEqlLLj9Vm5kIYen3Lw5NonX65S5wz7t1XutLfOEqLOGm5C0
    OYXX0p5kzugqYClaIBR9FNxFJXK6baQ4SQal6UuMB3D06/XMjjWDRs9XPOLA3FE9gLUC2C
    aiqbS3O7BkHzwnj1S7ikjSfRXXMmEjqujjBSliSjJrIyPxQLMvRz2+fANbWw
X-ME-Proxy: <xmx:0eNmauR-16SFds6lPdVO1V9877KJbLrSkLIAEo2scGPPF-FkWMy9mA>
    <xmx:0eNmauCRsYptt7bFVbkQYOUe_kB1nIThoKcid84jJsvTomy1CphuNg>
    <xmx:0eNmahT4Uu5In5AiAXFpuA_rG-pOfD7fMVZ4JJXANZX01L7WE70dmQ>
    <xmx:0eNmagS4RFkf1ewP3P15ayuNKy0Ix48_DQmoBUb3BMdIZ9u_Ojx4jw>
    <xmx:0eNmaqAYUa7OlIwkkPqDTtnZ5kl-qVaMBJ_pgG_BYVHuxvf-KYSrtkN4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 00:51:28 -0400 (EDT)
Date: Mon, 27 Jul 2026 06:50:04 +0200
From: Greg KH <greg@kroah.com>
To: Ning Ding <dingning04@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, davem@davemloft.net
Subject: Re: [PATCH bpf v2 1/2] bpf: Keep refcount_acquire nullable for
 borrowed RCU kptrs
Message-ID: <2026072749-refueling-bonelike-522f@gregkh>
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-2-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726235030.1152542-2-dingning04@gmail.com>

On Sun, Jul 26, 2026 at 04:50:29PM -0700, Ning Ding wrote:
> bpf_refcount_acquire() returns NULL if the object's refcount has
> reached zero.  For an RCU-loaded map kptr, another thread can replace
> the map entry and drop the last owning reference before the acquire,
> which makes the ref count drop to 0.
> 
> However, the verifier incorrectly marks the input as owning solely because it
> lacks NON_OWN_REF, and therefore treats the return value as non-NULL.
> This allows an unchecked NULL return to be passed to bpf_obj_drop(),
> which can crash the kernel.
> 
> Only treat the input as owning when it is present in the verifier's
> acquired-reference state. Add tests for owning input, checked borrowed
> RCU input, and unchecked borrowed RCU input.
> 
> Fixes: 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for non-owning refs")
> Assisted-by: Codex:gpt-5.5
> Assisted-by: ChatGPT:GPT-5.6-Thinking
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---
>  kernel/bpf/verifier.c                         |  2 +-
>  .../selftests/bpf/progs/refcounted_kptr.c     | 61 +++++++++++++++++++
>  .../bpf/progs/refcounted_kptr_fail.c          | 47 ++++++++++++++
>  3 files changed, 109 insertions(+), 1 deletion(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
