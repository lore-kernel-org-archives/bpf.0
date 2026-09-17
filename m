Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DF4D17BF
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666051; cv=pass; b=hc3UiNX6kvgPHpviQQe5rhhO7gK/13NXctaofEPIHCDC5PEWLKNh84UOvbVFcuUCf/rCJ99V4lTufBdpx7RgSX9C9WfhmqCPFQu80PrNLYPPRQyK9TKaPRbSK3FanZHta3IU5ctWJIYzX2hLT7b+Vm+heEJr0AtKIFO0aoZn41o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666051; c=relaxed/simple;
	bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfsdUKUdGdZaOBet7CRE6cDw2+agVqKk4uVPqYQgO6tedNAGD8J0bWDG3LH8zl/turyatWb288Zy0A+4h3auA2PIQcex+ygX/qTD+8l9iYCQ/Bdbmzje1PSMUw4c3Xxc9eYejG1D6U8GyqqMPaiM6lw4a28MjxUTL09AlHYNGaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/EOIUFV; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/EOIUFV"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so939228a91.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789666049; cv=none;
        d=google.com; s=arc-20260327;
        b=CvsEvRfKBmZWcnUorM6GdNj4U1dN3EQWWvdaP/w4V74bu3CB8/te7HK253sJrHpw5o
         Crl59I3bKBLzAqB466vn+EfLVr62d2ZHzmMhTwstvTmyAbpVUEjiHvFpE9Dt/KdOAnef
         I5aZOl5s1QWpAF4EamybrNqM578YTNc5OGGeNP48LBHaJcPPNkCtW28PqR9ziYys8t6C
         A0dPTi3TPmVjvFp6y4liXrTgB4gk+2Twlwix8jH42CK/lUcLwdWN0v4KsrURff+Tg6oF
         DiI61CmQTyH4RslEu6fcoakKr9V8duJvPXjpde6K8L+j3/f93Itr4ne3xQ32PSKeQb3H
         oQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
        fh=b6I1TO0yZK3DXhyoygKLmVIEYSjISwAm9bxGk4D8TgQ=;
        b=TBzNxD3HDqrQj9D7BcXcrES2ujnBiJgu0PqIIk+toYX1Ywy/JfR2azotu22ltxhEX0
         AEq8zC1fJR3qMKjMNlFhnMjAKig94UmVQj8UsKVKmCslmng6jHnk7Ri56DFPzOckn8Ap
         UbltWUYJnWnpOKQarcRHo4+D1PkgLc73RVyTnxCXQ1D4Y5lM3iabkY1U8RFJNY2KHmvD
         DnjgZ1LTneQKaZJGEZKyYXWTogCJAd4aCXytZvmnQIAy3wq9qboPICL+Hps5Xj1IpBE9
         rIj3ykweILxD5rDfk2uCcLKmrBCYFIxKGIaGUoCcEaGDcNRt/ExDPz4WStUKHp3OPFJm
         IJyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789666049; x=1790270849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
        b=P/EOIUFVamxgwK6SDy+zh7t1x8RRYudJFaA10XcXxnzn85VO5e6+5LMlq/sjnkAXaV
         YfcxlYkIH1J8pTcsV8p0lBy4D8QNSr1Q7l/z+lDKi6f11Wmg4g3hxhHuPZEwvNzqwshz
         PLR2wa8jYqTM0YFcIX6qZoyrH9g61a9Td9C06GaEWscC4pEb/TJRzRqtlSRFKz967Bjr
         A5Bzn/FeuEs3qh5cVKUGd2siTLAozBSZNqGGnugPTgx4lFTU9fjUZ9Pg1F4wABGJvXf4
         HSaewfc3A7MmUNRW8Ls2QygEZF8Q4cYLJwqD9KI7QagOgys18+j8YdB/2kOPAIel607G
         TlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666049; x=1790270849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnjJ2IzL4qK8F+LMB5D40jZ72KTwVoNqdK2RH6FWOTI=;
        b=UDPX3fJ1ZctHEmORmV71tTzvrr54dUEK7etLrQ09wPgEkSVhZRYHXmJWi7Ew4VB80e
         keGPyzdiLisCeQaJzhMkRcTP337S+UyN/TwhdSwf9+JU693rRcT+4B3Ju0I2CDOxvh1s
         i1PIzZVgYszvWyo+mTFcVntSy7HCxQbDG3YnVbt6Y2FFtVDH2otfLRBPF3M6jWSeh1/i
         J6ee9DylWGiROeuCMaxtOYLDEXi5XHVUGXXtYcW0m2Fm2RJhUvzCeFd2RXPotDCXMgV6
         Y40KrF3txdETXlwdhunOxz94FzeCiFfkiUdEQ23SUMbZTYz0pRH5/dFeddX1+iWUloXy
         XnQw==
X-Forwarded-Encrypted: i=1; AKwUvByhN5x8+uaaQxik5v28iX8Ez3b2Pnt4h9rbm4SXI22udAEnA5YrkIaV91AAdrqo1awIZng=@vger.kernel.org
X-Gm-Message-State: AFuF++nn9o8bQ67xwSjNdrOKfy553kMEvMCC0BtMMmxUZauiWNvX5AEi
	sGo8iDJr2GkC6xQdefdDx3iIt3c9tkjDDEGeZZtPq2aWpQ0hX2lBZ49f4xrP5dy11OuBO4ar8M4
	Z36dxtrRpH07m2d5BDgpPFplZUiBBaKw=
X-Gm-Gg: AYBFou2wifXqREkK4O/dhwYIwrRjD+GNTayzvFEMdhqy362sAOMdDtYYClaZPGCLp0H
	lU2+LYF+wCjXU/vEMSaqvTEOENHse2x6o8d05YMQGOgVLZiY83HV1tsw8sra44ycDuP0fbW7p7T
	bAT2mNnMuy5Qr0DHLqJW8blxt+zpxeiwpvPdPqo3z899tfAWtzMe6M+5Dx65quCEw101pyppbyR
	F6GjOkJr3vR30JA8OZo/A7GLG5YGNFrA7zZfdEe/82ExC5HwvpvvO+ToAH9IbAzjOt6IiQyib2J
	aP/8rciggpwi7d6PtrufZzbM5cgSWRFFN+C1/pyYVn447PfZWY3gOuVUbjU1BONuXiFoi3sjYzL
	RFbRrrDZ25f2QEIM3iWa9G8r81QZPiBrtrtRgOrROwmTL2QiAACzqQQB6yrdQJgI=
X-Received: by 2002:a17:90b:1b03:b0:39e:3558:f925 with SMTP id
 98e67ed59e1d1-39e3558fa6bmr9227481a91.24.1789666048912; Thu, 17 Sep 2026
 10:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqvBPVcN__UX8P85@sirena.org.uk> <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk> <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk> <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
 <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk> <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
In-Reply-To: <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 10:27:13 -0700
X-Gm-Features: AcwNN1V_0iUx8qs13fNseQxj5RN_q6E_gTGBE2XuMqNGKhunfH4trjoxSpweNWY
Message-ID: <CAEf4BzYp0YAbhkdkKJn1FR0pjUF3JXUxqXkZtWqKiSVPT4=qOA@mail.gmail.com>
Subject: Re: Missing signoff in the bpf tree
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2026-09-17 at 16:03 +0100, Mark Brown wrote:
> > On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wrote=
:
> > > On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
> >
> > > > Do you have a full list of the current committers, I guess there's =
been
> > > > more bitrot than just this?
> >
> > > It's me and Eduard, apart from Alexei, Daniel, and Andrii.
> >
> > I've added you and Eduard.
>
> Apologies, that's on me, some issue with scripts configuration again.
> What would you like me to do? Force push with SOBs?

rebase preserving merges, and add your SOB for all commits that you
rebased, including "xsk: Use a 32-bit compare in xsk_map_gen_lookup"
which you didn't apply, you still need to add your SOB
