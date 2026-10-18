Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1445038
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792283718; cv=none; b=rYkzBgk/wLDdO497lasMqlqJ5p6KPqKkqJqBgGvTEQs2RicNza4BO3jPTgJ9Bgkyp+WK8f2i4KXfUM5Epr6r11K3pDpkxkuqpXKE0Ud0Z/O2aU9qa2AsIZB3keJCK+WH3WxdPzdSlqWnSeJmEv4CAY1rVqz16xief7lpedhLbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792283718; c=relaxed/simple;
	bh=hfjTc2+7mRLA4lbE+4kOi9bthGB0Crc//S5N1v+8APY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=QbN7AflEqbfE1sBSskapwjSCWwIUHpueXjbZCDcGCu7MHkkEbuLu5houSLd6lh1BI1S8AIT27+3jrk3OALeYQQiax2Qg5NGEy/j6+2fap6jIS4EdRFKUAl7R33f8ru9kpTDiefxIVWppb2Vm89RGoJ23PdRGh0DN+C05qPNCjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzE9NVYS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzE9NVYS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e812e2b31bso5008975ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 17:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792283717; x=1792888517; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EH0gDvSzc6w/u1uhbFkTvLvSWpp8Ypw96bljv6WuNF0=;
        b=QzE9NVYSUvm/wvJSGbAu7CZWKF2axYikrTyhj8rjKO2kMyTZVKj67V95F/drpYdZBR
         aLmyYOHH//eT8GDqYwczvezQ1Hdp7Kx/wINArXHW1uaRRIt04UoN9uu3Z40gBcoRN/M1
         a/5OvBOcHu08FlTIZVWaba/Q7majAiE9PCq93ApnkcAUD7Hlp2Te04cCgMVQtzeJcbwa
         1k1RWbflBAh/teQFn5pQfxJMRcVm1dt5CZ/71MAONoKKg8CRtzsGnOZdkjXDvG6VlhdG
         IqsL+KnXN0YR5kXT9U1tR4y77nmcvwBH1cousdCdU0n9/mdTGhF297+nKStl24edXW8h
         qOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792283717; x=1792888517;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EH0gDvSzc6w/u1uhbFkTvLvSWpp8Ypw96bljv6WuNF0=;
        b=gXw9cP67BgPRbBgcmAfW8rEk2GungqZGF525ZlsbfACviAi1PEVanogNdPQfhRc0sD
         sxnqhout1U7Zy/cS5xIKTtlK/ySgPoGNRzMOMSqkc3WaKrFXawoq2n7uJZ2X0qOferXU
         /xz8e8Weg4Fnr/tcmBk3pTHKvtlDWxnuDmuP5w/TyRYCcC7Zeho6asuwWPUYNbrXEbXk
         alITPQkpQZriQ8qYb1oyYH5t7j7XXP42jj11bkUgb1Z9qpNtNwUHawmMkBpr1KsMPAqo
         mNEkaWK4n/W52tD1ZDz8/WG8KTznZi/JLfyeOvQI3c4iyVAySzjA2siO2uJM9h5HYaEg
         AJew==
X-Forwarded-Encrypted: i=1; AKwUvBy/uhpCNfl+YzoKjHwZgLNyHe87opRMlB5YFZBjXQNYUusURhceLETC+2dzEvtIEOPyoxM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6rl5WOUFQc7TWljAt/jCexJtf0zLSUVUJsss+q8UryzUCykXM
	A57NUWYx+DUZ487cYKVCjLcM5+CbaqmQXjfmAEIaUKFgbHtPcC+upB8fR9E7/w==
X-Gm-Gg: AYBFou1A3+t/fRUCns/gyTJS1F/MrftwJh0UTwSmA61773y7q1fI1s4nhyC/mi7YkG8
	zS7s2xj3uJz9CHU9BDF3KWylDlZfp6mOaQfT3+3DhKclAgKwQqdMO9IPno6NJ7mqIMf5HLpUK+o
	Vus8qKFmMYliPUhmQywcd9j3Ej910WTItc+0Z8ju9b7FkiCbGeWrQoGRXtHM+mpfduA7wGbyBOu
	6ZHvTBK6nXvA42bBTZ+vyBWiiGSF4+X/F1CSqXwp9SFO8xRG7VMAuscIew0sMLnF0JK7D53CpR5
	eMQVGT5RNsjz2f4MWiOi+PNfm/xOQj33cfYj0ejr4HOKtRDn36TJyXwuPyzEYLIDzZq+a5NnO9f
	ElWGr6rgtGNzRFXbdT5KpWJKTikKP8zjYRfnJ4OGCa3XNiY1oCNkElNQ7ui0KE9ljA0Ih0ug+Lu
	xU0vCLAy8mG7ulxbfZrPzuJwctnVAQy9kvaMbtOQxL4wjhgQZ4PTsWWcLytfaPyI+Y9Qxbf5ZG5
	OrHdqQQAJpm6wfV9jznBnUWzXsp0ryW889QPs5nbdW6JxDfxil1Sv66A5+8bZ6Vgd2X/8ev6FwX
	UO4=
X-Received: by 2002:a17:902:ce87:b0:2e9:9522:ed3a with SMTP id d9443c01a7336-2e9a69e7439mr35618735ad.22.1792283717022;
        Sat, 17 Oct 2026 17:35:17 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8aad3dsm24408635ad.64.2026.10.17.17.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 17:35:15 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 00:35:15 +0000
Message-Id: <DM7JJW2KF0F9.20SESIVIYNMYU@gmail.com>
Subject: Re: [PATCH bpf-next v3 11/16] bpf: Refuse the prologue for an
 extension that cannot take it
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-175849@kernel.org>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com> <20261017230950.802052-12-alexei.starovoitov@gmail.com> <sashiko-outbox-175849@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 04:29 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Could this cause a use-after-free in the caller after the extension returns,

Yes, for a target that only reads the packet. It's an old bug, not from
this patch. Reproduced on bpf-next without the series:

  BUG: KASAN: slab-use-after-free in bpf_prog_769e8c14b3a52c7a_t_read+0x386/0x404
  Read of size 1 at addr ffff888104c61e3c by task tt11/102
  Freed by task 113:
   kfree+0x161/0x500
   skb_release_data+0x2dc/0x340
   consume_skb+0xa6/0x1c0
   packet_recvmsg+0x4b3/0xa20

Two corrections though:

> skb_ensure_writable() -> pskb_expand_head(), which reallocates and frees
> skb->head while the caller still holds pointers into the old skb->head.

For a cloned skb it only drops a reference. The old head goes when the
other clone is freed, so another cpu has to do that while the caller is
still running. And the caller can only read: a target that writes
to the packet has its own prologue.

> If the target tc, lwt_xmit, or sk_skb program only reads packet data (or
> clones the skb via bpf_clone_redirect() and reloads skb->data) and calls a

bpf_clone_redirect() unclones the skb before it returns.

> and should an extension receiving a prologue also require the target function
> to have changes_pkt_data set (and set prog->aux->changes_pkt_data for
> subsequent BPF_LINK_CREATE attachments)?

That alone is too strict. It would refuse
freplace/test_pkt_write_access_subprog in fexit_bpf2bpf, which is fine:
the target writes to the packet, so the skb is uncloned at entry and
the prologue of the extension does nothing.

Will send a follow-up: refuse such an extension unless the target function
changes packet data or the target prog has the prologue, at load
and at BPF_LINK_CREATE.
