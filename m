Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319A23D7D4
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167316; cv=pass; b=OL1HoTFZJf61k7dYGGvhHlP7FsXw9yBkv4xl0tFIwKbbb7W/UWs93Suhq/lrQXi9DEndHi+ITAsB8j02qeqmC5I+YtWbdxhZeoPMoxUdo0CKqu4rOzkCOVd5zBFGMsJOKErh0mkfcJuHw5daQqDX+bnsMvmh60TQ7efw4QL4/W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167316; c=relaxed/simple;
	bh=dDmljR1YaDmWJButTVewOKZbQwpxrVcPMzLSR6XPJz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeF7U0W9+4XXtUpxGG0+KB+cZpc1jFTWoG/1Ixk0uk4diAPIXom2bv3ZYpcFNsAziARihMpH9XCjq9n5TOGZ+XyXiXp4VGvZNHF4RdC0cI5oqbOH9k05SmzPEpRxE6AZgNJIeBt44HyG0CI4SbLnomZ2KqtVI5vW2uM1TtfwtJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In6Eb6E4; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In6Eb6E4"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so2460222a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 17:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770167312; cv=none;
        d=google.com; s=arc-20240605;
        b=aHSs8z9CM9ejSd1MVa4jHWgD6fJdjf/eo41eiHGBGuH4gOQXs7GNLGo5/O24VfIgKh
         ZS3L0Kof1hXz1pdZF9pcdSATgbrZRccMzYubZPEBSya3Z1WJHYhSZiqFLYLzkzsxGyp+
         77plWMCgqnOvQU48vMWjm3Pk3BFlLUfu1Ct/0KCDbcywNlUnszbucjlwgaPEV9J+atbD
         H2S7OQb4C2jT1YTyfz5bW+RsLddXWq1yicf7zPo34R+8NekfRa8nJnLep9fhUuYrQdfs
         UcnhndvAxjMuVes9mAW2f7xKtOr5Q5Md3Woy4UdVgDzs7iE+7VlxtmMiwSQnOHHoRhL6
         tT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4AVLtBv+ItNA7W6L6HcrhBQtwBUytUYB9z0TDRmd0oU=;
        fh=kIXOO7gIzfs1LAD4tNghtZ0IYThyPhy/yMnYmS59Ibk=;
        b=Ce/aUTcPmVOm6fkteeCaz7o4MwIIiuXgWFIxEyf24HmKy052Y8T4GR73brQznVj6HR
         C3sV4W3IiNfuALQttGjrD/JEMFuln7I/OFZIFKDzvNQkfYuWw4ZPB5AbvNPxxaCasLhs
         zs5kZ3mL70o4/6DLC/p7b9nSTq1N8GFWO0LELWRn/oxnBXJbXC9Glbmo7Rm7XuET2L2F
         vTofl1KU0zJIilUqdwTg7Vnlw+IgQwr7kcO3RFwhad3gh2hdQH5GMIL6G/wzEL+e7FV7
         GGcwbtVZJqtrU8Hb8KROt9JA22XST3Qkq6hGaxMFvmkr1JbEL8S2j4ExBV2bSRgigmaH
         ExGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770167312; x=1770772112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AVLtBv+ItNA7W6L6HcrhBQtwBUytUYB9z0TDRmd0oU=;
        b=In6Eb6E4yLLKnmAImHwkKEfKjLo4xxFTok+eB1l3ENWQ/5YfD5xvRJ7iNu5hIAwjNN
         zxk6xZi+n6mBGANKeO8vsk2BVJtmplBGoFclZAmnGRdVl/FIsZNpCJ6bX3cenQh/0ptp
         IO8k7LtNci2NeiTJOjQ6vbzfu2QSUqO97WrJA2R0oBNQtJ8XcvhBgMag6CEfQOZLAb4s
         wM3LDkygud0Yxzjnvaa44L6gfVPG1IvVrBXZjCGRLVhxnJ0J3mEcZpahCsMmSxCf0smv
         8El2uAF6cRgDYNmW31SNktW6fVZwAP7JwDmOudJC8d2MFKpFZ24pW0oQfR8Pv2AdmBFp
         JgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167312; x=1770772112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4AVLtBv+ItNA7W6L6HcrhBQtwBUytUYB9z0TDRmd0oU=;
        b=QDhNIQUgOtUtPRYnui73Nz+4DUK5izLnSeKZ5zpCA3VnMx1Ir7Q7QUAOhNezIbOfLo
         HD5uX+xp9hFCUv0crwuMPOxRyuvU9i1f0u7zbqy54hYdCgYsPpdscBXYB37cUfO9Ert6
         +9LOl40WcP7bskRqtOcNON9MQIutpkCRauplbmmNDRg5wiM+KuXN17n12b7KznRGluyd
         NofCDDR1oB2U7C3nufyReWe/UhHKSVUJeyJ9QLw9Ih6xM23D+Kt9SeV0yi8QS2yQmDtT
         iEA5Gs1Ou1p2hW8xWV3rB3gtPhlVPNXtN+6s+GFBYMFBQ45nClNEFYl/5uZHa7pueaQE
         bjhw==
X-Forwarded-Encrypted: i=1; AJvYcCUN9ApQan7ZxQbA2V3tsXhddgPzFQt06nBilSWhYmhN9om/6ZG9xdRQWamiBpgnxIp2ax8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8X1l3BeNObg7FhmD1ubZiGMs6vELlAPNJd1Rqpoq0ey4QWoSN
	V9Bld9d7rGVde4MWZtMPGd4Pzxczj6GYpesN1vphgrY8Q13WEmYC5QrmYfybwqcnf9oKggNzrpk
	4uN4Q62LibaKnTrIgGJEZM3z78ZY2Yro=
X-Gm-Gg: AZuq6aLJkxt69hbJxmgj5gq8akbCW3cvruKLBdLn10zcI8xdspfQGD1GkXL+AXMO8mn
	YFyqlyfBNNBpi8kHXIugo/hBQMaLMGJFxwHQDxKAYFPmDGKXAWsnxtlARc1H1OP79DN/e799FHH
	rkkaxtFDMbUD2m+bktaO31ocDC1eME6XaKYO2UP8cx2nTAdrTMI/drPckP+Bfesks79x/EULL8l
	A8j3PF9F1xSLZ72Z88wsnYICHXN9B05aVREKcpSyI2nOhOsYK299qWj2kRuX2JIyimGSQQtjBSU
	fl/l2VDGLbE=
X-Received: by 2002:a17:90b:5246:b0:341:88c9:ca62 with SMTP id
 98e67ed59e1d1-354871db0e9mr909509a91.31.1770167312372; Tue, 03 Feb 2026
 17:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev> <20260126074331.815684-3-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 17:08:20 -0800
X-Gm-Features: AZwV_Qgpn8-cdsaGEqd4GfMTjYIgHVfw8Z0o0OS8K2yxYhHzNsrLuAVXEUnQ4Ek
Message-ID: <CAEf4BzYMJfQN+0SwzBM-DhREHwZ54TwA6GUtFv9=xret9pzXrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 11:45=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> From BPF stack map, we want to ensure that the callchain buffer
> will not be overwritten by other preemptive tasks and we also aim
> to reduce the preempt disable interval, Based on the suggestions from Pet=
er
> and Andrrii, export new API __get_perf_callchain and the usage scenarios
> are as follows from BPF side:
>
> preempt_disable()
> entry =3D get_callchain_entry()
> preempt_enable()
> __get_perf_callchain(entry)
> put_callchain_entry(entry)
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  include/linux/perf_event.h |  5 +++++
>  kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>  2 files changed, 27 insertions(+), 12 deletions(-)
>

Looking at the whole __bpf_get_stack() logic again, why didn't we just
do something like this:

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..80364561611c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,

        max_depth =3D stack_map_calculate_max_depth(size, elem_size, flags)=
;

-       if (may_fault)
-               rcu_read_lock(); /* need RCU for perf's callchain below */
+       if (!trace_in)
+               preempt_disable();

        if (trace_in) {
                trace =3D trace_in;
@@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,
        }

        if (unlikely(!trace) || trace->nr < skip) {
-               if (may_fault)
-                       rcu_read_unlock();
+               if (!trace_in)
+                       preempt_enable();
                goto err_fault;
        }

@@ -494,8 +494,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
struct task_struct *task,
        }

        /* trace/ips should not be dereferenced after this point */
-       if (may_fault)
-               rcu_read_unlock();
+       if (!trace_in)
+               preempt_enable();

        if (user_build_id)
                stack_map_get_build_id_offset(buf, trace_nr, user, may_faul=
t);


?

Build ID parsing is happening after we copied data from perf's
callchain_entry into user-provided memory, so raw callchain retrieval
can be done with preemption disabled, as it's supposed to be brief.
Build ID parsing part which indeed might fault and be much slower will
be done well after that (we even have a comment there saying that
trace/ips should not be touched).

Am I missing something?

[...]
