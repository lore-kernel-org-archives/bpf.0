Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13C477E4D
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527360; cv=none; b=HVXPUozJ0a8bnMjffFLC82ygtDuUSgWKaQ3LvJoM4NhDomSinG5MoZ/NUdCWAhv7mmPlu1MJ2Uk0znkjYWyYiBHMtiB8HBjReDrT5Cc/J0mirFCOp+nzLW0zV09I5zdv+4HajrTYO3DivzDogJyi+PvtLTkzEEFzLbu10Uo4EXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527360; c=relaxed/simple;
	bh=1Go7AkwpmkJBIvk/bDaA/aiLVxiJzm2LezpYLlLteKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqj4J8CGgoGiIbJcDZyfzDPVt4CCJ9GHjFN83s8Lh3SospcCM1UIGKwiO54NUZP9Yo6ojhRUGCIe9TRfPWdVPXZoHVLUKeVawDmm8kadJsIAYpVGdgz3kU6Nmeji7EVsOYuzoasoSqbhZQsaGfBmU10/HZMYpKRi7kdsWFkZkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDuJCN3o; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDuJCN3o"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bd65714dcaso50289997b3.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527358; x=1779132158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/a2/tf3pJlvTRKWq0xdAAEeDOGA4QAmtV52+9YCkorE=;
        b=TDuJCN3ozytkXGyvzJHMrSf3/IuQIjl87J2mtZsTiHKr1p/d+sQ9jcK+OxMW/wnOSH
         fKX09d3rDtS5xUL4ei28Hg+PFt3uP/ggSuvYpZ9C3MoEbjOdCGDKDewrokUevEwfs9xW
         uF+tM6BDvjJB2mtrV3WgWNI14ALlX0GI84y98MfMqLJNFOgGbclQC86MnhS9GzbOIldf
         67gxvbWfuyaUospQg1IG487cfe+hxENP/EtlP5jlxbt2cAJgQPOmHaXXU20KGmPLjNRG
         R/YP3HR7qseqn0rHxY5pSlW/1lED996u96iuCWIxEks01/tj2iiW+rreNMa10PYXaON1
         XtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527358; x=1779132158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/a2/tf3pJlvTRKWq0xdAAEeDOGA4QAmtV52+9YCkorE=;
        b=L7u7AhxVN5TM+r8Lx4qchSmUdMX+ysCcXplOsAbqHo/tZ6b9rWT+RNHgGfeERFpEF7
         5o8OiJh4n0BItuVHl/I2S2Mt+q1MDZri0szoJvjFi7lMLy/QYEfru4zWTwpcRyPBEKOV
         6Jcppl7Gb8bPCtkpo6J9+JwTSoSsV1EmapLXhnrn0XCc4IrLWpj1oIJxIgqhHRTOknZq
         0wz9JDW6aOeT9XfDyHbbZHIYo0fLcM0k67ZDUl+QSQvb4uikT21w78JJuVwXwQF3MY3j
         YJZLqF3311Um3IhanKSrqltH06KPHiSVHHYKcPDl9aFgtF6vv8OX4sw+U1bBbE+AS2PJ
         CdQg==
X-Forwarded-Encrypted: i=1; AFNElJ/FV7cfwV5VpIpMjdZhrIgi3QkHpHvDvHfGBix7htyf1ih+wGob+Bx7Qd/jiTxMPMR0wIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxI/196Uke57JFwtss6Qp5VJaA8Io94cYN8v0a4sycNvu2AMT
	JS3ITLixWeXr5DHFMo4B23dLupEHB83la9JIYih4keMrgxBCqD9NNvwn
X-Gm-Gg: Acq92OESgOb3XIjBD0Mq9v35GTKvrYGsLIdfB5n+0K2dX5QDinOXB7DoQ2BHmKJUwju
	MdlKsWzuF55r0LI8DzuG9GSPPEUb3z3wAKn+E7ZbwP6CgNj5BMgMr+ePgb9UaaZlVLXEGhIbliy
	pyQut3eRZ8aRGnF5LkRTV5Kpbm5okMV4xjB1DT+ZlHzNVQW8Uo32u4nKQavFCp4T5H/YIj/JMEV
	fIkkBp8IRn++7D1b/aD8BNyi5srh4Xp76SyPHFXHbo9owsTU5crYdwb2aQQYfcUvJGC5e8jRE2I
	fgDo+pgCEweviR4sJ+8TKcz+U4xt/1IVzRGWLUJh8IaQ2GjV5W/CyGB9AICm6NhMwNRHZA02G8C
	hwh7hTPQTv4ZLd562qhdtsoe4ZqMftbdpuPLcoH0D97iF3AWZAq2yExlplPqq2V6Hevzlw3ksB9
	CO50t0eSsP/Sap1xNXHI6fNQiCT9GWsy4vEdbLw8fYL6hq80EUqMQFpB4DOA==
X-Received: by 2002:a05:690c:6d83:b0:7bd:8d1b:b2d8 with SMTP id 00721157ae682-7c102760192mr98515307b3.10.1778527357715;
        Mon, 11 May 2026 12:22:37 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:e8b3:b34c:911c:3e07])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm153207707b3.11.2026.05.11.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:22:37 -0700 (PDT)
Date: Mon, 11 May 2026 15:22:36 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <agInlPe_e8Mpp3Nq@zenbox>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org>
 <agCXEJKJh-JGMhjG@zenbox>
 <CAADnVQJdFCFJcg0Pqdnx=D2h5vHj_q4mrwSJYxRC5RW0NTFNvQ@mail.gmail.com>
 <agEnc0aYMhuIeDlq@zenbox>
 <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DIFYUK5DKGAT.189D9YYSQFCUZ@gmail.com>

On Mon, May 11, 2026 at 08:51:53AM -0700, Alexei Starovoitov wrote:
> On Sun May 10, 2026 at 6:49 PM PDT, Justin Suess wrote:
> > On Sun, May 10, 2026 at 03:38:08PM -0700, Alexei Starovoitov wrote:
> >> On Sun, May 10, 2026 at 8:14 AM Justin Suess <utilityemal77@gmail.com> wrote:
Here's a reproducer for the cgroup case:

https://gist.githubusercontent.com/RazeLighter777/5f77cdfe035a4e22ee2642ae7db6387d/raw/10898d27040a07098cccc5d0785d9ad6620344e7/cgroup_kptr_nmi_deadlock_repro

Hacked together with an AI prompt but functional.

Exercises a different path, but more consistently splats even without
CONFIG_RCU_NOCB_CPU / CONFIG_RCU_EXPERT since this dtor uses workqueue.

Had to use an fexit hook to get the timing condition right to release
the last cgroup reference.

But this lets you see the deadlock is indeed in the dtor in NMI.

This is on the same bpf-next/master
7e033543a2ab4c72319201298ed458e3bbddd82f:

  [   15.160694] ================================
  [   15.160695] WARNING: inconsistent lock state
  [   15.160695] 7.1.0-rc2-g7e033543a2ab-dirty #130 Not tainted
  [   15.160697] --------------------------------
  [   15.160697] inconsistent {INITIAL USE} -> {IN-NMI} usage.
  [   15.160698] test_progs/434 [HC1[1]:SC0[0]:HE0:SE1] takes:
  [   15.160700] ffff9096fd66ced8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0xde/0x720
  [   15.160707] {INITIAL USE} state was registered at:
  [   15.160708]   lock_acquire+0xbf/0x2e0
  [   15.160711]   _raw_spin_lock+0x30/0x40
  [   15.160715]   __queue_work+0xde/0x720
  [   15.160716]   queue_work_on+0x54/0xa0
  [   15.160716]   start_poll_synchronize_rcu_expedited+0xaf/0x110
  [   15.160719]   rcu_init+0x958/0x990
  [   15.160722]   start_kernel+0x746/0x980
  [   15.160725]   x86_64_start_reservations+0x24/0x30
  [   15.160727]   __pfx_reserve_bios_regions+0x0/0x10
  [   15.160729]   common_startup_64+0x12c/0x138
  [   15.160731] irq event stamp: 18704
  [   15.160732] hardirqs last  enabled at (18703): [<ffffffffa200148a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
  [   15.160734] hardirqs last disabled at (18704): [<ffffffffa30e3f8f>] exc_nmi+0x7f/0x110
  [   15.160737] softirqs last  enabled at (18698): [<ffffffffa22e5800>] __irq_exit_rcu+0xc0/0x100
  [   15.160739] softirqs last disabled at (18687): [<ffffffffa22e5800>] __irq_exit_rcu+0xc0/0x100
  [   15.160741] 
  [   15.160741] other info that might help us debug this:
  [   15.160741]  Possible unsafe locking scenario:
  [   15.160741] 
  [   15.160742]        CPU0
  [   15.160742]        ----
  [   15.160742]   lock(&pool->lock);
  [   15.160743]   <Interrupt>
  [   15.160743]     lock(&pool->lock);
  [   15.160744] 
  [   15.160744]  *** DEADLOCK ***
  [   15.160744] 
  [   15.160744] no locks held by test_progs/434.
  [   15.160745] 
  [   15.160745] stack backtrace:
  [   15.160747] CPU: 1 UID: 0 PID: 434 Comm: test_progs Not tainted 7.1.0-rc2-g7e033543a2ab-dirty #130 PREEMPT(full) 
  [   15.160749] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  [   15.160750] Call Trace:
  [   15.160751]  <TASK>
  [   15.160753]  dump_stack_lvl+0x5d/0x80
  [   15.160757]  print_usage_bug.part.0+0x22b/0x2c0
  [   15.160760]  lock_acquire+0x295/0x2e0
  [   15.160762]  ? srso_alias_return_thunk+0x5/0xfbef5
  [   15.160763]  ? __queue_work+0xde/0x720
  [   15.160767]  _raw_spin_lock+0x30/0x40
  [   15.160768]  ? __queue_work+0xde/0x720
  [   15.160769]  __queue_work+0xde/0x720
  [   15.160772]  queue_work_on+0x54/0xa0
  [   15.160774]  bpf_cgroup_release_dtor+0x12e/0x140
  [   15.160778]  bpf_obj_free_fields+0x118/0x250
  [   15.160782]  free_htab_elem+0x85/0xd0
  [   15.160785]  htab_map_delete_elem+0x168/0x230
  [   15.160790]  bpf_prog_23fcbbeb395ac6b4_clear_cgroup_kptrs_from_nmi+0x54/0x74
  [   15.160792]  bpf_trace_run3+0x126/0x430
  [   15.160795]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [   15.160799]  nmi_handle.part.0+0x15b/0x250
  [   15.160802]  ? __pfx_perf_event_nmi_handler+0x10/0x10
  [   15.160804]  default_do_nmi+0x120/0x180
  [   15.160807]  exc_nmi+0xe3/0x110
  [   15.160809]  asm_exc_nmi+0xb7/0x100
  [   15.160810] RIP: 0033:0x5607a669541b
  [   15.160813] Code: c7 45 f0 00 00 00 00 eb 1a 8b 55 f0 8b 45 f4 01 d0 48 63 d0 48 8b 45 a8 48 01 d0 48 89 45 a8 83 45 f0 01 81 7d f0 3f 42 0f 00 <7e> dd e8 7e f5 ff ff 48 89 45 f8 48 8b 45 f8 48 3b 45 e8 73 16 83
  [   15.160814] RSP: 002b:00007ffdb09c1dc0 EFLAGS: 00000293
  [   15.160816] RAX: 0000003aced4e2f4 RBX: 00007f1d8d574000 RCX: 000000000000000f
  [   15.160816] RDX: 00000000000ad857 RSI: 00007f1d8d577000 RDI: 0000000000000001
  [   15.160817] RBP: 00007ffdb09c1e30 R08: 00007ffdb09c1da0 R09: 00007f1d8d577010
  [   15.160818] R10: 0000000000001614 R11: 0009718b9187183f R12: 0000000000000003
  [   15.160818] R13: 00007f1d8d5b6000 R14: 00007ffdb09c3358 R15: 00005607a9daf890
  [   15.160824]  </TASK>
  [   15.214040] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
  [   15.246002] perf: interrupt took too long (3135 > 3126), lowering kernel.perf_event_max_sample_rate to 63000
  [   15.308032] perf: interrupt took too long (3928 > 3918), lowering kernel.perf_event_max_sample_rate to 50000
  [   15.500072] perf: interrupt took too long (4912 > 4910), lowering kernel.perf_event_max_sample_rate to 40000

Justin
