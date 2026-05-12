Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575112DFA25
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621485; cv=pass; b=KqDxk1erLL6HGJHrcjK0xYQu8XGGjYbFc7WeNTUrhUzh0mZu2A0UEJIsJKQI4F1X9MQ5ru5/aO/PIFbHQW+7M0MAiCNvqzJtk+Rx4jw92K+RxTzna1y/Lapnow/lGuLAexryvNrYYIZjDiFD1mIWM8Qu+ya3PojXF273opo4Cq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621485; c=relaxed/simple;
	bh=PkC5s/4Uy0m2CN2hO3KoNCLTqq0UuYmaEjzo9fWkdZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crDWQWX5y1helBN0HPmniS0DdtKkIChJlWykqxSkhqF9hkPqedbWjqzsZmFJM8vHxq50VbN7AmAvkkdgY27prKXupeykcz0aWWzGoCiBjizOldCs+XTJeGnrH/4CC2Z62v+lbaG2ezPDbO3Jq5TZNVB4hL2qaP6mGReDZU9S3CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggN3G67r; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggN3G67r"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bf0b47d2f1so58170497b3.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778621482; cv=none;
        d=google.com; s=arc-20240605;
        b=D2d3tn6+RtAbUa06AoY35quNQwzNINa2F/ijHH5Ql4naWj+xrKM4iSJ4cYvTLgHRRL
         qQf6pVUP7JiKUkDAstdaNFZlsO3kJok2qaEuvs4koy/rfbLGlqgR+hP+lxy6hnMPBAt5
         UuXssvIgqd/tAwYlm3u34nP4QNrdYDANDfjDI3nktH3bDsHjedYVcE/TcfRUHAaaOMEO
         2wuJahRwvLsjP8+Gt1UG/ZpjNNM4HbEKbbqNL+hiITURJzj/es042j5IpEicvamS93lc
         Ily/qMGCeoe4BpvSNe0R1hrt40UinFgKsVdnwt3MbH/ih9/krDxLfUAZkDEM++laVM5r
         xzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7W6y2t+nJOe9TUUMwUkhxdnxRPcdVhvGuxKswbifoKM=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=dKWUnV3jr7vepHjJZAJ/ALqPbzUI0IdtlpnrZWteYkOvITcq8X541Uk1hhN7c/fcnx
         40TP2l0Mk+vvyn5jhnX5M6S9hnXwhPxoJt/UgYNqmCdkasAtRV4NSlYW5hyue68R9F0X
         wbvJznpKcNam5AxH9lQYvnCylFFU1HnlOkB3RZfeP8jbrQoG7ayJ9BNbUH8h2Lwo5YCF
         DGEzBbVb5qA9ZSDzJzwG0Nqi1wHukOTp8eKSRKHjcb/aofEEB9rpLSChkuedsb34oQwt
         hq/49AQSrWbXZN7rqo8UrGFt1HdpKw6BWj9QlK888yVcIscKBuSZqpv2QdUTw+s+Vqn/
         FThQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621482; x=1779226282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W6y2t+nJOe9TUUMwUkhxdnxRPcdVhvGuxKswbifoKM=;
        b=ggN3G67rWqVlp5MMgZoOlp+RR467rJEeDqWMIg4duWAlSoD0l8HB5D7A/hmnSNV30S
         oEvYtAGgYbdPhJh5oEP95It8BlNRuptO/+ry/5x1sdIicwG/8ZxSfVXEG1wpr+H9NUUh
         s6NnUqoti0MfCG/1CLVJYHu4n5etI2T+NwXO1naJc+IPSAQyJCXtVTrGvCJuwGM4FT3W
         d9aCMit7z966MLIBv5XvZd3oIUHUWxts1t0CBcAWo2tw4vCgAvfMRXo1DQFqzbhQfp0D
         ZjNsuDn+KqpVF2mf9mBSKK8LaY5lCONdYP1zIuor8wCNftPTP08vmXTDVOeQ5XPap4cC
         dugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621482; x=1779226282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7W6y2t+nJOe9TUUMwUkhxdnxRPcdVhvGuxKswbifoKM=;
        b=N8l2yf3iM4V5SHpREnFNO3CpqRNsOHn9v/LDOTKCniDWgutpdODnewSaa0Y/O2UWbi
         8OZPgVw1OO+ZSSERjvQvBTJWWIw0fW3BmvRsSO/6mRpD4Q1R2HXWERA52ZEMA8k8Nt8q
         Y3NHxrIp1HYVX4IAIWJgI/p5U9cpN2wu4Fj7zVclmcaSomyVCzcWFMALWdpLuNL1WA8T
         0+2IlqinvZftEKtJJUoIdsC8hbeoLCAYS2Cgq3UHBdxbGdcwlBTNUwRMtOTMembOyQ2E
         sJjKsvMQnzJlRrybXu4+Qrltp6+WipZXupqjxUlKazLG7dBlatYYVKPg1CdtFO59ZUya
         DAkw==
X-Gm-Message-State: AOJu0YyaMWddi7v8HQ+jN2t9IEqREobAfGpaTV2+PF2XWEKShm7LrEnq
	Hv2TheUxaCdLGJfR2oHKQIfsSSvwiz4tDRu+1fayaG3YJ016a9nFWh8+DvCmd0TpMpufLdJEoG/
	xlrgLLnFltOPioWLk59qrnBPx9tvzIBM=
X-Gm-Gg: Acq92OFXpLtuDwYsWjvz/vUYYBsxKWdUjAE9FUpX75cf+mjjELhfv3bVD1vTrqbbjlN
	KkXVqLY0eDG4nj6fnfpG/oxjmtUFmMVjCJGYZM7ANg4oypei2KpZNJ66uopXLwGoMG3Hay4iGoX
	7pKQ0zsxXQrXwk/hmwkfVyt5pIpTj+Py6THx71Jaunf2oY2lsWAuG6RYMthw0X9EYKqj03SmgS5
	YgekHZb75EM7EiYM0wcnnyHS/nQryB+45l4jR26N6TNZt4roLx+UP0SIEmehhKk5PMOTgaIOREY
	HOgBw7nRb5pgVlttdq7VYBc=
X-Received: by 2002:a05:690c:9e:b0:7ba:ef98:9712 with SMTP id
 00721157ae682-7c6a9b31e3bmr6451997b3.11.1778621482311; Tue, 12 May 2026
 14:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-8-ameryhung@gmail.com>
 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
 <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
 <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com> <073fd24d1220adccec5248b094f4f80fd5e66f93.camel@gmail.com>
In-Reply-To: <073fd24d1220adccec5248b094f4f80fd5e66f93.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 23:31:09 +0200
X-Gm-Features: AVHnY4L9IEgzBtCBDye1dKv4hRa9WilvXqRGKK6a36Cij0o4gsGIpgpGL2yqSGQ
Message-ID: <CAMB2axMSBOxpUkSPr9JtD2KT4FVvwKho-G8HKJp0DP+WEK0aEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-05-12 at 23:27 +0200, Amery Hung wrote:
> > On Tue, May 12, 2026 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> > > > On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> > > > >
> > > > > LGTM, a nit below.
> > > > >
> > > > > [...]
> > > > >
> > > > > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_ve=
rifier_env *env, u32 arg,
> > > > > >       }
> > > > > >
> > > > > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_=
XCHG_DEST) {
> > > > > > -             if (meta->ref_obj_id) {
> > > > > > -                     verbose(env, "more than one arg with ref_=
obj_id R%d %u %u",
> > > > > > -                             regno, reg->ref_obj_id,
> > > > > > -                             meta->ref_obj_id);
> > > > > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > > > > +                     verbose(env, "more than one arg with ref_=
obj_id %s %u %u",
> > > > > > +                             reg_arg_name(env, argno), reg->re=
f_obj_id,
> > > > > > +                             meta->ref_obj.ref_obj_id);
> > > > >
> > > > > I think this should be reported from update_ref_obj() itself,
> > > > > it is more consistent logically and also avoids reporting code
> > > > > duplication in check_kfunc_args() and check_kfunc_call().
> > > > > Also, technically the reg_arg_name() is an independent fix.
> > > >
> > > > We have kfuncs that have more than one ref_obj. This is not a probl=
em
> > > > unless ref_obj is referenced in the verification and is ambiguous
> > > > (e.g., used it to tie the lifetime of the allocated memory with
> > > > ref_obj). Therefore, it is kept at the location of use instead of
> > > > update_ref_obj() to prevent breaking existing kfuncs.
> > >
> > > Ack, thank you for explaining.
> > >
> > > > >
> > > > > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftest=
s/bpf: Negative
> > > > > > test case for ref_obj_id in args=E2=80=9D) since the verifier n=
o longer
> > > > > > complains about ambiguous ref_obj if it is not used.
> > > > >
> > > > > On the other hand, if you think that this property is worth havin=
g,
> > > > > then maybe wrap the check with in some utility function?
> > > >
> > > > A utility function like below makes sense if we fold ref_obj_id int=
o
> > > > id. It would be too cumbersome for v3 as we may need two of this fo=
r
> > > > ref_obj->ref_obj_id and ref_obj->id.
> > > >
> > > > static int get_ref_obj_id()
> > > > {
> > > >         if (ref_obj->cnt > 1) {
> > > >                 verifier_bug(env, "function expects only one
> > > > referenced object but got %d\n", ref_obj->cnt);
> > > >                 return -EFAULT;
> > > >         }
> > > >         return ref_obj->id;
> > > > }
> > >
> > > Maybe just like this:
> > >
> > >   static void validate_ref_obj(struct ref_obj_desc *d) { ... }
> > >
> >
> > Do you mean:
> > static int validate_ref_obj(struct ref_obj_desc *d) { ... }
> >
> > Then to use it:
> > err =3D validate_ref_obj(meta.ref_obj);
> > if (err)
> >         return err;
> >
> > regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;
> >
> > > ?
>
> Yes, like that, sorry.

Np. Thanks for the suggestion. I will add the utility function.
