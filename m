Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0328751B
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864086; cv=none; b=tLkL1gmRCFANkuqRWsmMP7ISj1PvNqijTPvK0P7VCaY7/3pIJIrZHPheIiYoiSWRFYIqzs2FhAw4BNRQAuJ87pyUblaVwcgjWwruGYBugSPUZMnE+69uZT7SRsyeg4r5yo6QUt53FG1YqK4r0cEeS05dNowMrrgLPWmBI8jsNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864086; c=relaxed/simple;
	bh=GGvtbmdrHpWov0hfduRttJHfpVecmu1fNiPKFMqC1Cw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qqPC3T2L1p/kpryK/XdbMQCCWKaXI5BPn3CxF1En7RynIpAXy7nvY5t9eCrgX7aR/kgZLTusWYG7xztsWUH0vVbA3itZaz2rHi+qLaMGbA60vlTV2epm/EvuRyTksU4xxVUU8TePgdhvYCNeUbyvvjxkTg5IV71OJ3HRURHDVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv+QAkLb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv+QAkLb"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79853c0f5b9so3385417b3.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864084; x=1774468884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ7Z8rAfiNkIJnsGGja0z7BFJa1lrhLafgp/LQadMbE=;
        b=mv+QAkLbbQty3KzD+iT6AyFWaebfR4sbkC1TuY7RqslFv4JKg4o1WkWuZxO0+S+7g/
         OQW9RX6rh0R1xFeIRtJ1aAQILiq+4lQUzGub7iTZNWqbvQeFB2QEge4qeov9objmGvnr
         4ydn18AQIBca6BZKMrdAtpFgP9KiBk07zq0ywRsMe62wljBmYoiT3hawelsTK5j6OKAv
         gitqBW2K3vrtuG6lXNUVZROD+ODFeWmB57x3rv39gSgA+tP7MbEaS5uvU+MVMwAgWVeK
         OkpvTSy5IfYabai2D42t31NHVjMUSa1zgvJ5OGFPpDrntAMZNilqGo55hnHYVjJ8v+FC
         LTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864084; x=1774468884;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJ7Z8rAfiNkIJnsGGja0z7BFJa1lrhLafgp/LQadMbE=;
        b=XEmK9NsMqQzd+g8EKA50b0/xb7MMTh8ePH6cJh6oFIrZhDVqW7QUPNp7NEsTnomN6H
         7oswS6sRVC5cIJQzJjZz9Z51Tc0B5sVnkq6WvCVPrn1Crl5Rrczzuv4wlTjUzNGejpH6
         AsOOpZBa95bq2B/X3lxZIZr56mtn3hJYtmDeUQ0Z5DfqT/PKaSIjg5NzTAaFHlN3a03v
         vKW6cGyvBt6qVTCG5by8rvtSiCuqsQikuHxxtRX+gOyETs4QD6Ab4Q98p4yv6RFiVBS/
         +2wyI754dQiYglFUyrUOsKxQQke2OlOVvOI0slEZItOSrbdDPQ84S1sxqFs2XsIyUKWO
         OWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWF4KM2AyOVf2DrGlCa5sOcwPEsdhHMZDRefmsNUKeGOXPN07ykWiRxeK3MjBFCrQhJ+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJs+FiI2C6TH7N8TiX+YnHFWEHhhnlKduw9T6HsXjQlQ1AUVy
	xGwdEKCYyMqTfylTJUyotezvw2Am7J/NKzAPNUVbYqbnWVYHNZQlUA/d
X-Gm-Gg: ATEYQzynVBknZWSeRZImu7uVVxYUFcxoCFL0sOYDW6skLsGYc5RyK0+qXv67YZ5vNMl
	6GvKOVZmGIEG2ZgPvZHctobcXiIgNSsA8Ajr1V7hJTRrb+nqBWur6NXuma6ddi5o8dBJtp8TIYU
	ERXfJF7kfARwSRN1EBjrIAlFoebCozZ4rFzK8xSXw2O5LeNAtZqU/iGm78lzuutJQBu2Pbx0Kh+
	8bfKwue+0nPF4M7Rqy8ZoS+sxW5CGt4aGkgz+SKIMFPMx35kdOclgjW7GQBfL4eoEUhePm964Zz
	MS5hsV4LeH5vRRSPVFkO8Wsl3RnETKhzUkL0Zza+izGTW8090qDLgRIZiiJCJfb+kF8N4/ZuKrp
	MHHVRObL7YW2AkFl8e1p3KvbUmfuz6fN64LWkL83BcdEJ8jHzvZi3siajBy48jbidVY/PxEA3bt
	EzDP2X2cK0galE11QDJhktb9a+s+BvSBGiD9OM5E5fQG0Wf4m1XgVtJnFlh0wmlo9rd++723XCU
	tqv
X-Received: by 2002:a05:690c:e3e4:b0:796:2dfb:4af0 with SMTP id 00721157ae682-79a718006a8mr49011147b3.10.1773864084200;
        Wed, 18 Mar 2026 13:01:24 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a71603d17sm23181207b3.46.2026.03.18.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:01:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:01:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>
Message-ID: <willemdebruijn.kernel.348794ac1e127@gmail.com>
In-Reply-To: <20260318134242.2725749-1-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
Subject: Re: [PATCH v2 0/5] bpf: skb_adjust_room helper refactor and tunnel
 decap flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> This series refactors the bpf_skb_adjust_room() helper to support tunnel
> decapsulation with L4 and IPXIP modes, in addition to the existing L3
> decapsulation support.
> 
> The changes are structured as follows:
> 1. Name the enum for BPF_FUNC_skb_adjust_room flags
> 2. Add new BPF_F_ADJ_ROOM_DECAP_* flags for L4 and IPXIP decap modes
> 3. Introduce helper masks to simplify validation logic
> 4. Enable the new decap flags and add guard rails for invalid combinations
> 5. Clear tunnel GSO state when decapsulating in skb_adjust_room
> 
> These patches enable BPF programs to efficiently decapsulate various tunnel
> encapsulation formats and properly handle GSO state transitions.

Consider expanding the existing BPF tunneling tests. Similar to
commit 166b5a7f2ca3 ("selftests_bpf: extend test_tc_tunnel for UDP
encap"). Given how far along this series is fine to do separately.
