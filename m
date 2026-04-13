Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E1221FBD
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110769; cv=pass; b=sJm5DqAGr22HOvqAOpWWyac2/tsgWoLMAJ16d9e0ANY0QmHybZ8QPqkywOHw6yFnngiyprQ8iH1kHMO22cgZFlQdkX1p6cS3HU/fcvH+hV88UJ1pqmhQWsGbh6K9eva/cAr12etagv27fD1gf2Mt60mOR+Htm7RO0VpyHAW4kIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110769; c=relaxed/simple;
	bh=FntwMTbN7rQHfvBNy6UufTqvzBSGmAQrXjSlKmNraO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7oUHlAWPJsT8y/kjln+AhmFO09CiEPce/WTTGwyq2+W7/hJRV9wAYIFzmAEctCglU1oeAK6wR6okmhYOabT6L4nWyEkrh6vdTEiwbSgXOvo8yvZ8sjVUqlv5uiMQQmInMD4r1YktM4QTllcKJtfJCT+g/ASIv9b9mZ+c47/Hnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYDQIzzt; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYDQIzzt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cfd832155so3305068f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 13:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776110766; cv=none;
        d=google.com; s=arc-20240605;
        b=LmxTXF4KCjZsc7oggiGywLBFYpTo57jNCYclrgfOP3fBsIKm3q/j9l7tfzfiKXHqoS
         6dj+GPKeLavgmh9bQpttuPvil4Ec8gwr51XEJUpV9+kOl+WghzL3erM0VxuNd4l9LHBh
         8cbIL8QmbAF/xrYAu8B9/LB+5OVlSBSkvseamgurMVMkA8A+Il3OiqmNkAovrO192EZ+
         0Y5m8xhLSZORqafq7VhkRKz4tynwoB/PxdBhA1gUu8lNt6ZMxhwtq96OocCNbuoKstDS
         s5Sg/tuzZCTfXu0FKfwDSFgCzON39A1LVvCHgI3cTtac4G+A7fGEL+KA1gWhqc+hMryx
         an7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzmhY0sob2IddRm1dh2Bbux/Jn9ljnnkK68ixuomyAQ=;
        fh=w9paX8TUTjpUD+DoFbhOt1TKmN2uoKLuFUUpp09tRys=;
        b=B89yNqfeIDncD5gPNpqWZtwnSCI21aD64iCnWrt/Y5W3JIt/D7mfyWVMenkGQzI38H
         /TQhLOWlGh0FmBKR01jr+u2+SBXK2M/6a6yFtUJR8cTHVP8aP3cbnBqOLWJ+HP4JBSmN
         /Z5za6Ijzd94dkYrT2fcDgkw01xIcQdrv1H/96qMuv0IKU2+aDn7A71rYNPCxp50wybI
         CPzsF1Chy6U30iAWZzLwvmH0iubASjjcifZ+6BydaAy1mGtAcqXSSPqmKor/YqBenwux
         UF65y6QEkO/WJUJdLr3WUPAZGkOubQXBaqjM/mXZari43Y2f5fvx/9LYooEY9lAkWRE2
         QWWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110766; x=1776715566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzmhY0sob2IddRm1dh2Bbux/Jn9ljnnkK68ixuomyAQ=;
        b=mYDQIzztqL72qP/cEsZbtRhmrgiTZXH9kYzq1uzgPRHPkV+BblFvwAY4HWQ0QPQ+EW
         XTS2J3ceEm85jDPJwnXiXNIk815VkYlACajM5JnnCRelRpvAtQC8VbeLYqUT5aNy4HZf
         NCzY3Xa4XUQjHATNt5qyo/ow7evradIuMsiLNtwjn8Jxd9vq0ZDA4ZnZ3anQEFFGA1uo
         N5I5TENKOLnS8QUrc7pcCGMIA/Yc1PtY8pqIHROalnKyTPe7MwTfN8kBHn2hfNQVv0xX
         gexipgw7f8E9lAfwUyxyIAVDvr6EWXzMdjCrktNRuwzKp2GJIgrhgChXEmpAAnnaT7z4
         aa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110766; x=1776715566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzmhY0sob2IddRm1dh2Bbux/Jn9ljnnkK68ixuomyAQ=;
        b=TKIORbMTGSIx+w84mH80uSARbuAXaLKkRA60CAuxIjJcxOtsjT6BcG6W8K23jiUEwP
         1/+u7S8Om9DGTQIfL6+jBB11mBI0IXD+OdwAZBEzlJq7aRKIg9O8ARjqV7wW5seCynbZ
         T/X1p967hkFSzp/4e+HSdpADZbdG6r7jDIalY60f64ZPoxBsX3CfWey/+aX9bJtsgKwx
         hCet037eB8DdkXpD86PXICCQIPiXQhud8K8P4gsnUgflDy/U5/rX1lvnWgRm9dFxP5sE
         qygrA/uYVGaxs+sEfrNSQp9fOUTq4j07vtX7tI2sI96f1poZcAFtEuTqj0X17oFau3JF
         STbQ==
X-Gm-Message-State: AOJu0YzNpd1H0065y9zKdQU5Fxgt8PRW6ED1wNQwzY7FR9+Fpmv/WSBj
	xFvLWtpH+v5ZAwQUz+7+4BdcJ13/HIqhb+E5ggQEbFJDOJvCD/Choci/PyrOe072riGtupDAfQ7
	H7GC7Uj8nEpPdEN3MkGr1ujCwqyIh9PQ=
X-Gm-Gg: AeBDiescxsE2iii6W5FVVh1t9vhS11v58ydIc+MxcyGi8fM7/F83IZyY8QmW8w/hx6I
	Q9a4FBiiGbYbT+tlFblda5lFRBRFt3QkwACaAp2fMLcdNlQ/R41hgHa/lg5WxG2fr5NboLPxvw5
	x39oMDtMz+kXD5jx6w4nrIh2D0kNiRG1d3E1ptTDyH9mLRVDeJFsWcDBg4mkNY4j9R2nfKbNyET
	n7ZpSYO2PADzh7DZemPoDfDkaFRf8kC9CnVg1xEOJ0j0I2NdeXEn9UilVkZQffK19/maGRhYkyh
	mnDv8OC+QgAzr4amTShkeZbLdcchrqqt7PIB1Rc6B1mGsDmmT0q4MJuIHjTvyYSxsyFJ+LxJCw8
	dGpGQ4LhURY2L9KMdp/lBv/CgWw==
X-Received: by 2002:a05:6000:b0a:b0:43d:6787:9924 with SMTP id
 ffacd0b85a97d-43d67879ad8mr13425513f8f.2.1776110765593; Mon, 13 Apr 2026
 13:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
 <20260410-sleepable_tracepoints-v9-2-e719e664e84c@meta.com>
 <CAADnVQ+6s0U6dVV0r_RK4ATwmuJd+BiGvp_yTYwL58ac9GEhwg@mail.gmail.com>
 <76e88c11-fc18-42e1-920e-e0965b984689@gmail.com> <CAADnVQ+SUUQEmM_gA7tTEWV=N43m1zJoTT3_7poGJ8ndiViaqg@mail.gmail.com>
 <c9f44057-a6ab-4307-9a43-48aa870fc2e1@gmail.com>
In-Reply-To: <c9f44057-a6ab-4307-9a43-48aa870fc2e1@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 13:05:54 -0700
X-Gm-Features: AQROBzBGGiQ6zc30_285B60ZpxvNib6ESFO0XpE6ipS1iwdSnJCbeXMvw9F88Dw
Message-ID: <CAADnVQ+0AfgjnmFf3KHHhC=_C-YDsp2K+473AdCGjH-+=OwGeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:32=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/13/26 5:25 PM, Alexei Starovoitov wrote:
> > On Mon, Apr 13, 2026 at 5:55=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >>
> >>
> >> On 4/10/26 11:55 PM, Alexei Starovoitov wrote:
> >>> On Fri, Apr 10, 2026 at 10:09=E2=80=AFAM Mykyta Yatsenko
> >>> <mykyta.yatsenko5@gmail.com> wrote:
> >>>>
> >>>> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>>>
> >>>> Add bpf_prog_run_array_sleepable() for running BPF program arrays
> >>>> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
> >>>> includes per-program recursion checking for private stack safety
> >>>> and hardcodes is_uprobe to false.
> >>>>
> >>>> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
> >>>>
> >>>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >>>> ---
> >>>>    include/linux/bpf.h | 50 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >>>>    1 file changed, 50 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >>>> index 0136a108d083..4e166accab35 100644
> >>>> --- a/include/linux/bpf.h
> >>>> +++ b/include/linux/bpf.h
> >>>> @@ -3077,6 +3077,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_ke=
rn *ptr);
> >>>>    void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
> >>>>    void bpf_prog_report_arena_violation(bool write, unsigned long ad=
dr, unsigned long fault_ip);
> >>>>
> >>>> +static __always_inline u32
> >>>> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> >>>> +                            const void *ctx, bpf_prog_run_fn run_pr=
og)
> >>>> +{
> >>>> +       const struct bpf_prog_array_item *item;
> >>>> +       struct bpf_prog *prog;
> >>>> +       struct bpf_run_ctx *old_run_ctx;
> >>>> +       struct bpf_trace_run_ctx run_ctx;
> >>>> +       u32 ret =3D 1;
> >>>> +
> >>>> +       might_fault();
> >>>> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock h=
eld");
> >>>> +
> >>>> +       if (unlikely(!array))
> >>>> +               return ret;
> >>>> +
> >>>> +       migrate_disable();
> >>>> +
> >>>> +       run_ctx.is_uprobe =3D false;
> >>>> +
> >>>> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> >>>> +       item =3D &array->items[0];
> >>>> +       while ((prog =3D READ_ONCE(item->prog))) {
> >>>> +               if (!prog->sleepable)
> >>>> +                       rcu_read_lock();
> >>>> +
> >>>> +               /* Per-prog recursion check to enable private stack.=
 */
> >>>> +               if (unlikely(!bpf_prog_get_recursion_context(prog)))=
 {
> >>>
> >>> from sashiko
> >>>
> >>>> + old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> >>>> + item =3D &array->items[0];
> >>>> + while ((prog =3D READ_ONCE(item->prog))) {
> >>>> + if (!prog->sleepable)
> >>>> + rcu_read_lock();
> >>>> +
> >>>> + /* Per-prog recursion check to enable private stack. */
> >>>> + if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> >>>
> >>> Can this cause a panic by dereferencing dummy_bpf_prog.prog.active?
> >>> When a program is detached from a BPF array and memory allocation for=
 the new
> >>> array fails, bpf_prog_array_delete_safe() replaces the detached progr=
am with
> >>> &dummy_bpf_prog.prog as a fallback.
> >>> Because dummy_bpf_prog is a statically allocated placeholder, its pro=
g.active
> >>> field is uninitialized (NULL).
> >>> If prog is dummy_bpf_prog.prog, bpf_prog_get_recursion_context() will
> >>> dereference prog->active as a per-CPU pointer, accessing offset 0 in =
the
> >>> per-CPU area and causing memory corruption or a panic.
> >>> Should there be an explicit check to skip dummy_bpf_prog.prog here?
> >>
> >> Looks like a real issue, thanks. I think the best solution is to add
> >> valid `prog->active` field for the dummy_bpf_prog.prog so we don't nee=
d
> >> to maintain special branches and can rely on the being a valid bpf_pro=
g.
> >
> > No. Don't copy paste from claude. Ask it to do the home work.
> > This was already discussed on the list.
> > I mean 'oh it's NULL let's add it'. It was similar issue elsewhere
> > and solved differently.
>
> Actually claude suggested to simply check if prog =3D=3D
> dummy_bpf_prog.prog, similarly to how it's done in kernel/bpf/core.c
> (for example function bpf_prog_array_copy_core()), but to me adding a
> valid `active` field sounds like a more future proof solution.

Sigh.
Ask claude to do more homework.
Don't be satisfied with the first answer.
Hint: prog->active is not the only one.
