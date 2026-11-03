Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680261;
	b=xNMqIaR+Jj2SfaZYDunO5Ws4ZoZQbTkRPR1tY9ro/cS3InPtcz5oDblf8s0GmAx6yH+K
	 yrvqBbJOokc0KrCkREBtVf6j4Q/1WcNstsOuxggG6m5TD/oIBA6XwXSO5nbamTxo7GwKx
	 Uqykx4H519zZy8ayHs81WmhEtY+v4wpnIQMqZOJQ5gjiEdbjp62EHUfeDJ7RvFbkr79dN
	 ZtI9X9bckAGy1KNA8KDbW5iBI2k6qyot+/YKrhXiZ0j3ltWBV8zPCVbLM6zskAtOCbzu1
	 DyQrR+tDzxL2Zlk+mx0unRPysZYqeJHCSN21PfLjgiEr9LV2ANyta34xdBTRcIlPQRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=90WOJxWEiaSb44hA6E+8FSqt8JtTiu4IKceMn/DMgMo=;
	b=E4MezX8QkAAyiE7lX63x0QRKnbWS4+2Vd4q8rWBAv+B0HPm2XT4Vdky9c/nSSP9KQo/B
	 kz1yoMRhRSOq73svfgOqqC1KDHtgvotH8xhAa4HF9BbN5cphEJgbksr0FnxRpktzM+KWE
	 JfG/GTTdGYk1MdINUsGc7EFI3bUDV5ijxSMwn2jlVcBHF/86158Yho+5eoozCWsxudGQW
	 PVX/T3MADZGWkjKsifGT4zuEWnZ6/TnxgZemBLatpP62bEY6bLqs2t9w6t0ZNBv8WRPTx
	 1X/+YY4vLiZ13lU++OJ49fElmF7cLK+L/YRvJqaT6c1k75MeWCRxLfOm1ecfZdZT7fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMG2TSXS;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29F606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 04:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA29F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FMG2TSXS
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so1693363a91.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 20:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793680260; x=1794285060; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=90WOJxWEiaSb44hA6E+8FSqt8JtTiu4IKceMn/DMgMo=;
        b=FMG2TSXSpexOAMI1R0qiDDsNi0cW2BEassL1KlQmjhbCHX8oo7zRZ32X+cKMEEnja7
         4h+LBPtoxT7W+2lqj5VO+PBagtvEL68B7J/ur1soU/glVuSIly4oBI0j0dX7PzlpGzfF
         onoyMOcLUUR6h5HeWTGfvb4b+HJ3UqdmLXBhOz7n4mwY5e5VLq+QxQ38+gk0c9PMCGyj
         G57GZP7vKHbp5lZ0N3oT036O5azXtKf25gWzlys4l3TpIycHsEjAUnLwG+YnCf9rqxoD
         COawC5HlsKPqDNEVOrNE4MwZfF9HNB2LiM6xNJnQPgYlLUyFddjMn54WdRFhsIAUZl+v
         Yo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793680260; x=1794285060;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90WOJxWEiaSb44hA6E+8FSqt8JtTiu4IKceMn/DMgMo=;
        b=u+9nWKqwv4o2GmyflEyLTYreHYBxCg7R8019Iw87p7xEtZ8j479V4PXsPeUOtK2Pyh
         PGELmnHgvDoELuUMHCBBIXVVwyZiDEVdtz4/iKGjAAf5GLH3iW260+0fGsRHfiKYzOG8
         qkEJBJ8iDRqivtUmqdcvfPqR8Nz0b50futK18G64CodioRSDcScrcf803ajPt5F/8SkW
         IQbgk11fq24vrdFir2Hn02WNo/xRpxxJseyQRoE9cmVV0XQCGko08NUR7iIBJTNyBHg9
         XxxXUgRSdx2inHdo5Gi4CXuaPFe/EdMLxQg6M9R1ehOE/HxRxwWPDLe3GiTv3rd+BCB6
         cdyg==
X-Forwarded-Encrypted: i=1; AKwUvByBSy/T3zwf1B93FwRTbcFxzodFZuBxZjffNOmJKaeAq6vDMw20AC6+Ec76e5Nun2EVcP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jvk/RngWiU04JwKt94NbOgWEb9btcvHzUsT2h9tVcoHjbskyc
	KgcnVYwrWS5KciVBFGysNgepm8IK9geLUme0HAHo67ou2pXcBlaONiR/
X-Gm-Gg: AYBFou2oULL4xrZ9S1KjlVS+8Fe5q+V4UXTt57T7wWzCwbhzFh/gm9ukwFmnZvVB5SI
	7AuO6NR+dRWZFmC9XXaD5jxNWc8SVl5bTu+/hybgJEIS+QtS3bfFGZwIRZf818FH686IfUjJtkX
	VdIMH777c/F9Xn0a/aBYihn14UGD5BVTrddyBEdwleq6EzZyOZYnHYy2YD3NsreGD+RR9a0hrk4
	zX391Lv2JqoC4Vs+t+LSZwQaAH17ZFCuhKu1a9ji6+sb78GGnJlMkbDp9gK2iqKnVvqOGWO0nSc
	lsurmyeUTlpn1tSLKe2TOD29dALpF4B06RPtzasy9Dz7qmFc10eHzPwP2n3lCIwIRaAIewnUGDU
	jvMqhB01lftMkL3GWjLTDbFMZCkORc8xIJR6g1OVfYIsECQj8EmcPvc/AjWMMl9Lzvy3nHpXFGH
	dKvgrBfBL+FQ+1vKaz7tf9J+TCRmLv8tewG0a0sgoeg+K26STjYYNHilxoKmz6UCwU1YbsPrMcf
	uYzjrvhJGKBU4ywBBZjV0iKjcLs+Zw3Lt//Tyr2O8dnLWGr8aMw8uX2pDw0tB1E8gwzez2zQmkT
	jFjX0WRTKcYFevjwwJi8lNEkGQIQt+NIpb3GSvRhjGtiiTic7dvCuHD6HwEr4m6hZLtOX5ufH+m
	0LW5s2/ZhSQ++mikZTBDAKgQReoJpN7b3WiI=
X-Received: by 2002:a17:90b:3812:b0:3ab:c80:9362 with SMTP id 98e67ed59e1d1-3ae89776da4mr9524287a91.35.1793680260307;
        Mon, 02 Nov 2026 20:31:00 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928c4sm2067891a91.15.2026.11.02.20.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 20:30:59 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 04:30:59 +0000
Message-Id: <DMLAL3JBM43I.2LIYO7PJ9XTN@gmail.com>
Cc: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <bpf@vger.kernel.org>,
 <stephen@networkplumber.org>, <dsahern@kernel.org>, "Willem de Bruijn"
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 <netdev@vger.kernel.org>
In-Reply-To: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
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

On Mon, Nov 02, 2026 at 07:35 PM Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> - Move all info to maintainer-netdev
> - Add a link in bpf_devel_QA to this location

Acked-by: Alexei Starovoitov <ast@kernel.org>
