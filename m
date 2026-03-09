Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44FA379EC1
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049301; cv=none; b=JH1HVXZiz/30HTFIApjmoZT+EMZTA8lKTrWAMxePyqZptEvfy2deK/LhDavJlERu05XhMmNCIAKKsgh7sc3ZTVH5rqMdHGKXkSWt5xf+6kDerjcnOTkDSstBX8bOI6K8SibHOwHNBXKdYf+1z61kHNlI7lhpwZ02T61uW7zYRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049301; c=relaxed/simple;
	bh=5qaV2q4pL4ot0coh84TNIQEWsyE133PJ4M1w0fQW6k0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=J3TjxkKjLLl8fMsM3R15xyHdAyM7R48oSCkObdFySLH/ZpOF6+QLjq3LeZm9oU6AWZuIUsFpSLYVX7nz3lRlV4+wi85LHmx7ngvQml55Gl4AZDjC2ROPu6xwDp3w9ye80XGAg1W/qsk6GF4smZD4WbyFWUFBRE4zcqfv9OsJRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FkTPo2MR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FkTPo2MR"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773049286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5emj4rOfumDjHAmcTR+t41Tv9z3bI+XmVMG7Ky6EkAY=;
	b=FkTPo2MR19B58eVh8+3LZBCUd7zwWHqxeTz3T2VBhTvPP8ocz7kSApX1gdTjQlS0eJ9Wj5
	ll8UF6xmpQAc8VytGAlNNg1ltOVX8IoEiUB0S5ZrJHx+zN2YDuc7bGJSEv0uCmzzMqkTD9
	UMfQN5K9JClVTonM9c8b3MHj3s2TFUU=
Date: Mon, 09 Mar 2026 09:41:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <903543b24e6e124ff970340e265185af176880f6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v5 0/2] net,bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding and add selftest
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org, razor@blackwall.org, jiayuan.chen@shopee.com,
 "Jay Vosburgh" <jv@jvosburgh.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Jussi
 Maki" <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

March 9, 2026 at 15:46, "Eric Dumazet" <edumazet@google.com mailto:edumaz=
et@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E > w=
rote:


>=20
>=20On Mon, Mar 9, 2026 at 4:07 AM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
>=20
>=20>=20
>=20> syzkaller reported a kernel panic [1] with the following crash stac=
k:
> >=20
>=20>  Call Trace:
> >  BUG: unable to handle page fault for address: ffff8ebd08580000
> >  PF: supervisor write access in kernel mode
> >  PF: error_code(0x0002) - not-present page
> >  PGD 11f201067 P4D 11f201067 PUD 0
> >  Oops: Oops: 0002 [#1] SMP PTI
> >  CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PRE=
EMPT_RT
> >  RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
> >  RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
> >  RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
> >  RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
> >  RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
> >  R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
> >  R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
> >  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
> >  PKRU: 55555554
> >  Call Trace:
> >  <TASK>
> >  bond_xdp_get_xmit_slave+0xc0/0x240
> >  xdp_master_redirect+0x74/0xc0
> >  bpf_prog_run_generic_xdp+0x2f2/0x3f0
> >  do_xdp_generic+0x1fd/0x3d0
> >  __netif_receive_skb_core.constprop.0+0x30d/0x1220
> >  __netif_receive_skb_list_core+0xfc/0x250
> >  netif_receive_skb_list_internal+0x20c/0x3d0
> >  ? eth_type_trans+0x137/0x160
> >  netif_receive_skb_list+0x25/0x140
> >  xdp_test_run_batch.constprop.0+0x65b/0x6e0
> >  bpf_test_run_xdp_live+0x1ec/0x3b0
> >  bpf_prog_test_run_xdp+0x49d/0x6e0
> >  __sys_bpf+0x446/0x27b0
> >  __x64_sys_bpf+0x1a/0x30
> >  x64_sys_call+0x146c/0x26e0
> >  do_syscall_64+0xd3/0x1510
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >=20
>=20Please, can you always provide symbols in such traces ?
> You can use scripts/decode_stacktrace.sh to make the trace really
> nice, instead of ugly.
>=20


Hi=20Eric,

Thank you for the suggestion. I didn't include the fully decoded stack=20
trace=20in the cover letter because the syzkaller report already contains=
=20
the=20complete information. You can find it here if needed:

https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D15448952580000
https://syzkaller.appspot.com/bug?extid=3D80e046b8da2820b6ba73
