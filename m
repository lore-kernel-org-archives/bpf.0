Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713D43F8B5
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512205; cv=pass; b=TwMrK2Uow3xQy2Av6IUkIb1eTwFqG8gV9cYQv1mAAaAq3f0vbvgUmOcrgJuHvM5rVjZGrymDkMJ+mKAOoyYezKexBSolhUxiVOXWf9HXv/AsQx1FORlVQ4b2QJkXqhFoC4a1ZgHxFej1dpT/eXdJUpqaqtfqVcrpSk+dfEwsc/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512205; c=relaxed/simple;
	bh=kPzEtdgmgmrhfEvclMUzFEFQMW3YYfNU1BZsWa7XSjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGowC/O1oXnOdfDV0/zwjtwJ+osNGFNSREpr+hMWK6opS5WsDYwfPoLzRETgQQfExsqTLwIazlUU8MrOiIrEjqlSCl9LHmjy2B3SZ5FJGH2RHctO5Rmar9TOtmv72RJ8sc6oMyeM2Zds4q7/h9LVtAlxVOYNg8wNjEf03XppfjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFc/OdTg; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFc/OdTg"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c16ac21acso6767491cf.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512203; cv=none;
        d=google.com; s=arc-20260327;
        b=IZ+/uBGu7iaAqvqwfCm/NO/fDojufRIIRIZFIIuzQFK/Z0QVW/gxutedb7Huz0AYKA
         TcPHEZPFzFMcTnCYMGiGDlrJuR4swDtyHFaOtYlA0tlSSf8+cYuQdvbWHOzk+zg0WKP3
         xf3dpHVCxP0EDStotsN2wHFdkIR+tmU0AHeDRnLfwdsJsvuwc7o9X7mKY9SRnv5t9bvV
         viMjGRmK2rZZ0YdKJan9W979ZgAwEMAkJnwr3kh6F/B4k0+W42O4+Wyj4LK1kuRYQyak
         4/sC6Xs4UACRT4sRyPK5CFcYSkVRK6nRiXDcLylP28JTCPwKWQ/YFs1ntar26UqrmPjb
         UbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        fh=Qbf+HJDw6wcuMjVot7tYfpv/f6Sb1xtTGhyco7Y8ZUw=;
        b=VSTU3l0AySVANgKOCtKCiy0Lx81Pzq9CwUVGT++0M7GAoRKyOUdIKyxn/5MhDJEjQd
         1lyGwRcE5iQ1K/LqZZufML30Um22JhHLb35+bnXILjhOWGrf/L5QNa0urqUZ4Qy5ZZGG
         sYkWkpPK21J+n0BdqBBj2/u5ESc2w1t1RSKBqhX1fzaQGdsXTuGK6SA0ZH5+bhn356y3
         yFIB3eDDQWVtE0CjOqcJrXFYMRLtQQ24rvEjqyTqV/gQzozGa3ms1kvRRex072TuC61I
         IEp22ecCT4Rra4yzGe6L4YBfsB9YciSeAfq4yaNwRB+mb1xz5tMtfzdGVtveidHmFrJ7
         c89w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512203; x=1786117003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=IFc/OdTggyxdx71WMUkmunfFJv/VBdRsML2egv3SAZWPQsqAefG+GCW5wF/exbuiTa
         QR7uGfe2g2p08Fxi7cbO7yEIIN8XKQYDgkRTTzsgAQkPuO3SGaSSiGhnwIgPexrOySZa
         +pZ+yNZlpxVkvSZoEM6zMPBqP0Vph8OkXnbLafOl4HbYSB/gXqgS0me72Dh31n5iZk+V
         2TfcgprOH90j2Y/h/YyQJmhoWqYtQXHojL9LdYazVTSYgmVIeG3kvXXY655TfaDon/Hm
         OOzMc1jTW2zPFrgbpFNTk0g5clcA9sqMzcETIeySBrsKVqu/NoYYyuQ5t9XCId0uEIcl
         kJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512203; x=1786117003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=MC1xXdPoqqWoDn/ddnKt9Q0Mwa0Z4hn6U04xg+3Xc0j4QtCNAF6KIJTCJbRwIuCYV5
         YqrVGJ5A++e2JIoU0KrkKYhmIFDyd235oBs3TtjQRnbavHIF7R42LF0KX3tBVPEkmy3f
         jOtd86TqFE7nC/E31z/SzRgDnapEmrxuh0cgLL2uF9istqrgyMpsyvIzd49p0eHAcQ9y
         NgUd2b5FhHJ6PKBaV243hk4C69/s01sj4CiKEbhY3JGCYHVSc6OhV2nOYcjcZ8f3wDeA
         ThvIL/f949OPvPpH1natbZuAp1UpRn7PPN1hZyAO7auvKFPVWL1qESP5EYpkWnIxIpp9
         rshw==
X-Forwarded-Encrypted: i=1; AHgh+RrO6WktlitwCduDt4knH1Y7upii2c+3cdRiYgnKg2WKmR+BGi9RdKbFuP9vtISyYI+L1fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzslV1smk5wQCcdJhrlM4xkNTgcCR62WDYR9OPrnASrviBKxulq
	5uTqz+o3vR5pgUW7kx4YEP3BpI6nbYYa6f2wf2j9ya2l7aW3tOgItGw4Xr1VDVZPRLb4PPOfU62
	31HCImG1Kl9RDJcVM+b+ZExwNr75IwPI=
X-Gm-Gg: AR+sD11tPJhwUBhrvlPj5wip5jhl/a38RfvbUep2YTOCKH7htGunxR++ZbIyPNMMnWq
	YA2Q+x5A615LEtB/Hydoza+y1ZgqdqMeWYsrGTctXjXcmhTxPs8s5ctxca8lyQQv9IDsulYCwSt
	rIswTeACUhX85XEBwDp/iqjxrANzztJJfS9JUgU+VewRCE5kORUJFPrfp2wLIW8RaYXXAnwrVAU
	82M8juOKAv/eFT53540wuzPtOwdwwmsVET9obAodvYiRLP3hXE6GRP235MDa6FHmG70ajgqSg/9
	euiRDKkgrrFHq9n86sFQptHRBAEy8KOSG2Sh/d1hwYaKw85j7in5joV6fqPPkEUjBanQzAKy7cs
	=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52b5679527amr12582491cf.32.1785512202948; Fri, 31 Jul 2026
 08:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:36:31 -0400
X-Gm-Features: AUfX_myF-Fa2Dx12J7XG4FMqMoM3YLOYocj4Wcd15kosvCgWFWfK34tns1g5ePo
Message-ID: <CAEXv5_i+OOJqr7xb02=5JMR2O8soLJARckG2CK7yvcv2Ycj+eg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:33=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Nope.  That patchset has its own issues, one of which is the location
> of the kfuncs outside of security/; I simply haven't had the time to
> review that in full and reply.
>

Makes sense, thanks, just wanted to avoid churn if possible.

> --
> paul-moore.com
