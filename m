Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793661875;
	b=MZAbhKj0Qi63uV5+lbtNqcnRhoi/0Ah3T5rMtIMHqqJnVEmPRQo9L2FmtRv5Vs6tk9MH
	 YJSLmYFJust+7D/GpmkNqyio9QJ0n4dDYsduuOtAsMlN3QehBPkUOi8OclRLGdfasCuvz
	 /2wKeV3ogePa6dDh1hCSQVgglBhmVrto81p2/D/4j11mJnvK6RFMsfkHENB6WSWlZmcYB
	 xJQVXke+RtTazPiBI2bJNm2j5ns13bGW11ilAS+nTG3lLnTRiiFE76vDNIq+Jdr349ll/
	 ebjDh/bPKI9IUsaESduiz/jV+C37hTmrNOstdeBw9g4NXOIrq69GlcDL6EBUZhho0ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=clGd0kEztycgStZjRN35b8z63U5kKCgKQbE7kXLWxN8=;
	b=p5kRM+hJFDNmSntz/M1g7XRXsVFbFTpmWCKyH4ul0Rg1vwVhkQ4nJdRUrqJyCU+qybDf
	 cE59dsNy7sBAQGQVLg6VGnei3afk+BhrnLzfFV8+sKC0SvVSju8UIDUFLCVDHvyiGYn2o
	 0ob/mKZ6BzwPTm7k7UPfBnfzDn6J1besxrhpURAZyZ1sao/zuYvPEc1jHb2iEUjqkguqJ
	 PL7hoka18BDksFwkMOzDk/iGz0bU0I0YWHMQFkSCEyb1RZvH+/fv/02F5RCSS6IGDHGRG
	 LF1nj5jkYirT+NPkTfm6tcEEQ8GbMZbQwHIsXcLC4NVYPqSyPhctsoFTwsaP1Rc5RaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=VoJsUXHV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47665606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 23:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47665606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=VoJsUXHV
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2eb4a9a580eso4020445ad.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 15:24:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793661875; cv=none;
        d=google.com; s=arc-20260327;
        b=ZftQkjktyyLSWAQBAyFtAj5C1wrPeIWrJz8bAVVwNXw10X25rQYzZMPLKtYdXo42Mz
         oMb3spGDysqfb6IG4FrESWpVYjIEplHyOf5fGM9G7GIKOREWrXN+YrkxUhUbMgnJBbCf
         wnQl77ffPnSfJhcqv0Sw/JxLD5z+q+9kbhj/hpCsl9kP5kSrwdVGUAG86ct8HD5e7249
         fa4q3qiHy7ZkxDKQQoG1O2Wv2HRsoFcW+Jqo44VVaHMZuDkf8FRNv7ELElQsMdHWaPHw
         q+EBLHfcaCiHc0kcm4b6gSG+hYgALSbsrwkAEy3JmOw63uqOJs0OGzjFWOGUNKKlJGi7
         sRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=clGd0kEztycgStZjRN35b8z63U5kKCgKQbE7kXLWxN8=;
        fh=LlZE560l2IzEXNMj/F00wicalx7P7XPQ6i7bMvWxyTA=;
        b=ogJF7NzSihWf6jEUouqFbHw8Md7U7yiM3pn93YPGq9JxteviD2qGjaNOQBDqz014eo
         RhDEmGornbp/sR+xX9+T0iMkC6AvxfkQOi+B14Dly/nEEyI4p/yUGRMXDn0BqEP6T0VO
         KIOaVLexzJYnQFLePuq+euMd9o6hf32mqeynjjgOgWKDCQ24AY9pYBV97Tyb1QkNG27/
         JI+6btXcbA4AKWug+8H25fjE+8zcIgufbc2Iz3TpHxJNggys+zZgUV5gXIo9sl43kDbV
         NUK4fET+3cD6sAJ2lGDsubJdVWmSIH6FdunF/SwielCZrUK03puHZ9Ifdd9neABOn1ZX
         nkTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1793661875; x=1794266675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clGd0kEztycgStZjRN35b8z63U5kKCgKQbE7kXLWxN8=;
        b=VoJsUXHVOh3WOnKnqX2qdJvPo165+E4Eodb/Vj3S1tPrqm5djyowm0rOKrH4UpL233
         FKOeVodvPNg+S9jR35oiMkZvKyABCT5VZ09dlAIj4OcN65bWsFBOk4BJJPGDhKYuo04L
         hFaX1JNFXqGbN9LNdJXjaZz19yFZJD4lGi7HWpdMgT/WSaaOtob9wnqgLfYGVEXU2yMf
         +q0a7dM8x/x+vJg/LsiF+bbdPWkselTJQ/u7EXaXAlPMN7argOMWw37k/PtMN041pynM
         SRrGQlfTU7kcwUmQdsjPkHdN4Y7WR+NhXfzpQ1oPlOiHj10Bnit2/P4KD+H+nwZuH7aC
         AKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661875; x=1794266675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clGd0kEztycgStZjRN35b8z63U5kKCgKQbE7kXLWxN8=;
        b=S+5iQ7fgGU1uziuZWSMJM9dAg7YhzbqaiA5j/e65TPnsvPdTzN0aKUuG2kQnkTHQ6v
         L16Rzjls86tLHjGq2AyPuvkR+UACs1SBDKAMZcn096EHJfcJJ82+DKTx//bxIlGwm0FH
         i3oDbL5Swcj0mKCZs6shT5uShEz1rmwgEHT+koQW/vnvvif3wOmke7Mo4CoP5AxLzj07
         Ds5LPwo7ahEu5xLoD7zEnrF/fphYgAOqsL9dl24GsJRslP3rpNzJk2D2lMc/l1VKSE+S
         MxccJ6ndYlb0CwVNefbYOOsKmvBbq+XwmT0n4LcNOj8M9gJxeH8RBK2CPYFkEvJsAQHj
         Yykg==
X-Forwarded-Encrypted: i=1; AKwUvBwmDVLSbiLwj8rDnrhC6KsN5Pe9qcjFwqiyZ84oWhA908WKU8+Xg63/a+5PyvtLSMRyfAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LZpxNG4OiPgM01pF5oHmnIo9An5Jw6G0kSJsvzOGF3f2ziep5
	hgZU+BFnu4P8eAu6VnxF9XNfKoiUbYslpx6n7hfX0h3JBovciFMpMk8CztT9GzGcvcyb7d3VOfr
	eSn2ocDMxXM8+7z47vpT9KQXeSjMsxWKeyngsxXvg/A==
X-Gm-Gg: AYBFou2ARPKVyu4RrefZCMyJrDFQ0WrDnZxrVDKkpRRGnOjf/OgAke+BWAP1JiVzwTG
	vMxxBdEalBQl7/3BYtzImCSZJoVwEjZkPojoMT0ITdJlTrO1ES9BbPCRyIsXnFlW6EW42kD9Pkn
	zXqmO6cPy4SfDvmpKBbeuUo+XzMikjJ6c7WgXfiE9axNlj+YYkWwq4Hf+kIC1nb4Zw+D7mz7BLt
	EWYXebimJRJBeqoUxS3loNZcjmnSVeeodhBSM4G3fPjSfDrBvCHopYbDs5TpIBxN5sRxI0EYNBT
	fWUPp6Aen/KUqGiD25EpAQK9cP4TsN1Oe1AxlcsiuHBqAJtX4OWZKkn4B4C8Z0b1B03wg6aJUy+
	wFauCXbHFesKNPMu+hFJtLfsGqdKbWKYxr+Z89YRGiEgbUoly3sjuenTFo6QM
X-Received: by 2002:a17:903:3804:b0:2e8:3cf2:49a0 with SMTP id
 d9443c01a7336-2eb36405287mr188158475ad.1.1793661874532; Mon, 02 Nov 2026
 15:24:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
In-Reply-To: <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Tue, 3 Nov 2026 01:24:37 +0200
X-Gm-Features: AclHuK8h_cYpK4lk7OO76ee8Kks2WVPwHiw9tfTN1WU_Lw9F0nS26YCUvD9J2rQ
Message-ID: <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 12:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Oct 25, 2026 at 04:02 AM Mike Bazov via B4 Relay <devnull+mikeba.=
sentinelone.com@kernel.org> wrote:
>
> > Is disabling preemption in __bpf_prog_enter_recur() on !PREEMPT_RT the
> > preferred fix for fentry/fexit, or would you prefer a different
> > mechanism for reconciling preemptible execution with prog->active and
> > the per-CPU private stack?
>
> No.
> We cannot disable preemption, since progs are not short
> with may_goto they can take 1/4 sec.
>
> Sounds like private stack is the culprit.
> Should we disable it?
>
> pw-bot: cr

I think disabling private stack alone won't stop the false drops by
itself: for fentry/fexit, bpf_prog_check_recur()
is always true even when priv_stack_ptr is NULL (as in the reproducer
and selftest where stack < 64B).

So when Task A is preempted on CPU 0, this_cpu_inc_return(*prog->active)
in __bpf_prog_enter_recur() stays 1 on CPU 0 and skips Task B even when
private stack is not used.

To fix fentry/fexit while keeping preemption enabled, we'll need to:
   1. Disable private stack for fentry/fexit (so each task uses its own
      kernel stack), and
   2. Check recursion in __bpf_prog_enter_recur() per-task rather than via
      the per-CPU prog->active counter (still blocking same-task recursion
      and IRQ/NMI re-entry on the same CPU, while allowing a preempting
      Task B to run).

Does that direction sound good to you for v2?

Regards, Mike
