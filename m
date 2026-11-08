Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126475;
	b=BG0C1ILotKxy7Kerwmlys1YvrjhPySNjaDK2vQq61NLCHbpkYfsnCW/IWw8On9wjSBPe
	 ErLx9Nwmzub4laYDimv+6ELNnwsfyjEbwwK2wi5Mzl6bpybghcNMdf8tfd1XjTya+RXaQ
	 kmbsU8IRj6UN8ErQ9YPtiGjekkUavdgzIopyU/sVib0kFgg/Waqg64UdJkI5H8JiTpq38
	 d8F9vtHRLfetP8bsjdpM+P8mLWZkuy8N2gvibHbZOL9BKMndIGOEU5OztCUAB7cRsx5+l
	 O3tHmx6LP2pagisV7r5G6Q+r6+eYGuXCeeup63m1RyRQZ0CCiXQ+sZ0sgWh3Pz70yOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
	b=Yb0aANNCt2RTJNSFwUf1J3msgs+51u4UbTgdw2RwL+y8DAyDZDYKVlQQKk9m+pn9+zoq
	 odArW9J2B3GaRupveGju/3fkUeh9f8jgIof3NjB2n6YclvguhD3t4GBTfkSYm6gRMOdCq
	 +Biy+M08+ARZmSlSRAtOWuzjLnWA3XrhVTEGMgbpRpMvl2smvalIc9PvOico9OTkXjeFC
	 4KtJ8pmZIRtMgk1PsY2OtbIQeKGl+Tq3ESIhaLCELf66mmlRqHzGEHaMmNU0o/+x6KFMj
	 MIRu2blOKG1SKDHnPc5dv4qFzNF/VqaVLkYWXJgRGaZso7kirwt35VtMFHCvqUg/gqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=St7c8hWs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9F606A322
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 08:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AD9F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=St7c8hWs
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-847ac7ccd85so138432a34.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 00:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794126473; cv=none;
        d=google.com; s=arc-20260327;
        b=BYMKdq1s9i+aEg6WXkLRFXy4TCMlK1tWUwHZxQtVfT1di5JTUxT45tvbmd9tBF72Uv
         Q6ErAHfa/U0riMJsvFOX/cD4Wtfeugk4YWiVFGqjvOVEiqoGAa4+Vc3evf4f4xZiih9M
         1F3gXsJ+47HPolZ3DhFlXrurDwRd5oIQFb8gWygVLTMpWEUxXxRFxK1MT8Om2IVLhuQg
         dLaEeENS6/yWFHv5eErfcSX6ebY+L4RgxfWsB015OfIJiNSJfhGB/aVyAkEa/pDSI8qq
         KxTQPMH46e3yDxj3XPpSXTrX5HBQCdDmdzyFfzLjvYpM5J8A/A/zNteysaV5vqsPiwmu
         Qhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
        fh=lLXYhlSYqwGfixXwYgMws5YudlQjCwJrf6ALvTgqu2A=;
        b=BozwhCyRzFr+UkxLvloPkAcyvLSxw+BXw4S8u/Zl5OU4ln0ViBhEY2JwajaLwlDb/5
         KRUJy6/91KT1paXTdEU8PVdJZG2gjMxA/ksm8Zf7ipmZJNm3M7F6C1XWvM7mHrxuYDsc
         zLWP0oVIxpZCsWSF49QRn8ZeEx4SDFwvJKx02sl4cE6DIkdnZwYmOO8gf759wh6iNGrX
         58XWVjdEtPpV077NbRjVyXMTLPFchWXN8nbipdDtUcuOMX3dexJsDEXGpvlgqIpMulv+
         XIMFIkQwCj91aYTIFiSGXQ3HeqoLmTyFfcLTkfdq+momqI9k7MXzVWjMd/xR7z5eQiOM
         4FYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794126473; x=1794731273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
        b=St7c8hWshA690BLsea/7BSBugBcIPmsC0glB0voRD2wLUW70KfdQBUU82HHi5IRjr7
         z56tvSXxO1k85jcc++z8ES41Q6kydj4961RV0ExG1dSATkUI96WMEFdbtuZ/uJiU0E4f
         sJbamRQSOtSkMP7mMaa3SqKo2pWxEgS06n6KbdpHnvPOXyltZ7DeNe91P+i7920+mkXd
         +k6pD3Jt7DdAL5DVvc3UKESlsjdRBdEY3TJcTvTuQoTWpSu7nBH1mG4ItkP+bOjggYO1
         0T5qtkI90Ftgd/l3g55HZcwUAvMh/oeB228IuwKF23qu6bqDxE2v2q9r3iFR6M1R5/Mq
         lzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794126473; x=1794731273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LHJ/s2pok+cQGyJRZxhcYGZiYXJmh71TKyHNP9sAFZs=;
        b=UbRH4Ny0nqCDLRYfQ0HNAy08lnvosf0VucpfBxJzPXdnLbslreLIMfoyzmV41/KF+S
         u2YMErOXP5kv0TpfaHPjHTT75LzKTHKnD9nxj67CCztOmjPo+sHS5ZqJ60cB/1ZD/vov
         XQVwiu1WUADsUDJ4SrP7k58ZLukcdSvm7k6lGAQK6lcyAR9TMpZnT956mmC44yESXp4h
         nhpwP/LIeMAwpaOZ0V1VKoXfjvwrTkiZrrrHKJRjR+8g3mAHpvyHj2SaWbZeytKh3zmJ
         c1xggsDyHWf18/OK6QFrAvM/qftqj0yhMiYyFFHAJgUdWZzeCShl8ZuaQz/HyWpkTjOU
         j3Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwJUMjE7Bf/SR/1LWD5nHCaZcyhlfBrqb6+LcJ00y1F+FSgysOyNzlmdnUyXpZRlHRWIEU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tqZkmcgwrIOjDbu1mTJv958UM+5dwdF5ZyRPdxy3hWVZttwXD
	b5t4ukPG5p15J+mlW5I6EJtr6In+uIsWli64AnwPmSQrcW0d6oztys+ZKoRS/TVy3vjZLE84mdl
	LLT4OT9qAZzgp+yJNKqreiJfzZLx2FPWNYiWotHnGsA==
X-Gm-Gg: AYBFou2BCRlR797jRW5M1WDMv17q6d7hgSSjOUj2nKyPf5kCE6I155c1hEi7YMcmnZX
	VVNMAZAdXhFPcm14uJ8NkEnTY61k2TOzUazB7gvtMuUpHx22DVao+RBfZVOGhJ5MTNIhQ193K0a
	Ycxql0dApGjUalzqICzJwNrTIcBUT6ogniZRWDIhQfAT12SffRzhg653yM23AutM/Cv9g3fNGJp
	mHz0ozUK/l1XTp+EqILgCbGPNhDztPNiPQ5WBlolCWRDN8iUqZybus1o8JpgRyIJv5Qi8UAwr8f
	DI4EzYsVNGOTA1ISCeh9eCV+H3x0kr/J6hgmmkC3YpiZTiUpnEHdoeQwoo4xYwpRgS9bIhBG9hh
	J4w7IE2oYKw2ILXljNWYSd3ugxAUWmL5DOf5UsCmyPHT3
X-Received: by 2002:a05:6830:71a3:b0:80c:d34f:5f5a with SMTP id
 46e09a7af769-85f5075a36fmr645255a34.19.1794126472981; Sun, 08 Nov 2026
 00:27:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-4-cuiyunhui@bytedance.com> <87bjcnlrbv.ffs@fw13>
In-Reply-To: <87bjcnlrbv.ffs@fw13>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 8 Nov 2026 16:27:42 +0800
X-Gm-Features: AclHuK-No24RzFz5kz6KGOgepjfUU9hWv2-yH0FoZIN8FZ2Py9-_ynkukYR0a6s
Message-ID: <CAEEQ3w=B4p-_4pg3ffrkSA_AXuz86FCd-w4FSB50HoijcSL74w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 3/3] riscv: store percpu offset into thread_info
To: Thomas Gleixner <tglx@kernel.org>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, debug@rivosinc.com, seanwascoding@gmail.com, 
	andybnac@gmail.com, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, 
	wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	qingfang.deng@siflower.com.cn, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Sat, Jul 4, 2026 at 5:02=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Fri, Jul 03 2026 at 20:28, Yunhui Cui wrote:
> > +
> >  extern struct task_struct *__switch_to(struct task_struct *,
> >                                      struct task_struct *);
> >
> > @@ -122,6 +129,7 @@ do {                                               =
       \
> >       if (switch_to_should_flush_icache(__next))      \
> >               local_flush_icache_all();               \
> >       __switch_to_envcfg(__next);                     \
> > +     __switch_to_pcpu_offset(__next);                \
>
> Why do you want to go through the indirection of current:
>
> > +static inline void __switch_to_pcpu_offset(struct task_struct *next)
> > +{
> > +#ifdef CONFIG_SMP
> > +     next->thread_info.pcpu_offset =3D __my_cpu_offset;
> > +#endif
> > +}
>
> instead of using __prev->.....offset, which is right there available?
>

Agreed. current is __prev at this point, and both forms compile to the
same load/store sequence. Passing __prev explicitly is clearer, so I will
copy its pcpu_offset directly to __next.

Thanks,
Yunhui
