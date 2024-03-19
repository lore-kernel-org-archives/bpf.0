Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDC81AA7
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865252; cv=none; b=hxickZwStKBsa3hKUnvSJz/gRMuC8Di0IvPFjELUDtb54wcziv5UkbGHuiC/etHns9Q/+W9ze4Y3HASwh0OdNpk06ffyoCQch3ZwWbXHbWLePYO4E3FmPkr0sYt9yiNei+783T3KiTU8lMvWtxBIH/JVKgVzfEBDdvGX85TCV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865252; c=relaxed/simple;
	bh=Bdz6oPIjJS3xdaircPapK+jAu6AigplYSAGaowwxHtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3e6agXNpMX8iVZ7GOJ+XwS6AEtUp3LQW+GqUms8ozuj+tUwUhdccls1Z1z3Re/hw6DuvHXS/M8V29MEzuuZVFoStWw1ffSaNc+WOqCkl8qDGrBpfpcbulQXoBk1E6xo0AJ0cNxonfOiA5tjxKKj7O79fZ85i2g+RV1WS18sEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1pQaHMH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1pQaHMH"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6cadfffdbso5279112b3a.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865251; x=1711470051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/1MK+K1XKwosILrubtkCE+2IstjKrSSL7BD8tpoRmY=;
        b=V1pQaHMHtJFedj6l+moUciI24VKkeDKjFrqxNpTdpme0yROLPau0fAfuuS17APIDQ2
         T+zKuAS4Dl1ZF2+n4UdCaKVT3OOs1kLIP6fy2SkE7+RWNm8ayj3c42RsKGksweizx2Dn
         J8sDRbZgvM12AB0p1ABsp1EpwJIM8588LYVc0i/CJX7GtoGxVCN2ODyOXHwWtPvIL/SP
         oVq03j8/rZFRtDTQkQrITXxEIgCYLhyJ0xL6MALUoTZLmHa8taj1BQampBzGUdpifw3S
         1n+6zkd8Ysg6BaQYRr0J6zygTNxoseYKvVMX40fhwgfPPe4q79PpUUrrFjC18CIIkUHG
         f5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865251; x=1711470051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/1MK+K1XKwosILrubtkCE+2IstjKrSSL7BD8tpoRmY=;
        b=XfXwFIt9VBXLjrdxpz1A3LXgKsbtGn0KgT3uRuayThuGwdg8AWcpxwwVR9unh3Mqw4
         tVBa2xFNVhU5wec61Onhjyx5HmYCRrOs8Pia+8zSJ0sDglnBfWXDusbOVni/MV2rq/jB
         2Nbx0LWq13vtklGHskBxsMRCb0069g3XQmybNk2jrbaKah3oQRg2PXgRLl7RuRyDsjsb
         hHT2Gap7AQd2it5N3RUmYwmuYQt/Vldli2pq8k/PVTGHSPrBO6YuOw9In1/L2m01Lbfr
         ghaXiaaI8CIl1khnFZfU+tPDtJjg06hw1mXOAouXA06oI5UvLPN1wLKjOsTuvU6p4HF+
         cDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyz87ueS1y90fSMagMfU+iS2ZyiLvLOuzHLtMqVN8lBaEBiYZsHe2dEWetAOsmnzatBlNC5H5d3hbyrIjuQhbQpQno
X-Gm-Message-State: AOJu0Yxbvpyv6OOhZ86h2farR9Pifbd0vKwmq3hU7pRnYII/2HDMJP+Y
	aPIakumoqOLxMzW83IyE4fg2ttOBy7vG4OE7ALGizbOfGM2N1V7K1HEZRt8cK7c/fgCeQ0aqWXG
	LeISXBJ24YmwtTbEO9f7I47HuN/0=
X-Google-Smtp-Source: AGHT+IFXt+BkaCYgG5pRyJeCU9wHs6xPxA2mFZMJTExMgt5uJ4b02zYY0LehP1MfyOPGn9oZQ6+ahDCbIawK/nOV85w=
X-Received: by 2002:a05:6a20:7da2:b0:1a3:63fa:f760 with SMTP id
 v34-20020a056a207da200b001a363faf760mr6669900pzj.14.1710865250876; Tue, 19
 Mar 2024 09:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318093139.293497-1-jolsa@kernel.org> <20240318093139.293497-2-jolsa@kernel.org>
 <CAEf4BzaKDz-2Tavkb+Uu3zugZHcfVLqO-09F=bEJkWFre747eg@mail.gmail.com> <20240319063219.GB20287@redhat.com>
In-Reply-To: <20240319063219.GB20287@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 09:20:39 -0700
Message-ID: <CAEf4BzZW9XK1Yu2NdzkLu8PwFhPvQhKwe1_S=he2vQq8kRXKGg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] uprobe: Add uretprobe syscall to speed
 up return probe
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:33=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 03/18, Andrii Nakryiko wrote:
> >
> > > +       "syscall\n"
> >
> > oh, btw, do we need to save flags register as well or it's handled
> > somehow? I think according to manual syscall instruction does
> > something to rflags register. So do we need pushfq before syscall?
>
> The comment above entry_SYSCALL_64() says
>
>         64-bit SYSCALL saves rip to rcx, clears rflags.RF, then saves rfl=
ags to r11
>
> then entry_SYSCALL_64 does
>
>         pushq   %r11                                    /* pt_regs->flags=
 */
>
> which should be restored on return to userspace. So I think that
> only X86_EFLAGS_RF can be lost, we probably do not care.
>

Cool, thanks for elaborating!


> Oleg.
>
