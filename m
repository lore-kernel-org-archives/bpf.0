Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201163B38BB;
	Thu, 30 Jul 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393559; cv=none; b=gMU08EwfEumkUzcq/krfGzNu/d06cC0v7Al5E08q/FfZxrF4Rn9uy1RrVB7pJdpB+sk0WCLseE3TjM+9aschmA3LKkYpJloDmGCzm4+gD+9yv7A5wVbWyEpynDNElLICtcM0UOHLvsZR2dd8nr2cuDszjSrvAp/BTGNingRCPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393559; c=relaxed/simple;
	bh=6DqELX+MweOTJNVaNV1oF07l0kj26tzU45SQ689gWI4=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=JndvfbCGqBAf5IGa+E5BWWl7Lurjqogs/u3P4MGpJ4JgI0FbWj0uzKNSSGMn4oZcaXh1OQuGMnzgr6F9MyMhGlXrD0kbrN5IUpSj5vSfMMsHwA3Uxw8tFEuGewPKm3DRWxEsq5ovYNCGZOWeG9Vmub6ZyWKwZPTN9FcmpWP0Ilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h9fgJ3kq8z8Xrrc;
	Thu, 30 Jul 2026 14:39:08 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 66U6d4v7053802;
	Thu, 30 Jul 2026 14:39:04 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 30 Jul 2026 14:39:05 +0800 (CST)
X-Zmail-TransId: 2afa6a6af1898f5-078b2
X-Mailer: Zmail v1.0
Message-ID: <20260730143905941QHCMi9dEpucvIiQP469PE@zte.com.cn>
In-Reply-To: <DKBP0J41TSLU.1V96E2XEEIOOA@etsalapatis.com>
References: 20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn,DKBP0J41TSLU.1V96E2XEEIOOA@etsalapatis.com
Date: Thu, 30 Jul 2026 14:39:05 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <emil@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBicGYtbmV4dCB2NF0gYnBmOiBsb2cgZXJyb3IgY29kZSBvbiB0cmFtcG9saW5lIHVubGluayBmYWlsdXJlwqA=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66U6d4v7053802
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 30 Jul 2026 14:39:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6AF18C.000/4h9fgJ3kq8z8Xrrc

> >
> > Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> > code from bpf_trampoline_unlink_prog(). This aids debugging of race
> > conditions during link teardown, while keeping the warning rate limited
> > to avoid log flooding.
> >
> > This will be very helpful for speeding up trouble-shooting of some crash
> > UAF due to bpf_trampoline_unlink_prog failures.
> >
> > No change to unlink behavior.
> >
> > Signed-off-by: Xu Xin <xu.xin16@zte.com.cn>
> > Acked-by: Leon Hwang <leon.hwang@linux.dev>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> The Sashiko concern seems valid, please let me know if you are
> planning on looking into it otherwise I can take a look.

It was discussed in previous thread, but the conclusion seems to be "let it go".

Not sure how to deal with it. Do you have any idea ?
