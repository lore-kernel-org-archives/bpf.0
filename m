Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4DC3E4C86
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453711; cv=pass; b=q2GpN9V6zE//su/GCQ1ahQeQ65RhRYh+cPt3hJW5BFSwxs0Yh8iaVDWtq7jk64ErfWtYthhhV6o/itkXoorjPQPr5OSSZ5kB/fz6PanO9emu4dHI1GV/B19/q3txHd5c4HXTB2OyFkqez/9efF3n8s+q7zhOxGJ3N8XKGM8jt14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453711; c=relaxed/simple;
	bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xnay0LqCe2fFellggO4NnW3hhZVUJV/7Mw7fdPkqO2vBup7xPs+fi66LObRW3e0ZxMYsdcth/8LqfuJ6pSoGfsqZeaL2s8+kWSBVGRSA1fn2RjuNVPp5vgfziUy27QoGoifaOKrusUbYpiZI67dUDnuNTs3ayOyA5C6kh1XNPpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9STyh2a; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9STyh2a"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b87970468so1364440f8f.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 08:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453708; cv=none;
        d=google.com; s=arc-20240605;
        b=aL4Tjaed9L7dyVRR093PDtZ2YG6NlD13A27YJsLM4nduodqvcsFcg1wQxhFZfve/W8
         gRlU6tLB/i1FXhmdmSz/ZWvsomK5M56XUjNu4C1XScgzIa0m6Hqo8hkjWL7od7zdqhSx
         xiOhN8I2sGN44dI1RwvWeBJSO3Fnk77Eo24px7KoXdvoUUjhscqnCD2J7xS8+1iFqaDW
         HrfmI2ue/khmieWUctTpAoKe8EsBx3lKGptjLSgY81avHq+e6KFrHc3GY2ozEyblscLF
         dT1+98uNF1ZRF5kScM8vxmHWcOkKxnD83GIOpMJCsXUcnvoiiaIJTTqXIVnq5IpeLlGB
         bAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
        fh=rgVpFvqJlCbZVq6RPragieaf95Dde/Ch5of6Coy+M1k=;
        b=goeRa2SgndSI4+UJsC/YyFhVI1fR4kuxCBnYJ2IlUS42HNC7RDoFJkVQJBdoaVorSM
         zv/SeIy/lHIDRxwkLGxTO8WTZSUozRLRZUs8BbvGvlwJ/VnSREY5n7muD8YRSfpQvPsK
         YwUgULDoqiVn0uAjQzkhc88z0aqJevgGzvOhr7blu12WHW/Lc6zR+gcEPysI1WYBUA7O
         doO/OBQzyrbhUoTlOuws3cm4VF0wO6KR5AN34iTJ31c1RhFLD55uVJxpnz3PbW+py6QR
         kHyUmtOcnNqXTHXUwfkWajgaV2Q/fLjq4764h479aJ60Yczwo28JgYePscjX3TkPPHDv
         XGyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453708; x=1775058508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
        b=R9STyh2aUwHqe5sK9AbQlCJuK//hCu4NDTPPxpNa6Tg3Y5NEaY3PHqGySX+i/3rJKy
         zXDpaSASz/NZBkZUgQtnOMOrKRWgRW2ViwAyGz+GnViGLno6J11/YlBkYUwN4bLk3w4y
         dia/3Q7rRfqseflp/VMHTT7XTJkia5WDq8oCailSFBfYgtPby6KTDLBFNowTCKdxdjsB
         Hmibls5hdbWdoedqBjSFHcpXW1xjePl3zEywpBgBNAlszsLNinklEI4soIiG+y14fyUq
         1b1gRA+FdawYBlAz94kD0Ev1G6Y4mxmEyrya2R5wuL61sabGCTpBoyUqF6kt2iAjCv3b
         UBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453708; x=1775058508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
        b=JTSqks7Rxsv2u9Ye01PKHg2vdYgRBfQ0FXmoUzqCLT8fUQ61hfuRJhJfwn78AihUv3
         rA/Nis1x+FdsvAT+88Lw8QZiYTwZlcwMQrVtEH2SpB4I+DOJuRUw7TPJp4EK0ONPWLGI
         Wnup0eJp2MrnLZfWSMMyt0qAnm2pkprSKMN+tSWeRWY21BkQSFrqsKtVFm5sarNmOMey
         zlYfiuL8+OdhrM6mjZOSWriCiPHcs1c/fw430WYJYHtXhSR0B7gpvOitsZyt+1/D6umD
         /3LuFYa4OajeYeDzUDfVqxv4A+yjDrjaWSb1rdl0hyPsjU5MxWXOlQEV82TH74CNU8XV
         dtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfhQhlAzFYMjmqJb1ugLntrWXeA5dl4ePLUxzBYZ2h3kYiwab45u3Yh3n5Br4gXv6EhTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PAvIYgBPGd/cYBJI4EwNaA2EbCDrFbopHdsuTd/0R1EYQDfM
	Wuivu1nrD2ar+h2AD4uWpIoZXO3HmK8Pl8tTVS/iUPMjsQjOCl1yg3vCkFqKF4Rjuadz3f/oV3f
	C5nHIpqPMjGvAPJwJ8Ft5EgecM+CHY2g=
X-Gm-Gg: ATEYQzxpN+io1UJwgxjSZGMU8pk+DIWskuQTmYOzlbYLnMZ2AtEWDkrdKFQLbZuSUTD
	3X5oZMy/tqYA7K9THVkNNRlcLchBftNLCzYbPQHhW76o/UtTR4DQ5wwmbpjkdR49ELQMbE8GOJb
	RaPLzw1EPTnSKpS8zPoGm9jXyVpuaSkIiJ3GItOf6hVQPo9DoAtGp/OoolpkaUJ7RLERvnfsFLn
	7fLdE9UuiCEywrcoKeu/qMiMVo6zeLGAtOrkY1FifsOWAS622gIqILGpwcavXAkYjsOehYMNp3m
	anuYsp4IUzTFwrkXosYQBepH1zsC3AatnibazLjiUf6TMolVe7oF2cP+nhypPTYVf6LnkeG83GZ
	BchURer/+IN27KFw2wHqNnmEmo45xPV8GxmY2
X-Received: by 2002:a5d:584c:0:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43b88a88a42mr6126841f8f.31.1774453707977; Wed, 25 Mar 2026
 08:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
 <D53376BA-4772-486B-A18A-6858C1732723@kernel.org> <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
 <202603240919.D248D71B48@keescook> <CAADnVQK+hMnUkv5TfOGfiVR+nf59bBX+zaHOvcp5zSZTpdJB_Q@mail.gmail.com>
 <202603242109.171584E8@keescook>
In-Reply-To: <202603242109.171584E8@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 08:48:16 -0700
X-Gm-Features: AQROBzBhIPVcTb_sCgIW7TYVTP8HJyUSk4-aSn1FI2sOIl1gLgUg1BW_DiJK3tY
Message-ID: <CAADnVQ+RfMaNDgoyCZ6gUJX-c+_XYG-_mFEuNM5xJANFs9USbw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:10=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Mar 24, 2026 at 09:31:09AM -0700, Alexei Starovoitov wrote:
> > And please keep ignoring it.
> > It's not broken. Don't fix it.
>
> Okay. I'm confused, though: what's your plan for when strncpy is removed
> from the kernel?

when it gets to the point to be actually removed then we will deal with it.
Until then it's a witch-hunt.
memcpy(,, strnlen()) is no better than strncpy.
