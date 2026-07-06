Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38236389DE3
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351636; cv=none; b=uuukU5C8SAOWrfFXNxirvsNt2rnqkUWUvUhAEe9RbcZz0DpLhDWqU/hO0/GQWSrERPfT3HnmozsNDxer4ysEDafOz9BXVjFIt5WSgZcko+585MRSs+hq+uyro3sFy0MqkVB+DS21XUD0ZPRUDA/0g4R1/cZdFuvyn2tYMcpXqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351636; c=relaxed/simple;
	bh=uLoqch9/c60sOgxm7nfgT7VWAe/wfBjsOiSuSTpNN38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2LRrt18PaSF9TKvSJfovBaPBhityq2ygneAL9Vj5/Cy8VRbAhb9PKSsqnzsXFhHomg3LRUSkotes5APol00zB7cdAJikM7OFmshO4jsKiqMKReb0qNGp+rdVhWJRkzXHDZPm6O7jPVFy8Pvht4NSJa4Xyb52W7U76MvjTFfh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUlCz8yg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUlCz8yg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so21208675e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351633; x=1783956433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq7K8KruM3IJOWy2HE+UaBvcH61LEV5J6OZAeJrMC/k=;
        b=OUlCz8ygJ1R5xX7Jt7uFhjUS+bUAiFbi+D4xb15lUbVhu4Q9PgWKB1T/HAGQN3t+ca
         adMmIW4GNv/i2NRyFCNSff++NFLe1yga/VBg1EAi3EpcoYoZ1H0GbkP1xDjB+1+gMptU
         lBEP00OVBjn0vR5M1wML8eCePchUgiL7uqQ/Nx1yCmU4hoSLqC0qLgqL2dbk7ZfNEXdx
         gjHdoTIJBM8NfiCVXxX8gSSxssXLFDdtqrjZGdlfFAimaVZpWaaN5eIKPGplBHB4BXOd
         zw1iWpbjRVIjfkFz5r18BzovUmL2ew7QKufZivtIKDFavAGNiMBNSeO2z0pDb2eP+XCq
         CCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351633; x=1783956433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq7K8KruM3IJOWy2HE+UaBvcH61LEV5J6OZAeJrMC/k=;
        b=dNMc/rqcs9J1S+GIxw27eaf54WbtJnodBP5MxPtjLDd5STNlVInn+hmiCMFRvsm8XK
         MHD9BEUS5t3/L4IA+sjzn0Te4UTCBjxR0uZjh683dsJ3XjMelDmcAYVAyC2WV0irI+bW
         oiQ4EQUIrUHh2gadxsyuXDIGIM/gTkEeEsVA6px28RtiNz+JgzDJCEzcvr1gbKPwAchb
         18lCy+hKl8d3roF2rfxfDbQ5nS4+5A7kaDrArDRH+8qw7Tqk/ZXg3X9cVzqigilCx7Wv
         Vuzfr6NTNKO82Z5TCFT0dnoHVBCFOTBdSWnC60PjaoDk/2oP8ZlKILBYvG7s1JeJTsFZ
         Aqew==
X-Gm-Message-State: AOJu0YyMfAZ7kw2VeTe+YfEnmwb7LW4YsbeVCaQWrwZV9X064apujNoO
	8awjOJd/t6aJscGtZQ5SGv0uWphue9dcJQ03MeMVx+y1r8kn+9jWh9w7
X-Gm-Gg: AfdE7cks4HqJhe0xqQJfmafCb+gmT4emOY69yQ1M/xeZ8qareHnzcx0KubzAm2C+V2i
	PUfFNtkLcky0ovzEBofPcAJRTbIE/DwO+V4mWWrnXa9/0nLKRgQ2CjKqxv8Kk+TGjjwrcTmBs0N
	ljvFK7TX7wwO4QIOOHzcGErg/H6TPwhdnC1ctt8t5cQAZ5UqtclflznS4MZqRbjc/1YP4kaKpZp
	PvwC1IOf+qsNzlcPEo53z1B2qX7G0qaCGlDZQBD0IBCnv6mOJiKf351FCQSFopm9V+B6R2GWblF
	tceGVHILOvt7/X+cAfBG/fKbS36bq/EXrAiHgGco5FJsvnpXxPXZcAuo1GhmK8rM8iTwwPPS4D6
	0QbbeOrcUcsUtbvJPtQ7aO5KmXAWJzPoB7j48DFFJy16gd1RkgRQDHw67nM8mY+7FZHvDOcefKz
	K1GuVJ/tZcNzK+KWksQ104p9Ku0OKvvtyDEIQeTDn93dkU
X-Received: by 2002:a05:600c:628d:b0:493:c2ac:58f with SMTP id 5b1f17b1804b1-493decbf152mr14148715e9.8.1783351633138;
        Mon, 06 Jul 2026 08:27:13 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6381e4fsm436227065e9.8.2026.07.06.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:27:12 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:27:10 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
Message-ID: <akvJTq3URZBpUTMh@gmail.com>
References: <20260706093525.13030-4-mahe.tardy@gmail.com>
 <d49e2fcbde106e80971b769793170fd479315d563d31bcaf6db33737c01c814c@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49e2fcbde106e80971b769793170fd479315d563d31bcaf6db33737c01c814c@mail.kernel.org>

On Mon, Jul 06, 2026 at 10:16:33AM +0000, bot+bpf-ci@kernel.org wrote:
> > Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
> > bpf setup program creates a ksock context and connect the socket.
> > Another syscall bpf program lookup the context and send test data.
> > The userspace harness create a network namespace and a new socket on
> > loopback, run the setup and send syscall bpf progs then check that the
> > userspace socket received the data from bpf.
> 
> This isn't a bug, but would a quick pass over the changelog wording help
> here?  A few spots read a little off:
> 
>   "One sycall" -> "One syscall"
>   "creates a ksock context and connect the socket" -> connects
>   "Another syscall bpf program lookup the context" -> looks up
>   "The userspace harness create a network namespace" -> creates

Will fix these typos in next iteration.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022

