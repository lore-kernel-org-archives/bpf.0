Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1631E854
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772771146; cv=pass; b=kl7PAQhx6rqtOhNnqWmTaPgcmCR+faEt0cVMYzA0IHOYEGP7Bc+x27qW+pcKx3ammKX2ODFo25lfHAPq6no3Ivkpn8LkK9nlIUttO+iuaq5nCi4R4a1gc28OARV89Qgvj4WyJmrTyY216OV2tQITRRoZGajhFWDc9OX6Cp/tPOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772771146; c=relaxed/simple;
	bh=IttntqNW3t9HwEWy+y7ze4n4w07EOvDdjMxr+JT4HoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c753iS88FGN3nHq+97f6QQmlaWvwpM4jABgqgUxt5sDfjor2eZ8tRw/yTvIzvFFbbtRS2opXuFq1+yp668vSXdlZDZaEoIhCs2wMXFLsA/pCozJ/bFRdyXYxde8nQM3lyr4Mhr8PppH8nxhdVhb3NDcs7WTyFsLNKiyAYrR8Kpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPxVO/cJ; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPxVO/cJ"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439ce3605ecso1040249f8f.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772771143; cv=none;
        d=google.com; s=arc-20240605;
        b=M+XBz4DJPsPT0K08ej1qizcg6Eg5obVqZFKorGZfVW8QnP1+16KDUkSc0jyGl1Umhn
         0v7C+dTb9zmlypJmpBuvkACfbF/lHAGofCa3gBRjY1imW04JAzmuMO0qjGVSyyZn/SdE
         YrJjhadHxiuwBJfklk02A4khxS2moKZuOJ4kyn6ZNeaLuT5jJkr3QA+/8p7USBh0wCIf
         BkuBCXM5Q1eMcg4R1Hsvs+gFl8sp4lQ+dQzh3iAYJHkbHzVpfgm7Y+nJ5Fpnv+No1lVh
         ASJrZ8pZfOTkN+1Qn41m9LxbZ/sBKsauXroVIfdSFOwtLvbZ6+OG4twf57/Xn8iCQn8R
         4yfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IttntqNW3t9HwEWy+y7ze4n4w07EOvDdjMxr+JT4HoA=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=EkjNDYzRdp7OtFxr7QtdOboKZdns4vReSyY5dkh3d+UaHR7DVOLWD4H47FQWZoKLI4
         EYfs+cw6liSax8wbb3xZtAbrERsO/Rj6qL8PHOW30HRZdWOWsIRcFOloAEHLxyk9ReCu
         C/p2HTRtmLj7rQkDGU79V1Dhyn9YW3sv5hpuytJVhrTnY5x5sczPDF9hPyC7KfYVC4yG
         v30W19hkuJiQ4ZGns7kad3RxAv6bwEbHlcSg83VOFurg2md8BxPV5d8MnYxzz7I10+yE
         6dR8QB8Tp0nW/GQyvf2I4k37+u4pHJzbDGEKTjg+GRKUE5STIwhJr3SlA03D8f1fzSlV
         UUOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772771143; x=1773375943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IttntqNW3t9HwEWy+y7ze4n4w07EOvDdjMxr+JT4HoA=;
        b=DPxVO/cJZqcvMTbqyPh3BRN6RbfmsXk0MVEnq7b0MQLwa5bEhcL/IsVnjRpAzQv5pw
         QcgDng0QDluGQ2PtCWCJyvllPA7sKFgqSh3nq3FpGDBuGfHcbYGOo1bMwpEASepDusFM
         cwzMjUGE0aoQssAmwnIB8Y0xO1ZgUtjxW/V84KhFHqhN3F/ZA0l0YPB8seRFVBhans39
         zQLc5zgb7232PH1QJyTUaH7fY8sffCqFFUq0mB+yjNyMWsauHhIfb4ztQbDm6EKnGHbg
         6C3Ha/D44tNRyMmY6Z76IEhm14k5Gnrvz9u0e6Spi8jtiFMLb/uywMfiioIuV2BBcMm/
         NkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772771143; x=1773375943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IttntqNW3t9HwEWy+y7ze4n4w07EOvDdjMxr+JT4HoA=;
        b=JCRjbgnIFwiERw6NG/AcdXddsFv/iKmbpvxDAkgZf00nk4ZiRJMh41XQ2GfEbej+Ee
         4km81EuRSimPNNUTPsT1JeBKF+WLfwUCdx+gfScVdsF1/aDEMKROEELO8X/SBYbKfFrZ
         RLr8Eonz8znfECRlEn+UcgZ/OVfyUE9ufPguL0SKqedA25Tli6yaxz9zCj/oSRYz9f9J
         YhryfcYyq9DpWLl4Vm01IYYErk5nkaik2kwtZVzTxplnR2DNfIK9swXTavM+umk1s8zL
         0j1PCRrNn11uf24deS9GQNQG8pfKrXy4JyQTOOEWkmpoBm5vu9EZMTtSlwyxZ9n9KW3i
         fUPQ==
X-Gm-Message-State: AOJu0YzI/zUfnVLrOfyjVXB1qKT+ItM6oTDu5cfsunPIhHM7mJleuyvG
	rIg4UAI0tiJ9uTqE6FQxLCQip8XcO0C39Z9zL+FzUcu9W1pa1lMIkVKtuzgpQpP5LK9F0FU/Z1c
	gN8X/L87ZqB2rxb2V/ZS4LIlrRKWFwT8=
X-Gm-Gg: ATEYQzyPV43RxCEgUfbPFjghY3H+TFF5dBy0Lb8B+gUBIV5JJ8yPLj5w7jyZH7jclyN
	n3YyNgKkXjh/7wAXyadeSRvJilmRA7skBWwCVBTBH0WqUVDuC4zKd4TLefjPZoOTbU/BiMwQ+er
	XvwvCPkI7RS+zVEfm1a6Qr81kuYDIZPoFqlVBcG4flcFkwuM3unUgC50Kw1xY/4Dtc8x5gHqvCU
	ABfdupQPUT5fqBIxqtG6Zop+1tqcE3zITdoc6m/sOsh7ZULPczwO2IS46EkQ49NsfAWk72edNjW
	MpWRwyBlIdYBKpriV/OCgO4TkenLB/TA+UpmSv867cceIYnB0WOHywn45VY=
X-Received: by 2002:a05:6000:1785:b0:439:af25:e4ea with SMTP id
 ffacd0b85a97d-439da66c26fmr1090160f8f.25.1772771143256; Thu, 05 Mar 2026
 20:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com> <20260225-sleepable_tracepoints-v2-3-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-3-0330dafd650f@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 05:25:07 +0100
X-Gm-Features: AaiRm50FZYnYGXmhkKwkjaN56C12gsss4esrsIR_cN0WGN9c57YNE_ysPkwECFA
Message-ID: <CAP01T77_Poa+JNksps7Tf7Z78TvGX6+7xSZxWY8FLm5KuCAyXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Remove preempt_disable from
 faultable tracepoint BPF callbacks
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 17:25, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Remove preempt_disable_notrace()/preempt_enable_notrace() from
> __BPF_DECLARE_TRACE_SYSCALL, the BPF probe callback wrapper for
> faultable (syscall) tracepoints.
>
> The preemption management is now handled inside __bpf_trace_run()
> on a per-program basis: migrate_disable() for sleepable programs,
> rcu_read_lock() (which implies preempt-off in non-PREEMPT_RCU
> configs) for non-sleepable programs. This allows sleepable BPF
> programs to actually sleep when attached to faultable tracepoints.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
