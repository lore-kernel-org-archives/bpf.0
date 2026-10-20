Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792535284;
	b=3ysCsQO5KWc4tfHqz6/EcPXHgygBRmebxzDNERAo0mVdDJPIinVhigks7CJEQoHVuYVG
	 5EMfhAi0UphETNIOVjJs4G3SZusPCJMB1DCyZcVrsBctkRhIh5a2Lk/JrUFL478+hVJeB
	 9Ug12WHxNlPwaO1ynEkAqN+U+IJRWojIOQ+GHUsXGag7vYOewICDhDdqBMuRHj5Q2nALz
	 VSkIRCf06Lo+N0VrJFx3jdN0EsQZBA9CbehALhC/wtl5opYHxbJdZrmX30PbQOFclEbwR
	 JrIu4+rxN5gIqmH3ieb8u516XpPD6pSQ05dTbukZvfnjI93TfPsZL1ak/3cf2IU8tAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
	b=hlHqSEDMlc0ifkys5IeLXZMvFO2mvlftey8ibxBH8+Yg/sOciV1Ka/4W+entiOUixEUL
	 5ElXTiY0dDBtIaDavKtTPd9t8ir6mK1TSRZvzlG9yKqfngOq0v592zhHj88uNlx5oI8E+
	 1oP/BlSo68KCjLakbG7Y3CBPLc4yYAbeLJXkX8Lpnm3Z1tuH0y6dODkRyreG538i3zTOZ
	 RdA1gQVAQHhq36lNB+foyqVnehUq0mYlB9tCR7M9/0Ux70wNyzinUcgePT2kzhFEpywjQ
	 tMiIXVcsPc1+mdAReerf2Z/FfLUjwGLSCRIET930H2UcXvuaN/Zigb0YmKc74l6uD0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rmfEpk+f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFD606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 22:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rmfEpk+f
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2246a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792535283; cv=none;
        d=google.com; s=arc-20260327;
        b=H3XWq5SrAhcsZXPY4bdaUUe7ObQAbzbeUZMhkf50QjPQ43tMY/ObGj9l29oHKW8ZAU
         8ABRTt5m2vG2gYhsj1iJt1mc2QV15hSGXBBj3djvlS3OlF1/k4cQkjAOBPufOtnvznkh
         FavYMvc+PZiU5j5ix5RkiItfhuFQ0Cgk6uv7h6TXklBW43eIVmSPP/14sa4bPGJ9AVuh
         kJVkVObLODuK9lpn8zACrzNm14bkXeVVDOlrLV9eUFfd98kEhpogRH14BUaAa1L7R8pU
         v9/mOFTwbbJ6K9jAZss4xyRXB6b2s3bc8YtGIQNx+BiIhSgn5xpMqVpF4Om+kIerMXXk
         k0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
        fh=ccxZaQ6cRojj4+MDgtAGAZmQrgngac+OXG17w6p4APc=;
        b=aVi5jliGSH1k2xzKtEHnLzS0yI+x47YWuXvra6J0dFbb/rqg0B71eJdv6kN9m+iGmE
         92pnEicp52JLIhBRA3X+s2KRZu2j7uR6R+fyHXVxiEDWFUWRCT+CxFW+Uk09KONI16Ly
         RDvGeYSCEp9LvCXbT22BCpj7ndWwyBkdlKSBIj41Kz4I9tYLOdSK7xk/JPWU7WnAnjWO
         gIWYH4rQduuPW3jMcbB/O3ZuS/r67K1QS23d3TG5npY7DVLai0i3jkfvWb0LygfXyHUl
         XNsdc7IcbWPp9xlyPgBMtYYMzV3zylyVrGZPMlJHYTfPJjZxfwrm2TVq6pPx5kHQAdal
         a3KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792535283; x=1793140083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
        b=rmfEpk+fCkZv/kL89pFPui7fFmGk1n8reU/QsXYE74PD0EFucUW0hMf+IS4aStL0Q8
         nG8UsAS92tQv9D9ZQHsaoESspRJ/Zb/tLj8EXkHtFpS/b+Yv1XiiogGOoQF3SNlGVDbi
         VjAnWBFpIEg3G+6ql6HnSMNEeatAVsqUGblKkp4VLsG3Vl5mPo6Qjfzp7VqRcZCtcixG
         ZID0xGN14VQRGASeikykGdy6GBWJ9A0V6AFkxpNoT6/e09Wv+fXGPPohwmNppGmv7pGS
         v5JICbY+ElGsHORRCVuJuVcDfeCBoIeo53TU2c1aTQ4ePKBBopr0CzBIg003ZmACaLP1
         mCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535283; x=1793140083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4ZO9/xaGwtst57VlOOA8l2P8QCQh7t0mTcJLRZEW7s=;
        b=Lb42bhtCrsjZQ0Cet6KHwsa1BrNTtx3jOp4DNkjbkeqOnSlU0Us0kUzoVA3Z/px9Fv
         RYllfFl9kb3mu34PEy0BDVPFJC+2PXR4lrpH6WVTCDani+a1WnRvtg05u1TfsIx1aKBI
         RMXzwjcZaTnka9uxcZqWyibL3xMoTVpYytI1OdHqNIB7kCnOeOmYKTSCImqru4tBHL0t
         8lU/FRPCagSZbBGKKdM+3aB1K6c7g+wX2qTeb+PoWLZrkWk+kiEmPwc3zYN0YxSmFqFu
         qAMfwDyNWDqgQA7J4R6eH/A7Z3SQSBpzTj6RJYBpMioeIBxx+UAG10RUDk3WGSEX0Ke8
         q1Mw==
X-Forwarded-Encrypted: i=1; AKwUvBy5Iyk1pxlG7IIVSuayYHNWjYrYLa4z1wuriz2prCtW6+aZbFhb2EISZoOxOnSXx0TuLa4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+/2R4KkZWusAuoD2jPsUQWGJPL1aHqshBKDC1j+qLPVmyQ+yi
	IMfTtCSYgkMreq+tmDeMKpPZuVsywSArjNIlfQ9YzhvnmzeZdbufUHiwj2hSZd0arxJFeXzVDUj
	+rMNF/F1Jrdp7oChdr3Tl3El2VBwR3gggmA3zxmrm
X-Gm-Gg: AYBFou1NNnd2CFjTxMfbQ3zMs96XEUSlGBZPvvSbzXHcrpzLYeQzk1vBV/ju3uKOgpk
	p2g2XeIpnKtLGfiAA9VKP5/O0f2iU7feiPpTwxynMQgzLv1p/Agh0AiR4bGdH16DPhfT6Ot7JJQ
	83YwPh1B6orQYSkcNt/E9sqbBndEVfo0DKAa2mPFMhgV/WTm+cX7dRJ5P6uQIEKmHyRB1lbtR6G
	ONGQWfx83zpGKf05l+4Xrcerjp8xjJmSp2Lw3GQYYtHdMm97vFO+j+udXHxpoHQpgJddgq1PoSh
	9PonhnlJ61iFZ7OAoJLXrAc0rj8IpMbSH3wjCLy2ATtAClQsIpeKF4vnM64Is8o=
X-Received: by 2002:a05:6402:a593:10b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b3e59e5999mr93600a12.4.1792535282334; Tue, 20 Oct 2026
 15:28:02 -0700 (PDT)
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
 <CAHS8izMRSU3AyVf+sP5uXShiSKuLumZwT=fsgW+bhJz47UoPRQ@mail.gmail.com>
 <20261020150307.258b00e9@kernel.org> <CAHS8izPZ18v_1CnRkaAAA=d94wutJhoOZdOFO_1CEXSexd_=EQ@mail.gmail.com>
 <20261020151352.794bf03b@kernel.org>
In-Reply-To: <20261020151352.794bf03b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Oct 2026 15:27:50 -0700
X-Gm-Features: AclHuK9dUEuy9FSTZ5UcXIu_nwM1X5COPAnL8H94zeKVggsnQ3YuXniy9SKSJgk
Message-ID: <CAHS8izPOqgG-LffZtN8rmuEt0dS1YZOmWALM9Le8F+rLbVA-sA@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 3:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Oct 2026 15:10:03 -0700 Mina Almasry wrote:
> > > You should have followed more modern naming patterns tho
> > > get_netmem() is pretty bad IMO. PP naming is object_action()
> > > so netmem_ref() or netmem_inc_ref() would be better, no?
> >
> > Ah, I didn't know about the modern naming. I made get_netmem mirror
> > get_page. I now notice it's folio_get not get_folio. I can follow up
> > with a cleanup when net-next reopens. I assume that will not be a lot
> > of code churn. I was also going to try to look into deleting and
> > consolidating some of the now-redundant ref-ing functions anyway.
>
> If you do it soon I think we can try to squeeze it into this merge
> window to avoid unnecessary burden for backports.
>

Let me try to get it on net-next in the next hour or 2.

> > I can also make it one of the design pricnciple in the page_pool docs
> > so that the LLMs pick up good naming practices moving forward.
>
> I don't think it's needed. I mean, if at all we should perhaps
> think about naming guidelines for all of netdev, but no time for that
> right now..

Yep, honestly, maybe even just general guidelines in an even more
global place like linux/agents. One thing that has been working well
for me is coding rules or designs in Markdown; agents inevitably pick
them up and try to code in accordance with these rules. Just spit
balling ideas, nothing concrete right now.

--
Thanks,
Mina
