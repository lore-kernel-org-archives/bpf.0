Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93C481A82
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941037; cv=pass; b=DX2fkGFgkn/PSZquHmy79yCoSi/VPtFlpA5wgo+YPIuu22Oz3HVbmgCHIrm78Cg5aGITgcUIw1k+NsXrKsifYLY2vMyZAkah/2cKfC0KJnZuS3DFAlDLMNEBdFq8qWbKnZZkTVzIOknJLQ5YFJ9co7fT5hQlbQA1e5g7gqAX9wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941037; c=relaxed/simple;
	bh=lN1hhMdriyj7QPcla6CJIPLYTvYL+HzR6XTrpS85sv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re3ksdPB8O4DHlUT1Clv/S1iueYgYTwsbjke2XNU8xwXNMWmjhICZLFHqoFxLb9AXjONjJedIA8GlA14Q4UemSGVnNa8+LHqMhzfBCVaf9FJS8uZyKjBy9ZUvIsPu5fAlqOssiZhnavRrqOSlWVtYlVxvUWcGKwgcXanHyAQsao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOxm3lBh; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOxm3lBh"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d0d5ae11so84079961cf.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 04:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790941035; cv=none;
        d=google.com; s=arc-20260327;
        b=FxEZMge0xTmCHQ2pnMqzr3e0YGZk/8ir+OBIX1LTZYttHrwtjXFaWkZT4Cd3wQB2nS
         kRtLQs2ihKJf00slyQkN6aHq/SnR9SRvSkXMEn0H7tY0P9FkZinGqpO89XP7icJY2+3i
         msQBUEM8LM/tocf6AwQjPx4gCQKJboK4bBRUAiDjxT8+0l70xC8yMtknCLvrSFb9xilR
         hsRtweElVf0nGQUVgiOWZyED73zIySOI4Q9Jpc7PtKsNmCreiGiD/V1dXoQEN3m6wsVA
         P44MlZkAba2mJs0Jc0YyAKFjt2dLUDpeaPaotpjoW2wQSmxINLYyEvkYtTdjbzxQ5s9P
         VKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sNFw6EjaVpez377CmXHJCYISmJpkLOWj2a4mkkpTO00=;
        fh=Rq/endMIsONs0HUYHQXRgkYmwJOG10loodILNn5MtOE=;
        b=msdzaGCTFCL6fuvkAuj/PA4a3/odblGpIn+1VjZe1zid8bkYkiskdHcBOu8vJ70Wqe
         gPlEm4pJz9c/58iu6N67yfHvH287WveZgJg39UXz27ifzMY/Q/5vRTHaFe6tT0BvvbnB
         jPFWfwU/Tp0V6Ouj6ioQOvxBB2FLiu1NRC/YkYdarDs+zPrRge+2dxVdjJJKqn78h239
         c49LlZe3aGcgr/V4GznBFgkWPhi3WXwV2QGyuJJsLkOHBdN/9y3deGnb5jxEDXe2rw1u
         0dvt3LTfVIbTdN2RhNz3Tz39J54gdSXrwx6DcAqZ6F5nSQafpxpHOSSzAPXHRauAjI5o
         ysdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790941035; x=1791545835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sNFw6EjaVpez377CmXHJCYISmJpkLOWj2a4mkkpTO00=;
        b=lOxm3lBhcOMupkYwjD+meejO9XF0MKqtFIwKE99SPn7gnmFKRDO40jNo8I3ojztBo6
         b9wzCD2cw5yrnPVsZDQtPe3p2f1TSxbCjj3Sr2sKK32Z3apQ5Z7pl6+x7j7J4/IQdp2C
         EXfu9BduyuN3AbQXTDDYqsTmb17oMyd8VMzLWe5I+BVUKnejH3A3Zvo52YeXjpTZKoHH
         mXiBST7ngy+Ck90xLxEtTN+ccuNmSDdir8zyliz3CqI6ggVk9ON/+MpwI6SZm3si4B3W
         oj4KfcWOxkkuzgTp3svVTIU6lesxF4zzxX0Dt7bS5DDlO2DYiH3ZHEXjc19FzJbdxI32
         m9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941035; x=1791545835;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNFw6EjaVpez377CmXHJCYISmJpkLOWj2a4mkkpTO00=;
        b=T5YlnA0mnaNQevDHT15vKlSj1oMA1ES4zNng5sCansbwcSfyvfTmVZqEhqSV7scQO3
         0fmwohrxFDrJ/eIINi3BTYpJudam1A1+hfmvYTIPyxvbl1OIyH5MZCKm4tYZnI36f1Ho
         K6uCk707/ppKzl4FVCqIbcOfO1fK+pGauaYO3k/aMjowbPDplm1pvv+K62rA/9FAguYd
         u9V4p16nD/c96YlejSOllB8m/3ml3+4NXz/UY8YjrzNsn9lmP1kDnyUM69jT52dWXGLe
         1B2rpWxyEEabMjHusrQZFxb8GqL2HYCQXHC2Gv1wD8l22PhzLWQ7/rXse1/2bOeXUcMR
         4VMA==
X-Forwarded-Encrypted: i=1; AKwUvBzvKih4L3yZpq3thxfKvc02cFfB7ibveBtbxK1CaJpWTu0DRx5EkN3iloIb9eGg4x1pBlw=@vger.kernel.org
X-Gm-Message-State: AFuF++nio4stv+ILAFi1qAYFDtuaAwZglBPPRrMtFC4V+wT9UvNIAyYK
	+2FyYML8Mbjt/jdHgGGNZgG9z7syX0p2An7EfUrQ6mCBcfrKRDzIGEzHg0VS/E4pOwnj727MV3c
	k+RQQSn8CYh+Sms+KPGSoExWTApeGEyE=
X-Gm-Gg: AYBFou05lKHFMckMeeFsbLXQgUHj9L0oO6OWzCOecjSrwllgFP1dsmycmOcPkyBYVPn
	UKSvKAcszpLm5O4rrL3b7h7SWmyC8N8xw0L26tR1PzHi8X9JBxaRNkghldCBDS0gg2HcKMpXMC4
	KWiGjkH9hgNaJvTgtn0+HSy6eTnArt3JaQ1y2XEYsRfOhfptrMO+bbmwGG97c0pUJjurbfUgenP
	1B/pwE8H8NP7hc1TE65kM+iLt5A+Sn7Kg0LKrsfehtwvZI5tt4/7EaDD06tRNMk7sng/HpeJi/S
	kEp8s6MdpyNrVF4VesSiPahh6r9o0gN3OtalfnmOQVuAav2zDONTgH/i1nNdKB7aAjf5tnQ=
X-Received: by 2002:a05:622a:4d45:b0:533:96c9:7ab6 with SMTP id
 d75a77b69052e-533cbdb4c73mr39682471cf.54.1790941035224; Fri, 02 Oct 2026
 04:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002044050.1277356-1-thepacketgeek@gmail.com> <DLUBA9JR5QHY.31UKYQQ9EYMDL@gmail.com>
In-Reply-To: <DLUBA9JR5QHY.31UKYQQ9EYMDL@gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Fri, 2 Oct 2026 12:37:01 +0100
X-Gm-Features: AclHuK_xXspU51eUha2NYmeyNcOU_aQLhOQFxxEdwFOzhD_cXYtGDGcItbka9NM
Message-ID: <CADvopvZPO1gDMDhDOPcArjRJ0cPpSUZ5suMg-1kwRi+_-Xeitw@mail.gmail.com>
Subject: Re: [PATCH] bpf, arm64: Fix text_mutex critical section in bpf_arch_text_poke()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Breno Leitao <leitao@debian.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 01, 2026 at 09:40 PM Matthew Wood <thepacketgeek@gmail.com> w=
rote:
> > +     /* pages of the bpf prog pack are shared between progs, so the
> > +      * set_memory_rw()/set_memory_ro() window below must be serialize=
d
> > +      * against other pokers too.
> > +      */
> > +     mutex_lock(&text_mutex);
> > +
> >       if (plt_target) {
> >               /* non-zero plt_target indicates we're patching a bpf pro=
g,
> >                * which is read only.
> >                */
> > -             if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target), =
1))
> > -                     return -EFAULT;
> > +             if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target), =
1)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out;
> > +             }
> >               WRITE_ONCE(plt->target, plt_target);
> >               set_memory_ro(PAGE_MASK & ((uintptr_t)&plt->target), 1);
>
> The lock hides the crash, but set_memory_rw() is the actual problem.
> The page is shared, so it makes 64K of other progs writable and
> executable at the same time.
> Use aarch64_insn_write_literal_u64(&plt->target, plt_target) instead.
> That's how ftrace_rec_set_ops() and arch_static_call_transform()
> update 64-bit literals in the text.
> It's atomic and writes via fixmap under patch_lock, just like
> aarch64_insn_patch_text_nosync() below.
> No need to change page permissions and no need to move text_mutex.
>
> pw-bot: cr

Thank you both for the quick review! This
aarch64_insn_write_literal_u64 makes sense,
I'll test and submit an update shortly.

Regards,
Matthew
