Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00E2F12AC
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499931; cv=none; b=FLhxfHKLxelJkdpv41/yNzvAFMhdldMjscLYIpDne4qq0ECxWhXIJqczYjpbBJz5zbhnip8rEelZ8ly9PefAWQZbs4gsAh2qfSRj1ga4y9mcAvBXleVTR2nPI+jgtjeUzd4YegNBcKHXwNGZtEL786jVtURDlxl01uspxaWsGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499931; c=relaxed/simple;
	bh=faZnyJz2V87Mu/N0BovXnVc1f0xWT29HYoOHfcayBxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCmC0Otw0z5AhAcooV6lj9+A+2PHNLWafGzI8edIeFx/4DVtsGDnb1vbEKuPkS53ilk+HFuKmFJMo/d+6s3bLrxRrpMpNRkfivJLZXRibyLmrDrsxTH6Vw609oyGhYZgL3uCpocRKj3vX5C34MqbbKyLB8+OjSpbQ7Fw3A7eaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku4SgX+g; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku4SgX+g"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3078e0dcd67so2213572eec.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782499930; x=1783104730; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faZnyJz2V87Mu/N0BovXnVc1f0xWT29HYoOHfcayBxA=;
        b=ku4SgX+ge/ieQoABdELk3oGWcUguzXbqwlGb4+8qkEIpt2dzPf4ILnVDKERukW1/c2
         tm5xViCiTFG9unVQUB+zgOBMPjTbEziHT35YjbgZMRtGJj3DReGblw3JwV16J6RXiEQc
         iqRBlMoeW1CGbcszLKq+n3vsHZRJQiBf+UJzNVrlmvPZOlhrzB3Zg7l+wMk9zoIpr4vl
         82jIr0R156/TIaT0J4EGdgfPa8UDOAFzVjEpYncP644vA+11ONVVfPaQcHJpDr2dO5sF
         M+Zj7lyUzy26PwCqH++djH9HoX6VYcTojShJ78GgLjOC4WujdWENMWbFrBvHhRWbqQeC
         l24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499930; x=1783104730;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faZnyJz2V87Mu/N0BovXnVc1f0xWT29HYoOHfcayBxA=;
        b=WUrjNymfIMxxD+BSUHJ876p/HDawYC+PXSCCjSM+df9m0jy/EMXLsv2neV0YvD1Mly
         nAap+OGNdqxa5YVDl5hA756hT30PM2jRmJx9hsdJIjW7vZvDKUJBSaUgGVwc8027uie3
         anLfedjM+tTVH4JkaTWDxYTFqSdVx81/kxzSVWcWM9Qe/0RfCNckc3xQdxPBv/+ASDf6
         fxN2OZso92tCXWkkyE1oO8z19ApRZcu9xoMkQ7G6V7CP52ycWWxNa4QT+Lh68wLO6oJ0
         M7Zjto2Ten+A+lLgFLg9d6P07Ydxp7AVzdcbump8Md3XKWkKx934FVBv/Hsv5KyRMpcC
         0bsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTiPtUTbAzUsPN+AnT8rteYjDDA5s2/0hfbzMiRkbqiiLkhVLqRzk2jEHQ0PqDUpraPEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMf0qNo7yqKCzmHpBJ84vE/gIoTrrQWG3fY0Ga8FLoTVkegLH
	KLiuXW55NHXcURvGvMpIRE+YwDcL4asyXidWchyjrTK9xuPVCMEo+jKA
X-Gm-Gg: AfdE7cneg2rCCXnxOMDL0FzGLCZwH06CLroWxbiP8PMjguSITdC2KTSGChrFKXJeXiM
	uy1F82fNF+/mhS2UbQ/2Mt79ysZvOlu5lOm1Q5vGcO491byxApnbl+G/UL2neUROv8Z8XN5Aow5
	mnH52Jd7w/wUpDkMQC3OWG63eszuNpOFKTe1wVIpSMmwdL7XTzlwi1KuPZoWTu2+yTJLvf13MgH
	VIiQwOIOK6+bHKX6R+uZwfj6YrORpGpgeyJ7YpsZYGcpreOhZiAK5rs4qk7BxHr+iAphNtKlNtN
	I06K5mVCfdYcXdVl4c2fSh+5tdhtGi22vjcyRk/mTR8dStzrwvsEfLHfI7Lu7xTaU1YzBceeLgs
	2kvH80817SoRBgDL181Simkc9wDNQLBtMRP5K9RBmBIieoLWUXI/l8o5eDiQYJXHz8XCpahj4zR
	50vpIrytCt6wqEbKj4O2NscPQu3INTRcJQccwGHVki69IgHYGLtAmkWlj5H27AncxvfGSBZQ==
X-Received: by 2002:a05:7300:760a:b0:30c:2d3d:7840 with SMTP id 5a478bee46e88-30c84e1987cmr7793381eec.35.1782499929291;
        Fri, 26 Jun 2026 11:52:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c002:b4e0:8df9:2e4a? ([2620:10d:c090:500::1:11ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca8b918sm22125081eec.28.2026.06.26.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 11:52:08 -0700 (PDT)
Message-ID: <dccb2602ea054f6fc8c54aba5e74c667be14ed2b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/15] bpf: Remove __rcu tagging in
 st_link->map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, kuniyu@google.com, 
	kerneljasonxing@gmail.com, kernel-team@meta.com
Date: Fri, 26 Jun 2026 11:52:06 -0700
In-Reply-To: <20260623175006.3136053-2-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
	 <20260623175006.3136053-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-23 at 10:49 -0700, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> st_link->map is always written under update_mutex. The paths that read
> st_link->map with rcu_read_lock() are not in the fast path, so they can
> simply take update_mutex instead. Remove the __rcu annotation and replace
> all RCU accessors with direct pointer reads under update_mutex. Use
> READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
> without holding update_mutex.
>=20
> It is a simplification change.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
