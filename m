Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA864CE0E
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524040; cv=none; b=m4KpYM+7roHANFuj73QiQnUaQva7OuQo948tGBMsgR/6StQKsvOG2nwy6LLGproBrClev14VtmD3HI5hLoHK7nQF+F4D6CG0lrBwitYMIeZIrXBnlhyiopCyzaCFpiD+HTrKgRN6Cxyu01NasLXcIsGiBsWpUUX2EpXsNSJ6i3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524040; c=relaxed/simple;
	bh=zW1RW6GM8CBpvandVLUsZHvOh+bfZo24Q7rRlPrBWN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t93ZjL0niqzKkzmXweyjpBJzFlu5rdmgqJ5XYCMo8HvOCAYMNgsqF7T10A8MrZZgyWrB9fHz2i5NcPFNkJMJ42B2wIk/GY8dSWP6ymX8da3KhfX44Cv8sp9K3hNLo60S1PhYdTDEx3nKYbNZ5Z8+TtCUYQPUmPb4HOdSJkxJBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoknpB3+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoknpB3+"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so23591487b3.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710524038; x=1711128838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zW1RW6GM8CBpvandVLUsZHvOh+bfZo24Q7rRlPrBWN0=;
        b=UoknpB3+AMmuO7KAvTwvXNf3SzOtXF1VYlryO2UoVoPnW2tRn4AmLrryAlDXweS55t
         aS1Xx+0KEEFumqH0wHksJGvO0q4kDCjQdIocWwptOaYNHwF8viSz41XxGQ4Thwtnk1EO
         SJlpGYA2kOHjagZ2FB51o4UmwYn9ccegpYYIzps5+od4TKv/s8V9s9jzAgQXr4k9NIz+
         SJpqG6jB0VVMQ1laoTH7tCIl4B6B7TMym6aHQi/1wqMZRZ/vbqKSCPwgg8Iyj3kldt/q
         +OFbbQX1vy+vQGe8NnF4Mwe8OfglZ5zQznkjGlRBeR0cSl/yXrkHYQtp74OG35CatpJE
         haaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710524038; x=1711128838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW1RW6GM8CBpvandVLUsZHvOh+bfZo24Q7rRlPrBWN0=;
        b=knUISvhiSMEtuhBAXCW5Hev/B7FgZMlQX5tWr+v26AnxqmudJ7Vetd1d/+0KS4tdcK
         6i0EtQJUqHKmDmU4ssx4U4Gkmd37iRKGraCHmosrbAhvKlBzaiQmlluT0q821uyyHyvM
         zq/S+gtnq78vHNIdPNbkEXlXF4QX0MiyO0V/e5M+n078b3vxtw9vpdxHD8MhNAYam1PV
         9RuWAqjsQs/xdnr/Ft9RVW4aC3R5iAvVbBgMtkGA7naArqs2Eo2lINRFqsDNFSd9FeGW
         HxoseLdvpKsoMNsf1sS5JXqdkKHfcqys8FFHuGUfQL6a5NyQ8qwjpfUGpbW3/Ujlri+O
         fCQg==
X-Gm-Message-State: AOJu0YyqGJnjMRzPvdK7wnW0pqhZ5ixKhZLJCcvTaXUDs5yWCvQJjCuz
	Ry5W+VeXJGPpfYfOg6sZTBn8+Es3sTf+xcQ2NFwmpnKZvlJLgjOplLCDMuzqCqOOjg==
X-Google-Smtp-Source: AGHT+IFxgCQ1Ymh7RTMQXWD/v9pxu5S2EZE0x98PfFjPfmNQVP1yNe7hV2Sl7mJynhtJKQYJ+k0nge0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:6dd4:0:b0:60a:562:d3b9 with SMTP id
 i203-20020a816dd4000000b0060a0562d3b9mr960614ywc.4.1710524037980; Fri, 15 Mar
 2024 10:33:57 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:33:56 -0700
In-Reply-To: <20240315140726.22291-2-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315140726.22291-1-tushar.vyavahare@intel.com> <20240315140726.22291-2-tushar.vyavahare@intel.com>
Message-ID: <ZfSGhI9hu_Yat9kI@google.com>
Subject: Re: [PATCH bpf-next 1/6] tools/include: add ethtool_ringparam
 definition to UAPI header
From: Stanislav Fomichev <sdf@google.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="utf-8"

On 03/15, Tushar Vyavahare wrote:
> Introduce the definition for ethtool_ringparam in the UAPI header located
> in the include directory. This is needed by the next patches as they run
> tests with various ring sizes.

Any reason not to 'cp {,tools/}include/uapi/linux/ethtool.h' instead?
Less divergence should be easier to support/understand.
