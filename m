Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724702;
	b=K6RkThKcGgTHZmxYoUaYUFu+A6WCowCGBE1kyq5H2DnwyjwhCrGJu4P2/M0s/e04HKBV
	 tm8CjyZgLYD2ZQX9V2AUS66CCBPOH8QSFHaz9916HQVscbg2hcEsIkLo/iAdVqtOYz0mn
	 qf+UAVdtevSmibE8kJg3G7/VQr8KoXo8Rcjneb5TnlYDVejWlIyACguSPwAhX/nNrELua
	 NxU8XmtpAAeOa/2PMf7ZDpq7sTBy1Yxr1gnQ3P3n8QGALMmilWHAGpe47QMDZaWqtspo9
	 R2hljpbnha9JRWLJQwT1QDtvJDAT/V0vaa389or8FZSpSyIj6vyJFk2KvaKgJzQ6z5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=z/+aYEPLoBSp7AxjoxxgYR8cgspXFyNdt6Vr/KNLDmE=;
	b=mjkYgQUniHHZ5O2milBr06Iu6SYW35MQjO9rjNPjpmOWQsrKAuEiHlZ4WYegDW54TTFJ
	 Vv2lMJhavNePptjMsL1QfhdBhOOC8GFi5Ed0E3MBVcREf5YwbGGRuIq+Nin0r42fQqFgu
	 TRDvsJuksuKjbkotkV/MiDSLrUOfZah757G8W2v3fGjkw8e3VKYabQofTzJT0qS9xnabI
	 K+h9e/LdakfPLzvzb4c6kPGZUXtATs1TJlUvhgoZZ0pNeUUWpTBVGQLaWq4Y97s3qOLz/
	 PyJ+F+Z3hTtF+RUl8GL3BbuU5+IT3RnOe8T917dzddbO3EVfIbGc2G3MVNHuiZPW3fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTIFtqdT;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3047606A33E
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 16:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3047606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTIFtqdT
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a07025cce4so2272563b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724701; x=1794329501; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/+aYEPLoBSp7AxjoxxgYR8cgspXFyNdt6Vr/KNLDmE=;
        b=eTIFtqdTdXpA/AfqqKkL10HIQZLcduWeqawGhkY8XSlpOW7wAg7SwK7IyckCmAeC8z
         QZEJnVKKbFm1lme2SYMMxv1HNP1Njw8KJE3QtzbovqqCyntSjZr0OxFCZk8earTy7ZeP
         s5VZOXYH++PjPF1kTEA3lESRC8qsEpTcVQUri9WLAkuFv2cuZix2S1MDadbIk2gWxXcO
         a1CWIRWP4N0snge7OVszIUi9zzUBbb6XW85sc28z+DIK0qUMW3AE1Bt1XJHJEohjeBO9
         ub6LOMq+gg31oFsCGTjAhEdvsMpjkdKA0Yw0Eq/2gp4qZRvsM2ML5GSPlkglQB80sBeL
         ogXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724701; x=1794329501;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/+aYEPLoBSp7AxjoxxgYR8cgspXFyNdt6Vr/KNLDmE=;
        b=sWy6sNTwf0ZV2duJHUTwv2HkhWcPWBeDiRWAZValpgI56aDGTKzVak93hkCuHVi9an
         fNbA2YMDfqP+ZZS3njpEmWJeeKKifYuk9QIUKfZHoNyGM165Cry54QPm1rW6fZCQGZxp
         MXoazMDS/Nt3W5dK5mo9k2Pp2O4F/at9G93Ejmm+fACzRZfhVZSLnlZD2m4UFR9igEvp
         mANfWqQXWtIocK/ka1ICDWLEQTSfDhu9yXENOcYYrZvGvv1L+BLwalSldVz089AXTlbG
         AhD+rVZQfTozXBm/eqUyNWXuYM9EYxlgZqrLh3JYh9mXJ7s7Gu3sPPzWkastqrmn2bX/
         sxDw==
X-Forwarded-Encrypted: i=1; AKwUvBy0h6JBMKo/7Zft0kyE10Q4CqclypkGKcdcgti8rhfzI3MxnXfQsX3MJ8gbg4ERZAqcOWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UqZC70ZJyaQxj4Dt9Qdi8xnaG3ayMs4dxJ+Q9oeLWZwpEnG9b
	kUVLSmU9Q029fKr6FSsRWL/iF3LtcIYrGg6208hHcPqEAQF/5QcOnQ+2
X-Gm-Gg: AYBFou0QFDAsHRWofB8hSLsyMYn6MqP8qcCraAhc/4pAOqXLAYWIHL5Dx/ygXS7kmE2
	vgMu36Z1GlhnTUqSrnMDvZo0SFGw/Uz6ZECJP9gqf1+fql4BlsHWqNr3x2tg3P9S/48/ChrmcrY
	UfHMteiceVnAm5bfb5Rp9uvwPEtJ9hvQgfGwx449xnZmr8IOjPFkX2gGo8euc1L87SmtjHgD602
	oCLnghaHCYc5HkME/zAx+5/UzGuStBNfmAbAzjxU+5U2ahyrCqLxMcuetp25lWJEGr/LVQs7pS/
	3CQbS3THrgGkDewmXq0a+UDUSccAylBkJLOHlb/C7Jk7QPmcMvWTznGTK6GvBwGbqYXyxSt6F/J
	58+h9RQeJc2t22XebiBLvG8FhZHmgQxJw+7lDHxvOe5IXstdXY8rKBWJiZ9Y8DAE13oeBv6lQSu
	HUGH5i0nqXO/wEAC4Aog5Q5riIy6iNkhwAmnPjZPuBaG+IQ+KitqFIyI9GyHIMXRUXUr2OgjaO/
	gTVxEQJAETIWE+00Tj4Nylmhfvi+y+BIq7TiH9XiP8tvxOE+y3U+yLxQeQrRAHLeXnvnnc5pAq4
	MgqTxFEZ+7bAwQRQmcy2sBhDksyWb4IfBryHKWwfD/YfSwhnQvPVXjZWbbFGWCIXbdbpHJEoXoP
	uFGrmZgo9PoNRuSK1HyBJYxlj7ZJ6Au+WzA==
X-Received: by 2002:a05:6a00:3a12:b0:8a0:2cfd:87cb with SMTP id d2e1a72fcca58-8a9bf90ab27mr11070101b3a.43.1793724700510;
        Tue, 03 Nov 2026 08:51:40 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fccffsm3794904b3a.7.2026.11.03.08.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:51:40 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 16:51:39 +0000
Message-Id: <DMLQC758A2C3.175VOTFQ2Z8HD@gmail.com>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <daniel@iogearbox.net>,
 <linux-kselftest@vger.kernel.org>, <cuitao@kylinos.cn>,
 <ameryhung@gmail.com>
Subject: Re: [RFC PATCH v12 1/4] blk-iocost: add BPF struct_ops cost model
 support
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tao Cui" <cui.tao@linux.dev>, <tj@kernel.org>, <josef@toxicopanda.com>,
 <axboe@kernel.dk>
In-Reply-To: <20261103132613.1952975-2-cui.tao@linux.dev>
References: <20261103132613.1952975-1-cui.tao@linux.dev> <20261103132613.1952975-2-cui.tao@linux.dev>
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

On Tue, Nov 03, 2026 at 05:26 AM Tao Cui <cui.tao@linux.dev> wrote:
> @@ -3223,7 +3306,6 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>  	return 0;
>  }
>
> -
>  static int ioc_weight_show(struct seq_file *sf, void *v)

Unrelated change. Tejun pointed at this hunk in v11.

Overall makes sense to me:
Acked-by: Alexei Starovoitov <ast@kernel.org>
