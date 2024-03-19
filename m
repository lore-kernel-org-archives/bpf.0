Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535551E4A9
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865440; cv=none; b=d+OSMM7lxlL5TkFYigeCUnCoNlEx91b8BtNqRGKADkbmmsVmDnApD+NqddDhDUE7cfqqKMRQvswsUigoyWBFc3xkYzc/qKJk6th9ow4wwhrre0XQgClYPn7f7j0Lrbsh6wtj/SNpnCQT25HVdhtKggBW6wWGQ/nIluYzooOzb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865440; c=relaxed/simple;
	bh=87VoUrDYui1tpoDhkW94EtKbJnzu2+Y+WixHtAAaOqM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEtc2oek7+g/fUo/eytk/rXzE/E0UCf9n5VnOHGRUxAbFOP0ArDJ+XLmK/Hc9nzHjM5kIw7clQezPJanVpJcrKAiHqhGQh1ZC58QIBmGpdbetM2VFj6Un76646XsakFYJFkHHNtqOo1pxDlHITvE9mX+/UhME2IEyBRwzHP1b8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9gATuk5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9gATuk5"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-568d323e7fbso3487676a12.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865436; x=1711470236; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uIJ+9/9VPiFeCRUyNVmXUMp0kcYaBUUowvKvZUKetJc=;
        b=N9gATuk5EGutEOXdNXZ3gtv2mSI2NvbbF0ATUaE/JcAsnJcc+XgGtnH2otX7mLqIeW
         qD/fdKrDVKXBv2I8CsvVuuIw5L0B/X6LXmY2pi/EKMnpJ/P8YpOdtdHqFfM5EaPsLvj8
         Sj45qST+lFZvAkHFW8Lvs2X9/+pQkCHsRh3ljesBj0rxLrZ6a9rbAGBBR9dLeDjQ86Qu
         nQdStK4yeg0PMoj44acU7GpyewYOJABnQ3zFG0TTNmKcCYSgrTL2SJSSHHLADLg94eag
         bWCWjjlVg5K87LIohtKtZcSjGNxE0GpmRlmWBn1CaS9hxXCzmx/TojAIMyU7KLEfIdsc
         y4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865436; x=1711470236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIJ+9/9VPiFeCRUyNVmXUMp0kcYaBUUowvKvZUKetJc=;
        b=QgUkiPuvwF2YIjswagLPOLvg4JlgIKPDZmI8Ihz4M9bVSWXKEGu/QSmeVIZm5FBmRc
         kC6uA/fsuXFDalVoi0I2bMhPZnSMoy2hOlmdmntOxh6qfAG0TlsSS5ItXWolYk2XHXt0
         we3Nw1ch40A3UTM1t0Hbfi2Z4Gw0NrlYTBqzqR8saQ7wxHYFC/WboTYiRFFXCyskIHPi
         3J7ARClpetkWqVyrOL8Ezc0K1u84yRs+GWZpnMrFs7eydy26sckHji3X3Sox+wIrymLU
         N38HOAViW+RS3N4ws7EYLWVE6BpCumHERrfbDOX1SADaR33G2dcf41xapUb4DnfY/vkh
         Vgvw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KTRAGVDmgg0Wp5cnJNOqr0HBDJWshTNvw3ptu0jpylikGdjlj/YT+bqCPvusGMWbVQ2B0EoLEnVKb8fZ0LMKVIxw
X-Gm-Message-State: AOJu0Yw4NsvNfGp5HV34gyHMo+P5PdY/Cpb3/yEZQO9SRFAgNwNdjvvV
	kbCkkDPYsPCo2O+NReJ68tUxalI1P3AjDl85gcwmNBvj/qAlgLi+
X-Google-Smtp-Source: AGHT+IEd/V10FuGaetYgX2PJj1YuYCSlIHqwtfta5QIseQtS+pZg4eWTykFjTuLTIPjRa2nU1PMGwQ==
X-Received: by 2002:a05:6402:c50:b0:568:93bb:d0c2 with SMTP id cs16-20020a0564020c5000b0056893bbd0c2mr13458109edb.20.1710865436383;
        Tue, 19 Mar 2024 09:23:56 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ck5-20020a0564021c0500b00568d37c53fbsm2886041edb.78.2024.03.19.09.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:23:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 17:23:53 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: support BPF cookie in raw
 tracepoint (raw_tp, tp_btf) programs
Message-ID: <Zfm8GTKVg-vyA-l9@krava>
References: <20240318184037.3209242-1-andrii@kernel.org>
 <20240318184037.3209242-4-andrii@kernel.org>
 <43eaaada2757048eed490ef2bc74d5d310889410.camel@gmail.com>
 <ZfmJm21mKaJN4vyh@krava>
 <CAEf4BzYp+rA+jov+GZsk2BjO2nBUYOe6vCL_ndiGQFP4dxH-=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYp+rA+jov+GZsk2BjO2nBUYOe6vCL_ndiGQFP4dxH-=g@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:09:46AM -0700, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 5:48 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Mar 19, 2024 at 11:19:08AM +0200, Eduard Zingerman wrote:
> > > On Mon, 2024-03-18 at 11:40 -0700, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > @@ -2373,15 +2378,23 @@ static __always_inline
> > > >  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> > > >  {
> > > >     struct bpf_prog *prog = link->link.prog;
> > > > +   struct bpf_run_ctx *old_run_ctx;
> > > > +   struct bpf_trace_run_ctx run_ctx;
> > >
> > > The struct bpf_trace_run_ctx has two fields: bpf_cookie, is_uprobe
> > > (there is also run_ctx but it's size is zero).
> > > The is_uprobe field is not set by the code below.
> > > Is it necessary to zero-init `run_ctx` variable?
> 
> no, not really, we need to initialize fields that are going to be
> used, and is_uprobe *shouldn't be used*, but see below
> 
> > >
> >
> > I think it's ok because the is_uprobe is used by kprobes/uprobes helpers
> > while here it's used for tp programs, so it won't be used
> >
> 
> yep, that's my understanding and why I didn't add is_uprobe = false,
> no need to pay for that (however the cost would be trivial, so if
> necessary it's not a problem to add it)
> 
> > OTOH it might be cleaner to add special run ctx struct for tp programs,
> > (like bpf_tp_run_ctx) to avoid confusion.. but then we'd need new helper
> > version for bpf_get_attach_cookie.. perhaps just adding some explaining
> > comment will be fine
> 
> so when I was implementing this, I didn't want to touch yet more code,
> but I felt it wrong that bpf_trace_run_ctx is shared between
> kprobe/uprobe and other BPF_PROG_TYPE_TRACE programs (fentry/fexit,
> tp_btf) and also perf_event/tracepoint programs. I'd say kprobe/uprobe
> should get its own, given they have these extra things like uprobe vs
> kprobe flag.
> 
> But I'd like to leave it to some future clean ups, and minimize the
> amount of changes in this patch set, as I intend to backport it to a
> rather old kernel we need this functionality in.

ok, sounds good

jirka
