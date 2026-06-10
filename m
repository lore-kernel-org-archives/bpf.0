Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CF3749F3
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134988; cv=none; b=BRkuXHYVX+87T7bWVSQj9AAxDiy5aN9/UqVMf9EweuRLpT9s2tR0Cc3y7shLb2GJhilGLkx3+0V2pSDCcs+dTLef6D8toPhPZBzJyoWdBncN393Ch68qU0tEtuGjwfUBveNa/EhmB7zvko/FbFRFZffs7AgZ296nPNbaONJDjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134988; c=relaxed/simple;
	bh=JsSFSoN44TFVz/6cV9BMkzX2QhQadkdQZzqFNXNwr0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItieHhubpwVdlwbV/NdZF3Mn7q+AGDYIz+kE7nzO6AEEAPBF1av3044fM0xcKAQwRW9QufzS6j4L38tQHGR3neJaRtexRGWe5UA1t6WONCslATeylIqHlrrdYsVUgF9LDXiN1LeSDQNJ9I+ljjZX4nGpEZtjy+82GEgemXrJo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUJBhkB8; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUJBhkB8"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso4790934a91.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134987; x=1781739787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=an0SgUn1oFV1bun03BprU1b2Uy0096MbOZfVjaHKMKY=;
        b=UUJBhkB8sfpvem76yql6tqKJZ/ehx6KUnAf3EaoOARnr2Ce6EIqJx0/uXQqIEvTR23
         GVFuRlmhrE4XFu+auh6oEcrhhgdbteoEdKv3vLDEP1dmD9t6OcGCAZfUxJWd8BS0PuzF
         R+xhGBLMrm5t3P/TjFMlkeULDS2xozEiHZ4CXkUIPUS8nMvzyCP6BpaSP/YJVy6nS/NR
         RT4nD+Ve2ftWudlHjCXt/7bEzbtSYFUh1DWr9PZjCFNC9HcHiJuurvHLdnKvrgxzkLlh
         cW23kHyJXGkP/Q7PqUrHVhJhmbxXJTJ67ByRcStPjNrWf/5JDD+fZhou+zM3n58hleYa
         ft3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134987; x=1781739787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an0SgUn1oFV1bun03BprU1b2Uy0096MbOZfVjaHKMKY=;
        b=pV+lbOpROzPk3zZy2PxlFEZLCzSwBH5rfCoTpXxUiIG0rsqAo9cPGBzmiEHftrMbR0
         49DZTsXLVjmFweYzCcP9D0+QpLoGPlRY8I7hbrbv9hPBVIbYc9JwYRLfk2snXKAdb8K+
         quZbEErofYtcGRkET1FqmehEkbsVuj327uSGT1FL9ckczBih6TLQUonW2HwvpnXGg0wr
         N87fzWrOsAv8FB8KGB7mIZT8GWZj25Zjf5ewmGOPjYmQpevrG/tGr2TTyUetTwwFZeKk
         nDOJ/uGGm3W0wTKcoAmvt/O+DCHhzivRsFSRL89RFihOXOMYsIcTp5k6rI5V3CwC7UIP
         i6Jw==
X-Forwarded-Encrypted: i=1; AFNElJ+QjTq1qSB1yNCzJZqvas5KvR74IwfGD0aIbDfbbpZ/YxwIVffnhVEn6o4jG3XFqoWlU5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHa5GJeymY5FKbmRRaSHXIUSQEeG0QKkPk9ibhpPIDxqsRv6Y
	8VSP3lByR3sAgrE5joTTslmkD57mU7Spvlbgc7UebwfkLhidYDijma0S
X-Gm-Gg: Acq92OHnWowKcHkoC9cYMeviLC1RPoyEQoo57MrqHtQjoulK/gsQgh47FOHxinwp23k
	VOH5pBCy3nm/YvoqveoppUHOvNwLSz92KHdJRbinb3LTNyV1SfhwiVQGpN7eqHnai3JAQ+tS2Yu
	A+gDVGPe6Ure0c6LReQOE5r3Th2ZJG5+Msd9gL28W7hfnEB5UAqHB4QYrnM0CRFdfM7bxwktVAE
	J4fFv8lGdVVU1ahn2rbCVhFNpy0InbuV0jgY2rGmBJwK4Y0siN5gm8PXsJGZn2hbbBhxoIzijjc
	bu1HfnjwJDGZnl9Vaj0Qug7+VpNIDpnhanW8pHdLeJuRPyw8zP2eF6kbG+iVHk39odjU7+WufFd
	RH4pS3PTC4ezWCtG/ReubhKx6hlFOGGM/HTxxwTxHmEMkfsxlpp5Q26eDGkFqjhB3Ch2EUT7gHa
	bXPikgrZynLJShjRjUzzs9ilg=
X-Received: by 2002:a17:90b:5708:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-377a9194d84mr388890a91.23.1781134987030;
        Wed, 10 Jun 2026 16:43:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a1a9esm495657a91.4.2026.06.10.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:43:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:42:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, skhan@linuxfoundation.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me
Subject: Re: [PATCH net-next 1/3] docs: net: fix minor issues with XDP
 metadata docs
Message-ID: <ain2fMNX27Z-ZlzT@devvm7509.cco0.facebook.com>
References: <20260609201224.1191391-1-kuba@kernel.org>
 <20260609201224.1191391-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609201224.1191391-2-kuba@kernel.org>

On 06/09, Jakub Kicinski wrote:
> Minor updates to the XDP metadata documentation:
> - s/union/struct/ for xsk_tx_metadata
> - document nested request and completion metadata fields
> - point capability queries at the xsk-features attribute
> - fix grammar in the XDP RX metadata guide
> - typos
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: linux-doc@vger.kernel.org
> CC: bpf@vger.kernel.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
