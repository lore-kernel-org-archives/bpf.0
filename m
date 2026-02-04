Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B36A937
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163465; cv=pass; b=ISbK74SS/8Q/Qgeb0FE0rNn63tWUKUPOafCAIaoDkyQi/PkV2qevbyzhBIZOtFRexr8g8DJz12DZK4ASJshqhor9nDzAwkm+syGQ+SDJg+U9iJ0B7J4TQSDC0Ar9uib9K+UDbjodGXcHF5yL5M2BhPfsP8FJH2vyw5QT1EIZ7w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163465; c=relaxed/simple;
	bh=kc1jJFUYanm72nBVwKH4HomeAzrqvPYkmvnRxU+TcFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K83rt9d7S6sWkV8PFEVNoKk9GE4ftm7/opAsy2sJYvyJEHNrZgWsGaa0CJkmtXrfD5TLfCc6mh0PtVPnIIxMMPiSet1fHttlKvppSgHw7G1ET/rVBfqKqdwsY7i4AFUIHMYfZ800qPRM6xge15PGNch2ioFCSo7uyDftShG+vgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2VSMOmA; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2VSMOmA"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso2564994a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 16:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770163464; cv=none;
        d=google.com; s=arc-20240605;
        b=T8O2E4oUa4I+uimlFA3XqkT2u6RyH03gt5ku8uuhdl4mqeCfRzbvknzUxCCZvQL3KX
         SDkE01DEhNn+9Ycs0UP9/T6uo6V6YCGeYKZdi6GWHfHTfxStR4sHha2rLjq76o6sF6VY
         m/EuOq+XnHz/X9pmFspQnPLvvZbAOqm9rJKl3NB1GFjtZ8O2B+WBAD6JXfZIYnj+1Z+I
         PeepXKbraKMBnzSZu/xQutFzyW3ue+hg13t665w4Z3mXtldbrJi7PhmMgMlUydZF1S/z
         wK95BGUmqkXSbNMg0yjx4/Ug9rD00w6UfxyHV2Au56pH8OrEmxj2y1xITphi4/VokQYC
         MlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpXUMfuHceqRwFl5jbM1rv8f5sHVl9+U1rfTT6u6uw4=;
        fh=BF8zMrOpXrdXp5oG1J9bobPHW4+D6H4qBnGOzUspcsA=;
        b=bVTFA/el1Yofih3+MMzwHWA0sAoyNDQvVQyacsHkE7hhbjfmfjC+Uv/4hHFKvKiB7o
         JrGOBGrsKzQ/N5CqLKBn6yLKkf7R2M4bq6TsawYt7V+vt29DoubWhdEUafVTX1ldnnj0
         MI66plUdGickAm4DplNSOOc59PJMVNxMgIQJARb+vQ/iPLh9kipSGiPpfZ+d3A8vVxLq
         0F12+LryApN4lg3ZTBz/Nz6nzUicbLoVAa1skev7Qo1cLi/Etdrizrh1wdsgO/on03wp
         AkcN7s0N15gDcJ1LJLTUmmOl3SpjeJpYg3QB3TX+Iaz1ZNyQBOt0uxYyfp57sG7k3JPz
         YR9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770163464; x=1770768264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpXUMfuHceqRwFl5jbM1rv8f5sHVl9+U1rfTT6u6uw4=;
        b=D2VSMOmAsHiahz4DbC3UFCG+y5QoGVop1AXBMbYN56JVPaSHEUsWtT7jvkNNHdf92f
         h4fij5846cO/FW+kCCjzFeYVgnSz5VAxtelUcl+AHmw6JSlmlyICF1fnB/BJjyeih3dJ
         L9MaVAiyluGLhjNz7DRBnNO2SlFV+j9sal3DpP2+WK06q1jwVj6l5UPbJIcfjUiczU18
         9GTgmsUkdoBP7bC/XVPcQZ3dFk5eWrGhnWEInSuFgYaSX43C7cFSBxlt32kgF2CAw9Gp
         /sRR2x9N/wSAy7Js+li4nTHct31MXLah8LEZRwABgYVNsauWwDmYtGV0VUIPzj9TyRGU
         g1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163464; x=1770768264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpXUMfuHceqRwFl5jbM1rv8f5sHVl9+U1rfTT6u6uw4=;
        b=w/vJKLD/OoV7QD45Btk/LYUWYR5HcoNGRJ27h90FDDQd77dPdZmJxtxUg1nQYvGnKB
         xEJ8Xb5zU1rgLKdvpzSgVwyCXaVCHB4XD+9ku8h4vxHEuqYSuYHtLiRADKpkNfF3TeRV
         D+xRh4TiEpq08oV6wOLvFDc7HN3EWAYxaCCmu1DNCU6HxdRA1ay3yDnQyDioJxqUlyxz
         ED/yhYhpqgHJ1PUlUaMDfIHRVM2E+5CT9xS+iym92ZH4hNQLbnVpPtPEfMZ7WQba/QLB
         U8jREu3lRXFbS9LEKHx0GtMseRJFyj73L3O39/Dp2RPOmRdQ31OFmem+MoafK6sJj7wz
         la7g==
X-Forwarded-Encrypted: i=1; AJvYcCWsNZLeSIAOQlGpFbJnxmOcVGYv7bMbcX0n8AIym4il43LJF7F8WO7qodyyfIadcqPc9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1HVdlhKNCUzvuP/iiTRdVxaheo1uXoyJkslE/pKWysudiyg8
	1lbZ3qAkzXlu+hnnpf0UAK3Gin2hMSnLX+xhqv3pDOuUdPY2O/MKbSzd1oZIKO1Itwfo2t36kIW
	xkMIz6FeMV7wCrEbXLLCs73UjKyuA0so=
X-Gm-Gg: AZuq6aJlOLiZ9C1lI9f8ZbbLF0dI/suQgbG4/7R9kptaBXRQclCu9JLmEw2i2nlxAai
	M86QyJwK0Q5ihnbwWe+N5R5ykkCqatP+j09ZeplA3sZDt2TpGvsz3RkdGQ97q5FEWFKSPdCJbku
	Vdj5wrOSz49ox09Vgd02jTP27oak7C+AtjzmmxJCsJv4szxKru/jwfGcOjPgibEUrspIlpRBwg4
	bpEWdPakhHZCp5JgPso1HxcfogLkA840zEhj5idMNTHLks6h757VhXTy08DN6xVSOEMJzrSY7T3
	3Z3i4lMCxJo=
X-Received: by 2002:a17:90b:3843:b0:340:c60b:f362 with SMTP id
 98e67ed59e1d1-354870ae597mr1057131a91.6.1770163463573; Tue, 03 Feb 2026
 16:04:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128061753.1857803-1-wangqing7171@gmail.com>
In-Reply-To: <20260128061753.1857803-1-wangqing7171@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Feb 2026 16:04:11 -0800
X-Gm-Features: AZwV_QjSU-xHFZaTZk9jkYzsceYdCAUetSnMDf2M6ltGkpGoSojCsn00RQszOxw
Message-ID: <CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com>
Subject: Re: [PATCH] bpf/perf: Fix suspicious RCU usage in get_callchain_entry()
To: Qing Wang <wangqing7171@gmail.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, peterz@infradead.org, acme@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:18=E2=80=AFPM Qing Wang <wangqing7171@gmail.com>=
 wrote:
>
> There is a patch intended to fix suspicious RCU usage in get_callchain_en=
try(),
> but it is incorrect. Specifically, rcu_read_lock()/rcu_read_unlock() is n=
ot
> called when may_fault =3D=3D false.

rcu_read_lock/unlock is not called when may_fault =3D=3D false because in
that case BPF program is already running within rcu_read_lock/unlock
region. So I'm not sure this patch fixes anything really. And even
with trace_in, if we cann rcu_read_lock/unlock one extra time it
shouldn't be a problem, no?

pw-bot: cr

>
> Previous discussion:
> https://lore.kernel.org/all/CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=
=3DwwyRw@mail.gmail.com/#R
>
> For perf's callchain, rcu_read_lock()/rcu_read_unlock() should be called =
when
> trace_in =3D=3D false.
>
> Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_=
task_stack() helpers")
> Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D72a43cdb78469f7fbad1
> Tested-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  kernel/bpf/stackmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..f97d4aa9d038 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -460,7 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>
>         max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
>
> -       if (may_fault)
> +       if (!trace_in)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
>
>         if (trace_in) {
> @@ -474,7 +474,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> +               if (!trace_in)
>                         rcu_read_unlock();
>                 goto err_fault;
>         }
> @@ -494,7 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         }
>
>         /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> +       if (!trace_in)
>                 rcu_read_unlock();
>
>         if (user_build_id)
> --
> 2.34.1
>
