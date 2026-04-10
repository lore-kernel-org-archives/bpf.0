Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE0225417
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775787764; cv=pass; b=sXqRUrvFSg/nskmz59Z2kqSw9l6VUVrIYrnY6OifxYCv4yoruljpJFqSF0zzh97UuSlNOAaFHcKI19tjmOsaDLp3PUSuY60fXsJR96mOBkdG2MOabkws6fECK2J4quuKTuyv63bxJQz5zOZsSn9vmih6539c7dRI31Ck/r8FrVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775787764; c=relaxed/simple;
	bh=wTVyE6RAC9LG4qz8B2+MRjjr0hw+F1mfiEb1uHlOaGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww1jYXOq5DY+i6rkcij3dUmg0iywp7Cu4kLQa4NUmvydcuZJxX2J68ENQJiYKM8ML5Q2Pq5E0lnRapvEYiJdqxYz6irn8c+5YUOb+PsRhKWdVtelWuuVSTprkcCf1UUwCaH/Fd9jlgUMOqcmPK0TdaRoF0QZpfiaErzMXN1Gp/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Jm9Ljq; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Jm9Ljq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so840485b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 19:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775787763; cv=none;
        d=google.com; s=arc-20240605;
        b=TFX0SRi3u6WTjt5sWqooa9O9fhDQ/cU3djcTNMClvDDyENOS1mcxIjRDVPSkHPMSIm
         9fTCzR3iTpdN7f6MamyQgyGR8z8zHtRS1tuWa+P27wU7vEmY0ql1T12yVL+iD1lD/iDw
         4+HpDmhduJZ0CqfGrB15BlHJ5omIr25Cg6zW/3DlysgZh6fFOF7y+1xFeWwRS+a4y7R7
         IqRq7zQRNOuXSKZEPxjHFYVLYv8w1b2mYr8IgStkWXtekTQ8A01DDKp8biVOq7DPs7an
         6z++IfIinQ5vZbT2FXa8wzezrHTRruU9hTkGNUmyoo89F8E6sjmCUqUYcYHEUA8EV1C0
         aWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcvcH/A1SDEsdRXqEgpBsFuL/hniK+b8ZOXg6/qNCls=;
        fh=Mt1caggX7Ts6abrwrZASysfIHTT+awy8AnLa1A0iwAQ=;
        b=jjE0ANX4nUaP48/M56sSlsSBskXx+rmWJtHpom01QWF0ROLl4U1gXAIiyELm5NZExb
         Ph9W4sZJhfJzES9NIvg6GO4UwzcoYE9d8YEKgmVeUOWxZknSi35V6YnHyCh70XWu/2LP
         9SjUKn6P7QgMyAn/U/vHtQCUWflkdeMQ06XhUn7RYYTlUu1UU4FWpm0hnZ7E22nKskdX
         Azut3pVjnI5tsInZL30DtRgdomr9QlXN7FPSinvkT3YRGhEBrB5XVqjzntVB0QV7I768
         LUUfTrSvKEmiXkYJGRaoWAv1RSUtE7P+UK6LasNqUl0pV6wIha4k40T13ebcgKSuWw4+
         Afzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775787763; x=1776392563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcvcH/A1SDEsdRXqEgpBsFuL/hniK+b8ZOXg6/qNCls=;
        b=V9Jm9LjqWEMgNlxUKqeceHZ4zzFjZKxekgyQdeq3C8GC4tITWD4XewLWHMEUEHaqdn
         QUe7fJJ1jGzQwsywvgzckT9puByRQm3RTT7g4wgMSH3IdjhAKGRwv6XsIgreo2u3+al1
         5kqgZEqqbTqO1Z86+WzMNnWGWlNdBzgJn0swo2wcU3RTFUP/bNNQiWM0TjqUzZ7vKU/J
         YO1iAx0rO9wgeAeNnTduIaDCGonni+TyouRpIxRm13dhLWCks7lquVMAYmLnuMKPSp2j
         sTdgM3dhTRlhYCVajVvmSv63UoiQg7hPv8n+b5gUDPJaNwbYtreVenK/+qeTvSyIVAlg
         DTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775787763; x=1776392563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcvcH/A1SDEsdRXqEgpBsFuL/hniK+b8ZOXg6/qNCls=;
        b=nA9B7EaDsvCtvqYGsL8te/Vl8d3O0tjvKGB6W+/AMhFb1ZK1VULmnVuSOo3K3usYYZ
         V6QTikNm5awHPjz7AdB/2W2+KvVvW4KIOInaoRCL1ptWBYlOak8fp10p5RxYndY0AZsV
         +Bdsn6a94zlVcU/1zZ+R/ELvdnauDN4PqLQPOU5ZEMsceMziauqq4ApiksBVYOibRWs7
         uHZLrrlg7UQetnwq7Om+ciUPEjBE/IvsIInjWWUPiSdDccz19LQofkjSZHOkMtSRWhgE
         FuoKQ2yCB27xCi2n/4YexWJuD7Gt2m9q4eoV3vTDzJGEIOCAmlxLCKwwsB53bzytYxEZ
         DrhA==
X-Forwarded-Encrypted: i=1; AJvYcCXx/ZYllcTB9W+ZtP3Y3UKnvx7AHr/CpxoY7Jzzm2Go84kpfqWw0t3BQV/IvEtGk2aQ2+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztezyXHyto+EqnQDoYT1tgspugLhMdAqDGnz6F6VTZ1Fej3Vdf
	1LJFnL1X7mp9p7T28o05ERRMrbECQNIL1vwoyUeuqv9pKG3hscixllP+9eo1UD+E/egteVmTjmc
	sRUbtPMCRpXevCz4ZnZPfkmDEu/2LRbE=
X-Gm-Gg: AeBDievQvWOo0xMbI5tbB15lq4Rl5IWoQ//Dwv0rA77uusFACbnwFtNIhkKvvL1ZkK9
	26SDrCGbWqfhCUOLS2d4c9V1RcIzbbTKH99lXKMIzBXKgtuPFYO8I4CxElj9vWQ3QIcK3X+1XPt
	HAeLifXSONtaSlSyxttBTJMOoHrfGelvn5k8aBHV9uv1Bsjtjk6jGwhOAg6e7LqyLV1PGndjd3a
	9X0HcCqaKYDn1x2xJFaKLJJ6k6lOluNui7kWgFCvUXdlx2I5Pf6bsoyRP+AeZAnoseOEdoaJKeX
	AATduQ==
X-Received: by 2002:a05:6a00:2d81:b0:82a:69db:b9b6 with SMTP id
 d2e1a72fcca58-82f0c25e24emr1647900b3a.5.1775787762620; Thu, 09 Apr 2026
 19:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403170900.58659-1-pilgrimtao@gmail.com>
In-Reply-To: <20260403170900.58659-1-pilgrimtao@gmail.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Fri, 10 Apr 2026 10:22:31 +0800
X-Gm-Features: AQROBzCEED2m4RzMMV6P43pzUld1hT44MkCcZKX7-cxY6G_CD4VORXL58IO11TI
Message-ID: <CAAWJmAZkSqSOJWQbbQVA2uL7xbSwawDiiLw9P6UWreVw93XR_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: Refactor how the verifier matches kfunc checks
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, Kaitao Cheng <chengkaitao@kylinos.cn>, pengdonglin@xiaomi.com, 
	song@kernel.org, Eduard <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Jiri Olsa <jolsa@kernel.org>, memxor@gmail.com, 
	Yonghong Song <yonghong.song@linux.dev>, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 2:41=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 4/4/26 3:38 AM, Chengkaitao wrote:
> > On Sat, Apr 4, 2026 at 12:49=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >> On 4/3/26 10:41 AM, Chengkaitao wrote:
> >>> On Tue, Mar 31, 2026 at 1:05=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Sun, Mar 29, 2026 at 7:05=E2=80=AFAM Chengkaitao <pilgrimtao@gmai=
l.com> wrote:
> >>>>>
> >>>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >>>>>
> >>>>> [...]
> >>>>> +
> >>>>> +/* Kfunc family related to spin_lock. */
> >>>>> +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[=
] =3D {
> >>>>> +       KF_bpf_res_spin_lock,
> >>>>> +       KF_bpf_res_spin_unlock,
> >>>>> +       KF_bpf_res_spin_lock_irqsave,
> >>>>> +       KF_bpf_res_spin_unlock_irqrestore,
> >>>>> +};
> >>>>
> >>>> I think it's a step in the wrong direction.
> >>>> I'd wait for Ihor's BTF_ID_NAMED cleanup.
> >>>
> >>> After reading Ihor's messages on the list, if I understand correctly,
> >>> our two approaches seem to target different problems. What Ihor's
> >>> work appears to achieve is the ability to remove the entire enum
> >>> special_kfunc_type. My goal, on the other hand, is to replace many
> >>> scattered func_id =3D=3D special_kfunc_list[...] comparisons with a
> >>> table-driven approach.
> >>
> >> Hi Kaitao,
> >>
> >> I appreciate your efforts, however after a quick pass over the changes
> >> you propose (both here and in the new series) with respect to BTF_ID
> >> macros and special_kfuncs_list, I don't understand what problem you're
> >> trying to solve.
> >>
> >> The inherent complexity is in the fact that the verifier must know
> >> when a particular BTF id identifies a specific kfunc, or whether it
> >> belongs to some pre-defined set of ids. This is why
> >> special_kfuncs_list and other BTF_ID_SET/LIST-s exist.
> >>
> >> And so there is no way around defining those ids and sets *somewhere*,
> >> and so far BTF_ID_* macros did a fine job of that, all things
> >> considered.
> >>
> >> AFAICT your changes simply move around the same definitions from
> >> functions with if statements to constant arrays with a runtime search
> >> on them (which is slower by the way). What is the benefit of that vs
> >> the current implementation? We still have to maintain those arrays in
> >> the same way we have to maintain the is_foo_kfunc helpers.
> >>
> >> Your newer proposal [1] takes the same idea to the next level, by
> >> introducing an entire new BTF kind, new ELF sections and a bunch of
> >> macros that are no less complicated than existing. And all of that
> >> just moves the same arrays "upstream" to the .BTF_ids section. Again,
> >> I fail to see any benefits to that complexity. Having differentiation
> >> between LIST and SET, and having to mark START and END is not a
> >> problem that needs solving IMO.
> >
> > Your analysis of the code implementation for the new proposal is correc=
t.
> > Let me elaborate on the purpose behind my approach.
> >
> > ****** Purpose 1 ******
> >
> > As described in this patch:
> > https://lore.kernel.org/bpf/20260303135219.33726-4-pilgrimtao@gmail.com=
/
> >
> > If we want to add a new kfunc, bpf_list_add_impl, we would today have
> > to add "btf_id =3D=3D special_kfunc_list[KF_bpf_list_back]" (or similar=
)
> > five times in verifier.c. ...
>
> Kaitao,
>
> I think the maintainability pain in the current verifier-side kfunc
> handling is clear, I don't think anyone would argue that it's not a
> problem. Your bpf_list_* work is a good demonstration of that. I agree
> it can be improved.

Hi Ihor,

There is already discussion of this patch series at the link below.
Please keep follow-up replies on this thread so the conversation
stays easy to track.
https://lore.kernel.org/all/20260329140506.9595-2-pilgrimtao@gmail.com/

Adding more logic in verifier.c is not necessarily a good thing=E2=80=94it
is already over 26000 lines. The .BTF_ids approach does not reduce
the verifier's logical complexity, but it can cut down redundant
verifier code and hide the intricate logic from kfunc developers.

To address what you raised (for example, lowering verifier complexity
and making the verifier more modular), I need to think about whether
there is a better approach that balances these goals.

> That said, I don't think extending .BTF_ids and/or BTF is the right
> way to solve it.
>
> > ... Under the newer proposal, that is no longer
> > necessary: defining the kfunc and its verifier metadata in one place
> > is enough, for example:
> >
> > __bpf_kfunc int bpf_list_add_impl(struct bpf_list_head *head,
> >  struct bpf_list_node *new,
> >  struct bpf_list_node *prev,
> >  void *meta__ign, u64 off)
> > {
> > /* kfunc implementation */
> > .......
> > }
> > BPF_VERIF_KFUNC_DEF(bpf_list_add_impl, list_api, graph_node_api, ... )
> >
> > If BPF_VERIF_KFUNC_DEF is extended further, BTF_ID(func, bpf_list_add_i=
mpl)
> > and BTF_ID_FLAGS(func, bpf_list_add_impl) might also become unnecessary=
,
> > so the snippet above could eventually be close to all the code required
> > to add a new kfunc.
>
> Defining a kfunc metadata in one place is a reasonable direction in
> principle, I agree.
>
> Where I disagree is the mechanism. The complexity does not disappear,
> it just moves into .BTF_ids, new macros and resolve_btfids. The
> primary consumer of this metadata is the verifier, and I think it is
> better to keep that metadata in verifier-local C definitions instead
> of encoding it into .BTF_ids. Adding more indirection to this will
> only hurt maintainability IMO.
>
> >
> > ****** Purpose 2 ******
> >
> > The kernel no longer needs enum special_kfunc_type to list every KF_bpf=
_*
> > entry. That information is folded into the .BTF_ids.##sfx section inste=
ad,
> > so kfunc authors do not have to touch or think about special_kfunc_type=
.
>
> This is not an argument for the .BTF_ids extension. Removing
> `special_kfunc_type` mirroring is useful, but that will be addressed
> directly by the targeted cleanup already under discussion.
>
> >
> > ****** Purpose 3 ******
> >
> > As described in this patch:
> > https://lore.kernel.org/bpf/20260303135219.33726-6-pilgrimtao@gmail.com=
/
> >
> > In is_bpf_list_api_kfunc(u32 btf_id) there are on the order of eleven
> > "btf_id =3D=3D special_kfunc_list[*]" comparisons. As more kfuncs are a=
dded,
> > every is_bpf_* helper will only grow longer and the verifier will get
> > more repetitive. With the new design, those is_bpf_* helpers can be
> > removed entirely, including the awkward scattered "btf_id =3D=3D *" che=
cks.
>
> The repetition is real. But removing is_bpf_*() helpers is not
> automatically a simplification if the same information is now encoded
> indirectly through section layout or local const arrays.
>
> The same metadata is being maintained somewhere else, with more
> indirection than before. The complexity just moved around, and was not
> reduced.
>
> The scattered "btf_id =3D=3D *" will remain as long as it is necessary fo=
r
> the verifier to do certain checks or other work depending on the
> kfunc. Whether it's an array lookup, helper call or anything else in
> the condition, the condition must be there. Refactoring can't reduce
> this complexity, without changes in the verifier control flow.
>
> >
> > ****** Purpose 4 ******
> >
> > It pushes us to untangle messy verifier safety cases and make them modu=
lar,
> > so they can be expressed as parameters to BPF_VERIF_KFUNC_DEF
>
> Again, I agree with the premise that verifier safety checks could
> become more modular where possible. But I think we should first
> separate two questions:
>
> 1. What kfunc properties should be declared centrally?
> 2. Where that declaration should live?
>
> While I'd like to answer (1) with "all of them", I am not convinced
> the answer to (2) is .BTF_ids or BTF. A better C side declarative
> representation would give us most of the benefit here without making
> the BTF tooling more complex.
>
> Here is how I think we should move forward:
>
>   1. Your bpf_list_* work is orthogonal to BTF_ID refactoring, so it's
>   reasonable to first focus on landing it without changes to generic
>   kfunc handling.
>
>   2. I plan to send patches (soon) for resolve_btfids, and then for
>   BTF_ID macrology to eliminate the enum + array pattern. You are
>   welcome to join the discussion and review / test the patches.
>
>   3. After all of the above lands, we can come back to the general
>   BTF_ID / kfunc handling discussion. If you are interested in
>   developing this further, I suggest to re-think the approach and come
>   up with a "single kfunc metadata definition" that doesn't require
>   significant changes in .BTF_ids section layout.
>
> A slightly off-topic comment: the usage of `_impl` pattern for kfuncs
> should be considered deprecated. Any new kfuncs that work with
> verifier-supplied arguments should use KF_IMPLICIT_ARGS mechanism.  So
> the `bpf_list_add_impl` in your seires should only have one version:
> `bpf_list_add` marked with KF_IMPLICIT_ARGS flag.
>

--=20
Yours,
Chengkaitao
