Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CE372EE2
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765456; cv=pass; b=YR6Mx4m4CB8kq2bEaOubeh0Fh2200xAPYVRydIFNa2p2boxKSF4sRbPBe2FaceGaC0tN5DEFZfy9PidYozGIrMwoOGnmzwXXf8Mu2qPbyi72neBp3RB+GxVBnPky2usGPN4LC8zM9c2EsVAKiDkcatR8u3FfYb4Aewq8WIdjKSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765456; c=relaxed/simple;
	bh=6I/1+qMQ471+4RYnld66Y6RCA6m5prbOV7XKezci6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQU6W+Nt/Y7RzJ63+7NXzJQSbAo4vO7Qq5Ww/edwogF+cq8ovOjrYfpy/kV8uwkf7e1VDLkFag7wYzmTHi/lflrGWlpargqTLORuIL5s3OaY1xR0wScgh7fVCY1+bWMv7ac/ukf7PQl6+V2qnB2h12O2k1MGmddTxkG7/PdJNw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYo6voBC; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYo6voBC"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517dc520840so10748061cf.3
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 10:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765427; cv=none;
        d=google.com; s=arc-20260327;
        b=QYxQq1MhXEuJf2Qx89nJhcpJUrsWWyH8wsBgxtb8jv4TcCjv+gEUmA+VWb2M5e0/G3
         4VFFsqZugfpzRMZrdcCZEXiaA2dCFniBfczkJYtoTG4MsYLrYLIeaA0X5ERA+Q9QUHr2
         awExOuL+/hrC8TUunuB5V8Zu8sk7Baot7OQPbv5pdYNC5ZXdTJc2qknGPRLm2vOUDqbC
         j51/qodCx9twy4aZUK/0L4mdaUSUJulSqsPo2R+5Lpz2BGTSJxkaAvbxL5rSyMn+vFXb
         Tn+x/LNBFVPlqzcjizIUB7yk5juYOanSZCsf0SbhgVByiUmFY0XgIsPvcpVXjiBOdlVd
         /JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        fh=oMfDpjutnoz+RVjNjJOMJTvyUpLctOcFyTWSmRNl9l8=;
        b=fMOXMtr+cRv8bNwl2AWgoCIR9jdsy4bAg2CCOKx+bXjo+LTwY75lP6roXJ+uzRrGg7
         sE4LvgYOG2syCWT32nihfl5ztneDwcR9jjr107owrVuctpO72lF4JFZQvSHx/NLZClC9
         6cDXNLTHUqu0o4NyqrdE3AGT/Vdc0bCsMXUtqzC5+v5L9rUc7qLqv0rcsyGxDfpYoNSC
         0MU5yOgVt8eWSLgXIYDscQhdZ9fo/FOa538643pPRrk0I9HH7W+htRJ5zZTJHDWx1r58
         cXqmPpVntdTnhg8mfXdqgHRUEZoWhth0wkQi0hEw/Z6oLo+4mQZ8UpKRBchAcIfc0GL1
         ALdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765427; x=1788370227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=vYo6voBC/2BgFQ4SxwiD2n2bJd0GVjymeEjikMl35kpmLBdbj3NS+ATEh6MTsXyqeN
         x2+Ou/joYg0moRd7b5+C2fHD/vYehytTAipnHAKslOVZJFwbMk6SO2ZKlrX1kXH3/lOt
         9CE0b0S/lXKVdJsuykaDUPWbP3Orz24rAv0lEqxRce1FuHIOz1iWL5tCdHT2xAaWzemA
         LPK8dTKM3Ty7wgKLYUZXx7o26GJ6BHPcVw17LrBgDJ126Uux28+82Gn1FfVMdoCs7uIE
         Qmoai63ljmAoeGWb/eK9aZqyiNYk8bLfWNhsWmdaPptimLbIisT5uwbtukhoHO7g/kfY
         439A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765427; x=1788370227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=ewLH6RQKpQUCtOXGypIHmtf8/LafMew+AFXGEhwnW9RcjeCbQEdQZyDc/ZSkTg0p1E
         JVDWqoPAfip3wn3IfEujRGeC2vjbGlF/3my2Go6GNgbtggOh9uDgx2PXBwskcAOLh4I7
         iZteDj2m9V4rUGGKKeK+t/vse0GjZ5FwQ21yOgIOovMAMvU2tCdzbMurmr+enFQxIa9U
         q1befduFQCpMpzJ3aqI3LWhS21JDJZE6hgjtYk5Ud8sshzthsGsHCagi8oelAga83qpA
         sOHo0QqJy/GBilIocYYGM7PLbwAtBWmdju+BHSzwK1nbXLAjaRXtw7OaeohNPx+ZcyAE
         B4Jw==
X-Forwarded-Encrypted: i=1; AHgh+RrlHFeD4pB3Qgt5rfQOw4CHQL0b1yb0joP2yAWczO8K3c3lMXfhztcGacB69LatbtM20Eo=@vger.kernel.org
X-Gm-Message-State: AFuF++nQC799Uy02VXWjxWiPhYxke8pfDmbmYBaFVCN8eGcGaunHUkIA
	bgjGU2RyfS5rXZw6On9w7jKX7d9WYdGyuX1J5zh+DohjGmiZY/rTGkd8Bnsq8tbRib5PcfeS5Cu
	NRvrBacxCTg94/KlkJ442YpTsLhjETvPWjVc+qRPy
X-Gm-Gg: AR+sD10GMyiUKeGGhWDy2SUyK7gSzEoaFiKCGNL3CLsHdEWC7XPXAJzti74JdY3PU2c
	DoEs3lSy16MbJMUuFl5pbeFnkIOU4fOA1SE4QGbupMJbNYLBmN74ceQ0tzsVWl9CpJgMIrzyJFN
	HDE87Z/fvciqQX/Fdr8LHQbcjbRvuWNNJI2x7B+aTboW/KhzTOomWVzZoNXuWIKXZ8NHI5rUz/W
	PG6Ymo/YXMPIz8NtMLOQMaJaaOjSW8FOKzNzgjZiPF2rSgxoALOT2vvp/qwzjGzbqkQwoYJxLuV
	SuyEZ+P70G5UilWhOWrmrgKG9wGOCmqY7rlgLpSWeN9lp6DCE4uOHwUzTH2sXTcFPTtg0C1y5k0
	famPfXq6xVJt6s8nJjBn3NnTGWGpAkbWgMUIfpg/ajJUfdFMXhBZBCyZ7Jfg=
X-Received: by 2002:a05:622a:3d4:b0:52d:7b2a:93f with SMTP id
 d75a77b69052e-52e422d73camr87475071cf.3.1787765426178; Wed, 26 Aug 2026
 10:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-2-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-2-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:30:13 +0200
X-Gm-Features: AcwNN1XFn8gzzgrjQfG4ZiFeGArbznLUn8IBe3QpZkDe5XgxFwMYGCWbJrGLGFE
Message-ID: <CANn89i+5+3-u3T0Tbu_NeDSc2L1_Fpqtf_inKB5k0tN=9SUaiQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
> rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
> tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
> allocated BPF struct_ops memory that may be freed concurrently via
> setsockopt(TCP_CONGESTION), leading to a use-after-free.
>
>   BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
>   Read of size 16 at addr ffff888013505260 by task exploit/149
>    _copy_to_user+0x37/0x60
>    do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by holding rcu_read_lock() around the ca_ops->name access,
> using READ_ONCE() to load icsk_ca_ops, and copying the name to a
> stack buffer before releasing the lock. Also annotate every explicit
> icsk_ca_ops store with WRITE_ONCE() to fix the accompanying KCSAN
> data-race issue.
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.co=
m/
> Cc: AutonomousCodeSecurity@microsoft.com
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.c=
om>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
