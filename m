Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552653A4256
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594834; cv=none; b=JRBtM5o40QCAmRFEoyx4s7m+9Rgy06arfscLFMSKJXZ4R66k3+aLUt1tv6FHY1ec9DnIsgPpdMeHisx4HO687Wm7eYgA3aMXF13d4xR5y0yhoFsD/nJ8Vu7gaYXxqqI7c5C2zIDO3QpZXaa21McWiXt+PAn1Ww1p/ijJvcspNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594834; c=relaxed/simple;
	bh=7Qn815U1F7r5JmrY/DXFkBxrIFH3iMTiXf1MBgCrFq0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=c1xMi7OCxC4+P5U6mZqWXylTX0RkFgjgpJf5SPfm/uc2s1HYj+/ZwJsK+yjp2Bo+7ky3eEXvH7AWcJex0/lzQ9tKSnIIUL0ILHV1OPidlsochsr/m5EG4Aa05g1OOw5XAoco/uXINe9XXbm/bpKjzHGvwD6cDBsMmFyrjZhJX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaCWl80/; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaCWl80/"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso48018825e9.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778594831; x=1779199631; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiQJpt2VrbtLNSjDrYu3YaKbjz6j7z3fvg88j20xgbI=;
        b=SaCWl80/OfKRtKCMZTPWTkb8x1UVEUE69DlVBuwM7YXrzSkyGMG/vNXWDHoaa9TiS3
         3RfbAcNxVFQBrBc7l3y3imnnqPvzqZrY/m9wo+ppiOCUq47vIIA7DWGQJFw3C+OPjk6F
         ohwttGxwsvAsEvMuE1VXvlRmjbL0PXhwVYew6of+5i00sVUrM4/DgFSpnNZeWz/JwgNs
         /lYQOHtVFCG6927b3DbCtji1Wcz3YxFdDHK7oV+TvMefGLTWymidWWlOnSS/ttXBjukm
         JU3TYeLNP915weRavCSrdvjQrQhFbeNwqXozALoaJM93mwwkbJTN9h1WU+tVyMZv7les
         LHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594831; x=1779199631;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SiQJpt2VrbtLNSjDrYu3YaKbjz6j7z3fvg88j20xgbI=;
        b=ggCOw6XFq6RrvOTGghbTUHjv86Upavf1cSy408zvY1G59Ng7MvfrI6kJqXynRA9ozN
         Wg4pmyjFElKKpzl32jJd9j8t/TadXDKr5xEn5OrOPgc3xFQR6I0u68WmUbdyIhNpu3r6
         JL/RNpwZX3dtCEZJRmNseVIiEaa1aHFR9RRCH/nWiNd9QbhXtUEogN+R+KlcRY2X8cw1
         2yWLGFDXTK3L0CHZ8xF0FUWmrQtlSNMJAF+t/EUifhufGnp5lzofmW4UrGhNkU+7b2OD
         zYFkbqQD6BR5n2EG1oRNVURW+B+lM/Wx2d4HaiLv6ufppgNUmLCmINLY+olXN7j2XV5R
         glkA==
X-Forwarded-Encrypted: i=1; AFNElJ/qGS8iwPxvm5Cmfsyu5D7YpNKlOhgbSu7E9YwBABpKG8X1N4P4qF9mTdJ73U8EEkkki+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5hao76JH867uB5psW9X/DcmILDH7MJ2Uuh3SfH6aGzBnMb++x
	UZwTH3gGzGRt/z2StH90dbK7ZeqG6425eMXkv5ehMf5yWQUCOkgnQHxa
X-Gm-Gg: Acq92OEnnOeBhASvrpg+NE+CSFraVZUSou5lSAL91Rzfm90V12SW5wsmqmKOI5oGjQL
	1zV/HWNxRLzN+DVjCiee+AdoAQ8Wd+996bLcfQrapEVeT3nlkT1qaP8sGCGnjRUHwMxXpMZm+yt
	cHLUzGAkdmqrwHBWO7re2Tg8tXvQgasURwVZ+utMHtskW1Pq4/weuJ0ohWpEvBGh/dO/PGZfUvx
	l2ryyLbLnNHfWnMhEh025hSJo/tCcj3qg96jY43+kJo8R5wo/A4qtU7PmGS1moWCoxEJjdjLWy9
	dhijnWX84ljm8ljfe/1EVUZjCoA49+R+cdWC2IoZcXzEdbrNd45bCJEBxQ0UKDAJ9g5m16iFKEI
	JEpanRDKxKo3Pj7JvcoweIqJQCJKECzei6786sE8x5lAjSSGVscV7oShdrCWtBv8gvohAVl88dm
	hTa6YbUUc3osnUPOMk+Nu84d/M6Ubq3/uKT3DF95X/0FKrbnlMxAS/HGBgt9ifRgxp+aP8x99KX
	RYAWMDzmEVluP93sPQx8+cEZXRx1Tt3NGp7BrtDuQJp4EMLw65yUEXSKHSwAWhgSQ==
X-Received: by 2002:a05:600c:8289:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48e8fe52c6bmr53853825e9.12.1778594830389;
        Tue, 12 May 2026 07:07:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27667sm196515e9.7.2026.05.12.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 16:07:09 +0200
Message-Id: <DIGR8WQ9B6JQ.13C5FY863IJ3V@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>, "bpf"
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
 <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
 <DIGDLA5275AR.128FTQMU7Z8S3@gmail.com>
 <CAP01T74MP6+igNsqhDinYXbk2mFB2zW6Kk6Lb7srrWM8ANojvA@mail.gmail.com>
 <CAADnVQKfMHUZ8YzLkWW--f1G_+mx6bKdvVHUMArYsb+6-esWCA@mail.gmail.com>
 <DIGP5VDNWMJ9.2HXDCVLOPWAMT@etsalapatis.com>
In-Reply-To: <DIGP5VDNWMJ9.2HXDCVLOPWAMT@etsalapatis.com>

On Tue May 12, 2026 at 2:29 PM CEST, Emil Tsalapatis wrote:
> On Tue May 12, 2026 at 12:24 AM EDT, Alexei Starovoitov wrote:
>> On Mon, May 11, 2026 at 8:49=E2=80=AFPM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>>>
>>> On Tue, 12 May 2026 at 05:25, Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>> >
>>> > On Mon May 11, 2026 at 7:43 PM PDT, Kumar Kartikeya Dwivedi wrote:
>>> > >
>>> > > If not, the best course to me seems to be to make the flag behavior
>>> > > default, and just rely on ASan (and Rust in the future) to prevent =
any
>>> > > memory safety issues, and drop the stream based feedback on fault,
>>> > > etc.
>>> >
>>> > Agree that this needs to be new default without new uapi flags.
>>> > How about we tweak the idea further.
>>> > Let all arena pages be unmapped initially. bpf progs will fault
>>> > on them and will be reported via bpf_streams.
>>> > But we also prepare one "scratch page". Let's use this name,
>>> > since "garbage page" reads too dirty.
>>> > When kernel faults we populate pte with that scratch page
>>> > and let the kernel code retry.
>>> > To implement it the page_fault_oops() can have a callback
>>> > into bpf/arena helper similar to kfence_handle_page_fault.
>>> > If fault address is in arena, do kfence_unprotect()-like.
>>>
>>> Interesting idea. So I guess this page remains mapped once kernel
>>> faults on it. I guess we can still reset it to NULL if we alloc and
>>> free a page at the same address, so it's just a drop-in to prevent
>>> further faults inside the kernel, since emulating instructions is ugly
>>> and we're not using asm wrappers that have fixup labels etc. If we end
>>> up allocating and freeing something at the same address it will likely
>>> get reset to NULL (that would be ideal). But even if this happens in
>>> parallel we may fault again and then will just fix up the NULL pte
>>> with scratch page again. We can likely also preserve fault reporting
>>> into streams when such scratch pages are brought in.
>>
>> Yep. All makes sense.
>> The hope is that faults from kfuncs should be rare
>> compared to faults from regular arena bugs.
>> So the stuck scratch page shouldn't happen often and
>> faults on unmapped will still be seen most of the time.
>
> This sounds great, it pretty much retains all arena behavior that we
> care about. The most important part is that it reliably reports the
> first memory access error, which even now is the only one that is
> meaningful. The delta with current behavior is that subsequent accesses
> are not caught, but we don't care about those because they are very
> likely caused by reading zeros during the initial buggy access.
>
> Would the scratch page be actually mapped into the arena radix tree, or
> just the pte? Because if it doesn't then I think we don't even need to

Just the PTE.

> worry about resetting it from the arena side. Just allocating it at
> a later time will overwrite the scratch page PTE with new valid page,

Which is fine IMO, and how it should be. Alloc and free cycle sets it to NU=
LL,
so be it. Users can also do it in parallel, that case will just cause a fau=
lt in
the kernel again and we'll reset the PTE to the scratch page again.

> Until then the page is accessing the scratch page, but again we only
> care about the first buggy access.

Right.

>
> Small nit: Maybe default page instead of scratch page? Scratch page
> sounds a bit like scratch space but we don't actually use the page to
> store any data.

It likely should also be zeroed out, to preserve the idea that reading
'faulting' regions returns zeroes. Let's just go with scratch page term.

I think the main idea is we install a page fault handler after the KCSAN on=
e,
from the fault handler, use bpf_prog_find_from_stack() to obtain the first
program in the stack trace, which will be the one originating the fault ins=
ide
the kernel. Then make sure the faulting address lies in the prog->aux->aren=
a,
(likely including guard pages in its range), and just install the PTE for t=
he
zeroed out scratch page at that point and continue.

I thought about various races, to me it seems it should be ok. If parallel
installation wins over us, it either installed a valid page replacing scrat=
ch
PTE, at which point we just let the kernel retry, or installed a scratch pa=
ge.
If it races and replaces existing scratch or valid page with NULL after we
checked, we fault again and retry. In any case, either the kernel continues=
 or
it ends up faulting again, at which point we can handle the fault again and
attempt to fix it up.

We likely need to make sure the existing thing is pte_none()  only install =
if
pte_none(), otherwise leave things as is. If racy attempts unmap and set sc=
ratch
or valid page to none, we will fault again and reinstall. If racy attempts
install scratch page or valid page, we let it be as is. More importantly we
shouldn't install scratch page over a valid page, I think.

Our PTE installation likely takes the form try_cmpxchg(pte, NULL, scratch_p=
age).

One corner case is that we may have cached scratch page TLB translations fo=
r a
range we are trying to alloc pages over. Typically the way to eliminate sta=
le
TLBs would be to just do flush_tlb_kernel_range(). In this case I wonder wh=
ether
we just skip it to avoid the cost and let the stale TLB stay, since it like=
ly
came due to program passing faultable memory into kernel.

That said, a cheaper fix would be to install PTEs under the lock not with
WRITE_ONCE() but xchg() so that we can inspect if we overwrote an entry tha=
t
had scratch page and only do the extra TLB flush in that case. I would be f=
ine
with either option (leaving it as is, or the above), as long as we document=
 it
somewhere (either in the commit log or a comment in the code), just so we d=
on't
forget.

The main question is, what are the next steps? Do you want to take a stab a=
t
implementing this?
