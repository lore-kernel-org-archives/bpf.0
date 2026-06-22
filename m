Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69E1C5F13
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171260; cv=pass; b=cZ1T3unW0zXQUYI8RAGLdPAj8l22rEVsuAEMHffu/WolYAWq/IqoqbS7JrIEr9fFweKTPJEXZYYX6daaiNNvEgB73L9X+YLNc8hY9l6eHYCdQn665hiR45vrKEvyrAfhUwjGd54M9DcacjNUNisKC16YKq6zWPR/KLR/jIcfuZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171260; c=relaxed/simple;
	bh=/NZH7CUDL0CkBDCC6EjEXPwjJ2ho3pwlwDRg4cLv2SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLtIYuhyoNyGyf5/gQ4U9mFJTiF4UFdZxjLJgq1LMo5S0gwgBrV6zl9t0ySqS5WRGxfw/vnzSU8TrA8SmE7qU6HQwSNSD3rApFeHil+Si5eVcLRwQ+t3eV4HSiNzVFUPVkDSR1dp/sBufFwdupcf8bmgIMXBmEUXwCNRt0w/wOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cGfrmY5b; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cGfrmY5b"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8894387780so2115435a12.2
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 16:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782171257; cv=none;
        d=google.com; s=arc-20240605;
        b=dgJ10gsxy8H0DUWjVse1DLx18idvi/d/uiUNL3C9re7GEhzlarQDBjx9Gqty0NZWBB
         h4jtjaEQFY1ONmZe+q32iNm768F1PcPrvTfo2ZyIc3w289nPH9HGPALgkJ7iRpbtKbBv
         8ttGT+kxKZIA0LvU+78CShA6xjwAF/f2pGdHGUc15vXFkRFz1CKga02goDqKU4Ot029T
         gvtCdCpgDwZ5a+hA1WzszXAdBYOntjeSJi3pKv2LJAiCNsywpF7bSIXq0CuPlYj5goA5
         wUfDEdiq/D8AnsBET9Q0qatDD97cj2ZBIe4mwR7pWvZ3/NxpkvbB7bL6ADL5DqHX7eZa
         QOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ouzSUEbSx+tH19jrVTA595wI3Lipv4w05V+9kgdiphc=;
        fh=g7NNNzopNkrG1Wyf0PQDOUpc1bne9NVrT1AQLCLMrLA=;
        b=XvMry4+Of1oSGvHraOc65DVOJiHLcP8kAk9QelWRidi2x/C1mhGfPMZLWf2wIT0Pqg
         sQHLpAjcX3lL0TlTKIVEgdWURQ1pHgFE0RveTVlKBp/2j7KUrgxD+c9Q5C8SXdKHE+f8
         p+g3RWX90X9F670HtWTW0gwoahUmbxVK23vmi8cFBOeOac6CfY5EyxQpl6+qglnGPZw3
         YY+3TnzD4bKK9h7I8zEyJe9uVBK7rbCghSdxNBqnJLOsjabyIeSI0OfBErAyPha+Qgf4
         KLC8eJsuO3Ow/6h6zVi1QgoLZuiEl9mPKVxg1BVFHyBVVVg/j1lx4iOiwX++PW7548oS
         0LRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782171257; x=1782776057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouzSUEbSx+tH19jrVTA595wI3Lipv4w05V+9kgdiphc=;
        b=cGfrmY5bzGJ3O/7XR2RBnvLJDf5gGi1fyVeQD1eTvyh1K2WDP72JmXL1JekSiy7uIH
         cwzhJf30WVZn5eYtB3fDD9SmO/t9WtNQoz+4tTix61L969wxYpymyohXHCmuO9fLEIHw
         4wn2b2DNRPykZdN2CZXuOlvlPorRQKKJejIeDxGy14dBwihrLxk6f2jUwXVsWAk8evlk
         +3HFXf63JlVwJzFu88TV0+zZLfYcXaGb5VT09Q6gy8NBzoXTrgX8RGa1QnbSNLj4Owgr
         ogOQIwZZfxH2U/cHlifEYwCYJbkPiIQq/8Xlu5rGPiTzSgqnbMBEdQwBxYwQTmH+dnhv
         Jd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782171257; x=1782776057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ouzSUEbSx+tH19jrVTA595wI3Lipv4w05V+9kgdiphc=;
        b=EduQnob0rtNbyuCUSE0TS1zbVi2O05E+EK6jWf8oEWYJN8pFR6oM+rWWcDVSJQY3pb
         FTqXFFtzfHtDo7zyD2gc6yZycg1D5CXG5EEI7T2l2h3G6hLX8XwSrR/8G7vIIPp56/GZ
         qO/RpelQI6oNmwDRW6Guo3/wVF1vEmr+EPoBXUG3p7MREYnwR3Av6IXMb3pSbgVOXKEy
         xwfWoVEtRdCfhCjXed9bkZu2wlTdDCWlCKJjsR4UvRXQFAIsPNWSYisxjygx9g7xwinx
         a4MTC1VPgy13s+SfNmWTLxYuoqfJCUhIIw4HVblzE/0a2+UM3TSHLwQ3kzzGa2UAhPH2
         cGQA==
X-Forwarded-Encrypted: i=1; AFNElJ9TeD4A2mt5PEWkbtn+uBn3pzeRrHqwVXxXXcDYI0HdeTPwT/o5H2r74xMGs2Y7um1ubZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pz1vAmnaqo17z+q/UZe5i8A2RusYXV6i50csrQ0yf99MjkLw
	7wHZYIpQ/Jya2zmTCMZKR/uR/6G3igF2ldqyNNwZY7Ik5d5zEK9sYOyKRWkrnamg35wK+qPE5Sw
	nUmP7dfTrvYklPzc7zu26rhUP4rjd7THVaUF6qSlD
X-Gm-Gg: AfdE7ckrAeNpAx2xAInFXR4XzkUgLukyCzvDXQTWfKjxfN0+HDmZMlI5cndYt3i6qkR
	n3G08A2zCGSFnnr1aCyqylkaV7G+YIgi9+DkrDrL/EGMi8+/CDLnBtrrVkq0tFrMk9WEC3bsJKO
	uUdNyk5l4Gn5ZyP4QXUdjJvfmN/YCzSt5RbA5WX5eFmuVgxABmURiUhKdFWBvXWFeJihxJi2A0y
	EsCJlc61IdiWBvHF/9D4+Ay4+M83+Hz1f3arWwC4L0nR8SMuhBRnqhjAs16W+NbbsnnOXsHVNTN
	yF38jMxvriAnPFQZB7P6YWwqqnzl
X-Received: by 2002:a05:6a20:4391:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3bb324241c0mr18478270637.19.1782171257148; Mon, 22 Jun 2026
 16:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620201531.180123-1-xmei5@asu.edu> <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
 <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com> <20260622155854.75977aac@kernel.org>
In-Reply-To: <20260622155854.75977aac@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 22 Jun 2026 16:34:06 -0700
X-Gm-Features: AVVi8Cf3SbUOBGmwse685yVa4RQSSzDqgZs0uYBTQhtoiGuwf8j3_ixHdVFDuc8
Message-ID: <CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in xdp_master_redirect()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Jussi Maki <joamaki@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>, 
	Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 21 Jun 2026 18:28:09 -0700 Xiang Mei wrote:
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 40037413dd4e..6037860d5283 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> > > >       struct net_device *master, *slave;
> > > >
> > > >       master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> > > > -     if (unlikely(!(master->flags & IFF_UP)))
> > > > +     if (unlikely(!master || !(master->flags & IFF_UP)))
> > > >               return XDP_ABORTED;
> > >
> > >
> > > I recall that when I previously modified this code, I removed the
> > > !master check
> > >
> > > because this is on the fastpath. However, since this is a triggerable=
 bug,
> > > I think adding it here is fine.
> >
> > Thanks for the review. It's difficult to hit under normal statue, but
> > the bug is real.
> > We have triggered this bug with a PoC plus GDB to pause one thread (no
> > other `cheating').
>
> Can you double-confirm that this triggers on current HEAD
> of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
> NPD when removing a port from a VRF") was supposed to prevent all the
> torn master fetches. Adding VRF folks to CC.

Yes.

We have triggered the crash on 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0,
which is the latest for net.git, and 2674d603a9e6 was applied. We can
still trigger the crash:
```
[    0.516445] BUG: kernel NULL pointer dereference, address: 0000000000000=
0b0
[    0.516448] bond1: (slave veth1): Releasing backup interface
[    0.516732] #PF: supervisor read access in kernel mode
[    0.516733] #PF: error_code(0x0000) - not-present page
[    0.516734] PGD 102597067 P4D 102597067 PUD 102598067 PMD 0
[    0.516736] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.517948] CPU: 0 UID: 0 PID: 133 Comm: exploit Not tainted 7.1.0+
#19 PREEMPTLAZY
[    0.518320] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    0.518796] RIP: 0010:xdp_master_redirect+0x5f/0xc0
[    0.519019] Code: 00 48 c7 43 10 00 00 00 00 48 c7 43 18 00 00 00
00 c7 43 20 00 00 00 00 89 43 38 48 8b 45 20 48 8b 38 e8 94 a0 fb ff
48 89 c7 0
[    0.519795] RSP: 0018:ffffc90000003b98 EFLAGS: 00010246
[    0.520028] RAX: 0000000000000000 RBX: ffffc90000003ee8 RCX: ffff8881026=
8cd02
[    0.520336] RDX: ffffffffc0000654 RSI: ffffc90000121060 RDI: 00000000000=
00000
[    0.520657] RBP: ffffc90000003c18 R08: 0000000000000040 R09: ffffc900001=
21000
[    0.521003] R10: 0000000000000001 R11: ffffc90000003ff8 R12: 00000000000=
0000e
[    0.521322] R13: 0000000000000008 R14: ffff88810268cd42 R15: 00000000000=
00003
[    0.521617] FS:  00007d34bc6546c0(0000) GS:ffff888197ac5000(0000)
knlGS:0000000000000000
[    0.521964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.522215] CR2: 00000000000000b0 CR3: 0000000102590003 CR4: 00000000007=
72ef0
[    0.522513] PKRU: 55555554
[    0.522632] Call Trace:
[    0.522747]  <IRQ>
[    0.522841]  bpf_prog_run_generic_xdp+0x39c/0x3b0
[    0.523057]  do_xdp_generic+0x1a0/0x350
[    0.523221]  __netif_receive_skb_core.constprop.0+0x5c6/0xce0
...
```

Thanks,
Xiang
