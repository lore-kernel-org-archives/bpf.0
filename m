Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF773393
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712277267; cv=none; b=e1OvcfDzpjo071HCnctbx1OKW1x95CjM/7+AKJ8l4sC9w1FE6dCb7k+OM8ijjXGXFbZdZwjRddf3vTmP2m00nUTXDnP2vx6ahamIenqhpFxu2E4PYTLE515js2OgPW5rKSqkrWKNSO7rYFrXonb2IBd7jfwpH6o+lf9EAeyGhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712277267; c=relaxed/simple;
	bh=MtJKf5WBBAlr3RTdgNEIWJJyhIEJiFwEMGcA1aGQi84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUpxd/iu4qsnqPI0XZAUxj2i3okFXS8XZTCl8tNwvnUmrIUHehy/OEOqtSSfQcK7U7dXOgrtuGMZ8Wa1hxtfCCt+aeCyDvQGyiG+fxNsnxayfdCbukCTHaV3BYz6W20At1z+mKhIoSuZwUYya6Vz9dDRNSYChWKTpdqvLeOvypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQ27+cMO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQ27+cMO"
Message-ID: <38bfc363-84fc-40db-9f99-c0654a68617f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712277263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtJKf5WBBAlr3RTdgNEIWJJyhIEJiFwEMGcA1aGQi84=;
	b=mQ27+cMO+yw11u3xpfzWRLhQHNrlqH7iLet27TR/rhbYfHo0wIKeb9NB29+hmVVIWTJxEv
	TX+WLdm7gilJoG431rwVL3gElSxn/lPNDutbT65xH5ZO1EnHtGjmwsk9Xi22ejQpN/x9r8
	MbOR57x0beFf8aIah5LBdG7bjNuz1Rg=
Date: Thu, 4 Apr 2024 17:34:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: prevent r10 register from being
 marked as precise
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com,
 syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
References: <20240404214536.3551295-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240404214536.3551295-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 2:45 PM, Andrii Nakryiko wrote:
> r10 is a special register that is not under BPF program's control and is
> always effectively precise. The rest of precision logic assumes that
> only r0-r9 SCALAR registers are marked as precise, so prevent r10 from
> being marked precise.
>
> This can happen due to signed cast instruction allowing to do something
> like `r0 = (s8)r10;`, which later, if r0 needs to be precise, would lead
> to an attempt to mark r10 as precise.
>
> Prevent this with an extra check during instruction backtracking.
>
> Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
> Reported-by: syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

