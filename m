Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECE3750BD
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504140; cv=pass; b=GfiMno2XOF7jD029aGvgEcpcIyICHDR/muKfVu/xhVzPSUqa07OMAv+PTXDCXtv+fQ8uGz+XGXB8qjsD2uKSSxZhUPoRfn9fsyg3/0Ow4PisTmb3htiBVPj6fe+ViHv2+gbm2KuPXT67CF3ecii2Luwpp32wLIFORsr9MS2MJbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504140; c=relaxed/simple;
	bh=0/3WVRTAV68Tqab1dU46QJFgGgY/DfR2M6RH6QxWnpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVOj50bHE/rDErIU9mPycSbfSNfG9GdfRTUfMxcIdhnrMrasRxy0qW89lIs2T+F0tK7cy3N93BvDmfy/6+7xpJgTnLSG5Nkeoo95DmaiNd6J85CaesBiLyS9rQRKdvp3JR3D/FVsS1MoJixA8oWhDF1XvXtmHTyYJCOw6h5XgBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNBqPBSk; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNBqPBSk"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79801df3e42so64124667b3.0
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 18:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772504138; cv=none;
        d=google.com; s=arc-20240605;
        b=f1pLTvb9ENJljZPTlQExOZ3GBZ/PjNgMuyA4+T0EAl6cz2eQ3f+0uDMNtd7Ly14wNj
         wKYu0dkHjgyWpYoodby0LiV+9/v+PMGt2wzwtDYNNKiZtYs+8Vcx5+9D9psw9XphcTvR
         AFQh61mVt5HT4FQw8BNo4747AHJPeDVa9dvqvv3u3oLWqYRmiJcDhYy7XS9SQc4KJCb7
         Espyn/p5S4c3RLim9cVyQjSxnFUkxqmLVUL3utuP7pI/Deifd1TsjPcu7re8957Gq8rd
         iiaPOcunACQloX4XaQKDSrorKteyIpiGiOVZO5dkOkSoos7q9Uj+Bs+4cPpaVFRQpPmM
         /ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zoWPPOcgLHeuKkOjDta8aL0tHWF1IewgSZONMaW0bRA=;
        fh=9zKZIZUvdRjP39YpplEyoAan5fZL4H+HUVTK9+2lF/k=;
        b=dncd/leLVf+mBvTTcJn+RhRjzjnB5WalJBS2ZNL6NDBANA6e/3z13XrU8rW7XUNkgx
         y7eW87XkvFVz78b2F31h4Y4uIKazf995ZxUIKxoC4XqUp9BPpSv7/hfflomC4afZK0Os
         BP6of/9G6cq4wkRGPJdqQU2q6Tn3afKsnXqSudMaQviyZ0shQ0cBkEk6id1d+uur/qOr
         5/nH2GEv6vH71YpDbMRrPq8aF7bHV2jlp8thpJbLYlkELYkut4w90Moj1GSOkghu+eWD
         drMWf8x2Vwt4irId7yjVbNIZdNQd/Aspl9exbLvOQgajC73BasGrSD6jbs5fyIdxXauZ
         hiJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772504138; x=1773108938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoWPPOcgLHeuKkOjDta8aL0tHWF1IewgSZONMaW0bRA=;
        b=QNBqPBSk4KfCVTVjTyIinlZBn+3CQjBCtOmMgz7sVHE8X6rJcuqWkuwk2VIFMk6lfC
         okFmjZBtcAlq9V63neEYHHKDa+UmKShLubQEq3OvbQe3qvzarFp765ZzzX14JfPTJzd+
         Q3FyTLjGpOkJJnow84GBPw9kbasbSfq7OSuZ1o7mnFrSuhyiAVEu2AIAcRJktk2a/kGW
         piIleR0vuWII93WiG59lPDg///tJOfPtnM2/WDzXjQKRA5385ps2gClagT8iXpNhL2XB
         +m/GeNJ7P0eFQW3qnSKmRZ5hVBCbLodSSEiH6vmRr60Wa7yjWmyT+bfqfNsgMcViRMsA
         Fc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772504138; x=1773108938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoWPPOcgLHeuKkOjDta8aL0tHWF1IewgSZONMaW0bRA=;
        b=CjlPN+rXmK9rgTBxYIyMnrvsBeG51x5Rxqis/wSp8/ZJh7wJaMB5TJHV+Zs0YwMwZ/
         8vUM8XHiJBhGYQMXI8mtZDL83M3SASapQelmycAiR2YeeGFN5yMSimbnMpqXNnHPSphe
         eYO7jEkE2Lh4kG23esB0ar92MMsJMDGmtIyoEG1zKhMNBq8zQ6TboDhEQEg8VPm7+6MQ
         WsCRxrigeLodt54iSD+O/MP9RDvFrdXI816qYSyZHBeGx9od6kqZ3f3sZnPsRP6Ada/u
         TF5ngx/TvW7cETuminBFkucygHNU8aXfouYrRpZd/rmzfBWUuBoflxL/pIhUVH3KJr7Q
         fVJg==
X-Forwarded-Encrypted: i=1; AJvYcCVJu6vpumUHP2+qnznVHphri8uHwYYrzd1WgO7dHKd9hMsZH/mNxvIkEsKbWqtGJChZAX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7UhqsPBBLlsICbQT/46a6LXQkW4eRpixGaSsIeGY2TcEl9yK
	kbWk+R1Sr1Aa9+vw9v7I/sJMWDyA+4ji7I58jO/rt2cEixRLyTExRbWMril8t1nLG/pWI7PB7Bl
	uzslHdZYugJjndr3sPXKHodxb839pejE=
X-Gm-Gg: ATEYQzxw0lqdPOoQxt6nqt5eyDLa5OyOwE+51ac5CX5Bn0m2tnkBuKWznW7ASPfylrQ
	t/fvJWsiHAkXypLl7Jpcg+ExGx8zio2LZcHzElW6yb928JUVhXZUKPYfvZmCCWDvQCx5Ey2vvPi
	JqKW5No1Pj1/ZPVeKgcpQxUuz1ga/xDqZP/qGJao2GQcFf8uHDv4CEz4GlOR10Vd+tiMcqhJiTG
	2X3YNaeX/psqTXdNWdzQ0feagAusndriVeo1U2JCgKto9xbYIMCpAUQRJkZ7v1VquDHf1kneSCB
	ai73ENPW
X-Received: by 2002:a05:690c:88:b0:797:bc42:9e35 with SMTP id
 00721157ae682-798bb3d41e5mr3992027b3.23.1772504138088; Mon, 02 Mar 2026
 18:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
 <20260228074555.122950-3-sun.jian.kdev@gmail.com> <aaVgTiHlc4rXvzKJ@krava>
In-Reply-To: <aaVgTiHlc4rXvzKJ@krava>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 3 Mar 2026 10:15:26 +0800
X-Gm-Features: AaiRm51dhpzDzc25XjIGtzB1i-KYwE6RRyra8isDGEkOSSEK9SbBlR_csmNEtRw
Message-ID: <CABFUUZGAK-kD75QAc8acfoGvPVj+EuaFNLT7rcPcWP7SOnpKqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: bpf_cookie: make perf_event subtest
 trigger reliably
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:02=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Sat, Feb 28, 2026 at 03:45:55PM +0800, Sun Jian wrote:
> > The perf_event subtest relies on SW_CPU_CLOCK sampling to trigger the B=
PF
> > -static void burn_cpu(void)
> > +static void burn_cpu(long loops)
>
> nit, there's another burn_cpu in prog_tests/perf_link.c,
> we could add it to trace_helpers.c or test_progs.c
>

happy to refactor into a shared helper if maintainers prefer, but I keep it
local to minimize the diff.

> >  {
> > -     volatile int j =3D 0;
> > +     long j =3D 0;
> >       cpu_set_t cpu_set;
> > -     int i, err;
> > +     long i;
> > +     int err;
> >
> >       /* generate some branches on cpu 0 */
> >       CPU_ZERO(&cpu_set);
> > @@ -443,9 +445,10 @@ static void burn_cpu(void)
> >       err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &=
cpu_set);
> >       ASSERT_OK(err, "set_thread_affinity");
> >
> > -     /* spin the loop for a while (random high number) */
> > -     for (i =3D 0; i < 1000000; ++i)
> > +     for (i =3D 0; i < loops; ++i) {
> >               ++j;
> > +             barrier();
>
> what's the rationale for barrier call in here,
> together with the volatile change above?
>

The burn_cpu() loop is only meant to consume CPU time to reliably trigger t=
he
SW_CPU_CLOCK perf_event overflow. With an side-effect-free loop, the
compiler may optimize the loop away or significantly shrink it under -O2.

The old version relied on volatile to prevent the loop from being optimized=
, but
checkpatch warns against it. Using barrier() achieves the same goal  =E2=80=
=94 keep the
loop intact as a CPU-burn  =E2=80=94 while making the intent more explicit.

Thanks,
Sun Jian
