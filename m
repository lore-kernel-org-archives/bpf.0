Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0242B729
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306933; cv=pass; b=R3HcoMCpUpwBWzRfo0ef0dN4SLrLoXwjsP4Bw3QZaQfPabQf+d2nnCh1IqO4uKDKVB+vdhp1jAx2z3fsfZRKQwubNwsasOSwznm7tnAMkFqBVWNNsaJUDibABJoAKNM/35Nt1xT+MOSZOYWVLWM66xdMewHlg2rrCR5pv/WQfmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306933; c=relaxed/simple;
	bh=ikZuoZwFDu6wsRXMDSCtLv45mAIw9IwBWA66ewbZQ8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e69zfa7ao3iKLttnAh1bz9e4A2jM5GLXiY7TMugIdTldP1yLdlnq1n3PnFFmdGM16I6dM3k9M5h274sC2JQEC3QR6DGn9nK5UHJQ8jidP7U3lkeL0pmKO/3ohJVsh+9/IQpb0tD0p7EI2/lXUo293SXG6k3j2L4yg1TRgQWGqBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg8VkZZZ; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg8VkZZZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-436234ef0f0so535195f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 07:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770306931; cv=none;
        d=google.com; s=arc-20240605;
        b=HD0GRVyZcLNgxJj3XWFJg8v4SvFq8GJQZ4hTYKtFcjutTTo1+yHKl2enMWGDnZYcHh
         j0uvtBPvTr16AxmZ7smELmmDtqWGywdJJRoIMZLFw8MFwpTMKv0CFEco8UL59Jh9P1Ao
         8I8rFu6dHNOgLzA6SWKhxJ5/VtBmMUlbaS1rKQl1vJ5HlUOwoFwWKaVhnA75w7vxCBxp
         7f0t6HLa/zF3JnvnoWj3durXVmdGtswRdFZD6q5lTsrRW9VfUkpfyirCZ1j0AIxZ6PHo
         m7xlY0i6i11S32cgCCABzsdWpndgultiAYNQGXVXTgT86N0GB4vQ+BpMGG6jP4Sa4CUR
         F8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Td5+tdEPVS1cr2PW4mwhRLoRhiYDMTcwTL8PbM8B30E=;
        fh=huwHUOrInd5b0Y9egA0+0j+ENp0LTWt2mTNwXJH/M3k=;
        b=EMqTEwHV/2ehx3SxTjUNIpaJ/3Rr20U98/muH/VnH5TyAYRuKiunIHyyRrJub/QNHT
         B0ftP1O9mc6zmbT5wLWDv87+brGSztD6DGIhG9KuphjVCErEXgmpqP+yM+9vk9N9Vk1m
         fnPc7rAeilG8wwKj+oE20+VkbanD8LSimAY213hbrAVGxVHWJBeYUFl0VUt3UE9/PkJI
         2x1VoLpp857HOvrPKYdpFdPXAO87u91tPlKI8jw8L8XQGP/OKjMF0s3qBBL8j4bvBgcu
         1Yuht+zelPKd3L4ASdLL7zf/EmYvaT9aaat19wEQIfX9SXqoO20HCX76fXGnBu6zCIeZ
         ribA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770306931; x=1770911731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td5+tdEPVS1cr2PW4mwhRLoRhiYDMTcwTL8PbM8B30E=;
        b=Cg8VkZZZ8KKR5i5RLrYiB7h5RVRwxjwuyMBSb+Uisu5vhTkgyDBAFapaia9X+kSg2i
         uPrG0o0Smf4oXwlInRE4T4KngEYQy9G3Wf7qNj8hs5MaxyjrVU2iOjv11t1aWhoqhm4s
         76CVf9aUFUzSecqzVWM6VO3ax46vziBQvbJzB/zGwxZV6TupLJ8SqR+Rx32ogr+6JfsN
         4Np5ECYV2DLMlfBopK9+e0bJyxMJkESN8Imcx9anlCRzwQtfJEjqx2YNE4j65GhQkLlm
         VPDeFXYLCC712tKT2rLwuHUayCFUG6pb3O34ot/mwN6QXCbDCO+cDmLIptjRlxlQbWSu
         jvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306931; x=1770911731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Td5+tdEPVS1cr2PW4mwhRLoRhiYDMTcwTL8PbM8B30E=;
        b=Wi2oU+vCk+sdTAs9ky9EC5nrU8lCM5TT2S73y2HPnr5IbtZYn4wH/wJj3Y1KnQ7qrU
         wY8xzE1oDUQ3SGSHEgUnty+iaiipRKeVp8zehipku8WcqYFtpwzBVyRzhoX3lMp1J+2x
         QOShWdDmSzk9sBErf/2THUGIrdpsrIXNlE1Ikl+d1oQvJ3Oj0iqElkXxF+W31FZuRHFd
         v4DAQvhRfjTU5NC9ZnC5Dv4Ui8Vb+T3FGIqBwoH8/dQrOhZsZ68yfPKkIImo7wRF+h/x
         t7le3UWVVAoGmvm/WlwSnoAN/FzcttCziUy6yXXKZ+3BEthdly0/wvMkaSoJc+f81qDW
         pywg==
X-Forwarded-Encrypted: i=1; AJvYcCV/IIHhMDlHGdKGfDKA92LHDqDWnJknNuQ4rn62Otx6EPMnRvBn+dIcnIAHQRzKaUYFqlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/R3VjabLDDuRPAamPxLSTbKXbq/LaN0Cb0pLq7lFYNTAjrtbk
	FRwZsiTi9GoCu3bOYdxzC6zZYMxDAlL1gnHESzFa5g3w7XjCy8c19V6dfAT+EwE6MchV1wv+Sfj
	nYyQhNsJxdhldM5E1NnQVQcWRiQMKz7w=
X-Gm-Gg: AZuq6aJ4PwxaO+EWVIJeaUao6o9KvxRVNM1SDNqTF7sp9D7u+Eu/staRKqi1vl+xVop
	p+ky+2KQtOy93JRUC3FX+lDgD7pvXuzi+GGcBI10Q9NtmO37ZDp7O3dzOum+OMO67DQX8/lovYK
	4vCSXLxELXtrF2TRNYFpXs7A+2PRaemdfzUKHq0v2PzoUK5RpXDdnI5tLFgxUigSJ/M2egNQCmC
	njt2QHBXX0g2pRNDindmxIsXnjwMm6BR+C6AX0DIv/e9z3BZZT5IQqhYHLBG4RMQQwWwVRRP9uD
	DGjpcVjNenmwxisVWjusROdbRLi7VXQ0p2ZU5g27PxTjuo5mwjMZBHhlNIAHc9czGJKZUFlK
X-Received: by 2002:a5d:5d0d:0:b0:435:e3bd:5838 with SMTP id
 ffacd0b85a97d-43617e3c9bemr9065339f8f.25.1770306930875; Thu, 05 Feb 2026
 07:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
 <aYM9YUl6xf9I2x4c@krava> <CAADnVQJPbnVEDYAAy4mUP7NmsGkUmeV9B73V+Bc=LYb8r8Zrow@mail.gmail.com>
 <aYRa_CDL1RqIR_8S@krava>
In-Reply-To: <aYRa_CDL1RqIR_8S@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 07:55:19 -0800
X-Gm-Features: AZwV_QipOgBLes70nSxscZOrEJXWlHyMrHEfcwSShz27Cvyr7P8AKnGRdBjQF7A
Message-ID: <CAADnVQLJJn=bSDvQrjNyyeNdLOZABKDjjR_3j6DG3pgbsJ+JXA@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Feb 04, 2026 at 08:06:50AM -0800, Alexei Starovoitov wrote:
> > On Wed, Feb 4, 2026 at 4:36=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> > > > On Tue, Feb 3, 2026 at 1:38=E2=80=AFAM Jiri Olsa <jolsa@kernel.org>=
 wrote:
> > > > >
> > > > > hi,
> > > > > as an option to Meglong's change [1] I'm sending proposal for tra=
cing_multi
> > > > > link that does not add static trampoline but attaches program to =
all needed
> > > > > trampolines.
> > > > >
> > > > > This approach keeps the same performance but has some drawbacks:
> > > > >
> > > > >  - when attaching 20k functions we allocate and attach 20k trampo=
lines
> > > > >  - during attachment we hold each trampoline mutex, so for above
> > > > >    20k functions we will hold 20k mutexes during the attachment,
> > > > >    should be very prone to deadlock, but haven't hit it yet
> > > >
> > > > If you check that it's sorted and always take them in the same orde=
r
> > > > then there will be no deadlock.
> > > > Or just grab one global mutex first and then grab trampolines mutex=
es
> > > > next in any order. The global one will serialize this attach operat=
ion.
> > > >
> > > > > It looks the trampoline allocations/generation might not be big a=
 problem
> > > > > and I'll try to find a solution for holding that many mutexes. If=
 there's
> > > > > no better solution I think having one read/write mutex for tracin=
g multi
> > > > > link attach/detach should work.
> > > >
> > > > If you mean to have one global mutex as I proposed above then I don=
't see
> > > > a downside. It only serializes multiple libbpf calls.
> > >
> > > we also need to serialize it with standard single trampoline attach,
> > > because the direct ftrace update is now done under trampoline->mutex:
> > >
> > >   bpf_trampoline_link_prog(tr)
> > >   {
> > >     mutex_lock(&tr->mutex);
> > >     ...
> > >     update_ftrace_direct_*
> > >     ...
> > >     mutex_unlock(&tr->mutex);
> > >   }
> > >
> > > for tracing_multi we would link the program first (with tr->mutex)
> > > and do the bulk ftrace update later (without tr->mutex)
> > >
> > >   {
> > >     for each involved trampoline:
> > >       bpf_trampoline_link_prog
> > >
> > >     --> and here we could race with some other thread doing single
> > >         trampoline attach
> > >
> > >     update_ftrace_direct_*
> > >   }
> > >
> > > note the current version locks all tr->mutex instances all the way
> > > through the update_ftrace_direct_* update
> > >
> > > I think we could use global rwsem and take read lock on single
> > > trampoline attach path and write lock on tracing_multi attach,
> > >
> > > I thought we could take direct_mutex early, but that would mean
> > > different order with trampoline mutex than we already have in
> > > single attach path
> >
> > I feel we're talking past each other.
> > I meant:
> >
> > For multi:
> > 1. take some global mutex
> > 2. take N tramp mutexes in any order
> >
> > For single:
> > 1. take that 1 specific tramp mutex.
>
> ah ok, I understand, it's to prevent the lockup but keep holding all
> the trampolines locks.. the rwsem I mentioned was for the 'fix', where
> we do not take all the trampolines locks

I don't understand how rwsem would help.
All the operations on trampoline are protected by mutex.
Switching to rw makes sense only if we can designate certain
operations as "read" and others as "write" and number of "reads"
dominate. This won't be the case with multi-fentry.
And we still need to take all of them as "write" to update trampoline.
