Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F923E9C36
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948942; cv=none; b=BuEGjurM7XDnDStexhSztlu3TJyZCuuRgWhEMupZqLkgTbWTx3pKz5H9grNxisDZZCWRIU3MyEmjGqlhI6HzQoNWL3pmNg+zIy30Uv4RQfQLyIcqegwYvJEj4uJ6ZQohu8vy7TaTKQ8YihA9UdyZNnz9OmCgDGIFcGFFiNCenyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948942; c=relaxed/simple;
	bh=wrqE2O76YCV8wdY1YPpUUnMYdTSt/lGtjLT9N9f7KaA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XWFaDkFokTO5UeZscS050r2xlgLLQ/GNvCtGh9pHeRAkb7qJ6w79UQS6Jn2rpz8fYbFF5bCGHbmEVR7ejxaD/jT+6IInZ8kpmXKdISQfCUWvDOq7yf5KomBf3CmcuS9tifjRgl3D/+TBn/xAHt/BRkrIRmvHDEcKt3jfuYRpDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaGM42CN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaGM42CN"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b5dfde3cso2574270a34.3
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948940; x=1781553740; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwrxcif3XUtEKF7lrhb7eyL0FpVd3GzB9U/X8qwd09o=;
        b=JaGM42CND++GVCO/APZTAt8fet5/AfRQBUcUWxHYxHHqZInMxKQbF6OT3FmXDjtx6i
         ozM356muRW6wHE7nxLSzn0SpJLwzCmam74OffTWA0QxKNXp2uBjvUKkWZHa5Qn2qSMvL
         LUMkkAtJm/hr/K3MutMWwkwk9vP0EL8d053cguGLhQO+eWhd9DcMNR1Mp9om4+fpp3Ne
         R6SlRzNODEgUPxSoeYrLPmWT5FDBkX33xxLwNapI3/HMCNc2SEWNQmWHBOZPmRQYpqpp
         +PAbwSpx/A6u4EDuoiFZcwRcVVsnSb9x8xXTMxRMeUutezTmyBN38WGw74RGHhb8To9j
         5amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948940; x=1781553740;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwrxcif3XUtEKF7lrhb7eyL0FpVd3GzB9U/X8qwd09o=;
        b=hQHK76hHICHatG+C5GUoLl2IYj8FktC9RqdmJfe523SvrcVuvQ2/YsOMsVpYEbqV5j
         +jskEutwlzIBdfj3WH2tZpVez4xhkV6HhyMJhyhO0V9k4utizLTa026LUo1oooJVl2XB
         RY3cXmlcHotLuCulsX4nnA7MsgZvQWbmlXwd0ChGfvCp4QzYOYlyAj/cbv/c0TkR2Tce
         fxn64D6uSTo3mO8X/Sl6ILOlgtNkQQdgwTwc9IlcwOYDxeUG6aanMR+fN97vMy6FgSl1
         xn7cg5dNUTmHl/bnvQlSQxm92AcwZHZeAQpleDlMpWs0eP98SU7VZHAcgvxN05+rVGn7
         Uqaw==
X-Gm-Message-State: AOJu0Yxwa7WM25ltJn+eE13CITERlCDFpQAs0fuldiiJndShb0cHoar5
	ftWBTwhpPGVR6jy+rUpi+PWf68UFMV2+TL6UQFKKkwpoMmV4LCfQvTKGsLyWVg==
X-Gm-Gg: Acq92OHFBUtne9DzpYxVZrdy2FMFyxElfLdhYmTmJyVKCPC3/g1JIDk1M6TUqSj1yRt
	BNW4QuJi9Hnfyyz/YGq23w/VFQC1K91Diy3F5mq7pyeOUOpCmRpOSdWKIQg7kg4VKz76twuMCDd
	U1ZAX6BhfSASOZHGySY4o5yhVT3qHSWiDNbBu1PtfiVmuiId+8l9jm73EtvfwpwU+sNvwADwzIN
	vCIWIg+7vbB0dzMhv8Nj9nsETtkNM8T2CpoiAi60b2w4Ki27KWRYTvU2LYPVyNACOS59F+doesu
	sYoGghD99mfNP7FfU1q7nFYN4X2ULPVLDLTBem9P5DNxriLHF59fboBbNylUXL7XeRB1/B2wUkd
	jQ+ODBP4nHooqWK9RPc8F0zLdJEQ4f/jJ65l+mRHSddZxG7ppBwGwoaRom7BmRwTw0ZDZ8kJvkb
	Q9MsdWxquaJ0wsXKPXfs3f+HXs5hAwNt714vwXTnMIM3WKF38nH6GbrFtGu7Tlp6E6188KwZVMX
	nMjXvdO4zUhIIP0JS+BTJ7OAnC+BC4FM0+/iks=
X-Received: by 2002:a05:6830:902:b0:7dc:dd19:7f53 with SMTP id 46e09a7af769-7e70c7906d4mr9896252a34.14.1780948940066;
        Mon, 08 Jun 2026 13:02:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7923af1sm13046364a34.20.2026.06.08.13.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 13:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 13:02:17 -0700
Message-Id: <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>
Cc: <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Joe Stringer" <joe@wand.net.nz>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock()
 for BPF-assigned sockets
X-Mailer: aerc
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev>
 <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
In-Reply-To: <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>

On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>>
>> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
>> causing a panic when the skb enters the wrong L4 receive path [1].
>> An initial attempt tried to fix this in the BPF helper by checking
>> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
>> this check via a TOCTOU attack by modifying iph->protocol around the
>> call:
>>
>>     iph->protocol =3D IPPROTO_TCP;
>>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>>     iph->protocol =3D IPPROTO_UDP;
>>
>> Furthermore, bpf_sk_assign() has had the same class of vulnerability
>> since its introduction =E2=80=94 it can assign any socket type to any sk=
b
>> without protocol validation.  Since the BPF helper check alone cannot
>> prevent a malicious BPF program from crashing the kernel, add protocol
>
> I'm curious about the BPF maintainers' stance on this kind of "bug"
> where admin tries to shoot oneself in the foot.
>
> I saw Alexei said this recently, and I guess it applies here as well ?
> https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWHDQu2=
OWQx27_w@mail.gmail.com/
>
> ---8<---
> Not every "bug" needs a fix.
> If a malicious bpf user wants to crash the kernel they will
> find a way to do so. Especially with agents.
> We cannot realistically close all of the holes.
> Right now the priority is to fix the issues that normal
> users can hit and not bots.
> ---8<---

In addition to that I have to add that skb_steal_sock() is performance
critical path of networking stack. Adding runtime overheard there
because bots can find a way to abuse the interfaces is not a good trade off=
.
If there is no simple way to fix it completely on the bpf side
then we have to flag this issue as "won't fix" and move on.

