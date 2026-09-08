Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806949EC7B
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870178; cv=pass; b=e0vGhDcWZ1TpSxoAzvZDujIo2Wscvk7b7ZnFlKeSeLPxi+TZ2w8Xiuo4XL7V7Pxd3Mc6S6Wq79NIG546K7Jgzs1HmWFov/njclyQKvwl/FKZsBGRo+i1810GaXnzlsT25s9x4iS+iwuDfUKLCF/NUnIWy/9UlTyx5y8laX+Hrcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870178; c=relaxed/simple;
	bh=jNKMxx0MOdU8RjRdPogMBdpEV9wM37Jz7FMCb1o4W3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBDoi6lewz0kUq1HoIwnlRR7aLzqxLjOsQhLKQZZow/pmfDAg3U5GgIb5swfw4CWsPxeb9x1PlW2hJkC4a21rtA6fExYz/DXuJqt50typpQgTNYZ1DFA23BQT8+VfFT2JzVePZ9Z/qxfuQGCVdAHRIY2F5mAabxb5HX9sqg5LLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLQ+KRLw; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLQ+KRLw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e2dab83eso774985966b.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 05:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788870175; cv=none;
        d=google.com; s=arc-20260327;
        b=V0czlzYy4zbD0njBBPXMqB2zDMeQTqeSPcPuNf/MfiNx4nubhSnoS5UqRAGscHU1bZ
         Yzp2OCUR9QzcRHqqau/85Pmt14Dp+Jxdbz6kyVoitCoBbQe7qkFWJluKdPhCWrhdbyfj
         PYMhXGwfKKhPX4txqZ5d2avTgW/DX0xeHJwH/HxbepkfPCn96WcN1TFLWyw33XQu+zi8
         hVDXPOWn9YR08lNjlYfl2pJncoRHP7EpSBprdqH9r44j1Q5Jndpt2u0WYnpTBDr291WL
         RbCSYYh4iR1BjFTjq+76ImPbbJUH2EXCrIYjlfjLz7EZpHnUie8Dn1/vfQ+E4WHqPlKc
         7vUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOTX3LhGaqV8k/2U8+BV0Xzd4XXbDTqUOYRoKAoVoyM=;
        fh=kFIDmAGcIldNPHeHwvFM9RhetWJQIgBJh/GzNaiGBSI=;
        b=NGxFKfq6EjqR+mdcXcJkOW1R0LCeJCtFSc5GmRmiHFUNJudWrxPx0hsOtTGwN5a32N
         8kNyq+alhHqlrRabcOWpAHopmYbEllkLHk14H2HgVRWBwO1kgOPMtQ10O8E+/hL0B1Hr
         PFln98PJJWsp49Ou0b1hpiKOCa3R6iOgeZgBhLMF8DK1SDIdjT6IuF9FG6+HxYz8fEj9
         e+eTtM5f0/N6+59tNfxPIYB80cNkSNpixRRF3PKugDmtm9vtAXIMOuo/OacfOA+8sbpU
         3G5lOzoE0K5Kws7h7GiVMC39qMqaaq6YkWCVEISMoLArHl8OsbFqwAsBTYBCr+Fgcend
         vS1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870175; x=1789474975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SOTX3LhGaqV8k/2U8+BV0Xzd4XXbDTqUOYRoKAoVoyM=;
        b=fLQ+KRLwzc6dO1YFT+g5rEtaDrT48USwXl+CfWDi3F+KE4IjWK04umd26+zYBA5B6v
         EJ0/Uma3RrgqILQ9x4ajprs6fu0MD4Kg62G7EsNg2CNOTcZ2EdlPc0lXp90Cjj3BG7KA
         vjVBKw/4W63a/a6w//vLtmJnQLCUXShNwdDhQ/HSucmkEOb5S0LI/pRq4oNj1OlVKpwB
         cKEdgtqrSS4034DFvyzOSriioXvTHfBw0FhfEfu35/qCicXtp7dHUo1S5HIXN5mNQtaV
         eIPCFlrHs5oalxhbYRiPBSaOXSZP9lPgu3Yo5DEv/F2HC3lUqFtnXQqCQoFRMhZy84R6
         a4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870175; x=1789474975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SOTX3LhGaqV8k/2U8+BV0Xzd4XXbDTqUOYRoKAoVoyM=;
        b=dIa4gCnI4ZKTg+VlA86rydqmt4DgOP/aT98coDejh2irCE2Iq7B0rNlNG5hhULrO2k
         o/++1kGuA3aCt3BQIdq5v7Mx6C7NKVTJAmfetCj8CQfCfnmfVJZbGK55Zb+mipTtoFC7
         PsRcJlyMMgD9lBWr4ECayG5OSySMEoVKBRLrkfeUUIhXYayrEeY0a8kPeFlMtqnX5ssR
         /Gx41CbhW0G+svSR/ByQ0gxle8qRtVbeWGgvaR7e89NH0yK3va0JHwnNmW0zm2uYWClV
         B3XIuHWB0wBGTnDalg8nWa9rEzxm5h64VqY4DkT8MNSnUhzVg8eZm0Y+NfrBhhw3hKV1
         R7EQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8FXwL6Hi8TwLuUe5X53DrSpV37PKoBFHIk9z+oFFmfo5uuXf1cE8f90F4CnT38uJfWIs=@vger.kernel.org
X-Gm-Message-State: AFuF++mJfjSXLTjJ6KwWkLB+WN919VWdNiZYAZT8s0kSuXJ3OcC1LnLD
	CX16as8W3Wy1fw2lZ2nhuTJhyxsqjF9ZumWYyMXeg5W+CtMv6f5yzOq7xt4Gdo7Lx20CuKaKh3y
	0eME6zRwCR4EeQGe8EuzwQVKWkQMX7gQ=
X-Gm-Gg: AYBFou0QfMA54m4Gi0B7Ep7KxTgEi+hcVNxOCSxH4H8pO9jXugU88BQEa0etAiNH8Wg
	vD60AsEdqYYwV4pVVg9w/1NPqKJb54qJ0Dv+kt89W9F76Jt1krcrPRlVTluPt1MGHmandf1XjLY
	6Td7ztQsLCtAi+nqwUEthKtwA/zZvEAFmdWKae82mZcdAsGgFw4/hInbeL8BXq4nOntPT5jgb9Y
	jtA6Gux49n8UYrh7ctSkmd2NWh1zmMrjxrasJ1Z/eAFslUhKChZsFKicmzYBjXKnvEPPWGbO/Ns
	ru5gpzMphdOKj4hogYqMaksxdekbuQcJoRHI6fJ8PrAGX/2k1Fb8SsRw80W3
X-Received: by 2002:a17:907:d01:b0:c26:19de:913a with SMTP id
 a640c23a62f3a-c2619dea224mr932569166b.45.1788870175001; Tue, 08 Sep 2026
 05:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907134552.1772405-1-puranjay@kernel.org> <20260907134552.1772405-2-puranjay@kernel.org>
 <20260907140642.B02581F00A3A@smtp.kernel.org> <CANk7y0j33fmyQyTvL37Tx6Ua_bGfT5n_=Smw44u_H7G6rMcr_Q@mail.gmail.com>
 <CAADnVQLeCzCAF1Ku2Ri=PUfespAKPMEO_qQLJ1XEhAtLERgeBA@mail.gmail.com>
In-Reply-To: <CAADnVQLeCzCAF1Ku2Ri=PUfespAKPMEO_qQLJ1XEhAtLERgeBA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 8 Sep 2026 13:22:40 +0100
X-Gm-Features: AcwNN1VRXI7Dc37t9BPlMRYUgwE1HIP92RRwvyEJXlseQFtzU6l3-Rs3wMRGzow
Message-ID: <CANk7y0gizeJe9tx12a+8VzBAAgzAh1G3N+Ru9mJ+4GJwW1CW+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Add bpf_call_rcu() kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 1:19=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 7, 2026 at 7:39=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
> >
> > On Mon, Sep 7, 2026 at 3:06=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [High] Calling `bpf_call_rcu` from NMI context causes a raw spinloc=
k deadlock because `call_rcu()` is not NMI-safe.
> > > --
> > >
> > > commit 3385037afe11a72dffbb6db99b4174626596c231
> > > Author: Puranjay Mohan <puranjay@kernel.org>
> > >
> > > bpf: Add bpf_call_rcu() kfunc
> > >
> > > This commit adds a new bpf_call_rcu kfunc that allows BPF programs to=
 defer
> > > operations using RCU grace periods.
> > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > [ ... ]
> > > > +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__c=
onst_map,
> > > > +                          bpf_rcu_callback_t callback, struct bpf_=
prog_aux *aux)
> > > > +{
> > > [ ... ]
> > > > +     rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> > > > +     rhk->map =3D map;
> > > > +     rhk->prog =3D prog;
> > > > +     call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> > >
> > > [Severity: High]
> > > Does this code risk a raw spinlock deadlock if called from an NMI con=
text?
> > >
> > > Because bpf_call_rcu is exposed to tracing programs, it can be invoke=
d from
> > > NMI contexts, such as when a tracing program is attached to a perf ev=
ent.
> > > However, call_rcu acquires rcu_node raw spinlocks and is not NMI-safe=
. If
> > > the NMI interrupts a path that already holds the same rcu_node lock, =
the
> > > system will attempt to re-acquire the lock, resulting in a deadlock.
> > >
> > > Should the verifier restrict this kfunc from being called in NMI cont=
exts,
> > > similar to how it uses btf_record_has_nmi_unsafe_fields for bpf_obj_d=
rop?
> >
> > This set is supposed to land after the rcu changes that allow call_rcu
> > to work from NMI have landed. Please see the cover letter for the link
> > to that patchset.
>
> The patch would need to be updated as s/call_rcu/call_rcu_nolock/ ?
> or more will be required?
> If the former then we can land it now.

There will be no call_rcu_nolock(), we decided to make the standard
call_rcu() be safe to be called from anywhere, so no change is
required to this set. But it needs to land after call_rcu() changes
land, or maybe rcu and bpf tree can co-ordinate somehow?

>
> Also notice how your LLM doesn't know about your earlier work ;)
> + rcu_read_lock();
> + migrate_disable();
>
> that should have been ...

You mean rcu_read_lock_dont_migrate(); right ? Will change in v2.
