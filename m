Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0AD3B52FA
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398438; cv=pass; b=IN1Gf4xIRZSESU4hty1XrioV9Jel/p1klrp8Hdz3ougOrEYdMinxseAdW80rKoCxEBORwx06rd8AfF/bVzPZt/tRVHelXC66IjQCp3Y0NF2yyVcA139t8+hvt85L6rjOy8nwIcfbf4huAI5n0VIeKlJ8tQFJExOfEFRn/1EXwXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398438; c=relaxed/simple;
	bh=/qumogwgWc59LHrQ8r6qu+ZZ1wrU6nBnOtAbRO4FIWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8zBq38T5fyKwy0O7yZPrtBq6Io/E0n3f5VtSih7k1FDY1ZKY4uBotP2h2xTAHOMHYuDPM5ryD79ekGLLdwmUB7LQFQwarMaI9pTLXQR05FqQm0fbWtLpiqNcKz9aG1RXVHNEVLy+A9NeQgAXMsw3LpSzQ3IuZPuCG6gxCzBa7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na7menCU; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na7menCU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so24912925ad.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 09:20:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770398438; cv=none;
        d=google.com; s=arc-20240605;
        b=OZGLJ3BaO+A+mEJPBtBsTfqKfmxZzGifjsasnmS9l07r/2fHSQN+aP84iEAqjF9950
         csplnLqxspZhiQ9eafFqW2HguWfuWmCxRq+T3m1wMgn7x8pdUrpJFlFHzYlXhp5RU0Td
         M372eJabfFybZF1R5E+RTinKiZ852+I0p0bNqNByhVJM1xWyXxXT6j0zyRD5b7Ip6tt2
         ZqK5p135zx7LG6YDHYeyCSyFqgjRjYWTCfmq2ctxKtCsw167RmHEi4GgzX/3aW0j+/k7
         hnuXXsyVVeMWL0oJilxPotHoNr/45oxI7Hu1kuBQ3OkxD/4tUp/DkoTrJrjST/LABqqa
         T2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lbwZjr3qYTYMVh5dSzWOvpZE3JIvD5tPPDm3ms1nJMA=;
        fh=FsV8VQB0aJQ/jMatOhpF3hncEylWSHHbgzY8rfH9Z0s=;
        b=MMNNMEDJJKfdokPXzKZsCyQYnqy4pOoej+A//X1c/qOuOtYce15BbbaRdPB1TIMsdj
         htdQVZ79TM0plQxFOJCWm3h1d4IyfJ+KskU9KXk2E5P/i2JyDPMfubRjWPb+/kKEq9FN
         /R63MnLK88Pnd2Qk6WTrNss/0TpbF7xwOpVbthp7k8Zp138/kevtNtqazzaOfjEZDL75
         zeZuUl41u3zE9A0Xphfd+8xUKDBLW6qZRPFsUSSGQzAZ4mDnL3zlb0erKSyoAcX7G+iW
         Y3WguksFvMudPcUG3BGXFCqJnFw6qGv2KrDj/kVtypK6XRN/lm9bKQ0t6sw6MtN7UHF+
         yV+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398438; x=1771003238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbwZjr3qYTYMVh5dSzWOvpZE3JIvD5tPPDm3ms1nJMA=;
        b=Na7menCU2EUdDderW2CsgabqMUKqL70vF7Eju0v8Z8+gUXa1TiXljcY+8WozNYvcKU
         DP3kbxFq3b+mnALsAebnaGZoJPb+E/I8I8WafyMyteD02aDFJkP5dOf/jl4pSL4PlhnK
         JJ5AgqWrv/tDyZP1Xl24PiWDQ+mOcs3ffpS0t1lPEeEbCBpRPGrGYAi0GFY5tpzoW3ud
         YRaZBxDU8dSKQTtfjmn9NccnhdnnwNZIUt3CfrWi1OIKonjz3KQRlu2p6I79vtFz5fgY
         ulKz2MD/Qf1F19CatZhudEWBKoTSjDMzu3n7f9TZY5IEPmYigJw/M7WkLrWGN6btwUIR
         oHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398438; x=1771003238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lbwZjr3qYTYMVh5dSzWOvpZE3JIvD5tPPDm3ms1nJMA=;
        b=rFET6qipmHWnmbIlof87nXZIU9imkx6ochqiCyjUnvdb1A2woUFEWP+86KbBCKyrRj
         v4SC9By0tzbLeUe/lHGSZRyZoJY51gfmCMLzuVRDpBb+PQlFlxXDrK8M7BGqlHTFmorn
         qMKWaEUxiXjE+i90QNpu0+if6wwlTy6dQ1x0lI3NDqtsrhs6BPMGMCRmnZhO6+MRgkFQ
         3IBpGLfGswEi8zrhYcP5A70yY0lihu9M54s998N/nHcA4S44hQ9Xd/XEeW/niHAifGaF
         04Zi3NTXWSnsiw+22K6O7DTwyWnMdW/npYriXiJzRUyBnLzbMNIz+Ixlcu6dlGlqwLvl
         oC/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWp+dCAiyb8NmglvlP1yaRwXoGkO4Y051xoTkwTn3mqfL43hKjo9I43wmnaTTNSrFKb9tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXV9ZoAdhPm4cM11ToTwnXYUIP9nHrDmxU3upZh+0hXzqVlDVf
	KtGQRlGpvIXSq9DMunE1jFk6eeUIZQUzam/SyVpEEUl6SwKCOLRnMFvqQHpXfRiCmbh1R4psSNC
	1lshScpM1+BMuMsooRwnfkoiNioF0Z+8=
X-Gm-Gg: AZuq6aLD8BbvceRseTefzP36TN8RLiz8pnVQSsUWOu3RoqUx+sURGWBAIhGPQGqcl+N
	4YJa2tP1EiFaWiwnTPE7kyBPpRiizIXWUU7UzBSyrZ3xBsIjo+S5uxNKMUR5xbwQjSKfghxf8LC
	4xWpGMnpgReNz2P7f4iBW4yyQv9JxAKL2ckhh48LCMLou1TGucgy4kj/wJ76XoylmHSTkM1OGka
	aeBbb5MrOtyRzlksUVK2gcCMDWfcTq4AmZs1Nx95FIZUf376wnI+dxqlaBIVLbosSr3gP0YzW/z
	HQpH5Hz1l1I=
X-Received: by 2002:a17:902:d4c8:b0:2a8:fd0d:ae94 with SMTP id
 d9443c01a7336-2a9516c7ef0mr38666495ad.19.1770398437457; Fri, 06 Feb 2026
 09:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206090653.1336687-1-chen.dylane@linux.dev> <20260206090653.1336687-2-chen.dylane@linux.dev>
In-Reply-To: <20260206090653.1336687-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Feb 2026 09:20:24 -0800
X-Gm-Features: AZwV_QiGAYd98m3cUzIw_vGUq6fevhLzkJz04ZqKbaLu10QiA8mV1o0rjk8RQc4
Message-ID: <CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add preempt disable for bpf_get_stackid
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:07=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> The get_perf_callchain() return values may be reused if a task is preempt=
ed
> after the BPF program enters migrate disable mode, so we should add
> preempt_disable.
> The get build-id offset in __bpf_get_stackid may increase the length
> of the preempt disabled section. Luckily, it is safe to enable preempt
> after perf callchain ips copied to BPF map bucket memory, so we can enabl=
e
> preempt before stack_map_get_build_id_offset.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 84 +++++++++++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 31 deletions(-)
>

Let's take a step back and look at the bigger picture. This whole
trace_in thing is still problematic because one way or another we do
get perf_callchain_entry, which *needs* preemption disable. So we need
to refactor __bpf_get_stackid() in such a way that we can do all these
steps separately:

a) get stackmap entry (pcpu_freelist_pop parts)
b) (under disabled preemption) get temporary per-cpu callchain_entry
and copy its IPs into stackmap entry
c) (now with preemption enabled) perform build ID fetch and transformation

Current logic is too coupled together to allow this, but conceptually
there is nothing preventing us from breaking __bpf_get_stackid() (and
see my replies in previous email, we should do similar breakup for
__bpf_get_stack) into few separate steps.

We have to do this to make all of this work in all the combinations of
sleepable/non-sleepable and with/without build id, IMO.

Take your time, don't rush, think this through. This is a bit of a
maze of code, we should untangle it properly, not hack our way through
it.

[...]
