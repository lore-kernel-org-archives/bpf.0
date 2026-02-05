Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE743637E
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308688; cv=pass; b=rTH4FxG7rkPOWfj5Vs7rgMcuuCxi6Dug10aghSua9XeXwvOjIVQBxexDQa9pGxdyo1C03vJO6X0efpSC9plddJANCzNUhZGbh+7R5pT6SuFxEE6Hle4cnERRNnYiaYUgHp6te48tzDhiNOasghELQVAPJVU+2WywdYP+VvXs4Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308688; c=relaxed/simple;
	bh=odNvXPzdKEvCp0BCtgvbKVCz2w6TVfIMVaJ+RANVd8U=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5r30a6ArBWuknfQHMSjxiP8kdl0MKu4Yj/pJMKiva+0rlsKLDnYPV+j8EEu31hkfAreL4sbFRpuyDrtCHNkSUP2Elve57PDnoQJGW8TgiX+XD1lrwfA1dveDdmscULPldG2upnj6TNBVaCKOxkkJunma5bfNXv1pMNfHihhBG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtK6VMZa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4MwZqYi; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtK6VMZa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4MwZqYi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770308687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
	b=OtK6VMZa7Jy48sADBGbhBuPi7M7y2DDI5FIgIAmErPU2zMNBj+Dc8x3M+9IU+a3YguKdWX
	1pvJ8ESq4gITsVnzrdNirOxD9YpxD6R9x2eG7vbMJvyJyVCji7rqbAoJjZV7pUIAI6wwMt
	dq/3oEy6odpdzpZl+4bCnkcgP06QO+A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-OQ6agnzIOEStCoB6ZhGwMA-1; Thu, 05 Feb 2026 11:24:46 -0500
X-MC-Unique: OQ6agnzIOEStCoB6ZhGwMA-1
X-Mimecast-MFC-AGG-ID: OQ6agnzIOEStCoB6ZhGwMA_1770308684
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-894709fbae5so40049346d6.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 08:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770308684; cv=none;
        d=google.com; s=arc-20240605;
        b=kIiKeA6oBni/BZL7g4b1TpVF01rdwjjjXjjj4MCas8q/9eFjda9O6yRKwzxDO0pH1B
         1yToLggsF7G86JD7r3fMnDF2bEwosOXNbE8WSqaB0gcpL4HYkAj5ylnzZAJ4vSoR5RiK
         lwi784bQ345B3whgbEs248aCLRwO1nJKo1POqyhhdEMMFDrB7s5T0xMERFEQRqhLAo17
         aL1lWUQ+TL7gVr7PN9USEUWe0O2ENiw7uu6m9iCkXKal2nUFA8kv5GJlZH5SShR1OZ95
         xerDBLfWqSg7ar2pjipISn1DadPgthmEuaU0f69+vdcEL/WfAnWd+1t1GeA8ke1Ja7Z3
         ZB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
        fh=vk/1m4YucDUYvb8IQzx8IIBucQNTLr2IlVHUJgQTOYM=;
        b=UNLwhdC6mJUZiaiixCvXr9Pkz8VYz53dDts1aubn4CyLASJA/4VNpAtqRg8a0lbY4E
         wWtFdkFtDVkpmpw+nX6n+0PS+yFZrfJswRBT0hq1Mn1pbbNO12WpGestoyz1n+tC9zky
         mh8sInvWpbte8NLYPlk0e9lc2byLlYQBOf4fiPLQfGQiWqRtpC8+kjDV2KfQnRZxodOW
         yWzUTvD9zDw5BAS8+jaLmWYSy7rOzA6NatOxo/lYwPwx5U9DE2d84UPI6BAocIa+QBjA
         OuBh1LteroxrBl7fLzXLzz4Z+iAWe1GVJ0WqpAsxwgdxCkARMDLbfyMJocs/zGTbGfn2
         d6Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770308684; x=1770913484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
        b=H4MwZqYisU5ALnuy+nWb4XH+7ryBxD1UcrN0Kr+63iRWDQe3ewrNoSfC9qf3Qbg9vq
         fDfeZeilyMTZruufv5J+EZl0oGSL3MZ3EgCXQC9uZ2CDyShRAkrn49m2lNiAmyv4nDzt
         Xi0mtcpbf5g6Lwsx3h2D3x+DoFP/sSzqrt6jeaor/Xu1yJD01FmZdd6Z9aOUO2xiYxWu
         IkVKmy+0eEGT5UhpnRtRWA1tVwtxJeGyOe8igUBqBy5Chx6XuR4tdX/FMDiwLhVx0kNv
         g5aOu6c61unrNZmEwHwnahC5BrOXZozjig/tq9FdGjRKsud/b4YukgdtVnjawDldMgQH
         i5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770308684; x=1770913484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
        b=U/TrLl3gspGR+L3DYYLdS54yNOPreb7iMNqUsBpV8Ewcv8o+ucCooxcCOmfhvEVF7k
         mfm42wejSjM2V8O+mTeIijDq7wTmxoYs+sNhV3Jk82SA84YKiiAD2Pq4TaSSth5vPvAr
         ow9Zf9selHdtnRtWsCdBFQb1sqfiXGuS0Su7+2USHwuRAecxtD2stSYJDPHakIw5/O24
         7dLML5Smm1sQt9TZFPzIW/l2r2WchGdnvjFZuojcgo9t0E+7NAUhMpxQn1fBHz7PfSsL
         RO3Vi0VmpDWyqZUvFnZvc+QH16eXVcT03LqDkYuZsdq2hpyz2Vy/V7QvenqX9dQMSApA
         /Xjw==
X-Forwarded-Encrypted: i=1; AJvYcCVmjMamoOGbr40QrG+fqoTeZA05xwkjGd4Sd+fjY4L2E377YbuUE1Lpzck6UWKEyO5RuzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTnt8lBAQmzQ/mgh4N+LCst5eKh+s3n0Q8P8aOb75UBwgRHBn
	KkqkDJBIvLpXAZlzBU2MpHc4hYndQFNTOYqVSoP8+gwK8HJkl1hBxUmkPwgIWVizxDp9ZqOdaZn
	EPLzhuDx/kyjbFdEPG3kwG3+8CVLqU12mHQs2RkRYq31CDJnyKOjrNdOu5Y+u6jg0a44ChopVDY
	b7m3AcaWZ/uHi+bRt9l2vLUNpZjwSv
X-Gm-Gg: AZuq6aIEdz9qb08hBh52o8rGrGrc+ZgEYGViOIJn3gNIZpvmhr2oKJQzrxkNj4Vg2hi
	PquqGUS+OVYbBKiVOazwObiBK9+4fY+PPZvM2tgouEd/Om8RxJbTIzy7mPqWTPveB9vcEs/PVEh
	s2RPeNeN+lZJdksMCxGBZ9/Kx0SKcfaXfbcQUPY1WOir1yVK/sydoZYQ3EqKs9t4RJOecLreFiO
	XptW32/xTVgLQAyvD/SOkzcrw==
X-Received: by 2002:a05:6214:29e9:b0:894:7051:2681 with SMTP id 6a1803df08f44-895221b95ccmr104470936d6.51.1770308684587;
        Thu, 05 Feb 2026 08:24:44 -0800 (PST)
X-Received: by 2002:a05:6214:29e9:b0:894:7051:2681 with SMTP id
 6a1803df08f44-895221b95ccmr104470156d6.51.1770308683860; Thu, 05 Feb 2026
 08:24:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 11:24:42 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 11:24:42 -0500
From: Antoine Tenart <atenart@redhat.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org> <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
 <877bsr1l1h.fsf@toke.dk> <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
 <87v7gbz1ru.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87v7gbz1ru.fsf@toke.dk>
Date: Thu, 5 Feb 2026 11:24:42 -0500
X-Gm-Features: AZwV_QhdojdkYOVl1RGk_7Zu-0LDXZBDivdkSb9oE5RRssG5O18zc8Kz5q75RuU
Message-ID: <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 03:46:29PM +0100, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
> Antoine Tenart <atenart@redhat.com> writes:
>
> > I'm wondering why not using the drop reason subsys logic to combine the
> > qdisc specific enum while not conflicting with drop reasons and allowin=
g
> > to inject the qdisc reasons into drop reason enabled helpers as well?
>
> See this prior discussion for how the proposal came to be:
>
> https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.o=
rg/
>
> Basically, figuring out which qdisc a drop came from is not possible
> with the current drop_reason code.
>
> So it's not just new drop reasons, it's a separate tracepoint with more
> information available (qdisc handle, name, etc). So you'll get two
> events for qdisc drops with this series (from patch 1):
>
> +		trace_qdisc_drop(q, txq, dev, skb, reason);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);

Right and that's fine. Using the drop reason subsys logic you could turn
the above into:

 +		trace_qdisc_drop(q, txq, dev, skb, reason);
 +		kfree_skb_reason(skb, (u32)reason);

You can look at enum skb_drop_reason_subsys and how that is used within
OvS (net/openvswitch/drop.h) for example.

Antoine

