Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFD468C14
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438556; cv=pass; b=POUKLTb1N31uske75j9bR5YKC12WPwIamfcpilxvb/ifOJXGUng/TxTFmlRErAneJmkTejm1Gqo5UeFIPCdFogTpu1au0SVarQ3BmnT3uoPgqUNF5Dmfm2qikP06nIPXjamEwnNpRC8lohPJc52NTubK8iKbD8Z+aHrKtimL3y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438556; c=relaxed/simple;
	bh=v0u4alOrwq5rTIgb2VMXyJVDRLR5K6pdRFLGd6pBE08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdivSXdKK27ns8uls+fNQCQzvM9g3cTgA2xJ0+R+bb5BGAOtV+5klvWPFp4arCDE5C5U9P3GcdrJyvGLAXpgYAwfEsLjnw6aYYh06APHSfR8Bmh0f8lBxEqfDiygotVElPhmKiefyBKMyXNQR931e5oeAC3gtkbhse4rKC+ZWTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhZDEtfN; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhZDEtfN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so120360a12.2
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 12:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785438545; cv=none;
        d=google.com; s=arc-20260327;
        b=ZA6fofipvesiV6nZSmEKeMHDOXfnIgy0Je1mlD0MqovWlbt4VzTq2VZWsI23HHYYWl
         FHHaDQ5IskeLxlih2wzEY7pVOpLN2aviz2r7s7EwIBaywVKJ9P26/SRP1pD7aUdOCzZG
         9R7LLoW6Rg/zaDZ3aAgXwxYxxL6BttsC0DeLeIG2cKSKfVq30N/pii6RDhfXq2GQ/Nnu
         bXOeBP43zoHxyPSycLwAVitg8CeOlS/AH4YHzScXnRyt2nOdgHK1U0qTcfLwsp2Nvcsg
         lNRUz0qubuCAtFhkbveqBUchvqp18ki2HMmBkYKW2J+/W1bFwcIcu7Sf15m4UgJqfRbe
         nnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0u4alOrwq5rTIgb2VMXyJVDRLR5K6pdRFLGd6pBE08=;
        fh=/adD2kRSRK62LOmMYTlPn6jdFjHgpAzJIgFs5FBaZz8=;
        b=QT9UeRrDjAgLPMfQ2oV3Uy5VfMT4ocmvWklYNeH+R+ukmltH5AskrTVdv/R16eIUg5
         rzBFHRXMZyiD7589fWnGN6CDNZwb8pLCiZjRosJslWpRwfSf2SDN8iU41UqKlM8vZhaa
         68AHDX7AWsXJvdl3DlPK52lgtR10E3RutVXwvgV5TbkIMH+6nTg2rcwksDImx+QhLewE
         2BC+L/FwIoogfvmJuFgJFcDTZAJ/23sFCpXvZAoejh/WHHLllViJI/9hQ4v/uz9LbFRe
         HHHLMWsXoyk03KhhXCH8jnUQ12xTV6k+Ygyd98c2UR8LJ3w3AOeHpSQhbldhojNRJ0Sz
         iSiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785438545; x=1786043345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v0u4alOrwq5rTIgb2VMXyJVDRLR5K6pdRFLGd6pBE08=;
        b=JhZDEtfNfKMycngnSwvncmYLhOvKEwzTOng/b4QAOLsvwodB7BnVJQF0Bc+3GAC/ME
         A7XI1z88dGu1qC9pVkuBF/7LS6rqmyKNgQ2yx6eDmWibHxwqapqpOaRwwBzWB9pc/WrA
         VbquWnlC3Jkuejx4WM+xYAuWTtF8zegKGn1uHk1CnGDeT5UHkv5PEE+YcyahXum6h95U
         sd6vrPmFcIEFdog+auR+n0Le8dsa5BZTPdQ+/KvL3zmsOgAPExgwT/uaih5nkkBbjMVu
         Hn5O1kb2cXIKg7eHQqZgX9vByjyGMmUDhVRVyD1K5BU3HoOChxqy79p49OdL7uFv61dx
         FpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785438545; x=1786043345;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0u4alOrwq5rTIgb2VMXyJVDRLR5K6pdRFLGd6pBE08=;
        b=UQ4SFLyMQlXtIe0p09Mp2R9LKgLkXh8GRLepla4wtZIzfHqDGbIvDUtxF1udwxyeUk
         0A5/L3slYeObWcylFdh5Lnr25kKGzgkJi6SPZ4yYmG/4hU3JI7sHyTlxPj+vl3R5GB4Z
         q/P4aHP2LxnF271PPhEiEUw6Y4dSqOw5paYoFy/KrRVKltO1b0K8xzJGOQZqyD28XQWw
         ucOw3VJfX4nyVl/+kGfzr9xs58m0Dq9y+hN16EjjOrLv9mcvIPgvCVGdZm+5L4jnhG1X
         aRHFIbrhR4NsX8HlJnzn4K8yABdDgsoZaGo9OzzgL0DufUMXyLyJ2ctL3/USWmHBHaUP
         z16Q==
X-Forwarded-Encrypted: i=1; AHgh+RrJb9ciRRU25g97xlE23Q+ccqEDVrM9nHf9eZG9wf10B3lnRks22TYHnZM5TpdfeGg1nn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgKbqPBeDrOJMS5BKueqQjcMpKX+oYoqPRC4vM8uIZRaqu+nr
	U7EjG8SuEQpCcB5BrHv9BiHvn2i224T2HlIaXeW5ERXMXyv54kjIWYwi3fcQTvGPpSGJtiZ00+L
	PaZG7ymViz7U2tuF7/cd2AtHSj+aE1tXR0DUMQNtA
X-Gm-Gg: AR+sD12agDdSknsKz1btnPNXijXJtYDeacHedXPyRiGfGIt05SaZIs5HStUSloTRFTe
	h2TWIqx836zlU7B58aRjYxACC/7mzC4sZ3QVp1qIXcYoms1fKcOSmw7m4tovZClRZ1ZwwWWjais
	GZtiY82KchRKIiqjfNL1e24/f69/wySBFakMBcOx4B06ELFFajQmGIbdmA6L8uW3ksoFvcRaXbl
	NfLJ35gj9sVuZLLVWMFk9oJv1Geq/QOUmW3k1/5mv+rGfCUNrFRbKhNY8Nwv2+71CrMViyTqLQg
	f6wyq7kN+2T+Ymdzg7XQQvEBg6rXcwOaVc6dg8FnweiW1/QofFJE+i86yXnQfF5H/TL3VIs4aTC
	MTx+tQc3ySgjRXbLbLcbtToeFyWWdns3bAYJRbcfye7kjCHZgg+NnWxewtA==
X-Received: by 2002:a05:6a20:93a1:b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3c9007f3948mr3817709637.35.1785438544828; Thu, 30 Jul 2026
 12:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-bpf-iter-tcp-refcnt-v2-1-8e81f0ac6f3e@linux.dev>
 <20260717025253.23EEB1F000E9@smtp.kernel.org> <DK4HTPHX3NL8.2N1FK8D2N9521@gmail.com>
 <ami0NJ9s6ZhXVZb5@linux.dev>
In-Reply-To: <ami0NJ9s6ZhXVZb5@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Jul 2026 21:08:49 +0200
X-Gm-Features: AUfX_mxYi3q4TNHstbDXLu_iANX6UYVzbjhCpb708Ut7DV_hLNVXcExA87EeG_E
Message-ID: <CAAVpQUAOzzhG6x96EM=Mk3EgYhmvoyTo0P5tAFh_237QWE-v0A@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 4:10=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> On Tue, Jul 21, 2026 at 09:24:05PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Fri Jul 17, 2026 at 4:52 AM CEST, sashiko-bot wrote:
> > > [Severity: Low]
> > > Does this multi-line comment follow the BPF subsystem comment style?
> > > The BPF subsystem guide expects the opening block to be on its own li=
ne:
>
> On the comment-style note, checkpatch accepts both block comment forms
> and the one used here matches the surrounding code in
> net/ipv4/tcp_ipv4.c, so I don't think the bot's flag applies. Either way
> is fine by me, whatever the maintainers prefer.
>
> > > Pre-existing issues:
> > > - [High] Double-put and wild pointer dereference of batch sockets on =
the
> > > first bpf_iter_tcp_realloc_batch failure path.
> >
> > Hi Kuniyuki,
> > Thoughts on the fix and Sashiko's concern? (The latter should be probab=
ly be
> > fixed separately, if needed).
>
> The double-put is pre-existing and already fixed separately by
> 980a81345275 ("bpf: tcp: fix double sock release on batch realloc"),
> now in the bpf tree. The hunks are disjoint, so this series applies
> cleanly on top of it.

Sorry for the delay, I was on vacation for two weeks.

I'll review the patch.

Thanks
