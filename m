Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7A4F1E2
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523885; cv=none; b=FDX3781oZ5o7bidvjdzHyjLeo/5RHZ0D8in3TMHk06FrhYkBfm0ml/+Z8IMc+otZiHtYFFk2wG3WRIbDuCEIzZGekdDLl0tRzu5OqoTNMbLVLh9bi54xjnYmpg37Q88YckCckFMDnULngRek+UHISpXFWE/Mt9E36oyrq14YCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523885; c=relaxed/simple;
	bh=ilIC9BM2yQqhWG9X2H+HCWxVK4bSsmBTULVcJzoGF3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDglfunIYIum5LE+mIQVUMvMV55b3v8m8GOsTcwGoblAQeQ6Z5ZXvueu6mxwr8rZNv7WIsvFTB6WSy3J+CQDdN1F7oal8kB3sp8Xl3L54sonTr7QkhkJ14wdg/Wvf69JCBt77YEdQwYmI5iO5IOv2gNjXxcHB2VjcgaJ9f2U7t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/tdJThY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/tdJThY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a0b18e52dso26769667b3.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710523883; x=1711128683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JntK938hkUjUQ0+wrIT5v7xAL62U6PLhjlg4LijO834=;
        b=n/tdJThYLDwu28lwaLV4oE0hWHIsDphpK/iBdE+4AY78nfnFtmASPl87Ufs/u126Ie
         beX2CmwrE6SZAjpmRW/Y4A81D+UoHooDUbzTNQOSnHuIoMT3LjtH6RUGeJ1WJe32PdQ+
         a26K9EscgZByuH+QXHyM41KGS1q6/8IGkpiy/B5X8hY1D4mGTk1JrBngnWDk6+WQpIsy
         KcvFdIQwDof22uLLfE/hG1J1CM92DgwL2uAoorsPC5j83ngpxb9D0LXJG4UNC4OO3aoT
         twww2uCD2Ye5u5/eeyhJl3uTtYkDMXFgof0nizxTo16Xf51ZD5HuJ7jsYmbuIEhxvdsg
         RHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523883; x=1711128683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JntK938hkUjUQ0+wrIT5v7xAL62U6PLhjlg4LijO834=;
        b=Zbrg5B+zoFpjvztgYL85nl9zMu58GD0Al2jMIYvsM7viGKc2JEZBnrl78JHPpweMpY
         66Fvhq7Xs6zkQxJl455uRIrlVmLMqyM1Qm+mgdfLllmMVAJ6i8fPeHSFEqcHN0zGslch
         RgcFFeqss4UfuRvoGFDEEYXjCxaLQ5KPS3OVzJjxZjbblAZE2A1X34DpN0tJ2i5wTttB
         GQiNnOJOk2tzWY41a8uYpbXO70LDGe5VqBChJlA258IWykMT6EhFLMIUR7Q+gW2E2YCR
         uhwNx924FIibd+LGSO5PS7NER9hU3br42kIQS+Br51m85TdMsUIRhYtKLvtxFJy7LvIY
         0saw==
X-Gm-Message-State: AOJu0YyQh0UCT6B1tPaxR/5DyWl+1JliFW74omYAvrvTrW2BzVezTAVB
	MFASTpel7ILFZaveip6tQFbORojPwvGYpSz1X3wujDgzd0uuQbYzq+m7FQBN3hZxPw==
X-Google-Smtp-Source: AGHT+IFT8rnI651cSRBxQA7H+a8weBZ72adyXJeuA0KzV+n2SnODwMUZF/hWHDYJOzoXPhld5xk54MA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:3513:b0:60f:d74f:a5ba with SMTP id
 fq19-20020a05690c351300b0060fd74fa5bamr365205ywb.2.1710523883296; Fri, 15 Mar
 2024 10:31:23 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:31:21 -0700
In-Reply-To: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
Message-ID: <ZfSF6aNQ419Dx9yS@google.com>
Subject: Re: PF_PACKET RPS like using bpf
From: Stanislav Fomichev <sdf@google.com>
To: Alexandre Cassen <acassen@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 03/14, Alexandre Cassen wrote:
> Hello,
> 
> While implementing a large scale L2 processing soft, there is a need for
> high perf ingress handling.
> 
> In short: using BPF socket_filter prog with a hash func over ethernet
> address to distribute load across multiple PF_PACKET sockets: mainly
> filtering out non related hkey packets. It simplify userland app by using
> multiple PF_PACKET sockets in dedicated pthread.
> 
> Longer discussion + quick source code illustration here:
> 
> https://github.com/acassen/bpf-pfpacket-rps
> 
> 
> My question would be related to sockmap. I tried to figure out how to
> perform the same policing design using sockmap. And cant find my way around
> it :/ If bpf verdict prog can get socket fd from __sk_buff then it could
> drives the same hash/policing decision.
> 
> Is it possible to get socket fd from __sk_buff from sockmap verdict prog ?

Don't have an answer about sockmap, but I'd suggest you look at AF_XDP
if you want the best perf out there with raw frames.
IIRC, it just recently got a mode where you can redirect into multiple
sockets (== consumer threads):

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2863d665ea41
