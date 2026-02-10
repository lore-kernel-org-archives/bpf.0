Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FA314B6D
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724392; cv=none; b=SQg3uJAVtHu2ycQAH8MinBRfCBlV7X18scwgqtRqh9ErikYF4sgo5TNEkGTznEWiQn80TpNMkVam3m2UUbe7wiFL2zOIhJ50+Si22JgM7UT4yxoRCmeoTdfpBCyoHbPyc3OZtgB2ACubvtRU3irQYIdlq0neX+O/7JPldyvz9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724392; c=relaxed/simple;
	bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uotMJrjzSPUPMdcTuw9PCT8mtAIybMIf5J66cWXSRTjxTpokCTbFnmBhbnSmTBL7kN6IYSO+zh0dq4N5FwvWGYdPxbH2kDNRl/N/0fjiXGMLYcyOituVZQHAjp7gY7wi4cf7KiRPlCc8S/1R+uN3O0/V9oyMAt1NyuSU48Mglr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxYnvSBJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwDccQIL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxYnvSBJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwDccQIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
	b=RxYnvSBJfFWeujRnQcARi1UtqbTuaq07DcC+zxQ9eNTpo5Cks94s3/09CD6g9qLcKFmhXo
	Jg9Thhsit/8NUT3ivzIu1krqTrSV2vpl0R4bEHjU83q56lVLaiiD5yU3x8vZmW+qtr9dYk
	sejYz/bEbjQAS42vVqKy7fhkFTMaqdo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-eRVEUQb1OHeSBQsoy45gyw-1; Tue, 10 Feb 2026 06:53:09 -0500
X-MC-Unique: eRVEUQb1OHeSBQsoy45gyw-1
X-Mimecast-MFC-AGG-ID: eRVEUQb1OHeSBQsoy45gyw_1770724388
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48071615686so6450645e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724388; x=1771329188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
        b=VwDccQILtoPONVQxd8Cto43gtIoE7hyb3RWyJLReOtBRBmLYiQSRiXFZS3c/J7QjmK
         7W+PCZPT+BkG+QLEDDYhWp6ienIViwzeZaJGAt4Y2HEgB1J4M4bHC9XTj0cUuGqFINrX
         gKWKdR0irnAnZO9T4IZuI+5KYFe91hCqK75vXJtEobqLhLc445k/Q9UHneZsiA6KFnV5
         3bqG9WpEGS/t5KPmS8NGdeHkMSrt422dtmArLEUDDMzPrRli8d7f4YXj0nFhsdF50DxI
         YcG6BixRhgr5sB3B/h0o5Pt4LXuYZ5M1Y+pyGTZElHaPcdTUpnWcq9biPblfEGcxwZ51
         /rCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724388; x=1771329188;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LpdzJGfDHQqYzc5BCyZcOZFflmElhqHKLmb47eKNQ2U=;
        b=ShlHQ96SxeQs3IzQGt0lCwDrsc2wBXuGPphzLStfeu+bzuF+MQy8xPKzatFS6BJ0Oh
         ax1xbX97Q6YkznsUopbq6EtzvTuv/dVQ3mAm9gVjppSt6SLwkucpVqBZxMzjGla1hecf
         +lkMHxIxmM4aoSimYs8BxV0jm3f81A2rZV1KvcgIlpjRpq8YW9EFnhQHUXir4zRkUnyw
         852dbkW5NXpqlDgrTjEQtsVHJvlJfkzKfoPWBvoqLVxXXZyIqs2mjF7JEU5y9EpS6iWm
         braS3mOEl0sS5l6nstz5o83dk6+d/cblmSWLEpW8/GVB7mrPakVagaguxuB7cqwKzFdH
         DiuA==
X-Forwarded-Encrypted: i=1; AJvYcCWBzXQCk/ZUbHyBMNIMwu0pzkYqTox4CJQ4EoheXgwHnBd31XI2Sk8oqEbv3cWBsjiXDWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4TAklMQ5Y4I54ygrjrQWPv9BS2oEYZsmrA/aeZOtl8I9/ZJu
	EqUAkiqNzexQn8rv/ym1raK3HdthT5INzayjkAl8hSHRLsVbgmRi4kY2d8LwIuS1oW58Wp1pATW
	Nza8gtJuh9mLg4GiDt50svYTv834SRI2XOY9WhirVdfOoOfAQgFLNgQ==
X-Gm-Gg: AZuq6aIM1/NigDItJqcMdZgqoYkOtIM6NHaQ1F0g2srA8QGMT7rRmwM/9/du7oO0lgN
	VZpHK4VohJVDi3fpS38/Dnfv4M+BnaXJbdBJj8l9G7DfrRv+BTfFCL3SQUIYepP6q+6A6n9HdBF
	99ngKBj6rylOyB4xuoNo6xxT7HaxgDSRBClm8295J5Va/2fm213Kmepr4F1h7YiY36o9wjVE57t
	Be1GuVkXUvwKE7S+tBlqvqYNdLihfqwg++BQKFliUyB7V9664GR29u6ZSPz/8i7KXD9VB4Q1HMo
	dJyLx5ZXIJZy09JS6HSwJFOY5Q78YX7mfPfOCqysvbO0pgj9aS+enumVvKHHa+4m2QuMlER8Izy
	hNSMUFNmijLl3DSvCRmwJ5av+D2ZBlkuoL/IEQ4qXdtZ9cror
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-483201e408dmr184790605e9.11.1770724388258;
        Tue, 10 Feb 2026 03:53:08 -0800 (PST)
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-483201e408dmr184790305e9.11.1770724387866;
        Tue, 10 Feb 2026 03:53:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48323c0296dsm323555505e9.1.2026.02.10.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:53:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4E89E4FE89D; Tue, 10 Feb 2026 12:53:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 4/6] net: sched: rename
 QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION
In-Reply-To: <177039508262.2258217.13751577312338706877.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039508262.2258217.13751577312338706877.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:53:05 +0100
Message-ID: <87v7g4yfvi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Rename QDISC_DROP_CAKE_FLOOD to QDISC_DROP_FLOOD_PROTECTION to use a
> generic name without embedding the qdisc name. This follows the
> principle that drop reasons should describe the drop mechanism rather
> than being tied to a specific qdisc implementation.
>
> The flood protection drop reason is used by qdiscs implementing
> probabilistic drop algorithms (like BLUE) that detect unresponsive
> flows indicating potential DoS or flood attacks. CAKE uses this via
> its Cobalt AQM component.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

