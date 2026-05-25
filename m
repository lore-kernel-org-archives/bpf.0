Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC392DAFBB
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735428; cv=pass; b=itxdXc/+Cp8vRky3kkr3Aqqzfu0GSzq5O+5NsXFbS+chfqR2MQJeg7eP4EcrbIzqN488hqGUlqmw8+4C9lYgVIHKKkgTo0QP2J3npvw5QDgHVnjngwaLbvqgSrnbM7zzPSObCLRpiP768SvmDRTpkrgkjFwAoXWUQmPH9HrnDc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735428; c=relaxed/simple;
	bh=XRSAh5kaVrEP9O3Q+Tnd8XqIjC0TIqhy118oZx7RfYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmaLEOM4QiF/uEwbO74KgFSovzw/qaDO4jJsNgm2LoaAygVvLEre9gI5Fjx9evFtEupTEzoEAtA+bFGj+rZ8ABb8c783PiBeRvwM4odFdSxfYq3DJLor1+8IzgA19zhTEP4RKsqxlcBFyvDjq5a7z4xdEcQ7D4ysG2d/wANeeV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpz2uYBd; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpz2uYBd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490426d72f7so31185185e9.3
        for <bpf@vger.kernel.org>; Mon, 25 May 2026 11:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779735425; cv=none;
        d=google.com; s=arc-20240605;
        b=ZA6UxTJQMyZofzAErqGmh43uaqAF7ZYg5Rd3tRDELTYG2ZqlnmgL8PPDZvfFsQqCOP
         ohsgXhRB6ZkqoWL5wraIFp7puSGEwlVFx9bWqoqpq9OrlHTIJ6QV6nkhLjCS+0Op2uvE
         WYuXc8sfEhDciUu206mhNFt91S1V7PPiv83LAGTgGIe59TjKI/q40RC+VzkgL0L0HmE5
         1zaX8Ktq11no/knMyh1bx8tljR06kvKs+MN7ZHc6fau2kitVOIm9rhgHOvkCWrJFY3bW
         dV/AtKaok14ElfqQCZJGvzeX0fEVKa1udjA1f2mmdwcaIfBgzXAmqGSyhnlh1AVUla+F
         4aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZUDg9BmpR8ZyuH0bT40ooltRfnMlL+nDk1jBlF5K26w=;
        fh=E/RnMbaSb9B1WybYy3Z/eQ59SsXmFwpxmGw1QEou/7M=;
        b=PXPXXlMe7uoyglLYFJ1KF5y18IEJOesyMf6JyRUcyTwY49dYUGDNDdn15olodxvf7a
         xHs0SZHl4+0eLI/n5LbXKHc4m81uS7e75bPevsVGsZzs24TPoY1rzbytW5DCu5Gso0Z4
         HZje0GtQPXZcp/hng+8UdNhgiDkEp3wggZtQkIrIgSPLYobRvvEzM4yF1vSU+nWoXwFf
         MVeFfUbG7HozS6/FH261medvPbvOrRK3JuQKiJEz066lvO8WJK2tks/wrcQtMaPyte3S
         JuK+G56rFwIXfMsNSzXkF30zJcYjOxx+MVpcepoxCcn35RMHiagnyEiB8EPGEFEyrHTD
         b5Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735425; x=1780340225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUDg9BmpR8ZyuH0bT40ooltRfnMlL+nDk1jBlF5K26w=;
        b=Zpz2uYBdW77WFf75ro1dBZuNifuc1A/2Dw/xwW2AWDrRSCGGNTZf/1wGcBp93yFKR7
         G+v1EQw1gyx3taxvZogCXYr0FCjUyxwWwOKqnMS5HP2/RFKM5UkragIhBtIqCvQc7MQl
         yV5zkHwdieI2Jxf8byIklJK73EEjAruvA0qY52POLJNOb52wo9haLrnHvU0n1cHEoJ9X
         rmGZBoSfWyRM1a/Bz7XJ7krs4FDOF4H4t/VgklpyrxW4dIorqtZDxEjM87mNDuuu7ivd
         BMIBHTmL4iKcdnFoH8ELjQgx5oC58ZiGtr+6ic2dCEN2wzHd+wgcADcU8nftfkRK0VeU
         bQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735425; x=1780340225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUDg9BmpR8ZyuH0bT40ooltRfnMlL+nDk1jBlF5K26w=;
        b=IaqI5D47yroWH0me+oTPbDisUo1miwGvL6E33/9hNVY7vTtDFBnSocCZUSyO7emRa/
         6z+prA7BjmH8pN3ByRGnV/WX/MDjJFrmuRmpTk9/l71S/adDahPZ1FA7ILQHc6hd79OW
         XCjr2l3lqMMiKbGe5bB9BfY3Wr3/Lmi4ZQ+bxf5ytXhFwhWkrsAODxP176u4w2taEIZo
         AkbjZ6pi6nxDFsNn1a3QqzTjv48jCimL4mGfOQd8PDK566RkR70zgO1GD0WM7d0AnXDX
         kC5iyCPdgZLlUuFmj0jcxl83LUfUviVYQEXAwbEaF9aDBsXrYB2QpQLuin9fwVthP1cg
         xltg==
X-Forwarded-Encrypted: i=1; AFNElJ/UHOB7mkRRc7i28Xcpn/9xnCV6YDkA9sYlHuEJSe4JtfqFATgv4IWyxs0jhIDKEOUMr8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeS6roeLvMTZOVUpOdKIfxuuI67xP//UljTxfb0EMnLYLoaJgj
	lePUMmtA8+D3RIdffj0cDvtJGSx56jsqZCGqn2tsYoALLIMPkwfAXPnuLow5hWxUhEhyQFvhx7m
	QIk6IsCIfZy6uIVJVldaVOtQ+gsTrgks=
X-Gm-Gg: Acq92OHcQMj4yXI16eji+gDtHIqx1idoFa78EtVzScp3YvvFrtJM8Yt6FvJUjUHB+nw
	zpUmSTXW6qPBSymrMxv+tb8WUPyKd9I0j3OGMT9zvMkrJQqK9e1oceTSgfIF6obDX60R02pKzbk
	an7h5erSPlbCJ743ycV7wfHc/jV+Meh82sXjH7iSp6srMBZts+6KY5uvsyKfozjBRibWXambdRV
	MLmCD+PX4HRgskBqS661HfV9TpIaJHwUnLs2ClVx0m2M78wpKN6QvT+tDQ/gFan/wGllnUsCph3
	SnPiPL4Il8S67b/FiWlAXeUMW7JsTuGVeYzA7A01LHEE6ZeKMozAbQzx6TN34b1pR5+KZpG5S+h
	U7Oo63F48au5MMMubzS3Nzdh6iA==
X-Received: by 2002:a05:600c:4fc1:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-49072aa14b3mr15431835e9.18.1779735424528; Mon, 25 May 2026
 11:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522025854.341647-1-jiayuan.chen@linux.dev> <20260525110303.4121f19b@kernel.org>
In-Reply-To: <20260525110303.4121f19b@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 May 2026 11:56:52 -0700
X-Gm-Features: AVHnY4JhZ--CeC1sfmDhn6orAED0FCr8ggM1y4msArMBO3eZWeUtyax74Fh4ptM
Message-ID: <CAADnVQJ2bjT=dYsBM60H=7BZwSGVupCCBPR7tz2+j_+g7EXXmA@mail.gmail.com>
Subject: Re: [PATCH bpf] net/sched: cls_bpf: prevent unbounded recursion in
 offload rollback
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 22 May 2026 10:58:53 +0800 Jiayuan Chen wrote:
> > -     if (prog && err) {
> > -             cls_bpf_offload_cmd(tp, oldprog, prog, extack);
> > +     if (prog && err && !is_rollback) {
> > +             cls_bpf_offload_cmd(tp, oldprog, prog, extack, true);
> >               return err;
> >       }
>
> Doesn't matter in practice but for code clarity we should only gate
> the call to cls_bpf_offload_cmd() not the entire error path.
>
> With that:
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> I'd take this via -next.

feel free to take it into net-next directly.
