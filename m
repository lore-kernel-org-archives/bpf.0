Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837571;
	b=F2y3FSC5uFqmXZcbKpPNY4rp1txINm4Jkgmf4S+zYhhUjLZz2fNbkdkwpWslC6XP/TxM
	 7pvlQN1ZhGpqeXDQ99YDGrPBs127D35j2Ma8BIi8+9DTac6o48HV7V4S0rnEuw+1zk5Ml
	 o+aHT/Jo41U3RlbxG7+JG2AgrL9ezCsg/mMGN/mwMVeMW2Gydh6LrJdb5NAyqUocO2nVk
	 zhpoI+WtJdh3nqugpZuM0lX3pab8YJx/z4wAyCZ10Mntu92amt44VVAj1duMacYjBqrfT
	 i0Fd86SHtXguK6nrR+ON2V3BciAYs15kTCQqBtxt5psg7Beh2H8xp28T76bhxgO1sNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=rwJhK3x7XVjm47244mpJl9P7sCIrVF4iHXLk2RT9ybs=;
	b=ctvf9I5QPRL+9CIWkz+YreCqjlpZ5YOiqAKpR6Fc+Uomb5L36fVAhxEKd7Um8RzLmbVZ
	 HQW+vEMocg+Ylh3TI+oOjOmWF84/siN/KoDWtake/wgh/ka22jWsnChINikcQ8n47B733
	 Og2fKnVMwhk2dbKqLkBiNgAl8hmhLrgj4UUSUOXlOZj0wMIADlJar5rI147MRon8G2bbN
	 1VEHe2Z/uhjx41Mu1ioyq5DwgUi32XSysIvzX7hmmOCk7SwXGV5cwvarQ+2fF1F3Y7K7b
	 hTgsY8lM46Nf6AfwFlX/hlB2yyHOOyA2aILLSHX77v7aI1x4iWpB5sAwJq7ro6L/IlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6D606A332
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 00:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42A6D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eac4936dfdso1580025ad.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 16:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837565; cv=none;
        d=google.com; s=arc-20260327;
        b=JjNinP5oJNT7+WPS/9q0tJZmXAL4ZZL5qNNQMu5sPULnhjpu2CYa6nF0kd5ni9xAbf
         g0pGJ9SJNKuU+H4VxvofZmqFSrRpsUIl84+yiVGv3GKetV7phdKkhkn/+o6pXJ4K3juf
         m8vL3ITVpcaAyr6cWUdqMJ3GaKIJutISM+/JyVYkXYj8Dc/fCzFH+K4XQaZMntXogm6y
         +rhfZFnq6rIqhSdO8qiaWxBZpySVLyf/PTT9u/aHjyAxxL9MtVycphHIucVBjID8dq+S
         IlNEVsHzQCqwSoCAEN08gVQNGMGbrWqPKGvrM53hfKx7+Xkv8MnCemMk1YG7NlmSOnEs
         dMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rwJhK3x7XVjm47244mpJl9P7sCIrVF4iHXLk2RT9ybs=;
        fh=ZSn4taASM4FAEBe4PONDR3j4h/IAl0HNQ6FvUdVpf1c=;
        b=iD5Ave8HVqYSsT3ZmLz6onMb/PPBXFuSCX3wQmCnph6tz2M8dIWp6KhHizDbYv67dV
         jtD+DJOZjzG1tvirceqyGwax8rO/S/pwOhaf7ghnQcBaAc4euQICiUx/bGRdWD1XKg/V
         vNpQDoDq8gBnQynaRPZLpBddiulNbJImDdgEJMvK+1IfkwUl7pg9Enu2aaBWjVB5gvR9
         etnHyh+blKPmahyJ8lLx2CXt1Iyw+jnzjR8RuccPGMgU0KBAPQX1hQgXkkr4bxFWOLxH
         KWbSM9fTH22j3nKZf7klGcwo5aCUG2YIW4bKlJcyz3isqITK8r/4fvVDL4v9h4A8hOlc
         tYyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1793837565; x=1794442365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwJhK3x7XVjm47244mpJl9P7sCIrVF4iHXLk2RT9ybs=;
        b=AIPk4pu6kv59pyU6Yftzb6cZja53z0GgjNiVDI0dY1cJucbOX64fTB4HWQprJ6UX3X
         bdYP63NgbU7hxKqGeS6fxjDJ+uk2aEAPmWo9GY9dDfVd2DNFHLu3aXzP9bFUF79PNSKy
         1omu0Tuve/kzRnzrZdOSkaEX0//VbVnQpQOdySSg2rNpGHxQ03eOKXvYNgsaZv9ZP1nB
         HKPe1ivDtl8WX++yckdqnXl45otViFSbIevYUhwZ3Ynn0HQ5Gz+5Ja5Gxk8Bjab7Kg9j
         3/QNU4jkIzgYYJeZxCT/zKUf+spcR9Y37aGtXc+/kS7fg9w7ZXZDM9x072jSL7DhWi72
         lMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837565; x=1794442365;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rwJhK3x7XVjm47244mpJl9P7sCIrVF4iHXLk2RT9ybs=;
        b=pEO8/N13Ts4RlqvaCrNHdfDR5e0y972sR/DSlUAOlk89vuTa5j5ovxUl/i0L+e2dyt
         UD7wmT4C+yIW8IhM9FZld3l965pajoz/tKGpzjV+yjMFDE9LwQaVF6AoVmY0PNvHI4z5
         O0qjI3qVv8goL5jDpWgYXjARQISUk3x0rVdpfgCBieuOKV2X7QHvgMBWBOD0efxGz9sF
         f7cf/LxCKKp9j700xzUzMWZ2YpYjkma1+zKm+AjTAc2Tw/+n0lSUAWEwMTS6nXHKo84S
         4ocA86dEwHn+NrnWdmogRLgk2a0PDwokBMLt+PRNiWEQfCieYk6jU4GOSMk84aXCH2Gv
         HZDA==
X-Forwarded-Encrypted: i=1; AKwUvBz0isLWuOa+qCKxPJKx3jh7DOqMKEMdlFIO1zYWd1q0k4yqehv+pgM59gSTLQB5Bi2P6D8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/byqNMwrMGA5GG1ec6BHLVEKnuvYREcT+NLD66m8+3ULnmizOU
	fNsTQOIlkpnIOAwCSvjABqbCJ9a+8x/x24A3PuQDzDw05pVPunyhB3Wf1sQS/4Cfp2bw2mP9SFI
	sEWl+8XvPeGfynXgWfCx8vpuvkBLS9eR4QvXVcEgmEw==
X-Gm-Gg: AYBFou2l27u7GoPkWXcwvgAy2WM33K2gkbH4yb6CD9YdMSA3WS2YnfrbczfQjLQatzw
	x9WhZsGHwACEIf3/X5TGpZOzm5lUkdK1GAC4FzUaDV5EharklQ+l7W+TaQ/lsas9QIiIzXOGfru
	4ClalpER9S4zXN2R73Ha4kwSi2Ni9dK3pTPDuME3WMapVn/iTjeoPaTMKqzcwWQmp+Az3xfYHwC
	3oht5D6G1m/v/uMzrI1g+kCuCrBq4ZwUsx09qnV1M2aapxghBSFoM1QSkRCQtIDlrO0YGJn1pgA
	uEF+5iVZMxT5YiCQ5xXO9tb22AE2EiehgqnjsB03D/q1a+dT2ZQ+IwrehRArqMOnJfrBuEuHJkq
	Knc+xMzhv8PF7q1ifyIUf3UOLJebkx3YAJFYf
X-Received: by 2002:a17:90b:2891:b0:3a8:1759:2217 with SMTP id
 98e67ed59e1d1-3ae8964f436mr24798413a91.2.1793837565532; Wed, 04 Nov 2026
 16:12:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com>
 <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <e3f63654-0f7c-462b-b58d-05f3164fe340@linux.dev>
 <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com>
In-Reply-To: <DMM2G9OX9ACV.231CHJEPK0OHU@gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 5 Nov 2026 02:12:51 +0200
X-Gm-Features: AclHuK-Mv6D6Vzn9HGZ74QBGavLw0oS_88AhPwykn9JGIV4rU_H6TjzTRynM-M4
Message-ID: <CAPnbwjpQBR-KHwOMG2bo1uhdp22ZW_O5sUj3=vjazVu=Rdnb7A@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let preemption
 cause false recursion drops in trampoline progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: JP Kobryn <jp.kobryn@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 04, 2026 at 02:20 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
   > Add bpf_preempt_disable().
   > Your test forces the preemption in the middle of the prog.
   > Explicit bpf_preempt_disable() will fix it.

   I tried it, and with the whole prog body wrapped in bpf_preempt_disable() /
   bpf_preempt_enable(), Task B is still skipped in every round (on a 7.0
   kernel, 20 rounds, fentry and fexit: runs_b=0, recursion_misses=20).

   perf record -e sched:sched_switch -g shows where Task A is switched out
   now, 20 of 20 (Task A, SCHED_OTHER, preempted by Task B, SCHED_FIFO):

     __schedule+0x48f
     preempt_schedule+0x59
     preempt_schedule_thunk+0x16
     bpf_preempt_enable+0x1c
     bpf_trampoline_6442539626+0x105
     bpf_prog_7dd04eadc26e277d_on_fentry+0x11
     bpf_trampoline_6442539626+0x192
     __set_task_comm+0x5

   That is still inside the prog, while prog->active is held.

   > What are run_cnt and recursion_misses of your progs on inet_sendmsg()
   > and inet_recvmsg() in production?

   We hit this while testing new distros with 7.0 kernels, so we don't
   have fleet numbers for these counters yet. For our inet_sendmsg/recvmsg
   progs, in testing: fentry/fexit on inet[6]_{send,recv}msg, Ubuntu 24.04
   with its stock 7.0 HWE kernel (7.0.0-38-generic, default lazy
   preemption, 4 vCPUs), behind nginx -> gunicorn -> redis, with wrk from
   another machine (128 keep-alive connections, ~1.07M requests over 10
   minutes, ~62% CPU):

     run_cnt 38040015, recursion_misses 4063
