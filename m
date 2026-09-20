Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623481C84A2
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789900172; cv=none; b=byZaLU7ED9ZcWk06gfVtNUup+WMSmg7TVgupmhODHb7J5vJVPNbevwgyGA2vIupM743nmwES/6Kj+tdNw/eHs0+UPlysQYqgz4srcVP7HWMC5n6RFacuwrZjeCkPM57CJXeSba9m8CzLsCcVnD+me2/tlwLgWCwRVMMeWXyGOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789900172; c=relaxed/simple;
	bh=4BQzVeanwVtXbuFPAfnsnMd1d3bi+yl+uv6Kg2oGZKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3tkeeYFvQZqjYI+YKVzC2j29qrYCV8hGekiBnMSByd0alD3sGiJeZfz9JxouGOS9sLHbSuj7stRphUO/O/sXmSLq2eojdqOsc7QCVHMIg2wIjKKEYXjYao1VMeguDoIG1hcdtzOLXYJs+kw+iqMzxgGhDspCKexHAvQ0ps7heQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl8DSgqV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl8DSgqV"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so18311355ad.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789900171; x=1790504971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8eOaouCq4BZ2q/2gl/vLSyGwMVXimj9oVClFLBXxtU=;
        b=Dl8DSgqVoU3P0YI+GebN72zguYlXcnRF8Ybq4+FtIAFLvtK85Bscpx61Hpp27QVKip
         4bxIqF8DMsy/SptQz5anx7wTojmTBSXGR+ko538YVvd6Ks7cp14gw7G4cU5Ue6lrTDes
         whFS8afyKW2jSMavW+UTQsnnTLiVWssQD3UCpJdF0EwEBfndFa83A+h5HpcLHVfncDdG
         iPPVsvOumeY3kuK25sai8pmq1x2GwnaRmI6f0eMcQ3iZZRpHfXYucFjAUwu15AbIdzcD
         oHbzQitPK6RW2WzwT6xuajA9aTCh98Iaa/U7DbuIetkPWv4i46fCUBNerRmr4dOaoBhP
         m9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789900171; x=1790504971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8eOaouCq4BZ2q/2gl/vLSyGwMVXimj9oVClFLBXxtU=;
        b=iuW6p3y4C0WXTtFExsyQjlwewU4VD4ASYYW6mX+5EQMenw00UA4jVB6ws6guyJzymk
         fAqInl07FlN589UPI7cWM23uVCx0bek+XlwrePhxMbghDhsVG+y7DZ8gwpeevYi4mKqV
         0IXf/jz3gumQWPhwDqejOaN1RMq0+evo6+eXalrMyh1l3AkJTyFvrn6rnxKEXmQA3HXA
         78NaNvCnUmqbMh2EZeRsBNXZdW0ehcWvU7fqBue/Hx1ZXWAtJMx4bX6ch3Tq1SmFFqUK
         muB3hqsQBi4FexPncgQy0lKE0MqhPZHqeO4+Y/GIF/uA2WH92+4A1+niXBl7TfHUdvhK
         NLEw==
X-Forwarded-Encrypted: i=1; AKwUvBwe2YctV6yJ76e8DiO8lqS92gq5jEYAkDNr/CgZbrtGmawHgVvAwfU2Rl2QGQY4/rxnTlY=@vger.kernel.org
X-Gm-Message-State: AFuF++kuxNPD5Y/c5q5WjoOnCVZlEu1X4cfOZMuT8aXebb1xxeVTsrMO
	7G/PNn8xzhdTiIevChA4Ve9M3Q4ByGJMkfoyWW1r91tpyJB3+YjhXPw=
X-Gm-Gg: AYBFou3Zq/DhO4IqCSqxIlTigcHK6w8jcVAsczJi3CcTOxO/YcquFmtwusIThb5aBT6
	AkhEHOC05wD8z5rv4RQTLwnEYk9yQpwKuf0AeVNBFAV3b5EtFroQ9e7I0EltIwlMU6aHjiHUF1M
	xeVh736/o08ZuDMpNVIRoJ3WoMYSS40/Sqhu4GOjekt3l7azacyCEBmyMVcmD6tB/0IyUJuETwM
	BS58m0cQScx2I6Xc9g5lKO071Ym/I7Y7mJDmlHu07cQe1UL535jSTQsK2j52tOW9gpHpIkJJvpp
	f7LVtE1tjUkPkKx7WnQhmwQ9zYfBcV3cgybFY8qliSDPhc91T8HmC8Z6obPNYAsQaeCrpSHE42c
	la/TEoCnvzb+Qv+VgopJgcfEm41gkz8NgrK841JIPx38qOhILoLZdTqjH0m6fA5+T6Boti34+Go
	xa7bGU7+xJpouFAH2N7Y5DepbEIbfX3vCpHBCC5lI1pSgaHAxd6xh3W0pN6ERg7/eN64q7e72pb
	jf+RZCP6I90knwvDKeWXWBVnLs=
X-Received: by 2002:a17:903:2349:b0:2dd:c100:b2c6 with SMTP id d9443c01a7336-2ddc100b360mr62001525ad.49.1789900170830;
        Sun, 20 Sep 2026 03:29:30 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17da543sm18500155ad.69.2026.09.20.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 03:29:30 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	martin.lau@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	mason@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH bpf 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
Date: Sun, 20 Sep 2026 19:29:23 +0900
Message-ID: <20260920102923.445964-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <eeaf9112a1ba86d1cbfbd5287cc67bcc13adb07861cced93eb4c51167758b3fe@mail.kernel.org>
References: <20260920093153.439743-1-donggeunyoo.kernel@gmail.com> <20260920093153.439743-2-donggeunyoo.kernel@gmail.com> <eeaf9112a1ba86d1cbfbd5287cc67bcc13adb07861cced93eb4c51167758b3fe@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 10:19:00 +0000 (UTC), bot+bpf-ci@kernel.org wrote:
> Does the block comment above this condition need updating? It says the value
> goes to the "current one" and explains the whole branch with "onallcpus=false
> always when coming from bpf prog."
[...]
> Could the comment be updated to cover both entry conditions?

Yes, it should. What is there stays correct for the !onallcpus arm, where the
value does go to the current cpu and the reason is the one given, so v2 adds
the second arm rather than rewording the first:

	/* When not setting the initial value on all cpus, zero-fill element
	 * values for other cpus. Otherwise, bpf program has no way to ensure
	 * known initial values for cpus other than current one
	 * (onallcpus=false always when coming from bpf prog).  A BPF_F_CPU
	 * update also sets a single cpu, and the element may be recycled, so
	 * the other cpus must not keep what the previous key left there.
	 */

Thanks,
Donggeun
