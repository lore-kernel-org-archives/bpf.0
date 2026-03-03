Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D953976AE
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572059; cv=none; b=mUw1mpcSnLwKc+2/adSILqzU1sRj4I/97omuVRcBuWuoZD2NExyJ5aIoTZb1uTD5L4sckxrNJKvtwXiXhchMadHwkS3HRXmYTa+FHsxoFJL9g2Z0NJcEBJqxQcUOo5RHvD6xjfBR3Qdy9sGWriDNQtj9DEyzwILK2vmcKlp4DFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572059; c=relaxed/simple;
	bh=dWV0urC7GXJe3oKflvdKpjYd1q4KvJjQhjYofU/Og+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rkzpa/EAo06S/pJZ4hBrHf09N/v5Bs5GMUbiH1ubHa8OsWFMQIFzvI1vsfC91y6k8JC/L6bxr7PnN/vues1dP8pp2s3S3/OgnlyMosRY2KT/1qcr6X5v+whatm2NaOlxCBF/lKOzTc2nVFOHVYBB2ZA/WR2nowxIGAYJ9/2DRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=efHj9x3V; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="efHj9x3V"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65c01595082so9427957a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772572056; x=1773176856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXHvHlZGtSW7HsiwQ41th4kpFrzXRsO7hly8Z9fZP2A=;
        b=efHj9x3VcZOJKWOVVQFa5J0qQbvpoHRdCL1nUgCfk1JlShgH9eHYg42t56uEBJgmCQ
         aee3gWX52clC64eN1dZ9KYt5yqayz61tcIdXeTbXkAVXQd3nZdJV7+xHzB2It+XNRPyx
         HQ/GKOudGh6UWS96I8UKnplciAMVZA/0TExR5/crIPvILPupGAFg3FPkSlNcijd0jHu5
         Jmq4OtDP4uRfswfvYvGEzpiD5ue2lVbc7iqa7CrGPE/MsKEXj8se/FuDvwAdmr6nJhU8
         1lbGrTa8ncBsNzQHughqbMKbW5y1Et+nIOV14NS8JcTWupbs4H8NyyklQmtINjBABWcp
         237g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572056; x=1773176856;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXHvHlZGtSW7HsiwQ41th4kpFrzXRsO7hly8Z9fZP2A=;
        b=itGxDD++1+EKzZCi/higpZ8Gqd7N1VY54T8Txso9IbG/pMohcZRgvvekCjplMW68lG
         jIU4STG+f1D9Yk3/Nkq/5vYuG70anQd0xoB+l/8m2rf0Y0RehLj6KhYQRTNDWAp90NRJ
         r9FtSRwaqFxsoV9m7z2X8cSGRlf9kWkcwpTMaJ/inDV9zxLzZOb6y9qLc+LjST4g4ykk
         BFka4tosN5EALOxpLVjla75C21+FTjBZLE3oeHGCnOVkkqL0Ztin9GMIWhemOS9/rIlj
         cwY7a0Q7igvpKkc9RLy+MD2ql6oAFSTXINXdytZdauGQHt6o3NRs8a5f46vy1uAXoFls
         m3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6oAMNenB9v4GdrUVmFAVxul4VPk0YgE66KENNTFhiZB1tcGpbfQNCgFmFpoWxgmLvRvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qR+jRMYkGnqYADCVeQU2othRraMuw+hM1Kr+LP0mevxpjEcL
	VOFkIIyyNZhNnzwD8YbZ910fKI4XDo/6WTwd4vtdyE1wom/pnnboHa5fm0y6Ja9WaWyGFlKcS7O
	If/I25kSUjavT
X-Gm-Gg: ATEYQzyEfxPewuyh5yZuCJ5QBOGvOyqSVZTJIP5SMllL8HgEWn6Lh0Egzdz+rxtWhBR
	wW0hU379Nlg/LPetYiNccRkoBnA6k2YqlHtkujNhCIxGlCQw4hOo7ETtnD7iD1yXLWLS7gWBhtb
	AWdqz/bAr+WOSwu07k7S0G3VGEmwGJYWmo+RUjobBeldbj6266yjXwWDIj5n2SA8EJeSt2kH70y
	GRt2zxZQpSnpm69dTRS7UU0iHwyV8BqW2CBR14iqLH1bZWbGiIysA+Dv4ZIEdNm2HtfTV42yAM3
	WCGwjr0BnvvZMGOj0OCE1Pf1tDh4k5YL0LU1Opre99nCN4ZxG9IUlJs6dKZdYdalJ9M+fbZsLxs
	/Anz50+11OZ2+LFYuJpTgTPIcVcXpjiV22ChNPCdnuMktIsAGEyH+5RW/NbvTRnXauCyFycsg/x
	CvcUwP+kmqAuO6n32smGFkjZGKuBw=
X-Received: by 2002:a05:6402:13d2:b0:65c:2836:1cc4 with SMTP id 4fb4d7f45d1cf-65fddee9f43mr10808349a12.30.1772572056523;
        Tue, 03 Mar 2026 13:07:36 -0800 (PST)
Received: from cloudflare.com ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d068sm4769862a12.21.2026.03.03.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:07:36 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [LSF/MM/BPF TOPIC] BPF local storage for every packet
In-Reply-To: <aa2fada2-3f61-4f3d-9f55-36538f566333@linux.dev> (Zhu Yanjun's
	message of "Tue, 3 Mar 2026 07:06:46 -0800")
References: <87ecmffopy.fsf@cloudflare.com>
	<aa2fada2-3f61-4f3d-9f55-36538f566333@linux.dev>
Date: Tue, 03 Mar 2026 22:07:35 +0100
Message-ID: <87ikbcoc4o.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 07:06 AM -08, Zhu Yanjun wrote:
> =E5=9C=A8 2026/2/20 6:56, Jakub Sitnicki =E5=86=99=E9=81=93:
>> In the upcoming days we are going to post an RFC which proposes to
>> extend the concept of BPF local storage to socket buffers (sk_buff, skb)
>> as means to attach arbitrary metadata to packets from BPF programs [1]
>> (slides 41-55).
>> Design wise, BPF local storage is a great fit for a packet metadata
>> container, as it that avoids some of the shortcoming of the the XDP
>> metadata interface:
>> 1. Users interact with storage through BPF maps and can take advantage
>>     of existing built-in BPF map types, while still being able to
>>     implement a custom data format,
>> 2. Maps within local storage can have different properties controlled by
>>     map flags. For example, maps with BPF_F_CLONE set can survive packet
>>     cloning. Other flags could allow map contents to survive sk_buff
>>     scrubbing during encapsulation/decapsulation or pass across network
>>     namespace boundaries.
>> 3. Local storage supports multiple users out of the box - each user
>>     creates their own map, eliminating the need to coordinate data
>>     layout,
>> 4. Local storage has its own backing memory, so persisting it across
>>     network stack layers requires no changes to the network stack.
>> However, this flexibility comes at a cost. While XDP metadata requires
>> no allocations [2], an initial write to BPF local storage requires two:
>> one for bpf_local_storage_elem, and one for bpf_local_storage itself.
>> We would like to align this work with the needs of other BPF local
>> storage users (socks, cgroups, tasks, inodes), where allocation overhead
>> has been a concern as well [2].
>> Optimization ideas we would like to put up for discussion:
>> - slimming down bpf_local_storage so it can be embedded as an skb
>>    extension chunk,
>
> Interested in this topic. I hope to join this meeting.

Thanks for the interest. I've since posted the RFC for that [1] and the
topic is, at least partially, no longer relevant. We won't be adding new
users of BPF local storage [2].

I've proposed to the PC that we can change it to:

1) How to make regular BPF maps work as a stash-away storage for skb
metadata. I've highlighted my initial concerns [3] and will give it a
try to get hands-on experience with this approach.

2) Or if we decide to go with a secondary skb metadata embedded in the
skb_ext - which is another direction I wanted to explore, then we could
discuss how to optimize skb_ext (this overlaps with the original
proposal).

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20260226-skb-local-storage-v1-0-4ca44f0dd9d=
1@cloudflare.com/
[2] https://lore.kernel.org/all/CAADnVQKVfyh3_OZshvYf7GJUF-ph2eMfmaQsxNgwBJ=
d1AJgXTQ@mail.gmail.com/
[3] https://lore.kernel.org/all/87wlzydk12.fsf@cloudflare.com/
