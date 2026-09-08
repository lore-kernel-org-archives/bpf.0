Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8411AC44D
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883254; cv=pass; b=Fs5joAd9lYi/zTwcsdR+ppuMHS7t2zCTWEDTl9WjNjyyjYo8Z79x7LxqzFeuhYCk9qEbAE+rsEmdgRkie0vmbkSLHpeb15gds71frDSpCAC6qRIuY0lGQ+HM7n8fGS/l3LeA7Da4+JW8fGAOgdnGOamd7rtwt4sRNSo4/iZeBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883254; c=relaxed/simple;
	bh=JvpGORMbN0f3B0RLWaA7oEm9RnNQKxZ8y3nKuSFivAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVPz5XKJRAeUtTVNOHWduoB7ElQSw8mpoPJP2J5SWmNOtGsoOi0oq8vMHXwxEXaOCYkRznGBeP/r32hl0iEnSgiEoGl+6VfkoN5PkCmr/zZfiJa49CGCpARhi2LyAIrRgivb5kf8KR5DuhbGN8F09g8ioYSLS8olgorXI/+h8og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vZOhEZ8+; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vZOhEZ8+"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4e39e3d8so6884857b3.0
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 09:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883251; cv=none;
        d=google.com; s=arc-20260327;
        b=B/+qoQWvQZxr+uqXAmil1+MYJ10HV+SHwtMJAyLmA21T6QoAe+fJlA7npnIMgL0KOg
         h1Ptw+1J60lCZJmj+S3M8WiJrF9GEGIH3wVFQtgB5WEumqJqNaX1aBe0AWbQuXVTkQFN
         g/Ateze82jNIb6JgAhpyKZCAxBMH3qfz3YbJSPKmGWniPepZc0ptlWTimiRW0pf45yXg
         hnfTfSojL5LndFccoCyubgvNRDUNYfsF+WTJlR9bvrpJoWnTgr4SI6jeLXD8W9cpRO/W
         4N3sTs4gV9vCv/qZWIZc6q8XYy9HCFc9KGJ94lmKTFPUF09Ht8Xjj0WnLTUspZNG4CT6
         tcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zLFcLibqgpv9VVaA1mPgIouxF6jt57E+rWme6slCmhY=;
        fh=oGseWDWQwTMcxS7490Ak5XTvNaq5Lih3BPmWJovRqOE=;
        b=pfsSzfZFs7dv4hjXwbIxfaHLMhlWNxZDynImy1ZLU62RAfsCy4Zlv+Er9pyIvkTxaZ
         P/uMZuQH0pZJXxIneft2YeSfZuhiLtnB9SKt1hkQGnZuoOVR1V6CeTZPVgTW6ar7uerr
         wdnusLTlk4AeLx5KvQQx2CtrKTJA4f2+JwGbDWUisrUGuxsRP62UVbvY27s2k5zP3RCL
         QJCW1wOO8LquPZ0ACFST9dsVvs35zfqrpVjjkJud1brbt9qlb6IW/cdu9eAjJAwbs3/q
         IJ9bWVpe58TdLj9enDNTdKaPwSWUToK+HYzi2FxX0D7J54l0E3iViSGe9dmIBiLF+nq9
         Vt5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788883251; x=1789488051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zLFcLibqgpv9VVaA1mPgIouxF6jt57E+rWme6slCmhY=;
        b=vZOhEZ8+UPsUYTdkRGYnGllympBUNzxLqElgR3TB2eHBw71vVOrqGJCbXF8YIKEKaZ
         Si5imTk0K2anAAiVmi6+sxAHX2Hyd0FwBYbw7y0msv6adFxpyq3ifAxFj3082s1A/ojo
         LJDeFyfk5ojnuQHc7U/PqVB+aDHoJjCvAfjNvtoDfKk8mbm0NpD2CDeAT8e4uO19bzNd
         KB3w0oGSL/0MjspmXRZEe3S7q/uHJUgZiQtiMo918TWP/BbWzPMTjoR5E6ezXFX38F2e
         Fi6NAufmdBm4hh+gVvd71hZrXmuSndXYb3s6b0qVC/G8Z7lavhzRf7CdD637qLG9h4Mh
         mw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883251; x=1789488051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLFcLibqgpv9VVaA1mPgIouxF6jt57E+rWme6slCmhY=;
        b=EUQebhYlU8DmMBl/6zNc4+3aw5vPNZ3+lksJxsqQ0IGqWh/aMPE8Qm0IrShpMzTZZ7
         QnzWWUwt+IlFXpGudXEzzNjDlxXFTD4x93geeqOLuUiMfm+qS2AFFZYZFavzn8WNhkeE
         5hN085YEr3eTddkJEYVSX7+5Z8zqkr7crhrYR4HvI4aJxld3CU8BO/vDrQpbQ9uChs2m
         y/c45k9EL0QZKQMoTKChXWTtGLtHB1DmWAPfCesMbLZznGxx37H4W2JF9Lspfinsm5s6
         UT2Y9bB08+y7PqpdBJ4YAsbFYFbbO0NKf9psXMw4cHrMxWKDLWqIdxWW76bPaSseDacA
         O7dw==
X-Forwarded-Encrypted: i=1; AKwUvBy1qJxu9bfeP6vjju8i9S6a5/yGJSMXTUOSnEbP1oBjfF0bgAAlDpwvdLUmD/TQmzfeVnE=@vger.kernel.org
X-Gm-Message-State: AFuF++myS/DxBjuoxbhQnDNmEpGTBVRHMzxYTs9KqsH5jI3Xc/MMf7Qz
	1Rfel0GgGrBm86qqW0lfcbZQp6EgFdDVz8YstEAli3ARVgyDDfSYf0Azeni57xFY3S+NzmNYoPV
	LpQSU7cIzd3bvFsXhwvExF3iUI5r5gwsDHYbPfTCYpOLJOwdmCkHoMqQ=
X-Gm-Gg: AYBFou1kz0Vp7v+x8DTBZfgFvgCmSfPsgtlG4YAA3bGDOpT/bKPur8+WiHcDOObUtCE
	ZMbr3B2fEpt8fh0sd9M6VJVXRk1+03bwSvflrsFGq2opWBAzMDy1Q6JIpO+y6UAKkk1rpaxNliy
	1mt05xhVZgPHGc7FN056DhxUZfmcrqPyAek/RXwEDBrFGafezO6xeFbIC6TKU64Sj9L1atmvO+C
	k2eODoCnJbBEab2iYv4eGj2YCXaH/FqVL2FIr4RILlwU4miPzY25PYgJRmJRdwk/j3Zj3LP70ec
	C0uEqOYLxYCXs+1Og2paoP8vrM7J+HPXZYR8VU2nbobj
X-Received: by 2002:a05:690c:6610:b0:81e:d001:e0ca with SMTP id
 00721157ae682-87c0cb08accmr20725467b3.17.1788883250501; Tue, 08 Sep 2026
 09:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902090220.16395-1-liujing@cmss.chinamobile.com> <286de7d2-3750-4a44-a8e8-7054c8cf51d9@linux.dev>
In-Reply-To: <286de7d2-3750-4a44-a8e8-7054c8cf51d9@linux.dev>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 8 Sep 2026 12:00:39 -0400
X-Gm-Features: AcwNN1XfVvWGsgSwn3ZqzKUvYXDqD4jVjYsyRGGjLTX1m5l-xdM6zw6YWnAE0_o
Message-ID: <CABFh=a5no3rKs-AzBNyTXUCP_DogzdA00_EMvB0y8ewERS6M+g@mail.gmail.com>
Subject: Re: [PATCH] bpf: cgroup: fix null-ptr-deref in __cgroup_bpf_attach
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Liu Jing <liujing@cmss.chinamobile.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+1, this patch implies the error is possible which afaict it isn't.

pw-bot: cr

On Wed, Sep 2, 2026 at 5:41=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> on 9/2/26 5:02 PM, Liu Jing wrote:
> > In __cgroup_bpf_attach(), the expression "prog ? : link->link.prog"
> > dereferences link before validating that link is non-NULL. If both
> > prog and link are NULL (a contract violation by the caller), this
> > causes a null pointer dereference.
>
>
> Both being NULL is unreachable, so the new check is dead code.
>
> It's meaningless.
>
>
> >
> > Add a safe ternary fallback and a NULL check for new_prog before
> > it is used further.
> >
> > Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> > ---
> >   kernel/bpf/cgroup.c | 4 +++-
> >   1 file changed, 3 insertion(+), 1 deletion(-)
> >
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -814,7 +814,7 @@
> >       struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] =
=3D {};
> >       struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYP=
E] =3D {};
> >       struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYP=
E] =3D {};
> > -     struct bpf_prog *new_prog =3D prog ? : link->link.prog;
> > +     struct bpf_prog *new_prog =3D prog ? : (link ? link->link.prog : =
NULL);
> >       enum cgroup_bpf_attach_type atype;
> >       u32 old_flags, old_pl_flags;
> >       struct bpf_prog_list *pl;
> > @@ -833,6 +833,8 @@
> >               return -EINVAL;
> >       if (!!replace_prog !=3D !!(flags & BPF_F_REPLACE))
> >               /* replace_prog implies BPF_F_REPLACE, and vice versa */
> > +             return -EINVAL;
> > +     if (!new_prog)
> >               return -EINVAL;
> >
> >       atype =3D bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_i=
d);
> >
> > --
> > 2.43.0
