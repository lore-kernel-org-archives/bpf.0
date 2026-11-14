Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674064;
	b=1/aMoCoWsSSSa5TxBVW5TKbL1o6SYGIBNRI3xcyv+n32yOJ7zLNRxcTMCNKRMTFtU73x
	 hzSZZ2aldD8ppO8FRUCcNrt3i3ZQcqKOfN6lU0/8n+veSACT59VNpegWMrUNS/WHmZ7nY
	 HJ0XUcxdvQacovzI4itz8ekeUIfqickanX9qbkDpPM5Ob85XPcL439iJn0BI8iMHR4k3p
	 CE0nEwK4ZogYD7ccOVrVCnE4sqjmjhLcSsWCVdPePcpRiNmbXxMZk795azPjDyirA4WU7
	 x0wmzBOpQ0DxPSkpfHmBhnuuv12VptyC3tOVAdEVr97TPjyJxYmtSqwsCdBPYFCtwnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=uIusyOIhmUCph+qRkqcgrTGen1lvnPy/jnK8ZUFUW0g=;
	b=EtYZ/blILW5h5u98yE3ockuBpHuCRtGZgbclSGRkDwKfKjV295GsEDu4EFz1MxSexr2M
	 ZFVZ/4XG3mdltWVKSWcpibCuJART89JOMXZo4wyV6gsD7eHG5r2N5omjihK0k9bP6ndB6
	 7Uuw785qO3vFhyUZbjsiKVDA3UT1t0YzvyO7L/9NSf3YKrEl3PPY9wYxfmEJcaBeMfKHA
	 xpNOed472o2m1NNcLgyEV13HSuPiG/zBMSF7ryZrjvp/oKIxAK+Y9BwC/Y1cYqzHdoBbp
	 XhsRvJ1NnebUqHdqZ9LgOM2A+rGIOhhJNvpXxQIu992dU7o8BVVXET79P6KLwFQyeGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6FERMf3;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD787606A882
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 16:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD787606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6FERMf3
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so2314052b3a.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674063; x=1795278863; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uIusyOIhmUCph+qRkqcgrTGen1lvnPy/jnK8ZUFUW0g=;
        b=e6FERMf3c3yD17BhvoNIpWQb4t45y4DIJCQ7OY3vra4DI0ay8y/ksjW3Y7VLoFySG1
         Z8og4d0qXuFTYi6wVdTsH2/fpl8pdHLA3TU+3K/xEtd/iBXFRX+7u6yn5IUovnzvVW44
         Flx7ZK6fRYplHSRb/2KrldN85TLfg+tKs0yiVzXJP5eVcI4jUntt0aZrfiZNjAlqdov3
         oJfznTuyHQTuV4U87ABE1tPqnmPwqj9kKM8OEtREOEapq6RLaqYFO8Lgr/V6S5AH73pb
         IEtXE4+3CHIrdshJZsMMd6VViw2FjZr1T3+0D4Fy/ezGpMA01VKBst4MtPZSG1sDeMTs
         8nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674063; x=1795278863;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIusyOIhmUCph+qRkqcgrTGen1lvnPy/jnK8ZUFUW0g=;
        b=fSAJZ3B/JsR3AAg2vkxvOvmlJkid7tkIynXM74r+y+jTpswYkzEHYThP0NTVMzimhH
         NI5Sp7efM/dcqC94kFM0+OyuoURuSnoltRopFO0VrwchBbvv092IrilfO6yMWo+B9Y60
         rbdxG3LPfWJ+mHHuEMHdObPFIbAJ9g4zbAI6HfCqOyqmsCeoKHBMCGKDhipcGGqLPGOv
         nc7LK1w4LalU4BXF+7ZXDDRJzvikirT3pBiXQG07eWceEFX5YXzELu/6+B/Nsew/Dozx
         lQszM7Q7loin3R0l91iLk9t8gM6Qz93rhlZbUQ/WVIry3vFFoUdK7eX678f/n7T60rSu
         4Kmw==
X-Forwarded-Encrypted: i=1; AL+hErFwczLjf86Flzs8Uh6+5nz/hCqKCqodAVOw89j3Vmn7lwreOcaAdk+bPD3WmwPsfwuHdV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UeOwE4j3CTg/2z33C2C7jc/eaRCvmV12BnFlpRDXSDFcLI7C2
	56jyi6Xg1Y6EkL9q2sxqXjgoCzEx5wtpDMloesFtOB3C0VfY6NLCU9UT
X-Gm-Gg: AYBFou1Mn6OvOe4zdwUTGSiAyA/PN5P3LyDOPWU/3V52CnUiZGZWASDDnAMobJpALiZ
	fPyOudLbMCgG2PQEUQKpjMhCtdxW6/sNNMbxInhkefQ2Hc/Y5V2HNm/W2HBDr31bXAtFa1opEC3
	KwdB0db/7RV/98e20d1nHGwvkD/GCc6J7fwKIW8Gh7z/zuWdvTDxoHX0eeID69znpFxN4/WMwES
	/khjGWU15p98QylAfKdEpKwyJY/vaBDJ/jA/IyNtmmHtjqNlvbXS8rr2QOptPegx80nmkew6gpp
	wiQms30NEOCmvnqOJN5/mYqUXYrgymPhmN7QsZcfnc4I1hnocW4CWVr2BRrYQDr5BwbljpU5ui1
	dW3EbQAPqPvTmUu7sngRz84mkMql2CPZvduzqaanPOadthGN5UW7AhM8Ffrn++tASFEkK6n+9O/
	oq1pb3F6lRcpRGyU+pNgw/k6tQBxy5MlcGwE84TUcXKrjHWLsbS1XrVDcJtPAKkYTj1iW3nuWQ2
	k4WwPp3XM8li7706Jy33WnKfQbCNMbz4txjNty1/+yX1U+fWA8qd337NsGBQbYFDGAywTdpPOVQ
	4R+FL8m/Lnf+sKELMO4ioEcGspFmU9ARVLQgcNB+kEHTG3UAs2AEzWhexY7CH6Qv17gW458U7Zt
	1v/so6qJZSwo6oYapfNeIMB8saBtR4V16hw==
X-Received: by 2002:a05:6a00:1ad3:b0:89e:fe2d:abe8 with SMTP id d2e1a72fcca58-8beb3b3d902mr5766668b3a.8.1794674062835;
        Sat, 14 Nov 2026 08:34:22 -0800 (PST)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190cfsm2173447b3a.51.2026.11.14.08.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 08:34:21 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 16:34:20 +0000
Message-Id: <DMV2UXIE0LQ9.29AJR2CMSPH67@gmail.com>
Cc: "Eric Dumazet" <edumazet@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David S .
 Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: fix cork data loss after redirect
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Jiayuan Chen" <jiayuan.chen@linux.dev>
In-Reply-To: <20261114115222.180345-1-omermetekaya0@gmail.com>
References: <20261114115222.180345-1-omermetekaya0@gmail.com>
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

On Sat, Nov 14, 2026 at 03:46 AM Ömer Mete Kaya <omermetekaya0@gmail.com> wrote:
> In tcp_bpf_send_verdict(), when a corked message is redirected via
> __SK_REDIRECT, the cork cleanup path unconditionally frees the entire
> message and sets msg to NULL, even when only a partial send was
> performed (tosend < total msg size due to apply_bytes).

It's fixed already. See bpf tree:
commit 13c41b87e4a7 ("bpf, sockmap: Keep the rest of the cork after a redirect")
tcp_bpf_send_verdict() puts the rest back into psock->cork
and goes to more_data.

pw-bot: cr
