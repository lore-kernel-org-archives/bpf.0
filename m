Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582278;
	b=MyjODP+8xSe5CoJEEyqM5XOyk3XCOUvzYEvCZkJjCBAjE+MJuXugNTxN6Q8pi81IMnPl
	 vsv9hzPDwFFRqGMTmrqQZ5UPwptQLD3bxJYzV9zvr504Duq0Qvep3+E1jMeKWoptGyUI+
	 eF1Dvtp7iADBisIOA8zzppPgieCTzdUxrJfDGDBZjeirAq1HPWX0B7xqg0xCkgr2L25Mx
	 WddUDrOhfgntHbHZc37hmJeLYwDwrSPf0gpCU/rbn++HxWrOQaj/6cHK7qr/F9eamQ4Br
	 XJe/QhV6bcb7EC6cFMnJiwmcivjwVXPHiRhbS8YrKDWFtm9aRDgcXloLIBktPSw0XUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=GzNf16NNZkizHpuwga0Z0tMlnoHvbeUboIUcXI7KCTQ=;
	b=Mc5XHF9U5JvY1CPBqNIg8P1QbYXGXbIWGaE9ziqbSRyWbTdkYildFh58YTJJB48+K9DG
	 W0qfqd3+YQExEvJ8mF7eCPD1tyBQLPLmStW0Bq+KHIlKcNlE58MxMx50gkDLn3C+Fx+IB
	 +QR5ZhiLDSwWVrbhWu+px0lQ42o3fTv3PlyvY4dmwJGO9dmaoIDGtxw9VjP3Baw0Bp9dq
	 FoRxliaV+qaCkWan/h21+gIk0Lp/YBNxhhr/wsowaXj00vD8QB5kuQkIct/F03AP05iuz
	 4DeGdsOpuFgdDQDR6mYAM1EWhmfwNxzrI3/DOv+WBfsIiqjBj9Rp+iBoau9IWsCcXxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMKOppcv;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223DE606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 223DE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZMKOppcv
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cde827b7b95so1444275a12.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582277; x=1796187077; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GzNf16NNZkizHpuwga0Z0tMlnoHvbeUboIUcXI7KCTQ=;
        b=ZMKOppcv7GMkcWPNGWwmyPziDutU9EquY2Tb1u7CJU/H0ved0KD9S3UTPJTxCiIrYe
         21L0mMIrsXo/BNHU0gbNODCyp2RJpG2SK4n8AIAnKS91M8hxsLLdyOOg2XpqPENqAzH/
         mKbUV9aIE9XQFM2xjMihS38qk5TlTFp02Ej00TjsqMEak6aySorRfUnMTioXp9qxWd9z
         UDJBHLiZM07mXwGvUduKcFvyQtFcuKxey/XDYFDGr+JT3HH1TG/RzvBLFnweghn6bTAn
         NJCf9HY7PXT5mPzSDRScX6kx8poiVcymnaHoFGPkrVh9H7mTlRt3lnDhqX76tMW+0bId
         g09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582277; x=1796187077;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzNf16NNZkizHpuwga0Z0tMlnoHvbeUboIUcXI7KCTQ=;
        b=ZpnFQDCUvdZ0PDVPHu4Dzueq6WpmG9OR1Wy2/kzPAv5bmBOVoDoNuCjxhpSkarZLvZ
         mrG5XT/jA/8P1JZoEEec1mSL2D2Zfqdiuz1eKMqdBercsVHoMxK8K5RQ2lTSMrJ1r6qv
         +93bqJ7PiXjfs8+09WpTUa7XNMaX8D6+1kpF/PI5qZ++4cPEj6dQyhh+xGkEHAYwzYuy
         e+k7pBiNCHlotOdzfRIQu7sZf5KhnXSuV3x0OkdOHw8+PWC5zQHl++OXU4GusJ+pGCGF
         46pzE5+bUZJ6X9J7ppn8m/fIxSR2CrTXVinHIk3f0o7+bH9DIOZ4J982NHlm0xGJMYQA
         5wJg==
X-Forwarded-Encrypted: i=1; AL+hErGRWqOT/BZEhMayNOikRF4cA+LLI0WyoDDa04jVVXxnHIIFuyr/yksj4x5mmJXlLxSM80o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9r3n0YLUYUg4hNyxydqv1jjlRPIBfMmE878tCeRMXjFRUrzADl
	QEkc4BwdZEU0qMfb9FcX6goCcihNNQITcTccfsME7GdnOTaikvOrVj7Y
X-Gm-Gg: AZFdTZcBNLZWlOZfeEJ5dMXsx6HkugtFa4fb21VWCG1Xu8bKU+mT/Gc8yyQy3/1JYZA
	TcmrA+t0RUC2bBdhsawULMgoyvsf9MgCzxrovdeD6ILBW+JeZeP6x7rt+ZKU42/mvL0pPJoCAzW
	A1yuWvLHSFNVZRnQ8/iCZ6vhFBz2PZNDC8iorYKQcCgVRtCr8zJVqU6lHlmQkihHEbJ+NqONTxo
	GB8Tg7MKVNVkTVNf7+R4ms890JPUwucD5FnVW339kz2hMXwK0FLiVD38PKnKtLOaS1SB5o0j9fG
	xmPFaZdqZuNNtdG2IV1RHH/g9YskQstV+8791hlQCTrC/bZYtPBHKhN4M/Kz2DIGOXSSSyRncLE
	pn9psFRJlathicpBTs2cIF9RVpDgS8SoAApXM6viwtkHbKYtc/rcQio9R0tJ+nEQPu63/S+LF+3
	y8fq/Cq3IwJpI6LJ4E56ZdL6A356Z5Ru78MBQLFY145JBXz/4OKLgXVvdL/5uCA+FDK+Bo39DcF
	ZtoksbMjNssCyMqK+RSOgTHJBk/z7IGrKevRJmVFgWnE9s/+prFUb9RnwdRz0OHd/17C4SzUPe6
	9Mwro71VaAqwJ68hfo46L30HTM8DXV+ws8/tLyYqX0CXsmVYTSm6GJ16NNWWnNfIXjjsIq+Eeck
	t/xwTziBnPX4LZBEshjTqKbhgesOXoTYz0PxQncUcEBNMZ0zmKpNj+tk=
X-Received: by 2002:a17:90b:134e:b0:3b0:a7e7:68f5 with SMTP id 98e67ed59e1d1-3b41c7b638bmr13032229a91.7.1795582276887;
        Tue, 24 Nov 2026 20:51:16 -0800 (PST)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm30569330a91.8.2026.11.24.20.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:51:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:51:16 +0000
Message-Id: <DN40SM25BZ6Z.34Q3QLH6PYUXL@gmail.com>
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ryan Roberts" <ryan.roberts@arm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>
Cc: "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
 <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
 <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
 <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
 <85385aae-af06-4742-a39b-5a95e3e73a7e@arm.com> <awRd1mHcQDVNi9U9@arm.com>
 <0fad3d48-54cc-4919-bff9-254347c933c4@arm.com>
In-Reply-To: <0fad3d48-54cc-4919-bff9-254347c933c4@arm.com>

On Mon Nov 23, 2026 at 4:48 PM UTC, Ryan Roberts wrote:
>>=20
>> If Alexei makes the Kconfig change to force JIT always on, I'd be
>> inclined to drop this patch.
>
> Works for me.

kconfig change was applied to bpf-next.

