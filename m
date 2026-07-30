Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2753E49D5
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451952; cv=pass; b=Qs215oK0cBqlPWS4ZC72/9lQsCCGxs+0fJjiL95yhCpTO+FbCjl2pcBZL8QKh1Iw6MnVmU++RTRVQ0OjE/PqDKPjPSvCEFwuyGQuBeF48axCmmPn3tgE3W7kGY1sWq0OEE0JwlfjOu+aJbgwKiNsHCXbixTeN0rjmtxBrZ9P5sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451952; c=relaxed/simple;
	bh=xakOe7onQvx4wiZDCNi7JSD0SnMEIMMivTi6oZqsI8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWTZ4CpglbDEjASTZNswxCKtzBN4TXseg0g9hLABF81N2j1IwmliIKL2rcmaJKHSeMONu7f8yPxevDti+Boa2H15he0v0Az2h97VsB9QvGq5nW1Twv4SXlTlG0lm7yfrSXt+YY41x2XhvApvjs36KhzWsGkR74x4yRXNiUjBLPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO5vg3+T; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO5vg3+T"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso172170b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 15:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785451951; cv=none;
        d=google.com; s=arc-20260327;
        b=dt+1Sq9NtGmiAe1AOJlkB1gCwxD+uyyKfusN82JxmMb8IuZUiuX46ixn5Yz7edQIPR
         b3WMdjOIQZ5xKF2rlrwDYgCm4NvYCs/+B/ZzPE0cKEavjFvafct+bZGVoiGT8jHdNBg3
         z3AyhX+2GtAzHhdtZIY5uGdaU9GHNJyseFv6CKhoZRRKXH16XEyM4DY5ow6jE9lGHw08
         N8LFz0vMf29j9Nc5WZRhWHymIxoVrMclfIj1HfDE3HDVG5/9LRCkodNmoU/lB8Bi2wUc
         nt1fucv9HPu4wL5PnTZ2L8Hc9aJ9CQDwI6KUUuQYBlaRTm0C8K48AzD8kGegHkuZjtW/
         GXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kK5U4QwGT9O9VQ+w4BY9Dom3H1xqRqoq0z8HNkQ4nwk=;
        fh=TmFTo7DVi7fmnwpD4VsHCbHZP61LxF2EIi5KSUngQps=;
        b=sBp/STEf+xfavbjbjckjngUm3Zt/Bqis+fB0lbIlgBYNKtmNIXjRkv6UQmuPkR0VUC
         5yu0dho9FeGrD1/LwsO/0jXwk5ljsPa6an5MAXYbiTVIIPbY962We21ms0zdkUiqtHDF
         AO0LdXWC4EuWkOF5sKNyEyzey7OEzNs5DEClCxtSXOS1b/E1x8KnMBhydCNFhiQhflAS
         9S3wOgs/9BJRN0P5L+D98CHZwDCFJPLJGgIVBFtr/w0AUw3wYWZfkhDqusRUO1/EJsWc
         Ecrth/A1Lsa+YOJmmVYFk9f5+mJtiDZLjHVuki1mgyF3EkUlux52iouyW3iR6Px2XqvF
         AcEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785451951; x=1786056751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kK5U4QwGT9O9VQ+w4BY9Dom3H1xqRqoq0z8HNkQ4nwk=;
        b=FO5vg3+TyGAVZMr43F51pzQdtfCSiJs/TIRpBFM6nJPe0jwHqNY0Mc9mt6t+GvPAXG
         aV86+NRYvPrFtotONJS5wxcCiaVaOrNBLq6yQt7UoS2xLF8Irr8cF7C49+FdcZH6Xp5o
         5CV/wCPENc5tr87+OD390TmxT2XeHdRynPhjKRVhT47L7DeOHBqYCaVYdu0+uZwDeNOh
         s9NCIL1LZLskAN0kxhh+PCRu5wJgpsM6DdKoNPU0P/nZM1l7KjIMso1ZpcL8C2xuSK/r
         jdeezhAi3ltYfzjLYdb1MEyKN91ZH9nHfxeZv5O8PXXEE9xWrDRODxMzZsq94Hi1oHMn
         8K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785451951; x=1786056751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kK5U4QwGT9O9VQ+w4BY9Dom3H1xqRqoq0z8HNkQ4nwk=;
        b=lbc7HjkIuhxeCUA4KhOsGSVpVHE2mPmMvA1tPuMA4elTBSJ9Fm0L6opcGK9QvpMeQP
         vDO+kYst+Gc74sZkpjB5y91ZfQDNJ5XFC/Np4mcoJGwWSu3WrCsSD/nu6Y4JHpADKyMk
         OSB/K1rch41+o+LjvmGQaJAg6KowxJROOsgxiF+hmu4bnGJfVr7jSdTBM+tIHA1NekOA
         6grCY2rz8B8fUonsiiWgrWIPl+J68GfGXknrHL/42/wi+exKxwhSQ1ESjQmqxPXz291z
         +aPuLwABRm5VTcH0TmNoFHVbhbwQnLgTSZgcrvHxCHppadStTqx4OLpESDJPBZbH6kAb
         48qw==
X-Forwarded-Encrypted: i=1; AHgh+RoMbZEehoWm4U8YTNcKLqlBRVCDdc7dksaZKFPvKjQVsBkIEKrjZrBw8mm8Bet9UK8SCpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJAX/k4A5PBxQVJEnxCZ7lXrGvgt0pvFLcQcUGXy7g8+VxRk+
	hEr49zm4dNqvBzcfW0BmOKCkc2sU0u0L07gehhKKyTiZcC7j5qUn+T11fwNmbpx9nifWw1MXam9
	6MuYdnp1Q9GmJnTIWwNaGyVAzdnFcL8U=
X-Gm-Gg: AR+sD12rrsgzAxtUtr3bqPHe9cfxINMgLSvxq4+oIBzKyPHHBESuW/YBMMPlB3OaP98
	CKwDERO9bJUxLcIuzQAqbQnBxBEmPStdQ2z5vpTJBBD3C4GMxooETqpKLr/4LTEzcdxpV1WeSYJ
	uihEVpv0VLmKihyumIM2ugr8qHgSO0R5ZHeOBzZj/sbxaiu5pxzqZsEPvXFYapCXgksqQ+HA3we
	a6N1i8G83AhOewMp7PzBH1jEBQnEG/qxMETlkfbPR5o0MpmjgZ2UQZ5OluZkzkHiT5mu0Md3T3h
	AE9JROXnPqNF+HRRUpTd1GmdwqVjUnrZtwECYnRPkDUeP8XjNPJSidKyt9EgjVXXZXlEFDpabHC
	OWgd7V49RcpsZvC/fArMYccEvlW0HXFPib41rwCU+DBjluFZG8YHE
X-Received: by 2002:a05:6a00:ad2:b0:847:8d0e:5d83 with SMTP id
 d2e1a72fcca58-84eca755e6bmr1544377b3a.26.1785451950568; Thu, 30 Jul 2026
 15:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-6-jolsa@kernel.org>
 <78c72a5b-0db5-47da-8b35-e6a2e6976d7c@linux.dev> <ams3yHvqyXrWAbBV@krava> <6a20bbdd-2557-4db8-8839-e2f53857ced9@linux.dev>
In-Reply-To: <6a20bbdd-2557-4db8-8839-e2f53857ced9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 15:52:14 -0700
X-Gm-Features: AUfX_myM53Q2L3UJ-nKNITC_joYJHuC0YcFLOr-SZmQSfciKfcDnBLGJiXibq7g
Message-ID: <CAEf4Bzbe1tETVtVMxkaURSoW1PmVfWnR9Kd9iwaPskzCwij7rA@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in bpf_get_stackid
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, 
	Tao Chen <chen.dylane@linux.dev>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	STAR Labs SG <info@starlabs.sg>, Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 2026/7/30 19:38, Jiri Olsa wrote:
> > On Wed, Jul 29, 2026 at 06:30:26PM +0800, Leon Hwang wrote:
> >> On 29/7/26 16:38, Jiri Olsa wrote:
> >>> The get_perf_callchain call needs disabled preemption plus we need
> >>> it disabled as long as we access its returned trace entries buffer.
> >>>
> >>> Note the bpf_get_stackid_pe function is executed already with
> >>> preemption disabled.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
> >>> Reported-by: Tao Chen <chen.dylane@linux.dev>
> >>> Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dyl=
ane@linux.dev/
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>> ---
> >>>  kernel/bpf/stackmap.c | 19 +++++++++++++------
> >>>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> >>> index 43b1e5436047..e48ddb4edd47 100644
> >>> --- a/kernel/bpf/stackmap.c
> >>> +++ b/kernel/bpf/stackmap.c
> >>> @@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, r=
egs, struct bpf_map *, map,
> >>>     struct perf_callchain_entry *trace;
> >>>     struct stackid stackid;
> >>>     bool kernel =3D !user;
> >>> +   int err =3D -EFAULT;
> >>>     u32 max_depth;
> >>> -   int err;
> >>>
> >>>     if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
> >>>                            BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
> >>>             return -EINVAL;
> >>>
> >>>     max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
> >>> +
> >>> +   preempt_disable();
> >>
> >> Better to use the guard-style guard(preempt)() in this series.
> >
> > we prefer to call stackid_install with preemption enabled
>
>
> Understand.
>
> I wonder if we could avoid the "goto out".
>
> scoped_guard(preempt) { ... } might work here.

+1, came here to say the same, I think it should be

scoped_guard(preempt) {
   ... do all the things with direct return ...
}

/* we got new bucket here */

return stackid_install(...);

>
> But "goto out" is fine with me as well.
>
> Thanks,
> Leon
>
> >
> > jirka
> >
> >>
> >> Thanks,
> >> Leon
> >>
> >>>     trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> >>>                                false, false, 0);
> >>>
> >>>     if (unlikely(!trace))
> >>>             /* couldn't fetch the stack trace */
> >>> -           return -EFAULT;
> >>> +           goto out;
> >>>
> >>>     err =3D stackid_fastpath(&stackid, map, trace, flags);
> >>>     if (err !=3D -ENOENT)
> >>> -           return err;
> >>> +           goto out;
> >>>
> >>>     new_bucket =3D stackid_new_bucket(&stackid, map);
> >>> -   if (!new_bucket)
> >>> -           return -ENOMEM;
> >>> +   if (new_bucket) {
> >>> +           preempt_enable();
> >>> +           return stackid_install(&stackid, map, new_bucket, flags);
> >>> +   }
> >>> +   err =3D -ENOMEM;
> >>>
> >>> -   return stackid_install(&stackid, map, new_bucket, flags);
> >>> +out:
> >>> +   preempt_enable();
> >>> +   return err;
> >>>  }
> >>>
> >>>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> >>
>
