Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D53DD500
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933841; cv=pass; b=dqywNHo47ns3XlmBXQBNUMrPqzOJR6kXzPhB1Pg+2IfurgDhh0jetuE2IQXFkW7rluhrZTaKx3mqj4ngXg/KfVXlKGlxwXrJVpJTNW3Z8CmgRDYyxjg6tRrG6tg2USXOrhBuuimbHsbJi21ScolQyoYICEF9aWZNVImyGPYUGZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933841; c=relaxed/simple;
	bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7waZhSe2IpSBmzQ+wsptwTg+MQmL/Yynt+rDGfQ6368pIcU9qyFQ5uJVNksgxgALkSCwBqePwJq08E2box8GKEXyKwdKXt9ottRRoruedMowglU2D+gugq3KX5Czpqn6ErpSs+3iPXW9GIBFO1XKmkKv7W25YN73mjysL94eI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9L5Dpy8; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9L5Dpy8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b8d99342so71375e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 12:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782933839; cv=none;
        d=google.com; s=arc-20260327;
        b=jC6uSPJpLRtdeqmY2FQRDzPDDgSW5P/Fx0EUt2ZEsqvJchq15ZotOTY1NrvFppsg8Z
         C2tayHYFhB4oIg4i6aArIjaT/54P5KH/Qqsxp1eLjoljB6QRFPIAAz4PHgVHu1WgBfuY
         PK9rni03fuDFyWEJy4h7GFwVF0DbmsscRCQaRAs1J9pHsQGipcqNvV89WYjLtAgW+TNE
         5m/c09KlooVLEB+X0x2JzDoWzVtzGYm1AU8Wj/bDnKTAIEFD/yspVExPubR+sq3smNGw
         CmfxOXMfJRzuBJ2krAE0OKPbgpEDSNmnCRlIL5/LMrwgNyncOfL60YEjJKWvwpFk5o4L
         SsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
        fh=Wpe6pechvKwH1VTfAW+Hv7N22YHAPhTHbSBdhPrO1Z4=;
        b=CCAmBu9ExoWqwVcJNRfofPe1Z0uias6OmJqVBQEhTD10zmTLxSirgc3Dku1dN5e8D2
         /HAKwR5LBAX+Xxdm8ndpZVOzdcDK5hnEAwPCPBA4ijqBzWsyMVMCdawTmnWqfF4LEzuu
         1w5AQr7wCcCriF66JZVJ/kKpdQFhmyH2QWdU+yS3Ia9FvVeu+j+e2tPTPvpar3cTT75h
         CbtGrCFJzhI67xWuWfvobkU9/IgD3elxHXljDdT4UPj32IPkQjqgwnXYn+kLSb3PACso
         /u9c3jPmXBic1/+ZzsNiFPJF7SUh3zlSrM2MDA86tRn5Z4w9RKj1S69JZ+Lxw4bNP4d2
         w9Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782933839; x=1783538639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
        b=Y9L5Dpy8z/KuMsCmndEzdcnpi/Mrwh0CFBg1M0fnL1iWlsS4aPOnfH4bNx1PqNjsQA
         pQePWlFcyEutcYwiX7JyQx/G8uWeFKkvEIVjLn+Kdk5xoEEXlnu9eGefuvVqTBH8RxDL
         Y4L9yGAlaB5zBcfRW6QlfIA2WMmv45zEN62CdMkdRm9ml7esAVntkWNVxNvXXlaY1vO8
         qKl1ubOdRLOQu7wH9O6cJ0ONfpdOx4AZXMHbFTqcgZw5rEsvKcr5f0pn5/PcmENO90mX
         WXq4EUtBPB09QMvHl6X28/t7IzjWRd66e6Z4N4SoLGQim2pyRMLo41v5j9S9AFtdz5O5
         VVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782933839; x=1783538639;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dsoYYFj2xtXzxEQ5IJrMmZ2387VOR+HXTHuw2bRS09M=;
        b=Qw+6PFJc2n0lIXFcJ+27BTlTNB6U03fpt0MB8XhTL3/Fz4KmPxrspZbhWlkP/QsCrT
         pCLTfs789UJaTA0ZUL93ROpgWVGlo6mx3CHti2otawjX5NN9K/2BLdrlkX8ng7C2ov7K
         RiKFlksG0TEehWaqF8xz4wyFxRrkGNLzgX9uzrVNzkx2TBTIWHIyipLrUtmjdtx9DmYB
         98MMpmpMtoT84guF0OvSRwiMazb362DWX4XnuSkjmk8nKfLIBdW47gXuE6prD6GEj3yx
         dROpE00r2fEaQfi1deWXklNsrs9ZqsrixGeCdyUzfDfPXPx6mjmOtc+OnN4XCrbOJmnE
         4dsg==
X-Forwarded-Encrypted: i=1; AFNElJ/mUaXvbiVn2yWCehPcT4BcF224Ral3pcCAzoodoDp3i5EKm5Zg8QejpDdDJSe5OdKL5qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsIeDN0+zcLkPG7GHvWfO8106SIrENJXA0Lo197G7gDlx2Ehv
	uEz7fK+7o0asII0ljv8kS1S5K93+Fupgdy0fp0o/J22GLqEr8D7e/GT4jl4SmSBy86BAwYUEvvz
	kcPa5W59CxPXxb2nDTcgaB6/MXeVx+8fXpEHiPWBe
X-Gm-Gg: AfdE7ckmvSrjxVmITY/B/hdyxDYxO5XIwpWp+Aun+ToS3Kxc/eCiabf+yUCffmFrFgU
	QUhjIUaC+VDHcV/RbcQpKcQ5S+LmGdBsonMfY/hqrN8m7uk422EX4p+3qksCpWcYYHAjhFGLkR2
	tk8VSdEK4E/pBt4f35xmYtG6ClXSGLeALURMm0zYjsVYTHFSm4BrFnR8dm8ivUKzkCnKmnJVWLB
	lfuHFZWCzd9vaVRiRo4xXdyaYYIRL6+8j/dazDKvWpsQi0ld1tHhBexSMy9/KjL0gLFWi8aC0BT
	iYKQFKIO/NuxJlTNbgcxj1Tii/HmgA==
X-Received: by 2002:a05:600c:4254:b0:493:aca0:32e2 with SMTP id
 5b1f17b1804b1-493c0b8dc60mr1101445e9.4.1782933838708; Wed, 01 Jul 2026
 12:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625181557.1086105-1-tjmercier@google.com>
 <20260626180941.45158025@kernel.org> <CABdmKX2oG9m316hiJpSXbujrT3vgE5hUpzH_WHfjNxBJ1_+BdA@mail.gmail.com>
 <20260701115708.01213909@kernel.org>
In-Reply-To: <20260701115708.01213909@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 1 Jul 2026 12:23:45 -0700
X-Gm-Features: AVVi8Cc9XyUG3uGiXCOCq9h4RePCwClPydes5CEX-eBZWcC0PMTerb9YxE0VoYs
Message-ID: <CABdmKX0bkWgMM4LNLFj_=egSCNSL4a2cqxARu0f5_wgSpjvd3w@mail.gmail.com>
Subject: Re: [PATCH] selftests: Open /dev/udmabuf O_RDONLY
To: Jakub Kicinski <kuba@kernel.org>
Cc: kraxel@redhat.com, vivek.kasireddy@intel.com, 
	Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 1 Jul 2026 11:53:15 -0700 T.J. Mercier wrote:
> > On Fri, Jun 26, 2026 at 6:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 25 Jun 2026 11:15:55 -0700 T.J. Mercier wrote:
> > > > Write permissions on the /dev/udmabuf device file are not required =
to
> > > > issue ioctls and allocate udmabufs. Applications should be opening =
this
> > > > file as O_RDONLY. The BPF dmabuf_iter selftest already does this. [=
1]
> > > >
> > > > Remove the write access mode from the drivers/dma-buf/udmabuf.c and
> > > > drivers/net/hw/ncdevmem.c selftests.
> > >
> > > You need to explain "why", too. Why change it if it clearly
> > > worked for everyone running this test until now.
> > > --
> > > pw-bot: cr
> >
> > Principle of least privilege. Folks use or point to these selftests as
> > examples, and then wonder why O_RDWR doesn't work on systems where
> > write permissions are not available on /dev/udmabuf.
>
> Alright, pop that into the commit msg and repost please.

Done, thanks.
v2 here: https://lore.kernel.org/all/20260701192210.2997769-1-tjmercier@goo=
gle.com/
