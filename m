Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092B3546D3
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835492; cv=none; b=rDUPKmLfv/54ECqbcCD5fV9Y0nF7tr/lA6jcSBd7wWwCymn7yZ3+X/svmSEF8QQ6IxUO/q9CeEalUH8OjhUFSqEC7B0x/e6Xb/OUhH8/kBGqvxDeLikqa7XpQglqCXHVNpEhOii0ofDAUqxDf5gt7are2QT6wnDjL/2cRivSc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835492; c=relaxed/simple;
	bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gozzPc2VauFDcICcfhi6BPnpB56JZ9ZeINsTasVsJgmATfr509h51dWSyKtp5mHGQdikqf0qgnapdWKX0ZKDciMhCwp3AFbjc1PKNvBuPY7C5u8huA14gWF+R2YIerVwY1E+nP4Fkc7v6DWkaTyOaG5b+bjzY3o1BxgQ78VXIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2FKRQZe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cN0oTRXh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2FKRQZe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cN0oTRXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782835489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
	b=Y2FKRQZe+gVFDrgPe3xXkkVa6jsVTNvaXWrZcVhESxb9Ax6qBS1+/4d7iyQGH5hkk4OGyT
	bG6o/jlrdFRkToVkpgFJ0Aa1mM+BiDY0zj1Imxh4YqfHw9Ju8R17HYQdXQ+N8R+NNEYNWn
	mgMwmY++qFcCJCKkOZ0JlncNQ3rMoNk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-XMUOtATJNCajI4Hsy0M8YA-1; Tue, 30 Jun 2026 12:04:46 -0400
X-MC-Unique: XMUOtATJNCajI4Hsy0M8YA-1
X-Mimecast-MFC-AGG-ID: XMUOtATJNCajI4Hsy0M8YA_1782835485
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475de65009dso683225f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782835485; x=1783440285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
        b=cN0oTRXht8efcyJTON9/Rhgq3t5BYAmy9k8uEs3eUe/Oqv8ROTVgJNCw630q3NCEqE
         LOGfKF/0K1KGj/KhbDVb6OnXAvuvDm4mosadAlXpFGVHChtIfX+kpgeMZw1NuvxXKkJ0
         H/rnQeh5pX2EjpwK1C92id90VTiwP8VjqQuQz/XRYrUL7wsuKiEcr2ffkjZhqGjJlmcY
         IqfL9EA2tUmi8nYqZyQA3FEwqmEVq79PcmHDHrH5NfcIWdLz+/dqUWjPgT2/PRRQ2WWq
         g3bVfBmNTPIOE7XLRGQpzrBiPO6WQOjy7IHJx1zu0dB575x3zdlcTV/ISujAyB4iaU83
         iuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835485; x=1783440285;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gnxLHcVgClfVWz5Z9psgzTnjkbBo03gIXTKKfAZdZU8=;
        b=ppyneKZZw8tLJlSNZsxZFL4WBcIQwZ2pKXpTKkn9f7OMgyqVB6OmhzVIoEW1t5ZIs8
         Q4nj+mlRvR0gCK/indKhnnzyVRtjoxBJRSehwirv1zHO16nWlcyCWDJ8znFXcbu4DOBM
         qN+i3+iDR/vlI1sMZ6rOTHAa3qufMRqL2L8b73Z/tPFjLLAzeLQo5nAb4YRoCMnWu4Jn
         hyBzRa45BFzRmA1K4a/NOMHQXeA+JYE3MWIugoCVrtxEQE7n7ofWwypQe0WEJ9rTEU+r
         aLZzBvNCmyiKh5BQ1x9cLGJEPeXCfWI6omKVd+aW5TplmkifW9aabQhvxSAqXtKspFiR
         8Qhw==
X-Forwarded-Encrypted: i=1; AHgh+Rp/DIPn9bcbizhxWE3aKMCuJtBvU2kKf+5zaeXm8ZJ3c/wT+dYZXX2yzSCYr01McrIdGGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoJsnbt0Izt8nXmf1TiKZVywwtIMRQJg6VH3vNlLGJp6Nhfnf
	mfofGcKq70+wwHGTkQxG8q6I2c/UkXh7bihxf1CUHbQERwoqm6SHsWR762aTciSwgVyvnwEGuxm
	DTnloQP2tgyd+uu0R6G7AqdAPNnzBrO83pYt/jE3tz7HSrWKSxUjTew==
X-Gm-Gg: AfdE7cnAj+LoXWh4fZWs2ah3o7iAZJcI+87UjfsShtnTkPclVDQGwsaG8JWL04eZ2wR
	JryZohlQDg9dRWyZqRhuEAJud4EuKH17z/ypyy4cxg7SpCkmI9bIGp09zsqn6L+/WUDB2JoQJvU
	l9hC4jAzkzhc5ReFY7fIit7Xmw2pltETgE/csdphtkv1zVIMf6rStww8MJoq13csFocGWqCNN+r
	pip3ZRuftCMjMyK8cn9sJJsuZ/wJcSbGn7dQ3ZK95POb45ViD45eiPzTotNzlHkciG9CjpEP73y
	35151grgoma20pufJYkuLYbJUEzCCsNHWioBd64e7XOI0Md1Vhp6euXRswC0WPeaXV8xwahLDC8
	yjea38R0xZSZtsOx+AMhNJVBcWXZoIFYQCKwHxw==
X-Received: by 2002:a5d:6e47:0:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-475524a8385mr3587010f8f.30.1782835485190;
        Tue, 30 Jun 2026 09:04:45 -0700 (PDT)
X-Received: by 2002:a5d:6e47:0:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-475524a8385mr3586955f8f.30.1782835484588;
        Tue, 30 Jun 2026 09:04:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636ce7esm9527715f8f.23.2026.06.30.09.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:04:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 23A5E80A689; Tue, 30 Jun 2026 18:04:43 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 30 Jun 2026 18:04:43 +0200
Message-ID: <874iik2ew4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Ahern <dsahern@kernel.org> writes:

> On 6/30/26 4:00 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> It does not make sense to require a flag to get lookup output. vlan
>>> proto of 0 is not valid, so it is a clear indication that the vlan
>>> output parameters were not set during the lookup.
>>=20
>> Okay, so we could just unconditionally set the VLAN fields, but if we
>> start rewriting the ifindex that would be a change of the existing
>> behaviour that could break existing applications, no?
>
> Consistently dealing with upper devices is one of the reasons I never
> sent patches for vlan support.
>
> xdp support is at the driver layer for real (physical) devices. The fib
> lookup is going to return the vlan device index - a virtual device.
> Support for xdp should not be propagated to virtual devices; it goes
> against the intent of xdp. Any trip down this path will have to decide
> how to handle vlan-in-vlan use cases. Where is the line drawn for fast
> networking?

Right, which is why we need building blocks that makes it possible for
XDP programs to do the right thing in the BPF code :)

A helper that resolves the parent could be used for stacked VLANs as
well (just calling the helper multiple times).

>> Specifically, if an XDP application has a table of the interfaces it
>> forwards between, today they'd get a VLAN interface ifindex, which would
>> not be in that table, and the application would return XDP_PASS. Whereas
>> if we change the ifindex and populate the VLAN tag, suddenly the
>> interface would be in the table, but because the application doesn't
>> read the returned VLAN tag, it will end up sending packets out without
>> tagging them, leading to broken forwarding.
>
> I have not followed developments over the past few years. Does XDP have
> support for vlan acceleration in the Tx path now? You really want that
> to deal with vlans and not replicating s/w processing in ebpf.

It does not, no. There's TX metadata for AF_XDP, but VLAN support is not
in there (see include/uapi/linux/if_xdp.h).

Doesn't mean software VLAN handling can't be useful, though; there are
use cases other than the very high end where XDP can speed things up
even if it has to write a VLAN tag or two...

>> So if we don't want the flag, we'd need some other mechanism to resolve
>> the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, say?
>> That could also be made generic for other stacked interface types, I
>> suppose.
>>=20
>> WDYT?
>
> dealing with stacked devices is hard :-)
>
> What is the return is a bond device or a vlan on a bond device?

Well, bond devices have XDP support, so you can just redirect to those :)

But yeah, each type of stacked device would need to pass different
information through to the XDP program, and the program would need to
support those. Building a single XDP program that supports all of them
will require quite a bit of code, and would probably not perform super
well. But most deployments have distinct subsets of features they need,
so this does not have to be a blocker, IMO?

-Toke

