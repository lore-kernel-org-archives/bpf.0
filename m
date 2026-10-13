Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE923FA5D0
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900351; cv=none; b=a+B6C9B/mWl+rMRrwRXQc/60YtvkEnnV/0tyAIA/OUmEpK/adF9W+4Z+kERwGG+FRe6k7SUV9ob9u7mzFIcg6elW9SepE8+gs4I4a07VUY9Mj2uDgmDAz9gCtvPXlzupHAHs+corMFvlMpKMdr/epImg0J47pPj7y/QzLx45oGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900351; c=relaxed/simple;
	bh=IhTLoHrlyl4CrIJgU6a7OH6/1uPW9hR0ITPDoRIiN50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTEShELMHtHtV8TQGcxt63jDkS43jxxbTH7DnupeYfisM1F1Eojayaj42nJbJWZiHpGHfei5NCtnADhc/byPfpaijiBt0LP2DfPD/EqA3NqHPVpqV01O0XCzZRzi3y9dbhJPvd2gXveptgiJhwA8/O+baLmHvXw9ys20rOF+SvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7qMdfqA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uukf24Os; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7qMdfqA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uukf24Os"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791900348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbSa4aMX4ZLanyQchu7pWrasbobdd8GQBaOw6y63Ae8=;
	b=T7qMdfqAE6hChzqqEQwBxKwOUJ/reglytd/s881vXRfLv2dBlj82DPFoz1QkeoDqFMEGX8
	Vez1M/ilgN5fojXajFrsLhCgsBOFMZZ9LPN82DUwxojyiaXXmYHBJbv4xH8OZSId2U7HkW
	Q5S/6fimjYRn0rEqMGHqcAMBJ8O9Q+4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-bt8IgS1wMfWxJHJ6Se4SCw-1; Tue, 13 Oct 2026 14:05:45 +0000
X-MC-Unique: bt8IgS1wMfWxJHJ6Se4SCw-1
X-Mimecast-MFC-AGG-ID: bt8IgS1wMfWxJHJ6Se4SCw_1791900344
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1ad49096fso6462375e9.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791900344; x=1792505144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbSa4aMX4ZLanyQchu7pWrasbobdd8GQBaOw6y63Ae8=;
        b=Uukf24Os2aSVACfZ8P/eWG5wGvTwe/X6PH1ykSx/BXZJ48JnXev9xhT0qhk4QWV9SD
         7VLo7lxtEYRdl3tjKycHEk3yAEgOW8ITHMgJOEsYbzr0YfbFpViQKPGbabhQP6NnVd0j
         sEwmE7VOtxEQv9TUav++8Tm96Xl6sOxJFMPPQqasvlooSB2YOp99cnvuNnsSL1sRt4LR
         NuZ8iWKYIGOkwKtMj4/OQsnLSdHM3zw8jHsF2/AfS/firOda/QYSDA4YhiIkoPnkznsB
         YRAqtXpbPa0WwjXVxtsQUATSRAvXU46GJkZ/Vq6v6XnfMEtzOzJLEG5TCE9EyIHoscyT
         EKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900344; x=1792505144;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbSa4aMX4ZLanyQchu7pWrasbobdd8GQBaOw6y63Ae8=;
        b=YIT4NY8/vnH9KLSJK62sJq7tFcb7Z45hpsl97OJU/TfIVh6SpzBnjzGA644iH1mkv9
         gabmffmpMKiXXtngEv5syQ7FW0/8RwVv+NJ8RGNVDReIlqsSW08pnfDulfR575VAliNB
         lftmJV9uuEwiyiU9xJUUhPqbmxH05wzlo1ckkfko8XNHcZmPaz/xw2XRNIdlw2DE0MbE
         uqw36B6FJWHenIpY5Ir43oi71eNM8NpvdITq0Wu4orkKonwm4FG5CqpDSxESp0+V6ULj
         MRkqsv5xo0qrPATImn9UinkWi5jM2KZMvvSWCdMyKOMXaQ86OUpPqRRnvLxPqrjyb308
         64Pg==
X-Gm-Message-State: AFq9FYKOdbVLGoWl8FtAAiCYHyMI979CHSdnxV3CEve5ZFY+cQrVzMuT
	jiDS8hZazlwlLf0poyytYn/nYr6Ey7SYBY3VoppGQtBbkxpks5tuxSPVaJseNJ41fyU/nJtkXSG
	3l+6eiJw4UiK+GyYs67r8JFEGbOFGtUcNMPiOChOuE72GTBCNo1DrZA==
X-Gm-Gg: AYBFou3W9b+fKe3EGbh3FGjniLyVZvK1vy/Ax9EA+CZr7J+D1uwLUKIssCGhQmXe0Vk
	XVlE6G8j5uuUP4zu4Jo0EXJp0NnyKZpYhjw3s/RSvot9OwvKxF1CZWvNVmLtF5Y8GucQYAg3Ysk
	OK80FB02NJaJ022uwxOrJEEh639aHHAJtJDvurRcjDLbeLrsrLPb04t8LPW/IljeftKjW9hnSq7
	4lxwh4nbmMh7iskJABeHteFCYn8m9wRNJt63q8kCu7/WdV+dU+U/0w3bwrldi/2upbdDOo8zBtr
	NOfUFyupCNA6zE/XZDmoAyLgdLnEF9TOHIMKq8SmqYzGLgn98o7XSduPtZq5wBFTXhF9X4YvGRt
	0KDchXDxLVC0JoNdXt3OhpQhZBcfwPAGB7csE8ivdw1ET9jA64X+Aoxc1joYL6WEA/n7eQTW4rA
	==
X-Received: by 2002:a05:600c:4e92:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a18e4837e7mr248254395e9.6.1791900343764;
        Tue, 13 Oct 2026 07:05:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4e92:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a18e4837e7mr248253445e9.6.1791900343076;
        Tue, 13 Oct 2026 07:05:43 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18dd15659sm242588985e9.4.2026.10.13.07.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:05:42 -0700 (PDT)
Message-ID: <38ae4fa2-29e5-49a7-8653-88f5a73593dd@redhat.com>
Date: Tue, 13 Oct 2026 16:05:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 net-next 2/2] octeontx2: add mqprio bandwidth offload
 for NIX TX schedulers
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev-bot+sashiko@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, sdf@fomichev.me,
 sgoutham@marvell.com
References: <20261006094357.840823-3-rkannoth@marvell.com>
 <179162647058.434549.12221340477037180415@kernel.org>
 <asxY6cs5os_q3mAA@rkannoth-OptiPlex-7090>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <asxY6cs5os_q3mAA@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/26 05:50, Ratheesh Kannoth wrote:
> On 2026-10-10 at 15:31:10, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
>> Thank you for your contribution! Sashiko AI review found 12 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 9 (1) · Low: 2 (1)
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] There is a use-after-free race on the deferred netdev_tc_work
>>    during device removal.
> 
> Not addressing this one; the window is theoretical and the impact is nil in practice.
The number of known valid issues that you intend not address is
concerning. Beyond the overall driver quality, please note that any
later patch touching this area will likely report the same issues,
require more effort from you to waive them and from us to actually
process the increasingly large wall of text.

I strongly suggest addressing at least the 'high' one and the others
with more straight-forward solutions.

/P

