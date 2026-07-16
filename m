Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665DD41B8E4
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205342; cv=none; b=DUfMhGe2SHzKVDFFLr5dcr90av6hzlPsG+CoCkTxpITVb8ojTMiz08HdeaEG6JPSmdqXVBmVjIjeAupdNg/MBEH+YBkdT1O07PhEbP9g0/2R/vjw4nsY0cG2Xp+7CguMy3Xp2edXyLsHIbWs3CMij2VC23w8l7LQo6Zx81WKf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205342; c=relaxed/simple;
	bh=zIK9msFJRP0bVSvAudH3HVfa7ABzZg1JzpTWlPIy4sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bPkJoRLbs/9F2Cr8ce63tfO62GOd79L050KRc6S4/s38VeWsiKzHTuYwcF0bBreUK17LP0+SWqMTiBuDb6nWwQbT+CTaYfKorNo+l0MT60Vhz+jpQVWN05UqPZaY4quO2BMfytQHcqqsP6tjfzsf59bLC84a/XsnURCnJ3FxpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AtJ0J5Gm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AtJ0J5Gm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49546e16075so366415e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784205338; x=1784810138; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mn32CUX/cJgGWYz3TdLuqf1PZ7vkIhqqxMT9vIruGHs=;
        b=AtJ0J5GmJfuNy1cEZikbAcJyxxd7TpLfwp3FDaHvWRMnbWpG911azD2FJJ/+a0rPSh
         OXIJm9gbJaQg29w0UIvlqkjpo8ESLrko3morkLRGlhrYdJj+EhgguK+FWWhK1vty97OS
         Y3f+tIjrR4shiUHqWVH0R6d6JPbVftSYclR+R3rRpBPhPJuWXjZ9ZpGtPh7EhipeaR9+
         2NzQs1FyIQKouBBDGUo4L1/hKIOVOPF1LWxMeS8LAKDwNVCSBiMGjmagoDtUclTWMxF0
         KikncRnj6UTSJI6EcmLmmAyLTlpCJCwLP8YhvudGAQolN9ebaazrX0mh52o+NcW9RBLA
         kBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205338; x=1784810138;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mn32CUX/cJgGWYz3TdLuqf1PZ7vkIhqqxMT9vIruGHs=;
        b=fPD14FeiSXrojp0KoX/YyrjzYZx9Wc35Z5hQtXaXjymR7oq5Q2qgRYjuyH7uTD1bGF
         T6WI85XuytyP+46/LEc8cjBirDBbwscuI3VYWhf5Zy+zm1m1aGyi80La8CaAEIin9VXz
         MtjsspV7TvXs2eDGCz0xr1JN1oBkvhI/sOCjbz4dZT5tZfzuWWZKGpkJQrKkengOAH1q
         r7eN8lE/lkZHTYv7OGenyCGOOPL8ObkEirwJr27ciWjfLaV/h1+WY7wxmkwj9xiMrWeV
         9HHg2+kRksjRWhZSDlbuaU4CFYGVs8ClHR0vnv0nEbqQ50xlYj20PrQkonTZUttjXY3g
         zi1A==
X-Forwarded-Encrypted: i=1; AHgh+RpsQioErrOK2Bw5epQUmFRsu/lipuc5lk9UfFPPV8J7+A4sV8CmQAJjG544lxnTWHg+r0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxduu/0Qhc2fRUz4a0mPHrDhvHMekrTJSKlowJn7f71ZddkML7A
	OHR9+ZXMNVk8AEkHCHP4GenXHn3Mz+TYBpSrP6QYTQRpx4G94w2b13Q5SLPBFfu6BjQ=
X-Gm-Gg: AfdE7cmO6H6zNpaGFTP7qJMzoelwmL3dhi9KyhVAN7naB9T3B5OYYZEUfVYzgcQMvya
	h5QsRfzw1g4Num4PlVzhZB2If95Bo3B9ixKUsHVnaV7gPZMfJABA+wJQms6U3DJEc21iPINJXNr
	WxD1f7Xc7SoKmv1jeh4DTNNNlT9cptJkMAeoACe8a/fkzjRtkmBledfxVvtEyLR9e4yahf8zFw1
	v8e83xZbIH4qTAesHhtTaCgHKe8wG3kLm2iHoTIKy/tjOODuTShF2BPq5h9pVyInmy1T8fC9oF9
	JE9OEguGocSdMQ0i82btQVPWzMCwhd4OPm4ClVxOTK9BEo5kg2ph5E18Lqn+7kubcoEZWzHc2se
	ixYc0fVQ4oA27t/hvgQD9rXwPe67vWKIl8kW9axsCENgGRqQ6ONSrrXnO3NW2uejHBmgWrxK/2V
	BlIuPmVA==
X-Received: by 2002:a05:600c:4fc4:b0:493:9cb3:53fc with SMTP id 5b1f17b1804b1-495389d2bb0mr120251385e9.11.1784205337476;
        Thu, 16 Jul 2026 05:35:37 -0700 (PDT)
Received: from cloudflare.com ([104.28.189.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a935sm24118297f8f.11.2026.07.16.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:35:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next 1/6] bpf: Introduce per-packet metadata
 storage for BPF programs
In-Reply-To: <aljJ1u-_1CBBF8Ha@devvm7509.cco0.facebook.com> (Stanislav
	Fomichev's message of "Thu, 16 Jul 2026 05:10:12 -0700")
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
	<20260714-bpf-meta-inside-skb-ext-v1-1-5871c07a8dd6@cloudflare.com>
	<aljJ1u-_1CBBF8Ha@devvm7509.cco0.facebook.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 16 Jul 2026 14:35:36 +0200
Message-ID: <87fr1jjenb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 16, 2026 at 05:10 AM -07, Stanislav Fomichev wrote:
> On 07/14, Jakub Sitnicki wrote:
>> BPF programs attached at different points in the network stack have no way
>> to pass data between each other on a per-packet basis, other than by
>> stashing it into a shared BPF map. xdp/skb->data_meta works for XDP-to-TC
>> handoff, but is not available to programs running at later hooks like
>> cgroup/skb, sock_ops, socket filters, tracing or LSM.
>> 
>> Add a new skb extension (struct bpf_skb_ext) that provides up to 256 bytes
>> of per-packet storage. Size is configurable at build time though the
>> CONFIG_BPF_SKB_EXT_SIZE option. The storage is embedded inside the
>> extension chunk itself.
>> 
>> Expose the storage to BPF programs via bpf_dynptr_from_skb_ext() kfunc.
>> The caller passes BPF_SKB_EXT_F_CREATE to allocate or COW (unshare) the
>> extension and get a read-write dynptr. Without the flag, it gets a
>> read-only dynptr to the existing extension, or -ENOENT if none exists.
>> 
>> Guard the feature behind a new CONFIG_BPF_SKB_EXT option.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/linux/bpf.h      |  10 ++++
>>  include/linux/filter.h   |  26 ++++++++++
>>  include/linux/skbuff.h   |   3 ++
>>  include/uapi/linux/bpf.h |   5 ++
>>  kernel/bpf/helpers.c     |   7 +++
>>  kernel/bpf/log.c         |   2 +
>>  kernel/bpf/verifier.c    |  10 +++-
>>  net/Kconfig              |  20 ++++++++
>>  net/core/filter.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>>  net/core/skbuff.c        |   3 ++
>>  10 files changed, 214 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 7719f6528445..6b918a5b61bf 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1484,6 +1484,8 @@ enum bpf_dynptr_type {
>>  	BPF_DYNPTR_TYPE_SKB_META,
>>  	/* Underlying data is a file */
>>  	BPF_DYNPTR_TYPE_FILE,
>> +	/* Underlying data is a bpf_skb_ext chunk */
>> +	BPF_DYNPTR_TYPE_SKB_EXT,
>>  };
>>  
>>  int bpf_dynptr_check_size(u64 size);
>> @@ -4209,4 +4211,12 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_BPF_SKB_EXT
>> +
>> +struct bpf_skb_ext {
>> +	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
>> +};
>
> Can we do a dynamic size from the start? Say, some sysfs knob, 0 by
> default. Once written, it's locks in the size and can't be changed.
> Then your new 'flags' field can be used to indicate whether the area
> actually has been allocated or not?

Thanks for feedback. Dynamic size would be ideal.

We're limited by skb extensions implementation here, which needs to know
the (maximum) size of each skb extension chunk at init time [1].

That said, there's been hallway discussion at Netdev, that we should
look into making skb_ext allocate memory just for activated extensions
and realloc as needed, as extensions are gaining more users.

Current implementation (allocate space for every available extension) is
wasteful, as you have extension combos which are not possible (won't be
active at the same time), like IPsec and MPTCP and CAN.

IOW, build-time config is what is doable today. Having a sysctl knob
doesn't buy us much. But we have a path to lift that constraint later
(if we don't mess up the BPF API).

[1] https://elixir.bootlin.com/linux/v7.2-rc3/source/net/core/skbuff.c#L5171
