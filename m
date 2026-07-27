Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CB233949;
	Mon, 27 Jul 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120099; cv=none; b=V98XKrqDpcsS2EOEmSWeCRJCqOGzhbtdQATU0QPXb71aoXBIaQ2pXGBkvHRG43sy8IlusjCTl+7ce7J4b9xeuX910+4LOUrFdAOMTzSje3LRlPYHYg29r5sGnaALjWrhDAtBMmBElMFZsNwK2W08zpfVevTrm0LUn6nHkttNVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120099; c=relaxed/simple;
	bh=0Df5WMixY8o8xPmWKlrg6APmHAxDp4zfSWgmT3miCh8=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=q2WPq/JHLONhSHQz4X/64G5OoOLtAiNSPkmOdkubxVbRgkBVzbH9Y3ibfEzA3+IlxRlQK2QkpsEQFTaCvjhc83pQCSzaRWUVFpFfaIO7tzxWH5FLLq4+7yHi2eyS95f2zotcejdhqg7PUXbab1+ahLjTyw4PRrQ8H4jauLAmTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h7jKy1pXKz1Dsx;
	Mon, 27 Jul 2026 10:32:22 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4h7jKn2Z2Kz9vSpD;
	Mon, 27 Jul 2026 10:32:13 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h7jKc2f9Hz8Xrrd;
	Mon, 27 Jul 2026 10:32:04 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 66R2VvI5049195;
	Mon, 27 Jul 2026 10:31:57 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 27 Jul 2026 10:31:58 +0800 (CST)
X-Zmail-TransId: 2af96a66c31e449-abb4b
X-Mailer: Zmail v1.0
Message-ID: <20260727103158658fTr4mVbmUdVPeIguhCrHf@zte.com.cn>
In-Reply-To: <31dc8d80-83d6-43fa-8e49-b5b9b3a6c648@linux.dev>
References: 20260726230724742Z4CDN9ntFInEofAf2YxME@zte.com.cn,31dc8d80-83d6-43fa-8e49-b5b9b3a6c648@linux.dev
Date: Mon, 27 Jul 2026 10:31:58 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <leon.hwang@linux.dev>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <leon.hwang@linux.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBicGYtbmV4dCB2Ml0gYnBmOiBMb2cgZXJyb3IgY29kZSBvbiB0cmFtcG9saW5lIHVubGluayBmYWlsdXJl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 66R2VvI5049195
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.35.20.121 unknown Mon, 27 Jul 2026 10:32:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A66C334.000/4h7jKy1pXKz1Dsx

> > Replace silent WARN_ON_ONCE with WARN_ONCE that prints the actual error
> > code from bpf_trampoline_unlink_prog(). This aids debugging of race
> > conditions during link teardown, while keeping the warning rate limited
> > to avoid log flooding.
> > 
> > This will be very helpful for speeding up trouble-shooting of some crash
> > UAF due to bpf_trampoline_unlink_prog failures.
> > 
> > No functional change intended.
> 
> Is it "No change to unlink behavior"?

Yes.

> 
> > 
> > Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > ---
> > v1->v2:
> > 1) clean the subject name by remove 'syscall' suggested by Leon Hwang
> > https://lore.kernel.org/all/20a444b2-aeed-4af8-ba76-e994e2c14087@linux.dev/
> > 2) Add up the missed case in kernel/bpf/trampoline.c:bpf_shim_tramp_link_release()
> > 
> > kernel/bpf/syscall.c    | 9 ++++++---
> >  kernel/bpf/trampoline.c | 5 ++++-
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 6db306d23b47..2348dc33abf4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3626,10 +3626,13 @@ static void bpf_tracing_link_release(struct bpf_link *link)
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
> 'if (err)' here is unnecessary.
> 
> > 
> >      bpf_trampoline_put(tr_link->trampoline);
> > 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 1a721fc4bef5..dae3c2104ed4 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -997,12 +997,15 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
> >  {
> >      struct bpf_shim_tramp_link *shim_link =
> >          container_of(link, struct bpf_shim_tramp_link, link.link);
> > +    int err;
> > 
> >      /* paired with 'shim_link->trampoline = tr' in bpf_trampoline_link_cgroup_shim */
> >      if (!shim_link->trampoline)
> >          return;
> > 
> > -    WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL));
> > +    err = bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL);
> > +    if (err)
> > +        WARN_ONCE(err, "bpf_trampoline_unlink_prog returns error: %d\n", err);
> 
> Ditto.
> 
> >      bpf_trampoline_put(shim_link->trampoline);
> >  }
> > 
> 
> Would it be better to include this multi_detach() one?
> 
>         WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
>                     NULL, &trampoline_multi_ops, data));
> 

Sure, what about moving WARNing into __bpf_trampoline_unlink_prog and then the failures of
__bpf_trampoline_unlink_prog everywhere will be logged.
