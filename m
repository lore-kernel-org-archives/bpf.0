Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC93148A3
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111875; cv=pass; b=jY9M0vHaKQ18ugxxBUKg99g39D1/tynOxBnOOMVgEyPHNZ2OEf12i+wqrxeA5RSW1SoK4cgBsO6+VhMmfW5EpDvErOEhJ2v2kLBKr7ec8n7hHwQnmaiMaA8+b2mxcpeShN59UhrmuRPvn/FicLIpwTHWfT9oadoOhXXW/XUmFBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111875; c=relaxed/simple;
	bh=NK7siyIJ/eEsJlUJu8OEqOJN6vumMIlBfcJjglJJkhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpXGXYAKisLAXEuluov9bLhZKcEI5E5AJIOBJBh4AyAfXXzzx0uHtnjC7WBA5t00kpDfpsEbtOj9QafKIz6tNt9G/43b4usWepH/Ey2MEQEK/bylWWvcSjcojWJ3ibmc4uc15Jk2dxW2XqvhUoPuJvhuWqjItzyAmkggA7nvKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXmIDmr/; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXmIDmr/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7991db3dc98so6031947b3.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775111873; cv=none;
        d=google.com; s=arc-20240605;
        b=X2T0vmNPJsNMrsBdrL28UxSZtMoXxtrwTi3SxfZoL+bR0e63Z+hfoY1LZ4XclMh7JL
         kEphW7R0ocD67Q7270vvKIt5zpgYB1+rwRxIcEY48CBp7ZvSJcz873yRcIAc2vy7ULpN
         a6RA8WiFWpejS4/gmnTILE+3WeUX+B5KwWhG36f2nzNPHoW0B9VrDNvHHTqXpbqUbQFB
         lYQ8ucSnVsaPpPVM3mdD/m1eKjGipi9g6Mb3gWJzWUXbSp7xfYmARAkxgvXHx62Ephwv
         k3BlPsNEzJVPpNZGkna8cQ/RJnxdmcLgGWfzG3pIbGVJaFbpmiynNn65LWww1ICyODm3
         qJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t+BrHQX+EQN9KTa01wtx2/XOg8PJ5fXoG4b7oExFqpc=;
        fh=OTngedkmQGSVGUefPNiJCoC1LtTfviac4wu/YJv3vNI=;
        b=T/EUtD8dntaIbu0r4LVlutLf1fHMVW7FLq7U2a8CcbhG1SMi5F5/YiCdAEaejTJLPZ
         YWVkbuZA6PQGsKrezH2GTT5JkWXlNM16wVBmJo4rpipagVwSueKvaZ/CE9GqhrX6bOsq
         mo55OrPghlvpbQEN1SwNvEABVgP2p710uxw/Hb9l9ZKckR/WJECqsMV9CZChs7nlcoXe
         Xej+a53onystW9TcHOrhYo+iE2fC4BT65BLlUyBPfnE/Qs03/11OKUFgdmSy9XBMmRqd
         oF3dQcdJ02gMToe0/Xrw21jVIIJmLUgD8jeuAAzVaaPdEByRkWua2KPAfX1KruRNi8xu
         2qOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775111873; x=1775716673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+BrHQX+EQN9KTa01wtx2/XOg8PJ5fXoG4b7oExFqpc=;
        b=JXmIDmr/ELI/+iZecR5P2fGyW6zXm6pbMV2bFtt+59katsugdzNq7OANBRu7Whg/mr
         PMR3jwfPOFdlnCoLhSI8PtKfXFaOMgkCn9ca4PnLG0KDcMPqLjlJnUs4q2knUtEfL1OV
         TX92A5LlLpnjjl373IqR7lDaSg10A/sDI0dQ9/sO1kBFSQTlTRERK+Xk64OzC0uckHnq
         pTkl34ICmj2GF//WVKORnyUGi8i09apgATUQgjO09TQCmUSbeO5ospSBt00exd/NzhaP
         6q7AqYT6Mey8xzgO7hLDV6BifF6d5iFVxAZTVGHGbpVovRuYbCYwxktc7yv2zTCydupl
         17dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111873; x=1775716673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+BrHQX+EQN9KTa01wtx2/XOg8PJ5fXoG4b7oExFqpc=;
        b=cKSgupoNHt6Zjr1WKaVDWlqAGcJOw6BhBHhntdcJX8wirNhiWeB6SiSMk0bajpD1qc
         Rn1KOwuKYqiAR9C/8eXl8ur+t6JLJE0ZcFdT7ZykSAz5xNaU4CXGapH8Z7DW2AZuPwZK
         UFWDctaBLk7W5wNftAbsP40of6qeSXqWOPCt2UYq84MIQZ/NrYhoBRNYainKN1rXIOAS
         Q/MjEWcD50HWnEiN6rA4+z9zbZ1ekVEfZGDRGper7eycG9VmSMMHcUw8idiggyYht9Wd
         w5DKQ/LDnhTUUW81KVfC78xDsdS9Mjosb/N8z23YAyr7PT4Ql71XfpLLX3q+kwLKsSOy
         0T8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7NMO8jmuaDwBpmN5uzfAGVwMSmTRcYmHSf9IkurZS3K1jF7TJxQI+377CF8dX/k5yYFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGtDI9Smvi9cR7mIxP8Xi1vLTD6MZ5KGgmawj0274eqX99HFO
	TF771wINn4CjMGucBDrR5PMIC3fdeQ9ZaWJLXIKayO1UVKP21+SSpyqFIeXIQXnTMc9+l8LtsQX
	qIaX7JqjNa4mtgsqiIP0CdXxVKAwcluY=
X-Gm-Gg: AeBDiesUSNIH2I5GFQFjekN8+N1iX1gboA7UUhSnellfbW1+7RfhGTXX1pK8duXYWFn
	dE9foHGbiBnOJn40+agEuobGikkBrkW4+QejwolWs2tgNqH3pOvbduzCVSgxcDnDeA/7nGBY7kz
	QCN3JWCGqRiZVcRbWUp825it5KsyxVJCIVsK2iUIdhvrxa7cBHHFib9QpzH/NosR/DfI9B9HFPl
	RIQGJ/ZM+sbytNiKsIDs+YjdTdiKEmfUsQi6aHJo7ODK/VVOaAAt9jPWaTaEDYAwKWGGh3WVso8
	Ffsijaai4b/9gr7X1MElbNqzt61NWXk7ktdzjIkk8km1PE24IFqwG6uFn+A9VLCYMHQuidaX
X-Received: by 2002:a05:690c:e3e4:b0:79a:d393:f8c4 with SMTP id
 00721157ae682-7a21184ba85mr73520507b3.34.1775111873430; Wed, 01 Apr 2026
 23:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402050928.32946-1-kartikey406@gmail.com> <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
In-Reply-To: <f64c57ad-c162-480e-910a-e7a5a3460104@linux.dev>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 2 Apr 2026 12:07:41 +0530
X-Gm-Features: AQROBzBOLHhkvCg28iOe4f7E1n0WRMLHW1eN8Xhts2J1WaN6Wst9NNUVwAWVyeU
Message-ID: <CADhLXY6-fto1jby-Hq4MgD5PkEQ7709V8+ivJ9oL=0iNZbmHmg@mail.gmail.com>
Subject: Re: [PATCH] udp_bpf: fix use-after-free in udp_bpf_recvmsg()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, ast@kernel.org, 
	cong.wang@bytedance.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+431f9a9e3f5227fbb904@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:33=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> Kuniyuki  is already working on this. Please see the
> existing discussion.
>
> https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/
>
>

I was not aware of it. Thanks for sharing.

Deepanshu
