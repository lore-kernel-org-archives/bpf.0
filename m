Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899263F54BB
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777064385; cv=pass; b=HnjfXF2HqtQERBTTPkqntV3xjhHEYWt2NSj0Dqzjxi45tqHqgV2YjyOmLCxkiYp9SaSFHtR4Th7ILaeAcFhf5FdoRWsgBlOHZXSgqGdPexPfrf85jSqYUcAvcFGelyN0tRC0CfXWNbeRQENj9b/vrFSoM+VXouZfwLhxgagK71E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777064385; c=relaxed/simple;
	bh=UeH21MWoLZK9qwhPVVQmSENxjvt2h6USDonb8uOfEZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIzhTcJ5kYkEr7lm4Ckvjly2iPcMedjbk3P4ycCsJUBhg3gTBb3rVYFULp1fefOkkS6+p2NjXzNJ/xDMS8BbbwO4mFAEKBNDW4+Y2PY/zRdwTJnivDfgVdETy/0HTpOZ9IOKrKEvoGx1oEJw++aPnLlxs0iU7WbIXnraxWFTdbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AFYxgzKY; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AFYxgzKY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaed195901so36593795ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777064384; cv=none;
        d=google.com; s=arc-20240605;
        b=VtbS9GPkcaI8B5Jb8eJTDi9ktAu5e28lQT2X9kjHnWclpDbTP5w8yfpzDhrHcg3Ya7
         xb5z5UqJj2LBYdI616JyZXSpuQauZTYcdi0/JdfY7ZWq0kKfbMK+jg3CrTFJ0zF9wvBr
         oBvBHpWN17sijYUOITBZ1bFXs3V22akccFBNAH5Oh8pFpvH1jDbUbRT2fEWGrSmGgI37
         44RtWb8JPKeeI544lc1lXKFWP7bsSGao/MLXyEWikXkxLoU9NZMvUBvKTo4i1xQI0aje
         Li092bDdNuTLT3xPQN+z6RaDHpkfOq2R12aSY0o9GWOqutkKjUrBnLDzHnW+bWU1RB5F
         hDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cx20PlWvPq7t/jSP14LCSKX3HGCyhuna9yTPTpknTk0=;
        fh=XWj8rCQEg13I3g/hCgZSbYTC9xL6Ah0BQU/+XGaQssc=;
        b=eetB4RF3CEfGpFoja7MH8yvoEA2jZ5+ZIQHJMmppojyKpbHBWNCHH9i2KzKQugUbi5
         Dh2G76MqABPlNbMoPc1H/XhGWLXQXF4hbtND2uEuKM1yJh0+nLjOGKahQ0tGErMTxE6z
         v1yaVQ7xPcg9/0fbmhy5gtNXt7ES9gq+slK3uxTaEw11/Qdbh7YlXpyTaDcFnoR4ZX45
         4VynjroWBuY4NYL9daKifCIJ/WkE4Z3pPKx4tx3SFREBpj2Nz3pmfKC1TG4Tn/Zlv6Z+
         Xz2zjVSWSUHTkLnokX3UETM1GKr/nPYxz9Lau7cnDy2ar3UYs5EIOEvkeKMbYVdDr1tF
         aLHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777064384; x=1777669184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx20PlWvPq7t/jSP14LCSKX3HGCyhuna9yTPTpknTk0=;
        b=AFYxgzKYRbUDqVkO6uhmxHDIhrpxxUfLe9M8Nc9HTLwwXEU8iJLJ47I10OAByCP2pp
         uUMkGmNNpDr6FjxxFMIRfQrLgrK12q1r7gw1bPCg3dM0BgDPbm+Ct3B+ifv1CSd5fcgz
         vXaE6nCxV81WZ0UE/05xEUWmEcatmb+MA0xfj1kIUNNalWC45UW3Oy6bmqpQa7A8C2GH
         EJx2Rxtc86GS5d2V5u1aL8f6S2lQIe5dNBg33IWreA02sX7/2dqZFzKf/YekFFhEDvBs
         iTyoEj+N2pHryD/mVdnL+d8xAbs+ACpsZohmWh6glBzJ40vxQAeD9huI84+0xkQxnIT0
         I1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064384; x=1777669184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cx20PlWvPq7t/jSP14LCSKX3HGCyhuna9yTPTpknTk0=;
        b=J9VRu9hbnpb/6FX8NEWN8YvfBN3G9JMsn3eOzmbQujuMbLVoWs5nxC0DkoopIppheA
         6vDurOuZqvuzGMTWFBbyrkWEYT/xaOIl4Tw62xOV7O58GyL2AYXoHeW6DBN3BGhdLFNC
         J8IDOF3FFnYTqms0xi9B2hUfmLmHPPZi+RtSzbzrv08IBJbimtOqjBq1gpgkvjndMz9X
         FLVHv8cnPjmxfUx6VvyPJ1ok85sVBKkVe9RMOtBo/79ZUQf4pPUsmmYWPjr7+JJY0Y75
         BL7N6uXWW/XTTMtDeZKvaVNLeNlWJe7mo5XluVnd9dMtNKW6SaE3tE1joqH3y6HVjLo/
         NyBw==
X-Forwarded-Encrypted: i=1; AFNElJ+GCdPv6nO2Ahp2MpOzS1Q7NrjqNKGhHybjQDNm7cfuKbFPnqpUsInRTZDoOqwgdMcYO5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVHAqTJ8crKFT+udHoCNCwuVN7M51VD4UO5lL3e2evNWnEV32
	ZQYyZPwPUBHp+emJnHrfT76qm8ZnspK1TFb+iuNT6yeg2ToNqQRy7GCaihH9gCq35W2+kb+1EDw
	2KXZ/vo+nl1OlLrZr9Tg+O3ABk2m28dJNLB4pn8pm
X-Gm-Gg: AeBDievQyZ9zDY6Bmex3BR5sSOQ4Unp6ErRhbVuQ6GG0fbZ0fTgCd6xhpDveLjf6beu
	RJvhZxPMMt52S8bvyXHi/IBrdLgxQ42gfPWCChPmgyHanTt8scTO9xbE8v59ZfXYMf9mnn2uTTG
	e47xln7xuGahJMqswQy/AGtw5wbJIJ4Pi7iN5pkxnw3/X3s6s11Bo/ssy50VXh7vLXn1Gy4+tAu
	QzRPhGzf8Ux6ubxpIrNrQJvOdHrtw3fZ72Ridl5uZxEAhV8QpTYOHeHvOElod1bRNcirlewg0Ds
	RLOkORI6+qLXCI0XGg==
X-Received: by 2002:a17:903:3d43:b0:2b0:5d60:7f3f with SMTP id
 d9443c01a7336-2b5f9ee90bdmr253173065ad.16.1777064383845; Fri, 24 Apr 2026
 13:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca> <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca>
In-Reply-To: <20260424143603.GB3611611@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 24 Apr 2026 16:59:30 -0400
X-Gm-Features: AQROBzBvtUdT2Z9qKk4YO4TpY44cZkRRfodVGSuPlBOevRtYkwWicMOMpHeLYC0
Message-ID: <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 10:36=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> On Mon, Apr 20, 2026 at 08:58:09PM -0400, Paul Moore wrote:
> > > > > > The access control point itself represents the requested
> > > > > > operation.  This is possible because the number of networking
> > > > > > operations on a given packet is well defined and fairly limited=
; at a
> > > > > > high level the packet is either being sent from the node, recei=
ved by
> > > > > > the node, or is passing through the node.
> > > > >
> > > > > I think we have the same split, fwctl send/recive analog is also =
very
> > > > > limited.
> > > >
> > > > Sure, but I thought the goal was to enforce access controls on the
> > > > firmware requests based on the opcodes/parameters contained within =
the
> > > > firmware request blob/mailbox?
> > >
> > > Yes, that's the goal. It is the same as iptables being able to
> > > identify that a send system call has a packet that is http or dns.
> >
> > I think we still have a disconnect here.  A packet being a DNS or HTTP
> > packet is different from an opcode.  The opcode in the iptables isn't
> > "DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".
>
> I understand that
>
> > Most LSMs will want to know who is initiating the firmware request
> > (the subject), the requested operation/opcode (the action/verb), and
> > the target of the request (the object, which in this case is likely
> > the kernel or the device).
>
> How is
>   system_u:object_r:httpd_packet_t:s0
>
> A kernel or device?

It's not.  It's one of two labels on a packet.  I've cautioned you
about leaning too heavily on the secmark comparison as it falls apart
in a number of places, this is one of those places.

> It is a label for packet contents. I also want a label for packet content=
s.

According to your explanations, my understanding is that you want a
fwctl RPC operation.  That is not the same as the secmark label
assigned by an iptables/nftables rule.

> > As I understand things, the action/verb is going to be the opcode
> > within the firmware request.  If you believe I'm wrong about this
> > please help me understand why.
>
> You could make that choice, I'm arguing we should not, and it should
> be in the object side.

Okay, you believe I'm wrong, that's fine, but you need to provide a
(better) explanation for why I'm wrong and your approach is The Right
Way.  Present your case, but please do it without referencing secmark
as that comparison is horribly broken at this point in the discussion.

> > > - op_X_t is the result of the classifier inspecting the RPC
> > >   packet. Admin tells the classifier to return op_X_t similar to
> > >   how --selctx does for iptables.
> >
> > I've tried to explain how this doesn't match with secmark, but I'm
> > evidently doing a poor job.
>
> Yeah, I don't get it at all, sorry. I fell you are making some very
> nuanced distinction with HTTP being an object but the HTTP-equivilant
> in fwctl is not an object, I can't follow it at all.
>
> By that logic:
>
>    iptables -p 80 --string "GET"
>
> Is an action, and it should get a unique action in the tuple.

Let's both do ourselves a favor and drop the secmark comparisons; I
think it is only hurting things at this point.  If we stick with the
secmark analogy I worry we are going to keep repeating the same things
to each other without making any forward progress.

> > If you want to continue with the secmark comparisons it might be
> > helpful to spend some time configuring secmark on a SELinux system,
> > and writing policy for it, to see how it works.
>
> I think I have a pretty good idea, you haven't said anything that
> contradicts what I expect..

Frankly, several comments, including in your last reply, indicate you
don't really grasp secmark, subject/verb/object, SELinux, or some
combination thereof ... and that's okay, you don't really need to
understand those details.  Let's move past the failed secmark analogy
and return to the fwctl hooks, that's the ultimate goal.

> > certain action on an object.  My concern with your example is that the
> > object isn't what is actually being acted upon, it's the requested
> > action.
>
> Object is a label for the packet contents.
>
> > The fwctl ioctl/API allows a user to act on a device, with the
> > actual action being specified by the fwctl payload.  From what I can
> > see, the classifier's output is the action, not the object.
>
> You can take that view, it is certainly one valid way to look at it.
>
> But it is completely impractical.

Elaborate on that, because from what I can tell that is the valid way
to look at it from a subject/verb/object perspective.

> > > The same way secmark cannot pre-identify all the XXX_packet_t's.
> >
> > Once again, I think there is a disconnect or misunderstanding, on a
> > SELinux system using secmark all of the packet types, e.g.
> > "XXX_packet_t's", *are* pre-defined in the SELinux policy.
>
> "Pre-defined" in a text files in user space controlled by the admin.

That's not correct.  It's kinda like saying the NIC driver sources are
simply "text files in user space controlled by the admin".  The
SELinux secmark labels are defined in the SELinux policy sources which
must be compiled and loaded into the kernel before they are valid on a
running system.  Policy must be written not only to define the secmark
labels, but also to define the access control rules which govern how
those packets are handled by the system.  The iptables/nftables
command lines simply assign a secmark label to a packet; that's
important, but only a small part of the total equation.

--=20
paul-moore.com
