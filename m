Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5114908AA
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848847; cv=pass; b=YprUk9pB8hJKHF0pXbD9Tm9h+1puJSuBXTQ0f3SvrruXWdl/CBmFcf5nJn7K40nZizfAnl1rhXrmzRs71eKftO8CrFQASZeOfQ9IL4NRrZuPJUeO7QcO2nYF0gntu8xUtHOuH69FaMgKisDZgG869uLrqsXtQFAy4u+W+NbnnnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848847; c=relaxed/simple;
	bh=Bc0mcS9QdnOZe2cDfaVrB6IpLXbgGTbtMuygd7Xdd14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfcjWP3Y4EG4IXA+d3sqCO8RYZBClzYK5EB9mI2I1eOs3nMPoK9R9y3u2OW5VmArEuRmTg6XssKq2M0gm2CvSFf3qpNU8XUYOXeEsryKhaItJhqtD9XwVy0mivjnvlP02mF4pNW3Vzz7o5nSIrGnvuR3eXJ2SaSu6JhIjBz8Qys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF8GJn1T; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF8GJn1T"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so200187b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 09:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848845; cv=none;
        d=google.com; s=arc-20260327;
        b=ek7lo81YbFh8Auf+sIaK2bzuGwkODn54TY3vkSAuK3gARb9dd0fyjCfUQJDNcbP/sH
         RpKR46OWpbyesFJYvrVryejck8Ld5d6QX6S2BJpm1f41UpZo9gCmmfy3Z3BYzu8hPcwI
         pcVpuDYkhWtZmgv+TyGof45dQ4UrlFgQv4jo7FSjFkVQ7JirwWbY1WkEAzrqAw7KoDDC
         vMiQqysfHrjCANu6+jXJop7XN5v0dSiLzAz5tf+KoJ8Z0p6KbUnT6E8E4ZazYsYyfxMb
         Y4EjmFhLbberrADeFeJ+1NStbiGdw+lv3R9pdOuEg4QU7dc+9AxNSDzbSVAHdKKbafLj
         1G+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HlMQ+RZs5fbBVG8fjD67Z6x1PNKB08HCYfn3H6xQ8Ng=;
        fh=5n7sejDvTVK5lU33iBcbkuUwXIBvg2M7E7UOUA3VIBo=;
        b=mFRNWUXo2427yXco1UT+H8lKDb3RBUwqBrtqUaJGc/3Ch2WsJ462VN+4mEipTmVSjz
         SaPzRlvKorUMcSDJc/TPXCLqZb5lQpCFLTTgp3ZNbEzUh7bJSNcFaazTBDY4nBaa053M
         8UCdmPG10ScyWWr0duqiGbMakRDCzSMzHgcA5/a5Rdx3+qmjSbNkgOWlAlmvtWfaIrpT
         UzSDOtD/13EFBOwMhEd6/wLPqJiDvCT55kJmp+jC1KGWIHabtsGP7ouAFZ15hT+w0ovH
         ITQI7PeDfdv/VokRzcv27+7sk//hyyEWScjVqWMr+RurPoV1fRMF6WmnMaEMgWgIymEN
         Kybg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787848845; x=1788453645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HlMQ+RZs5fbBVG8fjD67Z6x1PNKB08HCYfn3H6xQ8Ng=;
        b=LF8GJn1Twz3yqKNF6PlXKT46d+JdkWh58kV7S5zAWVcUooJvFtjC/8kg2pMpN/dgEh
         /oGTpwHZKuHWRtJ9wNnMnpHSOy+oQdDnyAbSJQdVbU8EQ/C82N3LuLUYqSekIJspw4/k
         KpiL9a7MP0yBj68pXRujbby4r2j8FEYpYhFEzLzyqVSM+ji5wtR+0hLFHIluBGkdWqJi
         +S33MjxyDAwlDRH6I7CdULXo5pcTn8+Y1+NuXWQJik9KDITxuB9W9agtAX/rrtkA7t4v
         Sljf/8AqchxT402cbcfEQGOzv12JJtSLcnOoLlzyt98h8AQkvVAsOgvVSmla6ktta5bf
         z7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848845; x=1788453645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlMQ+RZs5fbBVG8fjD67Z6x1PNKB08HCYfn3H6xQ8Ng=;
        b=Sr5o6LIL698/r8ukPcXaPqCSN+620IJnl8uawCJ7L70ypD/Kw1s4q9XqeGMFIq+2pM
         Q8CuFDC4z9cLVglBNQFLPp3dOQ9ovmontB+8kOWn+duVvxodhy/oxwjJk4BxAIGzfoaY
         8h+LM9o3aTAInOlcnl0yzNg0Mss5jhRG9C0q9tumm25sJaoXXYktFiph/QdXGtsmpPsJ
         CfmiQFo+mIqRz1s2rhC2GiTS74ET12a/JrtAr6HG4ZmuffDu0FKIuc0qa3b4uhWitt9a
         6DsAzzlds54bvg5SKcU5gXPFzOco+cIY3aPaZ6fnLNhnY3lrq+0NEAlj46dXPiybAth9
         3Upg==
X-Forwarded-Encrypted: i=1; AHgh+RoCSwlCbHdQbRu1PYbQ2U2WKb6r5VUE7ZlP/S7CP/jDhXsxZCAHRp4PxjHWgMAEbYIaBLY=@vger.kernel.org
X-Gm-Message-State: AFuF++l1gVbjms3R1nYhimRwRWBKgJr/xqFh/OMUe6lDgq4oZ7tPfsQ/
	/t3ySEH96lv4uv4VsT3Gx5ZY9PeNroPNCK1t3OwzcAd3Z3vw2iTQk3esf32BSk2yFlZ60ccY9mz
	m9NjR2A1yKAHC1NRYDxl1uzBkfWFoaEM=
X-Gm-Gg: AR+sD11QG5W7bDAvca4jQMMH3Ia9gXsXI8Ds0U3jD+g7NKL9PJ4wb1AFpd0TO8fpccW
	GQqH81N2MSZZLXwQWlJHPrG9brrgirkpAln2ylqMFKIazc5Bhn1KQY78zKno//8EZPQFHqKghKF
	YNjLPYoWjQnTZd7DwHwpn4yzIDbVIUDCVfO37wh6IONrPWWFgXKbUWvsChy5RgXkCmLNjVPPCZF
	voF5jDXb2owJYxEEENiwiXKjz675uv/VlDFC5T+SKRLsSJ9u64LJU4PG2r5vl3bl64bWIzLSy4k
	qHt1LlnhW9Vm19jrFLM6vjzlwKccHWEre3XrwG/J+DeQT/0XgqHaf7EsB8mm5+DKcYi8JwGjT7G
	B4V7ItZrhkzjLxt6JxWzkvHhg3g==
X-Received: by 2002:a05:6a00:e0e:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-85629a252femr834755b3a.9.1787848845094; Thu, 27 Aug 2026
 09:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com> <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
 <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com>
In-Reply-To: <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 09:40:32 -0700
X-Gm-Features: AcwNN1V67P0UflL_EMJPFTW5TTaVWrGa_WjK1k3E8xVwR46Ne80Fz1eP7Tks3Zc
Message-ID: <CAEf4BzaB+EDyf2exV8XGq_x4TvhTii7gJnWU0nq3380guaWF7Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, stable <stable@vger.kernel.org>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 27, 2026 at 7:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > > > A JITed BPF program can use one private stack per program and CPU.
> > > > Sleepable programs can be preempted, allowing another task to run t=
he
> > > > same program on the same CPU. The second invocation then reuses and=
 can
> > > > overwrite the first invocation's private stack.
> > >
> > > I'm confused by this. sleepable progs go through __bpf_prog_enter_sle=
epable_recur()
> > > which has per-prog recurison counter. So preemption of the prog
> > > doesn't break private stack.
> > > If the same prog attemps to execute on the same cpu it will be skippe=
d.
> > >
> > > syscall prog types go via bpf_prog_run_array_sleepable()
> > > that have per prog recursions counter.
> > >
> > > Looks like we're not doing it for bpf_prog_run_array_uprobe().
> > > I'm not sure what the right trade off here.
> > > I feel universally checking for recursion is better
> > > then selectively disabling private stack for uprobe.
> >
> > I'd really like to avoid adding this "recursion protection" to uprobe.
> > With uprobes, there is no recursion, it's called from well defined
> > context in the kernel and you can't have recursive uprobe BPF
> > programs.
> >
> > All you can have is a very valid and possible sleepable uprobe
> > interleaving, which the user cannot prevent or work around, they have
> > no control over this and it's just a fact of life.
> >
> >  E.g., a simple scenario, we attach one bpf program (let's call it U)
> > to some USDT. BPF program U is sleepable and actually can sleep due to
> > page faults (e.g., unwinding Python stack trace requires sleepable
> > mode for reliably getting filename strings from Python runtime, which
> > are not always paged in).
> >
> > In such a case, you can have thread A and thread B both hitting the
> > same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
> > thread A hits it first on CPU X, BPF program U starts executing and
> > unwinding Python stack, does bpf_copy_from_user() for string contents
> > and causes page fault, is taken off CPU X. Meanwhile thread B hits
> > USDT on the same CPU X, kernel runs program U, and it is supposed to
> > work completely independently and concurrently (no shared state or
> > whatever) from U's execution in thread A.
> >
> > Yet, if we add this per-CPU "recursion check", we'll just skip U's
> > execution for thread B. This is data loss, and it's very bad in
> > practice because it frequently just invalidates the entire data
> > collection trustworthiness.
>
> ok. fair
>

great, thanks!

> > So I think we should disable private stack for uprobes (sleepable or
> > not) instead. I'm not sure private stack buys us anything for uprobe
> > cases.
>
> why disable priv stack for non-sleepable uprobes?
> While non-sleepable bpf prog is executing the same or different
> uprobe cannot execute on the same cpu.
> So bpf prog can be preempted by kernel execution,
> but a user task cannot start preempt bpf prog,
> so 2nd uprobe cannot start running,
> no?

I think that changes on preemptible kernels, this was called out in
discussions on previous versions of this patch. So only for that
reason.

For non-preemptible kernels yes, it's only sleepable that is a problem.

>
> > As Jiri mentioned, at verification/jitting time we can't tell kprobe
> > from uprobe, though, so that's a bit of a problem, but it's a separate
> > discussion we should have. Perhaps having an extra expected attach
> > type, or type, or some program flag to designate uprobe program as
> > such would be appropriate, not sure. Let's discuss that.
>
> we don't have sleepable kprobes.
> So disable sleepable && [ku]probe type is enough. no?

Yes, unless we want to also safeguard preemptible kernels. But we can
do that as an extra #ifdef CONFIG_PREEMPT_RT or something?
