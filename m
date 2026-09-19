Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31817366DA3
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 05:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794964; cv=pass; b=dQKYuLnQhgLl788YRiOjFttxsxhBwb6m4gmGTeFFYohFzCV/Rp0AI6uJtkgSrrQBC11M4p70dRRXhhAyjftkfkq8FYNxdHG8aMd7idubE8AZkKnxNkDxRyIGMaCp0szZU+ciG92lDDqa2uV85ifVad43/7A7Yt09GGsnHUgUs+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794964; c=relaxed/simple;
	bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivVnHTEjnTFZL1ZIE79yvKzWdXcL8Rl1iv3t1967i28ehsOCujGmqTGS6OB93BNxdtW3KK5ybdIIlH4Xk+UxxCMkp6En/HABZQVYB4p02BoS1lqZVSvLjZAcBE+iPQMLzKeFT1pSm4ZHKY50ISR2+uH3oAc4dD29/L/7I18rb/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZlnxRLY; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZlnxRLY"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e211a3so1280046b3a.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 22:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789794962; cv=none;
        d=google.com; s=arc-20260327;
        b=eJQ9qbi20HIgCqfE6/syXKI9Yo+HvctM6SOFeQf49bBM17VXCOaG3AswUZsOZu1noI
         T2xQIQ9EbfsUODicNhPSVERdg93W5tuop+2wSAGEVRMPTwI5jBQWIn4YyoFCIe0fnFW0
         Fo0ZxbhQVzrcQqpkoHy32sKtiSyn6kZr16yYZ56fspxJ2iqPafoimV4WPV7pc9LxUYwv
         0e5NNndfb5SKZ2pYnIiH3M5PuDp4nv9GvojbBe4Pcyfc0fBFbo/r3Reo9nSjEvUWlWfS
         KY3TPPla1vp9kXL5vMcvZot7Nv8qqI+c/xbe+TEyRZ7WJanvtzPIxGVZY7RJG8p8Z+fC
         dd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
        fh=tsUJolupkqsvbGZrSFjeIv7evSv+qu+5fLLjsShz61c=;
        b=aZYvHoVGw29b019vRwonM+N6xr6eNNmnpIEZDnqs2BRem24S00Zxc4X1XgQyjTryww
         RwIJI4jld41R+1uF129Bc4BvHjDz8RsYDvIUjBjrTgKCTr7mH/pabFB5kncB43o7dNPA
         NcSEQt3tpup9p2Vqc4C6re3CKp4U8s8sZetfCbMXzMdER+z5/q3r5tCj8SPOEkYHqS4q
         i7m6SUIpgxTLMvp0ec4i0EVSQIM+6OT7yP08LwbQKwWfbtmcyyD3csqe5KGrwdWESD/Z
         ymtSDN9vUb8KEA07emi4Y1qKJuK6hTeanGJqIitD/dZY0oeLILmE0r87PF5fI3wLx7BO
         XckQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789794962; x=1790399762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
        b=hZlnxRLYYuhq6rOtbSY14BCpjRI0nniuC8wpAjxDkUfGQnbn/JacPgH0b/eS657MmA
         rxJGQbcOrGEZeUHGa4wvg9vvePe4KLbscy2nA0xbIYWB6xMpBGS7btTwOj+qC7UisC3K
         yUqkSs6aGw4M0wABWvAG+1WSSgPnwW6eObsbi9Bzd0idLIIDA0agDvJ3K3WMQMOAXzRd
         1gT/blG97Dze/aLGxocV6IXLAaumyjmDORSrCtDKz9DTzYhWj/W+MAO9C24qHhU2y/m4
         ZpKniXKOeJgOgcc1NOAz5EBtCNBxBQWAU94mQ3mvKafMItGrvErJaJdoN3bT1dHdv8Qn
         H6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789794962; x=1790399762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgMO2EdWYeQ9dfAK0ocaaxzydOr6VXQniQxvZT7Dh/c=;
        b=YpEc83Dcpt/8/hXAjNAtLNxI5NdumVYBzYY2sXFT69Gsb/fR2J2SWNT6F7lQewdKAy
         WY9V0XOUPFlfmIcopO2GU8Ya3iDBIezQ3P9OEuNPFld5+Su9Rk+xV7qsIcX6pIdvFYOU
         kTqFV0MaUE1q1Jvi1okuadBGmSS/1J5cIPegivBGLKBCmfbAv2qJ+H3QqPJ+/sZlD+Ao
         4MtoMsQvWJHwigab9ZWSyi1Q3YEgRP0tpldTH1ynUKDVfLFSucxvSoN3g9qoOlh0wLAM
         6W3lKS60PsKDtX3HDWyxpZfkSpU7/nPbAUHK7nM9DTYyYap6CzfirtL+gQMisZz/12u4
         3QlA==
X-Forwarded-Encrypted: i=1; AKwUvByzqy6qDsaXZYaq6dvV2/xEpqtiGlrjsTYjNYM8dxB84Y3ytbK9O+iqAFmL5Ku2NJRR00Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kcs7nodRuDMeAotQbXoyzWBlzknr1PYBMDokUiWqjGH6d5va5F
	f2+IUxc9wCKP6Hmxwg/VtHpW5rgi8vWskTspHf2GuMxivsab4vVM2tU+Ivz9rHCP4CyJcs7P59y
	N//DCAAMXWfE7mtJeelEZMK1K8+ZW8H4=
X-Gm-Gg: AYBFou2kumaJNyS8/M/ow/HWjb9gv8RdB+i92AUbbxqBjkWITLgPUjw8zLAhyo6o8Uz
	Zt2QBA70gsEUhuwdxDuXwYEf94XMUpWoRsCGjRN1anHLIumYeCKEnOzPH6b2q9UT6sQZOAYAFS8
	ZT0ZpRO5PP9veyPxp7A5k6AJtVvtDLsV7msmOv/aB8Wc9BkJXI9IfXZTgUwuh31nBWBlLWl6KNg
	24oqjww3mxpdPkU9fNqT1sHLCEea1ULeHD+2VNRo0LEN1JDHjfzfHaWQJ/kQzn0yygojprd4Hum
	g5wOpsTcnAd/m6nYXcvkC8VOfidUUToWk2U3NbSBQwQ+DjC2VfZQdypAat0Buee+sMytsha2yF6
	oKtzuFQoQqFGEtqNbbxDHG9cjVv8qe1l+ET4KARruZ9P3r4ZcseL7aIxkvnhaJNJ/hpXu3bRBgw
	==
X-Received: by 2002:a05:6a20:d703:b0:3dd:a196:9079 with SMTP id
 adf61e73a8af0-3dda196a86dmr2664642637.67.1789794962226; Fri, 18 Sep 2026
 22:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-1-puranjay@kernel.org> <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com> <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
 <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop>
In-Reply-To: <ede9d515-a103-461e-8244-656af641c6c9@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 18 Sep 2026 22:15:50 -0700
X-Gm-Features: AcwNN1XLF5-45PxpYWROshnd_TTN-hd81UJzSUteWcNqwlQM50o1v9bv2Lrt7Do
Message-ID: <CAADnVQ+bmTPScUBfOtD8Sj9H8KjAqU2-XocFsP3G2qgNA7q_Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 9:03=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> > >
> > > I tried to fully embed structure back when implementing bpf_task_work=
,
> > > Alexei rejected that approach, because some of the structures (irq_wo=
rk) I used
> > > are not in our control and might change. I think this applies here: `=
struct rcu_head rcu`.
> > >
> > > Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uN=
GZ3OBQh4V5Zt=3DWnQ@mail.gmail.com/
> >
> > I agree with your analysis. Although struct rcu_head is unlikely to
> > change but still, I will change this to a heap allocated version where
> > we only keep a pointer and not the structure inline.
>
> You can always use a union, as is done elsewhere in some cases.
>
> That would preserve independence from the rcu_head definition, while
> avoiding the need for memory allocation.

In most of the cases kernel internal data structures shouldn't dictate the =
size
of uapi struct, but in this case
struct bpf_rcu_head {
 __u64 __opaque[8];
} __attribute__((aligned(8)));
is the right trade off.
I cannot imagine how rcu_head would grow from here.
Two pointers is what it needs and it will stay this way tomorrow and
years from now.
The rcu logic needs a pointer to callback and ctx. So two pointers.
Let's not introduce memory allocation for highly improbable rcu_head change=
s.
