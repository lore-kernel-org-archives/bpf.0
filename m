Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA13D903C
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271679; cv=pass; b=VOKyEnC4NYwIf0mxcE6ZDSrNcaIO4+mf3iLP6mBNmgcBdaXgRElkkS8IbP0qvXoLgNomxgcFYjNtSxCaYCeMjOwr/zSfHzrWf+Yf82o8doswkjp8KLDtRoXb4lstSi+xER1RpM4nF6GrQ7R9MWreFtE5LjitvjubTa/lJRoeVbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271679; c=relaxed/simple;
	bh=clTjvontwUV5I1LzL/mG5UsFzPY6tLzjfYfcL4kTDMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUc/TxAlGIYUt18XRXwtUsat7OOQhyBtpGMR0rTO+/b7zkzRnN54OhItSLNSCzZNFprFuSu1bgSwdyPXR6rI2WM6dJOnhVD3vPLXAHnWsfwaA+C4DifQEVARPxkdiY+4sTRjYQqLAmYxhy2rSOzuJzFjI3vHkdrHd6pOZRMBxcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uodIKIqv; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uodIKIqv"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c1a170a50so3447743c88.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 13:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271677; cv=none;
        d=google.com; s=arc-20240605;
        b=OfSpWgvlEqFjTUft+rw4DizkzokATsX/AXmCxreHvTVCXVFRTszNvcs8G964jW/wBg
         oGrn5yCMj+7Rn6iS5X/bweRQbYSzkrbEoXN9fEutWB5uriMi5c3i2ab3oFgX0H1BZKta
         xUvig1jQNUKOUwaE9AZ9Hm07XXX7+l1G05JdX3E8V8MaMw7U8cGnRQ6JizOY2JpH3YgM
         eM1PzPOUh3YCHSIccvgifKeWXcpG3X43Sl4IOdWnGMfRB3UuBsXXAln3ypQtI/8qXE0y
         pYnEyw+UGNgciesUcXzjSWng45jZSTdf5va0b5QiDQETkrwXmVKcNULA6DHuU7gNJutX
         urdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eofxHGAuid8OpacDdi/A4URZkbFN7TREJITktZCU5PI=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=fsVtsltRy/Qh7zefoEXQ1NK7udpXIPlfugqUPj3AILDeq8+xpuVRXcIfWUAqLiRYY0
         mLZ5pS7I8MKx1058NQPywiq1VQCLNmC6jLRrrZwmYCzG04KFgyj2U4TYIuSLpPe30o+y
         B0ruND6mKtoxgYlf9MPSli0ojY49A6UzesXPk+e2xJrdlrEw4MDDRjo5cdROwiiKp20G
         gXdpxsmOVdhgcdssPbugefR7lZjD9OZ5Scnsnhz4B9c7vpAOETHeJygxr0y3XqS5HkYd
         5U6JvNSXi/tSK0QxmEucMeDFkQR+L3NqtZ6mufnBCS+kq0GyU4nIQoVogrDQdUDBM0N3
         dUZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778271677; x=1778876477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eofxHGAuid8OpacDdi/A4URZkbFN7TREJITktZCU5PI=;
        b=uodIKIqvw+jUY2dBZXDKpwMb9RjH6raqUUed9R5G67ZqMnuMIqcXufkPsllIK3K9NQ
         FbdbmEJERMA8MASWRQ5eagNWrHeOGzo5vzxkvgHtHHqAd6uk2v9xe0107ZLWSMsd5ycH
         xrBpJrQrpcZD5b+mQV1HDJtEa2NAZS6WPQtCk5dSp4CtHXkyVY8LMZCyZi67ReCcnBbt
         KMzNDzBFY02zK7PBy/6xCFv8CWIZoQ8V/5a7d6Sys/I5xQ2x2esnFOLDEjVgvA3azXQN
         0ssLVXh0/hR0SgXN+R8TZEt32Qh+h8azBUHlK/zCC7ZzfU7AGiHrWjTlKx/KFZtzJFJz
         MeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271677; x=1778876477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eofxHGAuid8OpacDdi/A4URZkbFN7TREJITktZCU5PI=;
        b=hh83xzzmaHU/Ml7g4FqJ48KVYYRAL3ltZunUN5mBPr9JJ5J6fKDi/l14jcFM84NcSL
         kGGhO9U3/N+9Dol0IF8k5z8jJ391fB9cQLZrLkfrrIDfX8L4OipUaJoHo5zCOZKKkdax
         W7A26jKsTbcBJ1fjhJShTgqGx4pJNu9YtmbVBhSU5HRps9PnHMBPgvs6SXm8N1Hd2eg5
         0K0zJDgIUK6Q1hYIvzRDxaK1VSBRek9Llwb73EO6BFf6qiP5Qpx2oUu5jTBLY0IbYMjz
         iKpLl9fMrI58dgXsIFkjHBEZykrBR2DMduuhoIEYPfMzUyDc6fTRvwydFDdk3ssZ2ihP
         YgkQ==
X-Gm-Message-State: AOJu0Yw7nU8PwDitM3JvXeUMWC3/tn2NzlCz972gQGlQclqpD3/nyt00
	ucF1lzCFNd9uf+nnZeLW8Pm0MDQ1QEPzxAfamyJ1nu3jPRO8eUFCtXRj5xdw6qqYACXK/2Ww41J
	dbTOG+Qfj6ZhVjXfFdXkxRHrCD12fc1GqpZcv8rkDIpH2WMc+5tLsw7oK
X-Gm-Gg: AeBDieulJa8TodxQiTQLrmDKPPBQOTmiCOn4T+1RB+sFRb1As9cbd4sAGAN+51z8hiu
	prkl8KBcCzJAiMzDmncH7ygOKrhRssy4ifL6r6dflPUnqdmnWUp0tp5OFpfxNmDl/E5qweZ6twT
	0gwvq22ZB1t0jUn0SDGELax5+NHSSkuPkniLuW9iIz85c1OVYz8FneHn4se5X1mtp4dmW2ZnMlN
	REiIxB/nCaHCNNJLLXyxFLbG9DoTFhshIptnkJHFXS1qAD8geiZK2hDOZskcnQVUYHhPXL0drz0
	fwMMFMLM3fuXmU5YX5mROlMLaKOF3peD5MMjvG5vqEQmoSb3KvEaFsuUnR3X7zLTUKnDHjUkax7
	SOAGYTXxSxblUo9jvEVaHeY+8S4lKSLM=
X-Received: by 2002:a05:7022:688c:b0:130:c9dc:bc55 with SMTP id
 a92af1059eb24-1319cf5d736mr7348783c88.28.1778271676496; Fri, 08 May 2026
 13:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-2-kuniyu@google.com> <20260508190227.AFAE9C2BD00@smtp.kernel.org>
In-Reply-To: <20260508190227.AFAE9C2BD00@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 13:21:04 -0700
X-Gm-Features: AVHnY4IITnMG9Ifo--WD0kHxiOjqAPYuz4ED94BpgA_GNomTzTUpKVDCO1IdJUw
Message-ID: <CAAVpQUAh-OiEUJ7PqcLAgYjJq8K9QTFPsDfVVeAcicyvtF4hog@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/8] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
 + 1 for bad_cb_test_rv.
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 12:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Using `BPF_SOCK_OPS_ALL_CB_FLAGS + 1` to test invalid BPF call=
back flags creates brittle test logic that assumes contiguous bitmasks and =
breaks forward compatibility.
> --
>
> commit dfed6c2387074d0f6f7afb70b6bba777371f7267
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
>
> Once bpf_sock_ops_cb_flags_set() supports a new flag,
> tcpbpf_user.c fails due to the hard-coded max value, 0x80.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/too=
ls/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> > index 7e8fe1bad03f5..e4849d2a2956f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> > @@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *resu=
lt)
> >       ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
> >       ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
> >       ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
> > -     ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
> > +     ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
> > +               "bad_cb_test_rv");
>
> Is BPF_SOCK_OPS_ALL_CB_FLAGS + 1 robust for forward compatibility?

This test is not supposed to run on older kernel.
