Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599895;
	b=JMj5W/5m6P5zhyBgPpxmVLpSHJo60ygKi977qUOugYYSXJcjmA89/EWv3g0cZsKqKzk7
	 Vs8jXEQSSarAOihDcKE5adcGwYR9cy+MU0801N5xg4+GgFGLzBAuJbgijuRTemCCvfFhe
	 Plfx88qpF484NlB+2ZtYqPVKr31ff0cBub1fVWWm2oQxJqSSpynjSDO53XFF2wNN53r/O
	 nadP7j7vHcJNCDVUt51Dpgk3AEI4lv5zzyxe+HMDWNoibbfW1pnZzmWi2xALkJfRWs5Sn
	 t1B+yth4AZygGxS4IfhoPTrcM8DLnj+aSYqhb0uiF6INatt7E+FzN5hOnzgWqDr1F0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=SA/I1XcNdOqWCHpHPoabvJbPaHjQpV93aW+4lUY75XM=;
	b=Ea8/7R9IlXHdG8aLx7Z42sjOiRFhvqVS9yuYo34x/qsv7d3k82ABW6yqER8DDgcmc1hc
	 ahFnRQI8CJI9DKQ2xt0eAxwY+5Nm8gHkvX4UDw/upKounaHkvmKjmjL4Peax0PeyHA0uu
	 kLgQx9CLefx15hIm+9iOQAi40JgRTuepmtuxgRchyBWpXdG2vPzXCdHTZQvHocO49wqS8
	 DhIfoLdbIQr2qoAesPYcY6+IOXm/HXftfbgSUWg8zIS1SdG6M52lz+IqzwOZSR6g8nAsW
	 olmVlB28iqF4RVKGDR9t5ZH1MsgfbKEZhqKnKrRRdgQB99hEvtIu0ZrxS9qzDdbjzFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=MAPT6p8f;
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDE5606A8BB
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 19:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADDE5606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=MAPT6p8f
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3564so321589a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794599894; x=1795204694; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SA/I1XcNdOqWCHpHPoabvJbPaHjQpV93aW+4lUY75XM=;
        b=MAPT6p8fzX9d12RkIjrOPm2Vue7u555UmawaN5NwZ3kF8eomxf1unrChz4ijRJddzc
         A6Md4fH+XjA2x1dmEsonbcoTNkR34hZ9Waa1GsLQ1GAOVnRCH/Sdpf5b2cm5q+JMAWSS
         pqOdCmIxo/F/Coty9/1uaqJON4Jn28u9Dc6ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599894; x=1795204694;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SA/I1XcNdOqWCHpHPoabvJbPaHjQpV93aW+4lUY75XM=;
        b=GT4ENiIVJ4iz59iSlszoncnUJ1y189tDSOquLMHw1lwL3jg00BjOeb8iJd3ZpHj+xm
         zey/v5m0KKiKcxRgxwXmL8bBSsTMPH1WKhwgRzNqGrpw5W0u0ZN4dNBSoMcHCvsn0nDb
         Wz+aNkRcGLQ9FP+1b7uOYUKb8JVV8lw59ksn7NFiFQH0Mu4gxolCfz7O22GSwYJYbvwi
         /bjPhCIRzvN2Lo+L8AQtor3KvRDmuGSNATYkuUsyHRJgPYmO1l8MCZr1dGZfNuGfBGCC
         gj71hmd/gtZBKIK5M9nwBkplRCRhP/K6bIbw4waEda295TY4WlUTFWfTLAxpqvqdWhpu
         anOw==
X-Forwarded-Encrypted: i=1; AL+hErFi8CFne3WU+gcwdAfXbZLD+mRShj7cqoxrjTMzv5iLnXL+v2i66fB5QJTvykOY5EOreKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z80aiakyER7J5ZgiuqJB0uL8U83tQTvjDHLZUxjojjj9TdzofC3
	a8t9niRf+moNq168ftv6W0Jq0mnBpfPm2/IUTKFEHoJpDnVK2qa3rDu0jslNcGFi2W0=
X-Gm-Gg: AYBFou2/msQnBYQ7DMjFa4J6dvZnCTKJcRcgE1I+hiIcQ6A5Kak0UlXX0InTDulEBvR
	5qnIVpvvQwnEz37FiWQM9J0l6OR3DXD7Hthc5FPfa5M27Vra0ADiEAPVM00ja5oVAqQ4yUwFckJ
	TgQcir0v/gB4Yt7DZ2r66xeiEaIQbo+3syY+g5CnK+aN7XfXsJuId4qNzurfM+rQV5/nyhsrLbH
	HGMqaBIPhdJjy4shoz+cqF+Wx8pa+W/FSCWLwn0POpUmhbvdh3OnFvHnpb1JDVM36H3FCPe7hXE
	jjbX+ZQ4dDO6Mu9T3EX8tchLV19sTXXOiXDrkjAeAw0a7EQxsqPwMV8OFU5WaDnscAHTCEJQZep
	I8O3F3xsRKfVNprdAEs9daLzzAUTW61dcgXW4vpKkfVFZ7GcYUTKD68aTjHSggQriIQR1lxAKfr
	00M7kWrdp5/2Nx0nJQ1tWZj6aS3PpDlidXo5XXW5uOYeqxxLDfHZSqkATIaOpUHlFDg70X9X7lG
	gJvsdReQPbRl4TyGYgGyweB8g4ijO1zQQLea3ETnw3lhwgBxbijFQi518fWhy+iGEVFq66kAJMl
	JKSzBA+ia+8dw6J1vy8sfa45ocLBbTYQQH1sOjr1sik8z1+JFUwdScPCSOUe8nwFsa0qW10DWHW
	0QdRcMgkCMSUxF1ccdmMmuLv+12l/tyu9Q0AvWDJdcuoA+r40wEdAnD7VYiBMK7hM8uUwY9g0Lv
	cBfokq+m0WWGLCGyYrzaTvg6283GhU+SaO6n6jA+Ij12iFZba0b/mwzwINW1Ktj3/PerLXLIhp3
	LftW5f3
X-Received: by 2002:a17:90b:394e:b0:3ab:be66:ddbf with SMTP id 98e67ed59e1d1-3b1b0b60493mr3259630a91.54.1794599894079;
        Fri, 13 Nov 2026 11:58:14 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm5853480a91.14.2026.11.13.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:58:13 -0800 (PST)
Date: Fri, 13 Nov 2026 11:58:10 -0800
From: Chris Down <chris@chrisdown.name>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: dennis@kernel.org, tj@kernel.org, cl@gentwo.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, acme@kernel.org, yonghong.song@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev, nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] local_lock: do not put btf_type_tag on the lock guard type
In-Reply-To: <20261110012235.1024461-3-vineet.gupta@linux.dev>
References: <20261110012235.1024461-1-vineet.gupta@linux.dev> <20261110012235.1024461-3-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113115810.cd33f9ed58c02dd9@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Vineet,

Vineet Gupta <vineet.gupta@linux.dev> writes:
>	typedef local_lock_t __seg_gs
>	__attribute__((btf_type_tag("percpu"))) lock_local_lock_t;
>
>	typedef struct { local_lock_t __seg_gs
>	__attribute__((btf_type_tag("percpu"))) *lock; } class_local_lock_t;
>
>Both put the tag on local_lock_t, an aggregate: the first on a typedef of
>it, the second on the pointee of the guard's member.

The typedef is the aggregate case, and it's the only one of the two that
GCC warns about. But the second one is just the "T __percpu *p" spelling
that 1/2 keeps the tag for. _T->lock really is a pointer to per-cpu memory,
since local_lock() passes it to this_cpu_ptr(). So the tag is correct
there. This patch drops it from the guard's lock member and the
constructor's argument as well, not only from the typedef. I think it
should keep the tag on those two and only drop it from the typedef.

>Every variant of an
>aggregate shares one DIE, so there is nowhere to record it, exactly as for
>DECLARE_PER_CPU() of a struct. clang writes the annotation into DWARF
>without complaint, but pahole does not translate it from that position,
>so with today's toolchains it reaches BTF from neither compiler.

That's true of the typedef, but not of the member. With clang 23 and
pahole 1.32 the lock member comes out as PTR -> TYPE_TAG 'percpu' ->
local_lock_t, the same as any other per-cpu pointer.

For the typedef, clang 23 puts the annotation on the typedef's own DIE, as
you say, so there is somewhere to record it. It's only pahole that doesn't
pick it up yet. You also mentioned GCC patches for type tags on typedefs
in the pahole thread [0]. Once those land, does this warning go away?

>Unlike the per-cpu declarations this changes no BTF at all. A tag in that
>position was never recorded, so there is nothing to remove, and the one
>percpu TYPE_TAG that does reach a local_lock type comes from those casts,
>which keep it. An x86 defconfig built with clang is identical with and
>without this patch: 152551 BTF types and a 6828300 byte .BTF either way,
>and .text is unchanged. The patch removes a GCC diagnostic and no more.

The defconfig BTF only stays the same because nothing in a defconfig uses
these guards. lib/test_context-analysis.c is the only user in the tree.
With CONFIG_CONTEXT_ANALYSIS_TEST=y, class_local_lock_t,
class_local_lock_irq_t, class_local_lock_irqsave_t and
class_local_lock_nested_bh_t all lose the percpu tag on lock with this
patch applied.

Nothing in BPF looks at those types today, so this doesn't break anything.
But it does remove correct annotations to get rid of a warning that is
only ever caused by the typedef itself. When the guards were added, the
type was only ever used as _type *. The typedef came later with
3931d4b98039 ("cleanup: Basic compatibility with context analysis"). If
GCC isn't going to accept the tag on a typedef, could this be limited to
that typedef in cleanup.h instead, so the guard's pointer keeps its tag?
As far as I can see, lock_##_name##_t is only ever used through a
pointer, in DECLARE_LOCK_GUARD_1_ATTRS().

[0] https://lore.kernel.org/r/252c53f3-3f06-40f4-9cd3-795eb298687c@linux.dev

Thanks!

Chris
