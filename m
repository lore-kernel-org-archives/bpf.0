Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793642165;
	b=tyuNXaE30bdjHOID4ctqIXfwu9jdqlIkw86Exw+2aIvd2XrXAB/Lg986cTtTipjuEFJK
	 5wVt1qIQltIGeV5ghBYGlWruC9B1UkkVm1v5NXX6udXjI2/zvt4x8EUwSaeecbgT2mSv+
	 5AtaiyBXuV1cdIRsMBQozND4fgsl8wXFMuA+Qjy6ZMw4kEtTATdum3H7SDU/lFe3CGpHw
	 6E4R/eCJQfUK3cetmNVxbX3+nGwt42X0Nwg14GlRJXjVfttBlQXgiH0ZM1P66j3Hrt2kz
	 52oTlix97caRrpDkJjhk8xknm6fDWPHkOzKZrv7lgKs15tQwR5j6Hn3d4dq/aYPN1+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WoPOH0AtiNVvhL1O4jndQU49NOQNRwz5+nKCw60ro/0=;
	b=W0477XS33k87WQNmQkkk53bf/Oewn3TO+gsRiujAaSFOQhYw7oYgEDBC1jyf4WNNagCo
	 hg/AfFHFbRLZx9OaLG3iw6QRWqAGHHFuR79iLhtuIZ6y2epliT1KF+lLmQRZ1aMSr4y4m
	 stg6OpJe+HuU8LTg4nckEehEslFVMg0l65CXEhgcmhPfGD+q1VBRppczIeeCdMOQN+/a9
	 qpeoz8Vc2wKuBGHPW9cMrrpx2U2VTLDDNB+rwY3gQ7MVR6VPxqhW40F2psANYasjMnpci
	 er+1uJTMgTrgaPrUojdEOhl0258mISDx1q+gB06gb9apWqxDGpx9E4xxy3sL32yokkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBK6l317;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCCA606D804
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 17:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCCA606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBK6l317
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so962058a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 09:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793642164; cv=none;
        d=google.com; s=arc-20260327;
        b=TcyswbIEzSiQw02G4yTim2I4C6ixIcxFmPgo1KY45O+Oc5LGtGVYVBt7pKZPsMTtHq
         tZdAaBXjp00svzY/EU4SvPX7OcDYEeYw9nimBfnjIFwonK8ctlzrkA08lyDgzlxULBvV
         feZkrUgIdjBFzo5RioBQIUXKWwch776uZ+UYZESfnjApaxuVOorI3vxyAVfxGq71C7+0
         TtKonotwHyCesuVVSpy+hsRIIIlJxWtA+zdQBXNcakehtlMmwPrftneY5TlFzmpTnVrV
         OWFqRM8jMHpVWopQQ/hKSKwCr0SZZ/Zm7U1nd5jFeOC265kzm6p/jktzkyY3MqJLnsM+
         Cdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WoPOH0AtiNVvhL1O4jndQU49NOQNRwz5+nKCw60ro/0=;
        fh=E87m5ns1yCPTtF4jxCBSs9j9lcynHQ7PIV9fk/VOlJA=;
        b=k8LHlakRbSRlQ3dBY66bF6R1Nx2Tzh5DYgC6Z6PF1HwCFyrUF9oTLo32dU+/qvELIB
         4nsEm/KfA5HRNxZSHKmhO7fZ7A5YyoZGnyb04kIL4sriCDVwYgDzXOe/JnkUDuPcFAeG
         YYDeIsbBtpj106ubDVF8bWbZkA8XS7QYJ92esyvcR5YYwImMrmqMLDPxSUCV6uHlBuJh
         ROOcx9k+N1Lo9nYaTZKDx7FHsaTaRuZ/o1Cg+i6xqO+RdcSC9EH6keCdgj23t+UdLNW2
         NpnjFNvrHtknSSRiWUjvBv0hFNOy1b/66mZiQvYouALqaxIakN1YgRS8/xVTTIWvjxKh
         6/zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793642164; x=1794246964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WoPOH0AtiNVvhL1O4jndQU49NOQNRwz5+nKCw60ro/0=;
        b=nBK6l317RxAQXnAvyg4sEgZo9GqQsdl8kOYCQhhFiys2Snunb8OzjFByqgk5BG/K+V
         TOTveh6TBJYey/Skas/2bxSgIVfm0lErZtCwpciCR2r1YBOAdzms/cKP8jeqCGZzCGfd
         +Yd7uOR/aX/Im83ennbqSfbU480afG6O5gcpJFuFsylFLJuYt5zHmXFNknLWv4ax43P+
         eC33/2MHN2lH2kz3Q2gfJxb//wJiyaiF1athJfIf9gY2RasFdGaujBgVeqGfbgw86t8J
         5jkbUlTFUebb8jjWt7QtvV8ehK9t0wIvymybBhO0MWdk7ZnaTMZpxCmYg2JonkVsHEef
         u/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642164; x=1794246964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoPOH0AtiNVvhL1O4jndQU49NOQNRwz5+nKCw60ro/0=;
        b=cI08xZtcKLu44vPUUwsX5znuCWKzTTM2riDvfJo7A4ITpCkULgefsS1s6zCgfkjQu7
         zC3Z+Vb/HcjyKKspAGl/3qGaDzS7Ef6LvzqrO4FpNVkC13rqGZIZkS4xDlvPLLJZPZuQ
         GcrbIXaCKYlMrMUcU+ThyUbSs6BikgguVh86js5fxYgm5lOvqAC/GI+URhj9V1SodqUQ
         sFq0hqUbixKCpK5ttp01khtV1bI31CNgA+1i9X9AJgq44lgi95q5ZhnErQt5EGRdAg4R
         /k+HXXsEsQVGm5jcAKWpfrfZoDVGhXJRjgrI2M7Urya4kQ0y0SBtp1WFWEbd0WcevBrR
         n31g==
X-Gm-Message-State: APuU4Z8M5DJfbI7lRI7rXSFQRoHwwu0caGbCe0mB2fqYig/tMhaSvyTJ
	7YHWXDaj+YzIuiMJUJAK713dNF57QSb6vjgS2zu10LsNwPx9JU9RHd/Z3uG7yQy9FK73OqEVY4f
	92f7zq9G+gtAWKLVK/FxKJ055WW+WCW0=
X-Gm-Gg: AYBFou3zRhcrjzJpcel/LKsbWSPGmlJAWiLef1LflWu3ZD0CybX3g1AMPIIlVThy+6l
	5IUBcl5nkOVNWf4NEAAkYzWfm0TvaXPe5tBn2x8P20aG8c1ZOlWXt9Wj11kPVolhmnTELKgBxTA
	EhyaGQLCabr/XmHdSee5dzrt1dMLoraue+qgaA23bX/qFirJJQ7C3vkN9K7kPCpu3p1HPhCWsMq
	J7pUJCwTbccVYbHXnWA6Ib+E6YGMbkaUfwr4BjkKNrPSJT2xDTdPB55YrYJPQHI8XVuzD6gTbpI
	eh4vrDZArR0pwe1L/2GI0S84dnsb3UuROmFnKdxBx23ThrUoOlof9+9nBblRQ7+lvPGe14jUgrb
	tBX63bgKX2YcbQMJy/Eq5NBcyZT65hmZPHmEqF2IyjEGvu+FYORLq885pGCxesQRxvJ6QVPDurI
	fm0oV0djsqydcfJNNr1e+jcxupb+Jg7jHssw==
X-Received: by 2002:a17:90a:e7cf:b0:3ac:9a54:e3ce with SMTP id
 98e67ed59e1d1-3ae8986e718mr9371816a91.63.1793642164378; Mon, 02 Nov 2026
 09:56:04 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102073439.6822-1-emil@etsalapatis.com>
In-Reply-To: <20261102073439.6822-1-emil@etsalapatis.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Nov 2026 09:55:52 -0800
X-Gm-Features: AclHuK8UstIrTAqjTQt170HkAvg-i85ziKHlGvrWmmEEobB7eoAmeKtZATwMa8w
Message-ID: <CAEf4BzYc=cpjD-2oKPXAi2b=CdKoTWwGjWjy50fp22PODN0g2Q@mail.gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: Avoid workqueue deadlock when freeing programs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 11:34=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> BPF program freeing currently runs from the system workqueue. With BPF
> program pack allocations, freeing the last program in a pack can take
> pack_mutex and call into execmem/vmalloc code to change page permissions.
> That path may queue a vmalloc purge helper to the same CPU and wait for i=
t
> to finish.
>
> If enough other BPF program free workers are already active on that CPU,
> they can all block on pack_mutex and consume the system workqueue active
> slots. The worker holding pack_mutex then waits for the vmalloc purge wor=
k,
> but that purge work cannot run because the queue is full of pack_mutex
> waiters:
>
> [   24.646667] INFO: task kworker/0:4:1291 blocked for more than 10 secon=
ds.
> [   24.646669]       Not tainted 7.3.0-00001-gdeaa120a9b25-dirty #11
> [   24.646670] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [   24.646671] task:kworker/0:4     state:D stack:0     pid:1291  tgid:12=
91  ppid:2      task_flags:0x4208060 flags:0x00080000
> [   24.646675] Workqueue: events bpf_prog_free_deferred
> [   24.646678] Call Trace:
> [   24.646680]  <TASK>
> [   24.646686]  __schedule+0x5bc/0x1430
> [   24.646702]  schedule+0x3f/0x100
> [   24.646706]  schedule_timeout+0x106/0x110
> [   24.646711]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646713]  ? mark_held_locks+0x49/0x80
> [   24.646720]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646723]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
> [   24.646726]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646732]  __wait_for_common+0xc1/0x1d0
> [   24.646735]  ? __pfx_schedule_timeout+0x10/0x10
> [   24.646748]  ? __flush_work+0x1f8/0x550
> [   24.646751]  __flush_work+0x309/0x550
> [   24.646759]  ? __pfx_wq_barrier_func+0x10/0x10
> [   24.646783]  __purge_vmap_area_lazy+0x3e4/0x440
> [   24.646796]  _vm_unmap_aliases+0x2d5/0x330
> [   24.646810]  change_page_attr_set_clr+0xb9/0x580
> [   24.646817]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646833]  set_memory_nx+0x3b/0x50
> [   24.646838]  __execmem_cache_free+0x35/0xb0
> [   24.646848]  execmem_free+0x98/0x160
> [   24.646864]  bpf_prog_pack_free+0x152/0x190
> [   24.646871]  bpf_jit_binary_pack_free+0x17/0x90
> [   24.646876]  bpf_jit_free+0x5e/0x130
> [   24.646882]  process_one_work+0x289/0x790
> [   24.646886]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646888]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   24.646902]  worker_thread+0x1b3/0x370
> [   24.646908]  ? __pfx_worker_thread+0x10/0x10
> [   24.646911]  kthread+0xf7/0x130
> [   24.646914]  ? __pfx_kthread+0x10/0x10
> [   24.646920]  ret_from_fork+0x293/0x300
> [   24.646923]  ? __pfx_kthread+0x10/0x10
> [   24.646927]  ret_from_fork_asm+0x1a/0x30
> [   24.646947]  </TASK>
>
> Move deferred BPF program freeing to a dedicated workqueue to avoid
> this.
>

Hey Emil,

My AI says that:

a) we might have similar problems due to trampoline freeing, so maybe
we should address both in the same fix?
b) there apparently was fix by Josef touching this code, so now your
fix doesn't apply cleanly, please double check

and me saying

c) do we really need to have an extra binary (bpf_prog_free_stress)
that we won't be really testing regularly? it's good as reproducer and
to confirm the fix, but I wouldn't check it into selftests

pw-bot: cr

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Emil Tsalapatis (2):
>   bpf: Use dedicated workqueue for freeing BPF programs
>   selftests/bpf: Add a selftest for program allocation/freeing
>
>  kernel/bpf/core.c                             |  19 +-
>  tools/testing/selftests/bpf/.gitignore        |   1 +
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/bpf_prog_free_stress.c      | 184 ++++++++++++++++++
>  4 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_prog_free_stress.c
>
> --
> 2.52.0
>
>
