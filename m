Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BB1B4F0A
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785079623; cv=none; b=Yl7hf/sRGjSPFY73U/8Z5egSe0oUft9ZgB8ZmiddMnluXfWOW6Opr/lPZGbB2XavScl2Tbj8qo9CT2OlSwYA8it2xgL/AjBG72E8iKWZFsW0Dabq85mECa0oMUlY3DGAxIZqgULHwAIMXzELN0XiTkTT9su2q1jGYV43ENZEz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785079623; c=relaxed/simple;
	bh=V+E0p2/P7/e3UbY8xBtFZF/rq/8lhOoBU8GkQT3Vfwg=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=BiUiYiXMdx/o83rYFNC0eH15t6C5aInJ/RuAJ727kZXZkCUoUMWpbNBsTOUkpq/a3mbDO1WdL928Ecv4kWIYmAq7qtRLWcD6hVseT0EdE+Rwmk9eavU2jyK5smyza4Ltcn0v2kal1weIvk6r9bD/X+qu//wP335M5h6hL75Ru2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h7QZC1kWJz5BNRf;
	Sun, 26 Jul 2026 23:26:59 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 66QFQo0g042661;
	Sun, 26 Jul 2026 23:26:50 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 26 Jul 2026 23:26:52 +0800 (CST)
X-Zmail-TransId: 2afa6a66273c781-1011d
X-Mailer: Zmail v1.0
Message-ID: <20260726232652148weP__aGeUXMQpolrgR-vT@zte.com.cn>
In-Reply-To: <20260726151922.C9F3B1F000E9@smtp.kernel.org>
References: 20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn,20260726151922.C9F3B1F000E9@smtp.kernel.org
Date: Sun, 26 Jul 2026 23:26:52 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <sashiko-bot@kernel.org>, <ast@kernel.org>
Cc: <bpf@vger.kernel.org>, <yonghong.song@linux.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBicGYtbmV4dCB2Ml0gYnBmOiBMb2cgZXJyb3IgY29kZSBvbiB0cmFtcG9saW5lIHVubGluayBmYWlsdXJl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66QFQo0g042661
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 26 Jul 2026 23:26:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A662743.000/4h7QZC1kWJz5BNRf

> Pre-existing issues:
> - [High] Use-After-Free due to flawed teardown design when bpf_trampoline_unlink_prog fails
> --
> 
> --- Patch [1]: [PATCH bpf-next v2] bpf: Log error code on trampoline unlink failure ---
> commit 8f743682724c96c3eba346cdcf6a1a3646dc28bd
> Author: xu xin <xu.xin16@zte.com.cn>
> 
> bpf: Log error code on trampoline unlink failure
> 
> Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> code from bpf_trampoline_unlink_prog(). This aids debugging of race
> conditions during link teardown.
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 0ff9e3aa293d5..9cbe00bc8d051 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3547,10 +3547,13 @@ static void bpf_tracing_link_release(struct bpf_link *link)
> >  {
> >      struct bpf_tracing_link *tr_link =
> >          container_of(link, struct bpf_tracing_link, link.link);
> > +    int err;
> >  
> > -    WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
> > -                        tr_link->trampoline,
> > -                        tr_link->tgt_prog));
> > +    err = bpf_trampoline_unlink_prog(&tr_link->link.node,
> > +                    tr_link->trampoline,
> > +                    tr_link->tgt_prog);
> > +    if (err)
> > +        WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this error path lead to a
> Use-After-Free?
> 
> If bpf_trampoline_unlink_prog() fails (for example, due to a memory allocation
> failure in bpf_tramp_image_alloc() during bpf_trampoline_update()), the caller
> logs the error here but continues the teardown process.
> 
> Because the update failed, the old active trampoline image remains registered 
> with ftrace or direct calls. However, the link teardown will unconditionally 
> free the linked BPF program:

the memory allocation failure case was discussed in previous thead, which seems
to be not a big problem [1]. So just ignoring this question.

[1] https://lore.kernel.org/all/9e36407a-22fb-0fc1-b147-ebdc12ea0823@meta.com/
