Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792534217;
	b=h1dCbVpVe5drbmNnkezKreyPVqESKqVSjYbIn/Drvhzpump5taS2b6RWXTS/e47gBPgR
	 qKQ4AglQwJ+4/1mW4N/rv1z5z1ClTH04aNtG6aE/dJ7J7gXWR/pg6/BHmPleF4zTQWvtq
	 vCAzYwqeYrwoWgjrOxY5Ri/7clrT4oJiG/R/HdjMV01uH7ypiHR65zNzPp+JxGgL9iQrq
	 OdmFtFZ0v5GTlulPcnSHbvsLx265FSwl5j/i0X6uuGaE2NOhcm5AnfizAzKXTdyuaSazn
	 Ek1YL76HSG6koOzZLXfSZXoJF4hoiQ9tAEFhVNNUh8jMHQjpZyJLEIXA1BhNH1+hKsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
	b=VR3U+GwCQ3Zbu+ukHahkrGCiQcLhtNeU0u42HaB96t0w6ZPWvKacXE9g+BcS5oYkajh+
	 Fy08IjgP6pz9+OEq8L57qNe5mbWbMJ68mgI9cY8253p1hzHQJehXTngMOK5K3qfzZ3Rhl
	 4NSvjXktjjlheGleGkOAUukhnAfnEoU2dj/V972snS+rb93V84uO9/RLvdvWg6SzpHM1x
	 SJMZWLaLpVQO+R0B4w7sYl1pudfY+RoL/HTlcEppmSJADFGN4/bQwTLfsMtzqZQN2SwbC
	 OtzR+cODxLJTSQeXK/gux8yP9hDu8mFHsIZgGgaCKJ4wxSEl+bvbR85/2hU8h43V5lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I9foUfAp;
	arc=fail smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0C606A31F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 22:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C0C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I9foUfAp
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2073a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792534216; cv=none;
        d=google.com; s=arc-20260327;
        b=JAUNsyx0PGcxTearhqVeZ5ArYYQ1++8IVi1fJ05rEPYTngc+AevF/bLDTzHXezZrC5
         sgslDHSBATBG7914EUL3tFe1n+DFfir00mNiNT7m99QH3KKNkJ7tvWMgHVT3MB9zbzWz
         6mXBR+IoDGjE3YajRlKY3rcfHQ8Mz8Fbxr28gsgQ5SjKihJwYwop3QeAsuXPm22/DLEN
         58BqiSn0Bz+hAbYC4dDskWvsdblrrUGs49nNEw1ppMysYWx2sEcHBrCCfdvrqSisa+Ux
         I0uFPlZ639CiVmLy1Zalhk2H19SQ2jXkjmLoAX+2prfP/mVcIKUFm+flQbBtBVWFJaD9
         zIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
        fh=qVX4kns63peEElXDhI24bvvAazVIGifNptbzEfrildY=;
        b=io+8SoxLJBSAINHqPcEn9e/yY5XMjQYn9t0HzWtl2miowWE6ly+3OjtxLjSM2K6WTl
         SRUmyNhktPy2bDRD+SHtAswzjZpvyxQ+mLj1yYfBkpczz1UKqIsRwPKQ5kMiWJdApe8n
         bB7nxXge/NU7nqeYshgg3mGFiIw6LECFzRh3A7PcawSGj++wY+clFTN4pOt6+Aeo+DLA
         RdKWJT5ezmnpxChob/5RDuePNKFa7eXCA7D6grmtWoEA7NBCprGBwR2LFEA506d0lDS0
         Jx3ag7YUKO3ICvg5L8QHw5NWNHHiZmC08E1Ucg5XlJTuQVfFmwp6khXQcIkxIgGiUni3
         DmSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792534216; x=1793139016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
        b=I9foUfApie8pgiZYfjauz9V97l8g4NY7YWU34Ms4vzqIiWzmDpB6SAaaxEekO1Ln4b
         c8MNWhWbPFk/vCJM+YBYqGFY57jiIrZ+7fJImQDXwBRlBeaoLdQ1beDrYnDSzhfJiCib
         hsFfdqtoj/lDRsFzW+hluaVqKh8H89NS+SuLcpfXQNl4HCwmaVmOYfxihZP1pizMtFk0
         SdTKRjQiEYXwKziMKFxUVXS2nBERdwR7JzAPUl/fDLwyJWWOy88RBh7nm8CKPWyw4nuJ
         ROWXaKIaP4ZdS/NK0g0qbrZTY+3srupeCZ3c6wEcJ3wpqH8EuhEd00haIcRuxsSlEVYn
         tUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792534216; x=1793139016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tl7GK25Ew5sPTNDqInllcRJZPijbAjxuuEYSDtAi2Yg=;
        b=korb7WwFHIRt5dllnZDHYbfZK8tEsyP8xmh9kWAhIYRc6qIIpR5vDUrpsNDk+8ZPhy
         aLW85AuNwmWFHMwp1tWz4W11d5A01+MJDlT4RoZDc5GBtGE+q3czJ7BxSEf6t33z/sAx
         d0thtcxFb/jj7R4v6K+v+wt6KcD0zPmAjjMa0uwfppgb5mPibtry/7wlAT8kunv+oPDH
         oDQCgFIsK67FiwAdrw/KwZ2BRB6q1QhV1MCvEW1hO2OBoqgR5DDswB/Z5E+IN6sL6DnF
         LkBpu1fIprEmoFtRHGl1m+z3TvBsssrHV6iJpuS17UAtVh585ZNy1jUvUlquTGd5hiRB
         rw5Q==
X-Forwarded-Encrypted: i=1; AKwUvBzlI83h96PZfnLRcnp+BSu6NubwNoJ/zakRuejHmUMfGMuzTBIwVU6IYjnlQZvLmIF65Ts=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCS8Ll4WSyCFif55fbj49yTnnK6+kljG6SmkgQtMslTyXVTnuH
	TDjdbVQp/zGlrjy9RoKF3OVd3ARwdSd04XoTdI6kUOUtPWDXBO/HFF0GTl/Ee9NImIRMje5928y
	P99oe633hcviLoJZreiWqg0b81j2C3mnH5Ik69Uk8
X-Gm-Gg: AYBFou1kw8bi+ZB1xOtR3wKnOjEnlzbEBK+DttWoRytWOtDVd7BTqHnAcGUbOtCUPaK
	f789bxLhG8hnW1kBTkt24Cd66WnNKpDCGlUingKZcpCxM7VJE9d4kgvuvlzIPKZg1o4ZcYChLwT
	kDi4eP56mfJOiwFNoGAxUelY5/A9iJ9c+H5dFnQNsjPAjw3jvRI9kQaIY0Er68/qyid7qcvAv0Z
	BWccqcfHxvaSS4qAHYX2mu5LxPcR/4phnORDs6JuscrE0+7eulIx03uIa2nKWZDZroT0LGZjBo1
	5KVTQkDcW6cRR7or24dtCbWF1HehPDI7DqXZe5h0oJSdnATuj8jf8hWUVcFRv42IFU2SUg9+sYa
	1lGxcsiMlhh13pSR6s/NL2Ga+BYlDhKs9IQ==
X-Received: by 2002:a05:6402:550:b0:6aa:7db5:ad39 with SMTP id
 4fb4d7f45d1cf-6b3e5a00af2mr82366a12.5.1792534215024; Tue, 20 Oct 2026
 15:10:15 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com>
 <179249101026.3632927.6502845375265155678.git-patchwork-notify@kernel.org>
 <CAHS8izMRSU3AyVf+sP5uXShiSKuLumZwT=fsgW+bhJz47UoPRQ@mail.gmail.com> <20261020150307.258b00e9@kernel.org>
In-Reply-To: <20261020150307.258b00e9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 15:10:03 -0700
X-Gm-Features: AclHuK8BsF2XH95JeQFPf6l-JaNozEbyLRQcmco_5nfrlR9V-h8rfRnrpx5Opf4
Message-ID: <CAHS8izPZ18v_1CnRkaAAA=d94wutJhoOZdOFO_1CEXSexd_=EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net: unify symmetric netmem and page_pool refcounting
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 09:23:03 -0700 Mina Almasry wrote:
> > This is awesome. For years the skb refcounting annoyed the hell out of
> > me. I couldn't fix it on my own; there were too many edge cases I
> > didn't thoroughly understand and could break. LLMs made this possible.
> > Thanks!
>
> You should have followed more modern naming patterns tho
> get_netmem() is pretty bad IMO. PP naming is object_action()
> so netmem_ref() or netmem_inc_ref() would be better, no?

Ah, I didn't know about the modern naming. I made get_netmem mirror
get_page. I now notice it's folio_get not get_folio. I can follow up
with a cleanup when net-next reopens. I assume that will not be a lot
of code churn. I was also going to try to look into deleting and
consolidating some of the now-redundant ref-ing functions anyway.

I can also make it one of the design pricnciple in the page_pool docs
so that the LLMs pick up good naming practices moving forward.

--=20
Thanks,
Mina
