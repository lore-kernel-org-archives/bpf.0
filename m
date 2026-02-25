Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D33393DD9
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017271; cv=pass; b=BQs5z8tN7phtYOcXD0//CQGttweZ/kWzRnpmIVHovjAZ+JZrHztY2NpuC9E7eoel8BI+XVptFaej2pOUkY5OwT4H7p3e2gzTI907aMesOG/HahY+7n+XpBS/tlFeIsOAlK5UApxev8vG05oX6UPejD5hXERNv6s59XMXMPVjEtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017271; c=relaxed/simple;
	bh=P2a5OMgtYUwIpmftFM3FyKxKU1phRRUzi6P0wXa6QvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqUoqnDW+qrR5k+QU2Y3gOk7uMjHm8zIpxLq0cafpgSh7oqR8EQQxPW4UrOUgoiyk797qsz5TBxa0QEqwWZ9eRqzZtdOD61IAkXfEbWEx/pZIZBjn8wdu8UuqUQj2luHvfbimBi4qirFcTOhqfu3HJAyzZhy67ZwtE+vfyU3JPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmPrwo7Z; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmPrwo7Z"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a355aedfso412531cf.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 03:01:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772017269; cv=none;
        d=google.com; s=arc-20240605;
        b=K9h7UJDMHzZmxYiWkXyPNkdUk1BueAJbjqogEKaF6OXrJJtyfHcJw68URg2NFdKoNj
         EFwn+O5VMbnl5QDuKjswNmERVx2Ces8f+YX8T9daetxagasKaRHn7u7wTy7HHWJA1py5
         sNg5H/0OYMMjgfhjnuXRzT6fJPm9+IyDDgv1J/LtMXlrE4/Tu4MA+wdjyi5UrHKZpd+o
         2oVKgRWK/PG36zpnUTahpQ+FLaK8Pkfkn9EvKpI2E1PnUbCBog3NdOfU1BqYJJAdAZb0
         RSlnge6IM39ckHNp7o109wPwp5cbfppr+UrrYRnpSbh/j2A7eOeAx9EFo77yyZMD7TIn
         XT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h6JvQdVhQWfInPA/Myzv9RmVQ9qHhQNHo4KQIihmpPM=;
        fh=7RMAbqhRi6PejUh1ds7yQrk1LmBalcx0x3+adTMXIsU=;
        b=Lzlo8Knk03QhS+/BcLftnKAP6sdt/hu8fsrTQOysdj+hmqZ/lY0o13qeYPRBeZdVXk
         k7JPW/zLc4hOY7xlWYDIb4W1Tu3bv9m9XoSpQi+JviA915GSG4GYy3yJEzz61xaJk28a
         MwMFDu6hqnzW1Isi/F0m6OSJQzHTYBQyBx7fiIULaX93f87ANfWW0o7/TRwHdxB11U21
         r90DzzAYvnMrPfhKT+C28qgVWHPnmuoEZ113yRg0LoBocKh4zFZlBfCukNDBq+16L0YL
         fxdox/qg3C5vKu+uFfP8j6LrFH3v2l8U+GGVLa4RVoZw3e/Twcm9mgctegmffmBpfQXA
         h9eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772017269; x=1772622069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6JvQdVhQWfInPA/Myzv9RmVQ9qHhQNHo4KQIihmpPM=;
        b=vmPrwo7ZdFm4w413fGwKTI/06XqQeXEtK7+3voLf0EiHccJe6di0B1vUZcYpsV6S0L
         rnfiK0nUzJuqm4o7MA+McIO7tXCbOPG+Y3f2V8GxusbEkhmH16CrhEkJtbpI6+j1bd9i
         q91AbaaSbmUAL9sJgJC47F2SMX943cHF1+L9AuWjCMXKukt5JDX1TiFjeXCidjev6jDe
         hxEGUpY8fhXoJ8A1LKL8yfd8t+fNsy2lx0TDH4xCndYhTLuOyMY4y2usXFsA3ohDWkra
         4CVw5OVFfvnM7om3Y7IgNU1fZ7S/B+TupWYYItS/VEWpjlfq8dJmGahRaFhb8ozURkEY
         QsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017269; x=1772622069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6JvQdVhQWfInPA/Myzv9RmVQ9qHhQNHo4KQIihmpPM=;
        b=FdYOPHLwq8ZvXLsgShAqGquB7pXr3x7houbk/euajrHtbEGUXirF3KXHbDdSUSaEeF
         ToQMk3ND2E/XkTp4qCbf2qIgOkPmeMgG0sQcS+K1q7Nlzp5KNOyhVHYxJ6swso0IT7ZL
         BXjXqBSk6ECC821GNZWDk0FHV2Eom1sxP6ynvIG2dJSl87hBambDNvf5EhiVTYm/hogy
         7g6iV8rhVv62NBEavd2WZ5HgmqzN4guoYhFLSzFa1icqxsHWFoDSW9l4tx+lfevYpNGe
         Zx+uZrf5bhz3YBE1YuTUWhkru8uGq5UYdreXPI+ndpDlGmZfqWe86AvmlPfEazFQgj/s
         oJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNVugfMakfOOzuWAb+cAhEkGRtcryrOIjL+5mJkOMT+ea0qbH5EVYt+++yNqX8m8GXoZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2wEFR4iKnL19SNkPswilkGKXcYytwva8R7vboRPBWa0LYKue
	gj8c6lwZegz3QpvkN//fLkEgReWG1iyKeGQ73iXqvCmjyqdmn1sKyxIWgFAUM1Z5IW6LfuonB4C
	/OsJb9aUBsAv/+KSHIIA11y+QkP/fzqfxoZJ980oo
X-Gm-Gg: ATEYQzymDp1Km6I+WbhjOLieHQUfHAQxwi8LZR//lhOV0o6XrCNt7pWUBpiLBKnC52H
	7Yx+6dZ99/B2RCallbhobxPY9vYaa3qz40qIM+mALAEQMG5lkd301l49GPhlkLCetffirNhcBek
	aTkFnH66JzjMJBpWVPj5sWKJhJqHnL10/9GcDUzU/CAyXM3lbOcDKBE2MmnqjVLyZTymRYFSY4X
	mUf3jkHYMO2Tmo5Yv6KRTyLBf+8k4QkaSSW02goD5kn6QrPMKg4T+iyJf1hDeByi9XfhNrnSLzl
	IC+iZRr5
X-Received: by 2002:a05:622a:4d48:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-5073c33f79fmr6685251cf.8.1772017268469; Wed, 25 Feb 2026
 03:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224093128.1926610-1-tabba@google.com> <c402e95a-26d3-47eb-8249-52ece97989d3@huaweicloud.com>
 <CA+EHjTyXWqnr4Cu_cZyxDCVNCxto9pJN0WS18S_ri824oQhwug@mail.gmail.com> <2d0c6893-d4a5-42bc-a480-55bc669da130@huaweicloud.com>
In-Reply-To: <2d0c6893-d4a5-42bc-a480-55bc669da130@huaweicloud.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 11:00:31 +0000
X-Gm-Features: AaiRm53jgmE7BvI5lAIMDYWme2AOTmQ1Io37wCuBgLmE_qBzXHY0ykNGDt8nNF4
Message-ID: <CA+EHjTwsrmEjG=n1VzucyiCq9ZURj_3QnMLBQZ2Zsj6qwpui5A@mail.gmail.com>
Subject: Re: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jean-Philippe Brucker <jpb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Xu,

On Wed, 25 Feb 2026 at 09:46, Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>
> On 2/25/2026 5:08 PM, Fuad Tabba wrote:
> > Hi Xu,
> >
> > On Wed, 25 Feb 2026 at 01:43, Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> >>
> >> On 2/24/2026 5:31 PM, Fuad Tabba wrote:
> >>> struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
> >>> was using an alignment of 4 bytes (sizeof(u32)), which could lead
> >>> to the 'target' field being misaligned in the JIT buffer.
> >>>
> >>> Increase the alignment requirement to 8 bytes (sizeof(u64)) in
> >>> bpf_jit_binary_pack_alloc() to guarantee proper alignment for
> >>> struct bpf_plt.
> >>>
> >>> Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> >>> Signed-off-by: Fuad Tabba <tabba@google.com>
> >>> ---
> >>>    arch/arm64/net/bpf_jit_comp.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> >>> index 356d33c7a4ae..adf84962d579 100644
> >>> --- a/arch/arm64/net/bpf_jit_comp.c
> >>> +++ b/arch/arm64/net/bpf_jit_comp.c
> >>> @@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >>>        extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
> >>>        image_size = extable_offset + extable_size;
> >>>        ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
> >>> -                                           sizeof(u32), &header, &image_ptr,
> >>> +                                           sizeof(u64), &header, &image_ptr,
> >>>                                              jit_fill_hole);
> >>>        if (!ro_header) {
> >>>                prog = orig_prog;
> >>
> >> Good catch. build_plt pads NOP instructions to ensure a 64-bit relative offset for
> >> plt target, but it misses the alignment check for image base itself.
> >>
> >> Acked-by: Xu Kuohai <xukuohai@huaweicloud.com>
> >>
> >> nit: Add check for base alignment in build_plt, or a comment to clarify?
> >
> > Thanks for the having a look and for the Ack.
> >
> > You're right that build_plt() assumes 64-bit alignment when
> > calculating the NOP padding. However, Will pointed out, over-aligning
> > the entire JIT buffer just to satisfy the C standard is somewhat
> > heavy-handed. I didn't actually run into a functional bug. The issue
> > is that UBSAN complains because we violate the standard's alignment
> > rules.
> > I'll dropping the allocator change in favor of marking struct bpf_plt
> > as __packed.
> >
>
> Interesting, I think the plt target should be 64-bit aligned to ensure
> atomic reading on arm64. It can be updated concurrently by WRITE_ONCE
> in the bpf_arch_text_poke function while the ldr instruction in the plt is
> executed. If it is not aligned correctly, the ldr may read a half-old
> half-new value, causing the plt to jump to an invalid destination.

You're right. I missed that target is concurrently updated via
bpf_arch_text_poke() and read by ldr. If target crosses an 8-byte
boundary, we lose the single-copy atomicity guarantee, risking a torn
read. So I guess that this isn't just UBSAN, it could cause real
issues...

> To avoid over-aligning the entire buffer, how about fixing the padding
> method in build_plt to just make the plt target aligned correctly?

I'm not sure about this. If my reading of the code is correct, during
the first JIT pass, ctx->image is NULL. The current padding logic in
build_plt() looks like this:

        /* make sure target is 64-bit aligned */
        if ((ctx->idx + PLT_TARGET_OFFSET / AARCH64_INSN_SIZE) % 2)
            emit(A64_NOP, ctx);

This forces the relative offset of the PLT to be a multiple of 8
bytes. Therefore, it assumes that the base pointer (ctx->image) is
also 8-byte aligned. If the allocator gives us a base pointer that is
only 4-byte aligned, target will end up misaligned.

If we try to make the padding dynamic based on the actual address of
ctx->image, pass 1 (where ctx->image is NULL) and pass 2 (where
ctx->image is allocated) might disagree on the number of NOPs
required. This would cause ctx->idx to diverge between passes,
breaking the size calculations and offset tables.

Given that enforcing 8-byte alignment in bpf_jit_binary_pack_alloc
wastes a maximum of 4 bytes per BPF program, I think my original v1
patch was actually the safest and cleanest way to fix both the UBSAN
warning and the tearing risk.

What do you think? If you agree, I will abandon v2, and resubmit the
original one as v3 with an updated commit message detailing your
observation regarding the atomic read/write requirement.

Thanks,
/fuad

>
> > Thanks again,
> > /fiad
>
