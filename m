Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069627;
	b=r9P7Ch2kx9MNbPnVbzWce0F4gtKN/ngp2mhIT2w88SP18xx/pGZ7ts67p0Szcz0yc/h1
	 erT9M+1GRQ6PhUD8Y4qzCKjrOYuaGG8huPv0zfhV2U9Zyx71UgfNwSaZMGlYeEZ/fj6Nx
	 gka0prR/mO6EHYbKbZu2hIrMBrJeZwjon2l4IHNohsLTcM2AEUYxwoC7Pwnz3rz5IxEXf
	 KdE084ABnU9UXcuqPDnj5vbEW7PJvtr8uJsEy23tK3PCgSxqDwc4SU6doLSjMh6HnltA3
	 HJSJUqOLoCqNA4gPYhVIe0Iog3IDI8tUmV3SzylN5Htfacs38ClSoQ34zdmhuZ4vIGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=QEyBimWiPMZCb/NgBqLydR3KIBuNX/gfzUiZdqnqTSg=;
	b=3N9SVwfsWWUl6dRj9pYvFJnfdhG++A+fADPCDZiuJTNyEMchGH3py/yAP3BVJEtl+EGC
	 SoqbeOlifUuVlJzIwXpHoDMuFLBVy17IuhaycDLS1kfPhb17nBXdhoZyRImU3F1RE/IqY
	 /AmL+jMq0ulPuIad8hnisvbx0Vil0a+QWbmQL/pLI/TbJWer6tpDmuWPb9kzXEWkSDQ/h
	 OjXx7iOsbXnyGKYVEH+VuDVifSzBNdfQrs+v3XavzAv9Nso6SFke8YLLlk8YPjGMpcDiV
	 iZGpifelRKw5EGdlWaTKeYLnJeYDGlW26EaIsEPqz7qJEtuPOqWHOOKim/Al3hr6+qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avJ1y1hc;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB86606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=avJ1y1hc
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1235553a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069626; x=1795674426; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QEyBimWiPMZCb/NgBqLydR3KIBuNX/gfzUiZdqnqTSg=;
        b=avJ1y1hccHAVp2OQEF6HFs7rp+tJ+c6Lsg4YWpNqEUj0mcGZs5E0JoA3GL8/MoukJS
         ZRbcrvfmw6g/qp1EzYUR8C1lMuFz6/WQBCBtCuRnvddMpKX83KqWaTTKu86i37L7rBP5
         Wx99kcAZpizEB/DtpChFFjMVNyFDUPUlNS+64QbGUboCHJ5YGZTyI3VluU43hZPu1t2m
         ZMtPG5S5NZuQcb7c5PhZ7QJ4S8PIOdg7UALNzWz7VfM+GFBfTASEII/f85KdU0VAAVIp
         IMoNCmMwpwClRvRqsNEvAekNhhXB9eXE6lfoP0zbkYlScNSY7nqS1Ki0UFCG7CokDdu6
         PHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069626; x=1795674426;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEyBimWiPMZCb/NgBqLydR3KIBuNX/gfzUiZdqnqTSg=;
        b=CO0Dj40pVYCSh4HxiXMerwXPnPWeiT/XY0VAsq47pcuadyA0A8JjhSiuV6twsP5wZe
         QRBpAFsEDI3MZtrP7IemUYu4IiyWMibjB9kvBX5BrcNLWsHbCrsX3hkb75a5sjO5Tv2j
         c3J13udhM5CxXuc8MPjwtnyQ0FVLlClzpJrto2GUMNoaU6SKAD8ztynse3qtVXCMtuZR
         ur5T0DIsq48fmXYB9z+sOsuaEiUfVs6ojil3YeBzNZNAAd/kmb3ClXNWH9NwDrubkZ3W
         JVLCrlwNE7lHxjSp7r4cDEuI/u+pkzAzpozaWsHI9dy0F3UcySuw0rwMhRHqET2u8+5Q
         j1hg==
X-Forwarded-Encrypted: i=1; AL+hErFfB4ZhzbTY0YGQoA3An/Cc/BoF3Du666HFJkthHg+lqJhgW0qXuzj5DhkcfLuSX2LJrII=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0I9eqms45Juf/dXY093baHqKsT2YzporMKvor7HaxUUHEcZHC
	SNAV7MLe0uCKiolJFG2vYBkPROdtscX3r/6oU/WzLG11xgULVlNpZnBGen8+KA==
X-Gm-Gg: AYBFou2zQAQpx8lKchXG94rG5rac3/MB27F6/gDXvmw6uDZajox8l8Xt7rmdA10SKms
	hk5n9oPsIFN4DNQNAdNvEZtVqOZ2xeWCA7IJYmh2YeAHpLvGPNEx3gUvyuHhsbBKxfd2zIuoXvm
	4aiMMN96QOLWZMDKuD2sCYq0B+WWN6el05G1aWmcpAEsTk827HvgT9u3IBZT3XhY/Z9RuK4GbIE
	vq/VWU8/zvFGiXqlbIKj2K1v1UwdE1gTSarZzjbuLIKdFs6tdB5cxIwXgecA18QcXA0Zvdjwy8n
	So6Y4N1YBC4KMwVbAmEVws9je72hJdEA9WCamanB5giZMjGKaZ92LgQItuVPQvBAS/6NNIC5Cms
	AIFcLV9EBM+JCi0wOw9LLVppuppphRv/FjlwnXSjC0fR55xNg5Wj7+JJAISHVEjEJj/KdPrra9v
	urh3kTdkAsR+Jbzj+eB6RhhiUUjYyPt9oE5rHu5+yPImG9R23+vPInWtwOLOUneOXxbAKQsQ8Ss
	CUvE1Bu33+rD4EzELeme/zQGhpPFzHeVMSQR7OlpDqD0HQUh7H0Cs6luFKm9JDJk6FQ4No2t9Jc
	9/gzM4rX0Mr893fmtVkiUYDL655Qt+8zs4k3SNP8PRkWCIe/oJpV+IywDzESmwAoZ+uTQBT7H8K
	BdpPr2j9zmi5M9LWnU4l4kqDiLchX45mzdw==
X-Received: by 2002:a05:6a21:b8c:b0:3e1:a8fc:18f9 with SMTP id adf61e73a8af0-3fe8b5eea53mr4717482637.62.1795069625749;
        Wed, 18 Nov 2026 22:27:05 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde5336475csm1177532a12.3.2026.11.18.22.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 22:27:05 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 06:27:05 +0000
Message-Id: <DMYZ2PEBP5GQ.NPCWIL8HYD9H@gmail.com>
Subject: Re: [PATCH bpf] bpf, lsm: Remove bpf_lsm_release_secctx from
 sleepable_lsm_hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?=E6=A2=93=E5=B7=9D=E5=92=B2=E5=A4=AA?= <inkxiao12@gmail.com>,
 <bpf@vger.kernel.org>
Cc: <security@kernel.org>, <kpsingh@kernel.org>, <matt@bobrowski.net>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>
In-Reply-To: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>

On Thu Nov 19, 2026 at 6:18 AM UTC, =E6=A2=93=E5=B7=9D=E5=92=B2=E5=A4=AA wr=
ote:
> security_release_secctx() invokes release_secctx LSM callbacks
> (selinux_release_secctx() and apparmor_release_secctx()), which only
> kfree(cp->context) and never sleep. Because the hook is non-blocking,
> Netfilter callers legitimately invoke security_release_secctx() under
> atomic, RCU, or softirq context:
>
>   1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
>      rcu_read_lock() and holds it across ct_seq_show() ->
>      ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_stop(=
).
>   2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
>      rcu_read_lock() in packet RX softirq and calls
>      nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
>      calls security_release_secctx(&ctx).
>   3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
>      allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
>      security_release_secctx(&ctx).
>
> Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
> lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
> blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/softir=
q
> context, causing BUG: scheduling while atomic or RCU stalls.
>
> Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
> line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
> and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
> x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch ->
> REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
> sleepable").
>
> Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: BoBppy <inkxiao12@gmail.com>

This is not a real name.
I'm dropping all of your patches.
Teach your bot basics first.

pw-bot: cr

