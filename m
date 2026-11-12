Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442995;
	b=dKYS9xvkiKXBgFHxVbGY2a0HH+Z3xNCKjh6TV15ystZBMz2hq5Mo43LkAJeFn5vkey2J
	 0thGUS5djWdAJoPXyJga7IiTTq5XOHtBIBL+g/n6IOjGpGY/2yvxFhwtbdbhsSfUAl4jy
	 fdOyaS0hbFlTmzlYZyq2svSqs/rvIn9BX0lZMpaltUhWKZOzhnvDjrgfLhDZhKx0b+SC3
	 TybjQ8SqviCRcFRfF1NyGS5eJ4y7d6CpumpdEWFdsoB2m/yN8IMnuaaGP4UXMfk8bN6iw
	 VNvFflcW+3p6foinHiHXBkBDuoNNb5i9+sGb2BZhm8OrtVEnqPY2XAOplGUss39dr1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=rPReUu3t/ubDPUia6daCimelDjDS6mqfi/IOHqkQ2l4=;
	b=zh4UGOxuirGvww/TYlO9m0yaBFor6PF9ZFy+viUsOpusDQ14qQp+mYiqwOWHy6fEF/Rz
	 GkOJH5jSlIpbCPYENnloadZfrTKrEORqB+5BWFYb5p3hiJ/V1shUL3rBzaWCnD10JEu1G
	 m/RCz+wQm2F5lAfXH4WRhF1v1mDOnLMBH8knGJ/X/yoCjuSYlzO11ihk1JNdDyQpxLdKv
	 5IZzPXi61H07yRCab0MCwj9v3nEblmR3jd/re1nlgjJa+ak3Zly1tbd02uCCVOFm8cCyp
	 0ffaBPeBV+d2ml7nFGh2HG0Aq09t3Yl/Kv+MauggXRlxv5KLApz7/8l5xgpFBSQCfKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7xRkkoA;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53964606A326
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53964606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7xRkkoA
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso1365067a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442994; x=1795047794; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rPReUu3t/ubDPUia6daCimelDjDS6mqfi/IOHqkQ2l4=;
        b=J7xRkkoAyhBAUqkINVdkgP4gkBHjYHKAIlMJnz9Sq+RTrBr3CADSRqNA+i41R/7b+W
         nQi+nkYfsSXlRNfQ9otKDvehTvNl+4Zqr+KqHoIvTP5mnNmRGszT1WGp4w5FtqjWoCh+
         Kf+RdWsXf+nw+0jhZhBHb2qlJ2tGmBMQm4jHC495Uh7hK/TPEnoGD55zqWX7Wx5ELPt6
         efvq5mjdlh/rUzaEWKssNc6D8Wrb0IiA4puwiuv8rMnZ3qldNXqHyeHacQyu9ZkX2/ad
         FuwgS/kVRVeGaOYhGEZXqc1CJnzOsMZmNp7i2bNxXRybDmsReWxKiNEbR9+UYvn7TkS0
         N/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442994; x=1795047794;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPReUu3t/ubDPUia6daCimelDjDS6mqfi/IOHqkQ2l4=;
        b=RGd7OhQKKZZkoDZhWJtfNLeFjlZ1WPHPRYd+w9gxzH3WR25kbTNPDEMhp2cOlz8ddu
         BNlyVmCsIro08laFujbRF76Om1FHCyqyAx0XwG/+FL6ddTUzfiddQwbCXqLVYDigDWSt
         +Ray43oLcuA5f34JxTH4bZOdynOQZtnaZN/IYHbhv939jGCmESxnLcjLEzU1Xx7BcmuK
         gRijt4zbUgOvIsPVoabh38t2Cz0mpmQQqGCONqcQsYbgp8BN47R+HacYjse5glI9n61b
         ltZgNTsQRNU9B/vwBQavM3SCcz8pjPTaxsmpjufOWLlbYh2mWrC+/y6OAWCkX5xmguQ6
         lmKw==
X-Forwarded-Encrypted: i=1; AL+hErEMGH+iaKqR4kfo7omaQ1CdeBG1i1LLerzDIAPSNSIbWoJ0PDDftjo/3tOKmjTzzy2z7CM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FEZl8Z4uvhP+lUidXkRICOtms0mUn5+odW8LLpAhrBWBim99K
	rFCdkvQhXQjs7lW0WOERAPrE1SuZhGqOqI2OHW4Jo3W2e0rOfCNoa4nj
X-Gm-Gg: AYBFou2my3al/Cg/R9IwDSej/TAZAct/H0lpgM1Gabyh9cGwlwzFelghzPllVo1r2Hp
	dQaa+6rf50pidpVAOFLjsTJG5Y6rJpwxVhxh5KtaQ+JHEuW+6NLwn3eiUIYhrUx+X7NG77d8Kj0
	nH2v5F0YUvc+0sCZR+dNarADlEWiJH+EqdRHoXk/L2ov5YPOLntukpimbEExeI8M2kaA81HFj2Y
	9NgNqd6nH1zUDym/cZk7ylAAI0PJ0zNbdsQe8j3YLYfEB7pvKKliwJaJFQJk313eFZBgyqI9egh
	RsbfNM8uFH45AvokgxcByU9W7MAm8SVoQiFWgFqFKG9Hqm0rcWF7OYkFNWLUR3A5fnlLZtWFiFm
	TieED8wwPvh1cYMYo+u/KqLgLtaWhitA947qjPC/kKQuLLnTMX9Jn3XA+ZNvShYSIV01aQtiyVI
	Ow1O8nMVkyWTsqPuiqlA+2wT5fXV2AHHhvKYms/VlDcW619Pghq8mDMHLH+xgiyDZ7deYKzfeuC
	bnYwhX2c4WumLiua3N+YHJdE9C+lGPQGaY1YhDu/WXN7mA7OdOQRCXgQuobPBBOrlJaRnHcVeO8
	EtLJPUni2+jq1nMxCuxm71l3+8MHhpqnlzuhDiSztPXv45BpvUaBm+usgeuwGJ85Pys6bYM/F6k
	fGahdXCEA0mlBjYtot61UOvIYsP0P3ta5+A==
X-Received: by 2002:a17:90b:55c3:b0:3b0:ad42:dcb3 with SMTP id 98e67ed59e1d1-3b182eec120mr3269580a91.14.1794442994313;
        Wed, 11 Nov 2026 16:23:14 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181b9419bsm3003238a91.0.2026.11.11.16.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 16:23:13 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 00:23:12 +0000
Message-Id: <DMSSYAEKE9XD.Q3C9CEHH7KTL@gmail.com>
Cc: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <stfomichev@gmail.com>, <pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
 <kerneljasonxing@gmail.com>, <bjorn@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from bpf to net
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Maciej Fijalkowski"
 <maciej.fijalkowski@intel.com>, "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261111155748.11b92b7b@kernel.org>
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com> <20261111155748.11b92b7b@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 03:57 PM Jakub Kicinski <kuba@kernel.org> wrote:
> BPF folks, I made a tag for both of us to merge / pull to avoid
> Makefile conflicts in selftests, the original series is here:
> https://lore.kernel.org/all/20261109193048.1006986-1-maciej.fijalkowski@intel.com/
> PR text follows. Please LMK if / how you'd like to proceed.

Take it into net-next.
We don't need to take them into bpf-nex atm.
There are no conflicts today and we don't plan to touch those files or nearby.
If selftests/bpf/Makefile conflicts it should be easy to resolve,
if not we'll pull later.

In case you want to add to merge commit:
Acked-by: Alexei Starovoitov <ast@kernel.org>
