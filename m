Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76B481A8C
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709656; cv=none; b=AZSiMhHrvwRRsOmctPv8qxtUrkGJnpGmU5FVKQDVP7qMho3COn1ApHolhGurcpV3Cp9ShENMYL2vq32jYVbmcFxQcRDlcutiqr9nuTwuxX+rNzjLzbZkRA0rYqbZdSOmHDIwF5oizyTlY5cChomOPGJxqujWMR/cfnKuiVXGXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709656; c=relaxed/simple;
	bh=nRcES0nMkLOy/vc/9pqn5mJSKCcle9ew3LfE7oSlcG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQ5M5dQNou0oYdzfogX4q2212BhV43rpy407aJu/7QtbnsP4CzFlPDhPEc/nW1xJIAKED5VglGACFWxR/q7vR/JqBUND97jz7NRiiIqwVW+KCl+jalsCytUtCSmBm5ybfqhINfEGg5EAr0ZpXDpupn+FzbgEmL4HlxPeOFsV1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CtRiocVG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CtRiocVG"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so10031305a12.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781709648; x=1782314448; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z182pk1fhhv1QTpxWDEtMipQ5yYjGFFBW3oThiUmi/8=;
        b=CtRiocVGDGg+likBLYExZPS5V7cX19mHql2x/DaJoQvxcHbHTQZiZGGVIVfrtkd1oE
         ywYTuW88nYYgE/yV4d8T7JreXKNTqjwoRKSe2zPJnMEDHmaHU6CSOKn7qCGV8u2eKp0g
         tF+IX1y5wXRm+cQqweu76TdneL/BquTGZzy1Cppy1gn8qdHlmQNITrHARBACDgndXMkz
         5tHz5QjphgtDo0QkD4kMJo1Xf49TuDSLWhEUtRtYGO8HFXyS+6yPesiP69Q8HPFrhVVP
         Jy4FoA2LHHAOZ/XnCHNVdTzanS5Mn6ua7fVizaKaP4gdORxFL1f80znX+niflT47Zxx4
         G4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781709648; x=1782314448;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z182pk1fhhv1QTpxWDEtMipQ5yYjGFFBW3oThiUmi/8=;
        b=fIfqip4tVZaBuSV2mJoQiYFYUJa69zJaWS0onEn6hRYzV/H5FADsL56cgghSYHlAnn
         Q+mwMOCUKpLEncbIJYX9VAqvqsR9HmNd7nMrMZaRvH86hQItCMFV+Ct3jIvuUZbdNWtQ
         c32qUTacWIbbZdyNdL+AqK7HvR68bJLEs3ncOuZCU3cdtCzFFsthnZCEjTiea1D+BkkA
         8sNLhcs8OPvQCPWu3KTNCe0XKRcQRdPcEbfsSAPvb0TSxMCT7zdDiCoWbxiYb+JzY3+x
         vyrHtsvUm/Dk20RrazMEPFGt6rCib1OMaNcc5o8r2vQgMu8qYeg3sXVtshigd0cZUO6P
         UbaA==
X-Forwarded-Encrypted: i=1; AFNElJ/pbLPoZZeQ1GxMF1pUyaaIckl3Pa3uzSf/cgUG78Ndjoevk+bX0luXDUMmD2VvHbuzLBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT16fQgmQaeXF8S7owzACXVv9cUoqc9r1IYfKBEfA1BJyi9quM
	GWVBcqf7ccws3JFhNvwGy+EMXylHpZB81vNQ7rrIK6kblnJBryV3YN0wEXuDZZI8lhI=
X-Gm-Gg: AfdE7cmi2/IkbGqDIt2Hpnpzmu5ReTXE48SIPuXnl4LMiRNROdmw7Rz4qLk/bcwUJ/7
	1RdUItZFAeUhltf8dgTcOZoqBACmN15mjWcuajEnm/f917mDJtGLzN7HpQzDkApFSrb2fpzMoKy
	8gaWvlCKUFFNrkhNk/Hym1YGkW5SzONwlqF6Xc9+Sl6xfyFrDpnPKhmEd3WT4hkHSeUoEW4MrrM
	ceAW2nr24bXQTX7WdMLEIX30kuIQYjV/pL5FEwPPQjeYAff7wE9xqyAzN8wzUYxfMyskJuk+itB
	SR/Kw3l08bf2p717hCJdZLRZJv3rgcTOjCkjMAtZ6a2LLb15WKSfo0o147vW2qiHYSJ9JtqdvgQ
	BzcaYzqRRsAQEBTLzTVUXgx+sbtIlGUMyJ5pJ3XjX46RZ92D8u0mMsG0xaUMXWei2G2lixvRHfu
	SdmE5kgJsZ8RJXeuJyYO+6izByHA==
X-Received: by 2002:a05:6402:51d2:b0:691:2ef1:354c with SMTP id 4fb4d7f45d1cf-695474bef0amr2441184a12.27.1781709647905;
        Wed, 17 Jun 2026 08:20:47 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937949bcbfsm6575286a12.24.2026.06.17.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:20:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,  bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
In-Reply-To: <20260515104741.DF6A9C2BCB0@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Fri, 15 May 2026 10:47:40
	+0000")
References: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
	<20260515104741.DF6A9C2BCB0@smtp.kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Wed, 17 Jun 2026 17:20:46 +0200
Message-ID: <877bnxb3ch.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Circling back to this.

On Fri, May 15, 2026 at 10:47 AM GMT, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unconditionally calling `skb_metadata_clear()` in `bpf_xmit` causes a data race and corrupts metadata for cloned SKBs.
> - [High] Uninitialized memory read and metadata corruption in non-BPF encapsulations and `bpf_input`.
> --
>
> commit 2265e07ff5cfd9680de6b565a2b5679d5adafe20
> Author: Jakub Sitnicki <jakub@cloudflare.com>
>
> net: Clear skb metadata in LWT BPF xmit
>
> This commit clears the SKB metadata in the LWT BPF xmit path before
> invoking the BPF program. It aims to prevent a warning in skb_data_move()
> when bpf_skb_change_head() is called on packets with existing metadata and a
> non-matching MAC header.
>
>> Drop skb metadata in the LWT BPF xmit path, just before invoking the
>> program. Doing it late, rather than in ip[6]_finish_output2(), preserves
>> metadata for tc egress on the outgoing device when no LWT BPF program is
>> attached - the only scenario where carrying tc-layer metadata through the
>> IP output path could be meaningful. Non-BPF LWT encap types do not run
>> helpers that touch metadata, so the BPF xmit op is the only site that needs
>> the clear.
>
> Is this assumption accurate for non-BPF encapsulations and LWT_IN programs?
>
> When non-BPF encapsulations (like IPIP or SEG6) or LWT_IN programs use
> skb_push() to prepend outer headers, they shift skb->data downwards but do
> not migrate the metadata block.
>
> Because the metadata pointer is implicitly calculated as skb->data - meta_len,
> the new encapsulation header silently overwrites the original metadata memory.
> The implicit metadata pointer shifts further into the uninitialized SKB
> headroom.
>
> When the packet subsequently reaches TC egress, won't BPF programs accessing
> data_meta read uninitialized headroom memory instead of the preserved
> metadata?

I initially focused on the case where a warning is generated by
skb_data_move(). This can be triggered only from BPF LWT because the BPF
helpers have been converted to call skb_postpush_data_move() after
skb_push(), while non-BPF LWT encaps have not.

However, non-BPF LWT enaps mangle the metadata as well, as it was
pointed out. So this needs to be addressed.

>
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index f71ef82a5f3d3..d26cb9bb81893 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -284,6 +284,11 @@ static int bpf_xmit(struct sk_buff *skb)
>>  		__be16 proto = skb->protocol;
>>  		int ret;
>>  
>> +		/* LWT BPF programs cannot access skb metadata but can corrupt
>> +		 * it with helpers that operate on skb headroom. Drop it.
>> +		 */
>> +		skb_metadata_clear(skb);
>
> Since bpf_xmit() operates in the LWT IP output path which frequently processes
> cloned SKBs (e.g., from multicast forwarding or TCP retransmits), is it safe
> to call skb_metadata_clear() here without unsharing the SKB?
>
> skb_metadata_clear() directly modifies skb_shinfo(skb)->meta_len. For cloned
> SKBs, the skb_shinfo structure is shared across all clones. Modifying it
> without gaining exclusive ownership first (such as via skb_unclone()) will
> silently zero out the metadata length for all other clones of the same
> packet, causing them to unexpectedly lose their metadata when processed on
> concurrent, unrelated network paths.

This is not an issue because:

1. Only RX-originated skbs can carry metadata.
2. RX-originated skbs must be forwarded (routed) to hit LWT.
3. ip_forward() will skb_cow() the packet to unclone it before LWT..

>
>> +
>>  		ret = run_lwt_bpf(skb, &bpf->xmit, dst, CAN_REDIRECT);
>>  		switch (ret) {
>>  		case BPF_OK:
