Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E337C0FE
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777269; cv=none; b=dyFpgeIfivnJShfshXKzRtqE0y6howEwygnWrvKxfBRZt5bsHOV2tcmoDVil3jiJ1tKj7/FVRN2yet3L+ay1JXTHwgf6s2l55sQIuK/FJgzUpPZR3gxOew/6t15nmhEF0HVKA45hJMFOuj+xQsVA1hByVAWLdpgmhFOl2U98hzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777269; c=relaxed/simple;
	bh=BCnhMXpiNt6GeK/JNZegIFyy6D8zcdHM6e+0Bxca6Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oztecB+SS9caTQIX7g2DjljvlPTurUAAep88FKz3LEZkbd5PT3owsTOmlzYBd/g00RktnoiJeY1jf2tET3qsLuxCWB44gV7yBWy/O47+NcRU14dblQ4a/qeoibw+/AljR1mQqT9uXli1qfig6BvZLLgoO1H/pqXQmWnphN83ZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsFSWvi0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlNso0af; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsFSWvi0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlNso0af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781777267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H2D+VZ/Tj0mUVDsv+aTtPFKUCIWgmNxSZBVstBUBcWw=;
	b=SsFSWvi0o8XBWoVx7UXnNWY8oJcpSauRIKAhQBrDfKuwM5SM9l2e6lH0NIai50IdmtN6aX
	8Q5VjfhU1hhNy3XJ3F2ri8CECmxoU+2q3S8kw4z7EipblWt+eQej2Udf9GYpRYX/nez5L/
	x/yygCigoWDFCvPYWTC3c8UbVbI0uc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-yE2Omtj_NYKkCjlxx89uUQ-1; Thu, 18 Jun 2026 06:07:45 -0400
X-MC-Unique: yE2Omtj_NYKkCjlxx89uUQ-1
X-Mimecast-MFC-AGG-ID: yE2Omtj_NYKkCjlxx89uUQ_1781777265
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-46010392f89so709440f8f.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781777264; x=1782382064; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2D+VZ/Tj0mUVDsv+aTtPFKUCIWgmNxSZBVstBUBcWw=;
        b=BlNso0afPaiSvxBB6f5/68vwG3CqZVg+02CbcYz34zMqrVu+OkpZGJyf+Qzd3NEcWe
         rRqNJjH2VUZIESv32fhmWNFWXXntp7DNxDR+bh2n1cxQILuVLENGNONebB1PQLLJEBTk
         dlv1Gfiqn/tW93IwxdbUhIM6IJOaU/X4C2KcwqZ5+zBXBaKOWgF84NhHKs3iSNsLpAiF
         /l8q5X9lm4Z1QICHKgfFvbv105u7XgSOSTmkVc71DvJjAA2IgOheplZev5YXwcHW57yP
         iTDDcfjNBy9v44ODQqaHkaS0YPl/nTfhOxqIT6Ptxfcg609IqAYj5k6oNxmqd1FQV2Xk
         dVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777264; x=1782382064;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2D+VZ/Tj0mUVDsv+aTtPFKUCIWgmNxSZBVstBUBcWw=;
        b=A1eoWarPwQZrdjBSBtio7R5Wf++OUqZIrgQyLm6f14t7uIST4SubRA8CSls1+VGgv4
         1r/ZliVUUYAwkcZlzK1IADaZQTQt1CuHU6gNgzk+byxHCoAsvEydNoWe4Z0VvUhO3k8l
         tMUrCFMvp7VJkF4o/ivocBjC/SuSwGbWJUqkJABu0fCsaoQUPssIP54pfg9sBOh91HBf
         qLlk8OdhAIPf418Cj+Zz4HabeA/OkwjCO2CwTNmV4pQdBNIQtpSFDE/m9kjlXA9UXNdP
         SrpT1dk6GLGinmbUBHXaqmHy3UXmO6oFhHZuMzrOHwtnobY5XMVApF52ZH3Qm0RmZihm
         RQSw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZmsrlbaKiExWGTCCNyE7LMttkAc2LQjw87uKC4iksb0tMCNliOpvYimG6Xh2LuNc1qnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4Sb51j+tpl3SlXZe+UQQAO4hDatWvBendQA6Ycoi7l7HMtyU
	G6wFFEwJBiQ4CGKWMSCCZEPRaxc6UHIOMsvx13qEkJ+2+4Lvl2qCzzCp7eocW6Ad51BDtiBdndj
	sOZ2FXdLjZIxO214Uk9JLjYdnt66/8isLDMOyGvKpHoL3ABNW6tFUqw==
X-Gm-Gg: AfdE7clXhdaFbr2J77qkmFiA17KqRC3cCiYnkoTaIMHtiezfrMn8Sr65dq38zjDij4c
	EEVMHC6A8hjo0J9g/IV74LGiLovepRMmAPFjd2UdojDTcOFq6fj6IecmG/MwapRrApW4zk6XrD+
	xOnm3eMqRhKAcFlP4V1iilDemKYYac2rdlU6bnRGIIDDrvWtuUsI+xwh5/eesee6qiGF/U0Rhcv
	T7oS05HRObGh+SlANIQp5/Z9P+aFSGebR1K/S3Dl1f2ZyZNByM1B6qk63ULQgdJNSOOthi8w1Ko
	MKQReZqDw7KqjpMYlKEClCuUSVaDVtC4tIWOdC7ir/ZviJ3WMr3yEHkOGEhfaSIqT88mUF5nnLo
	TTuKtgjE03NiHWrKg5GLyXUHKhRsP+QZQAY7K/A==
X-Received: by 2002:a05:6000:1a53:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4624179ba99mr9709043f8f.35.1781777264543;
        Thu, 18 Jun 2026 03:07:44 -0700 (PDT)
X-Received: by 2002:a05:6000:1a53:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-4624179ba99mr9708996f8f.35.1781777263942;
        Thu, 18 Jun 2026 03:07:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3fcfsm56057272f8f.26.2026.06.18.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:07:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 97AAE807861; Thu, 18 Jun 2026 12:07:42 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: ameryhung@gmail.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, eddyz87@gmail.com,
 edumazet@google.com, emil@etsalapatis.com, eyal.birger@gmail.com,
 hawk@kernel.org, horms@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
 leon.hwang@linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, rongtao@cestc.cn,
 sdf@fomichev.me, shuah@kernel.org, song@kernel.org, yatsenko@meta.com,
 yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3 0/3] bpf: bidirectional VLAN support for
 bpf_fib_lookup()
In-Reply-To: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
References: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 18 Jun 2026 12:07:42 +0200
Message-ID: <87jyrwf9g1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> This series adds VLAN awareness to bpf_fib_lookup() in both directions.
> BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
> plus the VLAN tag (XDP programs need this because VLAN devices have no XDP
> xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged frame
> had arrived on the matching VLAN subinterface, for iif policy routing and
> VRF table selection.
>
> The l3mdev/VRF flow-init fix that was patch 1 in v1 and v2 has been split
> out and sent to bpf on its own, since it is an independent Fixes:-tagged
> fix that routes to stable on its own schedule. This series is otherwise
> independent of it: on the default CONFIG_INIT_STACK_ALL_ZERO the VRF
> selftests pass with or without the fix. Only the one full-lookup VRF arm
> ("IPv4 VLAN input, tag selects VRF table") depends on it, and only on
> INIT_STACK_ALL_PATTERN or NONE builds, where the uninitialized
> flowi_l3mdev otherwise misses the l3mdev rule and the lookup falls
> through to the main table. Applying the l3mdev fix first closes that
> window.
>
> Changes v2 -> v3 (all from Toke's review unless noted):
>
> - Split the l3mdev/VRF flow-init fix out to a standalone bpf submission
>   (it was patch 1 in v2).
>
> - Patch 2 (VLAN_INPUT): bpf_fib_vlan_input_dev() returns a
>   struct net_device * with ERR_PTR() for the -EINVAL case and NULL for
>   NOT_FWDED, instead of an int return and a **dev out-parameter.
>
> - Trim the BPF_FIB_LOOKUP_VLAN and BPF_FIB_LOOKUP_VLAN_INPUT UAPI doc
>   blocks, and drop the in-function comments that restated the commit
>   message or the flag doc.
>
> - Patch 1 (VLAN egress): on the skb path without tot_len, the deferred mtu
>   check now runs against the resolved egress (VLAN) device, not the parent
>   params->ifindex was swapped to, so a VLAN device with a smaller mtu than
>   its parent is no longer checked against, or reported as, the parent's
>   larger mtu. Found by the bpf ci bot; this was an open question in v2.
>
> - Patch 3 (selftests): re-run every case through bpf_xdp_fib_lookup() as
>   well, since the feature targets XDP; and flip the no-tot_len mtu arm to
>   expect the VLAN device's mtu after the fix above.
>
> Open questions (defaults chosen, noted here in case a maintainer
> prefers otherwise):
>
> 1. An unmatched, down, or foreign-netns tag returns
>    BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
>    fib_get_table() finds no table, rather than a new return code.
>
> 2. BPF_FIB_LOOKUP_OUTPUT | BPF_FIB_LOOKUP_VLAN_INPUT is rejected with
>    -EINVAL; restricting now keeps relaxing later backward-compatible.
>
> 3. The name BPF_FIB_LOOKUP_VLAN_INPUT reads oddly next to
>    BPF_FIB_LOOKUP_OUTPUT. A pair like _VLAN_EGRESS/_VLAN_INGRESS is an
>    option while nothing is merged.

These three are fine as-is, I think.

> 4. The egress flag leaves a VLAN it cannot reduce to a physical parent
>    plus one tag (QinQ, or a parent in another namespace) as SUCCESS with
>    the VLAN device's ifindex and the vlan fields zero, like a plain
>    lookup. The input side instead fails closed (NOT_FWDED) on the
>    cross-namespace case. An XDP caller cannot xmit on a VLAN device, and
>    a zero h_vlan_proto does not distinguish this result from a physical
>    egress, so returning NOT_FWDED would be safer for XDP. But the two
>    cases differ: a foreign-netns parent is clearly fail-worthy, while a
>    QinQ egress is still a forwardable route (tc xmits on the inner VLAN
>    device), so failing it closed would reject a usable route. Should
>    egress signal NOT_FWDED, for both or only foreign-netns? I left it
>    best-effort, but will change it if you prefer.

This one is a bit more ambiguous. Specifically, the inability for an XDP
program to distinguish between a route that actually targets a physical
device, and one that targets a VLAN device that couldn't be resolved for
whatever reason.

Since this is a new feature that's opt-in, I think I would lean towards
failing lookups with a new error code (BPF_FIB_LKUP_RET_VLAN_FAILURE,
say) if the lookup finds a VLAN device but can't actually resolve the
parent. That way the XDP program can repeat the lookup without the
BPF_FIB_LOOKUP_VLAN flag if it really wants the ifindex of that VLAN
device, but that will be explicit and not hidden.

-Toke

