Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794586921;
	b=f8pj8SvAtkKfQp9M04JGtUDUhXh4bnAjV/VYMxjJmtBGZsJsiWRfH8cQQ266IuOr3kaT
	 OO1TmJKA2o/RyJqh70v3ew4z4OIww5rW4tpinlmB4VsiFo83T7aKExq18+kb7Ljv4CW4b
	 SX340/N7X1qm14UBsOqHhIADwPXq/nLUO66jtlcKPzJt1FWARc2JcHJu/NLoBzrsYOGtD
	 uzuAdMv3jsQEXWaxnTgmmKuAMkjSmK/e50Jxkns7IOtYVyOsbfSCw4LZM9bKSRg158LDw
	 kdLMz6vkI0rkn/8klNCZX3aiQc5xV2RleI/POZCH7H2ZlT6YJ0jD3gr71xLIDU2L/Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AXWySdsJT/b6ARZl7LO47tMMgeNKnSyajK6pLbSeVIs=;
	b=zFdomrGWGfhMRur/TS5hE9ZOguT1LNiztukwumvmo4PAW32QLZZPZg3B8/9GcQtB/bHO
	 EitejGJ81WZOc5z4T9HNXeXA7X3YB3Ir1nb6GInDQOhYVWK9fjr9BxvvjajzS5vPORy/P
	 qxJAPwpVpMDAUO27MA4LIZLI8Mek+gk/JXWuzgWn1L3dZjrjezuZCSt7lpOA22L0ZlqUg
	 mvhqEN3C1Qdlh946gZ26QB+VponRooiKmQCZ2+u8NkJu8n5h7xDzkhfZbkn1qLQluSDZK
	 p13KY2Qb/q+mD1UlUtPqHFcPy5hUAGnZicxPwtT6MUPrd6wVX6wM0DfgyCofvvsZYJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WSXSLLkI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC7606A33A
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ACC7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WSXSLLkI
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b2382bf051so952919b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:22:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794586920; cv=none;
        d=google.com; s=arc-20260327;
        b=kSPreVd9dZ42R7lM+wjKOR8z3SKIkwn1Rniy5Ybt8IPBo1VQBYPjookw1E8hbmSmlq
         8jriZys0w3SOZyc3g5wTsAv/oq/TXN0w34kq2VQiyD2GRV0nRyYrs3jKj2PApwWIB/jE
         ucbxhBde+F05Ag9QGRvfFE9x/KMWTSORR8aEaevtdbg93fwu1jStZdkfbqQxNRzjpnUY
         uRbznJVP71R6xdlBEfMQsTA7HwgcL8JGZJolXtFhYk65ln8oii20WT7ZuYjF8FdK2Day
         /bGXTgKYi5DKl0m1qrmqMzjuBEUmxEc3O538L/R8xRuMklDjGkDyrulkebWEmmVwV1LI
         0VFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AXWySdsJT/b6ARZl7LO47tMMgeNKnSyajK6pLbSeVIs=;
        fh=YooAmgwbO+Rgqm8et05q2V5jrVGlK+FPdQH/yqKYltg=;
        b=W2acjmc7jW7irk2etFqeIjqa/NyYl0WOUWWxAAw8D7vuiLZwXg8/lamkjTEntmYQaK
         vCfZVWerY3Ga1hRcCQkTiCgRHzlH9l2UcNNqNVajPcOUDK/Av5p1cJ+FMxn83+iMx/jj
         4mjik4KxO3FIuadIDwGdbResBK12oObIoR6WY/9yeHpPVT1+SWyEoEiPUZpwLZnkZvEP
         Ft3KJUQi0/myETLrzG/m5zPT70vyM+KAv9bApEqaFRMgCGHzzNv/s/1ucV3FUpQmZeY0
         aZtBoiidx0CGlpAIK32jIdJomiS5uxaSFPNmNnVBpre2woCOiYzL+fFi5twjFECBIaJb
         hHGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794586920; x=1795191720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AXWySdsJT/b6ARZl7LO47tMMgeNKnSyajK6pLbSeVIs=;
        b=WSXSLLkIUvE4WMH1l7pADj8xnyhpjkSL8o8eIg73sguWAbm+NKJG+OzvpjjcdDbPRz
         AU+NNMBE3aEudEhmmWYV523KprZKCkKuPTjwO5BcE8EqiWdq/ozZyQYz1pFm216jjh/2
         7SlVCpf0DUnwcBZgtYqtagAbGuBGStbbOCbyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586920; x=1795191720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXWySdsJT/b6ARZl7LO47tMMgeNKnSyajK6pLbSeVIs=;
        b=mmFsBJABgAU/xbTiI92/0pS9zLyaRq9hdsiZ1/Ne6SD8Hh2IncdGdKsCqjpbOlaij2
         ATVclOGmV9bIRYu8B3ydrfZJ41TIPImOooAEFiaTYsPhG9FDvR+X1ruM1lsK/EyOoen+
         RqtgqDVbIPhYE3iz29mx4H2GuN132OQjp6H6xridodNWG7cVn3J9oLLN1prlowWkYR6K
         8dWKxArqpRNapq4wJ2TFwpz8hMHdPNo/9J41PpMsGHsBPqbfoqad8lT2eaR2hGP5P6a+
         Lgs4R0IicDTYVH6CPHK19fqDsdc/Mn4Pwj51sCqJGRzD4+FrXN2O75H+6Ch3WRtN79NR
         xsFQ==
X-Forwarded-Encrypted: i=1; AL+hErFccr+v9aunfH70XYqgpi/Nevn2A/qOynHjPUzE8LpMDmFI/tqG3PhW/eSsrArBOPI8U7U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cnc4XWLzmgmheAFFBsn22qvzo+sAaFg9DeWtREPbqVpw740VY
	qXhZff6BM/qMG6Wf0fyjz2YwdoyxRobXCQHkyjQyAJBGPiaNi6oFoHdHAGHhO12aXW5m/VGws+J
	987msSuo5CnqYZv2IunPOlvwnIyAL+SislKUIH6/l
X-Gm-Gg: AYBFou2wisR4LnWMCUCV4v+hc+px/H2D98tlraPbMlVcjQycCuLW4FuaTLS1O9aZVNK
	7IZGiCFqUtZO4GLlwvGXMmuUgANPJW9fOwRk6+9HsydFLb5eQVSZNKgH88SmdFsKMhA26i8uXCb
	ikxVIiuf0DG9MAmWVxvndKduwnzY/LzoNtoOJ4WzSWY1fHtjjLqtWTfDdH1QUsGz21pHzWTXnDp
	AHSleUG0lnOAsnTEcHN/ix2c87/WHGm9Z8OoNxXsCjwjk4JyPdEKTaiyfJMiZMPgUAqJj0O5C6F
	tkDf1HvjdfhrmfWQyX2UWZSxsPVd4eE1WbRBMrCUvSpiLTU+crRuSHg5ZclwTlnMycuq8W0BHJB
	lpqurDjFilB2o10/78wRV1XmYT+i0PFjmfpk9Flx6vKqYfEu9AaDsXHpI0lbWZ/ewi2QGCn0BdT
	a5Rs4ix6c0koipN3s=
X-Received: by 2002:a05:6a20:9381:b0:3e2:1787:da07 with SMTP id
 adf61e73a8af0-3f7a85d9785mr2549276637.56.1794586919509; Fri, 13 Nov 2026
 08:21:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111005533.6436-1-toddfreed@meta.com> <CAM0EoMnPM54re5-WKyWgwyoz0cn1uGT6=E96OBG2-4m7M+kx7g@mail.gmail.com>
In-Reply-To: <CAM0EoMnPM54re5-WKyWgwyoz0cn1uGT6=E96OBG2-4m7M+kx7g@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Nov 2026 11:21:48 -0500
X-Gm-Features: AclHuK_WchFQemFFneVhxYWD771z7b7Pku7xwYTTzX6oI2Q8HVhFQ1mkhHj7XwM
Message-ID: <CAM0EoMmrRrmPdXPKyiQgEHQSb=mq3uYfNc69hEKw+Rw1EQAzmw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/15] psp: introduce socket-less associations
To: Todd Freed <toddfreed@meta.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Wei Wang <weiwan@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 10:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Tue, Nov 10, 2026 at 7:56=E2=80=AFPM Todd Freed <toddfreed@meta.com> w=
rote:
> >
> > psp associations today are bound to a tcp socket when created. traffic
> > on that socket is encapsulated in transport-mode psp, and encrypted.
> >
> > this series adds associations which aren't bound to a socket, which
> > allows psp encapsulation and encryption to be applied to forwarded
> > traffic. you can use this to transparently apply psp tunnels to flows,
> > with help from userspace to manage the tc rules and orchestrate key
> > exchange.
> >
> > the lifecycle of socket-less associations is managed over the psp
> > netlink family. socket-less associations are stored in a small registry=
,
> > and are addressable by id. the registry does not contain socket
> > associations.
> >
> > socket-less associations are on the device's association lists, like
> > socket associations. rx ones are therefore marked stale by key rotation
> > in the same way. in this series, nothing acts on socket-less rx
> > associations on key rotation. instead, userspace should replace decap
> > rules for a SPI before its device key has been rotated twice. a
> > follow-up will bring enforcement.
> >
> > series structure,
> >
> > 1, 2/ prepares psp to work with non-tcp packets
> >
> > 3, 4/ adds the netlink commands for managing socket-less associations
> >
> > 5/ adds a METADATA_PSP dst which carries the socket-less psp associatio=
n
> > on an skb for tx, and the transmit checks for it
> >
> > 6, 7/ keep mirred and bpf from sending decrypted skbs from egress to
> > ingress, since skb->decrypted depends on direction
> >
> > 8/ limit time-wait psp socket validator to sockets actually in
> > time-wait. the new psp actions check for presence of the validator
> >
> > 9/ adds the act_psp tc actions, psp encap and psp decap. in software,
> > encap is egress only.
> >
> > 10/ adds flower matches on psp header fields, for rx matching
> >
> > 11, 12/ add drv-net tests (netdevsim and hardware)
> >
> > 13/ makes tc-testing run dependsOn probes outside the test namespace,
> > where they currently always fail
> >
> > 14/ adds tc-testing tests
> >
> > 15/ Documentation for socket-less psp associations
> >
> > a following series adds hardware offload of the psp actions and flower
> > matches, psp tunnel mode (which is offload only and therefore not
> > included here), encap on ingress (also offload only), and the mlx5
> > implementation for switchdev mode. It's available in the tree below.
> >
> > relation to the psp fixes in net:
> >
> > this series is based on net-next, and overlaps with "psp, tls: don't
> > send offloaded contents in cleartext" in net:
> >
>
> I looked at the net/sched bits also looks like the two sashikos
> already caught at least two issues i would have brought up. I have
> started a test run on our test system to see if anything pops up; i
> dont suspect anything will show up, but if it does, I will followup to
> this posting.
> My suggestion is you address the issues brought up by the sashikos and
> spin v2.  I will review when you post a v2 and possibly add my
> reviewed-by.
> In v2:
> If you have, or can capture, the decapped-GSO packet shape that leaves
> the L4 header non-linear (gro_cells/vnet_hdr decap bridged to the
> act_psp
> egress), attaching it to the v2 would be useful evidence for the GSO fix.
>

My bad - only one of the sashikos (gemini) responded. I suggest you
wait for the second one. I think it watches this gemini sashiko and
tries to come up with more clever findings.

Here's my view after trying to see if we can actually reproduce the claims:
The only legit thing is "act_psp, [Low] missing .get_fill_size", you
need to add that.

act_psp, [High] "GSO skb with non-linear L4 header -> OOB read/write"
- this sounds like BS/false positive, but the burden of proof is on
you ;-> If that code is broken, then a lot of kernel GSO code is
broken from the grep-ing.  GSO skb's transport header is linear by tc
egress time.

act_psp, secondary claim that the transport_header write "defeats"
psp_dev_encap_ok() - that also looks made up.
Double check.

cheers,
jamal

> >  https://lore.kernel.org/netdev/20261111001831.3710881-1-toddfreed@meta=
.com
> >
> > when net is merged into net-next:
> >
> >  - net/psp/psp_main.c conflicts around psp_dev_encap_ok(), which both
> >    add: net's only allows tcp, this series' (patch 2) takes any l4
> >    protocol. keep this series' version of the function, and its
> >    comments above it and above psp_dev_encapsulate().
> >  - tools/testing/selftests/drivers/net/psp.py and
> >    tools/testing/selftests/drivers/net/config conflict: keep both sides
> >    (imports, constants, the list of test cases; the NET_ACT_* options).
> >
> > relation to the netfilter fixes in nf-next:
> >
> > packets which a psp device decrypted don't have to end in a local psp
> > socket. they can already be forwarded or bridged today, but with
> > socket-less associations that is the intended use, e.g. a router that
> > decaps and forwards. netfilter handles two cases itself, outside the ip
> > stack paths which the net series fixes, and would send such a packet's
> > decrypted contents in clear text:
> >
> >  - the bridge refragments packets which bridge conntrack reassembled
> >    (br_ip6_fragment(), nf_br_ip_fragment()), without the check of "net:
> >    don't fragment decrypted skbs".
> >  - the reject code builds its own icmp errors and tcp resets
> >    (nf_reject_skb_v4_unreach() and friends), without icmp_send() and
> >    icmpv6_send(), which the net series' icmp patches cover.
> >
> > a separate series to nf-next applies the net series' rules to both:
> >
> >   "netfilter: bridge: don't refragment decrypted skbs"
> >   "netfilter: reject: don't reply to decrypted skbs"
> >
> >   https://lore.kernel.org/netfilter-devel/20261111003111.3826942-1-todd=
freed@meta.com
> >
> > it doesn't depend on this series, and the two don't conflict.
> >
> > trees:
> >
> > the full tree, with the net fixes, the nf-next series, this series and
> > the mlx5 offload series, and the conflicts above resolved, is at:
> >
> >  https://github.com/toddfreed/psptc branch psptc
> >
> > iproute2 tree, with support for the psp action and the psp flower
> > matches, based on iproute2-next. the selftests need it:
> >
> >  https://github.com/toddfreed/iproute2-psptc branch tc-psp
> >
> > testing:
> >
> >  - netdevsim: drivers/net psp.py passes (57 tests), and tc-testing
> >    psp.json (17 tests).
> >  - mlx5 (ConnectX-7, FW 28.48), two hosts: drivers/net psp.py passes:
> >    46 pass, 8 skip (GMAC versions not supported by the device),
> >    3 xfail (netdevsim only).
> >  - each patch builds without warnings with gcc and clang, allmodconfig,
> >    W=3D1.
> > Todd Freed (15):
> >   psp: get netns from net_device instead of sock
> >   psp: take the psp nexthdr from the packet on encap
> >   psp: declare psp_assoc_set_tx() in psp.h
> >   psp: add support for socket-less psp associations
> >   net: add METADATA_PSP dst to carry a psp association on an skb
> >   net/sched: act_mirred: don't send decrypted skbs from egress to
> >     ingress
> >   bpf: don't redirect decrypted skbs from egress to ingress
> >   psp: only give time-wait sockets of psp connections a validator
> >   net/sched: add act_psp for psp transport mode
> >   net/sched: flower: add psp_spi, psp_ver, and psp_dev matches
> >   selftests: drv-net: psp: test socket-less associations and the tc psp
> >     action
> >   selftests: drv-net: psp: test that software encap on ingress drops
> >   selftests: tc-testing: run dependsOn probes outside the test namespac=
e
> >   selftests: tc-testing: add tests for the psp action
> >   Documentation: networking: psp: document socket-less associations
> >
> >  Documentation/netlink/specs/psp.yaml          |  98 ++-
> >  Documentation/netlink/specs/tc.yaml           |  14 +
> >  Documentation/networking/psp.rst              | 139 +++-
> >  MAINTAINERS                                   |   3 +
> >  .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   2 +-
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c |  33 +
> >  drivers/net/netdevsim/psp.c                   |   2 +-
> >  include/linux/skbuff.h                        |   4 +
> >  include/net/dst_metadata.h                    |  19 +
> >  include/net/flow_dissector.h                  |  18 +
> >  include/net/psp/functions.h                   |  91 ++-
> >  include/net/psp/types.h                       |   1 +
> >  include/net/tc_act/tc_psp.h                   |  23 +
> >  include/uapi/linux/pkt_cls.h                  |   6 +
> >  include/uapi/linux/psp.h                      |   6 +
> >  include/uapi/linux/tc_act/tc_psp.h            |  28 +
> >  net/core/dev.c                                |  48 +-
> >  net/core/dst.c                                |   5 +
> >  net/core/filter.c                             |   9 +
> >  net/core/flow_dissector.c                     |  27 +
> >  net/psp/Makefile                              |   2 +-
> >  net/psp/psp-nl-gen.c                          |  60 ++
> >  net/psp/psp-nl-gen.h                          |   8 +
> >  net/psp/psp.h                                 |   7 +
> >  net/psp/psp_assoc.c                           | 120 +++
> >  net/psp/psp_main.c                            |  54 +-
> >  net/psp/psp_nl.c                              | 261 ++++++
> >  net/psp/psp_sock.c                            |  32 +-
> >  net/sched/Kconfig                             |  13 +
> >  net/sched/Makefile                            |   1 +
> >  net/sched/act_mirred.c                        |   6 +
> >  net/sched/act_psp.c                           | 439 ++++++++++
> >  net/sched/cls_flower.c                        |  64 ++
> >  tools/testing/selftests/drivers/net/config    |   5 +
> >  tools/testing/selftests/drivers/net/psp.py    | 750 +++++++++++++++++-
> >  tools/testing/selftests/tc-testing/config     |   2 +
> >  .../tc-testing/tc-tests/actions/psp.json      | 459 +++++++++++
> >  tools/testing/selftests/tc-testing/tdc.py     |   2 +-
> >  tools/testing/selftests/tc-testing/tdc.sh     |   1 +
> >  39 files changed, 2812 insertions(+), 50 deletions(-)
> >  create mode 100644 include/net/tc_act/tc_psp.h
> >  create mode 100644 include/uapi/linux/tc_act/tc_psp.h
> >  create mode 100644 net/psp/psp_assoc.c
> >  create mode 100644 net/sched/act_psp.c
> >  create mode 100644 tools/testing/selftests/tc-testing/tc-tests/actions=
/psp.json
> >
> >
> > base-commit: ed04b202027249e2769420893220f54a56e0c59a
> > --
> > 2.53.0-Meta
> >
