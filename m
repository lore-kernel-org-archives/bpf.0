Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E93E1736
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538333; cv=pass; b=C+L0aCZWkl52aD0NBDamoLBJDotZfSTpZJ7PVYH7UN1yNMtvP0bGu5yXm2LCcOjdn2X62hoSTpu1gCF5kPHf/LYugNE+SCWZceoz3bPrpJ2kBjyc/H9Ux7yVi2VfzM7peh72RflrR6CuPZbYXYr2zxJ+TFSbFtb/NDQIV1TU+KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538333; c=relaxed/simple;
	bh=sH6q2n0fEFKEDFrWtEHeSL+NM063im3DtO6/1tRC2XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rehtU1ri3s2PokgMFu1XluIHS3D7f9aTNfcY06vQFAGpVTMn/lkkUxI6i49bUmrtN6M4ohHYNN+l9r/TeRlmA6LVck7B7Siw/rRR84yjbLHqV+wmDbE2j4Erj4VHi2ctTmC2X2sFSLnjwVW0VS4uKdTOdzRBwNKWc2bqyM4EwOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpySS9aE; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpySS9aE"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2ad9so452323fac.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789538331; cv=none;
        d=google.com; s=arc-20260327;
        b=mDNE71eXqLcxnOsOeOgfYXquP1CV7Gmhy0CZKcWaj8JoOX5SRpnygX9boeyeF6yoG0
         n0GHzxE/9NrBWNlRCvTs+4cRVcarLZ6vDLUCa3i2acyb3mtRZT4i55dZVl4jbS1BuosD
         LLdnDvv0gDXnSu0sN6BFR0g0Z0Wx10+LktVrMgfDPc8Js6jVqggYCm5CU8TjU2fKnV0A
         sQnzrEZxjOhFqmEvsYHnM1nLZ9hJ4fzTvjlIWj2q1TmydAavvOk+H0ZCuBvLkqKZmNO6
         DnkUHLAFLcCeymN674ucLyD7KHHuEW6wAkAZ03Z8zxip5vEs6HDx4csO2DucWA3pCgmO
         A/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5AbQA3VtvnqFs58mhGvbJnJvuR1sEBRnKiAIXt7xc20=;
        fh=gTMnKQOEjPifQ76zkpnUAsa464a59Rp5jluFZ9Fx5Gg=;
        b=gwazKJZHx17G6tf5PlUB+d4DYMU7Fao7H4ldZAVNET2TpK8qGakPLl56AeYrmRsrx3
         hrr+ztwgLQB+VZdlLpR0KpHXuJeqLieSVLCxfScaz0aRvXIyIrs3BajLQeT5CPY0bXpU
         U80PtVa7CMk8bQf5BzSRdHbYOEgXvwq+9/pzd0PBCqFYJSuYOu7M5EVzqwjbMVPvVWF2
         +o8b8dvXFCOVI1vi975a2EuXfVyYr46skALj/4fXwRKIpMGVUc20XPCTsNfXNnPT7PAE
         Kog/lKPvN275+NdMbx5fAWbGjq4mHco7/zr2EuicdR15ANVGfOMPOXxEIvjxFCnAKMfX
         2S8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538331; x=1790143131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5AbQA3VtvnqFs58mhGvbJnJvuR1sEBRnKiAIXt7xc20=;
        b=PpySS9aEaWrO/sQoDTLaC+UbTJs4T/YY0tLMUfXtbzuNnBsaDX2C2B0v0zJlA1KXjV
         Zc2Mat88qcQBOoC8HwS6m4MgoPJx3sy7ipAGug2cLwGJIUb7pagrP9Yynrp7HLaqiTJ0
         e6Y9YeUqQOo9rcF8WDp4uNEOj9iyjgdfD37TzJHN6+nkR7eoGs/97bFze9vDUOkOqst+
         SpDoY+J0ZYRoQCUpMQagr1HpsaOkNDkV0/mohJC8/CaK6whMt+Pbuhe+gVv8BRKc8Cxa
         QWzOX2kFW0sixYdZUhqXeS0zsBc+e6hstjQC0v4aj+Tgj4NJS9EFKIJit+TjajJWHkdb
         Ob0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538331; x=1790143131;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AbQA3VtvnqFs58mhGvbJnJvuR1sEBRnKiAIXt7xc20=;
        b=uIklBeNEIqGJ6bcXn1fPESteqSvo8yXeC130GFVEhDDzvtUN/3l39yQtpqHYDIVjYO
         fvfmOu1IaoAQ0UbSTnl1YcyEfNbqMx1fWgiWtIpmuROsLj1dx5UmxSCZgKzhT8L1Vj06
         NMwCfEF88Wdh+l5UQxi22yHRwwz/pFpHr3HI2rWXu9JoLO+4Ppc4qbmMQ5KDFmHm48Jn
         BSKted18rHk/Ks757d08gq72cr8ji4amQjerLre1NfclpPcNAKtl+CpAgADd3ChtJwG+
         yBuhmez0I27CmjHmNoy5cL2daSQK6ETRHzziiE2nLdavWGOEquf84wXUs8oH9EYVTicD
         t48g==
X-Gm-Message-State: AFuF++leTqaA0ezruZiXeC0rktZruyWlTlu/akP/o4f+olpUky0SFjwr
	cqz0eI2AWt1EAMIxJoqszcqHWzLFItae0pbV4gbCrqWWB8IaQdJZVLriVCWDClv+yIE0S4oTvxf
	wz9M9/zHTchWRHqQQF+fkaOgD0cTeTMA=
X-Gm-Gg: AYBFou2rg3B24nIAruQWu09v6KhlSWWGsxXzk0X1rxRt+zRMZjM9g9QXiFKacFCvFIG
	5lG0ODXDS3HHVVfMcXfDSF/gfsbn2O5SwfZ5cAPLLIm+A3OdKmUKOs2vWekYYRkQohuVn6C+DbC
	5QJ5e5NfBmqUL0+RJr2mKGMZIIPvk/bmbgZW2JUMd2nw06ueTv3QX097TIvWAoygVIGH5oV5N2k
	nV4L8tdo1aD06dKo+y8KII4T3SVEVmGflRzRbt2oLu8ssSCkOHcdkygojrsYdjcnmt2TCbvsV46
	W7Ht/q6/h3N1c0spEmimCt2iSrNk13678xa0kz5a8TvXwXRReZR8KJ4=
X-Received: by 2002:a05:6808:1512:b0:4c5:238e:b14d with SMTP id
 5614622812f47-4ca4a3f6951mr3000580b6e.6.1789538330893; Tue, 15 Sep 2026
 22:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916050830.8774-1-emil@etsalapatis.com> <20260916050830.8774-6-emil@etsalapatis.com>
 <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com>
In-Reply-To: <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 15 Sep 2026 22:58:39 -0700
X-Gm-Features: AcwNN1UEDpbD7UAOpj-CsBXx0PfZrtDh19Bu9PQqOkhwTuL81VJ5WbpkRqFuQdg
Message-ID: <CAMB2axMSmYcJp9FxsPYKHXu4QmWst0YJ8yWrV=_wN352dCCBWw@mail.gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 10:57=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Tue, Sep 15, 2026 at 10:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapati=
s.com> wrote:
> >
> > The verifier tracks changes in how PTR_TO_PACKET registers'
> > bounds are modified across subprog boundaries. PTR_TO_PACKET
> > registers are actually passed as PTR_TO_MEM, which is assumed
> > valid for the entire call. This is not the case with packet memory,
> > where a pskb_* call may invalidate its memory region.
> >
> > Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> > may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKET
> > because we would also need to somehow pass the PTR_TO_PACKET_META
> > or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representing
> > the pointer in the subprog as PTR_TO_MEM, only permit it if the
> > subprog is guaranteed not to mutate the packet.
>
> CC Mahe.
>
> Hi Emil,
>
> There is a related but separate issue [1] addressed by 8fe994c80af2
> (=E2=80=9Cbpf: Consolidate function call pkt_access validation=E2=80=9D).=
 I think a
> long-term solution could be supporting ARG_PTR_TO_PACKET for global
> subprograms. For example:
>
> int parse_something(struct __sk_buff *skb, __u16 off,
>                     char *data_start __arg_packet, ...);
>
> The verifier could require a real PTR_TO_PACKET at the call site and
> verify the global subprogram with a real PTR_TO_PACKET, rather than
> converting it to PTR_TO_MEM. This would preserve packet access rules,
> allow reads from cgroup_skb programs while rejecting writes in the
> callee, and automatically invalidate the argument after calls such as
> bpf_skb_pull_data().
>
> [1] https://lore.kernel.org/bpf/aqkhifLvyAhw66jg@gmail.com/#t

Forgot to add that I think we should still have the short term fix.

>
> >
> > Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> > Reported-by: Nicholas Carlini <nicholas@carlini.com>
> > Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  kernel/bpf/verifier.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6c6b8d852..507bc14b4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bpf=
_verifier_env *env, int subprog,
> >                         if (check_mem_reg(env, reg, argno, arg->mem_siz=
e, BPF_READ | BPF_WRITE, NULL,
> >                                           NULL))
> >                                 return -EINVAL;
> > +                       /*
> > +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, prev=
enting
> > +                        * us from adjusting bounds tracking info.
> > +                        */
> > +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dynp=
tr_slice_pkt(reg)) &&
> > +                           sub->changes_pkt_data) {
> > +                               bpf_log(log, "%s is a packet pointer, b=
ut func#%d may change packet data\n",
> > +                                               reg_arg_name(env, argno=
), subprog);
> > +                               return -EINVAL;
> > +                       }
> >                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
> >                             (type_may_be_null(reg->type) || bpf_registe=
r_is_null(reg))) {
> >                                 bpf_log(log, "%s is expected to be non-=
NULL\n",
> > --
> > 2.54.0
> >
> >
