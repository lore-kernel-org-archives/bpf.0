Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC31472780
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223071; cv=none; b=sUOIH4iDa5EcZDPAHJ8Iajq+Ss+J48C+d0iJCcaEcD5wtA0cK2jhvNVX8bjnuxZEVaHDaHeKiKZNifC5tOb5amFfHdSYa9uhMZqtxPVUx6YGsktAZnfx5DOaNb0928fsrty+dZVNLIuOVXnRyyWI81ew9fn1y0Gzqmbma7r8d4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223071; c=relaxed/simple;
	bh=QzSIfGAK0wUbz+fKdOQHReIUWyKiTXCk/6jtRbFYibQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jUItfBrNIB4cxWjJEb+dVaIMZmHiD840uvbll8KJvis98zzCdHqPIWGFuv4eM8qylfexSuRkFJuoDDsrfgxvFLM+kAeAdn/Z7YT5f1JS/fwVitTWAfANF31L9/PHbMyy8tyFP59BSMBpXHUBdSyUOkVBCnDEWHTL27o6aq/roR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KvnLe+hx; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KvnLe+hx"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65f94011dfaso4611162a12.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772223068; x=1772827868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrCe/NXbUx7RQHF2qacftGJ8uFVJRAsM8E3zSi9beXE=;
        b=KvnLe+hxT0B6rzDrtdJeSeJ7UBfaRokLri6aMfL4EqRWU0SPBhvcP/lyUlJbYfk7Q/
         oMWl9gRF50z+ATNEVobA5+r043W2X8SYfKZL7Jj/n158lcXUCEw1Z1+PaEpaBzh5/gwc
         V6gT7LlDUks6+EWHFKRuhbOA86e8KT1dtSupFbcE1ugXMEMWd0fyYzb3+epdeCgGSGqv
         DFQa0H7P1I6Xmu1FMC85r485VbxwbN0BHaYIUq+7RHyNbXvKUm55N7SYj2F5SCSnYcp2
         7rb3dUbTGh/em0brPf732bTVzwrIl6jfnInZiG9G6kV9AjFV+BMWoa0AIpr8DuSDRT7M
         pfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223068; x=1772827868;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WrCe/NXbUx7RQHF2qacftGJ8uFVJRAsM8E3zSi9beXE=;
        b=ZmdV9K7JNgM16Tk8thO9KjTxrFRxsVMl9ElHWartetBCnTgploxHXSGwZkAMZksaim
         w/rtb9ahXnxJAp3aqB8rgfLgVMi0yt1D5Eqtj1bCNySliS2I1ofUO+8hX5RgLQfHvJaN
         vfMhLx57CjQoTrenGMEUj8AXiRegIDmuSYBv2TiuAdQd311mZT2JUS+vu77R/N+3mAa5
         0wQ86dux3A8YnQ0WAe0dg/iQbaTs2L3Ehdv8tu8o8NmjM3JN91vRFSZCHW7FtiRPv7hu
         Y2FDQ4xH5eyOpRn4mSUhwp0BzglsyNc3yQs+mgbPGCjatbiu9AKoyNt3+2QkSfcJ7CdU
         jVvA==
X-Gm-Message-State: AOJu0YwMfFuRgCOtReDqUyX/hDwzM11d8v5BR4Y0zkDcdhENhpV9fwz5
	bhyTun0i1ple3hLiO2ImosgtewDRu2pXkpDUevtMvCybQNCadQEDwlZ4FgP7HfS1Qn0=
X-Gm-Gg: ATEYQzwKIKg2oYz1cqp7g/AKeg6tLJ6Z3SAuyUeDbeBjjWIRDKv/8yzaFBvIaT0X3Cs
	LPs4Quxu9gSOmKXBGK86XIusRe/omfW1GjOr0UeY/XTLyaGoS+qD7SAAR4HpBMK0thpx+cb4K+x
	+tOKkoYWhc/rqQJyGfV3rvnVeJorLLuc5F0uNkuTsEaIwiFwWAhI8tQbUv/6QzeB6yolbLCukPt
	teBL3Zk70GIEFHI5n4PvPlVu6EUVeNdvXOa+SZoX6pJxiys349pZfnwD3OzHZnJDIJyNPjNnVdX
	CjsN+XUqI+Ran3Y5xKqrRWglnOpkmKF0WR/WDkPcKdme8rwG6VtCLw5MwWYiL0xwTmb88IQ/cLy
	gL+Tkb3MMaVPNPN2yxNVtsQ8/HbftRLWQQSRhTTT4eWc0y13EVasPGLimMQ8p4is9D9hCQEvWLY
	vNKpMSogOd54Mp8P4SYA0Av8QDbvk=
X-Received: by 2002:a05:6402:3582:b0:65b:e788:5de0 with SMTP id 4fb4d7f45d1cf-65fdd4cc8c7mr2665034a12.7.1772223067682;
        Fri, 27 Feb 2026 12:11:07 -0800 (PST)
Received: from cloudflare.com ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd467d1sm1639567a12.10.2026.02.27.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:11:06 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: bpf <bpf@vger.kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Network Development <netdev@vger.kernel.org>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 0/5] skb extension for BPF local storage
In-Reply-To: <CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 26 Feb 2026 13:56:12 -0800")
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
	<CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJd1AJgXTQ@mail.gmail.com>
Date: Fri, 27 Feb 2026 21:11:05 +0100
Message-ID: <87wlzydk12.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 01:56 PM -08, Alexei Starovoitov wrote:
> On Thu, Feb 26, 2026 at 1:16=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Previously we have attempted to allow BPF users to attach tens of bytes =
of
>> arbitrary data to packets by making XDP/skb metadata area persist across
>> netstack layers [1].
>>
>> This approach turned out to be unsuccessful. It would require us to
>> restrict the layout of skb headroom and patch call sites which modify the
>> headroom by pushing/pulling the skb->data.
>>
>> As per Jakub's feedback [2] we're turning our attention to skb extensions
>> as the new vehicle for passing BPF metadata. skb extensions avoid these
>> problems by being a separate, opt-in side allocation that doesn't interf=
ere
>> with skb headroom layout.
>>
>> With the switch to skb extensions, we are no longer restricted by the
>> features of XDP metadata, and hence we propose to extend the concept of =
BPF
>> local storage to socket buffers - skb local storage.
>>
>> BPF local storage is an established pattern of attaching arbitrary data
>> from BPF context to various common kernel entities (sk, task, cgroup,
>> inode).
>
> And that list of local storages ends with a solid period.
> We're not going to add new local storages.
> Not for skb and not for anything else.
> We rejected it for cred, bdev and other things.

Thanks for the concrete feedback. I appreciate it.
This saves us from going down a dead-end road.

> The path forward for such "local storage" like use cases is
> to optimize hash, trie, rhashtable, whatever map, so
> it's super fast for key =3D=3D sizeof(void *) and use that
> when you need it.
> The life cycle of skb already has a tracepoint in the free path.
> So do map_update(key=3Dskb, ...) when you need to create such "skb local =
storage"
> and free it from trace_consume/kfree_skb.
> Potentially we can add a tracepoint in alloc_skb,
> so bpf prog can alloc "skb local storage" there,
> and to clone skb, so you can track the storage through clones
> if you need to.

That is similar to the workaround we have in place (mentioned at LPC
[1]).  And it was always our "plan C" to string it together with BPF
maps. But we wanted to go this way only as a last resort because:

1) consume_skb is a very frequent event spread across all CPUs

As a happy path it's getting hit 1M+ times/second.  Hit by every kind of
skb (UNIX, Netlink), not necessarily just those we care about. Even if
we can keep runtime overhead low, that's wasted effort and potential
data bouncing issues across CPUs.

$ sudo perf stat -a -e skb:consume_skb -e skb:kfree_skb -- sleep 1

 Performance counter stats for 'system wide':

         1,132,924      skb:consume_skb
           410,186      skb:kfree_skb

       1.034636263 seconds time elapsed

$

2) Sizing the "skb storage" maps is tricky

We need to size for the worst case, but the worst case is
workload-dependent and can change at runtime. IOW, predicting in flight
skb count is hard to get right. We've got skbs queued in TCP retransmit,
qdisc backlog, and need to factor in RTT and queue depth to estimate the
skb life-time.

We'd probably have to arrive at the "right size" empirically.


So to exhaust all alternatives I gotta ask - would you and Jakub be open
to the idea of a plain byte buffer embedded in skb_ext and exposed as a
bpf_dynptr?

#define BPF_SKB_META_DATA_SIZE  64 /* make it build-time configurable */
struct bpf_skb_meta_ext {
    char data[BPF_SKB_META_DATA_SIZE] __aligned(8);
};

Perhaps by reusing the existing bpf_dynptr_from_skb_meta to give access
to a "secondary metadata" storage backed by skb_ext.

bpf_dynptr_from_skb_meta(ctx, BPF_DYNPTR_SKB_EXT_F, &meta);

To be fair, the whole BPF local storage approach was never suggested by
Jakub, only skb extensions. That missed idea is on me.

IOW, what I'm wondering is if you're against a side storage in skb_ext
in general or just plugging BPF local storage there in particular?

Thanks,
-jkbs

[1] slides 57, 62 in https://lpc.events/event/19/contributions/2269/
