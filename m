Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEDD34AB0B
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925126; cv=none; b=pfKsvCHCwryUyqrLC+rncMOZIulfvI9tu5S2+OLMYzPN2AVL+6CoK/jFXC6qNvINQNjJkEglomSaIyDz8WR/tdjaQUrcRDMv7L/zdOdl1LWD2EMvXXVK5ULGG0SWsuNUxtCXX7ZVwKH4LX/KWSidbU/iDJplz7vUMG/MyosA86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925126; c=relaxed/simple;
	bh=nFL36VEInBxRBs34deavHFuTICMOSNOEqC2X0HTq11k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=cu/RPEDemSK4BKnanvdWRCzXR4U2+mxA7W28qpbAUOaJ524CPiM2vNHMDK5BiTe7Y3DGeqL7c9HPMk26zxiKyZwku4dFj9q+7ZgScISycrxaK0NA7bJnRuY5+D+bwPzqjTxcmfXajzX03l/W3/wsNGU8E41n/ei0r2yhTw03McI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6gDpwLI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6gDpwLI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso35062495e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925123; x=1781529923; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFL36VEInBxRBs34deavHFuTICMOSNOEqC2X0HTq11k=;
        b=i6gDpwLIo38MfIZPRzp4xLRNfEFRx1DTzgumLsVWLN5+M9uYhLrgWIvf9OauQj8fib
         pGf2NGDg12OVg4jW2see/TXUuDsvMnPsy9Rr9vqQZDYWInrUb0/0Yn4MoaG3cF4d2voZ
         OtLbPZTLHfn6q/eHUIlGTS50VmOXUhNZBqTNyLK0bg0htx2mcrN/PqAfUbkczdh+GYNN
         NGsH9z3/PPNme3w7JZbheleVeXcljXgJdOLBKN7a4m+WYEUmJ8lLb/LG9wP6gXrVNS/j
         yFyOkQYNYUPTOe9C9dRG5mmOomEbcC9V96KJUZR2t7lBSdvNC0JV8j2uIjIZ49uGaaZL
         E3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925123; x=1781529923;
        h=mime-version:content-transfer-encoding:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nFL36VEInBxRBs34deavHFuTICMOSNOEqC2X0HTq11k=;
        b=AA0iHhiD+NfSGlLMYVtDDMzWk+Gi87wuhQZbGvK1vk7Qf2QjvAGcvNPHjPwSdurRMV
         8RVrFcHOcvSWV13UalyqeIdIyipYhkjHPtbvK/nmg1NbaVAH6EOofuhMpM/jDDmKpi6o
         oUgrxohd2boRLYWV0B73NLAKlJikRVdYKmRBC5JPIjwWWZg8KvcA/fwxwyMNGjNqr9vS
         p/5GZlk1ClbVguT65leD2nUXvfWBKPDV715+dH3owWSKWLGXeqUXOlbhOnyw9r5jVnsk
         mqsTc/1jWstk1CH3EzVstIW5AzR2uiwuM/BDmYh25QFWLWtGgE/WEYbSRR9cHkKZKPgX
         2aow==
X-Forwarded-Encrypted: i=1; AFNElJ8d+Lh5eATk6MTbSKRz3YJg4o3vKX1XecYtz3sg0XTwLDaE5xFCutxDDPvn2LgmVscmZw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7pVsp5bgyd8mmoC5nAkVYiLrT5HPX4wNJ3to6LgWoIgpAATO7
	j2JEDOtMgh3A9BzXNoVnnrztcJaXwb7zTWgUPGR2tIP+FUx4SnxvjGD1
X-Gm-Gg: Acq92OF/WXqPEmwoMcRxgsukNYs6dx1UgTb3+rZiGX9zFsKKh17Pju7VsO66cE8Vaxz
	GULvpABfdu53NuwqHOZoCAhhtRvuPZntqMzlu/wmWRgRq5BxekzXPavsKrjvlYc0L8dP/cWzEDV
	J3enLd2Hbdg4GK6GZXaQD5pHage5J8jwpwK3Wba6UQ2xbDZxORQw5vsbFHMGcEUtpuEFZVTLONU
	x5vHlhxRzczcrI8cdNox1TpjOXtDI6SHflEOnqXahQaM8uqCu71F5PilWYPISCD8t61v6CmSPLS
	zZtjnbLiBul2Xx0zQAoNaNnK0UFJGarMyXfF8VJjQxX6FLxBSaDZm5kEauBg3nNppSQIojKlBAV
	LJE58B23+nDgdGCt7CYFA65Sq/OyT3jhILiYV3hdvrvuBnYJLrZWtXcaN/FGk8Ts6b+SPLuy63R
	2JwE3OxIZ+OZEYa04S6cjSc8wouqCe7A==
X-Received: by 2002:a05:600c:4689:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-490c2c63f53mr202240725e9.0.1780925122794;
        Mon, 08 Jun 2026 06:25:22 -0700 (PDT)
Received: from [127.0.1.1] ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm404126955e9.6.2026.06.08.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:25:22 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 martin.lau@linux.dev, memxor@gmail.com
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: add arena split and fork tests
In-Reply-To: <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com>
References: <20260605115713.3224051-1-linuxoid@gmail.com>
 <d12081a0-b933-44cd-8c46-5d7b83cf0347@gmail.com>
Date: Mon, 08 Jun 2026 15:25:21 +0200
Message-ID: <178092512130.4115875.16630628542529866765@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Jun 5, 2026 at 4:31 PM Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> w=
rote:
> Two tests are quite small and share common setup. Does it make sense to
> put them into the same file, extract common function and turn them into
> 2 subtests. You can check other BPF selftests to see how to implement
> subtests.

Sounds good, will do in v3: one file with a shared setup helper and two
subtests, "split" and "fork".

Thanks,
Ruslan
