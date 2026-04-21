Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DA37F8DC
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772433; cv=pass; b=Sf6JJ8ioblBp8uYx/JFdrLtLiM42qf29jI4F2O5tfAUCwPKNc8v/vVBfXL+fYp1u7EaBld0sjDuWtxjBdN8Ab1dTBDHF3/MqBTQ/t5yFjeVIb24CSzwM3SsAuX4H9HCXK7J+GSlozEia6PIcsXZzLdvOshc3mO8WCZ4jFa9WOTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772433; c=relaxed/simple;
	bh=oRq2LePUVfK7dwkVxdNWCIvYZihlp3zhNqDSWudQd8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hyb42dzwisQA6i4VOZytc7ix/fx45o1ZRsGfkkgNNTiiRT7xccsmvKUzS5u3AbDKkbdpQsI4IjsyJvhQ/0gzA8VFr6K7OrZNYIzgqTTWTaduxIG7mObL7xe37MtaS9hDaLiUe1AC3K7wEfcw+1eyX2hIhUsyn7DaqnfeZ+LlawM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSAU8Jq4; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSAU8Jq4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f97c626aaso649053366b.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 04:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776772431; cv=none;
        d=google.com; s=arc-20240605;
        b=YTl1IW3sqg0bHVTlC4ED9GykmiwBhKyMb0ym+uvE9gUEjFTxku7JwoCuLEBayMZNhM
         zGq1Hjg+OcjATDQZJwzt7Xy8+rqp3afqUEGCsWCB6flKjrDNKTXZK6DGsoEqrqlhnJ5e
         +ZCneHhHTIEx0/55Ndj93xmXrBvxPcNteLgCi9d4PAsbXsh9reAFL3zUEpSHl9NbAvL+
         pL9rLyEIWMVG4LrhLp332n3ubUliIyMWdCDjZm0aqiQOw11JniAZGubg0gPpB3eR4XIW
         pwIXnmp87wrtxAhDShPQvbez37RrAsNch9z4K/G/8f5g5w0bEdwGbI1/jVr5fXEdGIm5
         l58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YVPaS7F82I+fa/wQlu1iuZvNksosUMMwWhC1cueKpN8=;
        fh=L6UUCO9CfrlvdEk8W9OlafxpBmpw7oQJ3UoKJoe55DA=;
        b=EGImZcq0L8UWIyiyIysJQNoHmDQDIg77lFugwm/VlMTyB/SHAVdyXEKm5gSyBL+GRu
         2n32HkUezyiBLUDnv247LafJ5coCikNl8LrYg1Qsf1uxnKKCACQctwDLjVRpVlmPTGUu
         /O3A8j2BPBxMaLbE0lcmjyKu+nRpBzLU3+CODbgyq3FSf/7BSAVoeoSZtnwqVUvSeK7Y
         UGFI5NuZ9M3xyXZ1ND1gvAYb22ATViDOBmktm5KA2LfbrNj8nN4tiXuSFCfC8Kijk89i
         OIEOYETbTSXv66KaCoIu+TQCwoIvOCUWoOtBuDagW+9X7E0SNzfQxZ6cYQyvfHT3/UbX
         zg0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776772431; x=1777377231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVPaS7F82I+fa/wQlu1iuZvNksosUMMwWhC1cueKpN8=;
        b=gSAU8Jq42Rsla+GaQud6h7ZMwHmmzXsFlvDpr8FRZJ2jjI3qeFQyxINt7rAzTSLf6W
         bOhK3lkazv7rt8feK9xxE7++fndzLl24UxgKQ43jSkF5do4UDViFvVG9N2KMPzk0yCIZ
         Ob15+vQKs7k80y5XR6gCpJEd6jb8vnXCDzA5YR1vlFkzLBezRCUCr2vLRa+jhu+Eb3Br
         fQ1+mOuhK9wkcyIIbHA3SYrQ92ufGSGo5kSjQJPmFJdLoM3jimNoJ1iV/F8v40PnpsmU
         Z70SyTgFK5VKlTc4eNchYfJCcpClGxMMdU5Mux2y6kmG103NMaw1rQw2WUoZju5B9sko
         dDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776772431; x=1777377231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVPaS7F82I+fa/wQlu1iuZvNksosUMMwWhC1cueKpN8=;
        b=OKl6h9ZJOTAKDIVRkWM6ni02JrbeaiCBX616s9xc3UGFOytlp8dy69wvipc8oiAdi9
         m9p3LQgR0Z97va7eFWuMuBfk7IaZb4eWUf5wP49z/TLtEp8Y2ecEypT2a9BqnuOL8H4Y
         NG/BWBku0vJyd1CZAdqnguWJixaPfhPvZzj7rqvs0OOV27e4NYxNp6wpmtCe4vssyDhe
         V7g9uzzcxF0LWK5uRT/lBUGWQYs7TUUCLVlYi6uY46Y+asxxA3dilbtdNcA3dS8ACR5W
         liqYFBOzRoqaOJXxwdb3Mi5V3C4eoNhwaoj7Iv27qhrzjD4bDs8GMykNZvrvwt6L0Dcc
         NpDg==
X-Gm-Message-State: AOJu0YyOMF9NnR3kxyi5c5JYNtlD3pGxdoWYrlosJJbt37qdp16X6f0s
	G8tJvuCYfiVmTM1hWoSQU5Ih9GTLhINr5XFatpLneMPddCBDht8N2RuTyvr8mFzuSSL8U3DzAy9
	HCDFJvwDf+WACRFvMNc/pKFFi/khQkVI=
X-Gm-Gg: AeBDieuH4+HvZZM9+wnxScitddRyDqJMwujTIUzIhXVZRMuzqNe33DpbeEJqBxPJv/3
	bckoVhECxCJqT8i/F2NPDcjtEppB62+ucyCrNFRqoWFLTPadq6XkuNva5cMC87Uz78Lk6yBPUQ7
	NtwqTga8wQFm+dC9DLnI9bqdBUhULFV3oPG8MASruhbRdkg5R/cOls0fDYQslYV8Q/kJbIUzlTp
	r0hHs5F+VWLxXsrNgFaTP8lSmvpZf2SK7sTWSjwdyFcNQM3zusQdyePOUsoo2F3hPjD4FuJc18+
	DDjyAIkmMbqDAOSO0/y35IsAM2DN/Q/pej8F6Kh+VKr174Ztgj9V
X-Received: by 2002:a17:907:da16:b0:b9c:afde:9b59 with SMTP id
 a640c23a62f3a-ba41bad0086mr877460666b.8.1776772430297; Tue, 21 Apr 2026
 04:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153603.4097618-1-puranjay@kernel.org> <20260420153603.4097618-3-puranjay@kernel.org>
 <CAADnVQJ_D6XyvMHPr59dxZSgFY3+6UayhcWrDC-U2k-Epv-9eA@mail.gmail.com>
In-Reply-To: <CAADnVQJ_D6XyvMHPr59dxZSgFY3+6UayhcWrDC-U2k-Epv-9eA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 21 Apr 2026 12:53:38 +0100
X-Gm-Features: AQROBzDMBnDZlE1GQiV69BTv7CUF26NRR9MAAXFOt6v0yL9UPZlAUh-2o20pDdc
Message-ID: <CANk7y0gNqm7U_0Kc6ZP9jd19gHKScOaTVDa4yxkxTVDonM0iUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, arm64: Add JIT support for stack arguments
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 20, 2026 at 8:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
>
> nice and clean. I like how it maps to arm64 calling convention.
>
> > +       if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_=
depth) {
> > +               u16 outgoing =3D prog->aux->stack_arg_depth - prog->aux=
->incoming_stack_arg_depth;
> > +               int nr_on_stack =3D outgoing / sizeof(u64) - NR_STACK_A=
RG_REGS;
> > +
> > +               if (nr_on_stack > 0)
> > +                       ctx.stack_arg_size =3D round_up(nr_on_stack * s=
izeof(u64), 16);
> > +       }
>
> I'm struggling to understand this part.
> Why do this when this func calls more than what callee passed in?
> Looks fishy. I'd like to see selftests with more than 6,7,8 args.
> Because only then this logic will kick in?

Your confusion stems from the naming of "incoming_stack_arg_depth" and
"stack_arg_depth" (this should be called total_stack_arg_depth in my
opinion)

So, if you see fixups.c

                func[i]->aux->incoming_stack_arg_depth =3D
env->subprog_info[i].incoming_stack_arg_depth;
                func[i]->aux->stack_arg_depth =3D
env->subprog_info[i].incoming_stack_arg_depth +

env->subprog_info[i].outgoing_stack_arg_depth;

prog->aux->stack_arg_depth doesn't store outgoing stack depth, rather
it has the sum of both incoming and outgoing, that means if a func
doesn't call any function with more than 5 arguments but receives more
than five arguments, incoming_stack_arg_depth will be equal to
stack_arg_depth.

if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_depth)

This check is for - "Does this function call any function with more
than 5 arguments", if yes, is it more than 8? if yes allocate stack
space, otherwise stack space is not needed because argument 6,7,8 can
live in arm64 registers.

I hope this clears the confusion.

Thanks,
Puranjay
