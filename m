Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972313750D7
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040670; cv=none; b=QDL4n+IvyoyS0g3cm0K89WnV0LlVWrX9xppRXQ8sK0EbSdW+OU4mFEZS51ivm05st0rCOX7p9LN+PIfN1bIkBVuIlOnjD+rOAI7dDSSZQOrI8y7G0cJy4Sk+fDgOWg/P6w49YwEAyhoJe1mWXjVjqi2s1cHpPcJVAx+SG6D7H5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040670; c=relaxed/simple;
	bh=pLQIzyAXx9BXS4Jj3YBYF1I98hZkelIy5fkVP6OLqRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pyE+sTPwGysRuzqgoqQAW5p8rY/XEdtLH7x/2eiIkl4NX0DZyooMJgprfJjX38EpPj1KWKh8dGX9CH9ms2ptts+bbOTgM3kIyxG0kuNhKEl7Ch/4SfOJNbVMs88PfjSEJ2E3vi1Czm8Oud267LAr6L2FfcdakXm/YrneNC1oV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatlDfpl; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatlDfpl"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae3147so2623284d50.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040667; x=1790645467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZPM204BsQkvGwo/0VKtkWmPTs7CeisxuHS7DMwf2J0=;
        b=XatlDfplU5jxFj8s/qAjvIWuO09vLiCrFRHLWy3G3OMxOBIlmqsKvCBweD5Z9x04J2
         fHbLptA2LTwou8yktuWkEmPJSoWtG80LZ6ZpJusja/SCSJ0jdI+5mqQPCo/VpNci/MV+
         VeFWKN62iC/IhUG4gwPS/+JXebnSBmbCT2NNJHZ53ty07r886qGFokGjnbm9hXiQO+hE
         vo954ke5JmAezi00JegrecUtgblI0vEvvsqSSR9AAcmQqqbKma/dNAPj9rtHUA62ZaXm
         uPeIlBly1lbF+3rx9s6jm8rAi+4ZtVF0wFzqtwnxQ+45bycnL5jymiM9vrB8hz8uqYc6
         Fugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040667; x=1790645467;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZPM204BsQkvGwo/0VKtkWmPTs7CeisxuHS7DMwf2J0=;
        b=RtPh2BngwiHBBj08yM2tlwZJ4wyqQxMMF4aNeruJklgCKkC62JT7lAJC/BAVnr3FyF
         vI0oq51jTmLDBDyYMtBPgiqwsd+juO1yqfedeRZn792BrC88VVo6TRuES5Evi9iTfmnE
         R3li4Tb15YyoWQePWTej/kWsIB2dz35y5d8bQqaIMZQOqGUtiEjvF6tpOuSnjx4EeEDE
         c6V56DxEsOOqbEKMTUfX2zjk1R5jwwQeMEdQ1BPtd4jRE91fX+82v9/mDn4mxpR88Ag1
         +dJBHOlcyMCucMaDVvC9HJPwnmoazPEp8oq+Cxtvc6yI7JZUuBqsVMeaBdnAoKTr8ZqJ
         3UeA==
X-Forwarded-Encrypted: i=1; AKwUvBwHiVAralO+ldE/YwZOyB0KYxKT55P/3XCg5KcGgZeq7j+CTBbKSlB+NaUr49uhVgrEWL4=@vger.kernel.org
X-Gm-Message-State: AFuF++n7xiZH0Gk4884DP1l/IbKwWJrj6dRECwFtyvq3DghXc1b7cKDv
	V9H2FcQ6wjffd7NH2t6LCdF7ZGPK/AKr98lpw5JpyvFvohCCzbKL0qesTMv1MQ==
X-Gm-Gg: AYBFou1RRekwo2CRDyp8q1hDMkDUjbHNEAdAOyB9SElp6WDyjbeFIRvisFhKuEdQp/S
	30F6s0I4aCfoUxJW8WomfK6bK5n9JuPJAN/xExTk2EWWIeSJ2pDbKMEHOdYAv0e8RM2Oe1mHy7v
	ukfE4nMQ2V0Wp/qkOiix8dFv+eQW1jPi7Sc5+QqETQ34mIPgO5pkkYAAZO5tBRV1FZT39ckgqxQ
	ALg2Gb4JsLOn7QdK4qZJrYjD7xA6jgXENjhhImAxlqJeDZAT8fgyqHtPLqVP9dERV6EUoB2k2Bx
	tfwAtx7++0tpjUzKDMiNJvc/kuqvc0kVBTMeU+erYA3gOdlZ5MEL33AOOgqqjmnsVGHN9J6aaXd
	Nnsal00DYs+YsYR0q+cEzTPr7qz/5vr9zmrELJPiLiPsGUvn3Xv/Z2gHCmqiQEYQ0Zs4wjsrO33
	V75gC+LqqFslkdVPpFNCXTD+UfMiws4C0vcdquJR90P0BKiRDR9xPqGEvvFWZJdLy7iUxKTPR5F
	iGaKlNh19KtoyN4WFBiDn/j2u8iOv41lD7OQzWwTXJmdbwjvXLJ
X-Received: by 2002:a05:690e:138a:b0:672:a83b:9964 with SMTP id 956f58d0204a3-672c199f5d8mr821945d50.38.1790040667423;
        Mon, 21 Sep 2026 18:31:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c766dfcbsm157903d50.17.2026.09.21.18.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:31:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:31:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.2e1c6881ed336@gmail.com>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
Subject: Re: [PATCH RFC v3 0/2] virtio-net: add flow filter for receive
 timestamps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> This series tries to pick up the work on the virtio-net timestamping
> feature from Willem de Bruijn.
> 
> Original series
>     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
>     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
>     tx-tstamp and tx-time
>     From: Willem de Bruijn <willemb@google.com>
> 
>     RFC for four new features to the virtio network device:
> 
>     1. pass tx flow state to host, for routing + telemetry
>     2. pass rx tstamp to guest, for better RTT estimation
>     3. pass tx tstamp to guest, idem
>     3. pass tx delivery time to host, for accurate pacing
> 
>     All would introduce an extension to the virtio spec.
> 
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps    

What is the plan wrt the virtio spec? +1 on demonstrating working code
first for feasibility.

Does this now also need a spec proposal to virtio-comment@lists.linux.dev?
