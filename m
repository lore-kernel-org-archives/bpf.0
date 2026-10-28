Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205530;
	b=vl8cpioERLpLJmg8f/obQHNQGvPux/tyyePjozDOyY4PFSSyB/MgdmcRCKeJ702BL2mh
	 UvDYE9Jy4VX+DGQlwGQOPwJOVLXNeHcyFkq5uYV/VK9gILWcyFfy1xs3HK9aIUUs9YMnc
	 1UpBPwTUfAdoE0JTs9oV2rUIqY2s00VswHde3BlpzYI2b1FrrTwHapRfdZ7PiMB5zG24Z
	 uNgaUe/NtaTY74bUr74+fbwrxpmDe04+nzVWyKnzDEeDy6OHoS/DhpTem80q6Hh2TrX7s
	 zs04wzVfzJ+5CUfvxq4FHFJ6PNIcHUaD5SKTFl8k0mgYiSx7gXWzlscLkwXX3hVcI9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
	b=fa9rB4IZCnEr4Om1WViN6vvjmdiZxsRx/LgW+6bJZLP1lEwnkMxdd+1Mj/+tyKCHPHyu
	 60++L9XX+Dysybe8bPpP8e6Xest4fLFyVH6KNdlaX8V/WKlI6ApBBwqvFTn9YHMaqixEH
	 Fm4dBw+oFtwWHPuu5Tya5Y+h08EsXfG9FLq046iYuRprFEblENAGXqX+l59LufA/qsRad
	 by4ivwzpWsYRYeKyb8RGTZeNO3Yq/NCPkwK8cpQ69MAAsNsNPCz3OisNa9nhzK8X3eMwY
	 +yHtEmy0S9LDxtk1K/SoWP+WTxI+/3PnakgsDWTOCspvkMiepJ6uSPp4Og0mrOVTmZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPXilkf5;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261F606A320
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 16:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6261F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OPXilkf5
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e613f813b0so3174545ad.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793205530; x=1793810330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
        b=OPXilkf5W2mSrES/eYAou3I3925xBOmvAKuFXCfpSrnxPLnj4kUMLpI+jLbIXRhBp0
         Tt0n9dCUTuUw8+ZO0sS3kJucb4xltTp5nfTz+RJDWmJduzVdHYqQOd18bWatWyjnNovE
         YlZCPG3PGfuoMn/nqpAYtqGfP03M+3OSETEe8SNAH7VY91zPeU6BdgPCaw7u3EZmO7vY
         RUkAZYxo8g0xeRYpPdlRVmnVn5D7sjsWuZkGbk9BiCb0oSCZaraD8+H9mZKKzy9GcRFI
         A2ug5sAisBx6jr7IUqNsAwR0TnA6JRYhH+UizrU2Unehh9dbkTbDZdHmIia2jek02aWn
         t5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205530; x=1793810330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YYg+bgTYV9ji+xIuiu7GqnBDXQOUfklC31rXpMn4A4Y=;
        b=ykWvKcRPjQHgRIKaLz6Lht8dd7iDYe1bn1Ar2D7NNEctqj70XoQu9a5I4exGf4pqur
         1kcRj1eZQ0lkpfT0Szz5az2F2K6FWyMLzL7bknCOm7Yd1Ex9hcQx/vKsuxJ3L6MZQsBX
         Mnw6uy4majbS2zWX8Rmui9h2fak4UPW7UTwV0chYT/A7IYE4UDJ8xWlSGwDBf9++Plt4
         v8nOdzZ7CRmKmYSnpRhSS7lAd4n+fyIC2dQEnqDBLRzo0iEpgaSi0G/y6xNUlg30I6kw
         s7x4pw5af6Th2RnmuCVGqVQ0c6fjEfzpFnbFB+/3H6yCgnwUb5c5wiZRFTBLbzqwWkK2
         sNkA==
X-Forwarded-Encrypted: i=1; AKwUvBwCagh13ZYYaaUGHghx4urvFhSb4JBAHzuWVLW8u3tpGslaL74wCNX30qg5smlvof8see0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI18HOgBm4L48yuzigCHnbuvbgaauMwTn2ns3I8KHcsdmseR7Ul
	3LTOJ0a1xPl++ZDggJpWv6fqG8VX4oKjtOJXyiRCPOSbZfhEYMkC3HzC
X-Gm-Gg: AYBFou0KCjBkmvYhAE5nPtrMYyhwqEh1aD7cl/PC+hB9uokChkUz5utSEbQkAAZKrbU
	OD52tqc+vu7L0hB7g1/Oj47/uI0XlNPtpxtGQrc6DMJFcM/nRam7fJ7AEpIuY3H8Bz2pnuo2zWm
	YaboNSKrthbSMeNHqhGo7MtqI70re9l+4HviNDvbJbs+PDCZ0mQnO5ZGS07Ix0iRl2sCitCVuVV
	Jg3LGt4+acKZivgQ65AhPy3vZDQiwz/kuiDmj58gbVRV6yxqYmRLgkG2HqTAiHzIWosy2Og64ba
	FmI+DQqHTpRMuOgS7qCDYL8nitnreAbJMrbiHbvrei6JJBGiAjB+PldURxa5/hch7hD5IoEdyxR
	0z8KrvsiAKekpR0UC4dd4+vSOf1+sfZq0PbeYFGrSVB2j1Wf55VjBgPcfM/tg4t8trrfm/Kb3DJ
	dqyRwHl16Q0og6wLgbv85dkp2wJl3FypUOICJiM6vR0P93K5wqmi9Mi8M+Y8bTspsPrEOVQki2M
	R+JHRnG8/bVkC4EeFbhpKrIwsuC2pvXtNC1RvRxyGJ4u74azHB29GpR9yW1UwGR4n1OIJqO5FtU
	gt5VRJT01ACWmyclAt7EZ6iDhth/qojm41eOIDkv0iXwEp/1MNAO
X-Received: by 2002:a05:6a21:496:b0:3e1:9071:acb2 with SMTP id adf61e73a8af0-3e913a7ca80mr44385637.33.1793205529784;
        Wed, 28 Oct 2026 09:38:49 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:1490:f0fa:6df7:f234])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cc9b25a3sm4395321a12.2.2026.10.28.09.38.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 09:38:49 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Thu, 29 Oct 2026 00:38:39 +0800
Message-Id: <20261028163839.82573-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auH2iJ9oXEQRVG26@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-3-testwrzwrz@gmail.com> <auH2iJ9oXEQRVG26@boxer>
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

Following up: I extended the selftest to run every descriptor count from
1 through MAX_SKB_FRAGS + 1, not just 1, 2, and the maximum. This also
covers uneven fragment splits. All cases pass.

Thanks,
Rongzheng
