Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E83101A7
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271582; cv=pass; b=t5F4Iv7NMztZC7PYtRRLKkrDMB8NoTfwjtq0WwrJWVC+WmrqaVzxZhKhQMowJsESBHXlLJZuzbIe8T7RrM8ShKbBemohDZme3L3GdGe1iUhe5hS1ti3uRF1RdDClxzhUGisCHQvtiwCqG3mPEN1y5XF+M5n/o2OSUv/PT0P49MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271582; c=relaxed/simple;
	bh=8ItX+BQrb8DPPcdx7Fc0ebuh1W7HIG67JuXl7zgZvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jecjq6stdeVkQ8S+r2UsNEFyewWGjN3k+JOEoBzCg9aQJbB1a7c2Iwu7sUHa9Qj3ZVh9ei0+Svl/5pMj990BaJYNrZaspOO/X+ZTxb4vEvkEwiUKuuSYUjVynxEfY1I9wYQIGZt8L+lXdVnDLQFGKc5NAFaQqWltyF1MmhZ6ngc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYs+PV0k; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYs+PV0k"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dfee30612so2261248c88.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 13:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271580; cv=none;
        d=google.com; s=arc-20240605;
        b=CSkiliS8dEZ94psjcl0G4vYD/6ZCqwyOZ8FIHVklM3MxXt5o8tDTmOcWwlp9+cXoVi
         I824sZug+knGtGuHXG6G+5NnmcQNUmIKyZ3uEzyQdpK0mORthHJgNhSCdD5fe+mwZm4Q
         7kxop5lvetByOfjB1MjQM/7l57nlQtO2tTEkf1nDANc8eTWPgUNMq0+R0brAs2DPPyo0
         IUaermkkWkSIIFOmuAR4Zj/73LDBBB1vb1/HunUGpGzXAPqY+YbIpwX9HSyG7OZRuYoQ
         1YJf30TkdRl0j0rEvtSp2h8K9kNbyNPd3Mawq3U8LwW/iZrMKFW0XV1RtoIcHWRZ1KtU
         xYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+B1AKZI8ovjXprcofyiqirQq75Rr4Az3Z8kwmuK7zZw=;
        fh=+BoHRk7SVwOTNYmRYNAvpTio42IwAKdQm7QWJSYixeM=;
        b=hoUCvuVeImdObx8saxqh2qO/4iN8xrrOw5EAHY0thGp2liUP8+JMbqAYirBUrKl/WS
         oizb2H9eWPDPYLSn+dGo/6SM1vbtU79VXiShfcss83Kw4IZ18sjRbphErornDA+AGE2C
         ffJ2NUtYM10lm2N+dPjOuVIhpeLh1TdHO4+99ghWk6tTHFx+GeAiIUbRuY4EyRkfmmcQ
         eELvQAyIlTQLXIkk/GRJ2xSH2b5cOAMT1ontCDRwdKybeeQajiElDpJW9DUvMtA4TilM
         vPBLOMMGLvA6TZg8PAZP3Qz+3fC9/tUzKj+l7f4A0lTGUkgdNkEAxNwP9TtxkgIIQJX7
         fUxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778271580; x=1778876380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B1AKZI8ovjXprcofyiqirQq75Rr4Az3Z8kwmuK7zZw=;
        b=wYs+PV0k3yvi6BXrCJcKkZaKqSCOdvCzQ83KBluIldeKIae/TC0Azi8rhyjRXo86uh
         N9wHPO9MAEwufJkYcU+kHDCajyTOYs844+2mtG/vy2TkGrT2QCyLDce8xVnJq6j+j450
         oFVLHf3li4Xwsmadbeni0Ug71ieUl0CjT28POlRBTYHnW29l2WKFJqoxC4rDGcT+F9Y5
         0yXgseMBoSIPgDw0KxGPTC6ZR0+F2iDEGbslP/KDpi50JR2QaNa6NP1VGFO13XMC9yo4
         H2gLZUvfxtAhIg9oSGNt6wrEVZSjexpjZQSSN4sbo28xE2C4D4xZrckbR4diUxX881IB
         64Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271580; x=1778876380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B1AKZI8ovjXprcofyiqirQq75Rr4Az3Z8kwmuK7zZw=;
        b=dR8UFtAulXRxHfq4NcxOpWH7swOBDNRpEclTUQjEvW4Gh2b+xi0S2Lo6fbAh91yuvO
         TKct2TZrBE529c47EsNbr8QpRjTFk4DiroOG57JijY1RL4xGA0gM1zGg5wr5lKxrG+S8
         7raLlUkRZKp3po3Sd07yjX0guRvL9/HKOf0vmlcEIs+bkQ8CdKTnPk+aHIo4kvDOaYJc
         MMZFKWi7WTEa0X53ZFGkXJrbzLllRp0DexAaX8Pn845jQ637jMhI3ic/wuBZm8nf7SUg
         yhT3Xu9uurT9+HunPlJQmzsP8F0jQxOR+qSmelJrud5n69xXnQOl/KbCuW3shpFpCzeD
         cZnw==
X-Forwarded-Encrypted: i=1; AFNElJ9HXgbTukSzJs/9l75XwCYjBTXJZNOIbY2o3QtaVo6b/c7m5P929FthVedURlrgdkxDL/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+V4fkdVAW+KfTDNgey+krwyIV7XFBflevz/ILS4LrK1dBsROu
	1WqbsvDvN8qyYzfQn96pkZaI2dFfqa0nGHRup1bX2fhKG3nt0bW0bipLkBKPT79ggA2hwNh1Et4
	hxqpM1sm+5JVn9bqlbN2nZYS9LoYO6/yl2ST3Ux8N
X-Gm-Gg: AeBDievgQLgF5X5jgXRGs99Z1zAtsjHJZn/VvWPixPEAPxIoMaNK+nBnPS05su+JTgJ
	qWyTYHJc7hV/EjP7X/9l45ySVeURaWAAk2MR69fW9ESrkg6+1JhWmS3cX0ipomAnGRDrfiTrILH
	X2sPVpg1TgRRUFZZN3zoVF4sW0XIQyS4HjC///QUUeBbxZgghKO5hmk+syeaOEaMXWPJadBIKbN
	05Qr2YQRfuO2pB/XjywxJ/mL1pgMsdQfrcS2w8tJY9pc7m3wgB1C17tlNnXzSPWzdw7Fc0lbrZq
	KlgJjcnvUO2ik3DTAx/BWlqRyP8FBknkAkzyR8ys1wpkbuLBeTkKs3BIoBpS8U4i556PoXX5IvO
	kBf2+gbcEBhaGLgu0rUocA3hwU6dozSs=
X-Received: by 2002:a05:7022:4392:b0:11a:641f:ba11 with SMTP id
 a92af1059eb24-13271c9c205mr2423392c88.29.1778271579731; Fri, 08 May 2026
 13:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-9-kuniyu@google.com>
 <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
In-Reply-To: <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 13:19:28 -0700
X-Gm-Features: AVHnY4IfgnSdHVQGqmUp9c8TPr6rc7CoIlimLF0FkCpLI5deyQ5bxtFAPQGZg_k
Message-ID: <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for BPF_SOCK_OPS_RCVLOWAT_CB.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:35=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > The test is roughly divided into two stages, and the sequence
> > is as follows:
> >
> >   I) Setup
> >
> >     1. Attach two BPF programs to a cgroup
> >     2. Establish a TCP connection (@client <-> @child) within the cgrou=
p
> >     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> >
> >  II) RPC frame exchange in various patterns
> >
> >     4. Send a partial RPC descriptor from @client to @child
> >     5. Verify that epoll does NOT wake up @child
> >     6. Send the remaining data of the RPC frame
> >     7. Verify that epoll finally wakes up @child
> >
> > During setup, two BPF programs are attached to simulate
> > a real-world scenario; one is SOCK_OPS and the other is
> > CGROUP_SOCKOPT.
> >
> > While the SOCK_OPS prog handles the dynamic adjustment of
> > sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> > BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> > pseudo options:
> >
> >   #define SOL_BPF               0xdeadbeef
> >   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> >
> >   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));
>
> Hmm, so you do want to have this enable-on-a-per-socket use case.. Then w=
hat
> happens to the skbs already sitting in the rx queue by the time
> we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missing
> something?

If the upper protocol is designed that way, it could be racy.

For example, HTTP2 could have multiple streams within the
same TCP connection while only one stream can be upgraded.
But this use case simply does not work with a single
sk->sk_rcvlowat in the first place.

This feature implicitly assumes a single stream per connection.

In our original implementation, it traversed all (technically
up to 100) skbs in the queue and parse them like psock.

But this will be unnecessary if the server drains the queue
properly before enabling the feature.

If needed, we could return -EBUSY when the queue is not
empty.  It's always under lock_sock() or bh_lock_sock().
