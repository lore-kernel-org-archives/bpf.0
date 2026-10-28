Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214085;
	b=jsHH1bBDRMLqh2JXDF1SBgIkmDNrPHJm8i/gbhqGSjuEXfIBYc8uLECV5nNHHQPGo2JJ
	 mNy0AZQAlaQhW3mRZp1RFB07SChfIWiPjjk7nAelAYjz5gIKV29Gpwlg6yj/LpidIQ4xy
	 fMr8jjnynBaU/iOwqbDrepYsheUyfJJOmx1CHFo8D1sVJ9+j2FtehvcWAX5IbA3E77le+
	 jCs1keBUOr/ssOyxWy5qtecyLFeYKBjZDbtm3KZ/fr+ua133gRn8CRVhfFw18gj0TpECj
	 IatKVV7bEA3B2NqXIb9MUT3025BtdoXG6Buxy6Ai9cjLGRRUspKvMVfSLR8PvPfDiOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S9EurIifpUwJy2G+nM4BNN6Q+ATRJxxLHOwW+90amgg=;
	b=XRmFhPpClyfZNoe2itr4c7lIMemhQhA6pdxmU14ODGPNWKFHxAo+obMa/B0GpdavZwEv
	 zziI4UQLtXeiRAuutpFh4pHCC6CphMYFaft5/FQIGjbQ9d0RVOe9Qkm/ymuuKPSkXtet6
	 FrVMK1CGaY9jd2SUHsSXyyprHWJSEb2+HvUb1BW3itINQJGMMNMbkBVV2mKfc/s/sShx1
	 d85Eup0cTWR/TI0Ktp7edtisGXIfAi5rsVd7jHSRIvnq8XoLR6NWrj2W1VKjKYypmoJxv
	 hySzI2K/cKUWx2IQtMtXR6uNEviVhXuFOsbkSqgLIc344z6HB1KUpKiuHLwuHSDDgXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw6CkUOs;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF0606A322
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 19:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AF0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw6CkUOs
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd61a2dfd7aso499100a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214085; x=1793818885; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9EurIifpUwJy2G+nM4BNN6Q+ATRJxxLHOwW+90amgg=;
        b=tw6CkUOsTtCUEVI87JYtosACwojzTkmSCH+5Sm1+ktP/Wh/IvcBqsj4zv/7rsnBdFB
         Ep1+dBmaHAD1boz0GDehMz/xwhbAbzvn2z1NK/Bhy7Uc/7VXYWwVB0FlESvDf8ja/dMs
         OEZiBwhqoGBnLRT4EphV6umYTl1j/dnH8DGqE4c69hIu8f7rbQGScqgoYi/rZGUy5Aot
         7Sq/vRTu2mGNDjfWmV1NrMQTHYN7yHPG8JOD3TgLU4c9u9zGzAv8yQe3ZPc1t3puI6Xg
         fN/Mi7kzOblTTo+4EK5ix4YY3KZ9egdAxhDHIGgYVZGjURwhUPIZXemQpFl5QFnBgU3E
         /zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214085; x=1793818885;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9EurIifpUwJy2G+nM4BNN6Q+ATRJxxLHOwW+90amgg=;
        b=2DSZR72P8tDdPpISACYfLi7YUd+aSEusQY2pTio9OfJM/tTj2F0+LO2ym0Yy+p6+G+
         WECozd4PiIxwy3mz+U0U6qNF/m3SG++afr47teLDbUnjMrGkn18SV8C/tPukT2umpxOz
         jnbDkcqN+0uOTK2hCTty7PXgMdizBv6dA0cDUcoyCxYmlWWDFXpIGUez3L15bH8HfS1f
         vMrE06N7Gj8YDmGIVyadgt5T6fwVlZIEUb+K3/J0LD0BhPlUpj4L+DkvieIyzSrRWHlW
         qRXPv14ACND9s4IP+0hAh6lp1lE7lrbPegBlCUq+P6SPqYr2Mj7cgKrfzMVKHbvS7MK6
         FXFw==
X-Gm-Message-State: AFq9FYKNZBA20dRH6ZZyDnqs1IRwP7mgxGUl7CaB7uITWw1UI3ep7iUr
	YECoiNS8e71E87oBar9B8yIp6bSIjqKwN86hClMWZBDh6UL/v5bXgV+r
X-Gm-Gg: AYBFou0kAvtfcvEHZeNKtE3LGYkxv4Q9oDgGc3a1u68+rYg+7ElVfaclvNKOrkImRuA
	BMEw8tO4r6y2HZTTaZ408/b6KiODWj2IylaeA0He97z7SzYblv0TUQFPx12oZgofwxT8ErMJyFz
	orms7/d+/U/HBuzrQuLQentGj0YDCm9g+0/lohrvAb0+aFrIJ5/lmp5+2XvC7ZhBICdT4Flaj3B
	tZOtVWP5LiwOpyncjL7b4lY8P2K5p8HAxmXFN+diF3Pj7qzc1cW09KLJuDEzE42ewdBRf/S2wAZ
	2WnCNfFndNaI23Bu0kmJcdN6w79xmDJYeVmA5DZyO5rPyiM7f8cSH84J4PzLfYXk7ngyI28Zq6k
	ahKvtqXyhhDQYAy/VZXgIwW73+KOoFLgXHOGqjrCiVPH8s4xyGnGl6JBbwHPTAgaHfCSXsoQbcx
	WbP6gviB7NfoL9QjhNJqQUoV9JBJNB0+KSJcC2jqYzYB1Y6VBcxkFhecWwz09/ScttymnjAU2pO
	arXgB4cejXIQQ15Bv5Dy5oK6rzwdi7qAvHw6pUu/RpeGaJ3dNXQYavy4DBDPZdIeTIvwtvsN/TB
	8kcaFbeDcfEeIqXuante4UBnyd712FOSEq1eJn2sDJIKkiYCwCOJrQ7dClkNqPAAa/BSbrKQWiz
	7MjLDX+4LgB+8oyXsmOXD5xwzYIrlloFiuQ==
X-Received: by 2002:a17:90b:4ccc:b0:3a4:9a7a:360 with SMTP id 98e67ed59e1d1-3ae58100a06mr2555079a91.29.1793214084640;
        Wed, 28 Oct 2026 12:01:24 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5797f6aasm2275204a91.2.2026.10.28.12.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 12:01:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 19:01:23 +0000
Message-Id: <DMGPC9G5ZT9O.2NN1B6B3K7STH@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T75pOz8Nj_YG13quoVeniq6908sY5og4RadfM9-tz5j7PQ@mail.gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com> <DMF694XH2TJO.P59A31VE6GWP@gmail.com> <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com> <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com> <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com> <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com> <CAP01T75pOz8Nj_YG13quoVeniq6908sY5og4RadfM9-tz5j7PQ@mail.gmail.com>
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

On Wed, Oct 28, 2026 at 04:00 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> Sigh. This is not a good response. If you do not want to have a
> discussion, what is the point of posting patches and asking for
> feedback?

I do want the discussion. That's why parts 2 and 3 were posted for feedback.

Maybe I missed, but so far I didn't hear an alternative proposal.
Only worries and concerns and "there must be some way".
I expored all ways I could think of and listed some of them in prior email.
If you have a sketch of not a 'stack in arena' approach, I'm all hears.
