Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363200;
	b=x2/lNlq3j7UxLwzNCJ6K024duw/OlVHH1lct9F0tpSZUTjCkZ/gGCaGO5XZljZVTRUyk
	 5XViv+auHJg4PTj/QnoTsvfsk+/OF8lfsXMMzVAnf6OGMue3SVLgv7FAljEsXwHGPT4o/
	 DEKVH8R1LgEwD1+Wnobn4MCqjVhpcdFxOBwqhIUk4eZ+SH6TiDRnt4eP+WVV24aT4wo46
	 kuiqGA4jRfOCpvODTtTWUnBIjaGdD/mPo192O96LagyUICynPaYqDRQyYmul0lmItCoeq
	 d/JK0aT90j6ZJF/XWRcW9dalFmT5hpLR10+Kog+Pm1JwRoxr7D4WnD7I/NuqQWrO5sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ib0ZIb2YOYQ7w34USWape/G8EkDxIb1fCiEOQLBLNlA=;
	b=z3hVHRC7Is/54LJFOf3RSfx/0zDPdLJL1SjxYzny6e+r4zcnF8Dtvr2PIZbOoYo6UWZC
	 Mc8qtBo2aBwn1LF7CAIyjKLOSHryvkKKkgIvHubvWQeZ/8FYvF6w5Kp7N4550rAwPOsbt
	 jn6qiSDtZzbto+ZOvg6Zz1n5jpwXpJYX/TP/TfWpyNoqyzj5VP2WyLXD4OX9yKlfZ9Nuk
	 B//pvyMeNaaEVR0+5wITAWWR/GT/NcHkv0N7iJiDOVTLrSh6R3TG2S8aUdIsqalHXDzRi
	 MlUYYcO+kBgCzOwQmez2XWd+mS7GqXToBVPPWxN13C111ffxnxPQ+DdvcOwTe8NXIKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fhXFza+Y;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4E606A321
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fhXFza+Y
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so774572a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793363199; x=1793967999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ib0ZIb2YOYQ7w34USWape/G8EkDxIb1fCiEOQLBLNlA=;
        b=fhXFza+Yzy3VG+9OGHMOcR47ihiPebAoAFmsMUY2P6j1pr41QmigtuRDAv5TPC+uDE
         0J3nvWYLFmutTaTKdFz30ALFGAiiWg7cTyjr82gecO8pWjzBrrlyLSTp8j3jYXv3pL43
         xFkN4qEcHAjm2DJwQl7q5XooRBhI0bAl0tueGBxYCb0WgpV8Ybtpi4mCobTc/mvoUD5+
         sZmdzO9P3Ja8qlIWOVILGj0XA2BiBzcjS4Vj+W/j4ZnusyI8UcB9l0j6YLD/mCxJCQzZ
         tj2PheJ8/nEusRkl5R9YusrHcvJUoURwDOSSceCnHGjKE2frWjKllo14yQ/XiJ8aZEKi
         JfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363199; x=1793967999;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ib0ZIb2YOYQ7w34USWape/G8EkDxIb1fCiEOQLBLNlA=;
        b=lT60+Lw1Sg33QTMJkTmTCSWK+IO0cPjDo+gOWXTVuX35dKuzoHOSdTmvS8tf15NVUO
         CQh4AxsDicVW3hdPIPh83DtpREeza73tdVQ9H15PACGXXvWAZTelLGtabSX3OpVjKdiy
         eJKyEzBh65vINqNYKtUgDhgk2TVxaEVm5/RPq/IyXHn/pT5Sa2tZx2aFW4LHu+IFtxoS
         Uf+829T0hxKf6bIqjc6sm4BX+Yw7bInPEdudXBZZ6nUyTPRRouW9zcCbPQ3t/yuSW/X0
         C+PeAp7bUjnBjSe9Ebit6ynt55Ur6irhRU7vp7kXDZbLIket8mF7QtqBqeFTGL6Dntxt
         PZBw==
X-Forwarded-Encrypted: i=1; AKwUvBy7v5QWurkuESDeeh1AeaU1zy9/PT7LCLZltZFi6T1kQfYLxFArSWsLkxAHiYpupxWw7U8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq3Exur2HioDDU7B3Y6/xSEIt6Jtv6Tx24uAbmC34+YH8R3yd5
	Cj8cFcP2L+nmYQQJmjGyo9bBXbjnviFz0dFOOGJFJ8DX69d15bvD1sL2EfCE3FgjQz0=
X-Gm-Gg: AYBFou2cXPCWqXBZ/BaJqJXW7bwogFw/coXjadX/FnX+BX9FI8oKX11IvktT2ECz++H
	bkBVKKWtWEa/j23nmBdgfCPxP+Ii0KhzMmCkrmZckyvFLmORqU06+nxeqCLAawXaXUdDvi98+Xu
	HEOH0gHs2rq23On3Fp8W+26Ua5jBCGXpo8fyJBc39mKNET8lqrIPHpY2cs1BpHiq8RcNoT7gDvk
	4jcSUvnqX106WmGKYTYvKdZmX+ScTZ1eXuSJMbo5fbCDqkawkiOuK9Pwb0NV8FV0Q6Cz9nGDZga
	95UmOOle1fmmufT4dhlWmKHLDa6LQGEk3zCAU5+mxJoCWlL1DVDMQVpqLDOFQpwlHqboHrSG7ja
	ajmCXUji5qwEviXyBXltwTFrg2QpexR7xLipNWpYQnyomJyL3V5rtoUtrg4mkRHg8K3paZBFwFB
	Ju+RRwWPho0aWqKohw4Eh2jUSlsENN3ypRMBVCZ2BM2mkNWyCah8an0EFCXrsm18FRcGgbVSZ4a
	VfYm1dioy28deYltC12SdOO+h+SAqC/dhAA1jF78vXfMrxccYSazvqjsg3OH5rtIlE2eZqbSXQd
	vRbg2XVnaUwQfx6Ug4R9xZAHgyj8gwodsHmGgaA+PQ==
X-Received: by 2002:a05:6402:c516:20b0:6a9:a3df:e4f1 with SMTP id 4fb4d7f45d1cf-6b4d4c714a4mr1147063a12.25.1793363198834;
        Fri, 30 Oct 2026 05:26:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:295f::41f:54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b3fc5csm540597a12.33.2026.10.30.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:26:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "phx" <phx0fer@gmail.com>,  "John Fastabend" <john.fastabend@gmail.com>,
  "Jiayuan Chen" <jiayuan.chen@linux.dev>,  "Network Development"
 <netdev@vger.kernel.org>,  "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com> (Alexei Starovoitov's
	message of "Tue, 27 Oct 2026 16:46:11 +0000")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	<87v76o63qv.fsf@cloudflare.com>
	<CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
	<87pkwv5cj8.fsf@cloudflare.com> <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 30 Oct 2026 13:26:36 +0100
Message-ID: <87pkwrtlvn.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 04:46 PM GMT, Alexei Starovoitov wrote:
> On Tue Oct 27, 2026 at 4:33 PM UTC, Jakub Sitnicki wrote:
>> On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
>>> Sorry for the long silence =E2=80=94 my laptop died right after v2 and =
took the
>>> local mail and the working tree with it. Agreed that the ordering fix is
>>> the right one; please go ahead with the commandeer, Jakub.
>>>
>>> I do still have the reproducer (a KCSAN selftest for this race, verified
>>> in QEMU). Say the word and I will post it, or send it to you to fold in=
to
>>> your respin.
>>
>> Feel free to iterate on the patch once you get your dev env restored.
>
> I very much prefer if you Jakub will take it over.
> 'phx' is a clueless bot that sends spam across all subsystem.

Fix now posted:

https://patch.msgid.link/20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com
