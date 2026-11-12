Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794441795;
	b=tNujVo7uKFNA5p+gNS/6l6HNlCx1kRXfKoNHhl0TyBYM7QdAdKcecEooakf3q328v/h1
	 p5ph6jo+s1elIzfNKGfapeGxj07lI4eAfT60aTx9csJBd7Kq1pnvT08QUyqk26GIYek2U
	 4Snbr6QjNkWPJrPIEJFwTrYWttmYNrX3nQx5V+Rco0yRx9DVgMdbIrXnHzR7/+5dHW/6Q
	 pKI8To/mrFwdOtAxTx98hmaVDzT0v1wdXDWEXuhfrl9EF0HhwHNRHwe5gctsforXztVMN
	 kvCoevHBnJUxdeBaw2eBdlMshJD80ll5qpOvgD/H/fb2ZbEh67Q7hpVoaT0a809HL4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
	b=Wd4XpOOYyBSrfNvvQWc2gAp+Zx90/6v7nPXPp3CPiUQadL64VZ+fgdfrNLhEId0i9C5U
	 rlg4OXPOYoPYyv9Ddo/IJDg1vVB6L5wrU79pv3hshKEQqMHDUm6jU3fUV6nRvY0Uur7El
	 CEJp0zGi3BQmBXmskpwhZ09eMCGzGcKdtwfpWXwyScssRcUD3RRwpd31dMQfLeXpdyrLb
	 whHA2OxfgL5i3Mi7nctxQ9mQSTGB1JIELz7z9U7Jzky9es6L5Vs7aMwKnyflxiP+IBgoH
	 9VybKkeOitA8NEsrowwSQuQcCA9I84vFI8MXTC62vszqa3FKj0Xk2J8mBQegRrd7TGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cILHLZST;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D7606A326
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A1D7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=cILHLZST
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6de1fd5f572so1552693eaf.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794441794; cv=none;
        d=google.com; s=arc-20260327;
        b=GxX4GV8qyEa9GTN/qiUbQuvlL8WQYKNHUGp4dzaRHhVG7AToQik0x5sZXWoP2orkNC
         YLIx9YLNKdKi1wLS7ZpK+LbN7Sou/ERTufY64sUEM92LMBjpavVrIkNKIYaC7Sspp5ds
         aHK3jqP645VyL1OHCWqRKh1zEhZSzXKjndk9Sp+M5dONInvBJCV8kpDoQzqTShXcrLp6
         /CXEQSBa+qxjgU+oLJpgHhBARW/QkqCfM9UjulsCtvbRrmqxi0JJ9YNa9/9Qnsgn0DTG
         UWSKClxI0JfcnGfUdT6I6Odjhg2DrNuDvZOqVJtIKA03KlQAhOR2JkkGrSfhcHlnsHmv
         j7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
        fh=evQ81zQF0O4y4VbjEDt4CVCV+iimpwCWGa3P93vE/rk=;
        b=jEgxXck8aaM09kFgWopphq0IeCl1vjMUb9sQ+CAIwEb+QZ2In2SQAeRzc8YaK9Kufc
         wx6oO+sqHfTFwJADHJR+ls9AdW5zHle6lWwfU+9GgVfrhcGJ4/qOR0esUYNnG+SnK2TC
         pPYSiFQyGq4szoK1yiUBnYpAEuoPHSNf2WpALjRjysvouOzJ3mcikK7ySwC5CMU7Ugnv
         5Chv7x4/83yo3DlQ9+Ss0BwP2aaTU7ef6s0ODLc2yr845trf3HWDg4fRGqHMAXXboY8j
         agZ/q6uQKMH+sdNs3ysO8bWS18aReFhrYRMltK4wWvAxxoOSNAzupBFVFuW5mijc5yEx
         Y1Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794441794; x=1795046594; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
        b=cILHLZSTnKQEkbe7N+Oc0kZd1YMJ90v+inoo8hnd/du4Q8+TI7ThmqwGF7mc5pC4Zc
         p3RST8uK9+o/pASznYLtV0Z7weQjU6OIrJgytinvIk4otwF+rNEOKoimbWWnNMqH5buJ
         xCLw9HMNTcZlZTRHoJrN6pcicTv9FCZZeYbCVTLEV3d1vbtkvmzglrLY0Rw0y2iTXn+U
         z7pDnxzc2gWXMtz92BavIWrAnQ1cEvS0+M9IK0CPUjNYAYrv8VaJisHOkU80CgP/RKfw
         MyqjjMvpkeYtcCpkYSm24Gf8unvyyVbX7NIxTeOG3ssNop+SIoW1Unp6JfOBJr+qi4OR
         Btjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794441794; x=1795046594;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tSGqJI9Sfy6jLqsvt9BVccCgWOo1O99X2AFDHy843oU=;
        b=DAKM1FQqoV7G9Qh5QaVk3JtQSsQhWMUMg+nK5InkPuOjkqHUt2bi/fV3EEOGBLvGdI
         ECAeLluTdUqXk4TVFdXeHWTeGWWB8nuu+O5mIhRfkcUZxYWyEdoO2XVQtlLVo5iXC98f
         TrAXpIYiai7moBl9X4kS6ALKlDl6xIdSrz6cBOxuXSOqGo0sG5Qi4fny22U7htkVk8sP
         A+NdulIWZ4ZKGV2BoZVvnVKnDjt332ICvo+dg21LgwzTHv1BG2UDeiR0Rryxeqh8z29K
         kWjLfcFiiTAbgj/AnCjpduis0mfO5o22uPFS+YBAwhW0CcmPKOLVKReEmI0A/P5L2+C/
         lMoQ==
X-Forwarded-Encrypted: i=1; AL+hErHS1moMBS84MQ2G4wG76sNvNZIPl4eLmGPD4d/wtpBD+Ag7s7S3q2sy8p6oPQITPyp05w8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8fgiXyljgHQf/BruIJryPThDXcrMypcNc4ym+y/RKfsY1cjCS
	e/3zQLemCxASS77+SfQFvD9kKiEMUGEZwuWaAo43Jd26AR8LbzcmBglbDVfaMZ3KGR4S4dXD6Zs
	NPtt3ivKiEjY3a5kfk67buJu+/KpPWp2dZOCGFEAdJw==
X-Gm-Gg: AYBFou11UPmR+VeZ8OeHYM9jL8IVCtcqMgm7laPNtgiJ8VP4/w8VMGQ+m9rcohy0m3Q
	OeyJRRiPm8x7KJ4qkKYUrNnFakeD/a9b4JGoWsQdHuNSutAjabsEUjs6jhZGdRfZLKRK12dmGbb
	6NmDpo0/x+wXsOcV7aj/ueBRhNWS27n35a77e7lZlmf+4OcBEAqLGlm9caf59DEVNRzNpeiBoGm
	dAEs5WNef2Gqiu6uzPbMZ+S8dnjbW+kf8k1DUVJKin9GegbaTRWZZbQgZMHGLRnxIdGXMfG3TJX
	JOb1dolZjhfiEUFfGM9IS8f6JPvr21wUFCShcscuhDm192SUWQIyQOgiUuiPvjoYLQgJe3dFUeh
	ReEiwMHPiKQV0HBHYzx2+sMCrV/WJU9PsQ4MqRtHR7DwZlWpwBvjWfdhUE5MWB0kUSVptrTIsv4
	LV4zkQMGquvQ==
X-Received: by 2002:a05:6820:1341:b0:70d:8086:e48e with SMTP id
 006d021491bc7-7191784f4c9mr2405201eaf.20.1794441794070; Wed, 11 Nov 2026
 16:03:14 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794020868.git.tianyi@cloudflare.com> <e90e748e0aefa7cbe1c2b31b8c7902ccf135c3f2.1794020868.git.tianyi@cloudflare.com>
 <willemdebruijn.kernel.1d64e7848503b@gmail.com> <20261107182526.69543-1-tianyi@cloudflare.com>
 <willemdebruijn.kernel.2c6a653eb65fa@gmail.com> <20261108190831.3f991a13@phoenix.local>
 <20261109154909.32748-1-tianyi@cloudflare.com> <avTOvr+yy+2j8xrQ@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <avTSBFpR2t7PO9tx@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
 <CAG4wq-d+LtEi-omGwzgqx14rCp_4J9HztGMpa8ioMsviaPw+ZQ@mail.gmail.com> <avT4CezZCiRhvCXw@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
In-Reply-To: <avT4CezZCiRhvCXw@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Thu, 12 Nov 2026 00:03:02 +0000
X-Gm-Features: AclHuK_s8wIPjsY9dzqaekzO2VZaPxMJTb6Tg8Z4dNlh8vuXp1Ar6fObcRSwolA
Message-ID: <CAG4wq-cyLyxnnmhPvL+ZNmnXGjBp=OsbBNE=16j6WRSVJ8uv3w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: add tx_extra_headroom and LL_ALLOC_SPACE()
To: David Keogh <dkeogh@amazon.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	David Woodhouse <dwmw2@infradead.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Nimrod Oren <noren@nvidia.com>, Alasdair McWilliam <alasdair@mcwilliam.dev>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Breno Leitao <leitao@debian.org>, 
	=?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, 
	Danielle Ratson <danieller@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 11, 2026 at 11:19:37PM +0000, David Keogh wrote:
> On Wed, Nov 11, 2026 at 09:41:32PM +0000, Tianyi Gao wrote:
>> By the way, I plan to support tcx only in this series. A tcx program
>> is attached to one device, so the kernel knows which device to update
>> on attach. A cls_bpf filter can sit in a tc block that is shared by
>> several devices, which is harder to handle.
>
> tcx only is fine with us. Our chain is attached with cls_bpf today.
> Rather than move it, the simplest option for us is a separate tcx
> program on each device that carries only the tag and returns
> TCX_NEXT, so the existing tc chain still runs after it. A few
> questions so we can check that this works with v2:

Yes, this works.

> 1. Is the tag read for programs attached with BPF_PROG_ATTACH as well
>    as with BPF_LINK_CREATE? "bpftool net attach tcx_egress" uses
>    BPF_PROG_ATTACH, so a startup script could do the whole setup
>    without keeping a link pinned.

Yes.

> 2. When several programs are attached at the same tcx hook, is the
>    value the largest tag among them, and is it recomputed when one of
>    them is detached or replaced?

It is the sum of the tags, because each tcx program can push headers.

Yes, it is recomputed.

> 3. What is the exact form of the tag: which BTF element it must be
>    attached to, and the string format? It would help to have that
>    documented, since programs will depend on it.

This is the form I plan to use, and I will document it in v2:

SEC("tcx/egress")
__attribute__((btf_decl_tag("tx_extra_headroom:64")))
int headroom(struct __sk_buff *skb)
{
return TCX_NEXT;
}

The tag is a BTF decl tag on the main function of the program, and the
value is a decimal number of bytes. The kernel ignores tags on tail
call targets.

> 4. Is there an upper bound on the value, and is a larger value
>    rejected at attach time with an error, or clamped?

The upper bound is still NETDEV_TX_EXTRA_HEADROOM_MAX (512 bytes).

- A tag above 512 is rejected with -EINVAL in tcx_prog_attach(),
  tcx_link_attach() and tcx_link_update() in kernel/bpf/tcx.c.
- Several tags, XDP on the veth peer and VETH_INFO_TX_EXTRA_HEADROOM
  can add up to more than 512. The total is then clamped to 512 in
  netdev_update_tx_extra_headroom() in net/core/dev.c.

Thanks,
Tianyi
