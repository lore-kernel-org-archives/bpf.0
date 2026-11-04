Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802202;
	b=rIhZqWBGTye4Zqn5bZCpN1+IsVf1WIuafi7+hGRnYBJB8404Ec3MBgmZbZ+TU5UcHR7C
	 KqFjlD5AHXkYCn0OEpHmXn6L8VcNuwlC/hw0T572iOSyShCKW2nmzKgzV3S8Nq5lLFvrl
	 k/N4U/qBZa4lLeso4bqNNTN/T+RTBra2InZhBTrq3bDBBfRTwEeVabgwSoV2uc9FmORVN
	 DpmIJINVErTNNZ0bIAUE0AGKPSG4Zwe9rWtwXUI16WFqDuorRvU3dOGOqhJUd1sCzSbR0
	 Gq/QWIx5rS9ecU2yo9jyBaXNfQyvmabXIwCuaoNhQ8KN9RNr112I6fNvzoY8rYqn8hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ipCVhzNjz3bkUh3HIH/dC2V084l64YZgYq8uC+CfKVA=;
	b=M0gen57mwiEtF75hU3iZxhIVDm5oa3DTzHBrVcqwDwIA1vs+VXMD/xLmsxF/PhirY47P
	 FQfXtUID1D5ybSmGlajdLPxSz1DNJLqALTIvP/R6pWkVDyA6GgP6rvfGDRxUMGBt85MgQ
	 y5WMlI5LMBfn1uX3gWCmm3rszuJi7ILSL7t0Z73UQojHz1/ppQgxX9ZXnR/xcGzArMcyY
	 O+O2tCjvXVbQUkdoJ29+tmk4eLZ0bjVvjZtrC/EkhOVCErhssGSQGDAj/7ASD0QZL0LFA
	 bjD4gHL72T4/ptvVnk6UfSbI4cC0Nsfd1r00FMyG17j4cF/CLwSmoLwssAbBY5A9nkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LsVrB1R;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA4606A330
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 14:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AEA4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LsVrB1R
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso8051255e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793802195; x=1794406995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ipCVhzNjz3bkUh3HIH/dC2V084l64YZgYq8uC+CfKVA=;
        b=0LsVrB1RbPjDtXwX3qjLB1A3vbWVpqZ7HZf5pVQXVp4B7btdszFS1RljBh17d4QysC
         BS3cixxniLqtiMaPPHJK5cPfu73HovzOQC3aoX+YmxViTbcNeU+xrWcrtDpOK3olBzbq
         8BYj61J6NvVpkQGghxMoUWWxHaUL3v2+0S7dfFQuuTth1J1asNB7GdDfzPs5Ij5j1Fma
         CAHQ0lbRdCK0qEiS0+sQqrIdPbDnjliso64JP9yRZdlJQLMNlR49y+Q1lop64YIK2xJG
         yr/u0N5gPgEp75e1VVKhayMcmVrXJMOLfY8AaES0WpLtJCBYs28K3LQlgCNZwXYwAbjv
         QTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802195; x=1794406995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ipCVhzNjz3bkUh3HIH/dC2V084l64YZgYq8uC+CfKVA=;
        b=GLPoNaiWvNqTBoKrQYNKt0W6BIa1iOFYeZ1Zh4dpwf4WhvoNQ7o8Z0RJ3lZFUHLKWZ
         9c2z92EHL3fblkgml1XrVuS88YmKoLi0bhmQnhErkO10k3AIsv29IWHzEl+WF7EZjR7s
         CYzA9H9NqAWhwp6JzapAj+cLoYIPLC6j79avZXpLw6+8M2OaH3iDKAS87eHkuUErNDGs
         MAPIWlknEHUu+mmC/1j8pLXIYs+6OTVLZ1Pl3JVI6SAXV4Roq9+XjQC/RYRR+f0Vp/La
         T1Bbl+Dka1j7B3r2HWcwDQpMrAEA55lhJDiUZ5rsaCioiKsQH8iD0eWOC8ZtO/1Ia+sU
         OhIQ==
X-Forwarded-Encrypted: i=1; AKwUvBys1LmiPkSeIggD44ITPdBQxkeQfWtjAnjxyg0ruTYO8pfc49h/tjPEroy6dJrYwAco824=@vger.kernel.org
X-Gm-Message-State: APuU4Z+foW2OtxPrJ8FsOMrqMHfJF4r/1NFK8r3REscwr1lBe+oG7maO
	t0nHXKVR+Rgax7sGRgYVHn+qbbkvsf4so+arlww6G9i60GX7TuCN5Jd9
X-Gm-Gg: AYBFou3rvmSfE6LGKC7ByLy0rS8RuNLGaNmwMDBodag1tz0C1V+ARPHdv6yW44aI7Io
	1I/4eEue/3hyYjtKgAsu3r5v9p42zffUlH84JdJFRJMSOW161gqP4N65yui/2Xu04725NdFRuId
	whssGwJ7UG9p/Y5BljrDD8xStc1mnMrGppgdd5UQ7BaZr41jAJ0aWfOFOL+9VH6IL8VrD07gsZh
	9E/rTsXClaZJoCypYzstW9esyXY3XYRyB3fzRB7Rgwihnx6jKzn0IgjDLTN3a5DM3gguF9LS0rE
	cprBStA6ZKERfDg1VP6sBdtbejQKbH27tweFuJhKBBtr4dU/D45vuFppxRVyO6qfQQP1ElNEs35
	JCenIpgcsxstIgJMD4BKIwvoQnjt9By/1x6/yfCJV6sQCKs55GsqsaNqSNTsVh44gUeFlvi5sUN
	xpgH1wnBSoPNP95wvBsz/5zR3BhWq/LVL/OYdrrMr1I8ujG6COzTgihBM0WDKbM8NyrsejZopbY
	gUGBQUx79yuHF+vCT5O7/Ba+VoSrQeho5usC8E9hKS1IT4imcs893HC8NNEhfJKlEuQzzg1ZMON
	CMXWuKD5vCoNyCqn8FM3S0hN5tt3hGFlRjSMkLyDPL0YDmZ2tAjFb8l3WlllVvaQ
X-Received: by 2002:a05:600c:4f55:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4ac182dcba3mr406397685e9.17.1793802195353;
        Wed, 04 Nov 2026 06:23:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c7480e3sm87089165e9.7.2026.11.04.06.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:23:09 -0800 (PST)
Date: Wed, 4 Nov 2026 14:23:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to
 /proc/kallsyms
Message-ID: <20261104142307.431fc12f@pumpkin>
In-Reply-To: <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-9-wusamuel@google.com>
	<20261028134012.01d52e94@pumpkin>
	<CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
	<20261030100215.6f8e0d4f@pumpkin>
	<CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Nov 2026 17:14:26 -0800
Samuel Wu <wusamuel@google.com> wrote:

> On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Thu, 29 Oct 2026 15:05:45 -0700
> > Samuel Wu <wusamuel@google.com> wrote: =20
> [...]
> > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > > would be different symbols at different addresses. Please correct me
> > > if I'm missing something here! =20
> >
> > Only that the user might really want one of the copies.
> > Sometimes there is only the copy. =20
>=20
> Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> pagination to cover these. A prefix query for "foo." also finds the
> copies when plain foo does not exist (expanded on this in my reply to
> Andrii's Oct 30 mail in this thread).

I'm busy rebasing my patches - they got stamped all over :-(
I should get a v3 that applies by the end of the week.

I will add a 'prefix' variant for you.
The 'next symbol matches' flag is exactly that (actually it is a
this symbol is a duplicate to avoid issues at the start of the array).
So in this case that application would always need to read
the next symbol (by name).

I think it might be more sensible (less pitfalls later on) to return
the symbol number - not that of the next one.

David
