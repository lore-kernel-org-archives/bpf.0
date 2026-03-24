Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7333FE369
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364219; cv=pass; b=a3XoRaKerFJFdag+8CoBe+q6EfJSUGYR0SmGYxsnddi+VW1dm60FZXuIjF1AcNNbELiM37FWVNV6PJHMSoBO1zjQIxdI26ZQhqr+KBPkdbv9Hl9VoiHpSWVsl1ATa+bTHywsy7zB6owK70CLs2FnNMdcsKhT7eRCGw6q4MfOv6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364219; c=relaxed/simple;
	bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YM8iAmsvLQmJ8qyD/uagNr82FaoXsGdNGC4t49zVXTIq7QC70rFEB2gY90dTqIyEE7LO0pDDxl4M9oLKUw6Dnng1YYwzaxIEWhH64+TfGjfcmDbwnV+drl2hnPp1Wy2VsUv8V4bliOrTYiwgVk/lDKHRQA3vSgj4T+k8a+yL/oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHes4MmM; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHes4MmM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so4827428f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364216; cv=none;
        d=google.com; s=arc-20240605;
        b=NtliEBYT/29ZwzXpTqPTauPuWl6m5rhT7iYTioSFFfxH8XYATa5lnaqZTbJ66WxZSc
         D/1RAND4kAK9t682kPjVp4nykIQwePK41Urg//s1pN/TVHRrXVxjDxNf2lyYyOhV0SLC
         abYmVTgHrTL/NuTQTcm/6ZTSDslE2id3pPQHN9dpdanJeMmkQknUvJ5z0CE8Jlf0v8J+
         sGggoU9AqkPC5v9cVjsTT7iJHcWdHJ7kTYepV4VX31oPTKZv7piQCfprHKER9q+wcWlK
         8ktOnir15uBkf0r2fL5ISDg57yR/n2DYzPCBGk4DI8jpKeA2Ejmei7+FeesPpcQTsgf6
         wJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
        fh=IQeFayOOEOfIw4Cuc+XTtdGunTw2qtDQlhMbRbIwQRM=;
        b=QJvBcCWKmo8pIupYGQrt1P8FiCl7ys/Af+YHXMSZb1Gt2Rst5SlJdkDx/E3RtZZ8Ly
         Y4da7+8/T/QFqMRVorD14nNFmOVR+6N6j17kCgtcgFsQpXiIesVwKXwSSsC7fZEfirw0
         mYe9wdobjWu16akWD3M0J2bR57I71i6Yd+7FFPvjRruGWlw5g8sxtjvFBQJXL5ceKYRU
         0tmlJgxurgpCDY6L64sdoLj8ioirlQqxQ2YLPhATSEjudGtJNAJfoffzP0VY+fs+HjNS
         /HXtE5+eVuyQ2jbktdeV1lho5FvUHJVW/zGOKQ3l/se5cDlb2hy7pnwscKwcmX8JXPHq
         tuNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364216; x=1774969016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
        b=UHes4MmMkvnIgPzDKr67BGZJbzItgQvMmv0nzbjQgDxHuFe+PndO67DiVGt187xkhQ
         pQLWYaPW51FItojAvzWf5srj1TZ1CSR67V7Ar8Or7Vl6AM1x/fSA53vX5C23lwSL/n3U
         ZC9VU+sO9ULum5zdr+puPRxgatyoV3s4NHWaueY86YtcF2ZMjJYjuJn+4SnZA23lV5Jx
         dVyF4k4TDjk3yJZlKwljygKtZwUsjs9aShUKj23olCzOQWFVT4Kwzmy4pCzug1HCnZUj
         lQNaQcTvXVZKcoY43XXUNgWQVreQQCVxhfLnr/t6w6m3CJbp02Rvf7XHnMHyIavc2wva
         d4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364216; x=1774969016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TdbXn3ZDs/dZbLOQTiV+0BY7Obc6wGyCRsucRKYsV0=;
        b=LBl9Ybqk2hYxPGq/BP7/Vw6DW/VAQ3oU0jD4+lC7f+j2C0WOVITJP7exNhFnpkcsvZ
         zJh9gHtXN9821deud46sV0Su5PonqbLnOH09epzGroLs5KLohzfvHTOl0yHIoq4WxgCx
         Gv8mE3STZKeqkuIxzy6G9SSTPUAkvhBEe2YE29hZyj6tJZeI+FwjIwBo1xz/Gs6giBLh
         Mz7Ccbf52riKwGYScpO7EFQL80JyrnPHPIv2mq8X/+aFD4NLXvV+ybXdjyxeC4KW9TPN
         QuFuxL/Yi++njSf2uygYSYqke3E5euYqDYaR6o9UpjRLXmCYp/U4HXyk8LXaGfhJhu2W
         6aJA==
X-Forwarded-Encrypted: i=1; AJvYcCVZHat5iiOKWh/iC0bxnY6lDSswO3db+iTiiPP/1C056dPMCdXffApnwYSuiNkQmfbX73A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdtoat1R/5TFL0/P9j7Sw/xB5nSS1pJxCgoP9rcYFDJfhiDriG
	dsxh7EHF1UeJWUm+RQehRANejFFoRkPgxpq5/oRw4keuB8noS1VDWfE2ucXVeGrkTn8Vlpwvirz
	Mx5Km7hVUWqeEMnp07uv2fFBJj2lQ0Iw=
X-Gm-Gg: ATEYQzy+T60VKSfkdyhsl1SrsLWMNzpk9KCVXhWligL1dykgyglpte068QUzw1Y7tzU
	7HBM1tOiIjBi+omX6t5loWvXWMjllKi4fuyNy+U+4y23Q+wQ1COkUx1fROLwFu4Tdz/13D47fZm
	YCHHMv0IGWVDF21yyLesGTANxoB6XPbQ8nmu1CeXiOIfcIXcAR23FhZB6IyYX580mIZgdBnqazc
	39s+bCXGKGyMTK06nQSwIoB5LjLB5r1cd9DDVKhgDx2djtQJiCiZiG5f5BwcXjGejOCPSQUkehO
	pG15zqyBr/NQd/HjrANkTZdxOJ3QmE3sAYwM+Q8cNBfh9PtaHiMSaofYHx+jvuwi3NWM4aPEOB1
	0GICq61HO6lQBpnDIwwMAVdEr/w==
X-Received: by 2002:a05:6000:608:b0:439:fdd5:10b5 with SMTP id
 ffacd0b85a97d-43b6426d710mr26863361f8f.39.1774364216239; Tue, 24 Mar 2026
 07:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org> <acJ1HRXomQhbTN4_@localhost.localdomain>
In-Reply-To: <acJ1HRXomQhbTN4_@localhost.localdomain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:56:44 -0700
X-Gm-Features: AQROBzDJ2iP-PoWSWyhZ84FyoYg7DjuQTXoVPXfPQvooPzE1dJu3zm52xoJ_bGk
Message-ID: <CAADnVQKcQNAGOeyt6SOAss0EK4k3A6jYp7-FvgpS0waO6pv-UA@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Neeraj upadhyay <neeraj.iitr10@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 4:27=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Fri, Mar 20, 2026 at 03:29:16PM -0700, Boqun Feng a =C3=A9crit :
> > Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> > of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument ca=
n
> > happen basically everywhere (including where a scheduler lock is held),
> > call_srcu() now needs to avoid acquiring scheduler lock because
> > otherwise it could cause deadlock [1]. Fix this by following what the
> > previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> > the work to start process_srcu().
> >
> > [boqun: Apply Joel's feedback]
> > [boqun: Apply Andrea's test feedback]
> >
> > Reported-by: Andrea Righi <arighi@nvidia.com>
> > Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> > Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms=
 of SRCU-fast")
> > Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@=
nvidia.com/ [1]
> > Suggested-by: Zqiang <qiang.zhang@linux.dev>
> > Tested-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
>
> I have the feeling that this problem should be solved at the BPF
> level. Tracepoints can fire at any time, in that sense they are like NMIs=
,
> and NMIs shouldn't acquire locks, let alone call call_rcu_*()
>
> BPF should arrange for delaying such operations to more appropriate conte=
xts.
>
> I understand this is a regression trigerred by an RCU change but to me it
> rather reveals a hidden design issue rather than an API breakage.

You all are still missing that rcu_tasks_trace was developed
exclusively for bpf with bpf requirements.
Then srcu_fast was introduced and then it looked like that
task_trace can be replaced with srcu_fast and that's where the problems
discovered. So either task_trace need to be resurrected
or srcu_fast needs to be fixed.
Let's punt to bpf subsystem isn't an option.
At this rate we will have rcu_bpf. Which rcu_tasks_trace effectively was.
