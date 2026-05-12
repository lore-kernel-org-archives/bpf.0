Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F003783AF
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554800; cv=none; b=NiRnU/n7ZIeFV1GOwQZj+jlx+qRem6uHrHoPZLbiCVJrhKYAMnbdU3ytt1C4XcpzrQrkaMJriG3c2ik83nWQNEQ00azblfN6NJRHkJb7GFfAn+km1fwPxw/63p8vw0dI1kJGeRYy/63SDx8S66cEmE3pnnxZg5rwcqrbjTXNhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554800; c=relaxed/simple;
	bh=n50wEEJN1lOHOlcjN3TifmaTGmqHleYwleG2k1BTG0M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rdoCSfP/JR5QvIPEbSNw4XDkj/rWU7pEQosNnh4CwFkJQ4FZ07n+9qQwAk18ukkn/W8uO9ccsQZYKrmC1dsx6LVm0xudLZ8+W7H88eKckHqtWPe1NCx1EmadFmvTOa5/NhTbroMCtPoVF/ghu13jpkR3qDR99wzSs+/z+sCStBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJIB5pcs; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJIB5pcs"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdaf06498so3459817a34.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778554798; x=1779159598; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n50wEEJN1lOHOlcjN3TifmaTGmqHleYwleG2k1BTG0M=;
        b=AJIB5pcsYKSLMPVnvwbV1v3hwQAPjKKADJaAxCjadMNWouJSU+AKU82/+9UYR0pJHV
         Ic5bdn8S/FWaQgiTqRlZPHS3pSDfoADlesIXDmhD7mVQGLwZdGmmsQmsCgX7JjnTZ3uo
         I6nAPJhK0TrT1+d36MHdd+7Vav1pjNT/z8amI8Iows4vzWiSyqBJNboHeolSSBxao5cm
         srKk7a+TzBHYZNJMFS/skkw00Het/KINxI9dGJHxBhIrKnNi0Wc+dAHKaXjv54EcNo+x
         t64471JTgkf+rB8wCpd4lZ/f5C8Rdxq5XVvx/JmWUfxyjBIWLwcjEDG4pKUjzKjCkhPC
         OZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554798; x=1779159598;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n50wEEJN1lOHOlcjN3TifmaTGmqHleYwleG2k1BTG0M=;
        b=LofC08mALt87BKB0wJDMhFWBxeklZrRiLfDOL8RNrz9URgld5pDB4RbxTyjesKfTcQ
         uBmH8UaOjB8dWe9H661jCtPb5oOGPeAA/yuTlZZLE7P641cIU+p/bhNw8hb78VrpVCO+
         LzkvwNYUEqPRiX3hRK9Luy5ZHIzk/eJM4LbfVV3PSIx5m9FHwtA8HgrLS/x5fNpZVj2Q
         46CannVS/JGgekJDy7QSA/gc3E23NOo45ptFixEIc960K6RsiIQT15NJ5Nt/+JVIpHIE
         xKrY3yfyOWnhycPitdIwQpWlbc/TAi9xpciJwaA4y9VVRmMsQ57hJqRxaZrzowscMzol
         aEIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Y1m9cU3LoIdbaBBb/FIfVM61KAw30H7BRvxL2QhD/c/bORZt/AEeYznEu3xzDijkydzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwLMVMcBFI+ysSYLtHuziklpcJnYUm1M9D5DATTbgtQ66UDl6
	uU96AJkd7XE8Yv46xAk09Dmz09VzZiaE5qDhybtwrmygTJi/F2V/LaTv
X-Gm-Gg: Acq92OGkSXVZFFrgOEzr7wTH11OHwA3OPGlQdUjrfcRrkXxbh3xwDgJNVylIi0j6B3n
	IhD2c6L7Phm28C+XCYQW2fl8hAgLxETq+d7pW/lUDlurU4HFFBaxghjWfvpWx0rjBvgCgmM3Xcd
	e8FVaivxyyuFl8DzCVc5uzFRPq3mePCOHc6Dwj7YM+2J1lFW5tFxLPUaIdVTX/a/ABbvH6bfoGl
	7S4i25EiJ+EQY2g4yCRON7thdLis5v3VyprS5qIt6R4vyAqRYAipT59/sZv/ZoC39EtS1Iz837d
	5hx7vm+sMSz+iCUP/uOED6IWUyIVkJi1dEbC1LbErcDBi8M0I/rJf8v4hhS2kxdNlknj/5Rf6NB
	FsiWU8EJGX0+r9qrN7Q2qIyQU9ouMmRYR2jtCq4/xPs42sQ4hPJUDyMnctHIjZamtx7cpfJooPe
	FSPAl1EWuN3a7WEVY32Ag2dqPWH9APxSvObjh61uC72YaG5QBSkKRdiq8aGXuHzwTsVYqJEDUs1
	kbelpxDjMXBanZw64jCp4hB+mbl
X-Received: by 2002:a05:6830:2b06:b0:7dc:e6e8:62b with SMTP id 46e09a7af769-7e3c3f5fb3dmr662965a34.13.1778554798123;
        Mon, 11 May 2026 19:59:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d50611sm8080713a34.16.2026.05.11.19.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 19:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 19:59:55 -0700
Message-Id: <DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
Cc: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <song@kernel.org>, <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
 <20260511182019.69ebc7c6@kernel.org> <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
 <20260511193603.3ef00cee@kernel.org>
In-Reply-To: <20260511193603.3ef00cee@kernel.org>

On Mon May 11, 2026 at 7:36 PM PDT, Jakub Kicinski wrote:
> On Mon, 11 May 2026 18:59:56 -0700 Alexei Starovoitov wrote:
>> unusable toys? What are you talking about?
>
> Please refer to the comments on the RFC. netpoll bypasses most of=20
> the networking stack. And there either has to be some user space=20
> to negotiate crypto or this is unusable for anyone serious.

encryption inside UDP packet is orthogonal.
netpoll as-is is usable and useful to send plain text
best effort messages.

>> netpoll is already called from everywhere.
>
> You mean all contexts because it's used by console?

yes

>> bpf_netpoll_send_udp() won't add any more bugs.
>
> Same as TLS + sockmap didn't? I spend enough time mopping up after
> people.

huh? comparing this to sockmap is apples and oranges.

>> I like this netpoll approach way more then creating and keeping proper s=
ocket
>> within bpf and all head aches of keeping it around and doing send from
>> good context. With netpoll all of these issues are gone.
>> Just bpf_netpoll_send_udp() from anywhere and it works just like it does
>> for dmesg.
>
> No, netpoll is high risk / brittle and tightly integrated with NAPI.
>
> "I don't want to run a tiny user space program" is nowhere near strong
> enough justification to expose this API. SMH.

No. Nothing to do with 'user space prog'.

What's brittle in netpoll? It works today in any context and
that's the main point. All the gotchas were resolved over the years
by heavy netconsole usage. Sure, it only works in mainstream
drivers like mlx, brcm and likely broken in niche drivers.
That's not obstacle at all.
netpoll_send_udp() is a perfect building block for best effort
try_to_sendmsg. I don't see the reason to reinvent the whole thing.
Because alternatives are much worse.
bpf progs would need to create UDP socket, split udp_sendmsg
into who knows what. Lots of design questions, code reviews, etc.
Way more headaches for everyone involved.
Doing full networking with dst,fib,nh from kernel context is complicated.
Works for NFS, but it's an uncharted territory for bpf.
While netpoll_send_udp() is available, easy to use and proven to work.
