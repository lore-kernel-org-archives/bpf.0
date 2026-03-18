Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0BBE5E
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792503; cv=none; b=kln4dAkZK799/7w+WzErt2BpKOM1M2ecy7jtXk7AGgvhRVdvWtIZzdj1yiT2pWk2VomHXeKs4/cu9heJ/cLqqaKEtfaDK588asAwZeobYAA1wgqavd5HmEn1fAypYx/3bHtcksDaX2f+LgUyAQBkiCG5ny5eQpdBFI4YlNH+eYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792503; c=relaxed/simple;
	bh=cb8vE5HSSq56kcm56PlKyEh4gwh0lYtwbgbWt/bAoqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avN85+EB1XoC0tcsQVNSVIMFsFZKKXPMQMQsw91UY8s2wPqYP4FtxdKGjYpjO2kuRfdFAUFieRF/gb032l3sJz9JGv4wPp2N/WjNl7wM/P8HR5u8RtSAGDmBkLJQAaSvY4Y3U2cX1Ga53eJPI75NLIvQPEAwTO81uHPF9NXSVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoikiAEb; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoikiAEb"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1273349c56bso9794047c88.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773792501; x=1774397301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66d1uFpzzYCPdrNc8SA1GRs22SJbjq+tbh3FLYNMt+0=;
        b=VoikiAEbYz7YDzEx9ZurrTlvtBsB5G3PggbpGOo2tVhI1Zls437fOikSRxq5+nJRW0
         rkB/xgnpOo2N7uBVffghrmR7bBLZPXsi0pk1eXUUyrkGA58zmwk8R4Be1r8KN0t7gWjP
         eDBhDJWfGzFcx7ck4XTK8pvryRpsGracfmKPxDUfA15WPu3N1ol1I132/BqI73QrTcvd
         ZTmLQAjCF0pGpsA7HM4tuQ0NMQGSmg/+Ti2IRbOM66rodehJYfhlindkb0jExiPhuEBH
         LxerTl0R5d8fpitcjfyDnZWuaN1xBe/V5u0TUk8DH4podPB5zMk4qYE4df9Rd7lGyvGP
         O3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792501; x=1774397301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66d1uFpzzYCPdrNc8SA1GRs22SJbjq+tbh3FLYNMt+0=;
        b=BHMcwJUi6HpfPZ2WCnWbcUtQJJJB+UeSllKaxAAFkpYI4brb6ab74ax/tuyZQckYq5
         4tUmNpZyjQZ8BesV2FLOePV36oi3mumX12zWtCIjgckSh+b1K49kVKbC16HGZ7gna2SE
         inBMDSJkwmeLoHwYeioX1+z/Kvmg4pJDZ8w7YY1ORhIT3z+H99zEx/zLev+0RHzMJd+Z
         zdy1tEQoUTnYEMFMWjpkIra9BPtaHoINR3NiTSV2OmmnWmCd13tUJBm59CP3K+NVtZIb
         tJhzjW8ULBt+j+0xPeOEiLl7xXE+oJjOVOxPm2wzEmoGJ28yM0uTG89Mu79+7hyyWeit
         pjnw==
X-Forwarded-Encrypted: i=1; AJvYcCVNNFhNil/WD63Dxoir8nlHrHGLM0Jl0ndo0MT7Rxkv/RpSIlzGiu184fku31L19qnbmXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxab4zSud7gpKdBLXdc9ERryFqKTTiVG77mXqGEYYOjPji4IlRs
	UV+BwBAJvfAR3SsFQM2JrPibHwJ60n3YwJhqOa23wAYFIPE7B0SltCI=
X-Gm-Gg: ATEYQzy594AveFsMpZDdkAIUVUevpX+jayf5PyvoXPzV38rHW6WQtcAqJWmk0jb7OzZ
	RcgUXB/gLBx6oR7+yzy4SmaUL5nvSbztzq2lG2veTODIaTBVHWcWXEWZbz/YGstT9eMq/SbManv
	5JM48wdvQxOTUp4ozOL5hhKeLu0dAL8iMxCs3zTiTZpySQbaytc3RIPlGbZbNpBbHRH520M102s
	5DZfhX5e8XN/eS+K+JyoSRP/RBLX2C6Y+qh98UxAtC/X5y9VDmvtKtX5pcR3airrk5mZyrARHTw
	odOieg4wdETyJIHGGvcPG5VAqLhuvl8/MTn56ZcszpopxRqmfHOu3J6Ov+Xy0QwWK+Q/VyTJt+J
	EPKTXS+cG9q5lI9/BZqocR5a+IngYBQoJtFkQCgQRoMbaI6N6AA6OrkcPzeFun6eP6AZrVQ7QT5
	I1a5RmSojqXfpfeKgQKtFDVJPIZkgtxEG4hxPjgldCGKp3S8reDflEcvsqimVlkq6nzgg7mhPNt
	qq8Ca0MzeVpKoNd4g==
X-Received: by 2002:a05:7022:6a5:b0:128:d471:8c1 with SMTP id a92af1059eb24-1299ba3e555mr676234c88.17.1773792501230;
        Tue, 17 Mar 2026 17:08:21 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b4127b7esm2264454c88.9.2026.03.17.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:08:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:08:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abns9COj7WagFtZ8@mini-arch>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>

On 03/16, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add tests for devmem RX over a netkit device with a leased queue. This
> is the same as the other devmem RX test except for ncdevmem executes in
> a namespace, binds to a netkit, and skips the ethtool NIC configuration
> steps (relying on the test runner for that setup).
> 
> The RX path is setup as the following:
> 
>  RX Path
>  -------
> 
>  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
>    |                    |                     |                    |
>    |--- TCP send ------>|                     |                    |
>                         |-------------------->|                    |
>                       dmabuf                  |--- BPF redirect -->|
> 

Is it too messy to parametrize the existing test to run both with and
without the namespaces? Feels like should be somewhat doable in python?
