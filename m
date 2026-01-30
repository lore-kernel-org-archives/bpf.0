Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04834274FEB
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809962; cv=pass; b=f4RiBdwudJ0mqveO0Cr6oAtJDyKCiR9nAMf2fLXPxe8Y/t+Nrir5dqVjiPpRxUwrRFnni7wcZAxmn3FF7/EBM1NvmsSVpEPqDBtBz0b6JeSKP8RadBGj4CsYtcTpT6xz7Y7jdKPhYDpdKr7CbnF8RHf0LRheszcuELYUXegsUCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809962; c=relaxed/simple;
	bh=HkOaJWCEUAx+DqMUi5U7zuLkYyzEHmXgEtebmuCCMjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=go+nUxegJx591R65Kk5NpKsdLBXm3Yyur4awsAFWamuOpb9reA63wYiJpyqm87qyiHlYC6p6zxlZPs//E0irQDaAacsySVFWJhXEjkrB8ZJI9gaP4jKSgBJ8NlAe4I9akRYsWUwoikJVgYSpoMOyXeTMrTUz800HPfClqnGBHeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDZfzMrc; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDZfzMrc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c363eb612so1434957a91.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 13:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769809960; cv=none;
        d=google.com; s=arc-20240605;
        b=UXXRohChwsILOLqzMhLLOHOmbRcuOxVSuEBEni/TAjGN83UNmyKIgwNJXweRnucq++
         auIVOFIqTxWy8Qef6VLb1mv94oN3Q6p7YzBjwHxTRBjPBpufr4D75UEKypFO40TGeSJY
         yHCcaLkZzLBGhdkSOX2u2sZFuhhxZd+Zlbm+1XQpxv+sLWo4NPaoDu4G7loiiQy2FEfX
         zsRgyMlGzyLbg5IJhFvNL2MNGxkC6zcC3y1qZn3JhmxKbtdZLFya4wqoMGcCjFOG0YUA
         gJNgvwvQYF8hJB+eq98mMrbP0iWJrEEzMlqxLRlGuu3+eJ1LjyiTEEQpAmCk2FNSU5+I
         0f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkOaJWCEUAx+DqMUi5U7zuLkYyzEHmXgEtebmuCCMjE=;
        fh=g7NETJjdV3+y5BX+LVP5xVAOVBD/u3Z9FLE5UkyEbOY=;
        b=Qij/SATuK1eXfFqAnK6r0FXxEo/riQBWT6nTKYmYYoAe02+6vuRPNhNUnSxWIdL54D
         wGEXMcoGGgqErgePNNKNzEYmp38SCqeoPUxfEpRZWNswhBxyyuQursnBHMsqmgkYXNwL
         CmSWfbs9F71+A1HBnZGPVx77flUsLWNTgIje/sJRvir1vkCVxESvJc4ntPsW7MehxvF5
         /EF+9c1H8Dp3ycLZUb6EzY74YyqtqzoK/UIRDFMDXB8llYmRx7k80/9MAO78GCsGh9MD
         nrwIO1rP0NDVVggDJTdkcKUKBx7TzBWXH72c4FgpRujJTpaF4ZVzpSnerOKOlRimufNs
         8CcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769809960; x=1770414760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkOaJWCEUAx+DqMUi5U7zuLkYyzEHmXgEtebmuCCMjE=;
        b=cDZfzMrcZz7dVdYqFq9tqEKHXlxV+6/Mg6iA4l0eE0YiF2frcsvqx6819mht3K2rQQ
         pxloWyd+m8zfqVQpxsJKq8dHaGn/5dGXITGQ/4Vt5pQoF6DbHG2HbpHUJSaRitJ/VodX
         YtcSLD+r/3lQr/+6EtB13qIzzntMQr1a/ztFXbaJXybLgT5wkaGf76pWRKs0vg21P9k1
         kelpaShjjviF8BbcqrspuBob+8mhU6HGHIUIuJeHT00r3q7qVlCu3M/m+o3WxqwhD49l
         +3WaketBn/o3et6IhXy7mwR1XlRUwCXJG73nraJI5UwiVOO9QuQJVlYEkxtHSlVgVTdg
         K95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769809960; x=1770414760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkOaJWCEUAx+DqMUi5U7zuLkYyzEHmXgEtebmuCCMjE=;
        b=vyh48inBJ8LdUKnUwZJbOtWX3mMamdl1mmfRX1oBxDlxVWOl+X2JbZ8fQ6CpgPi305
         OfBGL4BVbcaMVGAPrhLN7ZMl1L/gsmoHPoPumSMEOEi/PB+4g+quuLAgMTgQRC21OQKQ
         gVbTMxUyPXuLzY1N9B9Upwczu47gFiYCZqdx55YcN8gTXqW+JPA92r1Cwpg2VJOX3rth
         8zO2Nesv/M1b3bbblA0ArQbPB4qvXe4llDhEZMsAKS4O+Z3YjIgyQkxcv/3WycQkb+cu
         OMkBFb8EbRT8HyJ65659WD9u92/waTfQZGXAe6sUGEQHOHmXev0hmn6sAnBKuck8KSpN
         CXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6rzPBAXIpmMQQatv9tLMEBqjT9z+gPdPAbg/+tDU+mAnbajUD7Ns5KDhJkIvdEffMYNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IOPi1rI8Rl/82+21rz5G0bZpQHH4YC2miSUw3HqJ4hhj+Qc0
	y83IlwgAhM4cp3+WgHHiuPo/HxmKP7F1BVyRlHsXCh7LOPrZrbO/Et43eCzz+p0FTOBP2j6xaAX
	lL17PQhY+n34r8ZxT4zD0iNkc7Nq2CCs=
X-Gm-Gg: AZuq6aLgxz0mYUwSYtgAddRAUi7HBTPqJ/uIFNYjk75tFelFRirDRTxQlbprH1dMGYI
	pXHLnlr0qv4a+1DZvAFRzrREYMxIAb+LsEblinb1kBv/6iHxzo7Y2tLsG2Ei3VmTBm3jPbYGubI
	7OgXD0bV25jIQZHrYorajAboTgEiJqKmdyFuF/fA82OkbpN0LSIwRG20gOFDBDzlKPG1cN7EeRe
	MgaDqULNoPSU23JgLSW9hAulWK94NkFc+KfO2A2y6I9iWNpPsRxLXSdtaQXXCWzubPHaS9erpqD
	imYloyZuv+g=
X-Received: by 2002:a17:90b:2dc7:b0:340:2a3a:71b7 with SMTP id
 98e67ed59e1d1-3543b30027cmr4400456a91.12.1769809960296; Fri, 30 Jan 2026
 13:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com>
 <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
 <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
 <CAEf4BzaEiQ8FApp1KMrCvsBVs+xLrk_mtQFUCfXZ3co2D6Oayg@mail.gmail.com> <20260130152400.6a71abb8@gandalf.local.home>
In-Reply-To: <20260130152400.6a71abb8@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Jan 2026 13:52:28 -0800
X-Gm-Features: AZwV_QgbUSaz7MUj7OhYEDzxdyYbizN9CIRR2xJRA3yE6ZDvsiSkjHOqbsVLyqI
Message-ID: <CAEf4BzZJyKDNtyefi9YL=jCX4fi+jCBJ-4uFiO-1Bv8ziqWjVQ@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Blake Jones <blakejones@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 12:23=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 30 Jan 2026 11:50:16 -0800
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > I'm not really proposing anything. You have a baked-in assumption that
> > you will have a user stack available *synchronously* and that you can
> > use that as some sort of lookup key. This is simply not true with
> > SFrame (and asynchronously captured user space stack traces in
> > general), so you'll have to redesign your approach (or you just say
> > that you only support frame pointer-based synchronous stack traces).
>
> From my understanding of what Blake's tools are doing is that it records
> stacktraces (both kernel and user space) when a task schedules out and fo=
r
> how long. This shows how long tasks were off the CPU due to being blocked=
,
> or sleeping, and even preemption.
>
> Currently, when a task schedules out and comes back on the CPU, the kerne=
l
> stack is combined with the user stack and it's put into a hash table wher=
e
> the time off the CPU is added to the hash entry's time. I'm not sure of t=
he
> details here, but this could be updating BPF maps and such here.
>
> The issue that Blake has is that this cannot be recorded when waking up
> because only the kernel's stack is known. The user stack isn't known yet.
>
> One solution we discussed was to make the hash key of the kernel tasks an=
d
> save it in a small array that also stores the time it was off the kernel.
> If the task schedules out in the same location multiple times before goin=
g
> back to user space, only one entry needs to be updated as the hash of the
> kernel stack would be the same. When the task goes back to user space, th=
e
> kernel key is attached to the user stack trace hash key and added to the
> main table that associates both the kernel and user stacktrace.
>
> But if the task were to schedule out in many locations (Blake has recorde=
d
> over 50 unique locations where a task could schedule out in the same syst=
em
> call), then it would need to save the time off the CPU for each of those
> locations. When going back to user space, each of those locations would
> need to be attached to the current user stacktrace hash key and added to
> the main table individually.
>
> Note, these temporary kernel hash keys are unique per task, as they haven=
't
> been associated with a user stacktrace yet, whereas the global table is f=
or
> the entire system. That means any storage of these temporary kernel
> stacktrace keys needs to be done per task.
>
> Blake, did I explain that correctly?
>
> Now the question is, is there a way to easily store these unique kernel
> stacktraces along with the time the task was off the CPU for those
> locations and be able to attach them each to the user stacktrace when goi=
ng
> back to user space?

You can use a global hashtable keyed by pid + kernel stack (either
kernel stack id as returned by bpf_get_stackid(); or just embedding
the entire stack trace as returned by bpf_get_stack()). You'd need to
pre-size your hashtable for total number of unique kernel stack traces
across all threads, so I'm not saying it's a perfect solution, but as
anything with BPF, there are some trade offs to consider.

The important part here is that the kernel stack trace can be
retrieved synchronously, so you'll have its contents right where you
request it.

How to join this with user stack trace (if user stack trace will be
known later) is up to the implementer, there is no general best way.
Pre-generating some ID is one way.

Let me address the rest in reply to Blake's email.


>
> -- Steve
