Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42041C2324
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251236; cv=pass; b=eeX8VqA0p6juO4i0jNgbBaqFsuZ33WPvJBItfhi0DyREEGzH44XUpvKDMNSy+L3trWKrSWIVGFgX0eD4H1NESpJbLuBrhYqq++Y5BeZzC9JHl204U09UEbxXRw9sLtQ5OpfbBZbBc/JEoHiH6ekt03jGO3449afLEH/ZdZtqfIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251236; c=relaxed/simple;
	bh=wSGZMNIWhO//TQc/kDi8TEO/Ez1Q5EPS2BI5zT0G1W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK3am5ODXx3UyVhTUH3dNRwZMMSvcE/Q3sRaL2fjx01jxN9gEO3CFbHh1ZWR0AhbSS5ybVwWWqfQhmJDvtb0c9V51mUt5rJ+jA8eekdNNpbWkch5vl4YjNwDHGCClna+5KfTbAQEnXAZ4EXqjIzrNdJG4rTQEhOqKOcDvL20L/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoYbVSPp; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoYbVSPp"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124afd03fd1so767751c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 16:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770251236; cv=none;
        d=google.com; s=arc-20240605;
        b=TPK7b9TOgdQ3C4tg7Qxyta7InGcRte3SIgVp+S8HAtmoApS+b9syEdpOX7fSAMAUhk
         TCMZo4Xh3zZMaSOQG7ixNJGRq0zCo0WWd0fbgBzoNO0KTz6fj7xj0dHgchcG/CYHQyLb
         wep02GdiQG40pLYpOz8onjWnJDETHy2dMX6a5h+lZcTwuI5J7sb18YlB7NRHO7koUBVH
         FqNYlLfL4mvCETq5aXuswpyXyheHZ7S+kOm3jFT8gkWCT3qCc2nW8cWXjvxqMnq2qrBA
         HmWpab5aTMwHC2qEWgv1OOwYKOCMvJBXjjNhMtyaatqC2HkBKhetxQr6vV9oDdSk5BAo
         tXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UW1SajXlWqYf0Hyv3s7E9w+wUbGNFR8Os1ePifkbB+Y=;
        fh=DGJhTZTVCLPds19h8irl7UE8g+59bWzp+uRRTQpAYT0=;
        b=ZgRdsTc+A2akMMCtZsp4Wa9ou6u9sQMwm3ffNbhwf07Chk37KZW0V3LYYT3HtWK/d1
         g5FzkWy6FxU1mw+hcMF/gj/Mg1lPP7aaFddSXRwshgAfdoC6YYTi6BehXUsttwnycqxp
         PjwcfGeOCFoJElsNXnIfmGBNQKR8UqxThwtQZ+UKdyUnUOT6sisAoAa5bC/+250y2Xdx
         h4ll2yc78wDypo7RHaKzCQZ8cgW38+KiAAFswBPgLhxdu+bpLwCMQj2OdVPP6tr5mkuP
         /vqSRpAhy70RGbdNvvCKCvoCrbs0sTwJidOIMtdohkSR9xaHAH1jvtW98wOiqymH0JgJ
         2BUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770251236; x=1770856036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW1SajXlWqYf0Hyv3s7E9w+wUbGNFR8Os1ePifkbB+Y=;
        b=SoYbVSPpkh54Wmx2t4AjncnnH3zf7IpTwpOW2agdvb5Lw+zrnkXE9XSCj7vIKomwvw
         M+kJgMvX3Co25XRUpqUvCcTJi1APO9f6KQugG5pzFTJZDv+0dYbmLvObsook4oUwOaC2
         fY8YsSU5NbRJlivgJGl+QfHV+pF2XbfpVlCFFwk4HT1fbstFndyMLtN3Ellkx8IKZpwm
         YMEKQ+lnA1Wyor/wTGqjgtSFWBlldNG6axLCHtetgoZ1fpk9VEuR1FdziSlVHBaJcoUt
         dWQFQ9DzpoWRXgKH9Ro32J9eNeQQTUC+fPRM0ON8BYbSEacmapWj/g/KgvP6vJbDehkM
         3e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770251236; x=1770856036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UW1SajXlWqYf0Hyv3s7E9w+wUbGNFR8Os1ePifkbB+Y=;
        b=FRbT3OX+3H85x0j2yUXNMZb1Q5UkxA55raZes68pgeWW8c7O4WHknYeGIiyCoUTweA
         opr0huIOPKgcpJePAxLn3FqxDHB8YjmmS/MiSDACws8cuyXpSriWlTgH/149I2M2svc2
         RYpclHPjBF4HtpW8nWA4WrJgFJjvJUvmNyXpvDNhykttFJeV6AZBTgNqJNMFYO12mBCt
         TduOBCVu5sTz0AOyQCezIji9m1ZGmSgH2fuw+0LOtgrfihp7BLiF8GAehtw307EXT9Mx
         hK+/Z6nLuRi+G2eyujBW4XE/OtaJgYaOTzcHLmN/KteZdqygII4cELGJoTQAKN7zP7I7
         77Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXSQpk70tF5/lFpTj3qHFLxF3qYA4v1uDWMCzEIMdjQiXpLxwgTPn+n49K6u0rkfrm52Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2gX0d0V5g5sEyBH1L/NSVBXlfQFFxxUlj3s9MBZOWLGEGbD2
	A9HpaYhUH14quXp1FSndGCcB+6kCWdn/igeR9Eujt/vsCtGWHps1dGa1karjlmW4Gt39xtf/667
	HgheoprWms0OvtpZhQb76/tVGCxirgwEVH2QW3mVl
X-Gm-Gg: AZuq6aKEiHmZvwOt5QDXb1SV9x0DSEMg0YCIYDsti2kWQk6fhMHsO6hY1EFj1ACxTTv
	UkU5OZi8ZYRuQ4aAKy0geO/tDjh16IYWQaAaWL1nhy5Y50aWZQzN7d8COWz7mEjaRzI3wXW+W4E
	sd/wiflulddqSYyEM+CorN4fgX2CupVGhLZxM5Q3KIh62e5Vlgr8oyWtkX4BxKfWtd5tItO6qsW
	b7JvEFXrDBJg/mjtS+qEhPjmZ95TNji1ckxFbxftsm/SKDFdhTfP7zyNFdi7U2txW22xpYLndEj
	0EbBcWk7KWQZeu8wWNwcqlBbFKqKqwTnHw4Ye+B6KhFcTyrMkdA8MC0j
X-Received: by 2002:a05:7022:127:b0:123:2dd0:10b9 with SMTP id
 a92af1059eb24-126f479db5dmr2185487c88.20.1770251235294; Wed, 04 Feb 2026
 16:27:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co> <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev> <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
 <408569e7-2b82-4eff-b767-79ce6ef6cae0@rbox.co> <0f8ec4c7-5de4-4e0b-a50e-cf4f8d59709b@linux.dev>
 <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
In-Reply-To: <37a594f4-a951-4283-80eb-67b6acecf61f@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Feb 2026 16:27:04 -0800
X-Gm-Features: AZwV_Qg3Ao_jkZiH5CFGA21_xhVBJceX5eso95X0_82kyEb20mWSlCtn132I1Uw
Message-ID: <CAAVpQUAi2WFMz3fZutKgJGjVnMh8LMiw1GM+M9L-Gt-NuHghBg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Michal Luczaj <mhal@rbox.co>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 3:25=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 2/4/26 20:34, Martin KaFai Lau wrote:
> >> But then there's SOCK_DGRAM where you can drop unix_peer(sk) without
> >> releasing sk; see AF_UNSPEC in unix_dgram_connect(). I think Martin is
> >> right, we can crash at many fentries.
> >>
> >> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0xa4/0xb0
> >> Read of size 2 at addr ffff888147d38890 by task test_progs/2495
> >> Call Trace:
> >>   dump_stack_lvl+0x5d/0x80
> >>   print_report+0x170/0x4f3
> >>   kasan_report+0xe1/0x180
> >>   bpf_skc_to_unix_sock+0xa4/0xb0
> >>   bpf_prog_564a1c39c35d86a2_unix_shutdown_entry+0x8a/0x8e
> >>   bpf_trampoline_6442564662+0x47/0xab
> >>   unix_shutdown+0x9/0x880
> >>   __sys_shutdown+0xe1/0x160
> >>   __x64_sys_shutdown+0x52/0x90
> >>   do_syscall_64+0x6b/0x3a0
> >>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > This probably is the first case where reading a sk pointer requires a
> > lock. I think it will need to be marked as PTR_UNTRUSTED in the verifie=
r
> > for the unix->peer access, so that it cannot be passed to a helper.
> > There is a BTF_TYPE_SAFE_TRUSTED list. afaik, there is no untrusted one=
 now.
>
> What about 'fexit/sk_common_release' that does 'bpf_skc_to_unix_sock(sk)'=
.
> Is this something the verifies is supposed to handle?

sk_common_release() is not called from AF_UNIX and
even other helpers accessing sk->sk_xxx should trigger the
same splat.  Moreover, any read would trigger the splat at
other functions like sk_prot_free().

We could sprinkle notrace over the kernel or have a blocked
list for each helper in the verifier, but then we need to inspect
all bpf helpers.

In the first place, it makes no sense that someone who knows
where a pointer is freed tries to read it after being freed and
complains about UAF :/



>
> $ python -c 'from socket import *; socket(AF_INET, SOCK_DGRAM)'
>
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> Read of size 1 at addr ffff888128312112 by task python/4076
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe1/0x180
>  bpf_skc_to_unix_sock+0x95/0xb0
>  bpf_prog_70a8d38bd5dbf399_release_exit+0x87/0x8b
>  bpf_trampoline_6442556594+0x64/0xd3
>  inet_release+0x104/0x230
>  __sock_release+0xb0/0x270
>  sock_close+0x18/0x20
>  __fput+0x36e/0xac0
>  fput_close_sync+0xe5/0x1a0
>  __x64_sys_close+0x7d/0xd0
>  do_syscall_64+0x6b/0x3a0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
