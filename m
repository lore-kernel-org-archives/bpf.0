Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C21F3B87
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780196523; cv=none; b=r3rub7lwEqURk9janDa3JR2TETRJ+KYo04gUu7MEeAbEoQoZ0j3k+e8rkvtrdCI8hxeGR+ws72Z/34Eb25U3sBHKQqPJ199iMqUfTwOvyrECxHDODBjj+IVrP71gVuQvIhrJPauIvEHJRxLoHGswf6tCJzZf9R3BYxG6oTMaNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780196523; c=relaxed/simple;
	bh=8HesMmPopPHyjuGUTNIlvBrHXcvGi00fldCIKrCCSm0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e8dudE4K08tVc3pwaJ9k8L+IHaU0l8ljDFSlceFcYskK0PcrE6a85TmQ+15KctF+1D24JrBjvuWWosjAd1no7awcRe1VO4tXKiUIXzc/ec0VHicTGwYtWHqTHJ29zsr62FBktPTpA1xg6111CfevUciptT96ueQKF+FlG5lGoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmUv0WRR; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmUv0WRR"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6b5ff3fb8so209161a34.1
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 20:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780196521; x=1780801321; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsmd12pLGX+TS7ApQoI+Bb30bGj8oks7xKAyqCnXlUg=;
        b=MmUv0WRRFXQbT+ZVb4CXnSPX4iqvdXlZ9QkWuooIWZqgQUCgnVwKrMqtD4bQ0mTq0q
         wRH6FyonudSJqZlUfAHDshle8yyJyP1mk7AKMRFzeyR7axwGcWTtPcz1L2eDqY35vKdy
         u0VBB0zUjA4KZVykS0N3UXMVgThYa83pz5KU2YDQbZ9hBY2eonSAdpfunAmD83INPja4
         exC3JnXj8aOmW7b6rOi8RuV5fLItygxF+DMS1Sgfqu8wfnPW9+j5q76pGAkn0izswWLp
         GzsXSd0+0zUuw+B1i/BrFM86SLsI+Dz4xQxrUHR9b4FRaKrfzwaHzZutJyQJaVPGGy+c
         eCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780196521; x=1780801321;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsmd12pLGX+TS7ApQoI+Bb30bGj8oks7xKAyqCnXlUg=;
        b=Im0qVFtGZtr7CMkscjm5scgTbhI+gG4F+HvLU/hk/3wWRbmVbcmwgfZymCnXRonhJc
         iCRxGzATcNszTxdrKHpYySvoK87LTVBzBocurfeMH+2KXljhvuy8A7XM46rJoTw5dbIm
         yV5W0OXsWKLsTmdWtGTyyliy74boEAiGDIQalYCHDBOUJfKPyItqGRc7KcY29POcwwYN
         iwER8l4eSXus4Is0H9JOjHUckJpzdJ45Cel6RNDkb6qPbcZJKIhz+pOqyOsdJxze1U+6
         eoGPwGA8P3aM+G5ZRl/Yd7XnJrDYzDOfOy0cU+ClMZYisZFWERzM6NeutZQGezaG/Jmg
         aAnw==
X-Gm-Message-State: AOJu0Yy6gDw22is33UnQzggQIrb2RDp+IKMPrAQzUpbzHzSf0uZTgjZM
	8zArA8kSVsOAe5+HuI4gjcwedF53eXvNZk7XMWxJa/6fPsKdiegvSo0arIfQaQ==
X-Gm-Gg: Acq92OGdtbOfHiSRPlgeiDtvcd0NC8I4VQtObdJ5Wtinq+1nAUXdg7l+hzqXelksfk9
	C6r6dTID5O2ZM93bRRPg6j5FEfOLORVlXplg08kzWw78qpAYffVav8+oHWd0k8yQnSFGSTL/SLh
	/04LA0N/lxxZXMDQJVDhYj6pgCQ/aPyrKcs93jnFsqO7L66cLADXGYJcnX9NbKKUQ/LaRuUlOG7
	+Aa/+FfE6eBAFbW28IIBP5BikQYrn4nIOimIRCQIe7E0KGXsQVH33tkryqfCwg+1ch9WZHAn9Ps
	MmFBlKK8JSwaWw44zbcd9TbBCQkqc6hqL2OG+5aYzb/vUFyWODu6Dlyh/VVNuTiZXBijS3l81tM
	mPLZ7qDRdwDAHIEtSyLcYkRIBzPo5zLxvMQ0ofL5Eh6kd+higHIlm8OxeEJ7DLr/z9MXYm6YsQQ
	UJthfRpk0TGJKViTYyvbCXnM21rqIvQlMg9W6T5M4rJ1Qq33i8xF1gpcaTp6utmftm84qjGhSU8
	27FQH6mq2HV0/69Kvx+sihS3gXg
X-Received: by 2002:a05:6830:6d4e:b0:7d7:dcbb:280b with SMTP id 46e09a7af769-7e6a2e63d1emr2840299a34.1.1780196520963;
        Sat, 30 May 2026 20:02:00 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d17b1asm4778913a34.17.2026.05.30.20.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 20:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 20:01:57 -0700
Message-Id: <DIWIZY7U8VDW.Q0HWZ5FCLRLE@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject BPF_PROG_QUERY with short
 uattr size
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Yuyang Huang"
 <yuyanghuang@google.com>
X-Mailer: aerc
References: <20260531004748.3567875-2-yuyanghuang@google.com>
 <20260531005931.D4F201F00893@smtp.kernel.org>
In-Reply-To: <20260531005931.D4F201F00893@smtp.kernel.org>

On Sat May 30, 2026 at 5:59 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] The patch unconditionally rejects BPF_PROG_QUERY requests wi=
th a smaller attribute size, breaking backward compatibility for older user=
space applications.
> - [Low] Returning -EFAULT for a structure size mismatch is semantically i=
ncorrect.
> --
>
> commit 205b70f382d21dfafc18f8275384ff0f06e59f6e
> Author: Yuyang Huang <yuyanghuang@google.com>
>
> bpf: reject BPF_PROG_QUERY with short uattr size
>
> This commit modifies bpf_prog_query() to return an error if the user-prov=
ided
> attribute size is smaller than the offset of the query.revision field. Th=
is
> aims to prevent an out-of-bounds write to userspace.
>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 9e91fb2fb492c..4dbf53e81a38c 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4719,8 +4719,10 @@ static int bpf_prog_detach(const union bpf_attr *=
attr)
>>  #define BPF_PROG_QUERY_LAST_FIELD query.revision
>> =20
>>  static int bpf_prog_query(const union bpf_attr *attr,
>> -			  union bpf_attr __user *uattr)
>> +			  union bpf_attr __user *uattr, u32 uattr_size)
>>  {
>> +	if (uattr_size < offsetofend(union bpf_attr, query.revision))
>
> [Severity: Critical]
> Does this unconditionally reject older userspace applications that pass a
> smaller uattr_size? The BPF syscall generally maintains backward
> compatibility by allowing older binaries to pass smaller structures.
>
> By rejecting the call entirely at the top-level dispatcher, wouldn't this
> break ABI for all attachment types (like BPF_FLOW_DISSECTOR), even if tho=
se
> specific handlers never attempt to write to query.revision?

bot is correct. this is too broad.

> Could we instead pass uattr_size down to the lower-level query handlers a=
nd
> conditionally skip writing the revision field to user space when the prov=
ided
> buffer size is insufficient?

ok. let's propagate uattr_size all the way to __cgroup_bpf_query() and do:

if (uattr_size >=3D offsetofend(union bpf_attr, query.revision) &&
    copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
        return -EFAULT;

With single fixes tag:
Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup pr=
ogs")

and explain in commit log like:
"
query.revision in bpf_mprog_query is structurally identical to the cgroup c=
ase: a late tail field, written unconditionally.

But the backward-compat hazard is not the same

The min-historical-size test is per command, and bpf_mprog_query only serve=
s attach types that were born with revision in the struct:

- tcx_prog_query =E2=86=92 BPF_TCX_INGRESS/EGRESS
- netkit_prog_query =E2=86=92 BPF_NETKIT_PRIMARY/PEER

tcx, netkit, the revision field, and bpf_mprog_query itself all landed in t=
he same v6.6 merge window (053c8e1f235d added the mprog query API + revisio=
n; tcx in
e420bed02507, netkit in 35dfaad7188c). There has never been a tcx/netkit BP=
F_PROG_QUERY userspace that doesn't know about revision. So for these comma=
nds the
minimum legitimate struct already covers offset 56=E2=80=9364 =E2=80=94 no =
old binary can be broken here.

Contrast with cgroup: BPF_PROG_QUERY on cgroup attach types shipped in 2017=
; revision write-back was bolted on years later (120933984460). That path h=
as a real
population of pre-revision callers.
"
