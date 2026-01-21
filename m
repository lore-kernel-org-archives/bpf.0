Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B9347BBB
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964628; cv=pass; b=jZr8Exo/BvHdXlm4vuHhvjOz0hGFDBB9uZzuUOGQPW5D0nluvfL7sheZg6VNoo9r159KE7SLcOVJ2OSd8f6wFVM7IIp4qsLHtovsTkZcXe5wR3H5DU4C4cwXzm4Vej4A1bpo792Rqwxa3wmtyqK3XWnqudrs6V3jrveto0FecLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964628; c=relaxed/simple;
	bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vre155OOBYRrfHP/6lKy4bTT3xWWbGK8MkcGmwzWx2zqpQ1aFuIsR1mYKFzuiPXZHLNImxuaAJwk+3CtCBNxaiUd+eEjZYVfnV06guAoOK/kTkE2fIgURBtAzQ77sUyStgeif3X2nrlf6quIOmILuqX5AHnMuWmgpZwBH6RoQx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3uFsn+4; arc=pass smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3uFsn+4"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79275e61c2cso57874227b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:03:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768964626; cv=none;
        d=google.com; s=arc-20240605;
        b=VqkmIGv/QkFNaKOUheey8yPbFTjzgF59Yicf6e7J3JSwLPJM2mmTJtOA3bWkr1Gl5t
         rvhzxYvA5oIVqamzmN1VzCAC7y5F/Iz2Sml0eDiraQ9yi7S70JpRVwWHwPoIxvDqP63Y
         KgD66uQgxBTPm0Tb1zqgGKwIYoiNvNBoQxc4TI9KbHkfQNfoMaS0ThXcuOhwi9Z4uZ70
         a5J0OuZ+I5Dk6gX0lQLPd/epQtWpSw5xeA3mAFCx5bDpcpsqNtNlH5s5Yn4/qy6v/B7Z
         OtoFCu5R053OPd+jY0h18Am0szv5qyk9hLLYQ3g6YL8SuikZavQW2s2RxJTmdz2gSZyj
         JxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
        fh=UphF0KRjQqb1K+YPLsN7Q216yCHu/4ucv5tIOqrinlc=;
        b=LAvowbqoSmjRkmtGs8x1cSHMXXOfbL6zUWB8pgCyFtql4H1JM9+2DYPvQ1Rp8SoU9b
         0ZefyBjj9XGQMWsemaQCd5J3WsvvFKbUaapI25in65rQFNbILRIpNVhqj/bF4tXx2L5A
         fVlj43TCLHueIUCNnzzskcqMawrpOn310GHaqvCe+IAsV2Eh3IPOkVL5CEYKxgCW9b1M
         H5zu97u7JmS7uhFeXGdeoLTOGRMPx5fCFNWuZfWOY8bxubyN7ZqKWIuROmWzIh/D7ibg
         RDqXeXyTKF4D0QcwpavT3Mb+tOnA3y4SCKwzfZ7MFpE5n6Bkm0LcRy+XYlqhZ+VZRsmI
         OfvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768964626; x=1769569426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
        b=S3uFsn+4iiJtlZMTj0nqj7q2bUCWgn44WpoatXBW/YfIrFqx5iH3fe1och8lual+Mc
         zrh8+n0CA1OAdJDRvharnVyClDeyUsx2SeWLrUfKx4iFkPL8yd2a++4ccwVd+VpcFVcU
         Z18G7AwtOne5MoGi58yVuYwajfyPhZYrtPmplbwCtnnnkBA1nrdr5lZsvxLZL5mzRywa
         bK5CkzhdOabK8dBpbO3rz1aWdGWugZg5sAY3+J8mvKi712jNhKFoa2ZL31bmV9PMi0Xi
         HD8hmslQX1A7kjUF7DIMODZOOe57gGFR9IsGmjtJzQj1zkewTL26X57COREoKlUktJq9
         U51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768964626; x=1769569426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7n5BpCEprtmLBLctZAMtt8SFp+1NrIdlsLO06oVVvI=;
        b=YRRxr7oy19fhnYpPMWyddSc2159BtejdA6AF78tkjAyvRialNYMUwKJR7V0NBtQ1Rz
         R5hRqKOvFO0Q7bu4D0HslJz5LZnnGl2MYwyTTojbuY8rlzUdLxZ41sccXs4iTR6jDB44
         Nrx/viGnypoprdQRRprBfRbzmvkuOuahm2KdA3swzKOiFQLmS98k9sG6nAxeklyKKjwO
         X8HBDm7jCz3pr6QELWNAFgmxj89vh+JoJQFkMcVI1C9TbZ3c+dOq+KJrzYgM3P8T8/IP
         dnsBGzSbr/jzJsOSFcl0stChRgtXOSiiA6ZRrvMOmrp0DFLL8ta2+oKWGDVgQGUpb95a
         ZACQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBu+PPGVvgnp98IXc0+Wv7MNEqADB1fiUm+nsslkBpi6PGoYCCHz0a4O12eqg/ge+rskw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9djmNBFamNSIcVrwHF1DJEsXZZpD4snnzqa79WY5TtvU9o/YS
	6ZShbPz049dPKmAxH5l7h5wQmozsxbsSvMGzuBEzlJXWezW9dUyD4ki7SqqaBb/bt1ek+lit8QJ
	OZkjFIl7tr+p0c8U05aebdyZY50Z2VSU=
X-Gm-Gg: AZuq6aJ2irsD2V6Mw7ZXaWIL8p8ZqISWV4RWfY1i/MYyhrLpJ/GPV/QaDFdll48TUrF
	Jt7RBgsaBkWxaxsyXBdlp7Y046qh/S7LO9m6T9LPCB9k22SKPQN+/lUrZGqpIQvWbgV4cIZ8owV
	4L95X4sjxPlMYvvDfcAospm7orgiu/a626TqjAR7xuOclj6h/JSF2xYHHq9JI+HF9hA+cmY/6/W
	Lt5WTtt9M4JlmeLSEPenePHDfqanUdCYR0T/H1AitZOpzTlONffdewNGgfvZErZ0OWIMFSJYWXi
	IjxPQ72b
X-Received: by 2002:a05:690e:d8d:b0:644:6c79:62d7 with SMTP id
 956f58d0204a3-64917713222mr12432211d50.63.1768964626122; Tue, 20 Jan 2026
 19:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
 <20260120070555.233486-3-dongml2@chinatelecom.cn> <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
 <5071056.31r3eYUQgx@7940hx> <bac96afe1a99c6a12cd85285c677f4eedcada066.camel@gmail.com>
In-Reply-To: <bac96afe1a99c6a12cd85285c677f4eedcada066.camel@gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Jan 2026 11:03:35 +0800
X-Gm-Features: AZwV_Qit2NKtH8jlbRBC4sp2eYwMKaaQ-6NnZxqEn4yUhXLl6r2aTmYTf8D2EII
Message-ID: <CADxym3bDOcwi9Qgaibu8TeER8ORtvX0-6ernqfLBTvd1Bo+5xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 9:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-01-21 at 09:28 +0800, Menglong Dong wrote:
>
> [...]
>
> > Do you mean that the CI of arm64 doesn't use LLVM for the selftests?
> > I noted that. I found that there are other similar "__jited" testings f=
or
> > arm64, is there anything we can do?
> >
> > PS: I tested the arm64 locally, and it works fine.
> >
> > >
> > > So we should do something about silently skipped tests at least...
> >
> > Like a warning?
>
> Yes, probably llvm-devel or libs dependency is missing,
> hence jit related selftests are skipped. Same thing for x86.
> Discussed with Andrii making llvm an opt-out dependency:
> fail selftests compilation if libraries are not found and SKIP_LLVM is no=
t set.

Sounds nice. People may not be aware of the LLVM dependence
sometimes.

So is there anything I can do in this series?

Thanks!
Menglong Dong

> We plan to address CI config issue tomorrow.
>
> [...]
