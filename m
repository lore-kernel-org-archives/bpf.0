Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30223DBD4D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327146; cv=none; b=OMf/dxe0pD7/bEXV+KWUiHa1jfUJ90feW+/qGUbQf+zVhCKwoElRxbBttT9nadiNlTTNgYy2T8ZBm/dBpfssBjGjAS7mOAejXV+gAQ5zKEIWtaxOSM2t+BOAim4c5SC3i9ZkWajLKBlrBlY+Tddr9bYmxG92ByAcR6q7mEAvGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327146; c=relaxed/simple;
	bh=PQO0UZwXLLelrITKmhXhC6F0znNCjfRA0kOIy5ZvCNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrnQSgHl8prQUpxIyoiyQ8+BSgw/8Fb7cl2OZS95Z20avktyVAbpkA1tVNKxaYo66gu3g5WKdSrfkAq1o3MB+DJb+6muyqDP0TjNVS7MEcFOQIp2JMN04b/qABwkk9KL8hYzDPG0kk84JWekfIw2PVVVg8DJCa6lr7oYvcf63fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr4tGw/Q; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr4tGw/Q"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c0c2a68d01so9886235ad.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327139; x=1780931939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDR/0d6767AKXu4Gbp+1FbUsOAvR4r8bVucFSVBkYL8=;
        b=gr4tGw/Q/FhooWcObcw2/szyDWZ8wkK15lcn36CakQOjov5TyO7oxkusGhs6mV28P2
         aQF0CjvkygHGfktnoQHH1oXFfKN454R8r7FWVdv07qtQlPbVu3/BYzmHLg11AwElZeEh
         /Fl45gYCucHNJFgwYHWvS1+tGN26C/6n/BGrihc7LCThEIFhA95T2e542MQg0nfDyQQ+
         geWuEeu052TH5vZFxUdlUxlYO2OnqhvGINOpJYVBJ8SE6VNf23euGXSo560TRRQGfh3/
         nbwFNu1JZEe+rI4yio0SVgxyJYkvSyIszcwV8yK2zuUFVn4fekcgjLT5sP3u1OLu9Lai
         OEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327139; x=1780931939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDR/0d6767AKXu4Gbp+1FbUsOAvR4r8bVucFSVBkYL8=;
        b=ZD3EgMMv5xbLVG0Kb2gAUyaxybBlnQis8CmydiFypXYzIsdjYPE0CdrTVUz4ivxB4X
         9UnVaYMET4I1SsRAGLZP+NhFVIXcpVzgm84Gl50hshrJA/zYsxR8hlzB1BTEXU/s7eW4
         oxPMs/+A7Qa0NwO0RkV3dMDrnVxAeSDwNi+Xpn/6PtCHBvZ+K/l/Q5JONcYm/UqqxtTC
         vNSk7KAob5I2CnMFUZMUH8GVYAW9MsGyqdZ28K15u/xj+yDHoulXJly2bDEoOhC4sOM+
         B33kHvhe5hfNdtW103bQaFGZtvNMvahGQlkn1+WmPxJ2ZufSk4bjyX21yVx7PGQAB4JT
         nXgA==
X-Forwarded-Encrypted: i=1; AFNElJ+vQQ1E5QFoT1mHFEu6APCOWU3+czye2kYOgZRGDhwMdJ3HoffvtLhiaVd+mhi8SHPTQJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3GGC9Us2rg3R4lq/gXwmHvcwIgDlSegY3kNLZx54d5VAg+FNx
	2LSJ5Fq3KdbWJsQazxU+ODxEg111f0+5COh96Iuna614lAS2kQ9jJ44t
X-Gm-Gg: Acq92OGPjWYqKUj2CgYmf9YeSQdh3F9OCdN/6rwI0gTzq+nr8Po88h5ybWARxsoAM0I
	7p5vaniaX1kCRPvexZBLSNzSx0HOjBDgeGSKKVaPwrZAYVqxzZK9J62Wu2aC494YCFo9hXye/ui
	07pjmxQbxMxmk8XM9QxuoVuU9lr+MahQgWD74rwukn4+5HKoLwCRwFtVQbIPs3ByUZsWH/gK0d1
	OKdT8qy2MKhl086+AAELUVhPdVGTok6yHlZoQeRg4KWjcxxZ32Jmu3I+BziRthbrU5pZ+HRsydc
	s0SnJd6LcN5Py1kCSoDaogkf8lMkV+hVMskaz/MbFSxD3qllzi1zNNs0SErONjV4DxmOZP+eCMj
	JmwcSJD2bQasH0CCq61dpHRoZ0oO8wfi1fnWFiyF/UhG5ETNnOEOu9WaRFPm19TTMP5hhkuFJNk
	L/oFSEsYxJfZgpUsNeRMQA5HnYwLc=
X-Received: by 2002:a17:902:e54c:b0:2bf:2b84:c207 with SMTP id d9443c01a7336-2bf3688e46emr142931175ad.35.1780327138899;
        Mon, 01 Jun 2026 08:18:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b01732sm113263525ad.54.2026.06.01.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:18:58 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:18:57 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <ah2isNZZycGgMNOv@devvm7509.cco0.facebook.com>
References: <20260530042630.80626-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530042630.80626-1-kerneljasonxing@gmail.com>

On 05/30, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. A malicious userspace
> application can race to overwrite these values between the two reads,
> bypassing the bounds check and causing out-of-bounds memory access
> during checksum computation in the transmit path.
> 
> Fix this by reading csum_start and csum_offset into local variables
> once, then using the local copies for both validation and assignment.
> 
> Note that other metadata fields (flags, launch_time) and the cached
> csum fields may be mutually inconsistent due to concurrent userspace
> writes, but this is benign: the only security-critical invariant is
> that each field's validated value is the same one used, which local
> caching guarantees.
> 
> Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
