Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921B4192F9
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586822; cv=pass; b=sdQ34j3EsN56IgMlQXVhcOmtiR8w2yzfPvJJsWD8UL3vInjHebfB9DD9o1Brlo8qsn/BIjflQABhhaz1yR81SYyBLsLKLFF6YhCu/rA/tywefQDjkjZadSrOEbsJx3/lpv6lK7nZZWRFh091IzbjTPT4QDF/bDKVexyXd8kPEPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586822; c=relaxed/simple;
	bh=OuBImfA2VtpjROUE4x9h29QyIc/c9CdbVEUrPXOnFn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzkcXUXDGEOf3F03p08HBeLv7t8TiKTY+SUzgW2g8GFQSueh3VhdCVoZl5cT9gSWlssEtpQ7QEEBI654+iE3Ym3ywzlWA5sFuhaQhSuGqxSDvZz5Bxt6nCi6rk6Bk5vsWtVN0rjiNETlTY5lhnxLWzZzjzLPfNTirtCFLSBzEwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L43aTNMG; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L43aTNMG"
Received: by mail-oi2-f13.google.com with SMTP id 46e09a7af769-804f7045f3eso20254a34.2
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789586814; cv=none;
        d=google.com; s=arc-20260327;
        b=rFWwfX38hdPJVBzWLcN0wLYAF7+7SYjzSMit76Mv4Wr29IIoYYgyig2PjfUuLOmoNx
         X5m4Ehf273qNQJbd3eN29PIyxFs/up8hzMVUw1Hq7ZA+WLfnSGmdKIMainBsk7lf4FYN
         VhHv/bRmsrVtqk4cewI0KbjtGsniw6Jkp8p4RKaP6XSx7GArMwXExR5HRpibqzfDRsqv
         fv348umg/LjrbrqiTgMneltlUF9UZT1SS6SJQMQSjRCvMWTB0UqI2yK61PzeNGOrblfN
         laCsv+4zAVoqEa+cX+qJC4I9nNuFbisgSpjTfEZFE6O1LMugOR/0NIwHANIdAGzVIc5a
         EeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqRw9HltWqM2sAD6nJCLGSalO5mjXMLxRfeaddbbUlA=;
        fh=gTMnKQOEjPifQ76zkpnUAsa464a59Rp5jluFZ9Fx5Gg=;
        b=emZMKEIp+9XGoZ3JJTzE4tGsd/0JhDgW75PTMQIb8P+9FGJ73Rum6zBOqkc99tYI35
         cXgrwmwltGQbzEhnhMV5D5WKx5f/x09xEuD/NtPP8lHsjOoneII0nijsvMZVkD+3uC9A
         urnekU8Dkamf9OAezNJMDPipJ/GGahA16jdsZAKNhIbex0DymiIxBZUMyO9ec0vx0vDp
         quLmMcc4ro6LbZgPyOt49wyrWgLfwXbBK+i95Oi2MG0RkIqXRn3fT6CF58m81BbdEsO9
         +u2OV2NmWajHGbd59ZBo9qj9AN9gAwHd4Zhrz0eRJvCT4BTlWmeNjNX2nfl4xRCdmf/z
         tYIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586814; x=1790191614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqRw9HltWqM2sAD6nJCLGSalO5mjXMLxRfeaddbbUlA=;
        b=L43aTNMGj0WsEFPWzjUtSxP8gV5PBz69FGK97PqP81FFSg2XNjHgT4Nw1yMIeaJUlp
         8cwX9nNrP/BZjYCF9PsY1MgeXFH1LqBRG6UXcV+Ixms2eY1BnGiEPTzMh+LVUJv/PTc4
         K/Kc4PxU4GHEoZ1VLBDjYIE1csuBS/zRz/rLseR2Bbgk3bVYCZhNBJiXQ5EBDAt8uMAY
         NsSTO+0bTMs6lEoRrih1gLCuV3nUfYDuCPX41P1lSzZ7izuxrlwMRNbxqL/coKLf+mUF
         k7l0bWFv5zhCtiNyvBByq1hB/vsXaQwJs5AR2JZROLF/CR2CnU+YUTG3W0rgh3bEL7hj
         XKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586814; x=1790191614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqRw9HltWqM2sAD6nJCLGSalO5mjXMLxRfeaddbbUlA=;
        b=U2dExqSBwPEdMDRVdORUcXFuvrVWiavnzQfMvxXWC4VC30yUlNTu1N8/MZNEIYcaLi
         9d4FSPCyc95ASSANduisq1qAIqB21B5mkmez0iKPiu91WY4nJ2N5LYCpS5c0q1/p2wOT
         TzPE6d0JSGraArJvZqjqyP1jHyUqwdZw2RnVcM+6VHla911PMfirFxn5UQoJXxAO1Kls
         RyGn80M3dJwp0yHZF6slqW5qlBqhIFulpxtoFE5AZlZv+zLzSKSGWRgLPtbqtGkuKKJB
         2aBXHMxUi9uINOmcylutWGugHmFo2DLmRj/Nvp3dPy3ZU0rAdtx6TSN7dt4DygwQTv7U
         05UQ==
X-Gm-Message-State: AFuF++m0jx3OPAx/lSz1S/W4ioMx58NLOSHJYHB1afYTvUetL4jKOxCQ
	nbwIP4EsQSshnR3zE73BhJh64g0rAwe5TxsvTvBR1gHm5sos0boOPhWn9zDeprjC9lrhxFmcJKh
	S+auNV2UApKkvXdmneQ1B4Z9fgQWyJJo=
X-Gm-Gg: AYBFou3U6zM9jnihP/Sy57AG2u7KQkMZNrgyAI4hWr1/OiJj5Zumpie4DxlTJMllDSS
	UfktsGt06jr91FJyiKm6dwMIraWx86J9jXsoBdAE5R6gTU3ZA2eD+plU7n42d4MX7kx5kBWbzuQ
	/eCfACk2eUebOp+A7kclLjGslycQ3D8g9JDWPvFznRUaBF/dbsG9YV28XTeFQTS3VqymWnaygT7
	D7fB8woaytOmZqCFNBjckdqZMfYmSNNqpTEHkT0v6Ig8AB75GQPqEffHKLTUKTCEu5J8JS4byMU
	dkaleFqKuSz9LvRoc819byTP8KnZKjR1bXlFGDtl814uRM9EusIzc3w=
X-Received: by 2002:a05:6808:238b:b0:4b9:e5fa:8a19 with SMTP id
 5614622812f47-4ca4c17d6e7mr4445335b6e.30.1789586814265; Wed, 16 Sep 2026
 12:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916050830.8774-1-emil@etsalapatis.com> <20260916050830.8774-6-emil@etsalapatis.com>
 <CAMB2axOAut_9utesiV9mG40bskrDscu+Gu9FUMNRKZC+hbd8UQ@mail.gmail.com> <DLGYLT5UIFDA.38RG9UBZNYI58@etsalapatis.com>
In-Reply-To: <DLGYLT5UIFDA.38RG9UBZNYI58@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 12:26:43 -0700
X-Gm-Features: AcwNN1V67fVu0jyiCVA6Tar7WC_uaAL4bPriMPLTUZNtE3MtDtEKZZbaOWcawGg
Message-ID: <CAMB2axNHEidSAzh5gG3UJHeqzK4VZ_Rsy+wvFt6N-q-qBsm+5A@mail.gmail.com>
Subject: Re: [PATCH bpf 05/11] bpf: Reject pkt arguments in mutating subprogs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org, 
	Nicholas Carlini <nicholas@carlini.com>, Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:41=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> On Wed Sep 16, 2026 at 5:57 AM UTC, Amery Hung wrote:
> > On Tue, Sep 15, 2026 at 10:10=E2=80=AFPM Emil Tsalapatis <emil@etsalapa=
tis.com> wrote:
> >>
> >> The verifier tracks changes in how PTR_TO_PACKET registers'
> >> bounds are modified across subprog boundaries. PTR_TO_PACKET
> >> registers are actually passed as PTR_TO_MEM, which is assumed
> >> valid for the entire call. This is not the case with packet memory,
> >> where a pskb_* call may invalidate its memory region.
> >>
> >> Reject BPF code that passes PTR_TO_PACKET pointers to subprogs that
> >> may mutate a packet. We cannot pass the pointer as a true PTR_TO_PACKE=
T
> >> because we would also need to somehow pass the PTR_TO_PACKET_META
> >> or PTR_TO_PACKET_END to the subprog. Since we cannot avoid representin=
g
> >> the pointer in the subprog as PTR_TO_MEM, only permit it if the
> >> subprog is guaranteed not to mutate the packet.
> >
> > CC Mahe.
> >
> > Hi Emil,
> >
> > There is a related but separate issue [1] addressed by 8fe994c80af2
> > (=E2=80=9Cbpf: Consolidate function call pkt_access validation=E2=80=9D=
). I think a
> > long-term solution could be supporting ARG_PTR_TO_PACKET for global
> > subprograms. For example:
> >
> > int parse_something(struct __sk_buff *skb, __u16 off,
> >                     char *data_start __arg_packet, ...);
> >
> > The verifier could require a real PTR_TO_PACKET at the call site and
> > verify the global subprogram with a real PTR_TO_PACKET, rather than
> > converting it to PTR_TO_MEM. This would preserve packet access rules,
> > allow reads from cgroup_skb programs while rejecting writes in the
> > callee, and automatically invalidate the argument after calls such as
> > bpf_skb_pull_data().
> >
>
> Hi Amery,
>
>     that makes sense to me, especially since this is a feature expected
> by existing programs. The main issue I see is that since we want to be ab=
le
> to pass it with subprogs we need to find a way to annotate its current si=
ze
> (maybe passing it as a __sz that is checked by the verifier to be <=3D th=
e
> range - off of the pointer in the caller?)

Yes. Supporting mem+size for global subprog similar to kfunc is
another direction, but ARG_PTR_TO_PACKET is simipler considering there
are other complication with packet (e.g., pkt ptr invalidation). With
ARG_PTR_TO_PACKET, the global subprog can be verified with a symbolic
packet pointer and establish its range through the usual data_end
checks.

>
> > [1] https://lore.kernel.org/bpf/aqkhifLvyAhw66jg@gmail.com/#t
> >
> >>
> >> Fixes: 80f281664f5a ("bpf: Support pointers in global func args")
> >> Reported-by: Nicholas Carlini <nicholas@carlini.com>
> >> Suggested-by: Nicholas Carlini <nicholas@carlini.com>
> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> >> ---
> >>  kernel/bpf/verifier.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 6c6b8d852..507bc14b4 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -10375,6 +10375,16 @@ static int btf_check_func_arg_match(struct bp=
f_verifier_env *env, int subprog,
> >>                         if (check_mem_reg(env, reg, argno, arg->mem_si=
ze, BPF_READ | BPF_WRITE, NULL,
> >>                                           NULL))
> >>                                 return -EINVAL;
> >> +                       /*
> >> +                        * PTR_TO_PACKET get passed as PTR_TO_MEM, pre=
venting
> >> +                        * us from adjusting bounds tracking info.
> >> +                        */
> >> +                       if ((reg_is_pkt_pointer_any(reg) || reg_is_dyn=
ptr_slice_pkt(reg)) &&
> >> +                           sub->changes_pkt_data) {
> >> +                               bpf_log(log, "%s is a packet pointer, =
but func#%d may change packet data\n",
> >> +                                               reg_arg_name(env, argn=
o), subprog);
> >> +                               return -EINVAL;
> >> +                       }
> >>                         if (!(arg->arg_type & PTR_MAYBE_NULL) &&
> >>                             (type_may_be_null(reg->type) || bpf_regist=
er_is_null(reg))) {
> >>                                 bpf_log(log, "%s is expected to be non=
-NULL\n",
> >> --
> >> 2.54.0
> >>
> >>
>
