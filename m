Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32340369997
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042399; cv=pass; b=omEXKS+1FY7/6M9hh4IlQ4tRm5mkFdpJVN/rUMueusKUOKKUNhgrrj+WtmSXBjTkYNo7vcPU7b3W/lfTYhSBZaTI9qt+HFl0m4crZfPZsT+PzJ2G86J723QyXSmr7CUMQp5zFupoH18LcxhJCkplT4EOQXBZeF2+ST/GOKkVXfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042399; c=relaxed/simple;
	bh=eacRXzXf/aiA5OgRGa3k7SPsaozGRTTdOpU1VEE4zBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ1Prk0i1tvnREZGc0yn4H8wk8n17+I7MAqZhEc43hLa/U7YaeG6M7IJXd0ayzPOlwPB9rojavnMrvE5wy+fE9407FFnXuu6OFSi9NRMTqxI0fbbd4fo4C/BN8g9ws1JM1rZj/eam5ExaKE2C6EZhbjgaZErJts6Irg2D2xiLRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CM3Z6Dxb; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CM3Z6Dxb"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a5db525cso105375496d6.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 00:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773042396; cv=none;
        d=google.com; s=arc-20240605;
        b=EGfLSM/2iT3KKEox9L2Xe0o4VMqCa9ZawZ3tLqJgW9wZ206++f637mX+xdB3WHib2D
         DuMTRjm9+4fnlOsvrhrQduhvSTvxuHlTHbkjs/xZL9rDW9t1Sj/EtmtDRpukpYL+mejN
         WrXPdnSFIG29jJsXVu3LKNJYXo5BJSkmlrElNwruUE1ns88MOTbi5FNbscrfzqb0rtYH
         qD3YKcXBkdYuCm/GthVb/MxDi5px/jdRynXC7wFcxxBnExwsvXI5AvC8gSC4YUMS3PkL
         5BEBagUqeVIUSEEIP8eCibNOz/cvqMs9Dk9XLRlBXJHAI5z/Gg72vLdgOqlmXxqgXwsd
         +ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        fh=8FxU8NoFDuLmN08ZHwBoILh73vj0XNaE1cBLQHH62II=;
        b=WW89oswpwjTO6OzD3fwYfLFNsT3DXtDvM0k9wJaaK9RymE7xakamI+17IZoHGp5etd
         IUlGOTpG4z0755F7+hXOE0V4buFjGKnK/gsVfMeiSnpxQ5W+WA9zxNQuXkwDDbs8pdQF
         QEO3zMhjYh5UNZA9yOa5tdqOIq0fpMyAQ1VrvyEM5X8iXesw3C9nDZx28z7slnFySV5O
         WvKnXvHZfPJt2Zxaimcr3mHjZLcjyw4rqIw3tq2LjR4mIhV2Gc6LV6oCm+nOE8XU705r
         qNGt55cwYbFKYh8yNQL1NazC+C91pR6nseOfMFKoTfxWDd0iYOgYhr3KJUk6M9RNcthv
         N0rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773042396; x=1773647196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        b=CM3Z6Dxbp7+Ddn//y5svnSSY6FXarjiZ5dEo/L8O44/6ecvDdJr7l3fKO/ub2GD/vn
         K0M0Zo5T738xnAgeGI/y5nSSLc29XyiYCXo9cMvcremUMi46bXsze8+eIu0iSLprQ6Vg
         gSvPI7TxolYx5J/MNPxpFzEy+VF+ZavGMnVz+88jK9A/Dbc4MFvI0/PNfdg3hO27xHfT
         BqKTV/Rdzy1S+s6kCyjztP+eKdP8Cb4YdSODXIr24fLCRjr6aa/wLZZgO0V0FKXFdtbx
         NQAMNPfDtk07kpMUooAk7V8yePGa+FBZZnGq2AoR12kT8EAsgo2qM4Eb8yCaus8tC3MR
         /Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042396; x=1773647196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dy2wEMRvx8pDR1Qm7aqueQadBuYC5mw6ZCVKfgZ4OGs=;
        b=PzxxIxfIuqb6tdEHizCx8CPumlfE/t6l7RKDx4y9odIyKgttBIaqH0eSQNCst9ZPk/
         aSz6eVdwPI7wLWW92jQp8I0kU5OB3yQFDYmbYjzh3gc6W0ch28xmtfGKFwszg5YTrnLh
         /PC0A9S6CP1k9bgOiRpNvztH9FFZttoMezJtwEC4ytAmIO/W7F6o33Qw5yWcOOobYjdv
         igUx+HIbsUWlyfk+GR22/ko2BgfKxTmcLa8XQAF5bD6vuBueLB4TykFYX8ENDUg1XCXI
         fGQIPxozn28O1mtZl3OYD9RFereZ34IUH6/CvqRo3UoBA+8mhPJpQMG5s/QUdFnZoN/V
         NJmw==
X-Forwarded-Encrypted: i=1; AJvYcCViX5n1DVT3jLjsQdl49NP8LGHmPvOPc8pQ+/yAzoQg2mzJnQZXsXXh+x0TDDWN8uZzHTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZmOSwGsdEkJXLfiHu/pm39klxCepAO2TbrTIYqwX4bv8C0bE
	QkqZuggrqbRs1npCU3/FFWEh+8J6JlDDH/TdBY1UlNudMSpXDq9ziEsTodx+VxsEX4KLCOfD9qS
	YUJV0FjTLP61HJXyLpNwQfePIQcB6ZgttD9zA+h3G
X-Gm-Gg: ATEYQzyx3z0fx9loRrFfcgKcYuOP37t+PEisy1gMdKBdGX+/SVYZkHhS5omcJDljCFl
	G2nCniYOrmyFwti6kfHqKufbDliXGSYlPjwZUKLDjdxGvz7tYkRT5M5UMTHRlt5VKEjA4agnuJg
	9Umip+O6S1ccTMzm7C8OQJCuv/zCFBiCGLxmFeA0jU+Sl3iB5hcSc40JcYNbFo3MfuSxs5MYchx
	icHMqX8PxPLN92mm/zhmrer3sC78S8BJDcR97nJX1av7nq20qYMCaDvy4yMKwLWjJ2xV7w0eJQe
	O42VREs=
X-Received: by 2002:a05:6214:f0e:b0:899:f691:fd3a with SMTP id
 6a1803df08f44-89a30a5ac53mr155765816d6.27.1773042395649; Mon, 09 Mar 2026
 00:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309030702.128520-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 08:46:24 +0100
X-Gm-Features: AaiRm51LwOtGnsLFGw5-TXI1ygOjcbArZhKBv2Arly_DVU4Sw2FiUsW3cGuVy-o
Message-ID: <CANn89i+SCJmUuQo2pSVv_4YhjvXGvnGDH_HNo2XY6KxDX1Kcgg@mail.gmail.com>
Subject: Re: [PATCH net v5 0/2] net,bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding and add selftest
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, razor@blackwall.org, jiayuan.chen@shopee.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 4:07=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> syzkaller reported a kernel panic [1] with the following crash stack:
>
> Call Trace:
> BUG: unable to handle page fault for address: ffff8ebd08580000
> PF: supervisor write access in kernel mode
> PF: error_code(0x0002) - not-present page
> PGD 11f201067 P4D 11f201067 PUD 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU: 2 UID: 0 PID: 451 Comm: test_progs Not tainted 6.19.0+ #161 PREEMPT_=
RT
> RIP: 0010:bond_rr_gen_slave_id+0x90/0xd0
> RSP: 0018:ffffd3f4815f3448 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffff8ebc8728b17e
> RDX: 0000000000000000 RSI: ffffd3f4815f3538 RDI: ffff8ebc8abcce40
> RBP: ffffd3f4815f3460 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffd3f4815f3538
> R13: ffff8ebc8abcce40 R14: ffff8ebc8728b17f R15: ffff8ebc8728b170
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8ebd08580000 CR3: 000000010a808006 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  bond_xdp_get_xmit_slave+0xc0/0x240
>  xdp_master_redirect+0x74/0xc0
>  bpf_prog_run_generic_xdp+0x2f2/0x3f0
>  do_xdp_generic+0x1fd/0x3d0
>  __netif_receive_skb_core.constprop.0+0x30d/0x1220
>  __netif_receive_skb_list_core+0xfc/0x250
>  netif_receive_skb_list_internal+0x20c/0x3d0
>  ? eth_type_trans+0x137/0x160
>  netif_receive_skb_list+0x25/0x140
>  xdp_test_run_batch.constprop.0+0x65b/0x6e0
>  bpf_test_run_xdp_live+0x1ec/0x3b0
>  bpf_prog_test_run_xdp+0x49d/0x6e0
>  __sys_bpf+0x446/0x27b0
>  __x64_sys_bpf+0x1a/0x30
>  x64_sys_call+0x146c/0x26e0
>  do_syscall_64+0xd3/0x1510
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Please, can you always provide symbols in such traces ?
You can use scripts/decode_stacktrace.sh to make the trace really
nice, instead of ugly.

>
> Problem Description
>
> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> when the bond mode is round-robin. If the bond device was never brought
> up, rr_tx_counter remains NULL.
>
> The XDP redirect path can reach this code even when the bond is not up:
> bpf_master_redirect_enabled_key is a global static key, so when any bond
> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> interception is enabled for all bond slaves system-wide.
>
> Solution
>
> Patch 1: Add a NULL check with unlikely() in bond_rr_gen_slave_id() befor=
e
> dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was never
> opened), fall back to get_random_u32() for slave selection. The existing
> allocation in bond_open() is kept, with WRITE_ONCE() added to pair with
> the READ_ONCE() in the NULL check.
> Patch 2: Add a selftest that reproduces the above scenario.
>
> Changes since v4:
> https://lore.kernel.org/netdev/20260304074301.35482-1-jiayuan.chen@linux.=
dev/
> - Reverted unconditional alloc in bond_init(); instead add a NULL check
>   with unlikely()/READ_ONCE() in bond_rr_gen_slave_id() and WRITE_ONCE()
>   in bond_open(), avoiding memory waste for non-RR modes
>   (Suggested by Nikolay Aleksandrov, patch by Jay Vosburgh)
>
> Changes since v3:
> https://lore.kernel.org/netdev/20260228021918.141002-1-jiayuan.chen@linux=
.dev/T/#t
> - Added code comment and commit log explaining why rr_tx_counter is
>   allocated unconditionally for all modes (Suggested by Jay Vosburgh)
>
> Changes since v2:
> https://lore.kernel.org/netdev/20260227092254.272603-1-jiayuan.chen@linux=
.dev/T/#t
> - Moved allocation from bond_create_init() helper into bond_init()
>   (ndo_init), which is the natural single point covering both creation
>   paths and also handles post-creation mode changes to round-robin
>
> Changes since v1:
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.=
dev/T/#t
> - Moved the guard for NULL rr_tx_counter from xdp_master_redirect()
>   into the bonding subsystem itself
>   (Suggested by Sebastian Andrzej Siewior <bigeasy@linutronix.de>)
>
> [1] https://syzkaller.appspot.com/bug?extid=3D80e046b8da2820b6ba73
>
> Jiayuan Chen (2):
>   bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
>   selftests/bpf: add test for xdp_master_redirect with bond not up
>
>  drivers/net/bonding/bond_main.c               |   9 +-
>  .../selftests/bpf/prog_tests/xdp_bonding.c    | 101 +++++++++++++++++-
>  2 files changed, 106 insertions(+), 4 deletions(-)
>
> --
> 2.43.0
>
