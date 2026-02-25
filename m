Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25E372B2E
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010498; cv=pass; b=Xj8XJA2SKqZMKobJftb4KIvlrVlD18CRfk5ih1Y0PdgRum4hVHxo9Po5TSRX2pBCMT7gyV6UOdcK1b6RG/j9kteY5VcxixFIDI5ageLggqkNIyVp1xRPPoiTC0HeKre60b84AJHzp6ZZnf55ZLvmPbGcz1M/7ca2Cym8iioDy0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010498; c=relaxed/simple;
	bh=8EofT32mw/6E5iWOfo8hMokVZ/qTA8vcogIG3R4jGSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3Af59Lt0m/BMNd1U3kRBDbk/rsW3CTrbYltOzWNIG3F0RcamdTVVbDw22M0JwZB+OFqY+kNztkyBDKnabkQSsgRCqPZP5dKTl5y0vjZAHJc/VWRWYm3cTxBQzedWONjCVVsHMphhKNapaahmwoWy5GoXvvRyXJLSgGWWSBJCoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhZZGyuX; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhZZGyuX"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5069a785ed2so423451cf.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772010494; cv=none;
        d=google.com; s=arc-20240605;
        b=FBANBw0/l+KFOCTEQBXwpvd6NQp/jFuu/lGHsfCRBt855itdl22fLFlGcGi4aFq88G
         xI2gs1/SzXX76wtd9ExXBHiuc0JLyUMMEcOQEti0+0hq0sayncYbr7kfSkPTOrHclq9W
         3ESHOVfkQtUE4gojYjK6a0TW798RaEzJH4pCgKYKMuMtFBZ+N/mLAr/8VbkVnTr+Kpeo
         upDvCzwPDAU8rzFHVzNQeZEsUdcVW1IJdwLBYIfGderGs1rHOpZqFr4K0BeYH+QKo5Po
         r+VZhw1oqecJptrfwHzcNm++zR81tmcZuvmOJaiqPNp34gZZs8JoT0fBO8+cUXsodWMG
         GJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n7sum/s14S9A39h5WhsYyHQGLKHSNdWj+CJqlksp3Dg=;
        fh=vpBFlyp7fY3nnkbH7PMJed+EejH45awxaADZuTqMabw=;
        b=SP3joCNw//YOhhFUUsQw2m7jFeyxsb89K64n/szUJcvi5XUZvNYB9W+pnw43bIYcsz
         ZJkBfnix8hGXFLV3cMTaET0Ne1MqiIcIqFZkTTQIRo6UaatXZ4ZNqT1QBqeDowZLXTOf
         Ref/x3tDi1BEuspYd3DW9rdfygtHkqMN/YWWYnoxvNvECRAIsk4IImK6k7xs+2QhbJkn
         K9BsircFDGt3XVFNxcTpXPYaGXNB7QgDNIztj4OcSCx4Q4h7y2hXOgYcVtz7wP96u+Br
         PEK/WqOrpnF9qvzLIg1TBMfiT+XsCXMPX0lQ10sZvSjx8BzCn0zi09sTMR8MxAC8jkBO
         Wxxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772010494; x=1772615294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n7sum/s14S9A39h5WhsYyHQGLKHSNdWj+CJqlksp3Dg=;
        b=qhZZGyuX+OUyhIgOD5IqKV3jEthGhujuEJ+6rul8ySVt1WYt6dH05hyzM9R0TL708x
         dlPQBcjQERZvcFT6TWEvlGWJKkKhQrBeJ5p2XojsrZ0I/rJNXZ/GfAX6F0N81l9ipv4I
         s0L02L58TsUgiMllILOQEOEi3TPd50WfYD4WJoTfLimG2iMmMyRRfkNrhLKQ0rsjyzLY
         l/eKORAqeeXVk+1qKACYTozhG44FI32DaqR3XuVbmM1t5+KzWsngyoT3qSG7gPMLolPa
         CaOJjQvVFU6UkTVghBPAL7SB4PtyXRZ1zOLT4+3sH7RT+zwbH0AS78S8VI7WBEyhW2zd
         mBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010494; x=1772615294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7sum/s14S9A39h5WhsYyHQGLKHSNdWj+CJqlksp3Dg=;
        b=gxCXJABMEub35He9bBsHqcj3cIUucTMLvL2Ujmyl5cFij8STIcIG36j9mVFHwiwQX7
         cOwlRTrbK/mKq0Xap5LSyhGt9PiykpdZOoEr9IBVCI+zl0CuIyzsIkBd5sDpHzPsgo7+
         h1+ZeoamZHTPfv6yQXJMbcdXEq71ZlF9ZBNYY5yNa1jNt3IgVFl+3uvzLu/yXJmDIueN
         5Gzcgp7CywKOs6KLyJAjwNozNEwZC7IzOA75io0JGKTRIT9eEgJaOcxGzOv2quu0UlI1
         Pd40065DSG20Oj+AkeT8KbK0tJw4YVPl10bgHPPgNL9P/riQ+sW6EOASwxC+WoxVkgwn
         7AoA==
X-Gm-Message-State: AOJu0YxKSUF19WD845GlrTMjlUFl6yTooUaGmayzzFQFTj+kw6cFPYMq
	Xv9aW2w2+XoE9Bkpxni6LnbFAYGmC0BGv4nCftGq7JndcuCy+8cJ55sJ40jPiNod86dZ6Ysblw6
	G/HCuFEPV3qW6V5v4Zly11loiGcV80IEVLzrEreKk
X-Gm-Gg: ATEYQzwi3YuM4C23llCJu4MF3RO7m87uXGrvhDlNOfpZkjqp3+L9rtoWcGfFq8MpLPa
	jGKiq854faS0+9d+2pFxTTRY08eV8JVdUP74RL3RiE05GVWiIlGVaekWz5OUto2FjJoLvnGzNUU
	qVc2x1HiUgAaA/6RdmxBZ9YQ3lEhlFMRxg2Shjue7QMo2WxQ9Ww9RHRd4ztk2nPAmWTtAyPH5Xr
	oJ4WePbfi9gJOIUlhSIH+V6DNX6PgbURtGYIERSK8OmS8AkbowpFt1lOIo7bwisWJYHGr3YKTJy
	RIZGmQqb
X-Received: by 2002:ac8:5854:0:b0:501:5180:3c90 with SMTP id
 d75a77b69052e-5073a358678mr5124481cf.15.1772010494111; Wed, 25 Feb 2026
 01:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224092915.1925488-1-tabba@google.com> <aZ4iBlzQ7kyxByg2@willie-the-truck>
In-Reply-To: <aZ4iBlzQ7kyxByg2@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 09:07:36 +0000
X-Gm-Features: AaiRm51o2vG5gfthjDXQ69EGaenridJm3gKmj3QSL0jeWsHv3kFjksydnvzOM5M
Message-ID: <CA+EHjTyF-0NMrfjX48epH5cjhy=TsDAO23TBU5MRe+0TPCtQog@mail.gmail.com>
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
To: Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Will,

On Tue, 24 Feb 2026 at 22:11, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 24, 2026 at 09:29:15AM +0000, Fuad Tabba wrote:
> > struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
> > was using an alignment of 4 bytes (sizeof(u32)), which could lead
> > to the 'target' field being misaligned in the JIT buffer.
> >
> > Increase the alignment requirement to 8 bytes (sizeof(u64)) in
> > bpf_jit_binary_pack_alloc() to guarantee proper alignment for
> > struct bpf_plt.
> >
> > Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 356d33c7a4ae..adf84962d579 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >       extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
> >       image_size = extable_offset + extable_size;
> >       ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
> > -                                           sizeof(u32), &header, &image_ptr,
> > +                                           sizeof(u64), &header, &image_ptr,
> >                                             jit_fill_hole);
>
> Did you see a functional issue with this or are you just trying to squash
> a UBSAN splat? I can't see an issue with the code and it seems a bit
> over-the-top to over-align the whole JIT buffer just because of structure
> alignment rules that don't really make sense for the actual PLT.

I didn't see a functional issue. I was debugging something else, and
ran into the UBSAN splat.

> Does marking 'struct bpf_plt' as __packed help?

It does. It drops the compiler's alignment assumption silencing the
UBSAN warning without touching the allocator, and the generated
assembly is identical. I'll respin a v2 with that fix instead.

Thanks,
/fuad

>
> Will
