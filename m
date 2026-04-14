Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C63283FEF
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194180; cv=pass; b=QQ5p8RX2eHrylFwrAgJBhf5VJytKTq389vhykY0uNr2ZsHl0OuLVTzW2Q5Lb1UP1bOxU7/8PkuPdvkr1TtVhN1FuJILpshgjzchdi7omxd/nBHmqNgKWixDFNnWlmgUuDXrCbdUf0A0KPH7Y5xfmnE4hkCLixSWj8P4cvs326eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194180; c=relaxed/simple;
	bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+HnHBVSurL3Rh9E/qmpBWPFPP4+SWgIrs+howpgdJh8LE657swCuyQfdRQJonMowGnHpoOyuTByxESdDemNHLlrqeG/mD7XlJK/vF7RLgVoqVNmN9cPZCrAGIaVDRD778CFGpu+ecgTmv5PIYwrnU2+nwBusBW2/OXVh/lxKZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpc7xVpy; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpc7xVpy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso56142435e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 12:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776194177; cv=none;
        d=google.com; s=arc-20240605;
        b=M1X3yTWSXHIB1ArDKu1KCpfBb20OsWmDX/zEkQu3TLiPwWUgkV2Aj9S7Nl0cYkJAAq
         /wLU853aB0EYxHQX2RCIYf/iNUsGI05o5Ell9FceKw+m3LG5ixSkBMq5JQ659zKmP+us
         9Pv0tdE+xnNgeXg/wPwUV9vU2AQEqHfzI8pFAdSGtXAhpLoYlwlzWZYNsfcEseH4h7jQ
         +ecoBLeaYhLadNM+edYNoll373FfRUQoGuM6UMugha3lF7A1AbpzSJI3/xodfGGscD/M
         9AbpdmJCeBOUbYaumOrp5a6sEPKphgKSS7UwbwLn/mlR2MnbukAeksWtRCUiQPqzHOhz
         z7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
        fh=ZE1jtvZ0Jhj84uBCAzrJK1RVkeFGtk+GS/ABsWxw9to=;
        b=WYlUhD0y2Zd7OooTB3HOX7jEf1jLvx3+ixh/mvvrDQtYfAOtbhc+wwPVjEcuZ1m39v
         zMLxHQbp+SFrQ+e7T9S42zP3fPgyzo/R0BuVpqOP1RrEoU4STziAvhiQS3WiyhSegYhO
         218g8yNPYRrD9PNUvLu4REUxodvMDZJtP7Nv4WZQUjf90sSlXD+IcY0puENi9ffe7x2K
         dRrHRLN1edoZU1/ce/McHr3dOFP+7biQcQV7/Wd+51QKuqNpr+ItrCOIpW70rC1q1aYZ
         uvyRjo09OgprQilAHQjtwNon+Q/BCBHimzYyVBycSDcQb4UdMiJj/zpAmy1jjopm/fjT
         Eutg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776194177; x=1776798977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
        b=Mpc7xVpy0aat/nOvxYcxYcf2t38XGL68q0eCA5v8oM4hPWbLdss4Rdsj8qSPNKhUqi
         KOczID1epKGzJJbY7riB26JVfzODnvHVKvoEUn79UDeMfee5OzhrgRdK1TpYXbhjZsWX
         JhK6CkseYiAEXB9MJqp7p5UviYRFK9SMlDFtSaWcj6Z8V9/HICDnls2FgnuLznBXww4p
         6snmdRCdSEuCc6aQnsWjc2cMPKwpaSRio8NKUZmUCm4qv0jybc+2GTvTOfosR7ZSPDGH
         J8H7u7gvVoRhzbOYL57IJGZujPjwoYSKuRkRVdro1b5v6HTcj2LCdPo81G1vaLdfglOp
         HxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194177; x=1776798977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pa9Tyq9G0aEPQgad+vwhYFPvxVvYUvSmDxYTMccNEa8=;
        b=l0N8ziNS/TR7FRgDRpACTKIbrqkmq3UDc0p0gbpVVD9IHnp5EOAzP6n8Wwm57+bJ9z
         AYs3eUbuFZgtEXwUfmxuDUYKlbYPoyxknueNYyeZCZTwAMxem8zcwMWNxTK4ywrUhxqE
         BJldMtILrQ6TGnHt+Bni/DdAbk5eWMu3YJYjQFBQtdADo6aKe8Gau9BHP5tyv9L+FQ/I
         6Rgv+vgm7rMly4SJNqfk31oxKqBwc315wuoK54mpUEV2AVztdkj+i2wv55BN2fBZSWP2
         w6z9wsGbeQa8XQ3dEyRuQ+gKGAK4DPqnsSqtiSZSVYT5eZ8VmIG/Ilh7hjUSopvtBqRj
         c8mA==
X-Forwarded-Encrypted: i=1; AFNElJ+X4bNBLQ4etACRTIDEb0qao+BPzqug6Ka8pr3+fGu1IaP5+OrM1cBXF4pJL+5t5TghuW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPMyHFfnajXtVj7PySRK2MnTrbEft2OBYsZHQ7DD2V8T2hAss
	R9qJg9gGbn2vze+vNsSfETbniv9S2T9Er0NIZXiOdeNbaPxTKJAMfjQsvzgD1b31z7U+HfvUJKo
	DP/dsgKTrX9hLiLdDO9p3TXON9mQ3CSs=
X-Gm-Gg: AeBDiet7cP4Z50sDPTMcnd39/NDAkmpOwh2hMxoi5DnSB+Ajf3nnhGBXm2RyfaEQrBd
	+we02IQf4aiFEcGjIj97pmT1Z44ljzP+s41sM5AO46F8GvY0gT0koWzHt0DFwebLX68mAbcQdtG
	dGjmvY8ZEh8TZdKVxjQqfTlAcW9iWxztcTWuRAXZlThCqGWAkyFlfzWFAaimOOXuiXUTPnnil1o
	uCbVvn51QN7Wtvhwrn0dVUG4h1ZtFnmoM+ZMgF2UjZzcF2FGvE97PhuRfYhnFKC27v7R+attra/
	dNwuHJqvc53d8O+zd7x/nLoHhObXmKImPtrN+MU/yd2aq5Gb60Ky8eVd84A250A7stwnqL1r5rs
	sgBS4PnHc7ltuQuSk2T+/iGjQisNJaR/4kKJ2
X-Received: by 2002:a05:600c:1f83:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488d687bf61mr256552315e9.25.1776194176915; Tue, 14 Apr 2026
 12:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com> <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <DHT3JV7GTOBL.29205LGGNEDSH@bootlin.com>
In-Reply-To: <DHT3JV7GTOBL.29205LGGNEDSH@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 12:16:05 -0700
X-Gm-Features: AQROBzCIKxzyzm1_jzBBwpYG5l-_Hq5ftS9HvYZuKsAkHlvW0CNWB1k5nfXPFjQ
Message-ID: <CAADnVQ+c9h_wuNwj8pjx885oNErGY7bxxCwKi+DiJ0XKSpyYfg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:41=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Tue Apr 14, 2026 at 4:36 PM CEST, Alexei Starovoitov wrote:
> > On Tue, Apr 14, 2026 at 6:13=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
> >>
> >> Hi Andrey, thanks for the prompt review !
> >>
> >> On Tue Apr 14, 2026 at 12:19 AM CEST, Andrey Konovalov wrote:
> >> > On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Fo=
undation)
> >> > <alexis.lothore@bootlin.com> wrote:
> >> >>
> >>
> >> [...]
> >>
> >> >> +#ifdef CONFIG_KASAN_GENERIC
> >> >> +void __asan_load1(void *p);
> >> >> +void __asan_store1(void *p);
> >> >> +void __asan_load2(void *p);
> >> >> +void __asan_store2(void *p);
> >> >> +void __asan_load4(void *p);
> >> >> +void __asan_store4(void *p);
> >> >> +void __asan_load8(void *p);
> >> >> +void __asan_store8(void *p);
> >> >> +void __asan_load16(void *p);
> >> >> +void __asan_store16(void *p);
> >> >> +#endif /* CONFIG_KASAN_GENERIC */
> >> >
> >> > This looks ugly, let's not do this unless it's really required.
> >> >
> >> > You can just use kasan_check_read/write() instead - these are public
> >> > wrappers around the same shadow memory checking functions. And they
> >> > also work with the SW_TAGS mode, in case the BPF would want to use
> >> > that mode at some point. (For HW_TAGS, we only have kasan_check_byte=
()
> >> > that checks a single byte, but it can be extended in the future if
> >> > required to be used by BPF.)
> >>
> >> ACK, I'll try to use those kasan_check_read and kasan_check_write rath=
er
> >> than __asan_{load,store}X.
> >
> > No. The performance penalty will be too high.
>
> Since we are mentioning it, I did not consider yet any performance
> comparision/benchmarking (and I am not really familiar with usual bpf
> performance validation practices for new bpf features). Is there any
> existing test I should take a look at for this ? Maybe some specific
> benches in tools/testing/selftests/bpf/bench ?

So far everything in bpf/bench/ measures bpf infra like
maps, kprobes, tracepoints, etc.
We don't have benchmarks for bpf programs.
So we don't know how well JITs are generating code
and how much inlining done by the verifier, JITs actually helps.

Puranjay is working on creating a SPECint like set of benchmarks.

For this kasan work we should make the best decisions from
performance point of view, like not wasting unnecessary call
and not saving unnecessary registers. btw in the other patch
I think you can skip saving of r10 and r11.
But we cannot quantify yet that avoiding extra call gives us N%.

You can micro-benchmark, of course, but gotta be careful
interpreting the results. It might be too easy to get into
thinking that JIT must inline __asan_load() for the sake of performance.
