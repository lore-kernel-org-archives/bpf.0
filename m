Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794789961;
	b=VUyeOzbbHh9fwn3hpzhFMkoOqj9sIIe0WxUpMKtjhZ8rGjR/vko4rMkRzkBHNA4wxPFo
	 YYLmUnUx7Rbx16kbDdDv9POSP0bFEJjTw6+YRNCrY6/JGsFNJDrEKiQOaMDx+8h1vnLNw
	 0w328xgZC0QIm9EcBETf/PLUB+VFERiiKmKtyqiijSpi9kDzJ1FbFFPvffcOjOeHVssnA
	 M8imkMexDC0GN+c0cs5wGUm1nMdI8GpYV7Tjbc7XRsEMhU3EwSOvF5onTdsDSAlIryG+J
	 hKXysTHMB971w7Hf7DI8BIXCn5eKCNZPGnux4EDfdrBl6Lz5DzG+LxpJQJmqHlAA0Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lO3Cr5SSAZtOZOOCaZ4gKS/kULSO6nzv/VYrrhRFV3k=;
	b=e2iv2zCVGlWUKDd6g/UlWvX3hsJpsKU0rw2Mbrtmh41ZWDD/zzAVL7JepuPrHq5Gtyqk
	 HMlEtfG975p+WhqhwNFOiW10v6DiQHvzS+DKwRzOnvJnFhUKKa4FT4kzXtgs96I8jISde
	 NgLcau6Fl19QCFWGdogVRtmMFvOVR+DcuHJHK6L1HHhG4rT7pgCfNUBgb1XNMPpgW9YuT
	 on/wTxXsHJ4j67deUlt5OgJO7CI3iwDLwg4xCLXTNOH7gDPSs8tq2Ve0FOTiPtU/Mncbz
	 ZN0d3EDcRbLaLde6LcmOP/KEDfwgNHpNfKo9sFWT5zRi37saH5blRge71dNnKG3InJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Xt03lFTd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E3606A32C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139E3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Xt03lFTd
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d68de53053so1850707eaf.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 16:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794789959; cv=none;
        d=google.com; s=arc-20260327;
        b=Ud2hvogdpXhNTewKEKbPER4/1YrdLKYIzHNOYqsrvx6+a74JmbHgu8AVAdwqF0kcrC
         zE2BU7uT1DbFbLnoKqL2f2fVkeTOqF+03iXLOgi2yIJcANvy411rE++0/sMHR39ojG6T
         pktDTt4okr8S8ixdyk/d9iHDCufZDLCgvLIbkh4xg0jmZUJfj3wfkI5U9WTm660ecHwH
         dUkVs/rv8r/ISao7hcQGg0rb2o5ViW4TT1ZzjmlfdOcX+5kBssuLwyCw4hkAdr6BQkvE
         q5FhSB2kOKhm/IC1ecnoWr8os9iT7Hd4rprJ5VJHUjQvbPyr1303Kg9AVSkBocUX80hH
         PXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lO3Cr5SSAZtOZOOCaZ4gKS/kULSO6nzv/VYrrhRFV3k=;
        fh=gQ2Nv63xCo5PXKF2mnfPP0OQghZ1napsAa1Cr5t5dcY=;
        b=HzxQUHkXWYIB8A7eCHoArCGtqf5PA7A+ajXgpGHREPhxuLRRUTL+o2v0MiEZ2MLH9m
         pxOu9AQADbZvnNzz3OH6UlJH3/4T8ZSZ5gMsWQ7kLDpH3VUBByXf9eU2uDzxnvGeM1lT
         pSA3fp23gEcU6kRgSU8qcmwT7TQcf3K32TMH8FwPZ6UmDqoJAhUkC3XSS685cbRYPomB
         jaar/K0H6ulRFqtO9L73q7ToBm6GuP8me1FA7PgmqemiY8IbwN+iNoMu7VEvQEFPD2j3
         POu3NeXJQulo1rGTuQEehoJKACRT4o3IBeFf6ESpdVaQtBTXWHySUlVblOzkVsrRMS6E
         CPAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794789959; x=1795394759; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lO3Cr5SSAZtOZOOCaZ4gKS/kULSO6nzv/VYrrhRFV3k=;
        b=Xt03lFTdg4jLInQcl04vLeXF9oJW0DFBwZLBN6a6UP614RusImFX02ZlrEXXz3F/ep
         FI/p/57ji0nH0Q/LBj2Vr5Tn4kQ9X0yEFhbcaIipNU/5Dht727hz9wrlYC5v9Dw24gIK
         gcndx96h0ysM2nC3pnuIqO7q2HWfC7yPwMymAp9Vdku3yEN1V2Og7zQOZ14fDuYFsTMu
         3WKaUgWtbxJLvpq9v0jiIsG9cRZAqum8zzpd0kZsrPRCsAMjhZR7M+XVrftklhRZ3tPd
         1OzvmXEgMo6/bzkd5tw/o0lbIPVzDasw4K4X/njk7mkw7MkFiZfaLq2snUGjJCuM2qG6
         XfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794789959; x=1795394759;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lO3Cr5SSAZtOZOOCaZ4gKS/kULSO6nzv/VYrrhRFV3k=;
        b=znbCkbcd4DgtH3aAUEYiCdcwJa10CWf1/EsBeNlEQh8C2xYmjhdmr5/ZRbZz9QuPtl
         Gcpm9AoAuCZ7Ti7S98IYFSUKUVhQs9VoHloVKF8ulGiZAoOuNRchjKSF6cElMuA/z83e
         wqiJVcrH4T0xo2OIhSbFTKDBhLDKsDyKr3OsMGaOUc2JNJ+dvfAMAKQEGf2ebLxN52SF
         7ZZ76kBSqLyPzqe6lSCG/hdFQyYNQjypz0ed0yGG08peqzbYkvu/92qdmZmRpfKsZqcP
         wwaBDBEqA97Ac4wp35D+6TU9KDnxRrGcsowCxo33rEMau+5haRi4mynddoz+rVNQyjh8
         01Bw==
X-Forwarded-Encrypted: i=1; AL+hErFsoe5+i9bIq8k6k2AZmlE1B74/GOFS+uK1YMmj4ZLvr+P/6j+jjkiaPlE0m1y+TY/EBwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZaYojkOqPdnCzD9FcB6RZjOUJ++4pihnTIKGmnV9vfEDl2t/u
	0Dgk74/BFuHsPWA6QX9zEPYOFmNVmG4zhBzYO6jWovU8WdwWxYqKDzvpSZA1rbhiEwu79ONZMuy
	WWUMZ31YV1jG5Ns/8oINgjX9WeK1/gIRCf4uX4hmx4Q==
X-Gm-Gg: AYBFou0OTnwDJM2HG3bTxSGotrgQSKYvgMGvAC10xF4mexFh5ngFAnioRFJp57MykG6
	oULyFtJ2pvd1On0YEZGQ0onehfUkfiGdIoOs4iCoCpYvV6WFqGKR6KisYF7qqFnvUBR866lobwm
	mo7f1CZqjDd6DgdpHQt52vpEXqFsXgeEtYqpx2azONzF6Gw1IoCdBzLQG7k8A7hRM69SSWbMYvv
	3bpbZguxxAlxGmu3xxy8nyuGUbf8Z45H8w7H/bZX7NE2PNAx84TZ7bx/aoRauzN3cdynLP1KPyd
	u3vLhrpb9EAqNmPyBKVsHhn2ofECiaQVIwnXK/XV2SK6Eo9YesZeV1bzUhxcHxIeLTpqEgZU98F
	86Ekw/1Njg2k+XtTJh7UcROn5srSynIkMte89/MSd1LovCgnsUZ6G5nsFjK80JbZrW8TYzrD632
	VwiewOdnniqFA=
X-Received: by 2002:a05:6820:4101:b0:716:bd98:252b with SMTP id
 006d021491bc7-71acc5342dcmr3472073eaf.26.1794789958914; Sun, 15 Nov 2026
 16:45:58 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115214702.50817-1-emmaonana18@gmail.com>
In-Reply-To: <20261115214702.50817-1-emmaonana18@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 16 Nov 2026 00:45:48 +0000
X-Gm-Features: Aa3M54pgGbrVncF7OWBfNtWTvVm2wgZ0k6kyExGgK-4Hkv46OrR8Lf1HTEPy_OU
Message-ID: <CAG4wq-cd01i7YrcFPmma=BXUcwn_PK=wneKW=vyEBYzQ3Bn7QA@mail.gmail.com>
Subject: [PATCH net v2] selftests: net: veth: propagate channel-check failures
 to exit status
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Nov 2026 22:47:02 +0100 Omokefe Emmanuel Onanaroghene wrote:
> chk_channels() reports mismatches with a "fail" line but never sets
> ret, so the script exits 0 even when channel counts are wrong.

I found three more checks in the same file with the same problem:

  bad setting: XDP with RX nr less than TX
  bad setting: reducing RX nr below peer TX with XDP set
  bad setting: increasing peer TX nr above RX with XDP set

Maybe it is worth fixing them all at once?

Tested-by: Tianyi Gao <tianyi@cloudflare.com>

Cheers,
Tianyi
