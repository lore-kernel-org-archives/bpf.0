Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607999;
	b=maYrO43U5saL1FfiDjwykvTKztc7hvP53LfHN5WH24Ow4OzQZ+rBF25sCestuH93b6bI
	 m+VjSIw/ADZXxlobbWyYofZyGP/Epzx145gEb/rEsyvCdrAnwLryfKV5hWtYh+gSjdqK5
	 MToD1Za+Cp4auKBPv0ao27UO92sIy4lpTMFM3a6QnxbAoNNHKyJGzpASkyOapG+7sKWad
	 bOMzdvWczsxrdAMIqvKUsb274+dh2n4Gjjxr71co2+xaSt1QrDz0LUbQCOtLvsuf+6US7
	 Pn7Q16ll5SCgNAGEN1aBo5av4aCg7RXj9FDHhEh2TsfSp05EMYdOMOP/522DsG+/7MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=FXnb5Rj5qfGts0gZYr/0A/mHLeDZB3dODomhDKpmTdk=;
	b=dqhfVDkFODFf/jd74z8xzx+t2KVN49qe37lu3NxxpQCPmRnpaBkvXewhu3waUDs30VH7
	 uQjcZePlHRu9KxQveEcyn9z+D4LF94euKAsbjd5bPzKa2pzYJPwPtdoXBrkP05nZdQ5Bs
	 Ih2Zk3beKTyr+tx3wq/pDm+g1I/JzmYJ18regVb+G7PvwdDrlOS3H0Aidu3ZYXnPxoWyO
	 BMkjkIZC8S2iMQ9Oyjg5jr+0mz54kKUuhO3PeHdv2VmMys4AcDz/ZcwwcO7IYs2yGGSS8
	 owN23oj6k6oUg6+JYxhnGg3r7zWHzd8snBmcZ4cXFcxn3GOP3nOR5xasqguswGhKwFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="D1i/BJq9";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31042606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31042606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D1i/BJq9
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df54150dfso673671f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607997; x=1793212797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXnb5Rj5qfGts0gZYr/0A/mHLeDZB3dODomhDKpmTdk=;
        b=D1i/BJq9eVs8XTcuhNqhkUYYw8TrAvsxkc9Ut9kiL6tbt0z5RB940/ahJed2a0/ZCc
         yF0oL3uN6pWw1lKve4dSejB2JxLl1/QzCYGZNDf4aMc9rPit+a1kn0IK6eg2IL0foh64
         u0fuONvYxKsrOO3Vxw8IiNzdBR/qmPQUXP29NN2IT1i0EObFTwOqkS2IJpvkLdmdUyPb
         vuk6y4jSgLjCEymCqAzmvfkOfD5BMnKf/Ura/Aav9bNR8L+wAOigT/HMXHIO4GM3klfH
         LzKp8O+BPHkxuLTP00Z4fPrBD8XtGxB3FNS/ML7ASlVbLin806NRRLngIsM3ETOxqKtj
         oMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607997; x=1793212797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FXnb5Rj5qfGts0gZYr/0A/mHLeDZB3dODomhDKpmTdk=;
        b=lPrC097IjAHPxWeEVVHHnK2t1TV/CBGJrPvUZTrCnO89icXKTbU8lWlpQVj6ve47HW
         UKWhV8n0AZHgLIlufOp0oF7FLkchOVrG2IhQcl4EYRfnhG81nd1mRnyFkW5lc4ibKTHl
         +ffLkJ5Ta6fGH0VM0iwT2ijpC8xXIueX/jAul2/sZvr5HU+uJoLqDAOmjnToeDF9IMTH
         uAU4gn0GQe9XtuP1nmOae1BzbTYkszvb/10JXMeo3tvDZqU7BUqxhh33GShxC+JenXd+
         c3cVu4kQpQm/V/RZSh9gD1xlnybvngmakysiBWPhGaiCLPuQU/BFpLRSHs2PzgtqLp7a
         EkTQ==
X-Gm-Message-State: AFq9FYLZ++g1EBuq/YuVfb+jytD61xMxIPi7fTdKiFI4yLDmrnFmXka5
	5sh/7FcCQVoMN2LcLd/hUGCReHexQUTL09hnEApXyif8EqnwFx5M48pj
X-Gm-Gg: AYBFou0bK6k0k+8GdWuyVg2IPF1A6YwnwvrpsNiBkJstJekEqGyZHagwMxQ6izWU7YP
	vLBjaV5FwKxbkZFbHNcs+Pf/yqEXgKbt+InDM87h6AFxs01+Ej1/kyBMiDGalnDv5z+IAhLmFec
	d7+vKhX9QTjeA3O5BawRV8gAoLzVoSRUsfTtFWXAPA5V1u76+0ufJxib5CO1PA+0faBRxA5g94b
	O2Wvbsg/9yqJkzzVqeTSmfALxLHCEuIdDN8Ths8EluNyPhHpms/b9IbpVGkV+4+k7lvgDgMcYxh
	bfDwRp5BaEz69cMfVru/Qo1b8H2KLEYuWgoeH1bmdf0jlquQDG0u07jTJDsrjWG96SALgoa6Q+1
	RqZASrDht/4javb+u0t/cpifI+ePFJSrIeEb1S7NW2P8GzIUoPCmAWwNI6fk4CyYigOthTN2gji
	8WadraJ7tNdRIgqnk41CtW4qTuupd28fQioUsSP/UeAY+xuni4hcyRO5VV2EN5se35n7aIVwIdd
	Uoi2vPWajIZStfuxA+sptPdcymWbAvbNKdz1QLHsguQz3CiwGWHpphWgTcQA0rI5a9eGZ8zSFAJ
	LN8KHeGCLZiXBSzidaldeXNLPxEpWyEfh/39aqM=
X-Received: by 2002:a05:600c:8b4c:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4a1fdd15484mr62637735e9.18.1792607997368;
        Wed, 21 Oct 2026 11:39:57 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a447c8sm10641255e9.12.2026.10.21.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:39:56 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:39:55 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
	netdev@vger.kernel.org, sdf.kernel@gmail.com,
	yonghong.song@linux.dev, jolsa@kernel.org, kuniyu@google.com,
	memxor@gmail.com, emil@etsalapatis.com, almagui@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
Message-ID: <atkG-5eqB8LfVxSa@gmail.com>
References: <20261020155848.75711-1-mahe.tardy@gmail.com>
 <20261020155848.75711-2-mahe.tardy@gmail.com>
 <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com>

On Wed, Oct 21, 2026 at 10:56:23AM -0700, Andrii Nakryiko wrote:
> On Tue, Oct 20, 2026 at 8:59 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > The motivation is to plumb more of the socket API into ksock, thus
> > supporting sendto() in addition to send() which makes a lot of sense in
> > the context of UDP sockets which are the only type currently supported.
> > This is useful when ksock is used to reply to specific addresses or send
> > to multiple addresses.
> >
> > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > ---
> >  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-------------
> >  1 file changed, 69 insertions(+), 27 deletions(-)
> >

[...]

> >
> > -       return ret;
> > +/**
> > + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a remote address.
> > + * @ks:                The BPF kernel socket context. Must be an acquired reference.
> > + * @data:      Pointer to the data to send.
> > + * @data__sz:  Size of the data to send.
> > + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NULL to use
> > + *                the connected destination.
> > + * @addr__sz:  Size of the address union, ignored when the address is NULL.
> > + *
> > + * Sends data to the specified address, or to the connected destination when
> > + * the address is NULL, best-effort and nonblocking. This may sleep
> > + * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
> > + *
> > + * Return: Number of bytes sent on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
> 
> This would limit API to fixed-sized data only. Have you considered
> passing dynptr as a source of data, so you can send a wider variety of
> data? I don't have a strong opinion whether we should add a separate
> API or convert this one into dynptr, but I do think that having
> ability to work with variable-sized data is super useful and should be
> added early on.

Oh wow this is really cool that you send this now. I was working this
afternoon on trying to see if a ksock sendmsg() would make sense, but
with these static buffer limitations as arguments, it actually didn't.
I'm not familiar with dynptr so I didn't think about it, but after a
quick check it looks like it would be a good match with the ksock API!

As I understand, since bpf_ksock_send() is already part of 7.3, it's
best to not touch it, and having a simple send() available with a
fixed-size data might make sense.

But since bpf_ksock_sendto() was just merged, we could make it evolve to
use dynptr perhaps? How much time do we have for something which was
merged yesterday to be part of a release? Is it going to be send with
the 7.4 pull soon?

> 
> > +                                const union bpf_ksock_addr *addr__nullable,
> > +                                u32 addr__sz)
> > +{
> > +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr__sz);
> >  }
> >
> >  __bpf_kfunc_end_defs();
> > @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> >  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> >  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> > +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
> >  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> >
> >  #ifdef CONFIG_BPF_LSM
> > --
> > 2.43.0
> >
