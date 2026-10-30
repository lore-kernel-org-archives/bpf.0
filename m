Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363084;
	b=1E8JHjKbkr+QaZsy0ejlOlENh6I7VTTZoY7OTFQdB78cYHRsOc2zutUjkqlc+4E+qgvx
	 pSaD7FhAzObkM2/3ugbY05AnZzsk1hOLdX6mZkFmkdgor/UMoG7FpzqgRUHKCZ8cb1DdP
	 YQlnazrEiWwdbSUQAU+n4HsAcXNQm5VAWl9sUMBEON4DaYUtdhT9UV8akQvRYDjkshYoB
	 kKPLdSP2LKPAhCPaORvXPGBkENVYwbOPTOrv0Qtt1bXnUng1qNOJda2ADOQYiHSnPIvwX
	 FomdFL3UaJMv9gBv1TXj5dgtuEoA56lcYmk65xUADCa+TgMuvsb2JHqoodJrYBk9X5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
	b=nRC1Vwo7jaXRQYj/lPNAQ9C7AjEId/R1lUgy+d+EdMkpnFkoeViV863VUtv5YRWV8qhP
	 wrTgy86/+O9OxYlNfukZ8MyDSIYxwjZqr9qWUOy+RcUeCK4V+vXlTgytn9PCunZrGlHug
	 TSTs8DDLHQMQtOItNmlhbhmJ8RjIVR/ovt6XoGEFZRpHXXr3hKS02NicfYgUZoklHte63
	 MSp+Wx9jaP6yKPzisGV2toGhcRv0E06GLrBdKko+JzibAekpRA85G5/hKBQ46VQpOVH/X
	 N3dagWxwK2GOZvgoW5Lgvk5jQPs5A/rS2VsBIX46DbuXUM4U24fsmiSfLg7YJiRdnaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDl7HVvK;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96262606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96262606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDl7HVvK
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so340822a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363083; x=1793967883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
        b=kDl7HVvKhavC8dBhxopELEbRq96LLaI6slGnuyyzzpW6HiVfGW+5iNPWoH9zW/heUE
         w8JVowdf9BDkIaRkb7XkvY6hKwgR0yzPfsDWcGZ/TEK3ir2aGz2DFMTmEl5ZhJjIRj65
         IaYA3vc9JbhxAqMO4AE7rw37++O1oUWN3Nmqcedd8UaAiPLTaFv3cdQA9uxOBqo02BDu
         ss3CrAEcE9GJBCtpgMGVvQtPYxRYHv/K46Bxi/obXBWgOIplzdfvA+5nCQS18C+R5zJo
         1LWEf+wYAQtEBy64hU04DLZ9zd58muabV/fqQF+M8lsvlA7BwXW74bgmo1u6xwlDDvrO
         Yo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363083; x=1793967883;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yrymDp79FZjbqEueI9kZqfriu2oDHzO0g8H9zdbK7E=;
        b=KvHtx1jNpGnLTtnFmbu4gko999uYGYyX8/pQJ+e2rLipMFuk+Sv/qrP0F3KWozRxUU
         balgV/xSPABPf0cBcti9f7bYdSZ7mlyFk0ZrIi+DSrtfybJwqK8GHW1h/EZuN2JMGc8B
         TOC4txodBnEFIphyb6RLoUYVX20fqi7qsNoXa90leW+jHAPrPqFJpbu9JQzTFx5dzwZR
         yzsFg2mNYh83zXad9EBTuAzo0MYRwV78FoWFWeoF0iWDNDBF5wDbfcxb+QxjfYfFJkgJ
         XcmXd/r0NquMvwUZSoWEx3S4D7bDA4T5Eybwp8I+psh3cR4FOIPt9MsNcC9UzfeClP/p
         EcnQ==
X-Forwarded-Encrypted: i=1; AKwUvByR4YO/uZxPbemJ9UpgC4OSaM9eEftlTfPgp/IOjxOtROLrxE4FI2PlT2xI586rDGir1AQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI40Dwrj+lxQl1ZCnhpcrMSP0iMaR2CgFNmHI6bBYIJLh3hNeNW
	NretdoMvr7YzjvAkQXEC0lmmBKpjvFBtpmvIaQkA/0QHsGuxvTPOEIjd
X-Gm-Gg: AYBFou2bBsbNDxg5UwKV03B0BqJGCtmp1koOgb/8cVRLn5MZFVrH+JsKkWBSAxv+t1R
	GVNVwHzWzRuLj3evebRFLSyn0n9QULyNPUfvSuflqdyGmp/9GXfLuKQOcpCHy87vp725jcMp5AY
	gVhYZPYmZ3JCO0LYKLJq7IjfJQDwN6EI4qYHsVWu8EFN1m/MThPLeCpwbLtXSXqxVyNi4ChuX0H
	QY/2DxxqSR2NTtua3cMqQfIu+4qitfolq4vpluC5VNCeBxPxzyAOUERbUv54x3F8rSHwb/SNzoF
	JFavRVtuTbTu0wQzGSHIM2zDzEi/JGlAu3I4Obfv3Qb2Db6mS+4gjqxhABk4w+bwDE6XThIsAzO
	J++VPsnOgZ1LW+HG6vNaaxSV7ZrsgP0qkdx0Fl5NhoYHDtB4h879VsTfvZq3igguPxg755NjlT+
	k/NzCVx3ouCvKLRRwmx7EVAUBuvYow5kM+dpLoRLv7r8rYX2jkmKXZVtJIAtw3vW3GaYqkQokXZ
	cajGwGY4CqZHgOO5i+fL9vjhONQd/AzPmc7Gg7coaygu59+HMzw2mmdzL5vsma5zeHmkynHqI6d
	7wwnm9axjhTOQSKpTOuGBb+2GgbsuatyQsAiHZq9wmkZ68jXDmz6/M37RQ==
X-Received: by 2002:a05:6a00:2d85:b0:873:f7a4:433f with SMTP id d2e1a72fcca58-8a9bea6ad35mr1985118b3a.26.1793363082777;
        Fri, 30 Oct 2026 05:24:42 -0700 (PDT)
Received: from 192.168.1.3 ([2409:8a1e:2331:2850:d40c:1fcf:6319:8524])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ef56b38dsm687929b3a.31.2026.10.30.05.24.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 05:24:42 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	netdev@vger.kernel.org,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 20:24:34 +0800
Message-Id: <20261030122434.91530-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auSF/bDmOW0Y7T4D@boxer>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com> <20261030094633.27910-1-testwrzwrz@gmail.com> <auSF/bDmOW0Y7T4D@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review, the suggestions, and the Reviewed-by on 2/2.

> Can you stop removing all the previous conversations and rather reply
> inline to related paragraphs?

Sorry, I'll reply inline from now on.

> I don't think v5 is necessary. And as Jason said you received 3 review/ack
> tags and none of them got included in v4.

You're right. v4 went out before Jason's tag arrived, and I missed the
other two tags from v3. Since you don't think v5 is necessary, I won't
send one; if there is another revision, I'll carry all the tags.

I learned a lot from this patch and from the review feedback. I'll be more
careful with future patches and wait longer for reviewers' feedback before
sending the next version.
