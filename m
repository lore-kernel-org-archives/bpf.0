Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C33B14C4
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479860; cv=none; b=gNSKigo+U5AsQ63flqPoOH7aF4l04LKXQrJtPREmyGsKETNEEASqSVpa8EgG+Vm1FH3VNZGy12P3u5G4p1Sy2xsPxjtZrOXkL4YciakFXGv/M69fRMXaKZRQKEWoSWM/CvP2SvCA9GGK2IOfHmeFYD/QMWYT+sG8muW+8KHt6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479860; c=relaxed/simple;
	bh=fa57BarLa3S4MwWGljw0T6+FFl5B5HOLbc1wS80I4Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqql2NanRxHHLtG8nKWn3YBxc9Hj9+jbaU9mb/lnVjtGWcTAAeRwaPvXKeYQuuKPtxz5F51dw3chI/YbQSKacL2AndwjiPghPTd42EkrLm3d7PB71OK7t2tJmdnwHLjQiSUZZLVOUhNjoQFNbTe0kQZpZ/BdSReGtyCnAsTnZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS2HQWq6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS2HQWq6"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcdab9a82bso556895e87.3
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479857; x=1792084657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0PLYiY/N8RhjOEjCS15BiR6ywDnnfcu/szHv5dRujk=;
        b=jS2HQWq6xE8lq1rtpRL4VZta8mxVld5O7SU3cw6IQqEEKyXS4RgMR+SJQ9Z/KrXfPm
         68GJx4TxlwlnDhdx8t4RjExja2OQTQ9o0R7l6ur9h9n2aCBu7zLirWVeYJyi+CrP3yFj
         qLc02xh65SGRlfjaRem5xG1vr8Y6sKfAkc1YLxajNKWZXEpUbsh4T7gYvoDMYovjVD+8
         gBTFALTe4ss7OVj++8BclcdTVNYjzrchsnD8LpEpyrK6k5JB78Nzxr2jny/4VJtmIRJ8
         28HE0tPuMoeUVZT2ibOOYR9/rhQ5u/kpsFJ3GykFdMF3GkA2KVUdOkdwBUyQ+vnFpDrJ
         3SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479857; x=1792084657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0PLYiY/N8RhjOEjCS15BiR6ywDnnfcu/szHv5dRujk=;
        b=f0YBMSN0E7SBu27kO9uCzmvwGaVyRfPqP9cOGcH7xtZTKCAvXgYgqpJvRZRtR2QdTt
         JEXwxuJ8MCwzEj+U3KUjyBoZA+1n0ZQs8mIyUNKhDsDRbZkFzv/VhuHBeWS9NK92dYGC
         kcb1HmzV3CLl/7QzdbmV4i48snRzM1sIZTbvZaksz6vHKWwAP76fUGX3I2MxZaJhoh/O
         hOgg5TU2Q7L9IXUvNXpy5XYrevr3eEXNuHZ3AOBm9QX1wHZ5q+6N9TliE0LKDZHzKwGG
         dLbHFUo9kb2LcdZrNEmRMqisLiLTScZ01uyYW5/Co01Ko6pVwDPJoBVnRqd6XpUNC3RH
         D5DQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZM6nBIfSl+oILbosBZMnq3Ler4ggamXeIEji1P0QrSXqYFN+KbrpJMJtk4QCPtuUlXM8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLC4Sr5DnYhPV8YW3Ats054GHwNzRQW4iSkUSlePZ1NPs13LHj
	NWlLY99j41ArT4T3V8mGPmNwJdF4ldKAx/QEb2tz92c+fqJ2tQlTy/KtLZo6OR/SXgc=
X-Gm-Gg: AYBFou2w+UBu19Yeo3U0YS95nKLukdgACZ9cJwdkkM129Fm8fKWjLKhcVoqZBuXPclS
	PV0xuBtb8jcPWU4XY1CrSvIJIAlgoiOqEskSV9JWhSiGi/a4if7qGYSE7ckwaJGy1cSsit4WlFN
	4OKFIanAKNG4kOCxmBq0/ze/NgYFBkENY2g6r78VnpEhYx05eHeX0vhIuRtsQsOdlivYSn0mJIl
	TRGtmO75oH7/SjpgKSEW94ecy3+A9xfpcc94s6r/OBsJ/1+QxUMf/TC3v8Km96KopiqJU4+nmyb
	BXiMVCOrFehsKBajisMyc+Q2aneDui5M9KAHa61XDfy7OpHD1OK2lElvPEJtPrZoqYTC2x+C+Xq
	GSb0Vm0QMIAmqZK+jxBw+VgK9fo9vH93Z4LRhwO6tMJgDuyq/cQmuSuk2g0LjMLB8MQ86EAMV5L
	n50AGDFwuRyEOzJ+9fvN1Hb9oSToRXDgYDLYo1UlbP061fss3YdnEhhmOAkFAbvsbqCdfTBDJua
	T6UAAuIZiDc7+bsVJDkcAktpwsx3HlbWAxNrYqd8rO3Yo2d5SYy
X-Received: by 2002:a05:6512:3a91:b0:5b8:bc5e:b57f with SMTP id 2adb3069b0e04-5bcd0712af5mr2293273e87.55.1791479856946;
        Thu, 08 Oct 2026 10:17:36 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcd3015020sm1497605e87.11.2026.10.08.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:17:36 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org
Cc: Maxim Skokov <skokovmaksimevg@gmail.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	vadim.fedorenko@linux.dev,
	mason@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: test_run: Fix false -EBADMSG after skb leaves CHECKSUM_COMPLETE
Date: Thu,  8 Oct 2026 20:17:24 +0300
Message-ID: <20261008171726.47795-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6ddac0398e54f73f0d424069145c6901d8d0ff3401fb160db0a9e3b281270c06@mail.kernel.org>
References: <6ddac0398e54f73f0d424069145c6901d8d0ff3401fb160db0a9e3b281270c06@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Oct 07, 2026 at 06:45 PM +0000, bot+bpf-ci@kernel.org wrote:
>> +	/* A helper such as bpf_skb_change_tail() may have downgraded the skb
>> +	 * from CHECKSUM_COMPLETE. skb->csum is then unused by the stack and
>> +	 * there is nothing to validate.
>> +	 */
>
> This isn't a bug, but could the opening of this multi-line comment be put on
> its own line, with the text starting on the next line, as is preferred for
> BPF code?

Right, will put the opening /* on its own line in v2.
