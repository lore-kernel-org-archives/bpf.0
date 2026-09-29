Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C56468C3F
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697504; cv=none; b=MghL+3MNWSBSscPUZl3MAYGaGTOX8qEYMnh7A45BBTm4UJNADfcSFL/Z8IhqK4DZfiBof5vnYx2qp+mLytx9XUFO8J0gNUfBIwjHQJ9tIOheg3Q2Yl2iGIiZGhvxf9KQ2v97cipvh/PzY9zPMttk2ox8oJgh4zYgK7bTPOd28So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697504; c=relaxed/simple;
	bh=nR4yrTOIgVgspvjCPgKKmvkm5cZCrViKQN79fpTorck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQGnW1gJloY1pbEPWzCYCd0FU/AXn30hWIkU7mJXnNjDOnIfcA0B8cBMBKsmnsA0dS0wiaxjk/V4uiX4gdR/XetFrnigL6rVsvZc8wrwhbTt1JyxcmMuE1VznSPzjDwtDB4l+Gc5ApwR/WIWGUEHYlszufXuCYfHfbBLFHXB6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TGjFZgg5; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TGjFZgg5"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so41089225e9.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697499; x=1791302299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=TGjFZgg5lUHeZxukRtGDBpWWXiPuev8gp7o7FIX6qFXoKC2EajqRD+/ExUDCSfZjoC
         i4OrZjFiZGSOtA6mpUM4f/v/zeZAXWCL3g41cedVNWBPRLuxv+9Dd+SWUiKp5re4pZfU
         jJ7hvCUY3S01HlnQisdD/KK+9JhEQayTnTWsXyOQs91JsZXPSkOOZZ2+4l+vktxu61vb
         8w/OE2ayTWQXiV2FZWNafA6HdPrYCAqgm4k0PQXdk1/Vwauf44GR+0YcnVQSOaFVxjpB
         d+/mHzpjlC5QOs1jyDU2SN5c6YrW8WpQYyg2fsMt9DDG51eS4rnjRbgfKV2Dql7KmKt4
         ocqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697499; x=1791302299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf4CL38l7K7zHB2Jr75kV3VIF1+DE+Av3C/FhqhlLqk=;
        b=IBygo5RDKJB8hYhE//QMaBwPBMmDFd9hjoWHVEzsPkM3mCEDZmfvpNZpTB/yZv0kLJ
         mDQK266svfO5wMtI1MtubH8ux0WcfEFHG+MdQJ34jA3sxtDnG55c7uuJ9uQHVrwT3Qlx
         k4/VvRe5T6R4E++6BNEjpzy14d1v5mJHNEYfU38XQ3zbM4T8az1PW8fN8JQ1/N/QM75p
         gOXdRXe32YLzklvTKOqi1vBJL564tXduAoX3btliJyYWDB2nZh1Z62dKbK2FGSVY+E6D
         WBJZpeG2+so1KPWv3m65agi3OrOvnw11Nl4q8QTeezoo+uaWWI29ze3whZZt8X+BY9nv
         Pv2Q==
X-Forwarded-Encrypted: i=1; AKwUvBydQ5+cqqC92G5upAjPvyEyf4E1K5Bnd1MOZ0Ze7xn7sDJsB1hu2OpvmnF2OkTyZXQvLkk=@vger.kernel.org
X-Gm-Message-State: AFuF++mAD9jWCRnq0TGeAFloa7FzNUrcoVvvk3ilisAjgfzRvlaSfy9u
	sdHqUjQ1uxBP3MEavYp2RleTXUtw8+TGjvVlJY3KkTP+gg13S8tF/fENJaXzPL4GZW8=
X-Gm-Gg: AYBFou2Gh6fw8YJV1SPkopNCA3MnCWywK6+Ya941RKB430PTEtNpJJt7V5Q5CWuYhOu
	ehUn1jvHZnCTJic1dMVjbq5W5iFHpnjy3pzfQDrLRD8YO/emYzz9CQ5CBoUlDkKw1Gi06IXOeGK
	6HeaWewtKX7kIMJh4Uirm9KfPVEUrTMjKbKYOtVD+Pwz1ORKby1QKh1tcBqoPVqXzfMUl58P8GZ
	2rkdSIxWxZ8eQv5b5flK7Cf0Mx/lab4djRp+VgQ7vGxpA2EnU81IJamgKifBJQTUcRbVaZ4wZzm
	5VoMEXW5etPMSr9H1oyPeYJws6Ws8KYmgsGl/F/+xXNWPGRSoL7OAyHrCXd98poWpdtIyCe9bKB
	qTSnerWuKL3pvRm964zLvgrqFOEAp/xYFV4Gjt5ZFSCcBR3vhc3z9ZVhC6+2ZtPSbiLrxxIH0n6
	AhTnUTQFJES58beujvsNvRT7Kp99nz/31SIILDoH+U3hCq/5B2KYITbX0rlH/tCfqGAh7zo4yft
	8oe
X-Received: by 2002:a05:600c:1d1c:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49fe66c9ae3mr284330975e9.3.1790697499193;
        Tue, 29 Sep 2026 08:58:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dfdbsm127631095e9.1.2026.09.29.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:58:18 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:58:16 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
Message-ID: <arvf-dEnIzsXhzkL@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:15PM +0100, Lorenzo Stoakes (ARM) wrote:
> There's no reason to export the symbols for these functions which are only
> called from internal mm logic, additionally there's no reason for them to
> be declared in mm.h.
> 
> This patch therefore removes the exports and moves the declarations to
> mm/internal.h.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

