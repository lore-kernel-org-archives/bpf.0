Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794624487;
	b=CF9lJ/VOT44SH7AfpgT/4Oy3V6RYbYq1uc5QJmZOwFBMrQIXbekhO8triwvP2x/J8vMR
	 pGVtSrpgrng0jTPBihgnF2xOqeptQIm6cCsJLErcYSonMl32wywSjQxV9srkIZvi+Ie1B
	 T+6rlfqLrg8QRoPKXiNZF8Nm9YDT1+i6qTQacnmN+ot/IwzHK4Zc3Ij1WV7u6LrvRq0s/
	 MoGII65RHEoREYi33Kfj2RuFeu3qj8OZS72ghkp0kX8zsS+Bdgjq5K0VepiSCV6RdpV+B
	 zbVm24IMcmdDzFDSEgazh1x6Mfk8ymndN7dW1I6ArjUA9Xi1KaEGqti+VLzWWUKp8QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
	b=iZfzHwwbOlijX7tHsxW3BUw1KjvtecV5NeWqlw9i9U+k1t/RFJFCDmyVRIK9WQfbOfd6
	 DoUItBSxzTo4AuL7Xs6/ysrC08JMM0IgP54+sM2770eezyj4yw1g7rh8PmljrQdAQzGRU
	 Oizo1E8xCvcete/pplGzQTL+bdGQcetZOijCKywuAkjtYpl4AIqAghIFvNXafI/6rhnTH
	 4D+iUiQ1cG7c196bJgXlM2FVTrJRYH3Ss/oWxpFrxTlqOpffzTfMNJ36ifDwx0V8d+SbL
	 bMcuqDrMcbWY1JxrS71WsErElW9Ikt7QW3i1Q/6xyt8Jt6BuYmcXecp0n9kJ/zCrh6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4FyeRk1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE1606A331
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 02:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53BE1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4FyeRk1
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so1273426a91.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 18:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794624487; cv=none;
        d=google.com; s=arc-20260327;
        b=lKD2jUGT1P7h461t4Gu9nk4EB+WHM5u9HaKI2YYRzH73+rpqMCnFVomhwylGI+kw4g
         +9jTdrOPChjQz/k6dSH6YqqzJTdrjohpZg+Qv81IxYN9uA0GKZ62nmZnwU7gDvE/nPtd
         elk6LOT1NFn/T9JHyopgA6J/ag29AiMX+sn5dwfjMWP1ub3z1v5NjBuc1R+LsqMnIL7e
         3cFqIlD3JbIBqna/Tm+6pCvhfyVYDrtDRupwjN911kRVvk7ciF3uQlEjiNgarsieWkNW
         NYI0HlZycmyLYK8JxSxhjBE96SL4zK3X8QPINnu4/DZZlN3vYPK32VpRyPfV5qw3nekq
         A8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
        fh=GfBhY9gWey+NqUQy4GT1xN38fiH+RdXrGQ5gQwWGvSs=;
        b=C+Xl2J7yB81TriLECw0CuPbxfWHBS2zqXTrTCf2/s6L8meOIWpTUJH5HhtYW/D8scX
         yNfXKOWkeQRQ2NFH8R/nsNL20K+SPKst8+205X+uZ5PMyOUSeD3SJOCaO7PlAs3e72On
         i9HlN6hPDgtjd02RZ3BYJ8ptFrIigGv7mlkyMazbbPdfWQFzZwkCM6VT6qbr8I3RIv/7
         FrqdU2/Nx58ZN94zO9N2BJn+ulFcmBwZTMTAI3YRGt3ZbUe0u51uV0n+45G7yyLtMtPt
         WcrM04758007kW6w2vq0+V87oGRV4kwC5q39JDEQErGVhXJ0WKQnzWlUWNwQv3uLtalK
         fDsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794624487; x=1795229287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
        b=A4FyeRk1XJ5lhp5+6l9ZBKBqUwvWOsBjbrCJLUbQu3jAbgp3KA8uyNP9pHrdpAYGiL
         ClQpGQdJJv0C5mBcC7vU1bNi6pGxXQyhQxdbqaz6tpfYab7WuvqXLp7x+AYglubSPGnO
         9Ph7vDuPVlRTSU3GlIAltSQRxMWr7X1I3sWjOwdugucoFiaDEQvM2ZfJklAR3h2u5Lh3
         p0Y/PCrCqrJDHLchOYoGd+PC4TMiLrIIM9Up2g3BEljJMM/FJa4tH948Rt0wkUzEpnca
         ntTkmQD7qIGBr8BsiqeT2jS2tRf7XH8DIEAvHD/dIjOMRQb2fLcDh+qvrIOCiC7k6ct2
         25yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794624487; x=1795229287;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eALZf4jDPuuFCN4fJbBtQv0/lExBZLf7fNwf9X1G3mw=;
        b=GtIHcc9miPB1zsXR13qBc/S/x9cmM5o5tkGY1o58VI+lJ4p2rodPDcWeUVptu9I0Sb
         Z2yYBTw1g07d+NS4iL9ZLm5Wu2EF8AquAR/9JuBeV+jyokbua3dEB4M+yR5Xa6gkkxny
         5iRDHaON916bcNEBBB5Vb73CNNN0toLzhlOYejbMLobMUbQpv1xarqj/8vYgtfkmhch0
         /uCrRiV2S2xlv7uXFe0sLk0xTR1z76PNZemRmfr9EpnI2NDETBxaNJCokOkjQmEVQ/Pf
         dTSIhrpIGIGZUPfqptt9jinQSa9fNGlq1T+EkK47Z5cEeZrdRGLiAVmY7C7lLmsABnVr
         OU9g==
X-Forwarded-Encrypted: i=1; AL+hErGrgLw/X0OJlF9guPmpuhI+ZflBv0TqfMU/lBaaA3Z2OqKUNFsP7FaNaTeBnHx68xsFSf0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s7ptjo8ECk+PYedFixXMx94QAEGx/cFaWmkgQQyO4jJxOAE1q
	jlMJNAtpYpJlAVajKV+b332QuW+OGPtDJ0uJs9oYXCLv0Bk29PGAsHBtnKVTdN4DLPNQLFz/Qyr
	g8mNYeDvfgDhDhgtuv5jbOZX60vBRUq0=
X-Gm-Gg: AYBFou05c7WsWf8dbSsdPb0jBhrpdiPUZNBEWBMPNKpL2RBljAbOC/Q9d9eXwMWw2Wb
	G+u7lF+CufaT+ru8nOsWVBD7K3wz4qm9HwIhQOq8a+A6CX060GcsXkeEw+7T9AlIilI/YbWGe8o
	5xyPS3SbkC9bXUPY7ypN6IV1kE3wdnJvZNMQOC504rpthZBCTcxymzz1MsU3xY/ccYH+F/OYQUO
	AVcpFy67kjaGz5j6tIKaANejBlxPVUfM36MzTrJnuZOw+cbwOYd6HkdRtFPHyinubXOEThP6PZq
	6z/HUhVaWh689xyclZcftSJhB3+Ggpqny1bQjw1iyzZ+BrUgTubPnmeWRCdyH6abqnKTRt8Pucp
	bGIWbKSaUXFxd+AieqZkCDE1cT11HzzLVvKb02uSqh1iTZJuTy4EOJcnnSWNho5E6Slfc0oGr1i
	KzM2J0514B6mTp0AioxFwN/0/95b5muH4piGMyl2nN9sD7kzH+sQg=
X-Received: by 2002:a17:90b:1d03:b0:3ab:c80:9365 with SMTP id
 98e67ed59e1d1-3b1b0b4cdf7mr3736445a91.42.1794624486524; Fri, 13 Nov 2026
 18:48:06 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
 <20261111155748.11b92b7b@kernel.org> <DMSSYAEKE9XD.Q3C9CEHH7KTL@gmail.com>
In-Reply-To: <DMSSYAEKE9XD.Q3C9CEHH7KTL@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Nov 2026 18:47:55 -0800
X-Gm-Features: AclHuK_GHHLj0tkZe8WQWt60_PoP1RTBPF_tvkYqhr7jC6EW5BMLLyA_qSZQp1M
Message-ID: <CAADnVQJtT=iXRh3OP=-6KdZnZJQQHs1V0KWNtZxYz-KRsMOY_w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from bpf to net
To: Jakub Kicinski <kuba@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 4:23=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 11, 2026 at 03:57 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > BPF folks, I made a tag for both of us to merge / pull to avoid
> > Makefile conflicts in selftests, the original series is here:
> > https://lore.kernel.org/all/20261109193048.1006986-1-maciej.fijalkowski=
@intel.com/
> > PR text follows. Please LMK if / how you'd like to proceed.
>
> Take it into net-next.
> We don't need to take them into bpf-nex atm.
> There are no conflicts today and we don't plan to touch those files or ne=
arby.
> If selftests/bpf/Makefile conflicts it should be easy to resolve,
> if not we'll pull later.

"we'll pull later" ... is now.
pulled into bpf-next too.
Just to avoid thinking about possible conflicts.

Thanks!
