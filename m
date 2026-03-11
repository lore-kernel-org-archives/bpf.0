Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA0392C32
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268211; cv=pass; b=JqyWVjadcMEU1KKXbIggVFnVFiFJNlkbYxrhZYR2+uHzRLu7NdRyFfO6T2Oj5uBp7H1VWPEuv2eCCVnAOOCJdNE57CBJsBkTAwcu9A+8A563F5r3LMu0plI1ZmoptkXlobVi789FMt8KIpMojGGwaWyytBun1l+4sF84DuvKFj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268211; c=relaxed/simple;
	bh=IXIsZStQj1ZtMod4DHzT83ni9ZEUj0wOPRkbFqMoz+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlBky9cjG6GQlN/aEycM3POWSIPD9jZ9pMkJo4PStNdwGM7EFP+YkM/HHG8JUJ/Of/rIZiLmJL5/6Hwftl0NU4FiInRZ8Ad32+y5QLaRGGC6Fn8n5/T8K20GgRaFnccb4ljmhzkun5H3EKy5FlbRo8eWrO1XNDGNw25Ea0DldRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCc3RXiJ; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCc3RXiJ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439d8df7620so268889f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268208; cv=none;
        d=google.com; s=arc-20240605;
        b=aH+cStfioIm9w6b/ehVT9t6OsS/H61O5GqREb59pYjxIPo9xzHjVaS9NA+T8psnjq9
         frQEgqOIJ+M7x2iyJbazjTZ3/pmjXaMqQxa5BCrDOswd/hjEe3S/X90GQpZEQ1IDKm2R
         WeEpWgoEcxwiMGXK6D4nbCZiwG54+b+CMyWhek+IGdmEsNZCe6skM/5JXviSbnsAmchm
         uxYsXxi0RhzYQOUJ2yorPhIoKYeRAHl5vTkL93mj4nK0aY5Z4QVX7oRwvL0dfhg+ql3l
         cW/jK5CaGBHJri5sYUD+tdocHxwIETFoCps1eh7z0Wydll+4mlcbd2smuswPmok1cLNc
         StIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2wMJzrqRjTyKyYc15YSzx0VqPlss0xaMiZG9fNQoX0=;
        fh=8/eGpY56OCAcNRT79TToKWibOS8+tBpWsO7zhc/eZQ4=;
        b=PBeM4d38XVGLJM4YcseE9hB0DriHyB1GdtjedbQ6eF+c/pA2lsmZBPhW/RPUMaa8Ae
         vZOz5ZHoofeNy/lTpxvSauLqAxz6ibw/QXBDaJgLk0eqeq3tr3CNvN5BDYrGMiZqFWAk
         ZqCs6Nj2lGogMMYr4gPvPvhwOfuvOIFBH1K6OTMFies+XoFAkMXdFs0YRfXrJVc9RBJC
         UXxm2Glu5cywZYT266PUelWCJR2XqOsEmyART4GUf7ZlHhp2iDCgy5n5D7DIQuU3Ec3A
         sC7SCjPnQ84OHoPbGfCFQppa6AeCNAmdscHo8/gia5WZJixhWrX28VESP7gKLif5zEzk
         SY2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268208; x=1773873008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2wMJzrqRjTyKyYc15YSzx0VqPlss0xaMiZG9fNQoX0=;
        b=SCc3RXiJHC31sf4n+RB5aa5OCR7bZgrR8Kn4rgTLaDs69WuMmd53/TegI4lwLNYtx5
         0vSWjHh+myEoWtriTW51h3Pl4vEJz7eiFS444f/GdVWVudcUP+eXr2hGBxRJbwJ1dmlj
         cgKbNc4w5JJRPqUZRL60p+IH4W46e1nhcr6AZD+YzS7CGr2DzdtH1rSMI+WzDsAGjaru
         fiRfdzmrOCQyQ3VDXbj5oN4y0yHpoLwjCsF4b8NCBof3BB1lDfWP8NKgvJcVLWKZubTi
         GEFSoc5etWbrcs7yhrWfVpoAWD/LafIjZg8Y7igxuG2LbCb8DNf1L213sLEmlno6bY3L
         23LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268208; x=1773873008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2wMJzrqRjTyKyYc15YSzx0VqPlss0xaMiZG9fNQoX0=;
        b=m2BnA/wiUtA2SzbU1bUtOuC1lg0Sbc5WTaOI81wZ0zXLpV/lOAoIx1Eb+ymJVnN2Ba
         Zkux2583aFfbfzKKQgtEET0eZMawvFjE3eNCq6tRrRiG0NhT9zm8oDJSTaXVszNZdnvM
         pxhj/kr8mUaBHD/G5g+1r6RBtuNXsb14xcoV1ZZFxd4hkSB58AypCLqkytSbiX0OMHbp
         qJ6GX2jqTQFLiAJ8u6FFkq1I6LkEW3HJSx56m6zC5pcw+T4u/Z0qyUDuK8lqHKChR/d5
         LI/CaiZ0kgBPeSR7MXXMb8XmtnkA/leTiFCxpjtcehJh8YXv3Eu0NTVTLqMUwofYp16O
         q2aQ==
X-Gm-Message-State: AOJu0YzLsEzKDbAYa8FW3ExxNivVYxFre1NHZPHTM3wbeJNxiztMoqAm
	PoT42rc1JaKn5E65tCYLG6SyNhj4gJhRKtOX4CjoN3z2bBb6pw88GQ/eYsQs0Ty+jirCB7od9aZ
	AavV1N933TukLCx2N2mcxQJm9naQ74K0=
X-Gm-Gg: ATEYQzxlpCfT1q3t77zHcLHVNqC11+kJjAjD8wq0T647k3VQ+L+HBktunyHvS43ZJpl
	4/XsVBMkaiEolXAjbb09JU08jTWHXUt8VgVIhDEK5u1CaLVQPuTf6RPszZ3uk86okZepWaIyDCF
	lSBwAp6BIMhD/8ZI3iI0KNMzBqVmpdClIxhO1Bjv5udVvs5RriAKCo3XsGAV8+dUlpfibO7BePQ
	71Bh4+vtDpxY28roTO6VIJuW6MY3tqUPDc2JLHYkEZHDEcY8KwEZ3sJSEN692Lty1F+8+gL06jF
	0+pXbVOjobqatvQOlAUofdu4CRbmjOeQ1YoQlGWV4ZTp3hX9S0e6B9epvJ4VAmAkk755hOQw7WR
	rSZeRT+8ruP4swOC+fp+d6mXbKg==
X-Received: by 2002:a05:6000:22c8:b0:439:c14b:2100 with SMTP id
 ffacd0b85a97d-439f81df102mr8608515f8f.12.1773268207904; Wed, 11 Mar 2026
 15:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
 <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
In-Reply-To: <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 15:29:56 -0700
X-Gm-Features: AaiRm51DVyipjj7ZjH8JPjlowS7QMe6j_IWZpgC279CIhJmlDmGjVule2JCDSF4
Message-ID: <CAADnVQLCKi_QL1FeybW+6MH6FAOAoRJyW06UvtX3my3yNSH5eQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Preserve reg->id of pointer objects after null-checking the register so
> > that children objects derived from it can still refer to it in the new
> > object relationship tracking mechanism introduced in a later patch. Thi=
s
> > change incurs a slight increase in the number of states in one selftest
> > bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
> > states is also negligible.
> >
> > Selftest BPF objects with insns_diff > 0
> >
> > Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DI=
FF)
> > ---------  ---------  -------------  ----------  ----------  ----------=
---
> >      7309       7814  +505 (+6.91%)         394         413   +19 (+4.8=
2%)
> >
> > Meta BPF objects with insns_diff > 0
> >
> > Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (D=
IFF)
> > ---------  ---------  --------------  ----------  ----------  ---------=
----
> >        52         57     +5 (+9.62%)           5           6   +1 (+20.=
00%)
> >        52         57     +5 (+9.62%)           5           6   +1 (+20.=
00%)
> >       676        679     +3 (+0.44%)          54          54    +0 (+0.=
00%)
> >       289        292     +3 (+1.04%)          20          20    +0 (+0.=
00%)
> >        78         82     +4 (+5.13%)           8           8    +0 (+0.=
00%)
> >       252        320   +68 (+26.98%)          21          27   +6 (+28.=
57%)
> >       252        320   +68 (+26.98%)          21          27   +6 (+28.=
57%)
> >       119        126     +7 (+5.88%)           6           7   +1 (+16.=
67%)
> >      1119       1128     +9 (+0.80%)          95          96    +1 (+1.=
05%)
> >      1128       1137     +9 (+0.80%)          95          96    +1 (+1.=
05%)
> >      4380       4465    +85 (+1.94%)         114         118    +4 (+3.=
51%)
> >      3093       3170    +77 (+2.49%)          83          88    +5 (+6.=
02%)
> >     30181      31224  +1043 (+3.46%)         832         863   +31 (+3.=
73%)
> >    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >      8103       8108     +5 (+0.06%)         459         459    +0 (+0.=
00%)
> >      8076       8079     +3 (+0.04%)         457         457    +0 (+0.=
00%)
> >      8177       8197    +20 (+0.24%)         459         460    +1 (+0.=
22%)
> >      8083       8086     +3 (+0.04%)         458         458    +0 (+0.=
00%)
> >    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.=
01%)
> >     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.=
02%)
> >      8103       8108     +5 (+0.06%)         459         459    +0 (+0.=
00%)
> >      8076       8079     +3 (+0.04%)         457         457    +0 (+0.=
00%)
> >      8177       8197    +20 (+0.24%)         459         460    +1 (+0.=
22%)
> >      8083       8086     +3 (+0.04%)         458         458    +0 (+0.=
00%)
>
> The table is missing names.
> State columns can be dropped instead.
>
> > Looking into rbtree_search, the reason for such increase is that the
> > verifier has to explore the main loop shown below for one more iteratio=
n
> > until state pruning decides the current state is safe.
> >
> > long rbtree_search(void *ctx)
> > {
> >         ...
> >         bpf_spin_lock(&glock0);
> >         rb_n =3D bpf_rbtree_root(&groot0);
> >         while (can_loop) {
> >                 if (!rb_n) {
> >                         bpf_spin_unlock(&glock0);
> >                         return __LINE__;
> >                 }
> >
> >                 n =3D rb_entry(rb_n, struct node_data, r0);
> >                 if (lookup_key =3D=3D n->key0)
> >                         break;
> >                 if (nr_gc < NR_NODES)
> >                         gc_ns[nr_gc++] =3D rb_n;
> >                 if (lookup_key < n->key0)
> >                         rb_n =3D bpf_rbtree_left(&groot0, rb_n);
> >                 else
> >                         rb_n =3D bpf_rbtree_right(&groot0, rb_n);
> >         }
> >         ...
> > }
> >
> > Below is what the verifier sees at the start of each iteration
> > (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> > verifier stops exploring the loop at iter 16.
> >
> >            rb_n  gc_ns[15]
> > iter 15    257   257
> >
> > iter 16    290   257    rb_n: idmap add 257->290
> >                         gc_ns[15]: check 257 !=3D 290 --> state not equ=
al
> >
> > iter 17    325   257    rb_n: idmap add 290->325
> >                         gc_ns[15]: idmap add 257->257 --> state safe
>
> I'm not following. The verifier processes above as a bounded loop.
> All 16 (NR_NODES) iterations.
>
> Why presence of id on 'rb_n' makes a difference?
> It will still process 16 loops.
>
> Which insn is safe vs not in the above ?
> One after gc_ns[nr_gc++] =3D rb_n ?

One more thing...

How does it interact with reg_is_init_pkt_pointer() ?

That pointer has to have id =3D=3D 0.
