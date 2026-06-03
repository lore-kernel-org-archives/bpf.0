Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB13382F0
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497032; cv=none; b=V9l2FX9DsJZsbXm0b1SFz0YztjMi+jrp2qtBt7meopbZNR6uANlDNvTKD4xYWT4Sr3qemp2OOoL9S6AshSs7ww2tI9h5uJ5dW//H/7xlQXZ0VgAMkcFjzF+upvD6ta0/XbIzjp2b3+Bam9Bq2FyKD81BhW/iRPxO7OJcM/MK+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497032; c=relaxed/simple;
	bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4iQ3xZaGLIZ07KIbXIT/N70DiCpdZNNBjwuVdoFnMUZds3nUqG7PSks/s+hCT3qMCncvtTnZqXIB3cAVDViyrR7w3Ut/GeeZ/eDy860b44D1shlyjW/SbGbKss8KmcgA6ZRX341e25n9wClP0MTbAxnNP6xqlTyC4YC6m+vHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ul1dYI4d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT56JXR1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul1dYI4d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT56JXR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780497029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
	b=Ul1dYI4dsWLbVtESBjR2mEJDX3aePYAnmC/1ag8oujN8JbaWvxJdKXPzHSIXwjrfiWCfqN
	d/ZvF2Z1F0EuEVdlesOjRGAnpAMTzsrjAwjxeVRu+P6/730taCMZbs/uAFWshuO4G4ctrx
	MtcdaWJn32mJsRwfKNa3yqHTZUbGuqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-SJSZgDjmO4Gb0C030BPuEg-1; Wed, 03 Jun 2026 10:30:28 -0400
X-MC-Unique: SJSZgDjmO4Gb0C030BPuEg-1
X-Mimecast-MFC-AGG-ID: SJSZgDjmO4Gb0C030BPuEg_1780497027
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso2173639f8f.3
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780497027; x=1781101827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
        b=iT56JXR1fVB6SWdXj9UxGk6uFJRkNrv7dnClHjY+u3mj5xYNevXwpv8fh0xEu/g+VQ
         oTIYZpCpPt5nQRI7heCmasrST8Vb7jJ4rKYsgMnrQlq61wVrpkax8JuPbJIDJ2hyMLBs
         tj8m3LavazNKNusl1WQJOd9d+W/HmRrbxewqT0xwgaNGjwPX6NjqLjIiszKerQXOP17J
         Kf8/Hw79nocsl+HHb/ZwvKjLk8+CCmyMMQqB8Qc26UbcXmtR3tYe5ZVfesQkxi3qCLs2
         B9nh+rCdUHQn5Ju1L8mCkvU93D652ifGRbK4vuDaTlCRbNmiRv8hitTjHLipZyiFBXwH
         cIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497027; x=1781101827;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9jDEYDDCN5zeho9H6VQCWpzCUKBDNTPbqQDHovWhsmQ=;
        b=KO1jfbBggUDQnM1BWayYEPCAny0D3OXGKNp1DM69/n2luiS4x2W+oq5kMoCdzgqmxj
         9B1ngJRuaEgITLZF+3mbxX26c6bXRZALFJbonjWyPo4ITOtMAbDAF7JTTT1cXqLvD7PP
         lt+KPCKWC1u+SKG1tOwfjWC52lSXL6eGaEyp8bqBn+LshUjVxj1JeCpTdjOeh6YO0jCw
         ncdON2LOnrIEk3ZG13un2BNqQnj6w+fcH/l9iTsoWvUqr4Vn3Q8ZsHwf+gO8isXwH378
         I9QQ8g2flKVrTbatvr4wN+Rggqubw+eRUEHDc+Ubi/ZrmgmkVAPGpGAq92aINSQ6iai7
         sAdw==
X-Forwarded-Encrypted: i=1; AFNElJ8Kdjte5piZaY6H33B+qMXhH1CYHNYC0hBhvbmEibkunc2PzDcFoKaAE36D0tOyFr1qIO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcL8BXw2JcbXzJMIE/c93KAkKt/x7F44Qkq569aZ+aArOYLmwK
	wNvvxoY8nNz+WsiN4eUK1ID2d7GkZ/W5Yqblo9/8pDcOz1e+rsoNIKcHKfwWhJYopB54XDn0C5j
	84TNHCuhqzuIEAmR/2kIqG8fV0X1JJ38KjEZ6HwRUC5Zdr6khsr429A==
X-Gm-Gg: Acq92OETJUB63Uc/xr1E8tqWKqTKzUGcbfAzCpsTpHDOIysCxM4O1W4xwAk2KAtLExJ
	ctxyS3MT3F3A1PxYKJsFIMGIaOK50EZk3F/bxWdmP5Eb2pletvp0sVCAcCm9Kz2FAUMQpCiShcY
	Ru/fW8xEpC9aqMhJRzcRmWMQX83YBER5ZgJWN4j4iVR8poy5/IhHX3IpzcUP8oLLdqtQvb1PruC
	TU5ea/E6/6bgOrsfJ701H89OLkN0Qk5z6+2Foiy5+J4DgkWd1VVgBXleGDoZ+RKz/PeIJJHF1+S
	QqIiVuOfuUVqOv7o135kJidusrVH+WQI96MKcyLKq9uajOpeNdCq6mxADy6mFiDnLFXlTEVgvQ8
	Y3otCUUyLbrVo/VbAuMgVgD9GxVXN1wABh0Ay+1j4nZr201MF4kriMbQt
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr58334525e9.10.1780497026600;
        Wed, 03 Jun 2026 07:30:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc6:b0:490:4973:91a0 with SMTP id 5b1f17b1804b1-490b5e950admr58333875e9.10.1780497026156;
        Wed, 03 Jun 2026 07:30:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b60f6d5asm68311455e9.0.2026.06.03.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:30:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E15C57BAEB7; Wed, 03 Jun 2026 16:30:23 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, liuhangbin@gmail.com,
 yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
 zzhan461@ucr.edu, n05ec@lzu.edu.cn
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based broadcasts
In-Reply-To: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
References: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 03 Jun 2026 16:30:23 +0200
Message-ID: <87v7bzbssg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ren Wei <n05ec@lzu.edu.cn> writes:

> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone the packet for all but the last
> destination.
>
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
>
> Reject fragmented native XDP frames in dev_map_enqueue_clone().
>
> Add the same restriction to the generic XDP clone path in
> dev_map_redirect_clone(). Generic XDP represents fragmented packets as
> nonlinear skbs, and rejecting them here keeps clone-based broadcast
> support aligned between native and generic XDP.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

