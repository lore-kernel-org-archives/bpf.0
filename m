Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDC3AF677
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789486577; cv=pass; b=Ch0F04Cd076S3+VhbSEH2vkP/zMACzq3fG7vgplQd+o4kFEYZTbkDzwSB5TWl6NEQm8PmVLKggp9uxy8u2IXjQkMruym6ZDjE+J273Wn63+urUSvnQS7Dwbmzt/vN5OtlhhpW1yJYXIIwD3Vuq7yMIHYEfSHDedGOtwZlsTtedU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789486577; c=relaxed/simple;
	bh=YI+W8R6LmUfiHRf+cLLJ3hjHCzqafGPuDCd4ahQ21/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKgMuvX8OPonth5bp/pkqqdP+ogmDz2mFv+PqbpjMjMWiEhvAg1zAC+/NvLo1uSK2gZu+b1xboWh0x9brYuu+5/PF27/cDg955LPaUrQSsFvOvERBYPy0SAzHYUGvjBQMq8zyRPyCS1n9F68Njx9i7Du5H0P5xIpiL10s7OV7LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9+TbZjy; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9+TbZjy"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f560398so84519466b.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789486573; cv=none;
        d=google.com; s=arc-20260327;
        b=gxa85LQrG2NG5TnHRR/Se98ilJD+SkJc7q1bRo0f2sldZ/j9UuOOrWPxW6JdVOFy1c
         3Ahe5likCBU9AXVaDhYAfg2fTnpZePS9o2DXwCqyb8cowLLWjbYmgMwLdKeOWzdok9/C
         /DfV9ETAFGhD9bAsP4UQ3d6nF6/74qj2Y4Dd8RoDuy2jAUgSpEvndTRmmy6XInNEr6+0
         UeZeLRvEr3c0/H8YPYSNb1AdK/nukCPlTcH27bzqJKqIAWvCQkAHN50ay8SXBkEIf2Du
         vKf3/L7Deyr3gEe+DoMFVtBzL8A71eXjZccoapI7rDtnFBodmRuH+F8mA8+LRIvFutIp
         sXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mUkY5Sia6l4PhBlX1ZDLMGsOaNUKMVJcdyjNi1/F244=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ckEnfaxWYeUBkriTaE9eCcIaIpqsDTJz/azq0Nwr8i7ixVcge/LYSJiv6K8rWmUdn+
         hFC/r6T6coC5l4P8MrkEwAXj2dOle4COKGQusuCmPhjuv7zkbMD8wMwLm9yKadBRknXY
         tSNfUvGTwetTV96MPCYBS97QFmei38cLC8mTT0ITO9k2suZeDXj3qG0Rw56FxUJPd1Bc
         TrwIYuGLTkHMgcO11zH89xNXg09npyH8wQzdEH5etf6pPAkyqwB1jynMfDPsSdP/VnPG
         kfRji+Ihe7m2vuf3QuyOGnvwiTtD2hdWTpvqZ22L3kVPVZEw/ujmqgjB2Pr1fpFtnQ2y
         Bsiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789486573; x=1790091373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mUkY5Sia6l4PhBlX1ZDLMGsOaNUKMVJcdyjNi1/F244=;
        b=T9+TbZjyh8ebgphZa700kJ1V+DC0z+j7P07dBNavNZ9n02WypyzUVCGVbfysxaS5N2
         grF9+q0iSkq3Qkw4+SD24R8Z7bm4TuxZX6p7tKbLhP6QSNsAP5LgwY+19IlKYrZZTlk7
         EXWBct9IP2YU7EdPzHRcZVZrAbhfEB30QhXo2bKTrNr4Fhdl2UG/07MqS42r09y9/Gpj
         RtbNzhrVT22BwuZYU77bIgrZ2OSin7uwyTvYTNP0LrWeCrflR0pVlvDaWUf2Q060GiHB
         E3h44kCs2hpbR560wW65RiR82/QbmEBAEG9F5vKWl7wGXtkfq6VuN5JMTVFRO+DbrG/j
         d1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789486573; x=1790091373;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUkY5Sia6l4PhBlX1ZDLMGsOaNUKMVJcdyjNi1/F244=;
        b=bUau6y5D9LE5vgIUfyoxupFYCq/vEmh6qtb76dOGOAAsx7j8ZOzdFmRq99Gk8J09df
         Xd3ECMLkzU2twJBOBBaTiJXZep/QCbyECgXW6Wk3Gy+Z87E7ZVBN8YhhWMhBpRTDJ3vb
         +rLdNdgBhAu97TkWdFV/I46TKMmXj4FJypXKHPHMl/MgQz0DIpcLaVVd1sAo+Nqr+fv5
         DkONr9R4tf9mJuCJAg1QNo9WEdkmzbd47yaD62y4sayw6nRQK1QRSWJNUWFPHHmMcNDx
         pXurWZlkigZgCv66rKvb/ypFLAqQ18SSQ2Tl5Cfz68sL9G4KzAEQgXAAZsLqUlcOQT9X
         sRJg==
X-Gm-Message-State: AFuF++n7LbH5pM3r2/kEe++AhZd72r/ceiwLmnf/OC5val6Kp4HGw+Il
	KecmSgPKsByFqtWMOfASFjqwR7k8hoTjcRJPd9nQClN9ecgC68bbu4KHh/UxyOAl17rGCLH9Ow+
	XrLQKLB44/d/zITg6vVDvJdN/FqhIEeyL3bgsnnpZBw==
X-Gm-Gg: AYBFou0QZW+SbCkZOT3/iO9IKWLJI2gI+zXdo1Tr7TKznByyHLpM5FwjInVN+FSvAL4
	0W19J8P8V63MQevr5iaMUL5zQVeB2tPklBlKR+8A3GqiZFA6MPiBP8gdlWMfixZLHjBKNS0anR7
	o7ZSH7vdsMNLpdixITzonYgOlKIrtasphsKtYAH/fjy6VOSLVrcuhQH7NrjV+pol0qPeAZK9Ssg
	tUsraEo/0FmZkNzmLoLwD1Ngfc6mlz0iivnns49MFmiowPCoxz59qUn97C0hrukc5SLSDfXkkyH
	aMQBZ0gAIUUTWX+5PLX40aKFaRDCq1xNTGKK3YVwfL2gBY+Qqx5YoTZFIro2odORA1Clj3U=
X-Received: by 2002:a17:906:c111:b0:c29:6c88:1213 with SMTP id
 a640c23a62f3a-c29d772f566mr132538566b.8.1789486573000; Tue, 15 Sep 2026
 08:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915143640.36292-1-puranjay@kernel.org> <20260915143640.36292-4-puranjay@kernel.org>
 <20260915150203.4C55D1F000FF@smtp.kernel.org>
In-Reply-To: <20260915150203.4C55D1F000FF@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 15 Sep 2026 16:35:59 +0100
X-Gm-Features: AcwNN1WK90HKyYW_TdUL2USpB3yC1jJ4otSuSwe7x5DBLdol3PqnDqGMvZ-Sn-4
Message-ID: <CANk7y0iw06voTJoXOWWwvUch67MKUetQa=YbwOUXV+nRVj_Xag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Add bpf_call_rcu_tasks_trace() kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] bpf: Deadlock risk calling bpf_call_rcu_tasks_trace() from NMI c=
ontext
> - [Medium] API behavior change in bpf_timer/bpf_wq returning -EBADF inste=
ad of -ENOENT
> --
>
> commit 144bc88aada0f77bf3ad5ba54cb25dc2ae7529ca
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> bpf: Add bpf_call_rcu_tasks_trace() kfunc
>
> Sleepable BPF programs hold rcu_read_lock_trace(), not rcu_read_lock(),
> so a plain RCU grace period does not wait for them.  A program whose
> readers are sleepable needs this flavour to defer reclaim safely.
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 6debb92fc8740..b76e2866693af 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1428,7 +1428,7 @@ static int bpf_async_update_prog_callback(struct =
bpf_async_cb *cb,
> >       if (prog) {
> >               prog =3D bpf_prog_inc_not_zero(prog);
> >               if (IS_ERR(prog))
> > -                     return PTR_ERR(prog);
> > +                     return -EBADF;
> >       }
>
> [Severity: Medium]
> Will this change break backward compatibility for existing BPF programs?
>
> Because bpf_async_update_prog_callback() is shared, this changes the
> user-visible return value from -ENOENT to -EBADF when bpf_prog_inc_not_ze=
ro()
> fails (e.g., when a program's refcount reaches zero).
>
> This affects existing UAPI helpers like bpf_timer_set_callback() and
> bpf_wq_set_callback(). Programs relying on the specific -ENOENT error
> code for fallback logic might break.

Will fix it in v4.

>
> > +__bpf_kfunc int bpf_call_rcu_tasks_trace(struct bpf_rcu_head *rh, void=
 *map__const_map,
> > +                                      bpf_rcu_callback_t callback, str=
uct bpf_prog_aux *aux)
> > +{
> > +     return __bpf_call_rcu(rh, map__const_map, callback, aux, true);
> > +}
>
> [Severity: High]
> Could this lead to a deadlock if called from NMI context?
>
> The bpf_call_rcu_tasks_trace() kfunc uses call_rcu_tasks_trace(), which m=
aps
> to call_srcu(). call_srcu() internally acquires sdp->lock, which is a
> raw_spinlock_t.
>
> If a BPF program running in NMI context (such as BPF_PROG_TYPE_PERF_EVENT=
)
> calls this kfunc, and the NMI interrupted a code path that was already
> holding the same sdp->lock, the NMI handler will spin forever. Since the
> kfunc is exposed without NMI-context restrictions, could a userspace
> process able to attach perf events trigger this deadlock?

The rcu side changes will land together with this and make it safe to
call call_(s)rcu()
