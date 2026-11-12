Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524445;
	b=erhokbosKBN/j9/xfSEG1EXMFOmou7eW+XLl8HyLhESRpaxzSAs8BDqfituawQJfZgTn
	 UJd36z2ctCBSkCmrHzpDgol68JhGArMEyOAiZKFDoJkfGffEWMvm2Po9MYOKmdW6CWkPh
	 F+hifq5XzH0PqORPaxtS/fjwKqdE27KTDybhQwzjZW59Bp7jsy1ZGBf1+hD6v+i5EX+Y6
	 0PIZXoG/ElbwCVHJElsajp27oMKlNWgRRXERCgHNRhodezAHQSapWPdLi1GX8+PNjQ0L7
	 JklDocEoKk/dc21hZ1GEKcEvNg8Q5wxynMNub83g6T5MUPFUZziNv+rS3EYWveX78fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
	b=mGk1dMQWRxEmBeNfPWme+JT6SnHFeqXszqY2hDDVoRQGqXveetw62+2+6ivIHlUYsi2u
	 mUs+vR4RRbf1IGBMtEqRm00CcuPqH6n7TkNFFLpac/K5pB3lUwfFb6xmj9FgJovCt2uWY
	 ngU6oP4DHs06aQNlO8J51Hg59Bl0ypzubhpateDwf4AkGgK/g6Xf13dxPlnSae0m+8BuR
	 PcRYNYAP0gHXAw6KpIU5lpHJiPL2AzRboCZ6tgEcN24dfaFpeB96kkNHo9Yq3nhTGcyeH
	 WsYlAdoxMDKxw88XQPgSbQeUZI9xfeAw/H70fechE+SN/nM/eLITECvgod6gYj5/Cww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjDNXoB6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693E606A888
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 23:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2693E606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjDNXoB6
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so119362f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524443; cv=none;
        d=google.com; s=arc-20260327;
        b=gi81Venc4O6unVg1eh5zUxP+ODwb9x9B0L8hGungtn4aXh4qD9Ec1SjJ5MSIVdvgTd
         FjvwKf2C0gOJ3q2ZzViXKX2Xo4YlXFjYLAhuvxR/jwk03ezPk4EUH6Z1DiL5KyIzZmML
         pTjvbdK/+H5DuWSOFcffeLTl9PTa3Dnrwa66X8i0FRerI6LteuhiDDh5OYc1vFWnXAuu
         lPlTa1ElphmQRFacu90gz4iW47g5NYGIg7c5Rd4EzZ+uqnb5B/T2GZLEoDAd5p9mP4Pa
         jWvv2rZ+rhYhpjIHP1HwCwIrcoyLtyQOhSZPL6jfrT7HkKTszpg6l/uVXIX4FzJrG0mD
         c2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
        fh=HgZF0MmzZ5KENX7ZA2I4k4IE1hH9vKK8VCHswuruFLU=;
        b=WiL8H/bzMfpefvqSVVqJMVygDPEzM5M2IkDIRsJ/cGFn9EclsIzaXeF+w93QSz8R8w
         JspFkI61ab1Ru8Azo+enBLOgNQ8vmLXqwQRqYu5PLiVzcNWXYED7c+idwRrzw000Pmme
         BnVWRqNYZekV/839ocC4JbkBg5ytv6WhRTr6sFzUB5y4ti74N6KXi5x8HN/Gf4ZwwG/7
         CnqaXVHxcyDUkuZDktfmW8pw3d9oYA6PLt3IGiqidmWMkuqBxq05eqrHYzGXZ0NFjNKc
         rM8c+ekKL4DX4RNnGaW1PoUTOincTwmnzBYE/vWx3KMeRsV9t/xqtMrRgVVkatb7tZqX
         Aemg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524443; x=1795129243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
        b=sjDNXoB6zcBiHEPu0PrEs2iYorJls7T5etmbz/NfEcTCj55pFun2I3zOD+NvijjUFq
         D8yiW6Uiq2zT4drRfzL9g5WwSV4ljjPc29uE6wvdNUnHImRqP16nNPnTPWyBCkQzNLHV
         q5PDapA0AchXZA16ia4F+ggMZ2/zrtRRYTKgp9xjWIRjxGMGoi7faYMHEmlYnUi3aIXa
         9VxSOqG1BBDzjKyfVJz5o0RTpyFmjH2JMc1a+HIKFSXSXOvPNDQlDazqg0WXpcHJBQhO
         lhWT9ZptbmEspFpTbPm/7iixxbpoXNroTtUoAf3riQTFMIPr1RwbRNSRLOrkDGXrAmiT
         onpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524443; x=1795129243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
        b=hab54vj0Lgxph3G8ERU1nzdrGX5vHZp7ROdzsa1itxqSsowhrzgmjZKzNw1nipss/b
         GhFbbBPxxleRV+lGDyY0cPvQVwIq2bgIkSnbwQ+WZk56/N0FXJKkzVxQQsQ9dL920FpM
         iTvNEUxU37KPbifW2XKuNUyCATmNjFpK8b8d9H4YNpKU+LpZkc9NffNPSFwEXnZBpeRs
         v8bRZ0OZN0YAlc5BbtgXxXBjMzFOUIQDovm7ETEhIuxJ9e7SuvuxK9Dblehc9siMNHv7
         +0dWijMO2IaSiIrT9oWL0KvTUhxGNZkP14i6Pc1uD/TtbG+6/gnYp3BrJT0N1qvDogx+
         DJnQ==
X-Forwarded-Encrypted: i=1; AL+hErFBhWMVtBUycetIVux+PVnAPdu+uqb5P9/WFBjAJdqEPKO7kuQ1tPMrANBXd8VXfPIgo/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SdGEzNiC9uTVjSLtR61JQ7wq2Zr5UCpGVO+4VpEVhoyTpiBDL
	MpqeVgRPJ5qbrQ7MhvdDfHwjx1PIrZkTj/Cxxw6R5gvHRt0/0Xht+2yN8Ncf2In9BURX4pjDkGR
	xFxQlrPrzKxPpuRRZKgQjk9oUV5Taj5A=
X-Gm-Gg: AYBFou3DqjxVugg4LpVDdRCFsaUtroSJAX/4wl3c5EOU+axHd+Zgi38taszMIJjb+j1
	aiTPGBg6ckyhSMQ7mgAEoooICsDNoHOQvreoZMZVjX2mL6Ku9pi2tncMD2l+N9n4v0FfgI6rXb0
	pSIULbr3AyV+kJ3tNZoj6gTZNBrrHK3vNnJ4OzzLLUvM3kMq9zmGxpbewQaBlsEOBXdFUsqSFkf
	kB0hwaU/QwtuO4evpIesUhwRXA5sLMYdw7L5b+xqvI1pqRIYuvdn/YOGhdUVyY3CuJES6maCFH6
	Ua5+YNzlpBZN+FrOickdAvmMWGEXQTkuDbgOhfmPPkYlticQSbmvlgraI8MPfwuocfvEF3yfRQe
	IOhJOIWpXHJ2bcU3/0hxRToTtaRDfa4K7MoGFZYudHN+jOv8dh9Vjomt+0JXvzi4X1X2Mt2ei/a
	ISJYMGQWDagMLXNeJvY6FInIcu/boujbRtCtj9Dq+HJcoFWXYgLBqvXEPk
X-Received: by 2002:a05:6000:4916:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-49c723fc072mr1488764f8f.35.1794524443278; Thu, 12 Nov 2026
 15:00:43 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com> <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
In-Reply-To: <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Nov 2026 15:00:32 -0800
X-Gm-Features: AclHuK-Kr9JdTGalkEgmmfAfdsFcOEOJ-nbAKjHr2jm9SnDPJTrEN9CPnUV0p4o
Message-ID: <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: roblabla <linux@roblab.la>
Cc: Paul Moore <paul@paul-moore.com>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wrote:
>
> Hi,
>
> Thanks for the replies!
>
> > LSMs that need to provide a stable API must provide an abstraction
> > layer between the LSM hook callbacks and their stable API.  The LSM
> > framework is not responsible for the stability of individual LSM APIs.
>
> Understood, that lines up with my expectations. I think the biggest
> thing here would not necessarily be stability guarantees, but rather to
> make sure that the eBPFs fail to load when the compatibility is broken.
> But that's probably a problem for the eBPF side, and not LSM, I assume.
>
> > So, in short, would it be possible to send a follow up to Daan's
> > commit and move `struct mnt_idmap *idmap` to the end of LSM argument
> > list?
>
> If this is possible, that'd be nice so that we avoid this breakage in
> the short term, since the change isn't in a released kernel yet.

can you please send a patch proposing that and we can continue
discussion there? please cc me so I can follow along

>
> > Having said that, there is a way to handle this, although ugly and
> > *everyone* using specific LSMs would need to do this on their own.
> > Instead of using convenience BPF_PROG() macro to define BPF program,
> > you just use raw `u64 ctx[]` access, and then cast ctx[0] to either
> > `struct mnt_idmap *` on new kernel, or `struct dentry *` on old
> > kernel.
>
> So, we already do similar tricks in the software we ship (which uses
> various eBPF program types, not just LSM) to cover kernels 4.11 to 7.3,
> using a mixture of CO-RE tricks similar to what you describe and
> per-kernel builds selected at runtime.
>
> Here's the problem though: We ship to customers, and we don't control
> when they upgrade their kernel relative to our agent. When the kernel
> changes a hook signature, a program built before we could handle that
> new version still loads fine and just reads the wrong arguments, which
> causes some really gnarly bugs that can cause really bad breakage (such
> as accidentally denying events that should have been allowed, often
> resulting in machines left broken).
>
> So what would be really nice is a way to make eBPF code robust against
> kernel changes such that it either works, or fails to load, but doesn't
> do the halfway "loads but silently misbehaves". Here are two ideas that
> have been in the back of my mind that could help solve this issue (though
> I understand that they may be rather large changes, I'm putting them out
> there mostly as a conversation starter):
>
> 1. Could libbpf/the kernel have a mismatch check on hook arguments? I
>    understand that libbpf and the verifier don't know the types a
>    program expects, since BPF_PROG() only casts u64s. But the macro
>    does know the types at compile time. Could it (or an opt-in variant)
>    record the expected prototype in the program's BTF, so that libbpf
>    can compare it against the LSM hook's prototype in vmlinux BTF and
>    refuse to load on a mismatch?
>
> 2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
>    could we maybe have CO-RE-style relocation to resolve "the argument
>    named dentry" to the argument index at load time? This way, adding a
>    new argument could happen anywhere in the argument list without
>    breaking eBPFs, and removing an argument will (correctly) cause our
>    eBPF to stop loading. It does mean the eBPF programs must provide the
>    same argument names, but maybe that's an acceptable tradeoff?
>

All this is not really an LSM-specific problem, it's a more general
tracing problem. And even if we have some custom hacky "solution" for
LSM specifically (but also see my previous replies, it's not something
that's easy to do either in libbpf nor kernel, IMO), the same problem
is still present for tracepoints, among other use cases.

It basically falls on BPF users to keep track of kernel evolution in
terms of attach points they are depending on. Luckily breakage doesn't
happen often and usually can be worked around or be adopted to. And so
far kernel community has been pretty understanding in terms of
evolution of some pre-existing hooks (like scheduler tracepoint I
mentioned before, and hopefully in this case with new argument moved
to the end of argument list).

> Thanks,
> roblabla
