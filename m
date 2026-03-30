Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80C32D7D9
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883281; cv=pass; b=H7w7z5SgvCffsvF9yA3WG91bluPTmllNG83o9i/zpcoIrHWyLwHytIYf+xZlnSZ8YvGbg+ATk3j1T2PD7uRkWucT2d7ecFKDAFiFc+5iM7kDpw7wKKDDDTOk4UEcAdUd1lNdos2cDNtGn1o8yj8kqYkafez4BVS3WR1gdpfSG28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883281; c=relaxed/simple;
	bh=UK5ug1KBpeYJuJULbs8QD76RwgEKjrrIQ1Z/71R11EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMp5EQ0np8mBgy9iIrD3vdmbIEnwsbk3Oib1NvRi9ifeXlPgqD58By0WpLzIw7/VajPQHR5Upx+pVOUouqxvqP2tp+skmMyhFIQMBKnXkq5R5pWb5tgX7DLxJN/w0/WeGQWqIt3zSeX16iTxPwVLnxpkaSqkYPhHad5J+WuBgBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5GQmRSL; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5GQmRSL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d029f346eso601332f8f.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 08:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774883278; cv=none;
        d=google.com; s=arc-20240605;
        b=ZNXk/DDNYRqCez1EJ3W2qGkwzc2ur9biVvWdtsr/PCOAeanudjw8iYy9thPxQTNLpA
         TtQdw42rFTdVDAeAXYREbuet21Igb4hx5RuUm7PGm9tlzCNHuXL4/89W5LSkasdgCoHZ
         33d3X38CWJiuFF12ZmZ4XraHnNnUsk3Tl94IRutZr7dM5ay3uQQlg+exey3u84CwtQxS
         nFa3Ts/QMYjKAGctcEoSPQ9FQMbGjosCEt86x/xHOrBSxwODor8X89HPGFymRNRbl7PU
         6zTrehcLWxsjRj0PI0PhbBa9EIEri2B6m1T3S/hCYdgSE2s2Xz8qE3Qa/v/B1XnDQFwX
         onCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpAoifrbsExtwuyIxh8a3oPuRg+33Av8BEc/LUDWfPw=;
        fh=dTfg0Za9rZfKCMgsmMpxvL7jzAmsUwM0lA5XC4HwOTM=;
        b=MkS27yBTkqmY1/kklwNe7JxVeoSpI/2zy0Dh0RqetjPJnFPfBWtUSUu5ROBIZPmjgO
         70kwfSF1Xl22QEaubCeomHei2Ks7ykfa9kMDfZJxX5bQAxQBDqr76JWN/xY1yarChMN2
         RssqMsl5nzJf4FkO270rTQQ1W+iHOff5PNcKwosLk+PF6tOxFqcpiJdd8Clgu1CwaMuA
         JrsFfTs3XbTgdUK1Xppirf6LNwmPi8Y7HO17jxWUUBWwSL3v+ebvrECBm0B1GIHcNLji
         knAzWVevXygx7cGl77vj2E+eNa3mW8XlJ/6CVaraW46K3i0VWfgjxgPN2r/mpqOe7Uks
         nMZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774883278; x=1775488078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpAoifrbsExtwuyIxh8a3oPuRg+33Av8BEc/LUDWfPw=;
        b=c5GQmRSL3TZpOoRXd43vVtJ2jYorgOnNmUNBu4Vm0rL7PY9Yh7vpysrVZWEs30ry3X
         PQGMRovZG0OP+jeC4TSFDXlKB8/ZjI1Vgg55eWWgSx415wBXWlhA4//gnHJmkAk22r7L
         3I6/7bhR62xz7oripaTVfuQ6fKjS5tdgFcGeFVVHl/AHnJ+Q60hLqvMoap2IqT3rsuWq
         mmzSCMLD8aG04BXNvL3n5hVU8cA+Smdoffy2DxM+I4Mtgsc6qtrjJRjwyEMsHxCuXOvk
         x4U1bM4pe+QlwJEUtXNhbfuOAQrxVgoWSohm6xaA3s77XEY0hLqOPFORueZIEGOQR8qB
         hduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883278; x=1775488078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpAoifrbsExtwuyIxh8a3oPuRg+33Av8BEc/LUDWfPw=;
        b=Py5YGJwsQ+kv3x56DrPzC2okKzKErKStzE1GKWLWcCT4/70Dl0aD2PRgJnbp2+XxAH
         V6xCqUQADzMMt+5p/hm/rZY4mSg+lakDo38gKUUy/+7OoojSkX79ooUfNUWro5rQugPQ
         Ew7CktB2dhXz1OK1Ru4TpOUb6jf3t+6rAlKo+hZlv2T6hPeoDFJp3n78MdLWuC52uvoS
         u8HTJuJ/HJL8g3NrV+Oqsj0iRiKwNJEuHKyBQn4N8+2OWQQIUwj4Eu4jk0hIrASNS1PC
         4jr/asK3Q0NJcZd8C55CW1ICu3WWvAmeBDnTGnIhJUXt+317fNkg2KwJ2hXpxJudAfes
         EA0g==
X-Gm-Message-State: AOJu0YzWRdsOA483CJUfaTSfYsmA4v6SnhE4gsrjDJHKjDempStYE3qq
	uXUjEGpDMuqCmYx88090iqKJvBqTpRLRLbLR0k05N3g7vyF/DcRvNi2pI2CmhCpwzzX8qvW5vm1
	qg5ZWkPKo6t6pc2hF2+QEOeXHF4PCi78=
X-Gm-Gg: ATEYQzwzqsjTm4/gGVhxqe7a2CREskUqgEKPYcTdgTRJ0oOx7jyjTiUDOT8bk5LF3U3
	aIe4wih+NIcFaP20vJ0OWHO1tAhJxzBwi4opk2YO62Q+dHLx4cOe1JtLGhPWeRmQLhZCu+3K77W
	L+qOQ5K1oqPFHhqhZp0GVeJm953BYsZQS1gC246z+p8Sgo4VWxM+Yv467khPQM5CFYb+XglqyjY
	5k2q8BAIbYLOmgJM1AeG7bm9ramMs2G/eayEE5QAVi2SlfzwMO2zb9FNB12T7YqIyR7s6oO2MF/
	yYC5kEZUI9eDMEbxQSOsSG0I764jZUt/3LOCn5bLiXWckyaIPyLWUcybsPU8Of+tKdf3hpIM+pT
	72XtS+gmVfJGI2M5VZRNg9IUkjw==
X-Received: by 2002:a05:6000:2083:b0:43c:fd7e:72eb with SMTP id
 ffacd0b85a97d-43cfd7e754bmr9007143f8f.41.1774883277844; Mon, 30 Mar 2026
 08:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330143102.1265391-1-memxor@gmail.com> <20260330143102.1265391-3-memxor@gmail.com>
In-Reply-To: <20260330143102.1265391-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 08:07:46 -0700
X-Gm-Features: AQROBzAMZrEGdWTlUh_7MruU_0oqzFbTePZaRBwxjrEQEFfQT0Wazn-1JydwKyA
Message-ID: <CAADnVQL1AGZtdMtB4i6GAmNTVT==v941w7+uPaW2ESd0k49uNg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Retire rcu_trace_implies_rcu_gp()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 7:31=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> RCU Tasks Trace grace period implies RCU grace period, and this
> guarantee is expected to remain in the future. Only BPF is the user of
> this predicate, hence retire the API and clean up all in-tree users.
>
> RCU Tasks Trace is now implemented on SRCU-fast and its grace period
> mechanism always has at least one call to synchronize_rcu() as it is
> required for SRCU-fast's correctness (it replaces the smp_mb() that
> SRCU-fast readers skip). So, RCU-tt GP will always imply RCU GP.
>
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/rcupdate.h | 12 ------------
>  kernel/bpf/core.c        | 10 ++++------
>  kernel/bpf/helpers.c     |  2 +-
>  kernel/bpf/memalloc.c    | 33 ++++++++++-----------------------
>  kernel/bpf/syscall.c     | 24 ++++++------------------
>  5 files changed, 21 insertions(+), 60 deletions(-)
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 04f3f86a4145..bfa765132de8 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -205,18 +205,6 @@ static inline void exit_tasks_rcu_start(void) { }
>  static inline void exit_tasks_rcu_finish(void) { }
>  #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
>
> -/**
> - * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply=
 an RCU grace period?
> - *
> - * As an accident of implementation, an RCU Tasks Trace grace period als=
o
> - * acts as an RCU grace period.  However, this could change at any time.
> - * Code relying on this accident must call this function to verify that
> - * this accident is still happening.
> - *
> - * You have been warned!
> - */
> -static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
> -

This is not a fix, so respin to bpf-next, and probably as separate patch.

pw-bot: cr
