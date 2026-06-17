Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69A3BA23F
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685759; cv=none; b=UR80DyJ8aKQTOCmTBiLH+Yl9mYAsvBehM0S8SPiz+GRoxR4Mh7KHNHDnCgWqEQExDbtgwmOl8itk39X+C58mP3z4NwrsleJdx9znwQv3d1eb7vV1YddM3q38ErVURw43Tyvh6rVywuLInlYnKXZcPAtOi08T8nw25FUL4UzplFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685759; c=relaxed/simple;
	bh=EtJppxe4EGo4uM3lpogOdt9EZSEjdt8jky7Ns4VMjo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJlmlJq8viabxZw95UpzT0Aj9GMrrKITo7a68h7SOY3oOkOMyqSICLTL0hvgow3vVDpA8Fp+My2QzLULDQaiV00j1PcRc0KRoSAQcvqX9gp2UoPSbZdVuko9crguQK7fLDi5qFHc7kkx6CV7vWniQekjocV4d/3aHB4ECT6veDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dxNWWZvK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dxNWWZvK"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ad4a5647e5so332790e87.3
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781685755; x=1782290555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D91uuhxz2PZm7lAfuFEXxuL7CaIWSPf/wlrqYzCILsg=;
        b=dxNWWZvKUqF3UUv7nG7111KvHL2BD0PxLXpF5Uda2s5L/jYnisfhjgnDUWA3xxfMu5
         tqIbfDaCU6tGJ10jOAEiIZRmSLAkBNEw5953+mc1OgOr3jw7diErIREJ5TWbJMifSNTj
         MLO8lT7b3zrLZXx5xm3KnjyQTCkyWZQg42qVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781685755; x=1782290555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D91uuhxz2PZm7lAfuFEXxuL7CaIWSPf/wlrqYzCILsg=;
        b=jxQpv9QBFoS/0J5Czf+Mc2NuavOnzajff9FimJUhT2jRATrwKfXAP166xvPvbc1UNn
         iUPjVxnpjxK6NhRH31w+QDTLRF3m6x/FByl3T/X/Mgyxft3/NdzT+Uhuk/0uIZ+qVj2O
         LRl59bXJmbAxKqkdBgr6pculTfMuAe2CUUJvckheyxb4u/hcyGyJq7VYkzSHyQrgILHr
         oyD76TmfbUCfN6Q6u16bWscGvVOUv+miIFhS4UwQ4lfxMHqzJJFqWLvsv5iB3zGSQOky
         hvBy3S7/wiNvtpoqk2KfDYIhR8Mk1BX4kklHRLpQmJys6a6UZAH8XspGbDxXaCVucp7g
         AShg==
X-Gm-Message-State: AOJu0YyxAvxLBeC5f9AWTjYkSQk4HpDQcEy4TgNv5/kRsAbwW0mv6A7W
	FjTbUC7yszQLHUadVmoO9qoLUtxXWC2jsGjcDwyzKXis/WyCx7S0IMSxhJo6gNvPFF/v9kYcVzT
	W5szi2YdVpw==
X-Gm-Gg: Acq92OFEGcK4VrqQivh8Q4KBwqq5/zjHsId/UQRzc9JSIc2/wpy6nXSZbxtccLyCG2G
	9Enj3+zRTmRGmkyHZQkYWBjhSnsoeHYP4aM2R8/qO8MulU7ePgFJwt7Pw16Inru4BbdU1NjL65f
	+75d+jpDzzu+kjxlPRGbAhiid154MOIJdNiCM1r/YNzxPS80UiFs+BOVuxPenlWIlkrp7RzVHSm
	Xp2Dyp9ccAapVz5KnWyTSeJtVMPPxifxiVScfzWl7e9qqlTOh/umOm25JyYpZuLXsNKPOALD7nJ
	J0zaV1NCkjR0ABwurFCYdOLRZ3JJaPHvEZdvhypWCVsVMdYAOVPopcad9cH6QipvtXEwwZsf1Dx
	gYfFhyXAEorpbW1xxeMAXrWtz6lXYORCcaRRqcO5NInDFUaVIz5ju0NPUNu1RtAKL0/mP8hWulZ
	OkFQPuudkvOgNDpvewu1W8OuwuZ/l7xRtKV5bLFTItePc10yGoaX50rXtqpTDINw==
X-Received: by 2002:a05:6512:3a8c:b0:5aa:8822:c946 with SMTP id 2adb3069b0e04-5ad4700c4a6mr939598e87.48.1781685755046;
        Wed, 17 Jun 2026 01:42:35 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a734csm4250136e87.40.2026.06.17.01.42.34
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 01:42:34 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa63628d26so5472863e87.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 01:42:34 -0700 (PDT)
X-Received: by 2002:a17:906:9fc9:b0:c03:a6aa:2aad with SMTP id
 a640c23a62f3a-c05a73b04f6mr188485366b.38.1781685444673; Wed, 17 Jun 2026
 01:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260615180858.15938-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jun 2026 14:07:07 +0530
X-Gmail-Original-Message-ID: <CAHk-=wjAVP3uu1inFqxeGmk5bTJqm204kxcWu8zzDGFNOh=Q7A@mail.gmail.com>
X-Gm-Features: AVVi8CfXG6jE8eJI8eyk9knIm0x4GaFMXbx617TwBUK2cdXfHNw3e9fhBZyifxY
Message-ID: <CAHk-=wjAVP3uu1inFqxeGmk5bTJqm204kxcWu8zzDGFNOh=Q7A@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 7.2
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Yiming Qian <yimingqian591@gmail.com>, Zhang Cen <rollkingzzc@gmail.com>, 
	Han Guidong <2045gemini@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	memxor@gmail.com, eddyz87@gmail.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jun 2026 at 19:09, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> There are two conflicts:

Actually, since I ended up doing things a bit out of order and did the
networking pull first, there were three conflicts, and while the two
you mentioned were trivial, the one to net/core/filter.c was a bit
different. Both networking and bpf had done "make sure to preserve the
sg.copy" bits, but done it quite differently.

And I think bpf did some things better, and the networking tree did
other things better, so my resolution is actually a mix of the two.

bpf had nicely named helper functions.

And the networking version used __assign_bit() instead of duplicating that

    if (set)
          set_bit
    else
          clear_bit

pattern.

So my resolution is to take a bit from column A, and a bit from column B.

And the networking tree had a case of clearing the sg.copy fields (in
bpf_msg_pull_data()) that the bpf tree didn't have at all - but I took
the nicer helper function from the bpf side.

Did I get everything right? It _looks_ right to me, and better than
either side on their own. But mistakes happen. Please check out my
resolution and send me fixes from whatever I may have messed up.

It doesn't help that I did this on my laptop while traveling - I hate
not having my big monitors and better test build environment, but I
tried to be careful, and it builds for me in my limited test
environment.

Please give it a good once-over - I've cc'd everybody involved on both
sides of the conflicting changes.

                Linus
