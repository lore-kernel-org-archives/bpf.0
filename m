Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F724DCF6
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097556; cv=pass; b=Hfj2CI1yMSMu7yAEUZ5IqZpCn7/iiz9ZahjPOqVqTiVOSzJai//td91mzE5i05irW7LPsqv0O67t4C/RsTBaoYhwq/cNUAeMXesKoGiKKdULMLf0+YTZUMzDpiK9L9AQV8QoiKKy5qW802aH2XgjTEFG8FKnBvJn5DTDN5dV6k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097556; c=relaxed/simple;
	bh=0JAUh4drrGtbqQqUK6H2/xrBzvgYqyQ03/O5vHDXxJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke0fuXmKrBRgy/gbJqJalCpvt/SkEMAiXIb40cXdunRKZwORH/u2E3BHZmPUltz2ZuL66HeTKgFuxBbe1hXbjrqFl2SMZZpWxNv37ElOBZIgCx3woSpsmFMWNUO5hrdOqocbL4U5SbatkBZq1HHKXk56E2ai+RtDl+dAl5e4f5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiYm/Q/I; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiYm/Q/I"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d75312379so952723f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 09:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776097554; cv=none;
        d=google.com; s=arc-20240605;
        b=UTZeHdhasO5BlBw4ZiD6HebjurQPyq2PldGIyzT6pw5dFz/2DS8x8fLCkWBMEYi5Rm
         Cx6BdhZ9JsuTkZwGqpmVJh6o3uHXzVOetYzzFLPXwEh/rKG7KLwuaNL5crsAV+v0uGo2
         qJoSeq7/y2yIDAlGrH835Hu7DOfcQ4gBsiifHg+ufbjUG9+0dL5kvL1f8a7TLlG42ZHK
         oXfRgddHK6oOj4vWeHdtWZNt01ni2cq4dvp20YEhpCfJpwI+YiGejNA5ayMLoX68c+PI
         qzon2nrp1RDnO22Zh0HcIDJEwDt/nDuI0O4aVCliCSvBdVvGixsO0rWN5uet+XBigcnM
         P7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GlLXpS8BvMrBLesKtAsHRb5QpAwdcI3sdCYAGi4MVQ0=;
        fh=w9paX8TUTjpUD+DoFbhOt1TKmN2uoKLuFUUpp09tRys=;
        b=bIXRCgy8vEePI4YfemBFbRaFTaBVamXuFg8ogkOFbfNBKPYsyyD9MU6DbllzYMDDEA
         LjcNH2UaaY9DSRMqJkj4eQSlEkbWmOodfyVcNYjwvG7GfD4FejVAU0BT1DPUkTUXPh/T
         FT4B/uiqbX5lvfG9+WOkzo1kQ+VHdYMOH7LU0meCCs4hEr9wAFBb042lyz+LxRxt165e
         ZGPCXUyRhoj6Irxd1sftNa393ojJ5rV601wR8Jrc4/NPdC8a/tVHqEyGKlk++Yjt1+M9
         91u2PQBbALjrr+nhvNl6ZIzY0kMkbJdrI5lYS4f7XtMTr05naWbvrGmsJpEyK62ZzTR1
         6k2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776097554; x=1776702354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlLXpS8BvMrBLesKtAsHRb5QpAwdcI3sdCYAGi4MVQ0=;
        b=oiYm/Q/I/q8D6KWNG87pS3mFoApfK/1kyLFlUwGbvgHLRksGJkgQQmC70gfeDfwr43
         pp12aFTaZYzT19BrlUzpR/HwM4VATmvARL/wPFK06qZUaIGXiBwDY/u3H5SvMNnz403Y
         MRYKqdQ+VbMLuP7QSr6fkiEP6uYfGzSXvH6mWhWDA0HVO3jJUF604b/T44eqyzGGvafk
         UAnIeGnhe1QTappZYVlST3UAO3mkONNfjBF6AQLbTy+1eTKimlERgQH4HCeP34gHE7FO
         4+QgCY70G9I0iHDRsQJUxwNXYgpTnzTiF+hjDfEG/JgqtjIyabZ0Q8871+6TUB085yR8
         oS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097554; x=1776702354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlLXpS8BvMrBLesKtAsHRb5QpAwdcI3sdCYAGi4MVQ0=;
        b=EyVBgq+iBJejwCf28ZoqGbyua6n68O3v+WX9lc2pEYWeQ6+h7VpnncQTwBhJ2yIK0I
         GiyrRrM6YvPbK+qK142MRzgWui5smiFx0LW9vedseWjP2gdj8q8WTMCPAU4BJNcDhXOv
         LYc9RNUlQcuAibQM0kb1PiHxDvh74noHSpzXHotKrUXoAK9l2GRJGKsHFWskhjPzrs/W
         RaHiK6sNtAY5Kl1tB5wGr2jY4XccK5I8KVhHf9TB8/OTIsEUcYuTyACrxk24fJ34x+Qn
         x/1aIPKsSdkbSOEVjhUB4AhwKA0uydumg6PCeA+wGBwRC/8di+9T/nkpRYWJ7wpU0Zde
         IIdg==
X-Gm-Message-State: AOJu0YzBP/JUeobN7AMx7dh3YkPYWl5cT1yK2ULvE5vfVk59kNfewEfG
	fTaglZCDT91p3r/yM1UXMVDz+L7mTi8mHaqnlFm12dpNTP4GCA0z5g3j28PuxfVeO0ewnB1SP3V
	Ziz/x0+YeZOhhnr96Jt7fdwfG0GQXAlGqlg==
X-Gm-Gg: AeBDieutkFDMbVlU3nzsbGWCqCqLd/zuH7E71vk14nqDRUkGK9g0Sojx7JYPdu9Dxb2
	j14evsrPRERN7XosInqEmm6eMWxUfR6xgKi0jqk5imELbxdDCxApftrEg+snLPVe6EvTGoK9ZyY
	6PpQDI3F7fC96WrRpPvyyFMSTRlJXNouqWDqFSVFlIzu7x2ChZEdTZ+b8bQem0WekRO8+C2Hvlq
	fLJLxMLGDdWg3wd79IulIZw6jqzQ+7j10+y6jWpEos2/W3+Xxbwiy+6Vbh7BfnvENO+L0JmQiaZ
	8+cm1BArI1JBGJ39cFC2qoRBOwALlxBYzv4+/+/3odVFBs337+6hgUC+UXVkgr45qX/byLhdvsZ
	an4cZNuyVVGOzf14LNddvsbN5iA==
X-Received: by 2002:a5d:452f:0:b0:43d:729e:f23a with SMTP id
 ffacd0b85a97d-43d729ef530mr6311092f8f.22.1776097553778; Mon, 13 Apr 2026
 09:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
 <20260410-sleepable_tracepoints-v9-2-e719e664e84c@meta.com>
 <CAADnVQ+6s0U6dVV0r_RK4ATwmuJd+BiGvp_yTYwL58ac9GEhwg@mail.gmail.com> <76e88c11-fc18-42e1-920e-e0965b984689@gmail.com>
In-Reply-To: <76e88c11-fc18-42e1-920e-e0965b984689@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Apr 2026 09:25:42 -0700
X-Gm-Features: AQROBzCa8eqR0MUaJ42FhDXPzXJWLbIEmLOptTfW5jmlMWjMp9rW6iblAs_FrEU
Message-ID: <CAADnVQ+SUUQEmM_gA7tTEWV=N43m1zJoTT3_7poGJ8ndiViaqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 5:55=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
>
>
> On 4/10/26 11:55 PM, Alexei Starovoitov wrote:
> > On Fri, Apr 10, 2026 at 10:09=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >>
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Add bpf_prog_run_array_sleepable() for running BPF program arrays
> >> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
> >> includes per-program recursion checking for private stack safety
> >> and hardcodes is_uprobe to false.
> >>
> >> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
> >>
> >> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   include/linux/bpf.h | 50 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
> >>   1 file changed, 50 insertions(+)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 0136a108d083..4e166accab35 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -3077,6 +3077,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern=
 *ptr);
> >>   void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
> >>   void bpf_prog_report_arena_violation(bool write, unsigned long addr,=
 unsigned long fault_ip);
> >>
> >> +static __always_inline u32
> >> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
> >> +                            const void *ctx, bpf_prog_run_fn run_prog=
)
> >> +{
> >> +       const struct bpf_prog_array_item *item;
> >> +       struct bpf_prog *prog;
> >> +       struct bpf_run_ctx *old_run_ctx;
> >> +       struct bpf_trace_run_ctx run_ctx;
> >> +       u32 ret =3D 1;
> >> +
> >> +       might_fault();
> >> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock hel=
d");
> >> +
> >> +       if (unlikely(!array))
> >> +               return ret;
> >> +
> >> +       migrate_disable();
> >> +
> >> +       run_ctx.is_uprobe =3D false;
> >> +
> >> +       old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> >> +       item =3D &array->items[0];
> >> +       while ((prog =3D READ_ONCE(item->prog))) {
> >> +               if (!prog->sleepable)
> >> +                       rcu_read_lock();
> >> +
> >> +               /* Per-prog recursion check to enable private stack. *=
/
> >> +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> >
> > from sashiko
> >
> >> + old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> >> + item =3D &array->items[0];
> >> + while ((prog =3D READ_ONCE(item->prog))) {
> >> + if (!prog->sleepable)
> >> + rcu_read_lock();
> >> +
> >> + /* Per-prog recursion check to enable private stack. */
> >> + if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> >
> > Can this cause a panic by dereferencing dummy_bpf_prog.prog.active?
> > When a program is detached from a BPF array and memory allocation for t=
he new
> > array fails, bpf_prog_array_delete_safe() replaces the detached program=
 with
> > &dummy_bpf_prog.prog as a fallback.
> > Because dummy_bpf_prog is a statically allocated placeholder, its prog.=
active
> > field is uninitialized (NULL).
> > If prog is dummy_bpf_prog.prog, bpf_prog_get_recursion_context() will
> > dereference prog->active as a per-CPU pointer, accessing offset 0 in th=
e
> > per-CPU area and causing memory corruption or a panic.
> > Should there be an explicit check to skip dummy_bpf_prog.prog here?
>
> Looks like a real issue, thanks. I think the best solution is to add
> valid `prog->active` field for the dummy_bpf_prog.prog so we don't need
> to maintain special branches and can rely on the being a valid bpf_prog.

No. Don't copy paste from claude. Ask it to do the home work.
This was already discussed on the list.
I mean 'oh it's NULL let's add it'. It was similar issue elsewhere
and solved differently.
