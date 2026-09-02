Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB815453A3B
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788389999; cv=pass; b=Bjn/bHIB396zNcvxrenSZLVdeaeqm+OOcl337zBBLsw854H8nHUlO19JWCL2V81tHZ3vmoqEV3x9rLGm5cCsQv8VcnxVOPTvlA20u0fAbo0Kkim/KIRtthImiRpMZy22/K4hkxCxuJ9ZX6AO6LwvBGxUgOE4aMvuHKBO3sgwNZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788389999; c=relaxed/simple;
	bh=rTXpQ+CXf0UAR98GTf9ftMHYKg5bCuE1K9GVgjgylOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJrNh24Kkhtunfi+zxyI9jdZOSV+Fl7sY/jjFuYCNyKe+QJ4lwzi+JtRJx47IecTVZ4Pyae95MbiZ2cSzR0EryCqWmk391hZsniAHgn5q84bXE+Ee52zQpfCQ5AdVOhnQtbYtXmkpeZauf/vc4Y42pmanew4udn69Kkg+DSEr2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKkvv7gP; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKkvv7gP"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-857ff9fef54so18420587b3.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 15:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788389987; cv=none;
        d=google.com; s=arc-20260327;
        b=mOYbRLBEnzafnxjuJJcRxMrupxtv5tHf/LIYbjNaKHRn9irluWcyse38NLu0lMQtQn
         BFPi+cj9y191cIUQ2WaRSG1IpLfLqNBGOn1dChOaRQxslM3atQlUzYF8qkfGjMmY3nV0
         fxOtAQ3i6BMZ7pA/Si/ePQbvv9/yXt0K1IYDdCXcvKnjBT8d9Z58pDMkCAFclEN8gPQn
         rL8/35n4xNf2lH5YA5g47uAZ/h1ZxtlKc2oURkzLZuRqZ5dDWCEJTYGu6YLlIMcug2yH
         oS+5ZK5sRgydMne4h0Ggey5WcwGW6yogXqfOzVnEmhs/8wB2uUNmPcOC6bHeX+eGYvGZ
         GhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rTXpQ+CXf0UAR98GTf9ftMHYKg5bCuE1K9GVgjgylOY=;
        fh=nKRUHx8QsMAbCNG4RvkIkcllm3zRVQl4TB18fHVE440=;
        b=RD3SME31094631zJcLtQdW5xeXBAZKFkVSuYb7jtXC1JBEuKw0h/4M3XMfZyUBhfAN
         TLRRf/fn8HDYuzgUUZ9b74X/RXHREVnN39cdU96vGwzSdMnfEkrujGkslUD/oazEldUg
         FtLRzmbDNjUMgPrbDfF8trFCGCt8hbvsHwdJZK2DNMbUhAGWPdrPMmND2dxi4yrHCN7W
         CnpRKAAowhxTiDa1fE4n21c3bydB7juUxhSZq8gSUKQqOYSoI+Vx8CjN2Igh3DZhS1BS
         pBa+b9Sy4xKFUs+57H9f+eiEqjURPFlc4fmCVNE/lsq/+Jyq93tHEe95T/cwV0szxTWb
         EvuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788389987; x=1788994787; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTXpQ+CXf0UAR98GTf9ftMHYKg5bCuE1K9GVgjgylOY=;
        b=jKkvv7gPav8QJXeGGqSsBXoBk7FgXG4TGuPxnkwQSHiJEOLfUiVzcFBapZkU1vzAUY
         mtrB3CQHE1YMUI9lkYDjlXSDjTg9UmCLDga5vdIqPMdoIsLKBVB2gBO/6VaoM3eEImuL
         A+syBtvBSL1SPttC3kiaVPhWm8fk9e30N1RXCVodv32jdsEN3gVOaRCk3ihGFjzI1N+4
         tgGxQE1BT7X8r7n2ARURXaTUX0QJH3twr9bTb9xIDYjKkSnOzhRG+cBi/xQRgdEdkPj9
         VU+QJ1/2n2okw7ya8tsUVwLaD96bPUEGRBlVDb4CzRCXKlx3Jf9sQ4oEbWEw5GBDIH5A
         1mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788389987; x=1788994787;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rTXpQ+CXf0UAR98GTf9ftMHYKg5bCuE1K9GVgjgylOY=;
        b=YoOBEaEwj7+bv1cjzk4djcXMXM/15a9mHlq6yOmJhhmRH1NueaKJ0dgBadtMMffbkv
         sZ+eUvJlOPun9O+52JhxTml81MZyopOz1Lz5xlzTxLNHINNyf5ldtHUykv5NOnh4ocDO
         t832JQGGqKTw14Ewg2j9DRiRRwpYSeycdZU7yYh9BhF5ob9ThB2PLowmzc2fmj7vMAl0
         kjmbwI4HE6RSbJfohyGaZtKv/TCgXcKlpkN6zXcu7O2A7wvCmpOZuUkjlEOocH5B2lJs
         UXc9bIzSw16UO/yAUte1hDBSL82zyegv7ww8MDNjfnIRhj5EzSENmD3WtzIZHl5mpVF5
         5WWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN3U8xNsml8RqsMWyRZ5xiZ6o6wOAiFcYciWKR7Noa+kL1B5zksraP3P5L+w1Ih6BuXdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mxprWAnGZFP0p6olZsqSLzTRGIusVRtsBOAlIgDy3LgyanuZH2
	eeaX4sDHdd77zpiiFeC9MsaipVFeGu9gwIde4qIwclBIyvVcqo/nj+fIYRGvgW8jKYUAc0gXk3j
	Vza3xkvV0MZKN8AWO13S3iaZQ9bttPC0A0R7Z
X-Gm-Gg: AYBFou2t6npOFKEb+z1ytDiRqcBpMcEav7e3mcwJcUNkirr9DSCntknZiU+T9qIYP9G
	3A5/NjqY161GJTvmE7HygHO2k6XJoil9ZXnBghNYm4Ip+ZxUjCz/Eb+JGY1fFH6yLEi8yV5sFZd
	p7zuShjOJ6MUe7lkLMHXfIUk2m1rXU0a2ftqo4Bczgep9DysBXeMSBSmhfxawdXG/Q5/s81EP9j
	Iro95knO3l49K2o1/+kfbMT2eZ52JR2YUD/G8/T6zuqU1unMcbBFTld+eKtaj5RzghEThazDfkR
	pkk0oFEpzOK9oFsl+z6HJn0/3vPiMkawIFm3AZiv518JsbAi1Vlss/SnplziPVwRpUBnsj902F8
	H9L7/sXJgi5bYHOxrTi0zlK066ZcYellZcs7/0kWgCPuR0xvZbfdUlfuNFJF/P16xvBwulHHNnc
	bevHElasGShWNba4hzB0JdBWY=
X-Received: by 2002:a05:690c:399:b0:85b:946f:129e with SMTP id
 00721157ae682-86c54b1dc48mr34415577b3.33.1788389986727; Wed, 02 Sep 2026
 15:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DKYH3KM93BDY.1MR4WLZSWGEU8@gmail.com> <CAE5sdEiGA+chRkkNGOWL89AFDNXor1RKHMEmouCNoCXVd4fc-g@mail.gmail.com>
 <d4e2ae332a9505cc2cee5a236ff86efb@oss.cyber.gouv.fr> <CAE5sdEg1eMs1Rip2mbCV570p0==2gj7ZtH8CttPfsqcM2CrB0Q@mail.gmail.com>
In-Reply-To: <CAE5sdEg1eMs1Rip2mbCV570p0==2gj7ZtH8CttPfsqcM2CrB0Q@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 2 Sep 2026 15:59:36 -0700
X-Gm-Features: AcwNN1VCmzOwcWIZyaonAOUF1fh45Tj69mMYftlMVQbdIt0yPBMMErZSHvWRTbQ
Message-ID: <CAE5sdEhfsv0FgdAjn0h0O74voyZpsKyHrjE56SZ5EeTb30-02w@mail.gmail.com>
Subject: Re: [BUG] bpf: x86 timed may_goto corrupts private-stack JIT state
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org, 
	rlmenge@gmail.com, hargar@microsoft.com, apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 10:42, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
<SNIP>
> > > Jeremy,
> > >
> > > I just wanted to check whether you're working on a patch for this. if
> > > not, I'd be happy to take a look.
> >
> > Hello,
> >
> > No, not at the moment.
> > Feel free to ask if I can be of some help
> >
>
> Let me playaorund with it. I'll let you know if I have more questions. Thanks!
>

I have a question for the maintainers - the fix involves changes to
all the arch specific trampolines `arch/*/net/bpf_timed_may_goto.S`.

Is it fine if I include all of them in a single patchset?

<SNIP>
