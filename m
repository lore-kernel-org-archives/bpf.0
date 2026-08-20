Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D963EEAD0
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218571; cv=none; b=hmHnJrr5+TxHkKor4mgPmwwuJ6Yue1eFtNryJOdXF8EjFeqlqO/WIlhe57I4jtbjpg5s4E15g6bXAMqWmY1VDI0Ux+21weRHtiaGWuw1r/t3h8dSAiC787Rfc93Uex5ypAM6gVraHSdxmGIeND7GvrguLDvzxizjOroBN5vr4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218571; c=relaxed/simple;
	bh=kJ3cTYIYrtG7tlP3Fs01NISD4Xb/24ggyMndOowsHXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3qIqeRkcE3iR+2rf8UUDtyBGIPbjyINq5+TEs87cfWZmgAzGQ5tHQf0tFBolW211glkhsaxMsIUwzteQpSq3WE1o9a0AlURhhL7/uorOiYVSVBHm2SLISXCkXbZITcufKzpveI9mJIedyY4C9c+D7HBFbI9E1/LC01Mpx4LhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd4vH6bL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rn5i2yLn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd4vH6bL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rn5i2yLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787218561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cihLxc2CBVpIep8pW98bFEf2PHfl2dA2RKm6Z1hhqi4=;
	b=Cd4vH6bLSUrdHeOw/LgoGGZZlbFmqzKzwjH3SuG6gbJa4SHBhrpWkoGW5UcXwQefAuEqgj
	syC5pcBIaUJG0lfnbvU0/Y9l8uxgzFM0ACt1hf+ymCbZzsZIoP89n2Wntbta80zYbcwcnf
	FaOb6aR/SHl78xAOE7dlT4Qvc6RqZMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-wneqgWY-M82SSOXN-iO1lA-1; Thu, 20 Aug 2026 05:35:57 -0400
X-MC-Unique: wneqgWY-M82SSOXN-iO1lA-1
X-Mimecast-MFC-AGG-ID: wneqgWY-M82SSOXN-iO1lA_1787218557
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so16353235e9.2
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787218556; x=1787823356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cihLxc2CBVpIep8pW98bFEf2PHfl2dA2RKm6Z1hhqi4=;
        b=rn5i2yLnKVHBxurkYxocygugSCKOySqUP1nPJHN+SMk2ZOdK+hnXlHZt4O6rMifPU5
         YDQVOyPYCGdihxesUmbXWqFg8JxOxIlvWzFEdNunQo2V4e7Yh2sr/+JlqW6uKy84ysdK
         ShQj6oxF/Rxq3yXqqa448xsyMY475Zjemh1S3b6E17zX5zkPMTyZ0c1LoWVOFEWpf0WE
         W2ENksFhdDDkxUAYR3fTe98YtrzekBSGOY6AwJAuUo7tOOk2UIvCAMLbKVqThzOQI+fx
         b0VY4FOxECNk304rYfW8eAlpgqN7lEKLd8vL8Ylqkyj+48lXM7u+OXaQiCkmRITP+0a3
         dp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218556; x=1787823356;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cihLxc2CBVpIep8pW98bFEf2PHfl2dA2RKm6Z1hhqi4=;
        b=qS0DMstqs+jiEUTrtrmpUjg1ac4NhEHbb1JsbuC3xisZC2n/fY56tZ+YM7532BsdKZ
         R5Lt5j2m6g+t3w3pMJH0qmW1S88dyRxxsC4IvMHYae12jQjhYb4Va9LvPaVDCAH7WbRS
         O78J/hIHOsELsv56MJ0Uj5HzCdtVJNn9Ca3fifisqqBmUFWqMoZYBU2aIZKsJ2Xgjuan
         Relwy1BHIZ2qXhWLUKyHjcfjb6pFJVgjhE5dg5k5KCtUorARDmLagW328ZAk7FRRZDUv
         iCCPZHwwpK8IFR3ogMPYYSO7l2g6mWa9woVItUfQDxtv4/NjeKgOZRz8lVdSTYp4ayQ/
         WYRQ==
X-Gm-Message-State: AOJu0YxX6I4GTDN5QUMtcH/bCFO6rP4UT5JrYIDqMOS/jOVcsLEggxCO
	S7cuDVDY4F+XsP+tD0BBZK9r8W3BqkR4Sg02p50N8Nz0214LPvapMAWr1XUfer+dLjKIsD/FTZZ
	2GY5oGamFXpKXztS0myXwyg1GDtEeptI0yV02ssbrPcxv4U5VV2MMAQ==
X-Gm-Gg: AR+sD10rHKvALkEXHflHPF8OkrfvlswdzXIl1+2KXGGEtWG6+QzZ8Ya9w2zD3fcHTyd
	MPWG0ydvzcru2SbGJXFJaYMYTMaRFrs3yAnBcy5TKsQOwO1T4hrLzJoqS6pEDSakZ3pIwMUk2bG
	dECU3HvoMy3QHp8F91UBw0sgE51zqGS0PFvthlsV4+IkjiOdbLGGv+WUdvJUaQKaJrvGBnf+BoN
	TyQYD5P+r8RZAQhpF1l8Nj4IQsGNG+/+i1QAKAVOPz0DESl7zYNcNZwMapVqrAbrLqKsI0lpOiL
	/QNTmV93d8erhDiYlqGVrAuyO/T6Q1RIzxTX08JZqWaNNWUU/Uuopt16W1PKUbvza6qm2hIoqJx
	mz4sMh/8VBgwFA4SioowtQEL80Sdd3jMw8ncqBVVxt6Br4+vGUkTnmoRygbdzEx90kxCquMBWH2
	s=
X-Received: by 2002:a05:600c:4e47:b0:499:a0f3:9d5c with SMTP id 5b1f17b1804b1-499aa14a711mr219190285e9.3.1787218556423;
        Thu, 20 Aug 2026 02:35:56 -0700 (PDT)
X-Received: by 2002:a05:600c:4e47:b0:499:a0f3:9d5c with SMTP id 5b1f17b1804b1-499aa14a711mr219189435e9.3.1787218555984;
        Thu, 20 Aug 2026 02:35:55 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b80a5sm12285701f8f.24.2026.08.20.02.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:35:55 -0700 (PDT)
Message-ID: <a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
Date: Thu, 20 Aug 2026 11:35:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
To: Tushar Vyavahare <tushar.vyavahare@intel.com>, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 stfomichev@gmail.com, kernelxing@tencent.com, davem@davemloft.net,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 tirthendu.sarkar@intel.com, andrii@kernel.org
Cc: bpf@vger.kernel.org
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260819024443.781764-1-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/26 4:44 AM, Tushar Vyavahare wrote:
> AF_XDP shared-UMEM support in the existing XSK selftests is limited to
> a small set of scenarios, while the supporting setup and cleanup paths
> become fragile as coverage expands.
> 
> This series improves shared-UMEM testing and infrastructure in four
> steps.
> 
> Patch 1 makes UMEM ownership explicit with refcounting and centralizes
> socket and UMEM teardown, keeping cleanup behavior consistent across
> normal completion and error paths. A UMEM that survives teardown now
> fails the test instead of leaking silently.
> 
> Patch 2 prevents TX setup when RX socket configuration has already
> failed. This avoids shared-UMEM TX setup relying on incomplete RX-side
> socket and UMEM state.
> 
> Patch 3 expands XSKMAP and test capacity to four sockets and adds a
> length-based XDP steering program. The classifier uses total
> XDP-visible packet length (data_end - data) and SHARED_UMEM_LEN_SPLIT.
> 
> Patch 4 adds the shared-UMEM callback runner and initial 4-socket,
> length-based steering, uneven-distribution, and unaligned-chunk test
> cases. The three packet-stream sequences share one transactional helper
> that stages replacement streams and publishes them into the socket
> arrays only after every allocation has succeeded.
> 
> Together, these patches strengthen shared-UMEM setup and cleanup and
> extend selftest coverage to multi-socket and packet-distribution
> scenarios.
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

