Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7F3B38BD
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959528; cv=pass; b=oo6tjtouh7Uc9KPbKE64HLUhIUg4jf9lNGLX6uTvZsV5CVT2IMquHSy8gLOh2e61EMqGW2TBhLCXXLVOW5YpPS9SE6o1omupR5bEKYueEI6uoTxLWGVBpWbsfGAXNeObgp0pxdoa6k/SdN0OauRwj+cpt2YoW/FESIr7t7rK/mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959528; c=relaxed/simple;
	bh=E15gTeE9IxpQqCiyRIAnhJyJyhZa2kflNcSZimN2LgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMxDq5IYoFwinynU6eGD9EGe/eaK+FOPmjp+bnYTvLyHSvddTjRd5A0iKdRPjEsyv5thaCO4lMkYEBs9h9psNU0g0tNvXIrRTbphkdV8aUZo+Idcupxrhfn53aUvo4K6ZOPppTD9OV8l/oLbODZMhAB+00U0fjAHXv+uHcnOdYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JGeVS5s7; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JGeVS5s7"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso10846976c88.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 22:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959526; cv=none;
        d=google.com; s=arc-20240605;
        b=M2Eqv17/iIodV/rqGag69KmLiyTQLTjNvNLdsZO3nJrPnzbM6/jKTOpPfAyNk6Mljx
         47+ButMHiluC5mdipxnhFskVVCBpI/RVgb1oZXxKqMGY6BPxdsrU7L7Is+mG7k1HCyrh
         VJdZeD4iQAtOQXno1EYB8faymIO1sJQHKOt2TfhUE5mwV2Ej8gxlOchcmnjL5a7KlDQd
         v9KI3H5tD88y+t3AlVIYZsTChDAvR5+q6XUcTw52IBlqfb2Ta0lSjG68AUxCpf8XIpJ1
         adA6N8sjTvApE+7MPVRboQeZkXwWg3LzjyxK9gWs2il8ETPvAUqvZ6zYidLuOIPvqVsB
         USiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OUm1t+0gZGzttowhsI56qfvRdvVsKy6ujIh4wA8TLdQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=kuOPPCT9Z+b9z+EyXDjkL858G3v6tkP7jYYijboY9NWgosLzA3r1gkWS5zhirGcI4t
         ax0457h/2XIKiuZ9V3no+f1gkXvtTQUcO4ho1cW+niUJECpj0ADa9bwdzcwevlrQL8dk
         mGk1SCJbFscHObrqRxI+YkNnG/fuPPYmBfwYWuDKqdMc0GW2ErkQzR8A5xVV+gAQai4x
         KlZRHirhZ/FuJK+TjwT/ydfFXxyDUWFp9xNjUqwnpMOtb7jn5XsqqesbP+ggiEG8AOcZ
         vHGGJcPZhE5bImIw8ueYUl9Dc4LqaOP0ec1Q73IRi65B4KHUlUAGFmgXi+1EgbtOLWKm
         Zyhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777959526; x=1778564326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUm1t+0gZGzttowhsI56qfvRdvVsKy6ujIh4wA8TLdQ=;
        b=JGeVS5s770MsFHq7525VEvrPaQXtHuJaLtVjGup0Ij0iERSEgMAkJ7PelS5YztsolX
         I6UiMzGaKnNa/lvlRt6RsU6KhqfgWbwGJPFNlSCVjvFFo9QmYuPMcPkI5TWWt+NsUMML
         DzSJ4LnWZKVTTOlTY7ZkOdqHqvwpwvHIgJweHryQZZ+oi8jzUkK+e/cpLyKXiWNdBaAE
         d3bobPmBxwDQ6ETP9BbP+oalYo3VPVij487W8IxJX0emgzzS6VNuBFT283X/vWAj8wtb
         OSTtfM1chgDNBLgpzCHQqATzGISjy05CZGOAiXTEu+LuQg56wCnxTjFGg8/hHMNPYQP4
         W73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777959526; x=1778564326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUm1t+0gZGzttowhsI56qfvRdvVsKy6ujIh4wA8TLdQ=;
        b=dliOEUum6YtgkehfxI64ekeCKIBAgkCOcVskPwNmricJ0ABdXjJUakkTt5eOXjSl8/
         p8gABgyP0GzW5Y/SlCh+mp3FJGMOVJ6PJQTFeq3mMnJSOVTd6F+NQAk0WZ2/vIezG7Hf
         zCI6EXJ7efGKJZNzeFk/NgLU8HqzjJTo350zL6SDIgSxpK1BtCoCAmluHEKXU5I+/bXA
         pAcUU5AEFsSy0bNMfVjNJ7ROTwCETdBfpwpKVqAUrl5bq0He+DheUfCYRnDRW910xq0M
         XwvcEgHV33JsLVn0oNTcnK4VBrQGrHpmEfkISkMqumasI85Kmiu9j4dLsPh6G+CN3LyP
         TEvA==
X-Gm-Message-State: AOJu0YzIewZ10RCeRGyjOgjLAx+G6StZ9T18Rf7H5SjVx39ctVdgNcse
	rPV5/ugs4j85wcaHbBIJJwwJDQeVk7/pC3qkRb2zbHs18pdl+NhsVlVBP/0vOWMiwWSoamdkOVB
	bPp8X1qpiMk2YoYBWbVP6RMAkenZZyWj9Tm9eAtb0
X-Gm-Gg: AeBDiesd7VC13EjsOjMdI+bq1smlZt9o+bB4NE/yLuh83WNW3GOY4883gL8KW21leDq
	wSBNEA0u33lpRbmaki6UI2brUC5EraSomnbIcvh+73n/XtJStXhBwZIDYMR7HU9L0s2VOmmqxZ+
	VqkGI7hJ6a//eAP7Tx7o0NehtT7Qnbnk7mueLGyjNbjsb5fC/wrFTTFbNUloniqYJ4lZlm1g/FS
	GuKEBRke6yMshFxsmC9uq4jGsXr75IVOiUwQVdzBr1igiBxPT0n0qlzTLlMdWMloDjRtgMkqbOp
	1Wm5b88V2iuKkPUSCbeUj9nYAPGq5IYvI4M1mb+rjXjPVmOmxvUp8cCjNVIVxZ6gsjnzYUgqty+
	AE6IsDNlqNPpyualyhUAC3/ypyRa43pGRgg12nAsqvospmBwjj8HSuipDQHgW01Bla1pY9xwLJQ
	==
X-Received: by 2002:a05:7022:5f12:b0:130:9f2d:ff99 with SMTP id
 a92af1059eb24-1309f2e02bemr1361751c88.20.1777959525442; Mon, 04 May 2026
 22:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504210610.180150-3-kuniyu@google.com> <20260505041433.8B6AEC2BCC7@smtp.kernel.org>
In-Reply-To: <20260505041433.8B6AEC2BCC7@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 4 May 2026 22:38:34 -0700
X-Gm-Features: AVHnY4IxGWS5GN45za6_yY6sd3bDU6y42Zis9J4CL8PN0-baQe0fNUQ6g7bQ_Cc
Message-ID: <CAAVpQUAbUnN_bBfguit7GO1VkQFwO3Oj-1adra820r3RpjO=kw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 2/6] selftest: bpf: Add test for bpf_tcp_sock() and
 RAW socket.
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Newly added code uses manual error checks instead of the mandated=
 modern ASSERT_* macros.
> --
>
> commit 1a574056fa08ab8c66dcd9b6ee5f0739ff6721b7
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
>
> This commit adds a test to cover bpf_tcp_sock() for wrong socket types,
> specifically tricking it with IPPROTO_TCP on an AF_INET RAW socket. It
> also fixes a missing free() in the test.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tool=
s/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > index 53637431ec5d..5fd33ad2eaaf 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>
> [ ... ]
>
> > @@ -211,6 +211,22 @@ static int getsetsockopt(void)
> >       }
> >       ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value")=
;
> >
> > +     /* Trick bpf_tcp_sock() with IPPROTO_TCP */
> > +     close(fd);
> > +     fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> > +     if (fd < 0) {
> > +             log_err("Failed to create RAW socket");
> > +             goto err;
> > +     }
>
> This isn't a bug, but should this new code use the modern ASSERT_OK_FD()
> macro instead of manual fd checks and log_err()?

I don't mix different styles in the same file, also such
cleanup should be done in bpf-next.


>
> > +
> > +     optlen =3D 20;
> > +     errno =3D 0;
> > +     err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> > +     if (!err) {
> > +             log_err("Unexpected setsockopt(TCP_SAVED_SYN)");
> > +             goto err;
> > +     }
>
> Could we use ASSERT_ERR() for this error check as well?

Same.
