Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5068374E9
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762746; cv=none; b=j24w3t6unYtsOslnNsFG1S++MZErLMUM1SwOHDKJUhIJ04Qq/K0OnBE30WwkgeSqhFQb70GuVhI4oVa15ZsHDrA4VnaRDW/BgtPtjQ7nQhyaMS6rxtaofieW34oMZTOT/qo767twoLANtZi5Df0KErW6uZrv5d2KwH5gNL15oqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762746; c=relaxed/simple;
	bh=0BzIfye21/bWosXW4BcFFyrAHwpAzD4F93HfAWpMzfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duhNBR0VDCxaw8eTiLc8PZPDtTvSm5nyJBVpxc2zWFPqMxhZJUduVNBPQwV/bhzPSAeW4d7cDnDcLzjrO6AfhcovgF4sQxRUiNpo+QTiIdRYg5iPoQ/GAR1BRar4eG530yAr8yA81PJPcC5SjMlq6yHJYhK/1iJNrpdIxkTuPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=keKuT7R2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="keKuT7R2"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466fc8fcccso506161266b.1
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710762743; x=1711367543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BzIfye21/bWosXW4BcFFyrAHwpAzD4F93HfAWpMzfY=;
        b=keKuT7R2aTZsDwHamg2wpevooc1yj7HpY6a78eqEGJ4i6l0sYR0d5GG4WjpIfCyTfl
         GhEmSAcpoCR6wpJGf72W9XOt1aqooc2vflR3GOyGGAYFb5pUk7VbnH0gpcpgCrrmWLqR
         JskxTcgWKO0rs+dv2EE02Pa8PUVWmdnYj1Fy2Hi5rtVeqs+vPpJoklS6m2rMbFPsFSle
         b7XqygDebR4rzvTxKStL0dwcAG2gJXWdYk4AFt5sBK792MuPiO5PQ4uWWbK40SWVDSJC
         9qMaCNnDWUalyvDHEfhkeAid7pIbwnIVnqGveU3qKtzjwN8lM2YXpaowtWW0bx29ePkf
         xg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762743; x=1711367543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BzIfye21/bWosXW4BcFFyrAHwpAzD4F93HfAWpMzfY=;
        b=KTLsuRcZ3oqrMqDTMtLC77tuP2TpFICbqYO6g1Ct4tmN/w8qd9j2i0lcyEPwgUhy5a
         Dq3j6F6vMdImuxl01ZTWqKN7lizpYQ/+6wFagX9CJqz8YxNb510Q8SH5/UaASS1OPn+x
         kcjGsKH8S+yaiNegI8TYBDPcz3aXFZ3JkCpsCVsmDobmJlESdVP1uZ5vuRR3gooPGuOP
         qxU33uPcLLUg2Mw7Nl9Dfx0XQHntEjjdnDWGwk/kH3o+7y/y/wGFYmIjZDIvnrFKmNLG
         8xsKdUXkMxPe50gpp9vtiO2U7pg8v4c/jqhwBhibYcXS7sAFtIMdkNnhK3GwGH8WXxgm
         /afQ==
X-Forwarded-Encrypted: i=1; AJvYcCVelrEMeqQw4a41ljXQRf2KDaOOSCtIjE0Fvh7dvSe9eImcVJsCXMtYr7hpBUM0FimSdojza9orFgqY8UjADzUpoCFk
X-Gm-Message-State: AOJu0YyLbJoPok9Xjzs9QnfNB/c44Hl8/wmZlZ7fqDGpA2AqHF250wSB
	jTUgO340/KqRmrJoCtRCpKXAFH6oal+io2ebwy59rB2VDvEo9yQg+t0QTSeIlSo=
X-Google-Smtp-Source: AGHT+IGH7Az1fjV3uZRCOp6EukepU1Xx4ebVyR3uACiFNu6khcE9tHSFcToOJxhD85O+9LXpwZzJBA==
X-Received: by 2002:a17:906:5ac5:b0:a46:cd44:827e with SMTP id x5-20020a1709065ac500b00a46cd44827emr752259ejs.73.1710762742845;
        Mon, 18 Mar 2024 04:52:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a46ce8f5e11sm311953ejz.152.2024.03.18.04.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:52:21 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:52:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <Zfgq8k2Q-olYWiuw@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>

Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>As the spec:
>
>https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtio net supports to get device stats.
>
>Please review.

net-next is closed. Please resubmit next week.
