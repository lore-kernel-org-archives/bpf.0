Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED78383C60
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389425; cv=pass; b=Wii98IblNvGJES5ig4qJA8UxcFS6Bi70FPhvtYHHfqCqOJ8V0CK5366n27cOM6PkreMp9x9TXqOO9tzxhZKa78YnHaeYAL+yEIR99TYG6mO5KVyLc+EeH/Vvvv3YPYUmF0iVj9ZecpUrAruiETqvgVyeDn2oJ9hWXbcI0IP+kv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389425; c=relaxed/simple;
	bh=06NqT5mNH8WH5XHnqPfulrse+8qOJRQeIdT9XEWW/yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXj2xzoPYCJQlb2uyaxpC/QsBPttbigFcgTuDNltOA0C9ocJ0pHOy9wKlyApE6ekob0bgFY0KcNefwa/3y21nEfaiaYhFWk5iQI0F31ifZXJTR/Ku2Q0mNaX0jOKsM1d1L4kWg2SNfle/l16H9Yv/GQhuE6eGy+Im+S00qwPrwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS8Kb0D5; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS8Kb0D5"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so3252742241.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774389423; cv=none;
        d=google.com; s=arc-20240605;
        b=GN2KNYsPMgaQGW/27epMB6oqppssVT5zP5iq1KwQCzYHwuRDWbzI5ux6zLecKWyyfX
         j62/2tyNM0UnFjprdbiFeGUfSt9w3698YLagvUs2GIlBQ0RerihDX6oDkgVbykyxUS9v
         hyzE2H3fX3stSaYQZnRfuSD7UZAZnRCi2vrr22zx0BcoyoltVuKRk3AxzbdVmCjD3+xi
         NCNrRtE/lYaIz5tnJCnXpliQMpy6POd6rySjFqnfCIIzXcU+O8mU5RitiSWTQXMOY5Kx
         Q1LMw+jh1skoCoIa3GUVSAZ9hShq94VNNVux+dOtyRyPqbSHQTLPltDUm2IKumvjyAh7
         rBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=06NqT5mNH8WH5XHnqPfulrse+8qOJRQeIdT9XEWW/yc=;
        fh=5tRLknEeTpFAJkwvCbIhxLXFcEJ7LZ6FYb8Xv+KU0EY=;
        b=QqeO3N21fnXlKp3b8OwjdEU63dxOD5U8XuAJH4jmYr8dnwkXyGMkpH3qdnP0KGJGKb
         hP015Thd05+WMlAVpMQoO7SRgfVhx1ijsiVjMwnmMGUip0GBpR3yRCWwBkmV/c089vab
         I1QEIofAGveQkj3ndOcGWVmfJ6fnwFMFUd6+U0+XX4dPDGCTLS5aGF9nJZA9OmtsWrDR
         vNO7Oyy5xgBxioDd2zaclRthvEzIl+w/qYVETfvYGXCLCBm9YNxGKMdRxxPNUDJVLEwT
         /HHa8hVwWsQtteOY/9BWfegnt+v/M2sew+UdcIecUKVJZMHbCJsYzhsReisod3w09r8J
         wjWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389423; x=1774994223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06NqT5mNH8WH5XHnqPfulrse+8qOJRQeIdT9XEWW/yc=;
        b=TS8Kb0D5iCEUOjhiS4GY/vocwaD8C07UeKIBpP1EcM0kZxAvVQcIDtsEtqPD6FuzLO
         Zc2d9NrYrNlRReZIO7R35EvNYdwQYPFDUM2PaoHon5ltWqUq/3fNWJih9OAXN8I3kpw5
         hKziTXA+2yFB94vr0NXmU03xnp7Vuu0rOj5qmOmIBEmlrBOEmw2ihzd9IRoYLtC4XYo4
         7TABVSONe9bAz80zldA0qfR1UfNkq9vAypd+UIsXmuzj1aHQ+5zqN3B4t97NjX4HIw54
         lkCu0LSwr+6owp2qpgYn+aWZS+V7JdpTptSGygnL+tFGTJGgLScOntDrXk7TlxqTH3xV
         de7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389423; x=1774994223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06NqT5mNH8WH5XHnqPfulrse+8qOJRQeIdT9XEWW/yc=;
        b=U1kN+N+eQkkkbcxpx9ultYvOLnjOHMGfp36/kuiDvJpAtLbmilQJYADwY1Nig37q/Z
         txYlU/vNrZVic5uy3bd/JcFnYg6PZlbDhD3gdZ5P9+vy7lLM6FSKZHWZrhsWxJItQyPM
         pXEgJ+vzCG0sICptO3Dqsfqf4GVGmlFQCwHRtFruAfn8yFC7afgiUqTgoO8XVKcatGWo
         6gXDShomzCLGKGBD0z/xKmZmT680zLq4SFhNU3Fxj7Rv3htZPjHGnQsoQxi6a9/1hb9L
         Vcsmg0HdPx47utXnfF901xdPnaBbU6RnYTPeGFCRblesM8DuUtKuXBTgZzwfk+wp0/QN
         TIQg==
X-Forwarded-Encrypted: i=1; AJvYcCWHhRvF+fN+rssDkA8TVTWNqQZnKmaBKXX0ahFya39tFj7v7s79zxofXjaLXCph0SZVt74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ZzUF1PnTvkF54Ffuis6NQW+qBH/AJcLTPX2+hxuuo9T2QcBO
	PzmY2bJ6XBnaCllPwPf+dSbSTMegzIa8amvcgo8xi4aYXg1z+DKOACKJKcxpeWOeLrjPd5O+H68
	e0DLX5VL8KzWlQdKKVLheQN/GnGevJKY=
X-Gm-Gg: ATEYQzzzvsnQ1cbj6RVIQfPkbrVhFqV85mD6RKmHexDUZSH4yFdpxWi7/ShKePljE9C
	owc98/2SK+pQMuLXdG+v+DcwVhCwSbkVVEP7oCGrmmGZbMRb4fLoysbvYyoLzH10R1MIUmkLH+F
	VU1phqdUdr7rdAUO89Tp9JsHWcc0HuGfDe14H3eKUdOvz7KCKD1rLWbjl1VUjZX5JJyhDsz/TXg
	3wJvQRBE5UFpKM4u055iUkh/oJFMUunO0m1D27cy5xiy/5kAzdoMuXcpzQrEv4FBmjGCx5Lt03G
	1aUt9X18+1pYBi46TyiCKTxWH0nSebMnaNDunFCrAA==
X-Received: by 2002:a05:6102:2d06:b0:603:1a8a:c84a with SMTP id
 ada2fe7eead31-60378fe89c2mr803487137.2.1774389423093; Tue, 24 Mar 2026
 14:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320162336.166542-1-hao.sun@inf.ethz.ch> <177436741379.1084685.742970732574986773.git-patchwork-notify@kernel.org>
 <CAM=Ch04dJEf0_1+NeO1AJOBwKhQ5hcQsionMyyxuu1h7Nmj_pg@mail.gmail.com> <CAADnVQKAb-igkV-7htfqMxFhui+utF24T70pbeWd4mwcXWQ4pQ@mail.gmail.com>
In-Reply-To: <CAADnVQKAb-igkV-7htfqMxFhui+utF24T70pbeWd4mwcXWQ4pQ@mail.gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 17:56:47 -0400
X-Gm-Features: AQROBzCzEMFYN4eo7Ah7yrf83vMoLcCwUMebMsk7_Mke3croJWX60MhwezeeysA
Message-ID: <CAM=Ch05c5ptrNHjKHWppynU_1rfsfZsiLwK111h4phrs_u77PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Simplify tnum_step()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Hao Sun <sunhao.th@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 5:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 24, 2026 at 2:33=E2=80=AFPM Harishankar Vishwanathan
> <harishankar.vishwanathan@gmail.com> wrote:
> >
> > On Tue, Mar 24, 2026 at 11:50=E2=80=AFAM <patchwork-bot+netdevbpf@kerne=
l.org> wrote:
> > >
> > > Hello:
> > >
> > > This patch was applied to bpf/bpf-next.git (master)
> > > by Alexei Starovoitov <ast@kernel.org>:
> >
> > Hello, I see this was applied. Just a heads up that I still had a few
> > concerns regarding the
> > commit message and code style in my last reply. I think it was my
> > mistake to include
> > the Reviewed-by while still requesting changes.
> >
> > Hao, would you like to send a follow-up for those, or should I put one =
together?
> >
> > Or Alexei, do you think it is okay as is? If yes, we can just leave it =
be.
>
> They read like nits to me.
> New code is definitely cleaner.
> As a follow up better craft a targeted selftest and explain
> your points in selftest comments.

Yes they were definitely nits. Makes sense to keep the
code clean.

The logic is sound and verified, so I'm happy to leave it as-is.
If I find the time to put together a targeted selftest down the road,
I'll send a separate patch!
