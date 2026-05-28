Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5B3F6C55
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990170; cv=pass; b=bExfi1NWlnVoW9aIqJqHVbWhNMZAKtiVALh94GtTRLjV+ylAvm7hZA5iCGu53BLkkGn5vIEh33eWICsPRsmblr9PqkzjrFsRmVw1L4GlmaFeMfkiT5rx8up1EaA1W2WWTXAzUXRFWoSxVh2E5Hb7WsVjv45Icj8PT2Psrf0PYSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990170; c=relaxed/simple;
	bh=/5uxk2mh9Pe8nnlC49OnrGbq3S7LQajdTGOV3bFVKpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEcvQ1yxBtiDc0wxS73IXCR1aIgBPLzEy8iyuMAmbsM1djZbRDOm4Kq9p7dzuOnUfsmGZQe0WdPOhB7DHJIMQPBC+kMjyO+PzMfzGU6I6iB0N5yey9AGPpZtOiM1GScfQO20OWIcFJE3gUhjXX/ypcFJQZ5pEYCHHF5Y4zRIVBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmSJlK7/; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmSJlK7/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e61648f10so8451cf.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779990168; cv=none;
        d=google.com; s=arc-20240605;
        b=F67Pzc4bKPMo7ou9ptqDBSOh2caVxkHj3CEL87ZEGBLJYYQng657M/KUW6WX4HC7er
         JYwsOi63uh96hxsK/3jjmWYpPrJqBugyCB7XqjfxmkTefTbJiYVQIsdalIiCW4OO28hD
         68vrXkdH25rUKmV4bkD9KIqXlB2Hj06LR9xlHCot7en6ppVc0c0nZ33XMPs/iRSdp7BK
         8H/207LP0j0PF3tn7gY6ZsCo+BmWBBI0xqy3Q0Q43BSYhvfsmdJrq4mFcPKh54g4xD6P
         uMZnAWqs87/V6bwUJFWnmi8Y6GoJYGtezwYkzCQ2rtzh+YNtSGBpV6TpoLNOvCoMWbLv
         62JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoR5M8BEaxFX9lWfZKBpV6kdRbQ0AiKjHHpbWviWrGM=;
        fh=yw2QU8I3gU1CXmuyGM9CgAvvB1zyVBQEMCV0+BAZhoM=;
        b=Dp10DzCB+aL9kym+Ma4U3wExQjyC3rqC8tNvWmD3hbTYELnmKp3qLf9CbzhTe/V3+p
         wDpFRFGA10csQ6C/FVQIsYGKzwH728e0oS7fELiGghaPjG7eLQzR0eTPC+icw06R1Iri
         HbfpRZm3TtaBrC1WVmDVUgbt1Am35a7WxsTqRb2INQ6TzBwQlLcWKBbD8/L4V7YPNQ7O
         Z3TkFV911DbYG97auiKtUaMz86/NS6lyd7Hk+RBFDOJqGVxdf5VkKoFpl9ZvGsG/KZ8P
         fyRG9D+IfOLD2aeXPCJcKqpxdWJwaFwwYQXY55O1aT8hxF/5vk577RCTtuzRLb/Wdp+D
         AFAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779990168; x=1780594968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoR5M8BEaxFX9lWfZKBpV6kdRbQ0AiKjHHpbWviWrGM=;
        b=RmSJlK7/Az7wvtseUM96wwSdyMCg2Vv+O99cshDqUBsexp4DjFa0FrHiF9ZQKS5eBj
         6FVi9UCm1HEWq6Xy4KUkv/O9OmrpMRVuFAYOwk5Ep6mbtm0ND0KbnDj87x2kD4JfwBdv
         +rEk5wH+5KC5cs4i71Bh+muLNKVpDAH9KhneQ2dribDhLIXd0c0tOx98LqvvKoeMvyAO
         2XcfqD1zSjrGeCVqkfqMbrEtk9teBWviv/tdeVVsY6wXUvxlE5JLoPaA/8LVdRE/VxJL
         yDHYDzdWHxMPjtzMaYIMpzldWT3e4UuWrUZGCoGTg3KwLdnm3ggNkDMSrPF8M5reT9vS
         dutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990168; x=1780594968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eoR5M8BEaxFX9lWfZKBpV6kdRbQ0AiKjHHpbWviWrGM=;
        b=YOnlhTEJrYD/SQoAF8TYxGyCS5e5tnD1ZO+d0eZb2djdF4WVQNZGjqB3ZUw88dqL3P
         Kck98nBWzxm3BXwkOpI7QLGX5eEUTJDDVFpDrEjVClnOQS86SyMXRmstYrwq29xhZR+1
         bxjuPvZVZ+JslIm6qwJQx3eUWGyG13Q95g+Hda4+1c9xIvMu5aq/x60I/yCR6GPrDHVS
         QhRmO6ObZt8S6UjxBDZQP13REZyOLltbj7+U6LfxLKBpvEIwWplSaO0AoO+lPZ6oEIuT
         rzol6uz8/ZfHql+sU7Cam4q7jfnMA9zMh7X2Ro71bgwKc7KDOoAG3kCuGICpWIl/e8Yd
         74fw==
X-Gm-Message-State: AOJu0YweZfJNqn3lDTuZstJQCkgbMbkxHzjNMyU3lU/FBA9ZTeJdKnGz
	ZrvWGeFkvqpT/y7RsAE2srmD2UwrsOBVDidKYJzbu347Kgi9tKv8FszTvR6B/cIrf98FEqGOdeq
	SjEzBRCtjXHoQFFMaWvKUD1IC3YJzOqMjgXqStvMf
X-Gm-Gg: Acq92OFZYtpNfKUBshx3Ewii3vI0ETsp8QnVGyj7ukCoVgFjGKNrMsg07ETj3WDqYRm
	hwY1qrsVV1oB+FhtYtmHXMHYgJbzCAQBHPBxLumIzj2wSIplajqezhGEs4lnltJ8L0RMunuqKoJ
	4OPQMZkOB8OSu5Kzzo1sCp1Q6zEYKF/g5cZdvNkg7PWUM2LysTaasJcWBDLnShn2etZ7jF8q9dU
	PwLttSD296M1e3ns9w0uTAM9pXIKRFq631z0TLPz9uH/C7o0gqGDOuaiL7eOyvnlAazmll3DGL8
	eHhKNYEwjwAgrVwmryiTU249ODg=
X-Received: by 2002:ac8:5057:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-5172c2af309mr249511cf.3.1779990166879; Thu, 28 May 2026
 10:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
 <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com> <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
In-Reply-To: <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Thu, 28 May 2026 10:42:35 -0700
X-Gm-Features: AVHnY4JeQtCBNW52iYtw9rNXcwqBes9meehAu5LI1twyKd6ojvC1gQKixGKTF24
Message-ID: <CAA-VZPnGxmnF3BkukQm5ZNQ4M3FkO9stbAEPWo4jv0qCL9OdkQ@mail.gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 4:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-05-26 at 19:32 -0700, eddyz87 wrote:
> > On Tue, 2026-05-26 at 17:51 -0700, YiFei Zhu wrote:
> > > I was looking at Kuniyuki's selftest for BPF autolowat [1], in
> > > particular why the verifier fails if these two conditions are swapped=
:
> > >
> > >   if (copy_len > RPC_DESC_SIZE)
> > >         goto disable; /* always false, only for verifier. */
> > >   if (copy_len =3D=3D 0)
> > >         goto disable; /* FIN. */
> > >
> > > This is the register trace of the reversed version (which fails verif=
ier):
> > >
> > >   33: (71) r1 =3D *(u8 *)(r9 +16)         ;
> > > R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var=
_off=3D(0x0;
> > > 0xff)) R9=3Dmap_value(map=3Dtcp_autolowat_m,ks=3D4,vs=3D20)
> > >
> > >   107: (b7) r7 =3D 8                      ; R7=3D8
> > >   108: (1f) r7 -=3D r1                    ;
> > > R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var=
_off=3D(0x0;
> > > 0xff)) R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> > >
> > >   117: (15) if r7 =3D=3D 0x0 goto pc+48     ;
> > > R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> > >   118: (25) if r7 > 0x8 goto pc+47      ;
> > > R7=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_o=
ff=3D(0x0; 0xf))
> > >
> > >   126: (bf) r4 =3D r7                     ;
> > > R4=3Dscalar(id=3D888,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=
=3D8,var_off=3D(0x0;
> > > 0xf)) R7=3Dscalar(id=3D888,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Du=
max32=3D8,var_off=3D(0x0;
> > > 0xf))
> > >   127: (85) call bpf_skb_load_bytes#26
> > >   R4 invalid zero-sized read: u64=3D[0,8]
> > >
> > > The oddity happens at this instruction:
> > >
> > >   117: (15) if r7 =3D=3D 0x0 goto pc+48     ;
> > > R7=3Dscalar(smin=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
> > >
> > > The C logic constrains that the unsigned copy_len !=3D 0, and <=3D
> > > RPC_DESC_SIZE, i.e. the end state should be umin=3D1, umax=3D8. Howev=
er
> > > instruction 117 does not record the umin constraint. If the checks ar=
e
> > > reversed to match the patch order, the verifier is sane; the
> > > possibility of overflow is eliminated, so the range becomes [0,8]
> > > after the first comparison, and then [1,8] after the second.
> > >
> > > I looked at the verifier changes and found this commit:
> > >
> > >   commit bbc631085503a7fde9617be18b0657cc9a83910a
> > >   Author: Eduard Zingerman <eddyz87@gmail.com>
> > >   Date:   Fri Apr 24 22:52:44 2026
> > >
> > >       bpf: replace min/max fields with struct cnum{32,64}
> > >
> > > This change means that the signed and unsigned ranges are no longer
> > > tracked separately, but rather in the same circular number.
> > > Unfortunately 0 falls within the circular range [-247, 8], and the
> > > cnum intersection returns the over-approximation result of the
> > > original R7 range (because the intersection happens on two disjoint
> > > arcs), thereby ignoring the introduced umin constraint.
> > >
> > > I'm not sure how this could be fixed without reverting the patch of
> > > using cnum to track ranges (which would re-introduce a lot of maths :=
/
> > > ), but I'm also not sure whether this is an acceptable regression.
> > > Some helpers, such as bpf_skb_load_bytes in the test, uses
> > > ARG_CONST_SIZE, which really does not like a zero lower bound.
> > > Therefore, if that argument results from a subtraction, the verifier
> > > now enforces checking the upper bound before the lower bound to
> > > eliminate underflows, even if the variable is unsigned and thus
> > > invokes no undefined behavior...
> > >
> > > YiFei Zhu
> >
> > That's unfortunate. Thank you for the detailed report.
> > One option is to allow intersect operation to return two intervals,
> > then use both intervals and fork the verifier state to explore second h=
alf.
> > Veristat impact to be measured.
>
> A few notes on the pattern first. Here is an excerpt from the test case:
>
>         if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
>                 copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
>         else
>                 copy_len =3D end_seq - rpc_copied_seq;
>
>         /* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
>          * clang omits the "copy_len =3D=3D 0" check below, which is nece=
ssary
>          * to satisfy the BPF verifier's range check for bpf_skb_load_byt=
es().
>          */
>         barrier_var(copy_len);
>
>         /* Do not swap the order of the two copy_len checks below.
>          * The BPF verifier somehow does not properly track the minimum
>          * value for 'copy_len =3D=3D 0'.
>          *
>          * 91: (15) if r7 =3D=3D 0x0 goto pc+40      ; R7=3Dscalar(smin=
=3Dsmin32=3D-247,smax=3Dsmax32=3D8)
>          * 92: (25) if r7 > 0x8 goto pc+39       ; R7=3Dscalar(smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D8,var_off=3D(0x0; 0xf))
>          *
>          * This does not occur if copy_len is u32.
>          */
>         if (copy_len > RPC_DESC_SIZE)
>                 goto disable; /* always false, only for verifier. */
>         if (copy_len =3D=3D 0)
>                 goto disable; /* FIN. */
>
> Note that "do not swap" comment here is fragile, as clang is free to
> reorder these checks is at sees fit. It will pick the layout basing on
> branch probability assumptions, trying to maximize fallthrough.

Right, good point.

> The pattern in question looks as:
>
>   1: rX =3D ... some range crossing sign boundary ...
>   2: if rX =3D=3D 0 goto ...
>   3: if rX > 8  goto ... // unsigned compare
>   4: ... here rX is guaranteed to be [1, 8] but verifier can't infer that=
 ...
>
> The (1) part is important, if rX is non-negative the cnums logic would
> infer true bounds. In the test case the negative range for copy_len
> comes from the arithmetic at the beginning of the code sample.
> I don't think such situations occur often.
>
> The main difference from non-cnum verifier is that from `rX !=3D 0` it
> was always able to infer a umin bound of 1.
>
> With this in mind I did two experiments:
> - At each conditional jump, if cnumX_intersect in refine logic
>   produces multiple arcs, fork the verifier state to represent each
>   arc in it's own state ([1], horrible code quality but good enough
>   for the experiment).
> - At conditional jumps of form:
>   - rX =3D=3D 0 / rX !=3D 0
>   - or rX =3D=3D rY / rX !=3D rY where rY is known zero
>   - when rX is bounded and it's range crosses sign boundary
>   Fork the verifier state splitting rX range in negative and
>   non-negative parts ([2], patch is fine, tests need refinement).
>
> [1] https://github.com/eddyz87/bpf/tree/cnum-intersect-split
> [2] https://github.com/eddyz87/bpf/tree/cnum-split-at-zero
>
> Approach [1] has some nasty verification performance regressions,
> because effectively it introduces a fork at each comparison with a
> constant. These compound when there are several comparisons within a
> for loop body. E.g. blowing up verification budget consumed by
> selftest test_parse_tcp_hdr_opt.c.
>
> Approach [2] fixes the issue at hand and has almost no impact on
> verification performance when tested on a set of
> selftest/scx/meta/cilium programs.
> It is fine tuning for a specific pattern though, but one might argue
> that zero is special and this behavior matches the pre-cnum umin logic.
>
> I'm thinking about a somewhat more generic approach:
> - a data flow pass collecting symbolic constraints on registers
>   (e.g. rX !=3D 0 =E2=88=A7 rX <=3D 8 at instruction 4 in the pattern abo=
ve);
> - and using these constraints to:
>   - refine rX range during main verification pass
>   - deciding whether to call mark_chain_precision() on memory access
>     by inspecting constraints (e.g. if constraint guarantees that
>     rX <=3D 8 and memory access is safe when value is <=3D 8, there is no
>     need to do mark_chain_precision()).
>
> This might make sense if mark_chain_precision() part would result in
> measurable verification statistics improvements.

Thanks for the tests!

I personally think zero is special because of the signed bit, and
ARG_CONST_SIZE. While the symbolic approach sounds ideal, I'm worried
about the complexity of such a symbolic solver; checking if an
if-condition is reachable could lead to a binary satisfiability
problem. Of course, we could dumb down the symbolic solver, but the
question now is how aggressively the solver should attempt to
constrain the values, and I personally think constraining to ranges is
fine.

YiFei Zhu

> ---
>
> Of-course there is still an option to revert cnums altogether.
