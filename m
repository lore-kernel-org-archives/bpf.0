Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A6286D60
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302795; cv=none; b=oRUvQtJYSkVxaBr/qIRQIhgmZUAIUUuBp/vZ+nwPDIWQilWDDynkOJHHrYSnvNECtY32GJ2F0+rBXtA+E2dLo8UZcqwjcjOmJrUMWHmN3AngnwSXZOVyFwnN7QjmLtjqouDP7/TRV8ZSrXqGgbRMY9PTgBPiLaJEBk5/jSagfVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302795; c=relaxed/simple;
	bh=MGLs4AHeGuuUiwrTtFVMTK1hvgbi9j+AlpfLaMkfR7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RGNpN00FSHOoyUs/sa0cnoGp7WfR8CE6YVaGhtbxVYQ6z4cJPrvOnjUfOi4r1/83mzeGtm/kFsu5EG8PKyNSrWIxGKj89WQYQRQqICx7W6qsE8qYKry4paLyk6ZedSFt5jBPiRXo5jtStiOVyxiZBzCA+WC6zJAYgfQohJ/z1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAMMCW81; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qc89RXCN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAMMCW81";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qc89RXCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770302793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFOMQPyw5rr74qw2CeOtYNKg1tyNBe5jr7LotboMons=;
	b=AAMMCW81jDDMK08wN0M052eOsELPh7+SOwsC0fDu+v/ERDoMf4JCtZn9ot0tu9hvbeGhrd
	QHu3571WQR9tkKmU5OnaE50MOVYGKhNMaC+Fbo71uQrEwuVtapu7bLOY2gMo9JKslN0XId
	yF2hVQR6N29HmYKu0raEZdjjYfrGInQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-np5th79INfySUT9cq9kxEA-1; Thu, 05 Feb 2026 09:46:32 -0500
X-MC-Unique: np5th79INfySUT9cq9kxEA-1
X-Mimecast-MFC-AGG-ID: np5th79INfySUT9cq9kxEA_1770302791
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806fce5ab1so6142465e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770302791; x=1770907591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFOMQPyw5rr74qw2CeOtYNKg1tyNBe5jr7LotboMons=;
        b=qc89RXCNMdyZauyKr5wOv4Wp28KRb1T5evrLNdxZky2oX8wflJEX21vFG/7KhXrtHN
         1r9e2ChPaAT5V0acrce6JDPEuW2yL0lwLrACi3vnVUKUsD61nRjtO9aCp8VO41aBvkDK
         QsTX+uouqNdNBSKqfBl6nc6UQkZtWKUTMDctseP3YHMcyuLGrAF65rcITeoEEvH7RrD7
         IR17/I9OzO8bCa/IMRbSh+P7HKZRM+GQ86SYiaJNdxY9IpmTtgsPUWNjU1IvSgVKI+ET
         939j7dj89wR7NP3eVW8cP9dDKm3MiO4T/gvNie+MJIkzUHVOYL065RoU2SYz7Qo++dmA
         oFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302791; x=1770907591;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFOMQPyw5rr74qw2CeOtYNKg1tyNBe5jr7LotboMons=;
        b=Sn+xQdzLYWJ7glxwfwy3+2FEPtVsvZ2DAhAy27mNO7lmCmmbf9fxfDhkKw83ET7oQL
         dK/4FOriUUwoa0cEnpuWIXzHXuRtQpSBznyPoEI5W+ifg6ufBRN3A5VCppiNR9FBvKJF
         1zqaYXDS9JbCbtxjOtI30gwM4BhsnUuUeDMSp4lpw9p6gAE9e6P1xutIUFkrBJ00CfpW
         FmrLf8VG1GcYf5Tp/k803Dm09ty8IeSXa6jVwWEtNyv+59TIiYbj/FXEHnp2mM7FLVt7
         PGXQBgKEKGHGvLnp7qeqA30cjaBljFyWDKn6TBlRt5O6JQjG6SU3zgdXmUjE+pFx9ZnQ
         YY6A==
X-Forwarded-Encrypted: i=1; AJvYcCWwXRssPIFzgp/ox08a/YddQ3lcBpQ3WI5ctheC00d+8IR66PjxAdhkQdPH5k3qo40uHq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGazPVYT40FvhBKD9jwvHng/CUp7w/c/vTDb5oFz6CalDMyqV
	Qm1hY9f9RQ/pS8R+2D5MKxl1NZM/AdWiSVV8PFp8h7qxuHjq0o0f/0TZtuHkCG8NYBLH1ljkvWP
	IuOS1+EvrYIEr+tz/v6vWiFArSMnz0uWfH0Odw9wfkhaoHK6KkqIDag==
X-Gm-Gg: AZuq6aImvEBWjc3RCexXChydsDFNag8ZeMVxFFTvuFzN0n+NIxmsfISwMxF8eJ6w6Se
	OcyRc28QJtSPasmDLYMbjEEiallE5dIukaQfw0MFlfZCgSNRTYkrHxo3ZDIEgAplLEX+oR2jTaF
	TaE/UWxiqIA556ciweZTXEZvYZnYJWt49cC1CgG4/0fkadwZxjPOmjDL+t6LqD2cYLBB5gWikyA
	CUnDG5T0OxyrJnGE9/UXl9jJGLRihF0nXN6W495O84I7gdJmeY09NLu2ujS2btHrHrgov+gUxG1
	350LaAZHSNo22MRkiIB+YTtSAuCgoYufWkp76EqwH4cuWba2xGVYAaqsekJNFc1gKuFlWMonju+
	5uvDXj2NvAAr/H4Lkx3k66fBOBzCQv4I7V0K+
X-Received: by 2002:a05:600c:4e41:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4830e990b54mr88588925e9.26.1770302791153;
        Thu, 05 Feb 2026 06:46:31 -0800 (PST)
X-Received: by 2002:a05:600c:4e41:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4830e990b54mr88588315e9.26.1770302790517;
        Thu, 05 Feb 2026 06:46:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f8c1sm12112640f8f.37.2026.02.05.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:46:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 419834D1165; Thu, 05 Feb 2026 15:46:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Antoine Tenart <atenart@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 Antoine Tenart <atenart@redhat.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
In-Reply-To: <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
 <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org> <877bsr1l1h.fsf@toke.dk>
 <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Feb 2026 15:46:29 +0100
Message-ID: <87v7gbz1ru.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Antoine Tenart <atenart@redhat.com> writes:

> On Thu, Feb 05, 2026 at 12:34:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>> > On 05/02/2026 04.04, Jakub Kicinski wrote:
>> >
>> >> It will presumably require existing users to migrate over
>> >> but sooner we do it the fewer users that have to move?
>> >
>> > I agree. Existing users will loose some details, but the patchset
>> > results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
>> > which existing tools/users will still handle.
>> > (The more specific drop reason is now avail via trace_qdisc_drop).
>> >
>> > Eric and Toke is this acceptable for your users?
>>
>> I like it! My only concern is that drop monitor tools will see two
>> events for each qdisc drop. I guess that could be relatively
>> straight-forwardly deduplicated in the tool, though? +Antoine who works
>> on Retis to give him a chance to complain if not :)
>
> Thanks for the heads up. We'll have to add support for the new enum
> (pretty straightforward), other than that things should just work.
>
> I'm wondering why not using the drop reason subsys logic to combine the
> qdisc specific enum while not conflicting with drop reasons and allowing
> to inject the qdisc reasons into drop reason enabled helpers as well?

See this prior discussion for how the proposal came to be:

https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org/

Basically, figuring out which qdisc a drop came from is not possible
with the current drop_reason code.

So it's not just new drop reasons, it's a separate tracepoint with more
information available (qdisc handle, name, etc). So you'll get two
events for qdisc drops with this series (from patch 1):

+		trace_qdisc_drop(q, txq, dev, skb, reason);
+		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);


-Toke

