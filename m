Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E535B629
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277187; cv=pass; b=n4+Hz7LkXf+LB9uVFUsIE9LSQjfU/oCMdWS7Te1y+9/4ExwtTYuIdBKgqsDAhfO6Ad5RuWtyTj6NjVIuk2TGHz/rSK+s3sQWn3AGbjXdtuC/ycLNDd5rUPcvFFGUFwq+87KDod0b9ZiEcNdKu222080EPdXeuMVJWfrQFazUbho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277187; c=relaxed/simple;
	bh=hyTb2fz7I2WzG6R6mU1WVLgerzwno1BLfBB/oeOep1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mV3uZuyUpyvyVnTrA1khyMnMZIpOA6qx1VS/Ea/48FkMHKlh5dqN7m9R6+7SvVi9Qo3GdnUH+D+bng52pvqhIfkC3cznYeCTs3G2TZPsVZLSSOUf05w4kaJEur7xktWU/MoqtUw9x8NyYQJ24dnDnxhJIZqXqrz6CarVqDsy32o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EgNY1KAc; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EgNY1KAc"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124afd03fd1so1154347c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:39:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770277186; cv=none;
        d=google.com; s=arc-20240605;
        b=capKfHGstaTqAW4bPKm8lDtSbjGhdf5DBNH5RR9nJho52rFpTWm29EWfgQ+NEU9y3C
         gH+oiZVaYOvw3JSBvC6QSNSylOMrKcWxLqmRSkvKQzwQoyfyI9uEnyA5C9wPHnVCllEh
         HS5Aoahf8U34KJghNjRIT5qLu2umjQUSH7xNp0892Gd+ZCgzIlOF1xWSE/V1dV8os105
         silfd/JgExjnAXMubu86rSJgmyew0v5kIj1zODpICsfAJBiTmwfYZWAJmNpA72luATO8
         wQ1HhDizk9YZ3vlk+3JFXaz4oFgMUQ8F/RhnjSD2qJO7AdLVYVyH5QYYy6bXKSokC+gr
         zUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0SZjZeeddONPmMPtBHPNeiHy+qYDLxVFCrm9enPzko=;
        fh=tzDsJm3H/+4t452LMXzEV3xX2qePZ83oqm67/3RqnXQ=;
        b=JAT9IsCyAYuJ2m5n6ZX4NZXue67zUYCPT8aOEYoGLfz6xNyep4mQNJEY9dd4LVB8EI
         gw7RT6nPuJLnhWtnIPx5O1jAlCVuyTT2d6D5X130eNzUoeWFvqSCQ6feYbA6joTqiTl4
         y6+KgcDSd52zD8I+ZI4+qDb08lDNBJhew7osxdMuq9iGAcOJRKOcu563KPGw1udWq629
         Ald4lZhudJ2BS03ynatI47LgWhAooUr791kw6uabRRJG2UM2juvN8IcJW90D+fFohCPy
         TLPnmiJSUojvwAA/SkyFh8bpeMmKGhLLso7ZuxYVkjCuPCG/g6uaI0ZPlYwr3sS0NbY8
         /oFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770277186; x=1770881986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0SZjZeeddONPmMPtBHPNeiHy+qYDLxVFCrm9enPzko=;
        b=EgNY1KAcSzplh61cVKPOtNA7aoELVI3fHW9nrvUjzT8pnGG2ktdxYuf/5WLeq94QGP
         Vt0Bm3PHjQjcMnlv5sbLJ1xEMd8St49hN3GslTJiznLrPjZ3MTCNEwO2K9wF7lOqS/qE
         hmF/EUKn/AGwAkD9UNy9ZGJjGIC3556MeFbZ/44fl8gEe31Se6QRM6HGUmjT9exwnQaW
         rOOyno/bL2cSojvXQNhCb4NgL7OkmBpyIgKT8hWB/53ZlxzjkGgH9YkxSlk9u1X7Ss9N
         HsMWA8uuQg1JNQHu7opLssa1L1wGcvcBeypS/RNFFDaoRptF2GhaHicW2yWN5T7aTG9V
         10rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277186; x=1770881986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0SZjZeeddONPmMPtBHPNeiHy+qYDLxVFCrm9enPzko=;
        b=HbQWWIljZoOZ/TjBbHS+ffF8uuRV+uMKg3cqbSiRkgzbXgSvOHVbfqSJF8bLxT0TRj
         qZlXPamufSCX7xUzhEjAHYfB8CFwQobjpHjVTT8+B0pFXyTAD1rC4/ObRZqYKk3e/c4N
         r6/D/bc2NijAZAV38spF7CLprZVBhY2fX7uyJ8kRwCXM233EX5+AIzIrdu0RHXAEpaZN
         w66NH05OLFgOhJMOWGNrj700MV61G8Mrop2EpdSByEg2XP+s2mCk5L1CviDdYNpyAJS0
         LEo1BKXGFF4LA68KrTqVipqJ1j41i5/ZL9DWV+MSm7I05nrM3ysS3YWlEVjRBlg2R540
         b15Q==
X-Forwarded-Encrypted: i=1; AJvYcCVljUxC3j/0AoKtQEkgvRR7SmXj52bQMBoJ3rggusiN6asB6fltLTUosvE1IoIfz4baiaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYVB/etzlD8s4B51rVx5V6KUix6VKOBKAS3ZjEmIyXTtCLSFG
	V7LuOFXZkrj1XgUtFyxB8IkFa1RIT4KfinIqxnAA0RGnrIoU8vMFuVb0bZ/AUS2Vb15bWCm9VEQ
	Wka/T0A2BV81YZAvYWQdoIU0VXlfYwDqjizxIFXxN
X-Gm-Gg: AZuq6aIN1b0TnN55745FXhby27lqArzNgro2VC9impwKavwLXeFtWkWe6W6iTYR4dtn
	wMs8FVe/K5IS9jq02DLLD8HoSf8C5FN3LMTcF+A+lXnKbycO92IMNCYgxfGP5UyxQXZuwCfxT8J
	WcC929jf84qSS6apsTUUqX+bInUdREfewMHd84sP1/K2vSvVS9/Vg/IOYLsZ8pF2jluc+CLqIDH
	MUjHVL3gmjq0cKp8v8Pgy6kDmguyajM7NWgfoHFT8eeKV+bHqYKxBPNHjXB61+b/JSwsz7bnShQ
	oJiMM4GcS3K9QpEAHw7sVAjZ/SB+YnNNc3g6E6WK1k2cY4CkU/tiqzpTnD8=
X-Received: by 2002:a05:7022:519:b0:119:e56b:91f6 with SMTP id
 a92af1059eb24-126f47dc251mr2122264c88.39.1770277185811; Wed, 04 Feb 2026
 23:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
 <20260204211436.1821958-1-kuniyu@google.com> <bf498b0f-7bdb-4668-b2de-80dbf9b0397f@linux.dev>
 <73175419-adbe-4108-a734-ff409ea3d1d4@linux.dev>
In-Reply-To: <73175419-adbe-4108-a734-ff409ea3d1d4@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Feb 2026 23:39:34 -0800
X-Gm-Features: AZwV_Qgg1wA_Qp8OpIXs9RmRBR7gamf1VbFSABg4U04-JkUC8Xu-QhokilluFwA
Message-ID: <CAAVpQUALZXmzJ9jepjkSS51n+puFhz6sWpr9QqcWjt6JxtW1Qw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mhal@rbox.co, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:00=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
>
>
> On 2/4/26 4:55 PM, Martin KaFai Lau wrote:
> >
> >
> > On 2/4/26 1:09 PM, Kuniyuki Iwashima wrote:
> >> From: Martin KaFai Lau <martin.lau@linux.dev>
> >> Date: Wed, 4 Feb 2026 11:34:55 -0800
> >>> On 2/4/26 7:41 AM, Michal Luczaj wrote:
> >>>>>>>>> If the concern is the bpf iterator prog may use a released
> >>>>>>>>> unix_peer(sk)
> >>>>>>>>> pointer, it should be fine. The unix_peer(sk) pointer is not a
> >>>>>>>>> trusted
> >>>>>>>>> pointer to the bpf prog, so nothing bad will happen other than
> >>>>>>>>> potentially reading incorrect values.
> >>>
> >>> I misremembered that following unix->peer would be marked as
> >>> (PTR_TO_BTF_ID | PTR_UNTRUSTED). I forgot there are some legacy suppo=
rts
> >>> on the PTR_TO_BTF_ID (i.e. without PTR_UNTRUSTED marking).
> >>>
> >>>>>>>>
> >>>>>>>> But if the prog passes a released peer pointer to a bpf helper:
> >>>>>>>>
> >>>>>>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb=
0
> >>>>>>>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
> >>>>>>
> >>>>>> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a
> >>>>>> tracing
> >>>>>> bpf prog.
> >>>>>>
> >>>>>>>
> >>>>>>> Can you cook a patch for this ? probably like below
> >>>>>>
> >>>>>> This can help the bpf_iter but not the other tracing prog such as
> >>>>>> fentry.
> >>>>>
> >>>>> Oh well ... then bpf_skc_to_unix_sock() can be used even
> >>>>> with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??
> >>>
> >>> It is fine. The type is void.
> >>>
> >>>>>
> >>>>> How about adding notrace to all af_unix bpf iterator functions ?
> >>>
> >>> but right, other functions taking [unix_]sock pointer could be audite=
d.
> >>> I don't know af_unix well enough to assess the blast radius or whethe=
r
> >>> some useful functions may become untraceable.
> >>
> >> Considering SOCK_DGRAM, the blast radus is much bigger than
> >> I thought, so I'd avoid this way if possible by modifying
> >> the verifier.
> >>
> >>
> >>>
> >>>>>
> >>>>> The procfs iterator holds a spinlock of the hashtable from
> >>>>> ->start/next() to ->stop() to prevent the race with
> >>>>> unix_release_sock().
> >>>>>
> >>>>> I think other (non-iterator) functions cannot do such racy
> >>>>> access with tracing prog.
> >>>>
> >>>> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> >>>> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin =
is
> >>>> right, we can crash at many fentries.
> >>>>
> >>>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> >>>> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> >>>> Call Trace:
> >>>>    dump_stack_lvl+0x5d/0x80
> >>>>    print_report+0x170/0x4f3
> >>>>    kasan_report+0xe1/0x180
> >>>>    bpf_skc_to_unix_sock+0xa4/0xb0
> >>>>    bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> >>>>    bpf_trampoline_6442564662+0x47/0xab
> >>>>    unix_shutdown+0x9/0x880
> >>>>    __sys_shutdown+0xe1/0x160
> >>>>    __x64_sys_shutdown+0x52/0x90
> >>>>    do_syscall_64+0x6b/0x3a0
> >>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>
> >>> This probably is the first case where reading a sk pointer requires a
> >>> lock. I think it will need to be marked as PTR_UNTRUSTED in the verif=
ier
> >>> for the unix->peer access, so that it cannot be passed to a helper.
> >>> There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted
> >>> one now.
> >>
> >> Just skimmed the code, and I guess something like below would
> >> do that ?  and if needed, we could add another helper to fetch
> >> peer with a proper release function ?
> >>
> >> ---8<---
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 3135643d5695..ef8b4dd21923 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -7177,6 +7177,14 @@ static bool type_is_rcu_or_null(struct
> >> bpf_verifier_env *env,
> >>       return btf_nested_type_is_trusted(&env->log, reg, field_name,
> >> btf_id, "__safe_rcu_or_null");
> >>   }
> >> +static bool type_is_untrusted(struct bpf_verifier_env *env,
> >> +                  struct bpf_reg_state *reg,
> >> +                  const char *field_name, u32 btf_id)
> >> +{
> >> +    /* TODO: return true if field_name and btf_id is unix_sock.peer. =
*/
> >> +    return false;
> >> +}
> >> +
> >>   static bool type_is_trusted(struct bpf_verifier_env *env,
> >>                   struct bpf_reg_state *reg,
> >>                   const char *field_name, u32 btf_id)
> >> @@ -7307,7 +7315,9 @@ static int check_ptr_to_btf_access(struct
> >> bpf_verifier_env *env,
> >>            * A regular RCU-protected pointer with __rcu tag can also
> >> be deemed
> >>            * trusted if we are in an RCU CS. Such pointer can be NULL.
> >>            */
> >> -        if (type_is_trusted(env, reg, field_name, btf_id)) {
> >> +        if (type_is_untrusted(env, reg, field_name, btf_id)) {
> >> +            flag |=3D PTR_UNTRUSTED;
> >
> > Something like this but I think the PTR_UNTRUSTED marking should be don=
e
> > right after the clear_trusted_flags() where it is for supporting the
> > depreciated PTR_TO_BTF_ID. Before that ...
> >
> > Alexei, can you advise if we should change the verifier to mark
> > PTR_UNTRUSTED on unix_sock->peer or we can deprecate the bpf_skc_to_*
> > helper support from tracing and ask the user to switch to bpf_core_cast
> > (i.e. bpf_rdonly_cast) by using a WARN_ON_ONCE message?
>
> After trying more, taking out bpf_skc_to_* is not enough. It still needs
> to reject passing unix->peer to bpf_setsockopt for bpf_iter, so
> PTR_UNTRUSTED mark is needed.

Ah exactly, I'll cook a patch in that way.


>
> >
> > The problem is that the unix_sock->peer pointer is not always valid whe=
n
> > passing to the bpf_skc_to_* helpers, so it is a UAF.
> >
>
